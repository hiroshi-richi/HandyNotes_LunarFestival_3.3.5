
local _, LunarFestival = ...
local points = LunarFestival.points
-- points[<mapfile>] = { [<coordinates>] = { <quest ID>, <achievement ID>, <achievement criteria ID> } }


points["BlackrockDepths"] = {
	[50536287] = { 8619, 910, 5 }, -- Elder Morndeep
}

points["BlackrockSpire"] = {
	[61814000] = { 8644, 910, 4 }, -- Elder Stonefort
}

points["BlastedLands"] = {
	[58005100] = { 8647, 912, 2 }, -- Elder Bellowrage
}

points["BurningSteppes"] = {
	[82004700] = { 8636, 912, 9 }, -- Elder Rumblerock
	[64002300] = { 8683, 912, 10 }, -- Elder Dawnstrider
}

points["DunMorogh"] = {
	[46005100] = { 8653, 912, 1 }, -- Elder Goldwell
}

points["EasternPlaguelands"] = {
	[35606880] = { 8688, 912, 15 }, -- Elder Windrun
	[75605460] = { 8650, 912, 16 }, -- Elder Snowcrown
}

points["Elwynn"] = {
	[40006400] = { 8649, 912, 3 }, -- Elder Stormbrow
}

points["Hinterlands"] = {
	[50004800] = { 8643, 912, 11 }, -- Elder Highpeak
}

points["Ironforge"] = {
	[29001600] = { 8866, 915, 2 }, -- Elder Bronzebeard
}

points["LochModan"] = {
	[33004600] = { 8642, 912, 7 }, -- Elder Silvervein
}

points["SearingGorge"] = {
	[21007900] = { 8651, 912, 12 }, -- Elder Ironband
}

points["Silverpine"] = {
	[45004100] = { 8645, 912, 14 }, -- Elder Obsidian
}

points["Stranglethorn"] = {
	[53201860] = { 8716, 912, 5 }, -- Elder Starglade
	[26607660] = { 8674, 912, 6 }, -- Elder Winterhoof
}

points["Stratholme"] = {
	[78622215] = { 8727, 910, 6 }, -- Elder Farwhisper
}

points["TheTempleOfAtalHakkar"] = {
	[62913448] = { 8713, 910, 2 }, -- Elder Starsong
}

points["Tirisfal"] = {
	[62005400] = { 8652, 912, 13 }, -- Elder Graveborn
}

points["Undercity"] = {
	[67003800] = { 8648, 914, 3 }, -- Elder Darkcore
}

points["WesternPlaguelands"] = {
	[65004700] = { 8722, 912, 4 }, -- Elder Meadowrun
	[69007300] = { 8714, 912, 17 }, -- Elder Moonstrike
}

points["Westfall"] = {
	[56004700] = { 8675, 912, 8 }, -- Elder Skychaser
}

points["Stormwind"] = {
	[36606620] = { 8646, 915, 3 }, -- Elder Hammershout
}


points["Ashenvale"] = {
	[36004900] = { 8725, 911, 9 }, -- Elder Riversong
}

points["Azshara"] = {
	[72008500] = { 8720, 911, 2 }, -- Elder Skygleam
}
-- Some 3.3.5-era data uses the misspelled map file "Aszhara".
-- Duplicate the points to ensure the node shows on those clients.
points["Aszhara"] = points["Azshara"]

points["Barrens"] = {
	[51003000] = { 8717, 911, 3 }, -- Elder Moonwarden
	[45005700] = { 8686, 911, 4 }, -- Elder Highmountain
	[62003600] = { 8680, 911, 5 }, -- Elder Windtotem
}

points["Darkshore"] = {
	[36004600] = { 8721, 911, 7 }, -- Elder Starweave
}

points["Darnassus"] = {
	[33601460] = { 8718, 915, 1 }, -- Elder Bladeswift
}
-- Some 3.3.5 clients use alternate map file names for city maps.
-- Duplicate the points to ensure nodes show on those clients.
points["Darnassis"] = points["Darnassus"]

points["Durotar"] = {
	[53004400] = { 8670, 911, 1 }, -- Elder Runetotem
}

points["Feralas"] = {
	[77003800] = { 8679, 911, 10 }, -- Elder Grimtotem
	[62003100] = { 8685, 911, 11 }, -- Elder Mistwalker
}

points["Felwood"] = {
	[38005300] = { 8723, 911, 12 }, -- Elder Nightwind
}

