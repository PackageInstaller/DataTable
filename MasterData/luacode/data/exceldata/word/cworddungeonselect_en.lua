-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/word/cworddungeonselect_en.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cworddungeonselect_en = {}
cworddungeonselect_en.Data = {
[1900001] = {id = 1900001, text = "Chrono Tower Floor 2"}
, 
[1900002] = {id = 1900002, text = "Chrono Tower Floor 5"}
, 
[1900003] = {id = 1900003, text = "Chrono Tower Floor 7"}
, 
[1900004] = {id = 1900004, text = "Hall of Irminsul"}
, 
[1900005] = {id = 1900005, text = "Forest Entrance"}
, 
[1900006] = {id = 1900006, text = "Western Forest"}
, 
[1900007] = {id = 1900007, text = "Clearings in the Woods"}
, 
[1900008] = {id = 1900008, text = "Commercial Area Entry"}
, 
[1900009] = {id = 1900009, text = "Commercial Area"}
, 
[1900010] = {id = 1900010, text = "Southern Commercial Area"}
, 
[1900011] = {id = 1900011, text = "Sentry Camp"}
, 
[1900012] = {id = 1900012, text = "Bog"}
, 
[1900013] = {id = 1900013, text = "Barracks: Periphery"}
, 
[1900014] = {id = 1900014, text = "Sacrificial Altar: Periphery"}
, 
[1900015] = {id = 1900015, text = "Irene Island"}
, 
[1900016] = {id = 1900016, text = "Giant Tree: Periphery"}
, 
[1900017] = {id = 1900017, text = "Giant Tree"}
, 
[1900018] = {id = 1900018, text = "Chrono Tower Floor 11"}
, 
[1900019] = {id = 1900019, text = "Chrono Tower Floor 13"}
, 
[1900020] = {id = 1900020, text = "Chrono Tower Floor 15"}
, 
[1900021] = {id = 1900021, text = "Chrono Tower Floor 17"}
, 
[1900022] = {id = 1900022, text = "Chrono Tower Floor 19"}
, 
[1900023] = {id = 1900023, text = "Hall of Snegurochka"}
, 
[1900024] = {id = 1900024, text = "Foothills"}
, 
[1900025] = {id = 1900025, text = "Outskirts Tundra: South"}
, 
[1900026] = {id = 1900026, text = "Outskirts Tundra: East"}
, 
[1900027] = {id = 1900027, text = "Foothills Hunting Grounds: South"}
, 
[1900028] = {id = 1900028, text = "Foothills Hunting Grounds: North"}
, 
[1900029] = {id = 1900029, text = "Frozen Lake Hunting Grounds: Front"}
, 
[1900030] = {id = 1900030, text = "Frozen Lake Hunting Grounds: End"}
, 
[1900031] = {id = 1900031, text = "Hillside Tundra"}
, 
[1900032] = {id = 1900032, text = "Hillside Fork Road"}
, 
[1900033] = {id = 1900033, text = "Cave Mouth"}
, 
[1900034] = {id = 1900034, text = "Frozen Road"}
, 
[1900035] = {id = 1900035, text = "Chivalric Order Camp"}
, 
[1900036] = {id = 1900036, text = "Pass of Talus"}
, 
[1900037] = {id = 1900037, text = "Frozen Lake Surface"}
, 
[1900038] = {id = 1900038, text = "Mountain Top Tundra"}
, 
[1900039] = {id = 1900039, text = "Entry Trail"}
, 
[1900040] = {id = 1900040, text = "Castle: Middle"}
, 
[1900041] = {id = 1900041, text = "Saintess Square"}
, 
[1900042] = {id = 1900042, text = "Chrono Tower Floor 21"}
, 
[1900043] = {id = 1900043, text = "Chrono Tower Floor 23"}
, 
[1900044] = {id = 1900044, text = "Chrono Tower Floor 25"}
, 
[1900045] = {id = 1900045, text = "Chrono Tower Floor 27"}
, 
[1900046] = {id = 1900046, text = "Chrono Tower Floor 29"}
, 
[1900047] = {id = 1900047, text = "Hall of Reversal"}
, 
[1900048] = {id = 1900048, text = "Foothills"}
, 
[1900049] = {id = 1900049, text = "Foothills Boundary"}
, 
[1900050] = {id = 1900050, text = "Outskirts Tundra: East"}
, 
[1900051] = {id = 1900051, text = "Foothills Hunting Grounds: Front"}
, 
[1900052] = {id = 1900052, text = "Hunting Grounds Boundary: Front"}
, 
[1900053] = {id = 1900053, text = "Frozen Lake Hunting Grounds: Front"}
, 
[1900054] = {id = 1900054, text = "Hillside Trail"}
, 
[1900055] = {id = 1900055, text = "Hillside Boundary: Front"}
, 
[1900056] = {id = 1900056, text = "Trail Outside the Boundary"}
, 
[1900057] = {id = 1900057, text = "Frozen Road"}
, 
[1900058] = {id = 1900058, text = "Chivalric Order Camp"}
, 
[1900059] = {id = 1900059, text = "Frozen Lake Surface"}
, 
[1900060] = {id = 1900060, text = "Castle Entry"}
, 
[1900061] = {id = 1900061, text = "Castle: Front"}
, 
[1900062] = {id = 1900062, text = "Underground Cave 1"}
, 
[1900063] = {id = 1900063, text = "Underground Cave 3"}
, 
[1900064] = {id = 1900064, text = "Underground Cave 5"}
, 
[1900065] = {id = 1900065, text = "Underground Square"}
, 
[1900066] = {id = 1900066, text = "Castle Entry"}
, 
[1900067] = {id = 1900067, text = "Underground Square"}
, 
[1900068] = {id = 1900068, text = "Inside the tower hides unknown secrets. The witch decides to go check it out."}
, 
[1900069] = {id = 1900069, text = "Dangerous aura emanates from the depths of the darkness..."}
, 
[1900070] = {id = 1900070, text = "Soon to collect all shards of the mirror, and unravel the mystery."}
, 
[1900071] = {id = 1900071, text = "A mysteries Hall, seemingly leading to unknown worlds."}
, 
[1900072] = {id = 1900072, text = "Entrance to the forest."}
, 
[1900073] = {id = 1900073, text = "The western part of the forest where the trees are madly overgrown."}
, 
[1900074] = {id = 1900074, text = "Central glade of the forest."}
, 
[1900075] = {id = 1900075, text = "Entrance to the Commercial Area which used to be bustling."}
, 
[1900076] = {id = 1900076, text = "Heart of the Commercial Area."}
, 
[1900077] = {id = 1900077, text = "The southern part of the Commercial Area."}
, 
[1900078] = {id = 1900078, text = "The inner area of the Sentry Camp."}
, 
[1900079] = {id = 1900079, text = "A densely forested area encircled by swamps."}
, 
[1900080] = {id = 1900080, text = "A place where the household guards once trained."}
, 
[1900081] = {id = 1900081, text = "The ruins there still show the glory of the old days."}
, 
[1900082] = {id = 1900082, text = "A small island bounded by water on three sides, at the end of the horizon."}
, 
[1900083] = {id = 1900083, text = "Entrance to the vast ruins."}
, 
[1900084] = {id = 1900084, text = "The Protector\'s royal seat rests at the roots of the giant tree."}
, 
[1900085] = {id = 1900085, text = "Chrono Tower Floor 11"}
, 
[1900086] = {id = 1900086, text = "Chrono Tower Floor 13"}
, 
[1900087] = {id = 1900087, text = "Chrono Tower Floor 15"}
, 
[1900088] = {id = 1900088, text = "Chrono Tower Floor 17"}
, 
[1900089] = {id = 1900089, text = "Chrono Tower Floor 19"}
, 
[1900090] = {id = 1900090, text = "A mysteries Hall, seemingly leading to unknown worlds."}
, 
[1900091] = {id = 1900091, text = "The foothills of Snegurochka."}
, 
[1900092] = {id = 1900092, text = "The southern area of Outskirts Tundra."}
, 
[1900093] = {id = 1900093, text = "The eastern area of Outskirts Tundra."}
, 
[1900094] = {id = 1900094, text = "The southern area of Foothills Hunting Grounds."}
, 
[1900095] = {id = 1900095, text = "The northern area of Foothills Hunting Grounds."}
, 
[1900096] = {id = 1900096, text = "The outer region of Frozen Lake Hunting Grounds."}
, 
[1900097] = {id = 1900097, text = "The core region of Frozen Lake Hunting Grounds."}
, 
[1900098] = {id = 1900098, text = "Snow-covered tundra on the hillside."}
, 
[1900099] = {id = 1900099, text = "A fork in the hillside."}
, 
[1900100] = {id = 1900100, text = "A cave on the hillside that can provide shelter from the wind and snow."}
, 
[1900101] = {id = 1900101, text = "A path completely covered by snow and ice."}
, 
[1900102] = {id = 1900102, text = "Campsite of the Frost Chivalric Order."}
, 
[1900103] = {id = 1900103, text = "A trail between the steep cliffs."}
, 
[1900104] = {id = 1900104, text = "A frozen solid lake. There\'s no danger in traversing it."}
, 
[1900105] = {id = 1900105, text = "The plain at the top of the mountain. The snow cover is deep here."}
, 
[1900106] = {id = 1900106, text = "The front path of Glacial Castle."}
, 
[1900107] = {id = 1900107, text = "The central section of Glacial Castle."}
, 
[1900108] = {id = 1900108, text = "The site where the Protector stays. A magic circle lies at the center."}
, 
[1900109] = {id = 1900109, text = "Chrono Tower Floor 21"}
, 
[1900110] = {id = 1900110, text = "Chrono Tower Floor 23"}
, 
[1900111] = {id = 1900111, text = "Chrono Tower Floor 25"}
, 
[1900112] = {id = 1900112, text = "Chrono Tower Floor 27"}
, 
[1900113] = {id = 1900113, text = "Chrono Tower Floor 29"}
, 
[1900114] = {id = 1900114, text = "A mysteries Hall, seemingly leading to unknown worlds."}
, 
[1900115] = {id = 1900115, text = "The foothills of Snegurochka."}
, 
[1900116] = {id = 1900116, text = "The southern area of Outskirts Tundra."}
, 
[1900117] = {id = 1900117, text = "The eastern area of Outskirts Tundra."}
, 
[1900118] = {id = 1900118, text = "The periphery of Foothills Hunting Grounds."}
, 
[1900119] = {id = 1900119, text = "The periphery of Foothills Hunting Grounds."}
, 
[1900120] = {id = 1900120, text = "The periphery of Frozen Lake Hunting Grounds."}
, 
[1900121] = {id = 1900121, text = "The trail leading to Hillside Tundra."}
, 
[1900122] = {id = 1900122, text = "The periphery of Hillside Boundary."}
, 
[1900123] = {id = 1900123, text = "A small trail outside the Hillside Boundary."}
, 
[1900124] = {id = 1900124, text = "A path completely covered by snow and ice."}
, 
[1900125] = {id = 1900125, text = "Campsite of the Frost Chivalric Order."}
, 
[1900126] = {id = 1900126, text = "A frozen solid lake. There\'s no danger in traversing it."}
, 
[1900127] = {id = 1900127, text = "The entrance to Glacial Castle."}
, 
[1900128] = {id = 1900128, text = "The front part of Glacial Castle."}
, 
[1900129] = {id = 1900129, text = "The periphery of Underground Cave."}
, 
[1900130] = {id = 1900130, text = "The central part of Underground Cave."}
, 
[1900131] = {id = 1900131, text = "The inner part of Underground Cave."}
, 
[1900132] = {id = 1900132, text = "The arena of the Protector, encircled by lava."}
, 
[1900133] = {id = 1900133, text = "The entrance to Glacial Castle."}
, 
[1900134] = {id = 1900134, text = "The arena of the Protector, encircled by lava."}
, 
[1900135] = {id = 1900135, text = "Deathscythe"}
, 
[1900136] = {id = 1900136, text = "Dimension Overseer"}
, 
[1900137] = {id = 1900137, text = "Flare the Priest"}
, 
[1900138] = {id = 1900138, text = "Asherah the Protector"}
, 
[1900139] = {id = 1900139, text = "Elementalist Anemone"}
, 
[1900140] = {id = 1900140, text = "Hervoraltar the White Bear"}
, 
[1900141] = {id = 1900141, text = "Captain of the Chivalric Order"}
, 
[1900142] = {id = 1900142, text = "Cersivey the Protector"}
, 
[1900148] = {id = 1900148, text = "Roadside Old Woman"}
, 
[1900149] = {id = 1900149, text = "Secret Cave"}
, 
[1900150] = {id = 1900150, text = "Snowy Plain Wolf Pack"}
, 
[1900151] = {id = 1900151, text = "The Locked Door"}
, 
[1900152] = {id = 1900152, text = "Snow Shack"}
, 
[1900153] = {id = 1900153, text = "Mysterious Ritual"}
, 
[1900154] = {id = 1900154, text = "An aged lady on the side of the road called out to you, \"This is the apple of blessing. Please take it.\""}
, 
[1900155] = {id = 1900155, text = "Deep in the forest you found a hidden cave. Intuition told you that there seemed to be some hidden secrets in it."}
, 
[1900156] = {id = 1900156, text = "Wolves\' howl can be heard from across the snowy plains in the distance, and it was getting closer..."}
, 
[1900157] = {id = 1900157, text = "While exploring, you found a locked door that emanates a mysterious, unknown aura."}
, 
[1900158] = {id = 1900158, text = "In a fierce snowstorm, you looked around to find a place to take shelter. At that moment you found an old, rundown cabin in the distance."}
, 
[1900159] = {id = 1900159, text = "Inside the room, a group of people were performing a mysterious ritual. A twinge of unease passed through your mind..."}
, 
[1900160] = {id = 1900160, text = "Accept the apple"}
, 
[1900161] = {id = 1900161, text = "Explore the cave"}
, 
[1900162] = {id = 1900162, text = "Ignore it"}
, 
[1900163] = {id = 1900163, text = "Find the switch"}
, 
[1900164] = {id = 1900164, text = "Enter the Hut"}
, 
[1900165] = {id = 1900165, text = "Stop them"}
, 
[1900166] = {id = 1900166, text = "Decline with thanks"}
, 
[1900167] = {id = 1900167, text = "Leave"}
, 
[1900168] = {id = 1900168, text = "Conceal your breath"}
, 
[1900169] = {id = 1900169, text = "Leave"}
, 
[1900170] = {id = 1900170, text = "Keep going"}
, 
[1900171] = {id = 1900171, text = "Watch stealthily"}
, 
[1900172] = {id = 1900172, text = "Restore Health of all Dolls in the team"}
, 
[1900173] = {id = 1900173, text = "Restore Health for the whole team"}
, 
[1900174] = {id = 1900174, text = "Random revive"}
, 
[1900175] = {id = 1900175, text = "Obtain reward"}
, 
[1900176] = {id = 1900176, text = "Reduce Health of all Dolls in the team"}
, 
[1900177] = {id = 1900177, text = "Reduce Health of all Dolls in the team"}
, 
[1900178] = {id = 1900178, text = "You took a bite of the apple. It tastes so fresh and juicy! $B$You thanked the old lady and continued on your journey.    "}
, 
[1900179] = {id = 1900179, text = "The apple is conjured. $B$It turns out the old lady is a witch who poisons travelers passing through."}
, 
[1900180] = {id = 1900180, text = "Not taking the apple, you continued on your journey."}
, 
[1900181] = {id = 1900181, text = "The old woman is a witch who has cursed you wickedly."}
, 
[1900182] = {id = 1900182, text = "\"May your journey go smooth.\" With the blessings of the elderly, you continued on your journey."}
, 
[1900183] = {id = 1900183, text = "In the depths of the cave, you found treasure left by a lost civilization."}
, 
[1900184] = {id = 1900184, text = "The cave was filled with toxic fumes and you had to get out quickly."}
, 
[1900185] = {id = 1900185, text = "Deep in the cave, you came upon a mysterious statue. You offered your sincere prayers and received the elf\'s blessing."}
, 
[1900186] = {id = 1900186, text = "You continued on your journey."}
, 
[1900187] = {id = 1900187, text = "It seems that there is only one wolf. It does not attack you, but quietly leaves."}
, 
[1900188] = {id = 1900188, text = "Wolves surrounded you. You fought them off, but were wounded."}
, 
[1900189] = {id = 1900189, text = "You found that a group of merchants was under attack by a pack of wolves, and you used magic to fend off the pack. To show their gratitude, the merchants gave you some of their goods."}
, 
[1900190] = {id = 1900190, text = "The wolves passed you by without noticing you."}
, 
[1900191] = {id = 1900191, text = "Opening the mysterious door, you found a chest behind it, which is the reward for your adventure."}
, 
[1900192] = {id = 1900192, text = "Upon opening the mysterious door, a trap was triggered that wounded you."}
, 
[1900193] = {id = 1900193, text = "After trying for a long time, you still haven\'t found a way to open the door."}
, 
[1900194] = {id = 1900194, text = "You continued on your journey."}
, 
[1900195] = {id = 1900195, text = "Inside the shack you could finally rest peacefully until the snowstorm subsides."}
, 
[1900196] = {id = 1900196, text = "The shack is in ramshackle and the wind is pouring into the house through the cracks of the boards. You waited in the cold for the wind and snow to calm."}
, 
[1900197] = {id = 1900197, text = "Convinced that the storm would soon dissipate, you didn\'t stop moving forward. And so it did."}
, 
[1900198] = {id = 1900198, text = "The biting cold paralyzed your senses and your hands and feet are severely frostbitten."}
, 
[1900199] = {id = 1900199, text = "You successfully stopped the evil ritual."}
, 
[1900200] = {id = 1900200, text = "An ancient monster was summoned during the ritual, and you fought with all your might to defeat it."}
, 
[1900201] = {id = 1900201, text = "It turned out that they were worshiping their ancestors, so you quietly left."}
, 
[1900202] = {id = 1900202, text = "They detected your scent and attacked you. Wounded, you had to leave quickly."}
, 
[1900203] = {id = 1900203, text = "Restore Health of all Dolls in the team by 50%"}
, 
[1900204] = {id = 1900204, text = "Reduce Health of all Dolls in the team by 50%"}
, 
[1900205] = {id = 1900205, text = "Nothing happened"}
, 
[1900206] = {id = 1900206, text = "Reduce Health of Dolls in the team by 50%"}
, 
[1900207] = {id = 1900207, text = "Restore Health of all Dolls by 10%"}
, 
[1900208] = {id = 1900208, text = ""}
, 
[1900209] = {id = 1900209, text = "Revive one Doll randomly"}
, 
[1900219] = {id = 1900219, text = "Mana Dreamland"}
, 
[1900220] = {id = 1900220, text = "Ascension Material"}
, 
[1900221] = {id = 1900221, text = "Skill Material"}
, 
[1900222] = {id = 1900222, text = "Doll Equipment"}
, 
[1900223] = {id = 1900223, text = "Intangible Barrier"}
, 
[1900224] = {id = 1900224, text = "Clear Main Story 2-2"}
, 
[1900236] = {id = 1900236, text = "A dreamland created by the butterfly monster. Defeat it to win Mana."}
, 
[1900238] = {id = 1900238, text = "A trial to win ascension materials for Guardians and Healers."}
, 
[1900239] = {id = 1900239, text = "A trial to win ascension materials for Assassins and Destroyers."}
, 
[1900240] = {id = 1900240, text = "A trial to win ascension materials for Mages and Compellers."}
, 
[1900241] = {id = 1900241, text = "A gloomy, fearsome villa."}
, 
[1900242] = {id = 1900242, text = "Defeat Soluk to win gear for Guardians and Healers."}
, 
[1900243] = {id = 1900243, text = "Defeat Soluk to win gear for Assassins and Destroyers."}
, 
[1900244] = {id = 1900244, text = "Defeat Soluk to win gear for Compellers and Mages."}
, 
[1900251] = {id = 1900251, text = "Chrono Tower"}
, 
[1900252] = {id = 1900252, text = "Irminsul"}
, 
[1900253] = {id = 1900253, text = "Snegurochka"}
, 
[1900254] = {id = 1900254, text = "Chapter 1"}
, 
[1900255] = {id = 1900255, text = "Chapter 2"}
, 
[1900257] = {id = 1900257, text = "Chapter 3"}
, 
[1900259] = {id = 1900259, text = "Chapter 4"}
, 
[1900266] = {id = 1900266, text = "Intermission"}
, 
[1900268] = {id = 1900268, text = "Ordinary Chest"}
, 
[1900269] = {id = 1900269, text = "Ornate Chest"}
, 
[1900270] = {id = 1900270, text = "Goblin Chest"}
, 
[1900271] = {id = 1900271, text = "Dejase the Alchemist"}
, 
[1900272] = {id = 1900272, text = "Cetess the Crimson Maiden of War"}
, 
[1900273] = {id = 1900273, text = "Sinmara, the Inferno"}
, 
[1900274] = {id = 1900274, text = "Mysterious Door"}
, 
[1900275] = {id = 1900275, text = "Mysterious Ritual"}
, 
[1900276] = {id = 1900276, text = "Roadside Old Woman"}
, 
[1900277] = {id = 1900277, text = "Secret Cave"}
, 
[1900278] = {id = 1900278, text = "Snow Shack"}
, 
[1900279] = {id = 1900279, text = "Snowy Plain Wolf Pack"}
, 
[1900280] = {id = 1900280, text = "In the corner, you found a mysterious door."}
, 
[1900281] = {id = 1900281, text = "Inside the room, a group of people were performing a mysterious ritual. A twinge of unease passed through your mind..."}
, 
[1900282] = {id = 1900282, text = "An aged lady on the side of the road called out to you, \"Would you like an apple? It\'s freshly picked.\""}
, 
[1900283] = {id = 1900283, text = "Deep in the forest you found a hidden cave with worn footprints on the ground. Intuition tells you that there seemed to be some hidden secrets in it..."}
, 
[1900284] = {id = 1900284, text = "In a fierce snowstorm, you looked around to find a place to take shelter. At that moment you saw a strange wood cabin in the distance."}
, 
[1900285] = {id = 1900285, text = "Wolves\' cry could be heard from across the snowy plains, but it seemed to be a long way off..."}
, 
[1900286] = {id = 1900286, text = "Open the hidden door"}
, 
[1900287] = {id = 1900287, text = "Stop them"}
, 
[1900288] = {id = 1900288, text = "Accept the apple"}
, 
[1900289] = {id = 1900289, text = "Explore the cave"}
, 
[1900290] = {id = 1900290, text = "Knock it"}
, 
[1900291] = {id = 1900291, text = "Keep going"}
, 
[1900292] = {id = 1900292, text = "Leave"}
, 
[1900293] = {id = 1900293, text = "Watch stealthily"}
, 
[1900294] = {id = 1900294, text = "Decline with thanks"}
, 
[1900295] = {id = 1900295, text = "Leave"}
, 
[1900296] = {id = 1900296, text = "Keep going"}
, 
[1900297] = {id = 1900297, text = "Conceal your breath"}
, 
[1900298] = {id = 1900298, text = "Upon opening the mysterious door, a trap was triggered that wounded you."}
, 
[1900299] = {id = 1900299, text = "There was nothing behind the door. Disappointed, you left."}
, 
[1900300] = {id = 1900300, text = "Just as you were about to leave, the door opened automatically and behind it was a shiny golden chest."}
, 
[1900301] = {id = 1900301, text = "You continued on your journey."}
, 
[1900302] = {id = 1900302, text = "It turned out to be a misunderstanding. They were just treating their wounded companions."}
, 
[1900303] = {id = 1900303, text = "They summoned vicious monsters that attacked you."}
, 
[1900304] = {id = 1900304, text = "It turned out they were praying for a safe journey, and you prayed with them."}
, 
[1900305] = {id = 1900305, text = "They detected your scent and attacked you. Wounded, you had to leave quickly."}
, 
[1900306] = {id = 1900306, text = "You took a bite of the apple. It tastes so fresh and juicy! $B$You thanked the old lady and continued on your journey."}
, 
[1900307] = {id = 1900307, text = "The apple is conjured. $B$It turns out the old lady is a witch who poisons travelers passing through."}
, 
[1900308] = {id = 1900308, text = "You took a bite of the apple, but nothing happened."}
, 
[1900309] = {id = 1900309, text = "It turns out that the old lady is a witch that poisons travelers passing through. $B$You defeated her and obtained her belongings."}
, 
[1900310] = {id = 1900310, text = "You continued on your journey."}
, 
[1900311] = {id = 1900311, text = "There is nothing inside. It seems to have been abandoned for some time."}
, 
[1900312] = {id = 1900312, text = "The cave was filled with toxic fumes and you had to get out quickly."}
, 
[1900313] = {id = 1900313, text = "You heard a cry for help from the cave and found a kidnapped merchant. $B$You rescued him and the merchant gave you some of his goods as a token of his gratitude."}
, 
[1900314] = {id = 1900314, text = "A group of bandits emerged from the cave. They robbed the travelers passing by. $B$You defeated them, but were also wounded."}
, 
[1900315] = {id = 1900315, text = "You found that the cabin was already abandoned. $B$You got inside to wait out the storm."}
, 
[1900316] = {id = 1900316, text = "The owner of the house kindly invited you in to wait out the snowstorm. And you got plenty of rest."}
, 
[1900317] = {id = 1900317, text = "The biting cold paralyzed your senses and your hands and feet are severely frostbitten."}
, 
[1900318] = {id = 1900318, text = "The voice becomes more and more distant. They don\'t seem to notice you."}
, 
[1900319] = {id = 1900319, text = "You found that a group of merchants was under attack by a pack of wolves, and you used magic to fend off the pack. To show their gratitude, the merchants gave you some of their goods."}
, 
[1900320] = {id = 1900320, text = "The wolves found you. You fought them off, but were wounded."}
, 
[1900347] = {id = 1900347, text = "Area 1"}
, 
[1900348] = {id = 1900348, text = "Area 2"}
, 
[1900349] = {id = 1900349, text = "Area 3"}
, 
[1900350] = {id = 1900350, text = "Area 4"}
, 
[1900351] = {id = 1900351, text = "Chrono Tower Floor 31"}
, 
[1900352] = {id = 1900352, text = "Chrono Tower Floor 33"}
, 
[1900353] = {id = 1900353, text = "Chrono Tower Floor 35"}
, 
[1900354] = {id = 1900354, text = "Chrono Tower Floor 37"}
, 
[1900355] = {id = 1900355, text = "Chrono Tower Floor 39"}
, 
[1900356] = {id = 1900356, text = "Hall of Cassiel"}
, 
[1900357] = {id = 1900357, text = "Chrono Tower Floor 31"}
, 
[1900358] = {id = 1900358, text = "Chrono Tower Floor 33"}
, 
[1900359] = {id = 1900359, text = "Chrono Tower Floor 35"}
, 
[1900360] = {id = 1900360, text = "Chrono Tower Floor 37"}
, 
[1900361] = {id = 1900361, text = "Chrono Tower Floor 39"}
, 
[1900362] = {id = 1900362, text = "A mysteries Hall, seemingly leading to unknown worlds."}
, 
[1900363] = {id = 1900363, text = "The Broken Lands"}
, 
[1900364] = {id = 1900364, text = "Evil Return"}
, 
[1900365] = {id = 1900365, text = "Intangible Barrier"}
, 
[1900366] = {id = 1900366, text = "Unlocks after clearing Main Story 3-18"}
, 
[1900367] = {id = 1900367, text = "Unlocks after clearing Main Story 3-15"}
, 
[1900368] = {id = 1900368, text = "Unlocks after clearing Main Story 3-5"}
, 
[1900369] = {id = 1900369, text = "Floating Isles Entry"}
, 
[1900370] = {id = 1900370, text = "Lower Domain: Stream Side Road"}
, 
[1900371] = {id = 1900371, text = "Lower Domain: Western Wilderness"}
, 
[1900372] = {id = 1900372, text = "Lower Domain: Northern Fields"}
, 
[1900373] = {id = 1900373, text = "Lower Domain: Cliffs"}
, 
[1900374] = {id = 1900374, text = "Lower Domain: Tote Village"}
, 
[1900375] = {id = 1900375, text = "Lower Domain: Flower Fields"}
, 
[1900376] = {id = 1900376, text = "Foothill Trail"}
, 
[1900377] = {id = 1900377, text = "Foothills Farmland"}
, 
[1900378] = {id = 1900378, text = "Lower Domain: Northern Fields"}
, 
[1900379] = {id = 1900379, text = "Lower Domain: Eastern Fields"}
, 
[1900380] = {id = 1900380, text = "Lower Domain: Ancient Tree"}
, 
[1900381] = {id = 1900381, text = "Ruins of Pelenier Village"}
, 
[1900382] = {id = 1900382, text = "Lower Domain: Road\'s End"}
, 
[1900383] = {id = 1900383, text = "Winding Trail"}
, 
[1900384] = {id = 1900384, text = "Spiral Corridor: Front"}
, 
[1900385] = {id = 1900385, text = "The islands floating in the air. The entrance to Cassiel."}
, 
[1900386] = {id = 1900386, text = "Follow this creek to continue exploring the Floating Isles of Cassiel."}
, 
[1900387] = {id = 1900387, text = "The western part of the Fields."}
, 
[1900388] = {id = 1900388, text = "The northern part of the Fields."}
, 
[1900389] = {id = 1900389, text = "Standing here, you can see endless darkness through the clouds."}
, 
[1900390] = {id = 1900390, text = "A small village of Cassiel."}
, 
[1900391] = {id = 1900391, text = "Flower fields outside the village, where all sorts of wildflowers grow."}
, 
[1900392] = {id = 1900392, text = "A path at the foot of the mountain that leads to a nearby farmland."}
, 
[1900393] = {id = 1900393, text = "A vast expanse of farmland, planted with all sorts of crops."}
, 
[1900394] = {id = 1900394, text = "The northern part of the Field."}
, 
[1900395] = {id = 1900395, text = "The eastern part of the Field."}
, 
[1900396] = {id = 1900396, text = "A giant tree that exudes magic is said to be hundreds of years."}
, 
[1900397] = {id = 1900397, text = "A village that was destroyed by monsters and left in its ruins."}
, 
[1900398] = {id = 1900398, text = "A path near the Ruins of Pelenier Village."}
, 
[1900399] = {id = 1900399, text = "A winding trail that leads to the Spiral Perch."}
, 
[1900400] = {id = 1900400, text = "The front part of the Spiral Corridor."}
, 
[1900401] = {id = 1900401, text = "Cassiel"}
, 
[1900402] = {id = 1900402, text = "Chapter 5"}
, 
[1900404] = {id = 1900404, text = "Dejase"}
, 
[1900405] = {id = 1900405, text = "Alchemist"}
, 
[1900406] = {id = 1900406, text = "Mortimer"}
, 
[1900407] = {id = 1900407, text = "Heart of Rose"}
, 
[1900408] = {id = 1900408, text = "Broken Segment"}
, 
[1900409] = {id = 1900409, text = "Rose Segments"}
, 
[1900410] = {id = 1900410, text = "A Missed Opportunity"}
, 
[1900411] = {id = 1900411, text = "Mortimer\'s Side Story"}
, 
[1900412] = {id = 1900412, text = "\"It\'s my choice, and I\'m not entertaining any of your unsolicited critiques.\""}
, 
[1900413] = {id = 1900413, text = "\"Locked slogans of Mortimer\""}
, 
[1900414] = {id = 1900414, text = "Chilora"}
, 
[1900415] = {id = 1900415, text = "Kingdom of Pannonia"}
, 
[1900416] = {id = 1900416, text = "Principality of Lunia"}
, 
[1900417] = {id = 1900417, text = "Act I: Invitation"}
, 
[1900418] = {id = 1900418, text = "Act II: Strength"}
, 
[1900419] = {id = 1900419, text = "Act III: Like-minded"}
, 
[1900420] = {id = 1900420, text = "Act IV: Secrets"}
, 
[1900421] = {id = 1900421, text = "Act V: Encounter"}
, 
[1900422] = {id = 1900422, text = "Act VI: Gift"}
, 
[1900423] = {id = 1900423, text = "Dejase was fighting monsters to search for clues to enter the Chrono Tower when she encountered Bluen, who also wanted to enter the tower and was putting together a team..."}
, 
[1900424] = {id = 1900424, text = "Dejase was pestered by a strange little girl. Not knowing what to do, Dejase decided to take the little girl with her on the search for Bluen..."}
, 
[1900425] = {id = 1900425, text = "Dejase decided to join Bluen\'s team. While they were discussing how to enter the Chrono Tower, a man claiming to be a preacher from the Holy Church suddenly appeared..."}
, 
[1900426] = {id = 1900426, text = "The preacher claimed that he found where the monsters gathered. Dejase decided to go there with Ella..."}
, 
[1900427] = {id = 1900427, text = "Since the Principality of Lunia fell into internal war, monsters that devour live souls appeared everywhere. Mortimer, the manager of the largest garden in Lunia, found monsters in his garden one day..."}
, 
[1900428] = {id = 1900428, text = "While escaping, Mortimer ran into Nocturna and thought she was the one manipulating the monsters. A wounded Mortimer tried to fight Nocturna, but he couldn\'t last very long..."}
, 
[1900429] = {id = 1900429, text = "When Mortimer and Nocturna cleared up their misunderstanding, they discovered that the garden was taken over by monsters. Mortimer decided to go to the castle and deliver the news to the Grand Duke. However..."}
, 
[1900430] = {id = 1900430, text = "Mortimer and Nocturna encountered the Princess, who was under attack. After rescuing her, they found out the whereabouts of the mastermind from the guard, and set off to confront them..."}
, 
[1900437] = {id = 1900437, text = "Easy"}
, 
[1900438] = {id = 1900438, text = "Basic"}
, 
[1900439] = {id = 1900439, text = "Normal"}
, 
[1900440] = {id = 1900440, text = "Normal 2"}
, 
[1900441] = {id = 1900441, text = "Hard"}
, 
[1900442] = {id = 1900442, text = "Hard 2"}
, 
[1900443] = {id = 1900443, text = "Punishing"}
, 
[1900444] = {id = 1900444, text = "Punishing 2"}
, 
[1900445] = {id = 1900445, text = "Nightmare"}
, 
[1900446] = {id = 1900446, text = "Nightmare $parameters$"}
, 
[1900447] = {id = 1900447, text = "Increases enemy Health by 20%."}
, 
[1900448] = {id = 1900448, text = "Increases enemy Health by 20%."}
, 
[1900449] = {id = 1900449, text = "Increases opponent\'s Attack by 20%"}
, 
[1900450] = {id = 1900450, text = "Chronospace Breach"}
, 
[1900451] = {id = 1900451, text = "Restore 10% Health per milestone"}
, 
[1900452] = {id = 1900452, text = "Increases Physical DMG by 5%"}
, 
[1900453] = {id = 1900453, text = "Increases Physical DEF by 5%"}
, 
[1900454] = {id = 1900454, text = "Increases Magic DMG by 5%"}
, 
[1900455] = {id = 1900455, text = "Increases Magic DEF by 5%"}
, 
[1900456] = {id = 1900456, text = "Increases Crit Chance by 5%"}
, 
[1900457] = {id = 1900457, text = "Dejase the Alchemist"}
, 
[1900458] = {id = 1900458, text = "Elementalist Anemone"}
, 
[1900459] = {id = 1900459, text = "Clear Main Story 1-2 to unlock Summon"}
, 
[1900460] = {id = 1900460, text = "Clear Main Story 1-3 to unlock Commission Board"}
, 
[1900461] = {id = 1900461, text = "Clear Main Story 2-2 to unlock Dreamworld"}
, 
[1900462] = {id = 1900462, text = "Clear Main Story 2-4 to unlock Witch Courtyard"}
, 
[1900463] = {id = 1900463, text = "Clear Main Story 2-8 to unlock Friends"}
, 
[1900464] = {id = 1900464, text = "Clear Main Story 2-13 to unlock Intangible Memories"}
, 
[1900466] = {id = 1900466, text = "Spiral Corridor: End"}
, 
[1900467] = {id = 1900467, text = "They finally found the mastermind, and started a fierce battle against her..."}
, 
[1900468] = {id = 1900468, text = "Act I: Frustration"}
, 
[1900469] = {id = 1900469, text = "Act II: Chance Encounter"}
, 
[1900470] = {id = 1900470, text = "Act III: Princess"}
, 
[1900471] = {id = 1900471, text = "Act IV: Set Off"}
, 
[1900472] = {id = 1900472, text = "Act V: Following"}
, 
[1900475] = {id = 1900475, text = "Clear Main Story 3-5 to unlock Intangible Barrier"}
, 
[1900476] = {id = 1900476, text = "Clear Main Story 3-15 to unlock Evil Return"}
, 
[1900477] = {id = 1900477, text = "Clear Main Story 2-3"}
, 
[1900478] = {id = 1900478, text = "As they were about to enter the Chrono Tower, Fellagood tried to dissuade Bluen and her team from entering, A heated quarrel ensued, and Fellagood summoned..."}
, 
[1900479] = {id = 1900479, text = "When Dejase woke up, the group from the Holy Church was long gone. She felt a little strange, but it was just a short nap, so she got up and followed Bluen into the Chrono Tower..."}
, 
[1900480] = {id = 1900480, text = "Spiral Perch"}
, 
[1900481] = {id = 1900481, text = "The end section of the Spiral Corridor."}
, 
[1900482] = {id = 1900482, text = "On the Spiral Perch, you can see a huge monster beneath the clouds."}
, 
[1900483] = {id = 1900483, text = "Clear Main Story 3-5 to unlock Chronospace Breach"}
, 
[1900484] = {id = 1900484, text = "Clear 3-18 to unlock The Broken Lands"}
, 
[1900485] = {id = 1900485, text = "Dream of Eddine 1"}
, 
[1900486] = {id = 1900486, text = "Dream of Eddine 2"}
, 
[1900487] = {id = 1900487, text = "Dream of Eddine 3"}
, 
[1900488] = {id = 1900488, text = "Dream of Eddine 4"}
, 
[1900489] = {id = 1900489, text = "Dream of Eddine 5"}
, 
[1900490] = {id = 1900490, text = "Dream of Eddine 6"}
, 
[1900491] = {id = 1900491, text = "Garrison Trial 1"}
, 
[1900492] = {id = 1900492, text = "Garrison Trial 2"}
, 
[1900493] = {id = 1900493, text = "Garrison Trial 3"}
, 
[1900494] = {id = 1900494, text = "Garrison Trial 4"}
, 
[1900495] = {id = 1900495, text = "Garrison Trial 5"}
, 
[1900496] = {id = 1900496, text = "Garrison Trial 6"}
, 
[1900497] = {id = 1900497, text = "Damage Trial 1"}
, 
[1900498] = {id = 1900498, text = "Damage Trial 2"}
, 
[1900499] = {id = 1900499, text = "Damage Trial 3"}
, 
[1900500] = {id = 1900500, text = "Damage Trial 4"}
, 
[1900501] = {id = 1900501, text = "Damage Trial 5"}
, 
[1900502] = {id = 1900502, text = "Damage Trial 6"}
, 
[1900503] = {id = 1900503, text = "Magic Trial 1"}
, 
[1900504] = {id = 1900504, text = "Magic Trial 2"}
, 
[1900505] = {id = 1900505, text = "Magic Trial 3"}
, 
[1900506] = {id = 1900506, text = "Magic Trial 4"}
, 
[1900507] = {id = 1900507, text = "Magic Trial 5"}
, 
[1900508] = {id = 1900508, text = "Magic Trial 6"}
, 
[1900509] = {id = 1900509, text = "Hall of Fear 1"}
, 
[1900510] = {id = 1900510, text = "Hall of Fear 2"}
, 
[1900511] = {id = 1900511, text = "Hall of Fear 3"}
, 
[1900512] = {id = 1900512, text = "Hall of Fear 4"}
, 
[1900513] = {id = 1900513, text = "Hall of Fear 5"}
, 
[1900514] = {id = 1900514, text = "Hall of Fear 6"}
, 
[1900515] = {id = 1900515, text = "Hall of Fear 7"}
, 
[1900516] = {id = 1900516, text = "Hall of Fear 8"}
, 
[1900517] = {id = 1900517, text = "Oath of Protection 1"}
, 
[1900518] = {id = 1900518, text = "Oath of Protection 2"}
, 
[1900519] = {id = 1900519, text = "Oath of Protection 3"}
, 
[1900520] = {id = 1900520, text = "Oath of Protection 4"}
, 
[1900521] = {id = 1900521, text = "Relentless 1"}
, 
[1900522] = {id = 1900522, text = "Relentless 2"}
, 
[1900523] = {id = 1900523, text = "Relentless 3"}
, 
[1900524] = {id = 1900524, text = "Relentless 4"}
, 
[1900525] = {id = 1900525, text = "Wisdom and Knowledge 1"}
, 
[1900526] = {id = 1900526, text = "Wisdom and Knowledge 2"}
, 
[1900527] = {id = 1900527, text = "Wisdom and Knowledge 3"}
, 
[1900528] = {id = 1900528, text = "Wisdom and Knowledge 4"}
, 
[1900529] = {id = 1900529, text = "Sky Dominator Solaris Dimas"}
, 
[1900530] = {id = 1900530, text = "Unlocks after clearing Main Story 3-5"}
, 
[1900531] = {id = 1900531, text = "S1-1"}
, 
[1900532] = {id = 1900532, text = "S1-2"}
, 
[1900533] = {id = 1900533, text = "S1-3"}
, 
[1900534] = {id = 1900534, text = "S1-4"}
, 
[1900535] = {id = 1900535, text = "S1-5"}
, 
[1900536] = {id = 1900536, text = "S1-6"}
, 
[1900537] = {id = 1900537, text = "S1-7"}
, 
[1900538] = {id = 1900538, text = "S1-8"}
, 
[1900539] = {id = 1900539, text = "BS1-1"}
, 
[1900540] = {id = 1900540, text = "BS1-2"}
, 
[1900541] = {id = 1900541, text = "BS1-3"}
, 
[1900542] = {id = 1900542, text = "BS1-4"}
, 
[1900543] = {id = 1900543, text = "BS1-5"}
, 
[1900544] = {id = 1900544, text = "BS1-6"}
, 
[1900545] = {id = 1900545, text = "BS1-7"}
, 
[1900546] = {id = 1900546, text = "BS1-8"}
, 
[1900547] = {id = 1900547, text = "Stage Info"}
, 
[1900548] = {id = 1900548, text = "Stage Info"}
, 
[1900549] = {id = 1900549, text = "Stage Info"}
, 
[1900550] = {id = 1900550, text = "Stage Info"}
, 
[1900551] = {id = 1900551, text = "Stage Info"}
, 
[1900552] = {id = 1900552, text = "Stage Info"}
, 
[1900553] = {id = 1900553, text = "Stage Info"}
, 
[1900554] = {id = 1900554, text = "Stage Info"}
, 
[1900555] = {id = 1900555, text = "Stage Info"}
, 
[1900556] = {id = 1900556, text = "Stage Info"}
, 
[1900557] = {id = 1900557, text = "Stage Info"}
, 
[1900558] = {id = 1900558, text = "Stage Info"}
, 
[1900559] = {id = 1900559, text = "Stage Info"}
, 
[1900560] = {id = 1900560, text = "Stage Info"}
, 
[1900561] = {id = 1900561, text = "Stage Info"}
, 
[1900562] = {id = 1900562, text = "Stage Info"}
, 
[1900563] = {id = 1900563, text = "Phantom Mirror of Stars"}
, 
[1900564] = {id = 1900564, text = "Star Collection"}
, 
[1900565] = {id = 1900565, text = "Defeat nightmares and collect star shards!"}
, 
[1900566] = {id = 1900566, text = "Current reward phase: $parameter1$/$parameter2$"}
, 
[1900567] = {id = 1900567, text = "Increases ATK"}
, 
[1900568] = {id = 1900568, text = "Increases DEF"}
, 
[1900569] = {id = 1900569, text = "Enhance Skill"}
, 
[1900570] = {id = 1900570, text = "Frenzy"}
, 
[1900571] = {id = 1900571, text = "Increases attack by 50%"}
, 
[1900572] = {id = 1900572, text = "Increases DEF by 50%"}
, 
[1900573] = {id = 1900573, text = "Increases skill damage by 50%"}
, 
[1900574] = {id = 1900574, text = "Monsters are enhanced significantly 30 seconds after entering combat."}
, 
[1900575] = {id = 1900575, text = "The boss is enhanced significantly 2 minutes and 30 seconds after entering combat."}
, 
[1900576] = {id = 1900576, text = "Incarnation of Destiny"}
, 
[1900577] = {id = 1900577, text = "Absolute Incarnation of Destiny"}
, 
[1900578] = {id = 1900578, text = "Increases drop rate of Stars"}
, 
[1900579] = {id = 1900579, text = "Increases drop rate Stars by $parameter1$%"}
, 
[1900580] = {id = 1900580, text = "Collect a certain amount of Stars to obtain the following rewards"}
, 
[1900581] = {id = 1900581, text = "$parameter1$ Expired"}
, 
[1900582] = {id = 1900582, text = "Intensified Shop unlocks at 04:00 on Mar. 18"}
, 
[1900583] = {id = 1900583, text = "$parameter1$ Expired"}
, 
[1900584] = {id = 1900584, text = "Clear $parameter1$ to enter Phantom Mirror of Stars"}
, 
[1900585] = {id = 1900585, text = "Use the following characters and enjoy increased drop rate of Stars"}
, 
[1900586] = {id = 1900586, text = "Unlocks at 04:00 on Mar. 18"}
, 
[1900587] = {id = 1900587, text = "Star Collection has ended, but rewards can still be redeemed."}
, 
[1900588] = {id = 1900588, text = "Half of stamina will be deducted if you fail in Intensified Difficulty. Challenge at your peril!"}
, 
[1900589] = {id = 1900589, text = "ATK Enhancement"}
, 
[1900590] = {id = 1900590, text = "Blessing of Arrogance"}
, 
[1900591] = {id = 1900591, text = "Beast Hunter"}
, 
[1900592] = {id = 1900592, text = "Helm of Counterattack"}
, 
[1900593] = {id = 1900593, text = "Blessing of Cleanse"}
, 
[1900594] = {id = 1900594, text = "Blessing of Attack"}
, 
[1900595] = {id = 1900595, text = "Blessing of Recovery"}
, 
[1900596] = {id = 1900596, text = "Mage Shield"}
, 
[1900597] = {id = 1900597, text = "Mage Shield"}
, 
[1900598] = {id = 1900598, text = "Divine Punishment"}
, 
[1900599] = {id = 1900599, text = "Augment Magic"}
, 
[1900600] = {id = 1900600, text = "Blessing of Life"}
, 
[1900601] = {id = 1900601, text = "Blessing of Willpower"}
, 
[1900602] = {id = 1900602, text = "Oath Shield"}
, 
[1900603] = {id = 1900603, text = "ATK Enhancement"}
, 
[1900604] = {id = 1900604, text = "Elite Hunter"}
, 
[1900605] = {id = 1900605, text = "Blessing of Tyranny"}
, 
[1900606] = {id = 1900606, text = "Blessing of Attack"}
, 
[1900607] = {id = 1900607, text = "Hourglass of Time"}
, 
[1900608] = {id = 1900608, text = "Blessing of Relentlessness"}
, 
[1900609] = {id = 1900609, text = "Blessing of Relentlessness"}
, 
[1900610] = {id = 1900610, text = "Augment Magic"}
, 
[1900611] = {id = 1900611, text = "Blessing of Life"}
, 
[1900612] = {id = 1900612, text = "Oath Shield"}
, 
[1900613] = {id = 1900613, text = "Bloodthirst Curse"}
, 
[1900614] = {id = 1900614, text = "Taking a Risk"}
, 
[1900615] = {id = 1900615, text = "ATK <color=#dd9758>+100</color>"}
, 
[1900616] = {id = 1900616, text = "Damage dealt to enemies with low Health <color=#dd9758>+10%</color>"}
, 
[1900617] = {id = 1900617, text = "Damage dealt to normal monsters <color=#dd9758>+30%</color>"}
, 
[1900618] = {id = 1900618, text = "There is a chance to reflect damage back to the attacker when taking damage."}
, 
[1900619] = {id = 1900619, text = "Healing skills have a <color=#dd9758>30%</color> chance to remove debuffs."}
, 
[1900620] = {id = 1900620, text = "ATK <color=#dd9758>+10%</color>"}
, 
[1900621] = {id = 1900621, text = "Character gains <color=#dd9758>+20%</color> health after killing an enemy."}
, 
[1900622] = {id = 1900622, text = "Magic DEF <color=#dd9758>+15%</color>"}
, 
[1900623] = {id = 1900623, text = "Magic DEF <color=#dd9758>+30%</color>"}
, 
[1900624] = {id = 1900624, text = "Deals a large amount of damage to <color=#dd9758>all enemies</color> <color=#dd9758>10 seconds</color> after combat starts."}
, 
[1900625] = {id = 1900625, text = "Increases damage by <color=#dd9758>3%</color> for every <color=#dd9758>1</color> Chaos Energy gained"}
, 
[1900626] = {id = 1900626, text = "All Health <color=#dd9758>+10%</color>"}
, 
[1900627] = {id = 1900627, text = "A doll\'s Health is increased by <color=#dd9758>20%</color> when they die for the first time in combat. Triggers once per battle."}
, 
[1900628] = {id = 1900628, text = "Physical DEF <color=#dd9758>+15%</color>"}
, 
[1900629] = {id = 1900629, text = "ATK <color=#dd9758>+150</color>"}
, 
[1900630] = {id = 1900630, text = "Deals <color=#dd9758>20%</color> bonus damage to elites and bosses."}
, 
[1900631] = {id = 1900631, text = "Crit Chance and Crit DMG <color=#dd9758>+20%</color>"}
, 
[1900632] = {id = 1900632, text = "ATK <color=#dd9758>+20%</color>"}
, 
[1900633] = {id = 1900633, text = "Order Energy generation <color=#dd9758>+20%</color>"}
, 
[1900634] = {id = 1900634, text = "Damage dealt <color=#dd9758>+50%</color>"}
, 
[1900635] = {id = 1900635, text = "Energy Outbreak damage <color=#dd9758>+100%</color>"}
, 
[1900636] = {id = 1900636, text = "Increases damage by <color=#dd9758>3%</color> for every 1 Order Energy gained"}
, 
[1900637] = {id = 1900637, text = "Epic"}
, 
[1900638] = {id = 1900638, text = "Rare"}
, 
[1900639] = {id = 1900639, text = "Mana Dreamland"}
, 
[1900640] = {id = 1900640, text = "Garrison Trial"}
, 
[1900641] = {id = 1900641, text = "Damage Trial"}
, 
[1900642] = {id = 1900642, text = "Magic Trial"}
, 
[1900643] = {id = 1900643, text = "Hall of Fear"}
, 
[1900644] = {id = 1900644, text = "Oath of Protection"}
, 
[1900645] = {id = 1900645, text = "Relentless"}
, 
[1900646] = {id = 1900646, text = "Wisdom and Knowledge"}
, 
[1900647] = {id = 1900647, text = "Clear Main Story 2-6"}
, 
[1900648] = {id = 1900648, text = "Select the starting point of this week\'s Intangible Barrier"}
, 
[1900649] = {id = 1900649, text = "You will lose all your blessings if you return to the starting point."}
, 
[1900650] = {id = 1900650, text = "Act $parameter$"}
, 
[1900651] = {id = 1900651, text = "\"Invitation\""}
, 
[1900652] = {id = 1900652, text = "\"Strength\""}
, 
[1900653] = {id = 1900653, text = "\"Like-minded\""}
, 
[1900654] = {id = 1900654, text = "\"Secrets\""}
, 
[1900655] = {id = 1900655, text = "\"Encounter\""}
, 
[1900656] = {id = 1900656, text = "\"Gifts\""}
, 
[1900657] = {id = 1900657, text = "\"Frustrated\""}
, 
[1900658] = {id = 1900658, text = "\"Chance Encounter\""}
, 
[1900659] = {id = 1900659, text = "\"Princess\""}
, 
[1900660] = {id = 1900660, text = "\"Set Off\""}
, 
[1900662] = {id = 1900662, text = "All Health <color=#dd9758>+30%</color>"}
, 
[1900663] = {id = 1900663, text = "Physical DEF <color=#dd9758>+30%</color>"}
, 
[1900664] = {id = 1900664, text = "Provides Physical Block and Magic Block"}
, 
[1900665] = {id = 1900665, text = "Reduces Health by <color=#dd9758>2%</color>, increases damage dealt by <color=#dd9758>5%</color>"}
, 
[1900666] = {id = 1900666, text = "Oath of Protection 5"}
, 
[1900667] = {id = 1900667, text = "Oath of Protection 6"}
, 
[1900668] = {id = 1900668, text = "Oath of Protection 7"}
, 
[1900669] = {id = 1900669, text = "Oath of Protection 8"}
, 
[1900670] = {id = 1900670, text = "Relentless 5"}
, 
[1900671] = {id = 1900671, text = "Relentless 6"}
, 
[1900672] = {id = 1900672, text = "Relentless 7"}
, 
[1900673] = {id = 1900673, text = "Relentless 8"}
, 
[1900674] = {id = 1900674, text = "Wisdom and Knowledge 5"}
, 
[1900675] = {id = 1900675, text = "Wisdom and Knowledge 6"}
, 
[1900676] = {id = 1900676, text = "Wisdom and Knowledge 7"}
, 
[1900677] = {id = 1900677, text = "Wisdom and Knowledge 8"}
, 
[1900678] = {id = 1900678, text = "Physical Block <color=#dd9758>+20%</color>"}
, 
[1900679] = {id = 1900679, text = "Spell of Blood"}
, 
[1900680] = {id = 1900680, text = "Act I"}
, 
[1900681] = {id = 1900681, text = "Act II"}
, 
[1900682] = {id = 1900682, text = "Act III"}
, 
[1900683] = {id = 1900683, text = "Act IV"}
, 
[1900684] = {id = 1900684, text = "Act V"}
, 
[1900685] = {id = 1900685, text = "Act VI"}
, 
[1900686] = {id = 1900686, text = "Increases ATK"}
, 
[1900687] = {id = 1900687, text = "Increases ATK"}
, 
[1900688] = {id = 1900688, text = "Increases DMG dealt"}
, 
[1900689] = {id = 1900689, text = "Increases DMG dealt"}
, 
[1900690] = {id = 1900690, text = "Monster Killer"}
, 
[1900691] = {id = 1900691, text = "Elite Killer"}
, 
[1900692] = {id = 1900692, text = "Relentless"}
, 
[1900693] = {id = 1900693, text = "Preparation"}
, 
[1900694] = {id = 1900694, text = "Surging Magic"}
, 
[1900695] = {id = 1900695, text = "Order Blast"}
, 
[1900696] = {id = 1900696, text = "Chaos Blast"}
, 
[1900697] = {id = 1900697, text = "Divine Thunder"}
, 
[1900698] = {id = 1900698, text = "Core Pierce"}
, 
[1900699] = {id = 1900699, text = "Large Physique"}
, 
[1900700] = {id = 1900700, text = "Large Physique"}
, 
[1900701] = {id = 1900701, text = "Life Steal"}
, 
[1900702] = {id = 1900702, text = "Life Steal"}
, 
[1900703] = {id = 1900703, text = "Healing Vitality"}
, 
[1900704] = {id = 1900704, text = "Healing Vitality"}
, 
[1900705] = {id = 1900705, text = "Periodic Supply"}
, 
[1900706] = {id = 1900706, text = "Everlasting Oath"}
, 
[1900707] = {id = 1900707, text = "Physical Resilience"}
, 
[1900708] = {id = 1900708, text = "Physical Resilience"}
, 
[1900709] = {id = 1900709, text = "Magic Resilience"}
, 
[1900710] = {id = 1900710, text = "Magic Resilience"}
, 
[1900711] = {id = 1900711, text = "Avenge"}
, 
[1900712] = {id = 1900712, text = "Early Blessing"}
, 
[1900713] = {id = 1900713, text = "Initiative"}
, 
[1900714] = {id = 1900714, text = "All or Nothing"}
, 
[1900715] = {id = 1900715, text = "Double Edged Sword"}
, 
[1900716] = {id = 1900716, text = "Ingenious Attack"}
, 
[1900717] = {id = 1900717, text = "Increases ATK by 5%."}
, 
[1900718] = {id = 1900718, text = "Increases ATK by 10%."}
, 
[1900719] = {id = 1900719, text = "Increases Crit Chance by 5% and Crit DMG by 15%."}
, 
[1900720] = {id = 1900720, text = "Increases Crit Chance by 10% and Crit DMG by 30%."}
, 
[1900721] = {id = 1900721, text = "Increases damage dealt to normal monsters by 30%."}
, 
[1900722] = {id = 1900722, text = "Increases damage dealt to elite monsters and bosses by 30%."}
, 
[1900723] = {id = 1900723, text = "Increases damage dealt by 1% for each attack, up to 40%."}
, 
[1900724] = {id = 1900724, text = "Every 10 seconds, increases the next skill damage by 100%."}
, 
[1900725] = {id = 1900725, text = "Increases Order Energy generation by 20%."}
, 
[1900726] = {id = 1900726, text = "Increases damage by 5% for every 1 Chaos Energy gained."}
, 
[1900727] = {id = 1900727, text = "Increases damage by 5% for every 1 Order Energy gained."}
, 
[1900728] = {id = 1900728, text = "During the first 10 seconds of battle, deals damage equal to 10% of max Health to all enemies (up to 20,000)."}
, 
[1900729] = {id = 1900729, text = "Deals 50% more damage if target\'s Health is below 30%."}
, 
[1900730] = {id = 1900730, text = "Increases max Health by 5%."}
, 
[1900731] = {id = 1900731, text = "Increases max Health by 10%."}
, 
[1900732] = {id = 1900732, text = "Converts 5% of damage dealt into Health."}
, 
[1900733] = {id = 1900733, text = "Converts 10% of damage dealt into Health."}
, 
[1900734] = {id = 1900734, text = "Takes 15% more healing."}
, 
[1900735] = {id = 1900735, text = "Takes 30% more healing."}
, 
[1900736] = {id = 1900736, text = "Triggers a recovery effect that restores 10% of max Health once every 10 seconds."}
, 
[1900737] = {id = 1900737, text = "When a doll reaches 0 Health, heals self for 20% of max Health. Only triggers once per battle."}
, 
[1900738] = {id = 1900738, text = "Takes 5% less Physical DMG from enemy attacks."}
, 
[1900739] = {id = 1900739, text = "Takes 10% less Physical DMG from enemy attacks."}
, 
[1900740] = {id = 1900740, text = "Takes 5% less Magic DMG from enemy attacks."}
, 
[1900741] = {id = 1900741, text = "Takes 10% less Magic DMG from enemy attacks."}
, 
[1900742] = {id = 1900742, text = "When taking damage, there is a 10% chance to deal the same amount of damage to the attacker."}
, 
[1900743] = {id = 1900743, text = "Immune to damage once after entering combat."}
, 
[1900744] = {id = 1900744, text = "Increases the damage of the first skill used during combat by 100%."}
, 
[1900745] = {id = 1900745, text = "Increases damage dealt to enemies as Health drops, up to 50%."}
, 
[1900746] = {id = 1900746, text = "Increases damage taken by 10% but increases damage dealt by 20%."}
, 
[1900747] = {id = 1900747, text = "Monsters are unable to take action during the first 10 seconds of battle."}
, 
[1900748] = {id = 1900748, text = "Increases skill effect by 5%."}
, 
[1900749] = {id = 1900749, text = "Increases skill effect by 10%."}
, 
[1900750] = {id = 1900750, text = ""}
, 
[1900751] = {id = 1900751, text = ""}
, 
[1900752] = {id = 1900752, text = ""}
, 
[1900753] = {id = 1900753, text = ""}
, 
[1900754] = {id = 1900754, text = ""}
, 
[1900755] = {id = 1900755, text = ""}
, 
[1900756] = {id = 1900756, text = ""}
, 
[1900757] = {id = 1900757, text = ""}
, 
[1900758] = {id = 1900758, text = ""}
, 
[1900759] = {id = 1900759, text = ""}
, 
[1900760] = {id = 1900760, text = ""}
, 
[1900761] = {id = 1900761, text = ""}
, 
[1900762] = {id = 1900762, text = ""}
, 
[1900763] = {id = 1900763, text = ""}
, 
[1900764] = {id = 1900764, text = ""}
, 
[1900765] = {id = 1900765, text = ""}
, 
[1900766] = {id = 1900766, text = ""}
, 
[1900767] = {id = 1900767, text = ""}
, 
[1900768] = {id = 1900768, text = ""}
, 
[1900769] = {id = 1900769, text = ""}
, 
[1900770] = {id = 1900770, text = ""}
, 
[1900771] = {id = 1900771, text = ""}
, 
[1900772] = {id = 1900772, text = ""}
, 
[1900773] = {id = 1900773, text = ""}
, 
[1900774] = {id = 1900774, text = ""}
, 
[1900775] = {id = 1900775, text = ""}
, 
[1900776] = {id = 1900776, text = ""}
, 
[1900777] = {id = 1900777, text = ""}
, 
[1900778] = {id = 1900778, text = ""}
, 
[1900779] = {id = 1900779, text = ""}
, 
[1900780] = {id = 1900780, text = ""}
, 
[1900781] = {id = 1900781, text = ""}
, 
[1900782] = {id = 1900782, text = ""}
, 
[1900783] = {id = 1900783, text = ""}
, 
[1900784] = {id = 1900784, text = ""}
, 
[1900785] = {id = 1900785, text = ""}
, 
[1900786] = {id = 1900786, text = ""}
, 
[1900787] = {id = 1900787, text = ""}
, 
[1900788] = {id = 1900788, text = ""}
, 
[1900789] = {id = 1900789, text = ""}
, 
[1900790] = {id = 1900790, text = ""}
, 
[1900791] = {id = 1900791, text = ""}
, 
[1900792] = {id = 1900792, text = ""}
, 
[1900793] = {id = 1900793, text = ""}
, 
[1900794] = {id = 1900794, text = ""}
, 
[1900795] = {id = 1900795, text = ""}
, 
[1900796] = {id = 1900796, text = ""}
, 
[1900797] = {id = 1900797, text = ""}
, 
[1900798] = {id = 1900798, text = ""}
, 
[1900799] = {id = 1900799, text = ""}
, 
[1900800] = {id = 1900800, text = ""}
, 
[1900801] = {id = 1900801, text = ""}
, 
[1900802] = {id = 1900802, text = ""}
, 
[1900803] = {id = 1900803, text = ""}
, 
[1900804] = {id = 1900804, text = ""}
, 
[1900805] = {id = 1900805, text = ""}
, 
[1900806] = {id = 1900806, text = ""}
, 
[1900807] = {id = 1900807, text = ""}
, 
[1900808] = {id = 1900808, text = ""}
, 
[1900809] = {id = 1900809, text = ""}
, 
[1900810] = {id = 1900810, text = ""}
, 
[1900811] = {id = 1900811, text = ""}
, 
[1900812] = {id = 1900812, text = ""}
, 
[1900813] = {id = 1900813, text = ""}
, 
[1900814] = {id = 1900814, text = ""}
, 
[1900815] = {id = 1900815, text = ""}
, 
[1900816] = {id = 1900816, text = ""}
, 
[1900817] = {id = 1900817, text = ""}
, 
[1900818] = {id = 1900818, text = ""}
, 
[1900819] = {id = 1900819, text = ""}
, 
[1900820] = {id = 1900820, text = ""}
, 
[1900821] = {id = 1900821, text = ""}
, 
[1900822] = {id = 1900822, text = ""}
, 
[1900823] = {id = 1900823, text = ""}
, 
[1900824] = {id = 1900824, text = ""}
, 
[1900825] = {id = 1900825, text = ""}
, 
[1900826] = {id = 1900826, text = ""}
, 
[1900827] = {id = 1900827, text = ""}
, 
[1900828] = {id = 1900828, text = ""}
, 
[1900829] = {id = 1900829, text = ""}
, 
[1900830] = {id = 1900830, text = ""}
, 
[1900831] = {id = 1900831, text = ""}
, 
[1900832] = {id = 1900832, text = ""}
, 
[1900833] = {id = 1900833, text = ""}
, 
[1900834] = {id = 1900834, text = ""}
, 
[1900835] = {id = 1900835, text = ""}
, 
[1900836] = {id = 1900836, text = ""}
, 
[1900837] = {id = 1900837, text = ""}
, 
[1900838] = {id = 1900838, text = ""}
, 
[1900839] = {id = 1900839, text = ""}
, 
[1900840] = {id = 1900840, text = ""}
, 
[1900841] = {id = 1900841, text = ""}
, 
[1900842] = {id = 1900842, text = ""}
, 
[1900843] = {id = 1900843, text = ""}
, 
[1900844] = {id = 1900844, text = ""}
, 
[1900845] = {id = 1900845, text = ""}
, 
[1900846] = {id = 1900846, text = ""}
, 
[1900847] = {id = 1900847, text = ""}
, 
[1900848] = {id = 1900848, text = ""}
, 
[1900849] = {id = 1900849, text = ""}
, 
[1900850] = {id = 1900850, text = ""}
, 
[1900851] = {id = 1900851, text = ""}
, 
[1900852] = {id = 1900852, text = ""}
, 
[1900853] = {id = 1900853, text = ""}
, 
[1900854] = {id = 1900854, text = ""}
, 
[1900855] = {id = 1900855, text = ""}
, 
[1900856] = {id = 1900856, text = ""}
, 
[1900857] = {id = 1900857, text = ""}
, 
[1900858] = {id = 1900858, text = ""}
, 
[1900859] = {id = 1900859, text = ""}
, 
[1900860] = {id = 1900860, text = ""}
, 
[1900861] = {id = 1900861, text = ""}
, 
[1900862] = {id = 1900862, text = ""}
, 
[1900863] = {id = 1900863, text = ""}
, 
[1900864] = {id = 1900864, text = ""}
, 
[1900865] = {id = 1900865, text = ""}
, 
[1900866] = {id = 1900866, text = ""}
, 
[1900867] = {id = 1900867, text = ""}
, 
[1900868] = {id = 1900868, text = ""}
, 
[1900869] = {id = 1900869, text = ""}
, 
[1900870] = {id = 1900870, text = ""}
, 
[1900871] = {id = 1900871, text = ""}
, 
[1900872] = {id = 1900872, text = ""}
, 
[1900873] = {id = 1900873, text = ""}
, 
[1900874] = {id = 1900874, text = ""}
, 
[1900875] = {id = 1900875, text = ""}
, 
[1900876] = {id = 1900876, text = ""}
, 
[1900877] = {id = 1900877, text = ""}
, 
[1900878] = {id = 1900878, text = ""}
, 
[1900879] = {id = 1900879, text = ""}
, 
[1900880] = {id = 1900880, text = ""}
, 
[1900881] = {id = 1900881, text = ""}
, 
[1900882] = {id = 1900882, text = ""}
, 
[1900883] = {id = 1900883, text = "Magique Augment"}
, 
[1900884] = {id = 1900884, text = ""}
, 
[1900885] = {id = 1900885, text = ""}
, 
[1900886] = {id = 1900886, text = ""}
, 
[1900887] = {id = 1900887, text = ""}
, 
[1900888] = {id = 1900888, text = ""}
, 
[1900889] = {id = 1900889, text = ""}
, 
[1900890] = {id = 1900890, text = ""}
, 
[1900891] = {id = 1900891, text = ""}
, 
[1900892] = {id = 1900892, text = ""}
, 
[1900893] = {id = 1900893, text = ""}
, 
[1900894] = {id = 1900894, text = ""}
, 
[1900895] = {id = 1900895, text = ""}
, 
[1900896] = {id = 1900896, text = ""}
, 
[1900897] = {id = 1900897, text = ""}
, 
[1900898] = {id = 1900898, text = ""}
, 
[1900899] = {id = 1900899, text = ""}
, 
[1900900] = {id = 1900900, text = ""}
, 
[1900901] = {id = 1900901, text = ""}
, 
[1900902] = {id = 1900902, text = ""}
, 
[1900903] = {id = 1900903, text = ""}
, 
[1900904] = {id = 1900904, text = ""}
, 
[1900905] = {id = 1900905, text = ""}
, 
[1900906] = {id = 1900906, text = "Flare the Priest"}
, 
[1900907] = {id = 1900907, text = "Phrygia the Chevalier"}
, 
[1900908] = {id = 1900908, text = ""}
, 
[1900909] = {id = 1900909, text = ""}
, 
[1900910] = {id = 1900910, text = ""}
, 
[1900911] = {id = 1900911, text = ""}
, 
[1900912] = {id = 1900912, text = ""}
, 
[1900913] = {id = 1900913, text = ""}
, 
[1900914] = {id = 1900914, text = ""}
, 
[1900915] = {id = 1900915, text = ""}
, 
[1900916] = {id = 1900916, text = ""}
, 
[1900917] = {id = 1900917, text = ""}
, 
[1900918] = {id = 1900918, text = ""}
, 
[1900919] = {id = 1900919, text = ""}
, 
[1900920] = {id = 1900920, text = ""}
, 
[1900921] = {id = 1900921, text = ""}
, 
[1900922] = {id = 1900922, text = ""}
, 
[1900923] = {id = 1900923, text = ""}
, 
[1900924] = {id = 1900924, text = ""}
, 
[1900925] = {id = 1900925, text = ""}
, 
[1900926] = {id = 1900926, text = ""}
, 
[1900927] = {id = 1900927, text = ""}
, 
[1900928] = {id = 1900928, text = ""}
, 
[1900929] = {id = 1900929, text = ""}
, 
[1900930] = {id = 1900930, text = ""}
, 
[1900931] = {id = 1900931, text = ""}
, 
[1900932] = {id = 1900932, text = ""}
, 
[1900933] = {id = 1900933, text = ""}
, 
[1900934] = {id = 1900934, text = ""}
, 
[1900935] = {id = 1900935, text = ""}
, 
[1900936] = {id = 1900936, text = ""}
, 
[1900937] = {id = 1900937, text = ""}
, 
[1900938] = {id = 1900938, text = ""}
, 
[1900939] = {id = 1900939, text = ""}
, 
[1900940] = {id = 1900940, text = ""}
, 
[1900941] = {id = 1900941, text = ""}
, 
[1900942] = {id = 1900942, text = ""}
, 
[1900943] = {id = 1900943, text = ""}
, 
[1900944] = {id = 1900944, text = ""}
, 
[1900945] = {id = 1900945, text = ""}
, 
[1900946] = {id = 1900946, text = ""}
, 
[1900947] = {id = 1900947, text = ""}
, 
[1900948] = {id = 1900948, text = ""}
, 
[1900949] = {id = 1900949, text = ""}
, 
[1900950] = {id = 1900950, text = ""}
, 
[1900951] = {id = 1900951, text = ""}
, 
[1900952] = {id = 1900952, text = ""}
, 
[1900953] = {id = 1900953, text = ""}
, 
[1900954] = {id = 1900954, text = ""}
, 
[1900955] = {id = 1900955, text = ""}
, 
[1900956] = {id = 1900956, text = ""}
, 
[1900957] = {id = 1900957, text = ""}
, 
[1900958] = {id = 1900958, text = ""}
, 
[1900959] = {id = 1900959, text = ""}
, 
[1900960] = {id = 1900960, text = ""}
, 
[1900961] = {id = 1900961, text = ""}
, 
[1900962] = {id = 1900962, text = ""}
, 
[1900963] = {id = 1900963, text = ""}
, 
[1900964] = {id = 1900964, text = ""}
, 
[1900965] = {id = 1900965, text = ""}
, 
[1900966] = {id = 1900966, text = ""}
, 
[1900967] = {id = 1900967, text = ""}
, 
[1900968] = {id = 1900968, text = ""}
, 
[1900969] = {id = 1900969, text = ""}
, 
[1900970] = {id = 1900970, text = ""}
, 
[1900971] = {id = 1900971, text = ""}
, 
[1900972] = {id = 1900972, text = ""}
, 
[1900973] = {id = 1900973, text = ""}
, 
[1900974] = {id = 1900974, text = ""}
, 
[1900975] = {id = 1900975, text = ""}
, 
[1900976] = {id = 1900976, text = ""}
, 
[1900977] = {id = 1900977, text = ""}
, 
[1900978] = {id = 1900978, text = ""}
, 
[1900979] = {id = 1900979, text = ""}
, 
[1900980] = {id = 1900980, text = ""}
, 
[1900981] = {id = 1900981, text = ""}
, 
[1900982] = {id = 1900982, text = ""}
, 
[1900983] = {id = 1900983, text = ""}
, 
[1900984] = {id = 1900984, text = ""}
, 
[1900985] = {id = 1900985, text = ""}
, 
[1900986] = {id = 1900986, text = ""}
, 
[1900987] = {id = 1900987, text = ""}
, 
[1900988] = {id = 1900988, text = ""}
, 
[1900989] = {id = 1900989, text = ""}
, 
[1900990] = {id = 1900990, text = ""}
, 
[1900991] = {id = 1900991, text = ""}
, 
[1900992] = {id = 1900992, text = ""}
, 
[1900993] = {id = 1900993, text = ""}
, 
[1900994] = {id = 1900994, text = ""}
, 
[1900995] = {id = 1900995, text = ""}
, 
[1900996] = {id = 1900996, text = ""}
, 
[1900997] = {id = 1900997, text = ""}
, 
[1900998] = {id = 1900998, text = ""}
, 
[1900999] = {id = 1900999, text = ""}
, 
[1901000] = {id = 1901000, text = ""}
, 
[1901001] = {id = 1901001, text = ""}
, 
[1901002] = {id = 1901002, text = ""}
, 
[1901003] = {id = 1901003, text = ""}
, 
[1901004] = {id = 1901004, text = ""}
, 
[1901005] = {id = 1901005, text = ""}
, 
[1901006] = {id = 1901006, text = ""}
, 
[1901007] = {id = 1901007, text = ""}
, 
[1901008] = {id = 1901008, text = ""}
, 
[1901009] = {id = 1901009, text = ""}
, 
[1901010] = {id = 1901010, text = ""}
, 
[1901011] = {id = 1901011, text = ""}
, 
[1901012] = {id = 1901012, text = ""}
, 
[1901013] = {id = 1901013, text = ""}
, 
[1901014] = {id = 1901014, text = ""}
, 
[1901015] = {id = 1901015, text = ""}
, 
[1901016] = {id = 1901016, text = ""}
, 
[1901017] = {id = 1901017, text = ""}
, 
[1901018] = {id = 1901018, text = ""}
, 
[1901019] = {id = 1901019, text = ""}
, 
[1901020] = {id = 1901020, text = ""}
, 
[1901021] = {id = 1901021, text = ""}
, 
[1901022] = {id = 1901022, text = ""}
, 
[1901023] = {id = 1901023, text = ""}
, 
[1901024] = {id = 1901024, text = ""}
, 
[1901025] = {id = 1901025, text = ""}
, 
[1901026] = {id = 1901026, text = ""}
, 
[1901027] = {id = 1901027, text = ""}
, 
[1901028] = {id = 1901028, text = ""}
, 
[1901029] = {id = 1901029, text = ""}
, 
[1901030] = {id = 1901030, text = ""}
, 
[1901031] = {id = 1901031, text = ""}
, 
[1901032] = {id = 1901032, text = ""}
, 
[1901033] = {id = 1901033, text = ""}
, 
[1901034] = {id = 1901034, text = ""}
, 
[1901035] = {id = 1901035, text = ""}
, 
[1901036] = {id = 1901036, text = ""}
, 
[1901037] = {id = 1901037, text = ""}
, 
[1901038] = {id = 1901038, text = ""}
, 
[1901039] = {id = 1901039, text = ""}
, 
[1901040] = {id = 1901040, text = ""}
, 
[1901041] = {id = 1901041, text = ""}
, 
[1901042] = {id = 1901042, text = ""}
, 
[1901043] = {id = 1901043, text = ""}
, 
[1901044] = {id = 1901044, text = ""}
, 
[1901045] = {id = 1901045, text = ""}
, 
[1901046] = {id = 1901046, text = ""}
, 
[1901047] = {id = 1901047, text = ""}
, 
[1901048] = {id = 1901048, text = ""}
, 
[1901049] = {id = 1901049, text = ""}
, 
[1901050] = {id = 1901050, text = ""}
, 
[1901051] = {id = 1901051, text = ""}
, 
[1901052] = {id = 1901052, text = ""}
, 
[1901053] = {id = 1901053, text = ""}
, 
[1901054] = {id = 1901054, text = ""}
, 
[1901055] = {id = 1901055, text = ""}
, 
[1901056] = {id = 1901056, text = ""}
, 
[1901057] = {id = 1901057, text = ""}
, 
[1901058] = {id = 1901058, text = ""}
, 
[1901059] = {id = 1901059, text = ""}
, 
[1901060] = {id = 1901060, text = ""}
, 
[1901061] = {id = 1901061, text = ""}
, 
[1901062] = {id = 1901062, text = ""}
, 
[1901063] = {id = 1901063, text = ""}
, 
[1901064] = {id = 1901064, text = ""}
, 
[1901065] = {id = 1901065, text = ""}
, 
[1901066] = {id = 1901066, text = ""}
, 
[1901067] = {id = 1901067, text = ""}
, 
[1901068] = {id = 1901068, text = ""}
, 
[1901069] = {id = 1901069, text = ""}
, 
[1901070] = {id = 1901070, text = ""}
, 
[1901071] = {id = 1901071, text = ""}
, 
[1901072] = {id = 1901072, text = ""}
, 
[1901073] = {id = 1901073, text = ""}
, 
[1901074] = {id = 1901074, text = ""}
, 
[1901075] = {id = 1901075, text = ""}
, 
[1901076] = {id = 1901076, text = ""}
, 
[1901077] = {id = 1901077, text = ""}
, 
[1901078] = {id = 1901078, text = ""}
, 
[1901079] = {id = 1901079, text = ""}
, 
[1901080] = {id = 1901080, text = ""}
, 
[1901081] = {id = 1901081, text = ""}
, 
[1901082] = {id = 1901082, text = ""}
, 
[1901083] = {id = 1901083, text = ""}
, 
[1901084] = {id = 1901084, text = ""}
, 
[1901085] = {id = 1901085, text = ""}
, 
[1901086] = {id = 1901086, text = ""}
, 
[1901087] = {id = 1901087, text = ""}
, 
[1901088] = {id = 1901088, text = ""}
, 
[1901089] = {id = 1901089, text = ""}
, 
[1901090] = {id = 1901090, text = ""}
, 
[1901091] = {id = 1901091, text = ""}
, 
[1901092] = {id = 1901092, text = ""}
, 
[1901093] = {id = 1901093, text = ""}
, 
[1901094] = {id = 1901094, text = ""}
, 
[1901095] = {id = 1901095, text = ""}
, 
[1901096] = {id = 1901096, text = ""}
, 
[1901097] = {id = 1901097, text = ""}
, 
[1901098] = {id = 1901098, text = ""}
, 
[1901099] = {id = 1901099, text = ""}
, 
[1901100] = {id = 1901100, text = ""}
, 
[1901101] = {id = 1901101, text = ""}
, 
[1901102] = {id = 1901102, text = ""}
, 
[1901103] = {id = 1901103, text = ""}
, 
[1901104] = {id = 1901104, text = ""}
, 
[1901105] = {id = 1901105, text = ""}
, 
[1901106] = {id = 1901106, text = ""}
, 
[1901107] = {id = 1901107, text = ""}
, 
[1901108] = {id = 1901108, text = ""}
, 
[1901109] = {id = 1901109, text = ""}
, 
[1901110] = {id = 1901110, text = ""}
, 
[1901111] = {id = 1901111, text = ""}
, 
[1901112] = {id = 1901112, text = ""}
, 
[1901113] = {id = 1901113, text = ""}
, 
[1901114] = {id = 1901114, text = ""}
, 
[1901115] = {id = 1901115, text = ""}
, 
[1901116] = {id = 1901116, text = ""}
, 
[1901117] = {id = 1901117, text = ""}
, 
[1901118] = {id = 1901118, text = ""}
, 
[1901119] = {id = 1901119, text = ""}
, 
[1901120] = {id = 1901120, text = ""}
, 
[1901121] = {id = 1901121, text = ""}
, 
[1901122] = {id = 1901122, text = ""}
, 
[1901123] = {id = 1901123, text = ""}
, 
[1901124] = {id = 1901124, text = ""}
, 
[1901125] = {id = 1901125, text = ""}
, 
[1901126] = {id = 1901126, text = ""}
, 
[1901127] = {id = 1901127, text = ""}
, 
[1901128] = {id = 1901128, text = ""}
, 
[1901129] = {id = 1901129, text = ""}
, 
[1901130] = {id = 1901130, text = ""}
, 
[1901131] = {id = 1901131, text = ""}
, 
[1901132] = {id = 1901132, text = ""}
, 
[1901133] = {id = 1901133, text = ""}
, 
[1901134] = {id = 1901134, text = ""}
, 
[1901135] = {id = 1901135, text = ""}
, 
[1901136] = {id = 1901136, text = ""}
, 
[1901137] = {id = 1901137, text = ""}
, 
[1901138] = {id = 1901138, text = ""}
, 
[1901139] = {id = 1901139, text = ""}
, 
[1901140] = {id = 1901140, text = ""}
, 
[1901141] = {id = 1901141, text = ""}
, 
[1901142] = {id = 1901142, text = ""}
, 
[1901143] = {id = 1901143, text = ""}
, 
[1901144] = {id = 1901144, text = ""}
, 
[1901145] = {id = 1901145, text = ""}
, 
[1901146] = {id = 1901146, text = ""}
, 
[1901147] = {id = 1901147, text = ""}
, 
[1901148] = {id = 1901148, text = ""}
, 
[1901149] = {id = 1901149, text = ""}
, 
[1901150] = {id = 1901150, text = ""}
, 
[1901151] = {id = 1901151, text = ""}
, 
[1901152] = {id = 1901152, text = ""}
, 
[1901153] = {id = 1901153, text = ""}
, 
[1901154] = {id = 1901154, text = ""}
, 
[1901155] = {id = 1901155, text = ""}
, 
[1901156] = {id = 1901156, text = ""}
, 
[1901157] = {id = 1901157, text = ""}
, 
[1901158] = {id = 1901158, text = ""}
, 
[1901159] = {id = 1901159, text = ""}
, 
[1901160] = {id = 1901160, text = ""}
, 
[1901161] = {id = 1901161, text = ""}
, 
[1901162] = {id = 1901162, text = ""}
, 
[1901163] = {id = 1901163, text = ""}
, 
[1901164] = {id = 1901164, text = ""}
, 
[1901165] = {id = 1901165, text = ""}
, 
[1901166] = {id = 1901166, text = ""}
, 
[1901167] = {id = 1901167, text = ""}
, 
[1901168] = {id = 1901168, text = ""}
, 
[1901169] = {id = 1901169, text = ""}
, 
[1901170] = {id = 1901170, text = ""}
, 
[1901171] = {id = 1901171, text = ""}
, 
[1901172] = {id = 1901172, text = ""}
, 
[1901173] = {id = 1901173, text = ""}
, 
[1901174] = {id = 1901174, text = ""}
, 
[1901175] = {id = 1901175, text = ""}
, 
[1901176] = {id = 1901176, text = ""}
, 
[1901177] = {id = 1901177, text = ""}
, 
[1901178] = {id = 1901178, text = ""}
, 
[1901179] = {id = 1901179, text = ""}
, 
[1901180] = {id = 1901180, text = ""}
, 
[1901181] = {id = 1901181, text = ""}
, 
[1901182] = {id = 1901182, text = ""}
, 
[1901183] = {id = 1901183, text = ""}
, 
[1901184] = {id = 1901184, text = ""}
, 
[1901185] = {id = 1901185, text = ""}
, 
[1901186] = {id = 1901186, text = ""}
, 
[1901187] = {id = 1901187, text = ""}
, 
[1901188] = {id = 1901188, text = ""}
, 
[1901189] = {id = 1901189, text = ""}
}
cworddungeonselect_en.AllIds = {1900001, 1900002, 1900003, 1900004, 1900005, 1900006, 1900007, 1900008, 1900009, 1900010, 1900011, 1900012, 1900013, 1900014, 1900015, 1900016, 1900017, 1900018, 1900019, 1900020, 1900021, 1900022, 1900023, 1900024, 1900025, 1900026, 1900027, 1900028, 1900029, 1900030, 1900031, 1900032, 1900033, 1900034, 1900035, 1900036, 1900037, 1900038, 1900039, 1900040, 1900041, 1900042, 1900043, 1900044, 1900045, 1900046, 1900047, 1900048, 1900049, 1900050, 1900051, 1900052, 1900053, 1900054, 1900055, 1900056, 1900057, 1900058, 1900059, 1900060, 1900061, 1900062, 1900063, 1900064, 1900065, 1900066, 1900067, 1900068, 1900069, 1900070, 1900071, 1900072, 1900073, 1900074, 1900075, 1900076, 1900077, 1900078, 1900079, 1900080, 1900081, 1900082, 1900083, 1900084, 1900085, 1900086, 1900087, 1900088, 1900089, 1900090, 1900091, 1900092, 1900093, 1900094, 1900095, 1900096, 1900097, 1900098, 1900099, 1900100, 1900101, 1900102, 1900103, 1900104, 1900105, 1900106, 1900107, 1900108, 1900109, 1900110, 1900111, 1900112, 1900113, 1900114, 1900115, 1900116, 1900117, 1900118, 1900119, 1900120, 1900121, 1900122, 1900123, 1900124, 1900125, 1900126, 1900127, 1900128, 1900129, 1900130, 1900131, 1900132, 1900133, 1900134, 1900135, 1900136, 1900137, 1900138, 1900139, 1900140, 1900141, 1900142, 1900148, 1900149, 1900150, 1900151, 1900152, 1900153, 1900154, 1900155, 1900156, 1900157, 1900158, 1900159, 1900160, 1900161, 1900162, 1900163, 1900164, 1900165, 1900166, 1900167, 1900168, 1900169, 1900170, 1900171, 1900172, 1900173, 1900174, 1900175, 1900176, 1900177, 1900178, 1900179, 1900180, 1900181, 1900182, 1900183, 1900184, 1900185, 1900186, 1900187, 1900188, 1900189, 1900190, 1900191, 1900192, 1900193, 1900194, 1900195, 1900196, 1900197, 1900198, 1900199, 1900200, 1900201, 1900202, 1900203, 1900204, 1900205, 1900206, 1900207, 1900208, 1900209, 1900219, 1900220, 1900221, 1900222, 1900223, 1900224, 1900236, 1900238, 1900239, 1900240, 1900241, 1900242, 1900243, 1900244, 1900251, 1900252, 1900253, 1900254, 1900255, 1900257, 1900259, 1900266, 1900268, 1900269, 1900270, 1900271, 1900272, 1900273, 1900274, 1900275, 1900276, 1900277, 1900278, 1900279, 1900280, 1900281, 1900282, 1900283, 1900284, 1900285, 1900286, 1900287, 1900288, 1900289, 1900290, 1900291, 1900292, 1900293, 1900294, 1900295, 1900296, 1900297, 1900298, 1900299, 1900300, 1900301, 1900302, 1900303, 1900304, 1900305, 1900306, 1900307, 1900308, 1900309, 1900310, 1900311, 1900312, 1900313, 1900314, 1900315, 1900316, 1900317, 1900318, 1900319, 1900320, 1900347, 1900348, 1900349, 1900350, 1900351, 1900352, 1900353, 1900354, 1900355, 1900356, 1900357, 1900358, 1900359, 1900360, 1900361, 1900362, 1900363, 1900364, 1900365, 1900366, 1900367, 1900368, 1900369, 1900370, 1900371, 1900372, 1900373, 1900374, 1900375, 1900376, 1900377, 1900378, 1900379, 1900380, 1900381, 1900382, 1900383, 1900384, 1900385, 1900386, 1900387, 1900388, 1900389, 1900390, 1900391, 1900392, 1900393, 1900394, 1900395, 1900396, 1900397, 1900398, 1900399, 1900400, 1900401, 1900402, 1900404, 1900405, 1900406, 1900407, 1900408, 1900409, 1900410, 1900411, 1900412, 1900413, 1900414, 1900415, 1900416, 1900417, 1900418, 1900419, 1900420, 1900421, 1900422, 1900423, 1900424, 1900425, 1900426, 1900427, 1900428, 1900429, 1900430, 1900437, 1900438, 1900439, 1900440, 1900441, 1900442, 1900443, 1900444, 1900445, 1900446, 1900447, 1900448, 1900449, 1900450, 1900451, 1900452, 1900453, 1900454, 1900455, 1900456, 1900457, 1900458, 1900459, 1900460, 1900461, 1900462, 1900463, 1900464, 1900466, 1900467, 1900468, 1900469, 1900470, 1900471, 1900472, 1900475, 1900476, 1900477, 1900478, 1900479, 1900480, 1900481, 1900482, 1900483, 1900484, 1900485, 1900486, 1900487, 1900488, 1900489, 1900490, 1900491, 1900492, 1900493, 1900494, 1900495, 1900496, 1900497, 1900498, 1900499, 1900500, 1900501, 1900502, 1900503, 1900504, 1900505, 1900506, 1900507, 1900508, 1900509, 1900510, 1900511, 1900512, 1900513, 1900514, 1900515, 1900516, 1900517, 1900518, 1900519, 1900520, 1900521, 1900522, 1900523, 1900524, 1900525, 1900526, 1900527, 1900528, 1900529, 1900530, 1900531, 1900532, 1900533, 1900534, 1900535, 1900536, 1900537, 1900538, 1900539, 1900540, 1900541, 1900542, 1900543, 1900544, 1900545, 1900546, 1900547, 1900548, 1900549, 1900550, 1900551, 1900552, 1900553, 1900554, 1900555, 1900556, 1900557, 1900558, 1900559, 1900560, 1900561, 1900562, 1900563, 1900564, 1900565, 1900566, 1900567, 1900568, 1900569, 1900570, 1900571, 1900572, 1900573, 1900574, 1900575, 1900576, 1900577, 1900578, 1900579, 1900580, 1900581, 1900582, 1900583, 1900584, 1900585, 1900586, 1900587, 1900588, 1900589, 1900590, 1900591, 1900592, 1900593, 1900594, 1900595, 1900596, 1900597, 1900598, 1900599, 1900600, 1900601, 1900602, 1900603, 1900604, 1900605, 1900606, 1900607, 1900608, 1900609, 1900610, 1900611, 1900612, 1900613, 1900614, 1900615, 1900616, 1900617, 1900618, 1900619, 1900620, 1900621, 1900622, 1900623, 1900624, 1900625, 1900626, 1900627, 1900628, 1900629, 1900630, 1900631, 1900632, 1900633, 1900634, 1900635, 1900636, 1900637, 1900638, 1900639, 1900640, 1900641, 1900642, 1900643, 1900644, 1900645, 1900646, 1900647, 1900648, 1900649, 1900650, 1900651, 1900652, 1900653, 1900654, 1900655, 1900656, 1900657, 1900658, 1900659, 1900660, 1900662, 1900663, 1900664, 1900665, 1900666, 1900667, 1900668, 1900669, 1900670, 1900671, 1900672, 1900673, 1900674, 1900675, 1900676, 1900677, 1900678, 1900679, 1900680, 1900681, 1900682, 1900683, 1900684, 1900685, 1900686, 1900687, 1900688, 1900689, 1900690, 1900691, 1900692, 1900693, 1900694, 1900695, 1900696, 1900697, 1900698, 1900699, 1900700, 1900701, 1900702, 1900703, 1900704, 1900705, 1900706, 1900707, 1900708, 1900709, 1900710, 1900711, 1900712, 1900713, 1900714, 1900715, 1900716, 1900717, 1900718, 1900719, 1900720, 1900721, 1900722, 1900723, 1900724, 1900725, 1900726, 1900727, 1900728, 1900729, 1900730, 1900731, 1900732, 1900733, 1900734, 1900735, 1900736, 1900737, 1900738, 1900739, 1900740, 1900741, 1900742, 1900743, 1900744, 1900745, 1900746, 1900747, 1900748, 1900749, 1900750, 1900751, 1900752, 1900753, 1900754, 1900755, 1900756, 1900757, 1900758, 1900759, 1900760, 1900761, 1900762, 1900763, 1900764, 1900765, 1900766, 1900767, 1900768, 1900769, 1900770, 1900771, 1900772, 1900773, 1900774, 1900775, 1900776, 1900777, 1900778, 1900779, 1900780, 1900781, 1900782, 1900783, 1900784, 1900785, 1900786, 1900787, 1900788, 1900789, 1900790, 1900791, 1900792, 1900793, 1900794, 1900795, 1900796, 1900797, 1900798, 1900799, 1900800, 1900801, 1900802, 1900803, 1900804, 1900805, 1900806, 1900807, 1900808, 1900809, 1900810, 1900811, 1900812, 1900813, 1900814, 1900815, 1900816, 1900817, 1900818, 1900819, 1900820, 1900821, 1900822, 1900823, 1900824, 1900825, 1900826, 1900827, 1900828, 1900829, 1900830, 1900831, 1900832, 1900833, 1900834, 1900835, 1900836, 1900837, 1900838, 1900839, 1900840, 1900841, 1900842, 1900843, 1900844, 1900845, 1900846, 1900847, 1900848, 1900849, 1900850, 1900851, 1900852, 1900853, 1900854, 1900855, 1900856, 1900857, 1900858, 1900859, 1900860, 1900861, 1900862, 1900863, 1900864, 1900865, 1900866, 1900867, 1900868, 1900869, 1900870, 1900871, 1900872, 1900873, 1900874, 1900875, 1900876, 1900877, 1900878, 1900879, 1900880, 1900881, 1900882, 1900883, 1900884, 1900885, 1900886, 1900887, 1900888, 1900889, 1900890, 1900891, 1900892, 1900893, 1900894, 1900895, 1900896, 1900897, 1900898, 1900899, 1900900, 1900901, 1900902, 1900903, 1900904, 1900905, 1900906, 1900907, 1900908, 1900909, 1900910, 1900911, 1900912, 1900913, 1900914, 1900915, 1900916, 1900917, 1900918, 1900919, 1900920, 1900921, 1900922, 1900923, 1900924, 1900925, 1900926, 1900927, 1900928, 1900929, 1900930, 1900931, 1900932, 1900933, 1900934, 1900935, 1900936, 1900937, 1900938, 1900939, 1900940, 1900941, 1900942, 1900943, 1900944, 1900945, 1900946, 1900947, 1900948, 1900949, 1900950, 1900951, 1900952, 1900953, 1900954, 1900955, 1900956, 1900957, 1900958, 1900959, 1900960, 1900961, 1900962, 1900963, 1900964, 1900965, 1900966, 1900967, 1900968, 1900969, 1900970, 1900971, 1900972, 1900973, 1900974, 1900975, 1900976, 1900977, 1900978, 1900979, 1900980, 1900981, 1900982, 1900983, 1900984, 1900985, 1900986, 1900987, 1900988, 1900989, 1900990, 1900991, 1900992, 1900993, 1900994, 1900995, 1900996, 1900997, 1900998, 1900999, 1901000, 1901001, 1901002, 1901003, 1901004, 1901005, 1901006, 1901007, 1901008, 1901009, 1901010, 1901011, 1901012, 1901013, 1901014, 1901015, 1901016, 1901017, 1901018, 1901019, 1901020, 1901021, 1901022, 1901023, 1901024, 1901025, 1901026, 1901027, 1901028, 1901029, 1901030, 1901031, 1901032, 1901033, 1901034, 1901035, 1901036, 1901037, 1901038, 1901039, 1901040, 1901041, 1901042, 1901043, 1901044, 1901045, 1901046, 1901047, 1901048, 1901049, 1901050, 1901051, 1901052, 1901053, 1901054, 1901055, 1901056, 1901057, 1901058, 1901059, 1901060, 1901061, 1901062, 1901063, 1901064, 1901065, 1901066, 1901067, 1901068, 1901069, 1901070, 1901071, 1901072, 1901073, 1901074, 1901075, 1901076, 1901077, 1901078, 1901079, 1901080, 1901081, 1901082, 1901083, 1901084, 1901085, 1901086, 1901087, 1901088, 1901089, 1901090, 1901091, 1901092, 1901093, 1901094, 1901095, 1901096, 1901097, 1901098, 1901099, 1901100, 1901101, 1901102, 1901103, 1901104, 1901105, 1901106, 1901107, 1901108, 1901109, 1901110, 1901111, 1901112, 1901113, 1901114, 1901115, 1901116, 1901117, 1901118, 1901119, 1901120, 1901121, 1901122, 1901123, 1901124, 1901125, 1901126, 1901127, 1901128, 1901129, 1901130, 1901131, 1901132, 1901133, 1901134, 1901135, 1901136, 1901137, 1901138, 1901139, 1901140, 1901141, 1901142, 1901143, 1901144, 1901145, 1901146, 1901147, 1901148, 1901149, 1901150, 1901151, 1901152, 1901153, 1901154, 1901155, 1901156, 1901157, 1901158, 1901159, 1901160, 1901161, 1901162, 1901163, 1901164, 1901165, 1901166, 1901167, 1901168, 1901169, 1901170, 1901171, 1901172, 1901173, 1901174, 1901175, 1901176, 1901177, 1901178, 1901179, 1901180, 1901181, 1901182, 1901183, 1901184, 1901185, 1901186, 1901187, 1901188, 1901189}
return cworddungeonselect_en

