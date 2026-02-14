
-- declaration
local _, LunarFestival = ...
LunarFestival.points = {}


-- our db and defaults
local db
local defaults = { profile = { completed = false, icon_scale = 1.4, icon_alpha = 0.8 } }


-- upvalues
local _G = getfenv(0)

local CalendarGetDate = _G.CalendarGetDate
local CloseDropDownMenus = _G.CloseDropDownMenus
local GameTooltip = _G.GameTooltip
local GetAchievementCriteriaInfo = _G.GetAchievementCriteriaInfo
local gsub = _G.string.gsub
local IsQuestFlaggedCompleted = _G.IsQuestFlaggedCompleted
local LibStub = _G.LibStub
local floor = _G.math.floor
local next = _G.next
local pairs = _G.pairs
local tinsert = _G.table.insert
local ToggleDropDownMenu = _G.ToggleDropDownMenu
local UIDropDownMenu_AddButton = _G.UIDropDownMenu_AddButton
local UIParent = _G.UIParent
local WorldMapButton = _G.WorldMapButton
local WorldMapTooltip = _G.WorldMapTooltip
local DongleStub = _G.DongleStub

local Cartographer_Waypoints = _G.Cartographer_Waypoints
local HandyNotes = _G.HandyNotes
local NotePoint = _G.NotePoint
local TomTom = _G.TomTom
local Astrolabe = DongleStub and DongleStub("Astrolabe-0.4")
local DEFAULT_CHAT_FRAME = _G.DEFAULT_CHAT_FRAME

if not CalendarGetDate then
	CalendarGetDate = function()
		local t = date("*t")
		return t.wday, t.month, t.day, t.year
	end
end

if not IsQuestFlaggedCompleted then
	IsQuestFlaggedCompleted = function()
		return false
	end
end

local points = LunarFestival.points

local function getPointsForMap(mapFile)
	return points[mapFile]
end

local AzerothZoneList
if Astrolabe and Astrolabe.ContinentList then
	AzerothZoneList = {}
	do
		local t = Astrolabe.ContinentList
		for i = 1, #t[1] do
			tinsert(AzerothZoneList, t[1][i])
		end
		for i = 1, #t[2] do
			tinsert(AzerothZoneList, t[2][i])
		end
		for i = 1, #t[4] do
			tinsert(AzerothZoneList, t[4][i])
		end
	end
end

local function encodeCoord(x, y)
	return floor(x * 10000 + 0.5) * 10000 + floor(y * 10000 + 0.5)
end

local function rebuildContinentPoints(continentMapFile, zoneList)
	if not (Astrolabe and HandyNotes and zoneList) then
		return
	end

	local C, Z = HandyNotes:GetCZ(continentMapFile)
	if not (C and Z) then
		return
	end

	local contPoints = {}
	for i = 1, #zoneList do
		local mapFile = zoneList[i]
		local data = getPointsForMap(mapFile)
		if data then
			for coord, value in pairs(data) do
				local x, y = HandyNotes:getXY(coord)
				local c1, z1 = HandyNotes:GetCZ(mapFile)
				if c1 and z1 then
					local cx, cy = Astrolabe:TranslateWorldMapPosition(c1, z1, x, y, C, Z)
					if cx and cy and cx > 0 and cx < 1 and cy > 0 and cy < 1 then
						contPoints[encodeCoord(cx, cy)] = value
					end
				end
			end
		end
	end

	points[continentMapFile] = contPoints
end

-- plugin handler for HandyNotes
local function infoFromCoord(mapFile, coord)
	mapFile = gsub(mapFile, "_terrain%d+$", "")

	local data = getPointsForMap(mapFile)
	local point = data and data[coord]

	if point then
		return GetAchievementCriteriaInfo(point[2], point[3])
	end
end

function LunarFestival:OnEnter(mapFile, coord)
	local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip

	if self:GetCenter() > UIParent:GetCenter() then -- compare X coordinate
		tooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		tooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local nameOfElder = infoFromCoord(mapFile, coord)

	tooltip:SetText(nameOfElder)
	tooltip:Show()
end

function LunarFestival:OnLeave()
	if self:GetParent() == WorldMapButton then
		WorldMapTooltip:Hide()
	else
		GameTooltip:Hide()
	end
end

local function createWaypoint(button, mapFile, coord)
	local c, z = HandyNotes:GetCZ(mapFile)
	local x, y = HandyNotes:getXY(coord)

	local nameOfElder = infoFromCoord(mapFile, coord)

	if TomTom then
		TomTom:AddZWaypoint(c, z, x * 100, y * 100, nameOfElder)
	elseif Cartographer_Waypoints then
		Cartographer_Waypoints:AddWaypoint( NotePoint:new(HandyNotes:GetCZToZone(c, z), x, y, nameOfElder) )
	end
end

do
	-- context menu generator
	local info = {}
	local currentZone, currentCoord, nameOfElder

	local function close()
		-- we need to do this to avoid "for initial value must be a number" errors
		CloseDropDownMenus()
	end

	local function generateMenu(button, level)
		if not level then return end

		for k in pairs(info) do info[k] = nil end

		if level == 1 then
			-- create the title of the menu
			info.isTitle = 1
			info.text = nameOfElder
			info.notCheckable = 1

			UIDropDownMenu_AddButton(info, level)

			if TomTom or Cartographer_Waypoints then
				-- waypoint menu item
				info.notCheckable = nil
				info.disabled = nil
				info.isTitle = nil
				info.icon = nil
				info.text = "Create waypoint"
				info.func = createWaypoint
				info.arg1 = currentZone
				info.arg2 = currentCoord

				UIDropDownMenu_AddButton(info, level)
			end

			-- close menu item
			info.text = "Close"
			info.func = close
			info.arg1 = nil
			info.arg2 = nil
			info.icon = nil
			info.isTitle = nil
			info.disabled = nil
			info.notCheckable = 1

			UIDropDownMenu_AddButton(info, level)
		end
	end

	local dropdown = CreateFrame("Frame", "HandyNotes_LunarFestivalDropdownMenu")
	dropdown.displayMode = "MENU"
	dropdown.initialize = generateMenu

	function LunarFestival:OnClick(button, down, mapFile, coord)
		if button == "RightButton" and not down then
			currentZone = mapFile
			currentCoord = coord

			nameOfElder = infoFromCoord(mapFile, coord)

			ToggleDropDownMenu(1, nil, dropdown, self, 0, 0)
		end
	end