points["Maraudon"] = {
	[51479373] = { 8635, 910, 3 }, -- Elder Splitrock
}

points["Mulgore"] = {
	[48005300] = { 8673, 911, 8 }, -- Elder Bloodhoof
}

points["Orgrimmar"] = {
	[41003300] = { 8677, 914, 1 }, -- Elder Darkhorn
}
-- Some 3.3.5 clients use alternate map file names for city maps.
-- Duplicate the points to ensure nodes show on those clients.
points["Ogrimmar"] = points["Orgrimmar"]

points["Silithus"] = {
	[23001100] = { 8654, 911, 20 }, -- Elder Primestone
	[49003800] = { 8719, 911, 21 }, -- Elder Bladesing
}

points["Tanaris"] = {
	[37007900] = { 8671, 911, 15 }, -- Elder Ragetotem
	[51002800] = { 8684, 911, 16 }, -- Elder Dreamseer
}

points["Teldrassil"] = {
	[57006000] = { 8715, 911, 6 }, -- Elder Bladeleaf
}

points["ThousandNeedles"] = {
	[45005000] = { 8682, 911, 13 }, -- Elder Skyseer
	[79007700] = { 8724, 911, 14 }, -- Elder Morningdew
}

points["ThunderBluff"] = {
	[73002300] = { 8678, 914, 2 }, -- Elder Wheathoof
}

points["UngoroCrater"] = {
	[50007600] = { 8681, 911, 17 }, -- Elder Thunderhorn
}

points["Winterspring"] = {
	[55004300] = { 8726, 911, 18 }, -- Elder Brightspear
	[61003700] = { 8672, 911, 19 }, -- Elder Stonespire
}

points["ZulFarrak"] = {
	[34503934] = { 8676, 910, 1 }, -- Elder Wildmane
}


-------------
-- Outland --
-------------


points["AzjolNerub"] = {
	[21774356] = { 13022, 910, 9 }, -- Elder Nurgen
}

points["BoreanTundra"] = {
	[59106560] = { 13012, 1396, 1 }, -- Elder Sardis
	[57304370] = { 13033, 1396, 5 }, -- Elder Arp
	[33803440] = { 13016, 1396, 6 }, -- Elder Northal
	[42904960] = { 13029, 1396, 15 }, -- Elder Pamuya
}

points["Dragonblight"] = {
	[29705590] = { 13014, 1396, 3 }, -- Elder Morthie
	[48807820] = { 13019, 1396, 12 }, -- Elder Thoim
	[35104830] = { 13031, 1396, 17 }, -- Elder Skywarden
}

points["DrakTharonKeep"] = {
	[68887912] = { 13023, 910, 10 }, -- Elder Kilias
}

points["GrizzlyHills"] = {
	[60602770] = { 13013, 1396, 2 }, -- Elder Beldak
	[80503710] = { 13025, 1396, 9 }, -- Elder Lunaro
	[64204700] = { 13030, 1396, 16 }, -- Elder Whurain
}

points["Gundrak"] = {
	[45676153] = { 13065, 910, 11 }, -- Elder Ohanzee
}

points["LakeWintergrasp"] = {
	[49001390] = { 13026, 1396, 10 }, -- Elder Bluewolf
}

points["SholazarBasin"] = {
	[49806300] = { 13018, 1396, 7 }, -- Elder Sandrene
	[63804900] = { 13024, 1396, 8 }, -- Elder Wanikaya
}

points["TheNexus"] = {
	[55206471] = { 13021, 910, 8 }, -- Elder Igasho
}

points["TheStormPeaks"] = {
	[28907370] = { 13015, 1396, 4 }, -- Elder Fargal
	[41208470] = { 13028, 1396, 13 }, -- Elder Graymane
	[31303760] = { 13020, 1396, 14 }, -- Elder Stonebeard
	[64605130] = { 13032, 1396, 18 }, -- Elder Muraco
}

points["Ulduar77"] = { -- Halls of Stone
	[29376205] = { 13066, 910, 12 }, -- Elder Yurauk
}

points["UtgardeKeep"] = {
	[47426963] = { 13017, 910, 7 }, -- Elder Jarten
}

points["UtgardePinnacle"] = {
	[48772298] = { 13067, 910, 13 }, -- Elder Chogan'gada
}

points["ZulDrak"] = {
	[58905600] = { 13027, 1396, 11 }, -- Elder Tauros
}