end

do
	local emptyTbl = {}
	local tablepool = setmetatable({}, {__mode = "k"})
	-- custom iterator we use to iterate over every node in a given zone
	local function iter(t, prestate)
		if not t then return nil end

		local state, value = next(t, prestate)

		while state do -- have we reached the end of this zone?
			if value and (db.completed or not IsQuestFlaggedCompleted(value[1])) then
				return state, nil, "interface\\icons\\inv_misc_elvencoins", db.icon_scale, db.icon_alpha
			end

			state, value = next(t, state) -- get next data
		end

		return nil, nil, nil, nil
	end

	-- custom iterator for continent maps
	local function iterCont(t, prestate)
		if not t then return nil end
		local C, Z = t.mapC, t.mapZ
		local zone = t.Z
		local mapFile = t.C[zone]
		local data = getPointsForMap(mapFile)
		local state, value
		while mapFile do
			if data then
				state, value = next(data, prestate)
				while state do
					if value and (db.completed or not IsQuestFlaggedCompleted(value[1])) then
						local x, y = HandyNotes:getXY(state)
						local c1, z1 = HandyNotes:GetCZ(mapFile)
						x, y = Astrolabe:TranslateWorldMapPosition(c1, z1, x, y, C, Z)
						if x > 0 and x < 1 and y > 0 and y < 1 then
							return state, mapFile, "interface\\icons\\inv_misc_elvencoins", db.icon_scale, db.icon_alpha
						end
					end
					state, value = next(data, state)
				end
			end
			t.Z = t.Z + 1
			zone = zone + 1
			mapFile = t.C[zone]
			data = getPointsForMap(mapFile)
			prestate = nil
		end
		tablepool[t] = true
	end

	function LunarFestival:GetNodes(mapFile, isMinimapUpdate, dungeonLevel)
		mapFile = gsub(mapFile, "_terrain%d+$", "")
		if isMinimapUpdate or not Astrolabe or not AzerothZoneList then
			return iter, getPointsForMap(mapFile), nil
		end

		local C, Z = HandyNotes:GetCZ(mapFile)
		if C and Z and C >= 0 then
			if Z > 0 or (Z == 0 and mapFile ~= "World") then
				local tbl = next(tablepool) or {}
				tablepool[tbl] = nil
				tbl.C = C == 0 and AzerothZoneList or Astrolabe.ContinentList[C]
				tbl.Z = 1
				tbl.mapC = C
				tbl.mapZ = Z
				return iterCont, tbl, nil
			end
		end
		return next, emptyTbl, nil
	end
end


-- config
local options = {
	type = "group",
	name = "Lunar Festival",
	desc = "Lunar Festival elder NPC locations.",
	get = function(info) return db[info[#info]] end,
	set = function(info, v)
		db[info[#info]] = v
		LunarFestival:Refresh()
	end,
	args = {
		desc = {
			name = "These settings control the look and feel of the icon.",
			type = "description",
			order = 1,
		},
		completed = {
			name = "Show completed",
			desc = "Show icons for elder NPCs you have already visited.",
			type = "toggle",
			width = "full",
			arg = "completed",
			order = 2,
		},
		icon_scale = {
			type = "range",
			name = "Icon Scale",
			desc = "Change the size of the icons.",
			min = 0.25, max = 2, step = 0.01,
			arg = "icon_scale",
			order = 3,
		},
		icon_alpha = {
			type = "range",
			name = "Icon Alpha",
			desc = "Change the transparency of the icons.",
			min = 0, max = 1, step = 0.01,
			arg = "icon_alpha",
			order = 4,
		},
	},
}


-- initialise
function LunarFestival:OnEnable()
	HandyNotes:RegisterPluginDB("LunarFestival", self, options)
	self:RegisterEvent("QUEST_FINISHED", "Refresh")

	db = LibStub("AceDB-3.0"):New("HandyNotes_LunarFestivalDB", defaults, "Default").profile

	if Astrolabe and AzerothZoneList then
		rebuildContinentPoints("Azeroth", AzerothZoneList)
	end

	if Astrolabe and Astrolabe.ContinentList then
		local kalimdorC = HandyNotes:GetCZ("Kalimdor")
		local easternC = HandyNotes:GetCZ("EasternKingdoms")
		local northrendC = HandyNotes:GetCZ("Northrend")

		if kalimdorC then
			rebuildContinentPoints("Kalimdor", Astrolabe.ContinentList[kalimdorC])
		end
		if easternC then
			rebuildContinentPoints("EasternKingdoms", Astrolabe.ContinentList[easternC])
		end
		if northrendC then
			rebuildContinentPoints("Northrend", Astrolabe.ContinentList[northrendC])
		end
	end
end

function LunarFestival:Refresh()
	self:SendMessage("HandyNotes_NotifyUpdate", "LunarFestival")
end


-- activate
LibStub("AceAddon-3.0"):NewAddon(LunarFestival, "HandyNotes_LunarFestival", "AceEvent-3.0")
