-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/word/cwordtask_en.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cwordtask_en = {}
cwordtask_en.Data = {
[1000001] = {id = 1000001, text = "Collect the Mirror Shards"}
, 
[1000002] = {id = 1000002, text = "To the Hall of Irminsul"}
, 
[1000004] = {id = 1000004, text = "Mysterious Giant Tree"}
, 
[1000006] = {id = 1000006, text = "Frog and Butterfly: Encounter"}
, 
[1000009] = {id = 1000009, text = "Frog and Butterfly: Pot"}
, 
[1000010] = {id = 1000010, text = "Frog and Butterfly: Wand"}
, 
[1000013] = {id = 1000013, text = "Frog and Butterfly: Return"}
, 
[1000015] = {id = 1000015, text = "Explore the Chrono Tower"}
, 
[1000016] = {id = 1000016, text = "To Snegurochka"}
, 
[1000017] = {id = 1000017, text = "Look around"}
, 
[1000018] = {id = 1000018, text = "Blizzard Rest"}
, 
[1000019] = {id = 1000019, text = "Defeat Saintess Cersivey"}
, 
[1000020] = {id = 1000020, text = "Hunting Altercation: Message"}
, 
[1000021] = {id = 1000021, text = "Hunting Altercation: Reconciliation"}
, 
[1000022] = {id = 1000022, text = "Disaster of the Wolves: Persuasion"}
, 
[1000023] = {id = 1000023, text = "Find Anemone"}
, 
[1000024] = {id = 1000024, text = "Continue Exploring Chrono Tower"}
, 
[1000025] = {id = 1000025, text = "Search for Dejase"}
, 
[1000026] = {id = 1000026, text = "Return to Snegurochka"}
, 
[1000027] = {id = 1000027, text = "Search Around"}
, 
[1000028] = {id = 1000028, text = "Cause of the Blizzard"}
, 
[1000029] = {id = 1000029, text = "Check Outside the Boundary"}
, 
[1000030] = {id = 1000030, text = "Investigate Foothills Hunting Grounds"}
, 
[1000031] = {id = 1000031, text = "Enter the Boundary"}
, 
[1000032] = {id = 1000032, text = "Explore the Boundary Warily"}
, 
[1000033] = {id = 1000033, text = "Source of the Geothermy"}
, 
[1000034] = {id = 1000034, text = "Site Where Monsters Appeared"}
, 
[1000035] = {id = 1000035, text = "Catch Up with Cersivey"}
, 
[1000036] = {id = 1000036, text = "Search for Clues about Frost of Absolute Zero"}
, 
[1000037] = {id = 1000037, text = "Make Frost of Absolute Zero"}
, 
[1000038] = {id = 1000038, text = "Stop Sinmara"}
, 
[1000039] = {id = 1000039, text = "Continue Exploring Chrono Tower"}
, 
[1000040] = {id = 1000040, text = "Brothers: Search"}
, 
[1000041] = {id = 1000041, text = "Soleil\'s Songbook: Search"}
, 
[1000042] = {id = 1000042, text = "Precious Things: Armor"}
, 
[1000043] = {id = 1000043, text = "Soleil\'s Songbook: Anomaly"}
, 
[1000044] = {id = 1000044, text = "Precious Things: Gold and Silver"}
, 
[1000045] = {id = 1000045, text = "Precious Things: Homeland"}
, 
[1000046] = {id = 1000046, text = "Precious Things"}
, 
[1000047] = {id = 1000047, text = "Brothers: Return Letter"}
, 
[1000048] = {id = 1000048, text = "Search for Wood"}
, 
[1000049] = {id = 1000049, text = "Discipline the Grain Thieves"}
, 
[1000050] = {id = 1000050, text = "Return the Luggage"}
, 
[1000051] = {id = 1000051, text = "Wounded Wolf Cub"}
, 
[1000052] = {id = 1000052, text = "Escort the Hunter: Search for the White Bear"}
, 
[1000053] = {id = 1000053, text = "Escort the Hunter: Drive out the White Bear"}
, 
[1000054] = {id = 1000054, text = "Return the Hunting Bow"}
, 
[1000055] = {id = 1000055, text = "The Homesick Wolf Cub"}
, 
[1000056] = {id = 1000056, text = "Stored Food"}
, 
[1000057] = {id = 1000057, text = "Chrono Tower"}
, 
[1000058] = {id = 1000058, text = "Chrono Tower: Hall of Irminsul"}
, 
[1000059] = {id = 1000059, text = "0"}
, 
[1000060] = {id = 1000060, text = "Irminsul: Giant Tree"}
, 
[1000061] = {id = 1000061, text = "Irminsul: Forest Entrance"}
, 
[1000062] = {id = 1000062, text = "Irminsul: Riverside Path"}
, 
[1000063] = {id = 1000063, text = "Irminsul: Sacrificial Altar"}
, 
[1000065] = {id = 1000065, text = "Irminsul: Giant Tree Periphery"}
, 
[1000066] = {id = 1000066, text = "Snegurochka"}
, 
[1000067] = {id = 1000067, text = "Snegurochka Mountain Peak"}
, 
[1000068] = {id = 1000068, text = "Snegurochka: Saintess Square"}
, 
[1000069] = {id = 1000069, text = "Snegurochka: Southern Outskirts Tundra"}
, 
[1000070] = {id = 1000070, text = "Snegurochka: Frozen Lake Hunting Grounds (Middle)"}
, 
[1000071] = {id = 1000071, text = "Snegurochka: Hillside Tundra"}
, 
[1000072] = {id = 1000072, text = "Snegurochka: Outskirts Path"}
, 
[1000073] = {id = 1000073, text = "Snegurochka: Hillside Boundary"}
, 
[1000074] = {id = 1000074, text = "Snegurochka: Foothills Tundra"}
, 
[1000075] = {id = 1000075, text = "Snegurochka: Foothills Hunting Grounds"}
, 
[1000076] = {id = 1000076, text = "Snegurochka: Hunting Grounds Boundary"}
, 
[1000077] = {id = 1000077, text = "Snegurochka: Chivalric Order Camp"}
, 
[1000078] = {id = 1000078, text = "Snegurochka: Underground Square"}
, 
[1000079] = {id = 1000079, text = "Snegurochka: Castle Entry"}
, 
[1000080] = {id = 1000080, text = "Irminsul: Commercial Area"}
, 
[1000081] = {id = 1000081, text = "Irminsul: Sentry Camp Periphery"}
, 
[1000082] = {id = 1000082, text = "Irminsul: Commercial Area Entry"}
, 
[1000083] = {id = 1000083, text = "Irminsul: Bog"}
, 
[1000084] = {id = 1000084, text = "Irminsul: Barracks Periphery"}
, 
[1000085] = {id = 1000085, text = "Irminsul: Irene Island"}
, 
[1000086] = {id = 1000086, text = "Snegurochka: Foothills Hunting Grounds Periphery"}
, 
[1000087] = {id = 1000087, text = "Snegurochka: Western Outskirts Tundra"}
, 
[1000088] = {id = 1000088, text = "Snegurochka: Pass of Talus (End)"}
, 
[1000089] = {id = 1000089, text = "Snegurochka: Hillside Fork Road (Front)"}
, 
[1000090] = {id = 1000090, text = "Snegurochka: Frozen Lake Surface"}
, 
[1000091] = {id = 1000091, text = "Collect the Shards of the Irminsul Mirror"}
, 
[1000092] = {id = 1000092, text = "To the Hall of Irminsul"}
, 
[1000094] = {id = 1000094, text = "Find out how the Giant Tree appeared"}
, 
[1000096] = {id = 1000096, text = "Investigate the cause of the mutations"}
, 
[1000099] = {id = 1000099, text = "Help Frog Chevalier find the Pot"}
, 
[1000100] = {id = 1000100, text = "Help Frog Chevalier find the Wand"}
, 
[1000101] = {id = 1000101, text = "0"}
, 
[1000102] = {id = 1000102, text = "0"}
, 
[1000103] = {id = 1000103, text = "Return the Wand to Phrygia"}
, 
[1000105] = {id = 1000105, text = "Dangerous Exploration"}
, 
[1000106] = {id = 1000106, text = "To Snegurochka"}
, 
[1000107] = {id = 1000107, text = "Look around"}
, 
[1000108] = {id = 1000108, text = "Figure out a way to stop the blizzard at the peak"}
, 
[1000109] = {id = 1000109, text = "Defeat Saintess Cersivey"}
, 
[1000110] = {id = 1000110, text = "Deliver the Hunter\'s message to Silverbow"}
, 
[1000111] = {id = 1000111, text = "Reconcile Silverbow with the Old Hunter"}
, 
[1000112] = {id = 1000112, text = "Persuade the Leader of the Pack"}
, 
[1000113] = {id = 1000113, text = "Find Anemone"}
, 
[1000114] = {id = 1000114, text = "Continue exploring the Chrono Tower"}
, 
[1000115] = {id = 1000115, text = "Find Dejase"}
, 
[1000116] = {id = 1000116, text = "Return to Snegurochka through the Hall of Reversal"}
, 
[1000117] = {id = 1000117, text = "Search Around"}
, 
[1000118] = {id = 1000118, text = "Continue exploring Snegurochka"}
, 
[1000119] = {id = 1000119, text = "Explore around outside the Boundary"}
, 
[1000120] = {id = 1000120, text = "To the Foothills Hunting Grounds"}
, 
[1000121] = {id = 1000121, text = "Explore inside the Boundary"}
, 
[1000122] = {id = 1000122, text = "Search for clues inside the Boundary"}
, 
[1000123] = {id = 1000123, text = "Seek the source of the Geothermy"}
, 
[1000124] = {id = 1000124, text = "Go to Saintess Square"}
, 
[1000125] = {id = 1000125, text = "Go deep underground"}
, 
[1000126] = {id = 1000126, text = "Speak with the Captain of the Chivalric Order ahead"}
, 
[1000127] = {id = 1000127, text = "Find La Crima"}
, 
[1000128] = {id = 1000128, text = "Prevent the oblivion of Snegurochka"}
, 
[1000129] = {id = 1000129, text = "Continue exploring the Chrono Tower"}
, 
[1000130] = {id = 1000130, text = "Search for the little brother"}
, 
[1000131] = {id = 1000131, text = "Retrieve Soleil\'s songbook"}
, 
[1000132] = {id = 1000132, text = "Retrieve the merchant\'s armor"}
, 
[1000133] = {id = 1000133, text = "Check up on Soleil"}
, 
[1000134] = {id = 1000134, text = "Retrieve the merchant\'s gold and silver"}
, 
[1000135] = {id = 1000135, text = "Find the merchant\'s savings"}
, 
[1000136] = {id = 1000136, text = "Find the merchant\'s true hometown"}
, 
[1000137] = {id = 1000137, text = "Deliver the message to the awaiting elder brother"}
, 
[1000138] = {id = 1000138, text = "Help villager Andy find wood"}
, 
[1000139] = {id = 1000139, text = "Teach the fox thief a lesson"}
, 
[1000140] = {id = 1000140, text = "Return the luggage to Silverbow"}
, 
[1000141] = {id = 1000141, text = "Escort the wounded wolf cub back home"}
, 
[1000142] = {id = 1000142, text = "Gather information about the White Bear from Silverbow"}
, 
[1000143] = {id = 1000143, text = "Drive away the ferocious White Bear"}
, 
[1000144] = {id = 1000144, text = "Return the bow to the young hunter"}
, 
[1000145] = {id = 1000145, text = "Bring the wolf cub to the Leader of the Pack"}
, 
[1000146] = {id = 1000146, text = "Search around for the stored food"}
, 
[1000147] = {id = 1000147, text = "Shards of the Irminsul Mirror are scattered <color=#82C65D>within the tower</color>. It seems that something strange will happen when they are all collected."}
, 
[1000148] = {id = 1000148, text = "You have collected all the shards. $B$Go to the <color=#82C65D>Hall of Irminsul</color> to unravel the puzzle."}
, 
[1000150] = {id = 1000150, text = "Explore the Irminsul Woods and find out how the giant tree appeared."}
, 
[1000152] = {id = 1000152, text = "Proceed and investigate the cause of the mutations of the forest biology."}
, 
[1000155] = {id = 1000155, text = "Phrygia the Frog Chevalier has lost his beloved <color=#82C65D>Pot</color>. Keep an eye out for it during your explorations."}
, 
[1000156] = {id = 1000156, text = "Phrygia\'s <color=#82C65D>wand</color> is also missing; how careless of him! Help him find it during your journey."}
, 
[1000159] = {id = 1000159, text = "You have found the lost wand. Return it to Phrygia. He should be at the <color=#82C65D>Giant Tree Periphery</color>."}
, 
[1000161] = {id = 1000161, text = "Deluca noticed that a mysterious girl had entered the upper level of the Chrono Tower. Continue exploring up the Tower."}
, 
[1000162] = {id = 1000162, text = "Snegurochka witnessed the end of the War of Protectors. Perhaps you will find your answer there."}
, 
[1000163] = {id = 1000163, text = "You have reached Snegurochka Mountain. Take some time to look around."}
, 
[1000164] = {id = 1000164, text = "It is said the blizzard was brought about by the magic circle at the peak. Climb to the <color=#82C65D>peak</color>, and you may find a way to stop the blizzard."}
, 
[1000165] = {id = 1000165, text = "Defeat Saintess Cersivey at <color=#82C65D>Saintess Square</color> at the peak, and calm the blizzard."}
, 
[1000166] = {id = 1000166, text = "Help the wounded hunter and deliver the message to <color=#82C65D>Silverbow</color>."}
, 
[1000167] = {id = 1000167, text = "Find Silverbow at <color=#82C65D>Frozen Lake Hunting Grounds: Middle</color>, and try to reconcile Silverbow and the Old Hunter."}
, 
[1000168] = {id = 1000168, text = "There seems to be some kind of misunderstanding between the wolves and humans. Persuading the Leader of the Pack may improve their relations."}
, 
[1000169] = {id = 1000169, text = "Anemone lost her Flame Emblem while escaping. Find <color=#82C65D>Anemone</color> and return the Flame Emblem to her."}
, 
[1000170] = {id = 1000170, text = "Go on and explore the secrets of the Chrono Tower."}
, 
[1000171] = {id = 1000171, text = "Dejase is distracting the monsters single-handedly. Bluen is worried about her. <color=#82C65D>Explore upwards</color>, and confirm that Dejase is safe."}
, 
[1000172] = {id = 1000172, text = "Use Intangible Shifting again, and try to prevent the destruction of Snegurochka."}
, 
[1000173] = {id = 1000173, text = "After Intangible Shifting, Snegurochka seems different than before. Have a look around."}
, 
[1000174] = {id = 1000174, text = "Go on exploring, and find out the reason why Cersivey created the blizzard."}
, 
[1000175] = {id = 1000175, text = "Cersivey set up a powerful Boundary. Search for clues outside the Boundary."}
, 
[1000176] = {id = 1000176, text = "The place where magic can be felt the strongest is the Foothills Hunting Grounds. Maybe you can find the entrance there."}
, 
[1000177] = {id = 1000177, text = "You have entered the boundary forged by Cersivey. Search the inside for anything unusual."}
, 
[1000178] = {id = 1000178, text = "There are suspicious creatures inside the Boundary. Proceed with caution."}
, 
[1000179] = {id = 1000179, text = "Cersivey has created the blizzard in the hope of offsetting the Geothermy, but she refuses any help. <color=#82C65D>Continue exploring</color> and investigate the source of the Geothermy."}
, 
[1000180] = {id = 1000180, text = "These suspicious creatures may have something to do with the Geothermy. Search <color=#82C65D>Saintess Square</color> and find where the creatures are appearing from."}
, 
[1000181] = {id = 1000181, text = "Catch up with Cersivey and find out what the source of the Geothermy is."}
, 
[1000182] = {id = 1000182, text = "Sinmara\'s lava core is the key to saving Snegurochka from devastation. Inquire the <color=#82C65D>Captain of the Frost Chivalric Order</color> about clues to the Frost of Absolute Zero."}
, 
[1000183] = {id = 1000183, text = "You have received the Ice Cryolite from the Captain and the Eternal Ice from Cersivey. Next, you need to find La Crima who is believed to be at the <color=#82C65D>Castle: Front</color>."}
, 
[1000184] = {id = 1000184, text = "Defeat Sinmara, and reverse the fate of Snegurochka\'s doom."}
, 
[1000185] = {id = 1000185, text = "Go on and explore the secrets of the Chrono Tower."}
, 
[1000186] = {id = 1000186, text = "Entrusted by the elder brother who has become a caterpillar, you need to venture into the <color=#82C65D>Forest ahead</color> and find his strayed little brother."}
, 
[1000187] = {id = 1000187, text = "Soleil wants to retrieve his precious songbook. Search for it at the <color=#82C65D>Sentry Camp Periphery</color>, and go back to him at the <color=#82C65D>Sentry Camp</color>."}
, 
[1000188] = {id = 1000188, text = "The merchant\'s favorite armor is at this shop in the market at the <color=#82C65D>Commercial Area Entry</color>. Retrieve his armor."}
, 
[1000189] = {id = 1000189, text = "After getting his songbook, Soleil seems to be acting a little strange. Go quickly and see what is going on."}
, 
[1000190] = {id = 1000190, text = "The merchant hid his gold and silver under the floor of his shop in the <color=#82C65D>Commercial Area</color>. Retrieve his hidden gold and silver."}
, 
[1000191] = {id = 1000191, text = "All the merchant has left is some savings buried in his hometown. Explore Irene Island, and help him back home."}
, 
[1000192] = {id = 1000192, text = "The most precious thing is the homeland in one\'s heart. Fulfill the merchant\'s last wish by finding his real home on <color=#82C65D>Irene Island</color>."}
, 
[1000193] = {id = 1000193, text = "Deliver the news to the anxious elder brother that his younger brother has also turned into a caterpillar. He is at either the <color=#82C65D>Commercial Area</color> or the <color=#82C65D>Giant Tree: Periphery</color>."}
, 
[1000194] = {id = 1000194, text = "Help villager Andy find the <color=#82C65D>proper wood for making a crutch</color>. He will swap treasure with you for it."}
, 
[1000195] = {id = 1000195, text = "Villager\'s crops were stolen by cunning foxes. Find the stolen crops, and teach the foxes a lesson."}
, 
[1000196] = {id = 1000196, text = "A snow wolf stole Silverbow\'s luggage. Return the luggage to him. It is said he is at <color=#82C65D>Pass of Talus: End</color>."}
, 
[1000197] = {id = 1000197, text = "Escort the wounded wolf cub back home."}
, 
[1000198] = {id = 1000198, text = "The White Bear often attacks humans nearby. Collect info about the White Bear\'s whereabouts. <color=#82C65D>Silverbow</color> might know something; keep an eye out for him on your journey."}
, 
[1000199] = {id = 1000199, text = "Slay the savage <color=#82C65D>White Bear</color> so that it will no longer harm humans."}
, 
[1000200] = {id = 1000200, text = "The young man\'s bow was taken away during the hunting altercation. Retrieve his bow. He is waiting on the <color=#82C65D>Frozen Lake Surface</color> ahead."}
, 
[1000201] = {id = 1000201, text = "Find the Leader of the Pack on the <color=#82C65D>Hillside Tundra</color>."}
, 
[1000202] = {id = 1000202, text = "The Little Fox must be hoarding the food <color=#82C65D>nearby</color>. Have a look around."}
, 
[1000203] = {id = 1000203, text = "Shard"}
, 
[1000232] = {id = 1000232, text = "Chrono Tower"}
, 
[1000233] = {id = 1000233, text = "0"}
, 
[1000234] = {id = 1000234, text = "0"}
, 
[1000235] = {id = 1000235, text = "0"}
, 
[1000236] = {id = 1000236, text = "Enhance Doll"}
, 
[1000237] = {id = 1000237, text = "Extend Best Wishes"}
, 
[1000238] = {id = 1000238, text = "Enhance Equipment"}
, 
[1000239] = {id = 1000239, text = "0"}
, 
[1000240] = {id = 1000240, text = "Out for Exploration"}
, 
[1000241] = {id = 1000241, text = "Strong Stamina"}
, 
[1000242] = {id = 1000242, text = "0"}
, 
[1000243] = {id = 1000243, text = "Friendship Exchange"}
, 
[1000244] = {id = 1000244, text = "Clear Main Story stages 3 times"}
, 
[1000245] = {id = 1000245, text = "0"}
, 
[1000246] = {id = 1000246, text = "0"}
, 
[1000247] = {id = 1000247, text = "0"}
, 
[1000248] = {id = 1000248, text = "Enhance Doll once"}
, 
[1000249] = {id = 1000249, text = "Send Gift to a Doll once"}
, 
[1000250] = {id = 1000250, text = "Enhance Equipment once"}
, 
[1000251] = {id = 1000251, text = "0"}
, 
[1000252] = {id = 1000252, text = "Explore the Mirror of the Otherworld once"}
, 
[1000253] = {id = 1000253, text = "Consume 100 Stamina"}
, 
[1000254] = {id = 1000254, text = "0"}
, 
[1000255] = {id = 1000255, text = "Purchase Item with Friendship Points once"}
, 
[1000256] = {id = 1000256, text = "Clear Main Story stages"}
, 
[1000257] = {id = 1000257, text = "0"}
, 
[1000258] = {id = 1000258, text = "0"}
, 
[1000259] = {id = 1000259, text = "0"}
, 
[1000260] = {id = 1000260, text = "Enhance Doll"}
, 
[1000261] = {id = 1000261, text = "Send Gift"}
, 
[1000262] = {id = 1000262, text = "Enhance Equipment"}
, 
[1000263] = {id = 1000263, text = "0"}
, 
[1000264] = {id = 1000264, text = "Out for Exploration"}
, 
[1000265] = {id = 1000265, text = "Consume Stamina"}
, 
[1000266] = {id = 1000266, text = "0"}
, 
[1000267] = {id = 1000267, text = "Purchase Items"}
, 
[1000268] = {id = 1000268, text = "Continue exploring and clear Main Story stages."}
, 
[1000269] = {id = 1000269, text = "0"}
, 
[1000270] = {id = 1000270, text = "0"}
, 
[1000271] = {id = 1000271, text = "0"}
, 
[1000272] = {id = 1000272, text = "You can increase the enhancement level of Dolls by consuming Mana."}
, 
[1000273] = {id = 1000273, text = "Giving nice gifts to your Dolls to increase the Bond level."}
, 
[1000274] = {id = 1000274, text = "You can enhance equipment with certain materials."}
, 
[1000275] = {id = 1000275, text = "0"}
, 
[1000276] = {id = 1000276, text = "You can send Dolls to explore the Mirror of the Otherworld in Witch Courtyard. They will bring back plentiful materials."}
, 
[1000277] = {id = 1000277, text = "Stamina is the driving force that sustains the Witch. Exploring the dungeon will consume Stamina."}
, 
[1000278] = {id = 1000278, text = "0"}
, 
[1000279] = {id = 1000279, text = "Friend-assistance brings you Friendship Points that can be traded for items in the shop."}
, 
[1000280] = {id = 1000280, text = "Goddess of Victory"}
, 
[1000281] = {id = 1000281, text = "Extend Best Wishes"}
, 
[1000282] = {id = 1000282, text = "Enhance Doll"}
, 
[1000283] = {id = 1000283, text = "Daily Exploration"}
, 
[1000284] = {id = 1000284, text = "Intangible Barrier"}
, 
[1000285] = {id = 1000285, text = "Mana Dreamland"}
, 
[1000286] = {id = 1000286, text = "Ascension Material"}
, 
[1000287] = {id = 1000287, text = "Skill Material"}
, 
[1000288] = {id = 1000288, text = "Collect Equipment"}
, 
[1000289] = {id = 1000289, text = "Collect Fireflies"}
, 
[1000290] = {id = 1000290, text = "Out for Exploration"}
, 
[1000291] = {id = 1000291, text = "Enhance Equipment"}
, 
[1000293] = {id = 1000293, text = "Summon Practice"}
, 
[1000294] = {id = 1000294, text = "Achieve victory in 100 combats"}
, 
[1000295] = {id = 1000295, text = "Send Gift to a Doll 5 times"}
, 
[1000296] = {id = 1000296, text = "Increase the enhancement level of the Dolls 5 times"}
, 
[1000297] = {id = 1000297, text = "Clear Main Story stages 10 times"}
, 
[1000298] = {id = 1000298, text = "Clear Intangible Barrier once"}
, 
[1000299] = {id = 1000299, text = "Clear Mana Dreamland 3 times"}
, 
[1000300] = {id = 1000300, text = "Clear Ascension Material stage 3 times"}
, 
[1000301] = {id = 1000301, text = "Clear Skill Material stage 3 times"}
, 
[1000302] = {id = 1000302, text = "Clear Doll Equipment stage 3 times"}
, 
[1000303] = {id = 1000303, text = "Claim 1,000 White Light in Witch Courtyard"}
, 
[1000304] = {id = 1000304, text = "Explore the Mirror of the Otherworld 10 times"}
, 
[1000305] = {id = 1000305, text = "Enhance Equipment 10 times"}
, 
[1000307] = {id = 1000307, text = "Summon 5 times"}
, 
[1000308] = {id = 1000308, text = "Victory"}
, 
[1000309] = {id = 1000309, text = "Send Gift"}
, 
[1000310] = {id = 1000310, text = "Enhance Dolls"}
, 
[1000311] = {id = 1000311, text = "Clear Main Story stages"}
, 
[1000312] = {id = 1000312, text = "Clear Intangible Barrier"}
, 
[1000313] = {id = 1000313, text = "Clear Mana Dreamland"}
, 
[1000314] = {id = 1000314, text = "Clear Ascension Material stage"}
, 
[1000315] = {id = 1000315, text = "Clear Skill Material stage"}
, 
[1000316] = {id = 1000316, text = "Clear Doll Equipment stage"}
, 
[1000317] = {id = 1000317, text = "Collect White Light"}
, 
[1000318] = {id = 1000318, text = "Enhance Equipment"}
, 
[1000319] = {id = 1000319, text = "Collect Equipment"}
, 
[1000321] = {id = 1000321, text = "Summon"}
, 
[1000322] = {id = 1000322, text = "You will encounter all sorts of monsters during your exploration. Eliminate them and achieve victory in 100 combats."}
, 
[1000323] = {id = 1000323, text = "Giving nice gifts to your Dolls to increase the Bond level."}
, 
[1000324] = {id = 1000324, text = "You can obtain a lot of Mana and other materials in the Dreamworld."}
, 
[1000325] = {id = 1000325, text = "Continue exploring and clear Main Story stages."}
, 
[1000326] = {id = 1000326, text = "There are many incredible encounters in Intangible Barrier. Explore it from time to time to collect abundant materials."}
, 
[1000327] = {id = 1000327, text = "You can obtain a lot of Mana in the Mana Dreamland."}
, 
[1000328] = {id = 1000328, text = "Obtain Ascension materials in Ascension Material stages."}
, 
[1000329] = {id = 1000329, text = "Obtain Skill materials in Skll Material stages."}
, 
[1000330] = {id = 1000330, text = "Obtain all sorts of equipment in Doll Equipment stages."}
, 
[1000331] = {id = 1000331, text = "Tap the floating white glow or use the Firefly Lampstand to get White Light."}
, 
[1000332] = {id = 1000332, text = "You can send Dolls to explore the Mirror of the Otherworld in Witch Courtyard. They will bring back plentiful materials."}
, 
[1000333] = {id = 1000333, text = "Winning battles or opening chests for a chance to get equipment."}
, 
[1000335] = {id = 1000335, text = "Replicate souls from other worlds to add new dolls to your lineup."}
, 
[1000336] = {id = 1000336, text = "Monster Hunter"}
, 
[1000337] = {id = 1000337, text = "Monster Hunter"}
, 
[1000338] = {id = 1000338, text = "Monster Hunter"}
, 
[1000340] = {id = 1000340, text = "Treasure Gatherer"}
, 
[1000341] = {id = 1000341, text = "Treasure Gatherer"}
, 
[1000342] = {id = 1000342, text = "0"}
, 
[1000343] = {id = 1000343, text = "Mana Gatherer"}
, 
[1000344] = {id = 1000344, text = "Mana Gatherer"}
, 
[1000348] = {id = 1000348, text = "Magic Convergence"}
, 
[1000349] = {id = 1000349, text = "Magic Convergence"}
, 
[1000350] = {id = 1000350, text = "Magic Convergence"}
, 
[1000351] = {id = 1000351, text = "Exploring the Unknown"}
, 
[1000352] = {id = 1000352, text = "Exploring the Unknown"}
, 
[1000353] = {id = 1000353, text = "Exploring the Unknown"}
, 
[1000354] = {id = 1000354, text = "Equipment Gatherer"}
, 
[1000355] = {id = 1000355, text = "Equipment Gatherer"}
, 
[1000356] = {id = 1000356, text = "Equipment Gatherer"}
, 
[1000357] = {id = 1000357, text = "Responsibility on the Shoulder"}
, 
[1000358] = {id = 1000358, text = "Responsibility on the Shoulder"}
, 
[1000359] = {id = 1000359, text = "Responsibility on the Shoulder"}
, 
[1000361] = {id = 1000361, text = "Step into the Otherworld"}
, 
[1000362] = {id = 1000362, text = "Withered and Shattered"}
, 
[1000363] = {id = 1000363, text = "Save Irminsul"}
, 
[1000364] = {id = 1000364, text = "Ferocious Bear"}
, 
[1000365] = {id = 1000365, text = "Blizzard Rest"}
, 
[1000366] = {id = 1000366, text = "Save Snegurochka"}
, 
[1000368] = {id = 1000368, text = "0"}
, 
[1000370] = {id = 1000370, text = "Ascend Limit"}
, 
[1000371] = {id = 1000371, text = "Ascend Limit"}
, 
[1000372] = {id = 1000372, text = "Ascend Limit"}
, 
[1000374] = {id = 1000374, text = "Contact from the Otherworld"}
, 
[1000375] = {id = 1000375, text = "Contact from the Otherworld"}
, 
[1000376] = {id = 1000376, text = "Contact from the Otherworld"}
, 
[1000378] = {id = 1000378, text = "Dreamland Recall"}
, 
[1000384] = {id = 1000384, text = "Mirror of the Otherworld"}
, 
[1000385] = {id = 1000385, text = "Mirror of the Otherworld"}
, 
[1000386] = {id = 1000386, text = "Mirror of the Otherworld"}
, 
[1000391] = {id = 1000391, text = "Doll Gatherer"}
, 
[1000392] = {id = 1000392, text = "Doll Gatherer"}
, 
[1000393] = {id = 1000393, text = "Doll Gatherer"}
, 
[1000394] = {id = 1000394, text = "Act as One"}
, 
[1000395] = {id = 1000395, text = "Act as One"}
, 
[1000396] = {id = 1000396, text = "Act as One"}
, 
[1000398] = {id = 1000398, text = "Survive and Thrive"}
, 
[1000401] = {id = 1000401, text = "0"}
, 
[1000402] = {id = 1000402, text = "Luxury Courtyard"}
, 
[1000403] = {id = 1000403, text = "0"}
, 
[1000406] = {id = 1000406, text = "Enchant Equipment"}
, 
[1000407] = {id = 1000407, text = "Enchant Equipment"}
, 
[1000408] = {id = 1000408, text = "Enchant Equipment"}
, 
[1000412] = {id = 1000412, text = "Intangible Crevice"}
, 
[1000413] = {id = 1000413, text = "Defeat 50 monsters"}
, 
[1000414] = {id = 1000414, text = "Defeat 500 monsters"}
, 
[1000415] = {id = 1000415, text = "Defeat 2,000 monsters"}
, 
[1000417] = {id = 1000417, text = "Open 100 Chests"}
, 
[1000418] = {id = 1000418, text = "Open 500 Chests"}
, 
[1000420] = {id = 1000420, text = "Crack 50 Mana Crystal Clusters"}
, 
[1000421] = {id = 1000421, text = "Crack 250 Mana Crystal Clusters"}
, 
[1000425] = {id = 1000425, text = "Obtain 100,000 Mana"}
, 
[1000426] = {id = 1000426, text = "Obtain 5,000,000 Mana"}
, 
[1000427] = {id = 1000427, text = "Obtain 50,000,000 Mana"}
, 
[1000428] = {id = 1000428, text = "First time to clear a stage"}
, 
[1000429] = {id = 1000429, text = "Clear stages 50 times"}
, 
[1000430] = {id = 1000430, text = "Clear stages 100 times"}
, 
[1000431] = {id = 1000431, text = "Obtain 20 pieces of equipment"}
, 
[1000432] = {id = 1000432, text = "Obtain 200 pieces of equipment"}
, 
[1000433] = {id = 1000433, text = "Obtain 500 pieces of equipment"}
, 
[1000434] = {id = 1000434, text = "Finish 10 quests"}
, 
[1000435] = {id = 1000435, text = "Finish 100 quests"}
, 
[1000436] = {id = 1000436, text = "Finish 200 quests"}
, 
[1000438] = {id = 1000438, text = "Defeat the Chronospace Monitor"}
, 
[1000439] = {id = 1000439, text = "Defeat Flare"}
, 
[1000440] = {id = 1000440, text = "Defeat Asherah"}
, 
[1000441] = {id = 1000441, text = "Defeat Hervoraltar"}
, 
[1000442] = {id = 1000442, text = "Defeat Cersivey"}
, 
[1000443] = {id = 1000443, text = "Defeat Sinmara"}
, 
[1000444] = {id = 1000444, text = "Have a Doll reaching Lv.10"}
, 
[1000445] = {id = 1000445, text = "0"}
, 
[1000447] = {id = 1000447, text = "3 Dolls reach Ascend 1"}
, 
[1000448] = {id = 1000448, text = "3 Dolls reach Ascend 2"}
, 
[1000449] = {id = 1000449, text = "3 Dolls reach Ascend 3"}
, 
[1000451] = {id = 1000451, text = "Have 1 friend"}
, 
[1000452] = {id = 1000452, text = "Have 10 friends"}
, 
[1000453] = {id = 1000453, text = "Have 100 friends"}
, 
[1000455] = {id = 1000455, text = "Clear Dreamworld for the first time"}
, 
[1000461] = {id = 1000461, text = "Explore the Mirror of the Otherworld once"}
, 
[1000462] = {id = 1000462, text = "Explore the Mirror of the Otherworld 20 times"}
, 
[1000463] = {id = 1000463, text = "Explore the Mirror of the Otherworld 100 times"}
, 
[1000468] = {id = 1000468, text = "Possess 10 Dolls"}
, 
[1000469] = {id = 1000469, text = "Possess 30 Dolls"}
, 
[1000470] = {id = 1000470, text = "Possess 50 Dolls"}
, 
[1000471] = {id = 1000471, text = "Upgrade the Bond Level with any Doll to Lv.2"}
, 
[1000472] = {id = 1000472, text = "Upgrade the Bond Level with any Doll to Lv.10"}
, 
[1000473] = {id = 1000473, text = "Upgrade the Bond Level with any Doll to Lv.20"}
, 
[1000475] = {id = 1000475, text = "Magic Tree reaches Lv.3"}
, 
[1000479] = {id = 1000479, text = "Fully upgrade all buildings in Witch Courtyard"}
, 
[1000483] = {id = 1000483, text = "Enchant equipment once"}
, 
[1000484] = {id = 1000484, text = "Enchant equipment once"}
, 
[1000485] = {id = 1000485, text = "Enchant equipment for 500 times"}
, 
[1000489] = {id = 1000489, text = "Clear Intangible Barrier: Prelude."}
, 
[1000501] = {id = 1000501, text = "0"}
, 
[1000502] = {id = 1000502, text = "0"}
, 
[1000601] = {id = 1000601, text = "0"}
, 
[1000602] = {id = 1000602, text = "0"}
, 
[1000644] = {id = 1000644, text = "0"}
, 
[1000645] = {id = 1000645, text = "0"}
, 
[1000646] = {id = 1000646, text = "0"}
, 
[1000647] = {id = 1000647, text = "0"}
, 
[1000648] = {id = 1000648, text = "0"}
, 
[1000649] = {id = 1000649, text = "0"}
, 
[1000650] = {id = 1000650, text = "0"}
, 
[1000651] = {id = 1000651, text = "0"}
, 
[1000652] = {id = 1000652, text = "0"}
, 
[1000653] = {id = 1000653, text = "0"}
, 
[1000654] = {id = 1000654, text = "0"}
, 
[1000655] = {id = 1000655, text = "0"}
, 
[1000656] = {id = 1000656, text = "0"}
, 
[1000657] = {id = 1000657, text = "0"}
, 
[1000658] = {id = 1000658, text = "0"}
, 
[1000659] = {id = 1000659, text = "0"}
, 
[1000660] = {id = 1000660, text = "0"}
, 
[1000661] = {id = 1000661, text = "0"}
, 
[1000662] = {id = 1000662, text = "0"}
, 
[1000663] = {id = 1000663, text = "0"}
, 
[1000664] = {id = 1000664, text = "0"}
, 
[1000665] = {id = 1000665, text = "0"}
, 
[1000666] = {id = 1000666, text = "0"}
, 
[1000667] = {id = 1000667, text = "0"}
, 
[1000668] = {id = 1000668, text = "0"}
, 
[1000669] = {id = 1000669, text = "0"}
, 
[1000670] = {id = 1000670, text = "0"}
, 
[1000671] = {id = 1000671, text = "0"}
, 
[1000679] = {id = 1000679, text = "Unused"}
, 
[1000682] = {id = 1000682, text = "Goddess of Victory"}
, 
[1000683] = {id = 1000683, text = "You will encounter all sorts of monsters during your exploration. Eliminate them and achieve victory in 50 combats."}
, 
[1000684] = {id = 1000684, text = "Achieve victory in 50 combats"}
, 
[1000701] = {id = 1000701, text = "0"}
, 
[1000705] = {id = 1000705, text = "Mana Dreamland"}
, 
[1000706] = {id = 1000706, text = "Ascension Trials"}
, 
[1000707] = {id = 1000707, text = "Skill Library"}
, 
[1000708] = {id = 1000708, text = "Equipment Dreamscape"}
, 
[1000709] = {id = 1000709, text = "0"}
, 
[1000710] = {id = 1000710, text = "Doll Enhancement"}
, 
[1000711] = {id = 1000711, text = "Doll Deployment"}
, 
[1000712] = {id = 1000712, text = "Clear Mana Dreamland twice"}
, 
[1000713] = {id = 1000713, text = "Clear Mana Dreamland 3 times"}
, 
[1000714] = {id = 1000714, text = "Clear Mana Dreamland 4 times"}
, 
[1000715] = {id = 1000715, text = "Clear Ascension Material stage twice"}
, 
[1000716] = {id = 1000716, text = "Clear Ascension Material stage 3 times"}
, 
[1000717] = {id = 1000717, text = "Clear Ascension Material stage 4 times"}
, 
[1000718] = {id = 1000718, text = "Clear Skill Material stage twice"}
, 
[1000719] = {id = 1000719, text = "Clear Skill Material stage 3 times"}
, 
[1000720] = {id = 1000720, text = "Clear Skill Material stage 4 times"}
, 
[1000721] = {id = 1000721, text = "Clear Doll Equipment stage twice"}
, 
[1000722] = {id = 1000722, text = "Clear Doll Equipment stage 3 times"}
, 
[1000723] = {id = 1000723, text = "Clear Doll Equipment stage 4 times"}
, 
[1000724] = {id = 1000724, text = "0"}
, 
[1000725] = {id = 1000725, text = "0"}
, 
[1000726] = {id = 1000726, text = "0"}
, 
[1000727] = {id = 1000727, text = "0"}
, 
[1000728] = {id = 1000728, text = "0"}
, 
[1000729] = {id = 1000729, text = "0"}
, 
[1000730] = {id = 1000730, text = "0"}
, 
[1000731] = {id = 1000731, text = "0"}
, 
[1000732] = {id = 1000732, text = "0"}
, 
[1000733] = {id = 1000733, text = "0"}
, 
[1000734] = {id = 1000734, text = "0"}
, 
[1000735] = {id = 1000735, text = "0"}
, 
[1000736] = {id = 1000736, text = "0"}
, 
[1000740] = {id = 1000740, text = "Obtain 1,000 Friendship Points in total"}
, 
[1000741] = {id = 1000741, text = "Obtain 5,000 Friendship Points in total"}
, 
[1000742] = {id = 1000742, text = "Summon 30 times"}
, 
[1000743] = {id = 1000743, text = "Summon 100 times"}
, 
[1000744] = {id = 1000744, text = "Summon 500 times"}
, 
[1000745] = {id = 1000745, text = "Summon 1,000 times"}
, 
[1000746] = {id = 1000746, text = "Purchase item in Friendship Point Shop 50 times"}
, 
[1000747] = {id = 1000747, text = "Purchase item in Friendship Point Shop 100 times"}
, 
[1000748] = {id = 1000748, text = "Obtain 100 Furniture Coins"}
, 
[1000749] = {id = 1000749, text = "Obtain 1,000 Furniture Coins"}
, 
[1000750] = {id = 1000750, text = "Obtain 5,000 Furniture Coins"}
, 
[1000752] = {id = 1000752, text = "Clear Intangible Barrier: Engraving."}
, 
[1000753] = {id = 1000753, text = "Clear Intangible Barrier: Final."}
, 
[1000757] = {id = 1000757, text = "The Heart of Friendship"}
, 
[1000758] = {id = 1000758, text = "The Heart of Friendship"}
, 
[1000759] = {id = 1000759, text = "Doll Collector"}
, 
[1000760] = {id = 1000760, text = "Doll Collector"}
, 
[1000761] = {id = 1000761, text = "Doll Collector"}
, 
[1000762] = {id = 1000762, text = "Doll Collector"}
, 
[1000763] = {id = 1000763, text = "The Value of Friendship"}
, 
[1000764] = {id = 1000764, text = "The Value of Friendship"}
, 
[1000765] = {id = 1000765, text = "Master Collector"}
, 
[1000766] = {id = 1000766, text = "Master Collector"}
, 
[1000767] = {id = 1000767, text = "Master Collector"}
, 
[1000769] = {id = 1000769, text = "Intangible Crevice"}
, 
[1000770] = {id = 1000770, text = "Intangible Crevice"}
, 
[1000771] = {id = 1000771, text = "The Heart of Friendship"}
, 
[1000772] = {id = 1000772, text = "Obtain 200 Friendship Points in total"}
, 
[1000773] = {id = 1000773, text = "0"}
, 
[1000774] = {id = 1000774, text = "0"}
, 
[1000775] = {id = 1000775, text = "0"}
, 
[1000776] = {id = 1000776, text = "Fully upgrade all buildings in Witch Courtyard"}
, 
[1000777] = {id = 1000777, text = "0"}
, 
[1000778] = {id = 1000778, text = "0"}
, 
[1000779] = {id = 1000779, text = "0"}
, 
[1000780] = {id = 1000780, text = "Sweet Home"}
, 
[1000781] = {id = 1000781, text = "0"}
, 
[1000782] = {id = 1000782, text = "0"}
, 
[1000783] = {id = 1000783, text = "0"}
, 
[1000784] = {id = 1000784, text = "0"}
, 
[1000785] = {id = 1000785, text = "0"}
, 
[1000786] = {id = 1000786, text = "0"}
, 
[1000787] = {id = 1000787, text = "0"}
, 
[1000788] = {id = 1000788, text = "0"}
, 
[1000789] = {id = 1000789, text = "0"}
, 
[1000790] = {id = 1000790, text = "0"}
, 
[1000791] = {id = 1000791, text = "0"}
, 
[1000792] = {id = 1000792, text = "Level up Croche by 5"}
, 
[1000793] = {id = 1000793, text = "Level up Croche by 10"}
, 
[1000794] = {id = 1000794, text = "Level up Miku by 5"}
, 
[1000795] = {id = 1000795, text = "Level up Miku by 10"}
, 
[1000796] = {id = 1000796, text = "Level up Eulalia by 5"}
, 
[1000797] = {id = 1000797, text = "Level up Eulalia by 10"}
, 
[1000798] = {id = 1000798, text = "Level up Primula by 5"}
, 
[1000799] = {id = 1000799, text = "Level up Primula by 10"}
, 
[1000800] = {id = 1000800, text = "Level up Nemesi by 5"}
, 
[1000801] = {id = 1000801, text = "Level up Nemesi by 10"}
, 
[1000802] = {id = 1000802, text = "Level up Pakane by 5"}
, 
[1000803] = {id = 1000803, text = "Level up Pakane by 10"}
, 
[1000804] = {id = 1000804, text = "Level up Octavia by 5"}
, 
[1000805] = {id = 1000805, text = "Level up Octavia by 10"}
, 
[1000806] = {id = 1000806, text = "Level up Mikoto by 5"}
, 
[1000807] = {id = 1000807, text = "Level up Mikoto by 10"}
, 
[1000808] = {id = 1000808, text = "Level up Czerni by 5"}
, 
[1000809] = {id = 1000809, text = "Level up Czerni by 10"}
, 
[1000810] = {id = 1000810, text = "Level up Cetess by 5"}
, 
[1000811] = {id = 1000811, text = "Level up Cetess by 10"}
, 
[1000812] = {id = 1000812, text = "Level up Elis by 5"}
, 
[1000813] = {id = 1000813, text = "Level up Elis by 10"}
, 
[1000814] = {id = 1000814, text = "Level up Cuspidata by 5"}
, 
[1000815] = {id = 1000815, text = "Level up Cuspidata by 10"}
, 
[1000816] = {id = 1000816, text = "Level up Ruda by 5"}
, 
[1000817] = {id = 1000817, text = "Level up Ruda by 10"}
, 
[1000818] = {id = 1000818, text = "Level up Hilda by 5"}
, 
[1000819] = {id = 1000819, text = "Level up Hilda by 10"}
, 
[1000820] = {id = 1000820, text = "Level up Yurugu by 5"}
, 
[1000821] = {id = 1000821, text = "Level up Yurugu by 10"}
, 
[1000822] = {id = 1000822, text = "Level up Yothaya by 5"}
, 
[1000823] = {id = 1000823, text = "Level up Yothaya by 10"}
, 
[1000824] = {id = 1000824, text = "Level up Avil by 5"}
, 
[1000825] = {id = 1000825, text = "Level up Avil by 10"}
, 
[1000826] = {id = 1000826, text = "Level up Fey by 5"}
, 
[1000827] = {id = 1000827, text = "Level up Fey by 10"}
, 
[1000828] = {id = 1000828, text = "Level up Mortimer by 5"}
, 
[1000829] = {id = 1000829, text = "Level up Mortimer by 10"}
, 
[1000830] = {id = 1000830, text = "Clear Main Story with Croche 2 times"}
, 
[1000831] = {id = 1000831, text = "Clear Main Story with Croche 3 times"}
, 
[1000832] = {id = 1000832, text = "Clear Main Story with Croche 4 times"}
, 
[1000833] = {id = 1000833, text = "Clear Main Story with Miku 2 times"}
, 
[1000834] = {id = 1000834, text = "Clear Main Story with Miku 3 times"}
, 
[1000835] = {id = 1000835, text = "Clear Main Story with Miku 4 times"}
, 
[1000836] = {id = 1000836, text = "Clear Main Story with Eulalia 2 times"}
, 
[1000837] = {id = 1000837, text = "Clear Main Story with Eulalia 3 times"}
, 
[1000838] = {id = 1000838, text = "Clear Main Story with Eulalia 4 times"}
, 
[1000839] = {id = 1000839, text = "Clear Main Story with Primula 2 times"}
, 
[1000840] = {id = 1000840, text = "Clear Main Story with Primula 3 times"}
, 
[1000841] = {id = 1000841, text = "Clear Main Story with Primula 4 times"}
, 
[1000842] = {id = 1000842, text = "Clear Main Story with Nemesi 2 times"}
, 
[1000843] = {id = 1000843, text = "Clear Main Story with Nemesi 3 times"}
, 
[1000844] = {id = 1000844, text = "Clear Main Story with Nemesi 4 times"}
, 
[1000845] = {id = 1000845, text = "Clear Main Story with Pakane 2 times"}
, 
[1000846] = {id = 1000846, text = "Clear Main Story with Pakane 3 times"}
, 
[1000847] = {id = 1000847, text = "Clear Main Story with Pakane 4 times"}
, 
[1000848] = {id = 1000848, text = "Clear Main Story with Octavia 2 times"}
, 
[1000849] = {id = 1000849, text = "Clear Main Story with Octavia 3 times"}
, 
[1000850] = {id = 1000850, text = "Clear Main Story with Octavia 4 times"}
, 
[1000851] = {id = 1000851, text = "Clear Main Story with Mikoto 2 times"}
, 
[1000852] = {id = 1000852, text = "Clear Main Story with Mikoto 3 times"}
, 
[1000853] = {id = 1000853, text = "Clear Main Story with Mikoto 4 times"}
, 
[1000854] = {id = 1000854, text = "Clear Main Story with Czerni 2 times"}
, 
[1000855] = {id = 1000855, text = "Clear Main Story with Czerni 3 times"}
, 
[1000856] = {id = 1000856, text = "Clear Main Story with Czerni 4 times"}
, 
[1000857] = {id = 1000857, text = "Clear Main Story with Cetess 2 times"}
, 
[1000858] = {id = 1000858, text = "Clear Main Story with Cetess 3 times"}
, 
[1000859] = {id = 1000859, text = "Clear Main Story with Cetess 4 times"}
, 
[1000860] = {id = 1000860, text = "Clear Main Story with Elis 2 times"}
, 
[1000861] = {id = 1000861, text = "Clear Main Story with Elis 3 times"}
, 
[1000862] = {id = 1000862, text = "Clear Main Story with Elis 4 times"}
, 
[1000863] = {id = 1000863, text = "Clear Main Story with Cuspidata 2 times"}
, 
[1000864] = {id = 1000864, text = "Clear Main Story with Cuspidata 3 times"}
, 
[1000865] = {id = 1000865, text = "Clear Main Story with Cuspidata 4 times"}
, 
[1000866] = {id = 1000866, text = "Clear Main Story with Ruda 2 times"}
, 
[1000867] = {id = 1000867, text = "Clear Main Story with Ruda 3 times"}
, 
[1000868] = {id = 1000868, text = "Clear Main Story with Ruda 4 times"}
, 
[1000869] = {id = 1000869, text = "Clear Main Story with Hilda 2 times"}
, 
[1000870] = {id = 1000870, text = "Clear Main Story with Hilda 3 times"}
, 
[1000871] = {id = 1000871, text = "Clear Main Story with Hilda 4 times"}
, 
[1000872] = {id = 1000872, text = "Clear Main Story with Yurugu 2 times"}
, 
[1000873] = {id = 1000873, text = "Clear Main Story with Yurugu 3 times"}
, 
[1000874] = {id = 1000874, text = "Clear Main Story with Yurugu 4 times"}
, 
[1000875] = {id = 1000875, text = "Clear Main Story with Yothaya 2 times"}
, 
[1000876] = {id = 1000876, text = "Clear Main Story with Yothaya 3 times"}
, 
[1000877] = {id = 1000877, text = "Clear Main Story with Yothaya 4 times"}
, 
[1000878] = {id = 1000878, text = "Clear Main Story with Avil 2 times"}
, 
[1000879] = {id = 1000879, text = "Clear Main Story with Avil 3 times"}
, 
[1000880] = {id = 1000880, text = "Clear Main Story with Avil 4 times"}
, 
[1000881] = {id = 1000881, text = "Clear Main Story with Fey 2 times"}
, 
[1000882] = {id = 1000882, text = "Clear Main Story with Fey 3 times"}
, 
[1000883] = {id = 1000883, text = "Clear Main Story with Fey 4 times"}
, 
[1000884] = {id = 1000884, text = "Clear Main Story with Mortimer 2 times"}
, 
[1000885] = {id = 1000885, text = "Clear Main Story with Mortimer 3 times"}
, 
[1000886] = {id = 1000886, text = "Clear Main Story with Mortimer 4 times"}
, 
[1000887] = {id = 1000887, text = "Initial Bond"}
, 
[1000888] = {id = 1000888, text = "Summon 10 times"}
, 
[1000889] = {id = 1000889, text = "Initial Growth"}
, 
[1000890] = {id = 1000890, text = "Recover Dejase to normal"}
, 
[1000891] = {id = 1000891, text = "Catch up with Dejase"}
, 
[1000892] = {id = 1000892, text = "Turning a deaf ear to Bluen\'s persuasion, Dejase has become very dangerous."}
, 
[1000893] = {id = 1000893, text = "0"}
, 
[1000894] = {id = 1000894, text = "0"}
, 
[1000901] = {id = 1000901, text = "0"}
, 
[1000902] = {id = 1000902, text = "0"}
, 
[1000903] = {id = 1000903, text = "0"}
, 
[1000921] = {id = 1000921, text = "Dreamland Recall"}
, 
[1000922] = {id = 1000922, text = "Act as One"}
, 
[1000923] = {id = 1000923, text = "Monster Hunter"}
, 
[1000924] = {id = 1000924, text = "Magic Convergence"}
, 
[1000925] = {id = 1000925, text = "Survive and Thrive"}
, 
[1000926] = {id = 1000926, text = "Responsibility on the Shoulder"}
, 
[1000927] = {id = 1000927, text = "Luxury Courtyard"}
, 
[1000928] = {id = 1000928, text = "Exploring the Unknown"}
, 
[1000929] = {id = 1000929, text = "Ascend Limit"}
, 
[1000930] = {id = 1000930, text = "Contact from the Otherworld"}
, 
[1000955] = {id = 1000955, text = "Deliverer\'s Resentment"}
, 
[1000956] = {id = 1000956, text = "Search for the fleeing Goorveig"}
, 
[1000957] = {id = 1000957, text = "Chase the fleeing Goorveig"}
, 
[1000958] = {id = 1000958, text = "Dejase\'s Tracks"}
, 
[1000959] = {id = 1000959, text = "The Preacher\'s Conspiracy"}
, 
[1000960] = {id = 1000960, text = "Escort Lyne"}
, 
[1000961] = {id = 1000961, text = "Hemostatic White Flower"}
, 
[1000962] = {id = 1000962, text = "Brew Potions"}
, 
[1000963] = {id = 1000963, text = "A Clandestine Meeting"}
, 
[1000964] = {id = 1000964, text = "Villager\'s Crops"}
, 
[1000965] = {id = 1000965, text = "Investigate Whereabouts of the Preacher"}
, 
[1000966] = {id = 1000966, text = "Investigate the Ruins"}
, 
[1000967] = {id = 1000967, text = "Find the Cause of the Earthquakes"}
, 
[1000968] = {id = 1000968, text = "Foil the Preacher\'s Conspiracy"}
, 
[1000969] = {id = 1000969, text = "Naughty Guy"}
, 
[1000970] = {id = 1000970, text = "Danger Draws Near"}
, 
[1000971] = {id = 1000971, text = "Giant Monster"}
, 
[1000972] = {id = 1000972, text = "Tuonel\'s Kindness"}
, 
[1000973] = {id = 1000973, text = "Enter the Upper Domain"}
, 
[1000974] = {id = 1000974, text = "Break Time"}
, 
[1000975] = {id = 1000975, text = "0"}
, 
[1000976] = {id = 1000976, text = "Dolls rest in the Cottage once"}
, 
[1000977] = {id = 1000977, text = "0"}
, 
[1000978] = {id = 1000978, text = "Dispatch Dolls"}
, 
[1000979] = {id = 1000979, text = "0"}
, 
[1000980] = {id = 1000980, text = "Cottage is a main building in Witch Courtyard. Dolls restore Energy there."}
, 
[1000981] = {id = 1000981, text = "0"}
, 
[1000982] = {id = 1000982, text = "Combat Tips"}
, 
[1000983] = {id = 1000983, text = "0"}
, 
[1000984] = {id = 1000984, text = "0"}
, 
[1000985] = {id = 1000985, text = "0"}
, 
[1000988] = {id = 1000988, text = "Strength of Evolution"}
, 
[1000989] = {id = 1000989, text = "Strength of Evolution"}
, 
[1000990] = {id = 1000990, text = "Strength of Skill"}
, 
[1000991] = {id = 1000991, text = "Strength of Skill"}
, 
[1000992] = {id = 1000992, text = "Fashionista"}
, 
[1000993] = {id = 1000993, text = "Fashionista"}
, 
[1000994] = {id = 1000994, text = "Forging"}
, 
[1000995] = {id = 1000995, text = "Forging"}
, 
[1000996] = {id = 1000996, text = "Equipment Ascension"}
, 
[1000997] = {id = 1000997, text = "Equipment Ascension"}
, 
[1000998] = {id = 1000998, text = "0"}
, 
[1000999] = {id = 1000999, text = "Dream Maelstrom"}
, 
[1001000] = {id = 1001000, text = "Dream Maelstrom"}
, 
[1001001] = {id = 1001001, text = "Alchemy"}
, 
[1001002] = {id = 1001002, text = "Alchemy"}
, 
[1001003] = {id = 1001003, text = "Alchemy"}
, 
[1001004] = {id = 1001004, text = "Break enemy\'s spell cast once"}
, 
[1001005] = {id = 1001005, text = "0"}
, 
[1001006] = {id = 1001006, text = "0"}
, 
[1001007] = {id = 1001007, text = "0"}
, 
[1001010] = {id = 1001010, text = "1 Doll reaches Evolve 1"}
, 
[1001011] = {id = 1001011, text = "3 Dolls reach Evolve 2"}
, 
[1001012] = {id = 1001012, text = "Upgrade 1 Doll Skill to Lv.5"}
, 
[1001013] = {id = 1001013, text = "Upgrade 3 Doll Skills to Lv.5"}
, 
[1001014] = {id = 1001014, text = "Obtain 1 Doll Costume"}
, 
[1001015] = {id = 1001015, text = "Obtain 10 different Doll Costumes"}
, 
[1001016] = {id = 1001016, text = "Enhance 3 pieces of equipment to Lv.20"}
, 
[1001017] = {id = 1001017, text = "Enhance 3 pieces of equipment to Lv.40"}
, 
[1001018] = {id = 1001018, text = "3 pieces of equipment reach Ascend 2"}
, 
[1001019] = {id = 1001019, text = "3 pieces of equipment reach Ascend 3"}
, 
[1001020] = {id = 1001020, text = "0"}
, 
[1001021] = {id = 1001021, text = "Dream Maelstrom reaches Max. Lv once"}
, 
[1001022] = {id = 1001022, text = "Dream Maelstrom reaches Max. Lv 2 times"}
, 
[1001023] = {id = 1001023, text = "Perform Alchemy once"}
, 
[1001024] = {id = 1001024, text = "Perform Alchemy 50 times"}
, 
[1001025] = {id = 1001025, text = "Perform Alchemy 100 times"}
, 
[1001026] = {id = 1001026, text = "Continue exploring the Chrono Tower"}
, 
[1001027] = {id = 1001027, text = "Help Kyphon"}
, 
[1001028] = {id = 1001028, text = "Search for the fleeing Goorveig"}
, 
[1001029] = {id = 1001029, text = "Chase the fleeing Goorveig"}
, 
[1001030] = {id = 1001030, text = "Search for the mentally abnormal Dejase"}
, 
[1001031] = {id = 1001031, text = "Investigate and foil the Preacher\'s conspiracy"}
, 
[1001032] = {id = 1001032, text = "Escort the mysterious girl Lyne"}
, 
[1001033] = {id = 1001033, text = "Proceed and harvest the Hemostatic White Flower"}
, 
[1001034] = {id = 1001034, text = "Give the White Flower to Tuonel"}
, 
[1001035] = {id = 1001035, text = "Use the code to deliver the message to Nemesi"}
, 
[1001036] = {id = 1001036, text = "Check the crops in the flower fields"}
, 
[1001037] = {id = 1001037, text = "Investigate the whereabouts of the Preacher in the Lower Domain"}
, 
[1001038] = {id = 1001038, text = "Investigate the Ruins of Pelenier"}
, 
[1001039] = {id = 1001039, text = "Find out what caused the earthquake"}
, 
[1001040] = {id = 1001040, text = "Foil the Preacher\'s Conspiracy"}
, 
[1001041] = {id = 1001041, text = "Escort Afallen back to the Upper Domain"}
, 
[1001042] = {id = 1001042, text = "Remind Garditis to be careful for he\'s being targeted"}
, 
[1001043] = {id = 1001043, text = "Defeat the giant monster perching in the Lower Domain"}
, 
[1001044] = {id = 1001044, text = "Give Nemesi the salve made by Tuonel"}
, 
[1001045] = {id = 1001045, text = "Enter the Upper Domain and find the truth"}
, 
[1001046] = {id = 1001046, text = "Continue exploring up the Chrono Tower."}
, 
[1001047] = {id = 1001047, text = "To carry out the Deliverer\'s duty, as well as save his friend, Kyphon decides to chase <color=#82C65D>Goorveig</color> alone."}
, 
[1001048] = {id = 1001048, text = "Help Kyphon find the fleeing Goorveig."}
, 
[1001049] = {id = 1001049, text = "Goorveig is in danger. Find her ASAP."}
, 
[1001050] = {id = 1001050, text = "Find a way to get Dejase back to normal."}
, 
[1001051] = {id = 1001051, text = "The Preacher has gone to another world with the forbidden magic. Find out what he\'s been plotting."}
, 
[1001052] = {id = 1001052, text = "Escort the mysterious girl Lyne to her companions."}
, 
[1001053] = {id = 1001053, text = "Go north and harvest the <color=#82C65D>White Flower</color> that stops bleeding."}
, 
[1001054] = {id = 1001054, text = "You have collected the White Flower. Deliver it to Tuonel in the village who is waiting anxiously."}
, 
[1001055] = {id = 1001055, text = "Light a pile of leaves on fire under the tree at the <color=#82C65D>Entrance to the Flower Fields</color>. It\'s the code signal to contact the leader of the Alliance of the Rebellions. Tell him what happened."}
, 
[1001056] = {id = 1001056, text = "The villager hid the crops in a secret path in the flower fields. Confirm her crops are safe."}
, 
[1001057] = {id = 1001057, text = "Someone saw a suspicious preacher near the Lower Domain stage. Investigate that area for clues."}
, 
[1001058] = {id = 1001058, text = "The preacher was spotted in the Ruins of Pelenier Village. Investigate that area for clues."}
, 
[1001059] = {id = 1001059, text = "There\'s some strange <color=#82C65D>rumors</color> going around about the earthquakes that are worth investigating."}
, 
[1001060] = {id = 1001060, text = "It seems the Preacher is manipulating monsters to attack the innocent. You have to stop him."}
, 
[1001061] = {id = 1001061, text = "The naughty Afallen strayed into the Lower Domain. It\'s unsafe to tread alone. Escort her back to the <color=#82C65D>Upper Domain</color>."}
, 
[1001062] = {id = 1001062, text = "Garditis is contacting his comrades nearby. Inform him to be careful for that he is targeted by assassins."}
, 
[1001063] = {id = 1001063, text = "Team up to defeat the giant monster perching in the Lower Domain."}
, 
[1001064] = {id = 1001064, text = "Give <color=#82C65D>Nemesi</color> the salve made by Tuonel."}
, 
[1001065] = {id = 1001065, text = "The earthquakes are not a simple matter of monsters. Enter the Upper Domain to find the truth."}
, 
[1001066] = {id = 1001066, text = "Chrono Tower"}
, 
[1001067] = {id = 1001067, text = "Chrono Tower"}
, 
[1001068] = {id = 1001068, text = "Chrono Tower"}
, 
[1001069] = {id = 1001069, text = "Chrono Tower"}
, 
[1001070] = {id = 1001070, text = "Chrono Tower"}
, 
[1001071] = {id = 1001071, text = "Chrono Tower"}
, 
[1001072] = {id = 1001072, text = "Lower Domain of Cassiel: Stream Side"}
, 
[1001073] = {id = 1001073, text = "Cassiel: Floating Isles Entry"}
, 
[1001074] = {id = 1001074, text = "Lower Domain of Cassiel: Northern Field"}
, 
[1001075] = {id = 1001075, text = "Lower Domain of Cassiel: Tote Village"}
, 
[1001076] = {id = 1001076, text = "Lower Domain of Cassiel: Tote Village"}
, 
[1001077] = {id = 1001077, text = "Lower Domain of Cassiel: Flower Fields"}
, 
[1001078] = {id = 1001078, text = "Lower Domain of Cassiel: Foothills Farmland (Middle)"}
, 
[1001079] = {id = 1001079, text = "Lower Domain of Cassiel: Southern Field"}
, 
[1001080] = {id = 1001080, text = "Lower Domain of Cassiel: Ancient Tree"}
, 
[1001081] = {id = 1001081, text = "Cassiel: Pelenier Outskirts"}
, 
[1001082] = {id = 1001082, text = "Cassiel: Winding Trail (Front)"}
, 
[1001083] = {id = 1001083, text = "Cassiel: Winding Trail (Middle)"}
, 
[1001084] = {id = 1001084, text = "Cassiel: Winding Trail (End)"}
, 
[1001085] = {id = 1001085, text = "Spiral Perch"}
, 
[1001086] = {id = 1001086, text = "Strange Earthquakes"}
, 
[1001087] = {id = 1001087, text = "Lower Domain of Cassiel: Cliffs"}
, 
[1001088] = {id = 1001088, text = "The unpredictable earthquakes have created panic"}
, 
[1001089] = {id = 1001089, text = "It seems that earthquakes strike the Floating Isles from time to time. Maybe the villagers nearby know something about it."}
, 
[1001090] = {id = 1001090, text = "0"}
, 
[1001091] = {id = 1001091, text = "0"}
, 
[1001092] = {id = 1001092, text = "0"}
, 
[1001093] = {id = 1001093, text = "0"}
, 
[1001094] = {id = 1001094, text = "0"}
, 
[1001095] = {id = 1001095, text = "0"}
, 
[1001096] = {id = 1001096, text = "0"}
, 
[1001097] = {id = 1001097, text = "0"}
, 
[1001098] = {id = 1001098, text = "0"}
, 
[1001099] = {id = 1001099, text = "0"}
, 
[1001100] = {id = 1001100, text = "Furniture Theme"}
, 
[1001101] = {id = 1001101, text = "Apply 1 furniture theme"}
, 
[1001102] = {id = 1001102, text = "Furniture Theme"}
, 
[1001103] = {id = 1001103, text = "Apply 5 different furniture themes"}
, 
[1001104] = {id = 1001104, text = "Furniture Theme"}
, 
[1001105] = {id = 1001105, text = "Apply 10 different furniture themes"}
, 
[1001106] = {id = 1001106, text = "The Broken Lands"}
, 
[1001107] = {id = 1001107, text = "Clear Broken Lands once"}
, 
[1001108] = {id = 1001108, text = "The Broken Lands"}
, 
[1001109] = {id = 1001109, text = "Clear Broken Lands 5 times"}
, 
[1001110] = {id = 1001110, text = "The Broken Lands"}
, 
[1001111] = {id = 1001111, text = "Clear Broken Lands for 20 times"}
, 
[1001112] = {id = 1001112, text = "Chronospace Breach"}
, 
[1001113] = {id = 1001113, text = "Win combats in Chronospace Breach 10 times"}
, 
[1001114] = {id = 1001114, text = "Chronospace Breach"}
, 
[1001115] = {id = 1001115, text = "Win combats in Chronospace Breach 100 times"}
, 
[1001116] = {id = 1001116, text = "Chronospace Breach"}
, 
[1001117] = {id = 1001117, text = "Win combats in Chronospace Breach for 500 times"}
, 
[1001118] = {id = 1001118, text = "0"}
, 
[1001119] = {id = 1001119, text = "0"}
, 
[1001120] = {id = 1001120, text = "Day 1"}
, 
[1001121] = {id = 1001121, text = "Day 2"}
, 
[1001122] = {id = 1001122, text = "Day 3"}
, 
[1001123] = {id = 1001123, text = "Day 4"}
, 
[1001124] = {id = 1001124, text = "Day 5"}
, 
[1001125] = {id = 1001125, text = "Day 6"}
, 
[1001126] = {id = 1001126, text = "Day 7"}
, 
[1001127] = {id = 1001127, text = "0"}
, 
[1001128] = {id = 1001128, text = "0"}
, 
[1001129] = {id = 1001129, text = "0"}
, 
[1001130] = {id = 1001130, text = "0"}
, 
[1001131] = {id = 1001131, text = "0"}
, 
[1001132] = {id = 1001132, text = "Add 3 friends"}
, 
[1001134] = {id = 1001134, text = "0"}
, 
[1001135] = {id = 1001135, text = "0"}
, 
[1001136] = {id = 1001136, text = "0"}
, 
[1001137] = {id = 1001137, text = "3 Dolls reach Ascend 2"}
, 
[1001138] = {id = 1001138, text = "Daily Login"}
, 
[1001139] = {id = 1001139, text = "Strong Stamina"}
, 
[1001140] = {id = 1001140, text = "Friend Assist"}
, 
[1001141] = {id = 1001141, text = "Chronospace Duel"}
, 
[1001142] = {id = 1001142, text = "Log in daily."}
, 
[1001143] = {id = 1001143, text = "Consume 60 Stamina"}
, 
[1001144] = {id = 1001144, text = "Clear 1 Main Story with Assiting Doll"}
, 
[1001145] = {id = 1001145, text = "Clear Chronospace Breach once"}
, 
[1001147] = {id = 1001147, text = "Login"}
, 
[1001148] = {id = 1001148, text = "Friend Assist"}
, 
[1001149] = {id = 1001149, text = "Chronospace Duel"}
, 
[1001150] = {id = 1001150, text = "Log into the game."}
, 
[1001151] = {id = 1001151, text = "Defeat enemies with Friend Assist."}
, 
[1001152] = {id = 1001152, text = "Fight against other witches in Chronospace Breach."}
, 
[1001153] = {id = 1001153, text = "Dreamworld"}
, 
[1001154] = {id = 1001154, text = "Clear all Main Stories of Dreamworld"}
, 
[1001155] = {id = 1001155, text = "Complete all Quests of Day 1"}
, 
[1001156] = {id = 1001156, text = "Complete all Quests of Day 2"}
, 
[1001157] = {id = 1001157, text = "Complete all Quests of Day 3"}
, 
[1001158] = {id = 1001158, text = "Complete all Quests of Day 4"}
, 
[1001159] = {id = 1001159, text = "Complete all Quests of Day 5"}
, 
[1001160] = {id = 1001160, text = "Complete all Quests of Day 6"}
, 
[1001161] = {id = 1001161, text = "Complete all Quests of Day 7"}
, 
[1001162] = {id = 1001162, text = "0"}
, 
[1001163] = {id = 1001163, text = "Into the Future"}
, 
[1001164] = {id = 1001164, text = "Chrono Tower"}
, 
[1001165] = {id = 1001165, text = "Return to Chrono Tower"}
, 
[1001166] = {id = 1001166, text = "The chaos in Snegurochka has ended. Back to Chrono Tower, a new adventure awaits you."}
, 
[1001167] = {id = 1001167, text = "Ascend Limit"}
, 
[1001168] = {id = 1001168, text = "Ascend Limit"}
, 
[1001169] = {id = 1001169, text = "Ascend Limit"}
, 
[1001170] = {id = 1001170, text = "3 Dolls reach Ascend 2"}
, 
[1001171] = {id = 1001171, text = "3 Dolls reach Ascend 3"}
, 
[1001172] = {id = 1001172, text = "3 Dolls reach Ascend 4"}
, 
[1001173] = {id = 1001173, text = "6 Dolls reach Evolve 3"}
, 
[1001174] = {id = 1001174, text = "Forging"}
, 
[1001175] = {id = 1001175, text = "Enhance any equipment to Lv.5"}
, 
[1001176] = {id = 1001176, text = "Equipment Ascension"}
, 
[1001177] = {id = 1001177, text = "Ascend equipment once"}
, 
[1001178] = {id = 1001178, text = "Unlock the 2nd skill for 3 dolls"}
, 
[1001179] = {id = 1001179, text = "Unlock the 2nd skill for 6 dolls"}
, 
[1001180] = {id = 1001180, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001181] = {id = 1001181, text = "Clear Dreamworld 5 times"}
, 
[1001182] = {id = 1001182, text = "Unlocks after clearing Main Story 2-2"}
, 
[1001183] = {id = 1001183, text = "Clear Intangible Memory - Dejase"}
, 
[1001184] = {id = 1001184, text = "Unlocks after clearing Main Story 2-13"}
, 
[1001185] = {id = 1001185, text = "Unlocks after clearing Main Story 2-8"}
, 
[1001186] = {id = 1001186, text = "Join Guild"}
, 
[1001187] = {id = 1001187, text = "Unlocks after clearing Main Story 2.5-2"}
, 
[1001188] = {id = 1001188, text = "6 Dolls reach Ascend 2"}
, 
[1001189] = {id = 1001189, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001190] = {id = 1001190, text = "Clear 4 Bosses in Evil Return"}
, 
[1001191] = {id = 1001191, text = "Unlocks after clearing Main Story 3-15"}
, 
[1001192] = {id = 1001192, text = "Win combats in Chronospace Breach 5 times"}
, 
[1001193] = {id = 1001193, text = "Unlocks after clearing Main Story 3.5-2"}
, 
[1001194] = {id = 1001194, text = "Claim rewards 4 times in Mirror of the Otherworld."}
, 
[1001195] = {id = 1001195, text = "Claim rewards 8 times in Mirror of the Otherworld."}
, 
[1001196] = {id = 1001196, text = "Unlocks after clearing Main Story 2-4"}
, 
[1001197] = {id = 1001197, text = "Unlocks after clearing Main Story 2-4"}
, 
[1001198] = {id = 1001198, text = "Unlocks after clearing Main Story 2-2"}
, 
[1001199] = {id = 1001199, text = "Unlocks after clearing Main Story 2-2"}
, 
[1001200] = {id = 1001200, text = "Unlocks after clearing Main Story 2-2"}
, 
[1001201] = {id = 1001201, text = "Unlocks after clearing Main Story 2-2"}
, 
[1001202] = {id = 1001202, text = "Unlocks after clearing Main Story 2-2"}
, 
[1001203] = {id = 1001203, text = "Unlocks after clearing Main Story 2-2"}
, 
[1001204] = {id = 1001204, text = "Unlocks after clearing Main Story 2-2"}
, 
[1001205] = {id = 1001205, text = "Unlocks after clearing Main Story 2-4"}
, 
[1001206] = {id = 1001206, text = "Unlocks after clearing Main Story 2-4"}
, 
[1001207] = {id = 1001207, text = "Unlocks after clearing Main Story 2-8"}
, 
[1001208] = {id = 1001208, text = "Unlocks after clearing Main Story 2-8"}
, 
[1001209] = {id = 1001209, text = "Unlocks after clearing Main Story 3-5"}
, 
[1001210] = {id = 1001210, text = "1 doll wears all Gold equipment"}
, 
[1001211] = {id = 1001211, text = "3 dolls wear all Gold equipment"}
, 
[1001212] = {id = 1001212, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001213] = {id = 1001213, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001214] = {id = 1001214, text = "Send Gift to a Doll 3 times"}
, 
[1001215] = {id = 1001215, text = "Send Gift to a Doll 6 times"}
, 
[1001216] = {id = 1001216, text = "Unlocks after clearing Main Story 1-3"}
, 
[1001217] = {id = 1001217, text = "Unlocks after clearing Main Story 1-3"}
, 
[1001218] = {id = 1001218, text = "Clear Broken Lands 2 times"}
, 
[1001219] = {id = 1001219, text = "Unlocks after clearing Main Story 3-18"}
, 
[1001220] = {id = 1001220, text = "Use Assiting Doll 5 times"}
, 
[1001221] = {id = 1001221, text = "Unlocks after clearing Main Story 2-8"}
, 
[1001222] = {id = 1001222, text = "1 Doll reaches Ascend 3"}
, 
[1001223] = {id = 1001223, text = "3 Dolls reach Ascend 3"}
, 
[1001224] = {id = 1001224, text = "5 Dolls reach Ascend 3"}
, 
[1001225] = {id = 1001225, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001226] = {id = 1001226, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001227] = {id = 1001227, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001228] = {id = 1001228, text = "Clear Dream of Eddine 5 three times"}
, 
[1001229] = {id = 1001229, text = "Clear Dream of Eddine 5 five times"}
, 
[1001230] = {id = 1001230, text = "Win combats in Chronospace Breach 20 times"}
, 
[1001231] = {id = 1001231, text = "Unlocks after clearing Main Story 2-2"}
, 
[1001232] = {id = 1001232, text = "Unlocks after clearing Main Story 2-2"}
, 
[1001233] = {id = 1001233, text = "Unlocks after clearing Main Story 3-5"}
, 
[1001234] = {id = 1001234, text = "1 Doll reaches Ascend 4"}
, 
[1001235] = {id = 1001235, text = "3 Dolls reach Ascend 4"}
, 
[1001236] = {id = 1001236, text = "5 Dolls reach Ascend 4"}
, 
[1001237] = {id = 1001237, text = "Enhance 3 pieces of equipment to Lv.5"}
, 
[1001238] = {id = 1001238, text = "Enhance 6 pieces of equipment to Lv.5"}
, 
[1001239] = {id = 1001239, text = "Clear Main Story 3-18"}
, 
[1001240] = {id = 1001240, text = "Summon Dolls 2 times"}
, 
[1001241] = {id = 1001241, text = "Summon Dolls 4 times"}
, 
[1001242] = {id = 1001242, text = "Summon Dolls 6 times"}
, 
[1001243] = {id = 1001243, text = "Enhance 3 pieces of equipment to Lv.8"}
, 
[1001244] = {id = 1001244, text = "Enhance 6 pieces of equipment to Lv.8"}
, 
[1001245] = {id = 1001245, text = "Clear Main Story 4-11"}
, 
[1001246] = {id = 1001246, text = "Vanquish 2 Monsters"}
, 
[1001247] = {id = 1001247, text = "Vanquish 4 Monsters"}
, 
[1001248] = {id = 1001248, text = "Vanquish 6 Monsters"}
, 
[1001249] = {id = 1001249, text = "Enhance 3 pieces of equipment to Lv.10"}
, 
[1001250] = {id = 1001250, text = "Enhance 6 pieces of equipment to Lv.10"}
, 
[1001251] = {id = 1001251, text = "Unlocks after clearing Main Story 4-20"}
, 
[1001252] = {id = 1001252, text = "Unlocks after clearing Main Story 1-2"}
, 
[1001253] = {id = 1001253, text = "Unlocks after clearing Main Story 2-10"}
, 
[1001254] = {id = 1001254, text = "Having fun? Leave us a comment!"}
, 
[1001255] = {id = 1001255, text = "Unlocks after clearing Main Story 2-8"}
, 
[1001256] = {id = 1001256, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001257] = {id = 1001257, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001258] = {id = 1001258, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001259] = {id = 1001259, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001260] = {id = 1001260, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001261] = {id = 1001261, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001262] = {id = 1001262, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001263] = {id = 1001263, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001264] = {id = 1001264, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001265] = {id = 1001265, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001266] = {id = 1001266, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001267] = {id = 1001267, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001268] = {id = 1001268, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001269] = {id = 1001269, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001270] = {id = 1001270, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001271] = {id = 1001271, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001272] = {id = 1001272, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001273] = {id = 1001273, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001274] = {id = 1001274, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001275] = {id = 1001275, text = "Unlocks after clearing Main Story 2-2"}
, 
[1001276] = {id = 1001276, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001277] = {id = 1001277, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001278] = {id = 1001278, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001279] = {id = 1001279, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001280] = {id = 1001280, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001281] = {id = 1001281, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001282] = {id = 1001282, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001283] = {id = 1001283, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001284] = {id = 1001284, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001285] = {id = 1001285, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001286] = {id = 1001286, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001287] = {id = 1001287, text = "Unlocks after clearing Main Story 1-2"}
, 
[1001288] = {id = 1001288, text = "Unlocks after clearing Main Story 1-2"}
, 
[1001289] = {id = 1001289, text = "Unlocks after clearing Main Story 1-2"}
, 
[1001290] = {id = 1001290, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001291] = {id = 1001291, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001292] = {id = 1001292, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001293] = {id = 1001293, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001294] = {id = 1001294, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001295] = {id = 1001295, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001296] = {id = 1001296, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001297] = {id = 1001297, text = "Unlocks after clearing Main Story 2-10"}
, 
[1001298] = {id = 1001298, text = "Unlocks after clearing Main Story 2-10"}
, 
[1001299] = {id = 1001299, text = "Unlocks after clearing Main Story 2-10"}
, 
[1001300] = {id = 1001300, text = "Unlocks after clearing Main Story 2-4"}
, 
[1001301] = {id = 1001301, text = "Unlocks after clearing Main Story 2-4"}
, 
[1001302] = {id = 1001302, text = "Unlocks after clearing Main Story 2-4"}
, 
[1001303] = {id = 1001303, text = "Unlocks after clearing Main Story 2-8"}
, 
[1001304] = {id = 1001304, text = "Unlocks after clearing Main Story 2-8"}
, 
[1001305] = {id = 1001305, text = "Unlocks after clearing Main Story 2-8"}
, 
[1001306] = {id = 1001306, text = "Unlocks after clearing Main Story 2-8"}
, 
[1001307] = {id = 1001307, text = "Unlocks after clearing Main Story 2-8"}
, 
[1001308] = {id = 1001308, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001309] = {id = 1001309, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001310] = {id = 1001310, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001311] = {id = 1001311, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001312] = {id = 1001312, text = "Unlocks after clearing Main Story 2-8"}
, 
[1001313] = {id = 1001313, text = "Unlocks after clearing Main Story 2-8"}
, 
[1001314] = {id = 1001314, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001315] = {id = 1001315, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001316] = {id = 1001316, text = "Unlocks after clearing Main Story 2-4"}
, 
[1001317] = {id = 1001317, text = "Unlocks after clearing Main Story 2-4"}
, 
[1001318] = {id = 1001318, text = "Unlocks after clearing Main Story 2-4"}
, 
[1001319] = {id = 1001319, text = "Unlocks after clearing Main Story 2-4"}
, 
[1001320] = {id = 1001320, text = "Unlocks after clearing Main Story 2-4"}
, 
[1001321] = {id = 1001321, text = "Unlocks after clearing Main Story 2-4"}
, 
[1001322] = {id = 1001322, text = "Unlocks after clearing Main Story 2-4"}
, 
[1001323] = {id = 1001323, text = "Unlocks after clearing Main Story 2-4"}
, 
[1001324] = {id = 1001324, text = "Unlocks after clearing Main Story 2-4"}
, 
[1001325] = {id = 1001325, text = "Unlocks after clearing Main Story 2-4"}
, 
[1001326] = {id = 1001326, text = "Unlocks after clearing Main Story 2-4"}
, 
[1001327] = {id = 1001327, text = "Unlocks after clearing Main Story 2-4"}
, 
[1001328] = {id = 1001328, text = "Unlocks after clearing Main Story 2-4"}
, 
[1001329] = {id = 1001329, text = "Unlocks after clearing Main Story 3-18"}
, 
[1001330] = {id = 1001330, text = "Unlocks after clearing Main Story 3-18"}
, 
[1001331] = {id = 1001331, text = "Unlocks after clearing Main Story 3-18"}
, 
[1001332] = {id = 1001332, text = "Unlocks after clearing Main Story 3-5"}
, 
[1001333] = {id = 1001333, text = "Unlocks after clearing Main Story 3-5"}
, 
[1001334] = {id = 1001334, text = "Unlocks after clearing Main Story 3-5"}
, 
[1001335] = {id = 1001335, text = "Clear a stage in Dreamworld for the first time"}
, 
[1001336] = {id = 1001336, text = "Magic Tree reaches Lv.3"}
, 
[1001337] = {id = 1001337, text = "Finish 10 quests"}
, 
[1001338] = {id = 1001338, text = "Finish 100 quests"}
, 
[1001339] = {id = 1001339, text = "Finish 200 quests"}
, 
[1001340] = {id = 1001340, text = "First time to clear a stage"}
, 
[1001341] = {id = 1001341, text = "Clear stages 50 times"}
, 
[1001342] = {id = 1001342, text = "Clear stages 100 times"}
, 
[1001343] = {id = 1001343, text = "Have 1 Friend"}
, 
[1001344] = {id = 1001344, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001345] = {id = 1001345, text = "Unlocks after clearing Main Story 2-4"}
, 
[1001346] = {id = 1001346, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001347] = {id = 1001347, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001348] = {id = 1001348, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001349] = {id = 1001349, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001350] = {id = 1001350, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001351] = {id = 1001351, text = "Unlocks after clearing Main Story 1-1"}
, 
[1001352] = {id = 1001352, text = "Unlocks after clearing Main Story 2-8"}
, 
[1001353] = {id = 1001353, text = ""}
, 
[1001354] = {id = 1001354, text = ""}
, 
[1001355] = {id = 1001355, text = ""}
, 
[1001356] = {id = 1001356, text = ""}
, 
[1001357] = {id = 1001357, text = ""}
, 
[1001358] = {id = 1001358, text = ""}
, 
[1001359] = {id = 1001359, text = ""}
, 
[1001360] = {id = 1001360, text = ""}
, 
[1001361] = {id = 1001361, text = ""}
, 
[1001362] = {id = 1001362, text = ""}
, 
[1001363] = {id = 1001363, text = ""}
, 
[1001364] = {id = 1001364, text = ""}
, 
[1001365] = {id = 1001365, text = ""}
, 
[1001366] = {id = 1001366, text = ""}
, 
[1001367] = {id = 1001367, text = ""}
, 
[1001368] = {id = 1001368, text = ""}
, 
[1001369] = {id = 1001369, text = ""}
, 
[1001370] = {id = 1001370, text = ""}
, 
[1001371] = {id = 1001371, text = ""}
, 
[1001372] = {id = 1001372, text = ""}
, 
[1001373] = {id = 1001373, text = ""}
, 
[1001374] = {id = 1001374, text = ""}
, 
[1001375] = {id = 1001375, text = ""}
, 
[1001376] = {id = 1001376, text = ""}
, 
[1001377] = {id = 1001377, text = ""}
, 
[1001378] = {id = 1001378, text = ""}
, 
[1001379] = {id = 1001379, text = ""}
, 
[1001380] = {id = 1001380, text = ""}
, 
[1001381] = {id = 1001381, text = ""}
, 
[1001382] = {id = 1001382, text = ""}
, 
[1001383] = {id = 1001383, text = ""}
, 
[1001384] = {id = 1001384, text = ""}
, 
[1001385] = {id = 1001385, text = ""}
, 
[1001386] = {id = 1001386, text = ""}
, 
[1001387] = {id = 1001387, text = ""}
, 
[1001388] = {id = 1001388, text = ""}
, 
[1001389] = {id = 1001389, text = ""}
, 
[1001390] = {id = 1001390, text = ""}
, 
[1001391] = {id = 1001391, text = ""}
, 
[1001392] = {id = 1001392, text = ""}
, 
[1001393] = {id = 1001393, text = ""}
, 
[1001394] = {id = 1001394, text = ""}
, 
[1001395] = {id = 1001395, text = ""}
, 
[1001396] = {id = 1001396, text = ""}
, 
[1001397] = {id = 1001397, text = ""}
, 
[1001398] = {id = 1001398, text = ""}
, 
[1001399] = {id = 1001399, text = ""}
, 
[1001400] = {id = 1001400, text = ""}
, 
[1001401] = {id = 1001401, text = ""}
, 
[1001402] = {id = 1001402, text = ""}
, 
[1001403] = {id = 1001403, text = ""}
, 
[1001404] = {id = 1001404, text = ""}
, 
[1001405] = {id = 1001405, text = ""}
, 
[1001406] = {id = 1001406, text = ""}
, 
[1001407] = {id = 1001407, text = ""}
, 
[1001408] = {id = 1001408, text = ""}
, 
[1001409] = {id = 1001409, text = ""}
, 
[1001410] = {id = 1001410, text = ""}
, 
[1001411] = {id = 1001411, text = ""}
, 
[1001412] = {id = 1001412, text = ""}
, 
[1001413] = {id = 1001413, text = ""}
, 
[1001414] = {id = 1001414, text = ""}
, 
[1001415] = {id = 1001415, text = ""}
, 
[1001416] = {id = 1001416, text = ""}
, 
[1001417] = {id = 1001417, text = ""}
, 
[1001418] = {id = 1001418, text = ""}
, 
[1001419] = {id = 1001419, text = ""}
, 
[1001420] = {id = 1001420, text = ""}
, 
[1001421] = {id = 1001421, text = ""}
, 
[1001422] = {id = 1001422, text = ""}
, 
[1001423] = {id = 1001423, text = ""}
, 
[1001424] = {id = 1001424, text = ""}
, 
[1001425] = {id = 1001425, text = ""}
, 
[1001426] = {id = 1001426, text = ""}
, 
[1001427] = {id = 1001427, text = ""}
, 
[1001428] = {id = 1001428, text = ""}
, 
[1001429] = {id = 1001429, text = ""}
, 
[1001430] = {id = 1001430, text = ""}
, 
[1001431] = {id = 1001431, text = ""}
, 
[1001432] = {id = 1001432, text = ""}
, 
[1001433] = {id = 1001433, text = ""}
, 
[1001434] = {id = 1001434, text = ""}
, 
[1001435] = {id = 1001435, text = ""}
, 
[1001436] = {id = 1001436, text = ""}
, 
[1001437] = {id = 1001437, text = ""}
, 
[1001438] = {id = 1001438, text = ""}
, 
[1001439] = {id = 1001439, text = ""}
, 
[1001440] = {id = 1001440, text = ""}
, 
[1001441] = {id = 1001441, text = ""}
, 
[1001442] = {id = 1001442, text = ""}
, 
[1001443] = {id = 1001443, text = ""}
, 
[1001444] = {id = 1001444, text = ""}
, 
[1001445] = {id = 1001445, text = ""}
, 
[1001446] = {id = 1001446, text = ""}
, 
[1001447] = {id = 1001447, text = ""}
, 
[1001448] = {id = 1001448, text = ""}
, 
[1001449] = {id = 1001449, text = ""}
, 
[1001450] = {id = 1001450, text = ""}
, 
[1001451] = {id = 1001451, text = ""}
, 
[1001452] = {id = 1001452, text = ""}
, 
[1001453] = {id = 1001453, text = ""}
, 
[1001454] = {id = 1001454, text = ""}
, 
[1001455] = {id = 1001455, text = ""}
, 
[1001456] = {id = 1001456, text = ""}
, 
[1001457] = {id = 1001457, text = ""}
, 
[1001458] = {id = 1001458, text = ""}
, 
[1001459] = {id = 1001459, text = ""}
, 
[1001460] = {id = 1001460, text = ""}
, 
[1001461] = {id = 1001461, text = ""}
, 
[1001462] = {id = 1001462, text = ""}
, 
[1001463] = {id = 1001463, text = ""}
, 
[1001464] = {id = 1001464, text = ""}
, 
[1001465] = {id = 1001465, text = ""}
, 
[1001466] = {id = 1001466, text = ""}
, 
[1001467] = {id = 1001467, text = ""}
, 
[1001468] = {id = 1001468, text = ""}
, 
[1001469] = {id = 1001469, text = ""}
, 
[1001470] = {id = 1001470, text = ""}
, 
[1001471] = {id = 1001471, text = ""}
, 
[1001472] = {id = 1001472, text = ""}
, 
[1001473] = {id = 1001473, text = ""}
, 
[1001474] = {id = 1001474, text = ""}
, 
[1001475] = {id = 1001475, text = ""}
, 
[1001476] = {id = 1001476, text = ""}
, 
[1001477] = {id = 1001477, text = ""}
, 
[1001478] = {id = 1001478, text = ""}
, 
[1001479] = {id = 1001479, text = ""}
, 
[1001480] = {id = 1001480, text = ""}
, 
[1001481] = {id = 1001481, text = ""}
, 
[1001482] = {id = 1001482, text = ""}
, 
[1001483] = {id = 1001483, text = ""}
, 
[1001484] = {id = 1001484, text = ""}
, 
[1001485] = {id = 1001485, text = ""}
, 
[1001486] = {id = 1001486, text = ""}
, 
[1001487] = {id = 1001487, text = ""}
, 
[1001488] = {id = 1001488, text = ""}
, 
[1001489] = {id = 1001489, text = ""}
, 
[1001490] = {id = 1001490, text = ""}
, 
[1001491] = {id = 1001491, text = ""}
, 
[1001492] = {id = 1001492, text = ""}
, 
[1001493] = {id = 1001493, text = ""}
, 
[1001494] = {id = 1001494, text = ""}
, 
[1001495] = {id = 1001495, text = ""}
, 
[1001496] = {id = 1001496, text = ""}
, 
[1001497] = {id = 1001497, text = ""}
, 
[1001498] = {id = 1001498, text = ""}
, 
[1001499] = {id = 1001499, text = ""}
, 
[1001500] = {id = 1001500, text = ""}
, 
[1001501] = {id = 1001501, text = ""}
, 
[1001502] = {id = 1001502, text = ""}
, 
[1001503] = {id = 1001503, text = ""}
, 
[1001504] = {id = 1001504, text = ""}
, 
[1001505] = {id = 1001505, text = ""}
, 
[1001506] = {id = 1001506, text = ""}
, 
[1001507] = {id = 1001507, text = ""}
, 
[1001508] = {id = 1001508, text = ""}
, 
[1001509] = {id = 1001509, text = ""}
, 
[1001510] = {id = 1001510, text = ""}
, 
[1001511] = {id = 1001511, text = ""}
}
cwordtask_en.AllIds = {1000001, 1000002, 1000004, 1000006, 1000009, 1000010, 1000013, 1000015, 1000016, 1000017, 1000018, 1000019, 1000020, 1000021, 1000022, 1000023, 1000024, 1000025, 1000026, 1000027, 1000028, 1000029, 1000030, 1000031, 1000032, 1000033, 1000034, 1000035, 1000036, 1000037, 1000038, 1000039, 1000040, 1000041, 1000042, 1000043, 1000044, 1000045, 1000046, 1000047, 1000048, 1000049, 1000050, 1000051, 1000052, 1000053, 1000054, 1000055, 1000056, 1000057, 1000058, 1000059, 1000060, 1000061, 1000062, 1000063, 1000065, 1000066, 1000067, 1000068, 1000069, 1000070, 1000071, 1000072, 1000073, 1000074, 1000075, 1000076, 1000077, 1000078, 1000079, 1000080, 1000081, 1000082, 1000083, 1000084, 1000085, 1000086, 1000087, 1000088, 1000089, 1000090, 1000091, 1000092, 1000094, 1000096, 1000099, 1000100, 1000101, 1000102, 1000103, 1000105, 1000106, 1000107, 1000108, 1000109, 1000110, 1000111, 1000112, 1000113, 1000114, 1000115, 1000116, 1000117, 1000118, 1000119, 1000120, 1000121, 1000122, 1000123, 1000124, 1000125, 1000126, 1000127, 1000128, 1000129, 1000130, 1000131, 1000132, 1000133, 1000134, 1000135, 1000136, 1000137, 1000138, 1000139, 1000140, 1000141, 1000142, 1000143, 1000144, 1000145, 1000146, 1000147, 1000148, 1000150, 1000152, 1000155, 1000156, 1000159, 1000161, 1000162, 1000163, 1000164, 1000165, 1000166, 1000167, 1000168, 1000169, 1000170, 1000171, 1000172, 1000173, 1000174, 1000175, 1000176, 1000177, 1000178, 1000179, 1000180, 1000181, 1000182, 1000183, 1000184, 1000185, 1000186, 1000187, 1000188, 1000189, 1000190, 1000191, 1000192, 1000193, 1000194, 1000195, 1000196, 1000197, 1000198, 1000199, 1000200, 1000201, 1000202, 1000203, 1000232, 1000233, 1000234, 1000235, 1000236, 1000237, 1000238, 1000239, 1000240, 1000241, 1000242, 1000243, 1000244, 1000245, 1000246, 1000247, 1000248, 1000249, 1000250, 1000251, 1000252, 1000253, 1000254, 1000255, 1000256, 1000257, 1000258, 1000259, 1000260, 1000261, 1000262, 1000263, 1000264, 1000265, 1000266, 1000267, 1000268, 1000269, 1000270, 1000271, 1000272, 1000273, 1000274, 1000275, 1000276, 1000277, 1000278, 1000279, 1000280, 1000281, 1000282, 1000283, 1000284, 1000285, 1000286, 1000287, 1000288, 1000289, 1000290, 1000291, 1000293, 1000294, 1000295, 1000296, 1000297, 1000298, 1000299, 1000300, 1000301, 1000302, 1000303, 1000304, 1000305, 1000307, 1000308, 1000309, 1000310, 1000311, 1000312, 1000313, 1000314, 1000315, 1000316, 1000317, 1000318, 1000319, 1000321, 1000322, 1000323, 1000324, 1000325, 1000326, 1000327, 1000328, 1000329, 1000330, 1000331, 1000332, 1000333, 1000335, 1000336, 1000337, 1000338, 1000340, 1000341, 1000342, 1000343, 1000344, 1000348, 1000349, 1000350, 1000351, 1000352, 1000353, 1000354, 1000355, 1000356, 1000357, 1000358, 1000359, 1000361, 1000362, 1000363, 1000364, 1000365, 1000366, 1000368, 1000370, 1000371, 1000372, 1000374, 1000375, 1000376, 1000378, 1000384, 1000385, 1000386, 1000391, 1000392, 1000393, 1000394, 1000395, 1000396, 1000398, 1000401, 1000402, 1000403, 1000406, 1000407, 1000408, 1000412, 1000413, 1000414, 1000415, 1000417, 1000418, 1000420, 1000421, 1000425, 1000426, 1000427, 1000428, 1000429, 1000430, 1000431, 1000432, 1000433, 1000434, 1000435, 1000436, 1000438, 1000439, 1000440, 1000441, 1000442, 1000443, 1000444, 1000445, 1000447, 1000448, 1000449, 1000451, 1000452, 1000453, 1000455, 1000461, 1000462, 1000463, 1000468, 1000469, 1000470, 1000471, 1000472, 1000473, 1000475, 1000479, 1000483, 1000484, 1000485, 1000489, 1000501, 1000502, 1000601, 1000602, 1000644, 1000645, 1000646, 1000647, 1000648, 1000649, 1000650, 1000651, 1000652, 1000653, 1000654, 1000655, 1000656, 1000657, 1000658, 1000659, 1000660, 1000661, 1000662, 1000663, 1000664, 1000665, 1000666, 1000667, 1000668, 1000669, 1000670, 1000671, 1000679, 1000682, 1000683, 1000684, 1000701, 1000705, 1000706, 1000707, 1000708, 1000709, 1000710, 1000711, 1000712, 1000713, 1000714, 1000715, 1000716, 1000717, 1000718, 1000719, 1000720, 1000721, 1000722, 1000723, 1000724, 1000725, 1000726, 1000727, 1000728, 1000729, 1000730, 1000731, 1000732, 1000733, 1000734, 1000735, 1000736, 1000740, 1000741, 1000742, 1000743, 1000744, 1000745, 1000746, 1000747, 1000748, 1000749, 1000750, 1000752, 1000753, 1000757, 1000758, 1000759, 1000760, 1000761, 1000762, 1000763, 1000764, 1000765, 1000766, 1000767, 1000769, 1000770, 1000771, 1000772, 1000773, 1000774, 1000775, 1000776, 1000777, 1000778, 1000779, 1000780, 1000781, 1000782, 1000783, 1000784, 1000785, 1000786, 1000787, 1000788, 1000789, 1000790, 1000791, 1000792, 1000793, 1000794, 1000795, 1000796, 1000797, 1000798, 1000799, 1000800, 1000801, 1000802, 1000803, 1000804, 1000805, 1000806, 1000807, 1000808, 1000809, 1000810, 1000811, 1000812, 1000813, 1000814, 1000815, 1000816, 1000817, 1000818, 1000819, 1000820, 1000821, 1000822, 1000823, 1000824, 1000825, 1000826, 1000827, 1000828, 1000829, 1000830, 1000831, 1000832, 1000833, 1000834, 1000835, 1000836, 1000837, 1000838, 1000839, 1000840, 1000841, 1000842, 1000843, 1000844, 1000845, 1000846, 1000847, 1000848, 1000849, 1000850, 1000851, 1000852, 1000853, 1000854, 1000855, 1000856, 1000857, 1000858, 1000859, 1000860, 1000861, 1000862, 1000863, 1000864, 1000865, 1000866, 1000867, 1000868, 1000869, 1000870, 1000871, 1000872, 1000873, 1000874, 1000875, 1000876, 1000877, 1000878, 1000879, 1000880, 1000881, 1000882, 1000883, 1000884, 1000885, 1000886, 1000887, 1000888, 1000889, 1000890, 1000891, 1000892, 1000893, 1000894, 1000901, 1000902, 1000903, 1000921, 1000922, 1000923, 1000924, 1000925, 1000926, 1000927, 1000928, 1000929, 1000930, 1000955, 1000956, 1000957, 1000958, 1000959, 1000960, 1000961, 1000962, 1000963, 1000964, 1000965, 1000966, 1000967, 1000968, 1000969, 1000970, 1000971, 1000972, 1000973, 1000974, 1000975, 1000976, 1000977, 1000978, 1000979, 1000980, 1000981, 1000982, 1000983, 1000984, 1000985, 1000988, 1000989, 1000990, 1000991, 1000992, 1000993, 1000994, 1000995, 1000996, 1000997, 1000998, 1000999, 1001000, 1001001, 1001002, 1001003, 1001004, 1001005, 1001006, 1001007, 1001010, 1001011, 1001012, 1001013, 1001014, 1001015, 1001016, 1001017, 1001018, 1001019, 1001020, 1001021, 1001022, 1001023, 1001024, 1001025, 1001026, 1001027, 1001028, 1001029, 1001030, 1001031, 1001032, 1001033, 1001034, 1001035, 1001036, 1001037, 1001038, 1001039, 1001040, 1001041, 1001042, 1001043, 1001044, 1001045, 1001046, 1001047, 1001048, 1001049, 1001050, 1001051, 1001052, 1001053, 1001054, 1001055, 1001056, 1001057, 1001058, 1001059, 1001060, 1001061, 1001062, 1001063, 1001064, 1001065, 1001066, 1001067, 1001068, 1001069, 1001070, 1001071, 1001072, 1001073, 1001074, 1001075, 1001076, 1001077, 1001078, 1001079, 1001080, 1001081, 1001082, 1001083, 1001084, 1001085, 1001086, 1001087, 1001088, 1001089, 1001090, 1001091, 1001092, 1001093, 1001094, 1001095, 1001096, 1001097, 1001098, 1001099, 1001100, 1001101, 1001102, 1001103, 1001104, 1001105, 1001106, 1001107, 1001108, 1001109, 1001110, 1001111, 1001112, 1001113, 1001114, 1001115, 1001116, 1001117, 1001118, 1001119, 1001120, 1001121, 1001122, 1001123, 1001124, 1001125, 1001126, 1001127, 1001128, 1001129, 1001130, 1001131, 1001132, 1001134, 1001135, 1001136, 1001137, 1001138, 1001139, 1001140, 1001141, 1001142, 1001143, 1001144, 1001145, 1001147, 1001148, 1001149, 1001150, 1001151, 1001152, 1001153, 1001154, 1001155, 1001156, 1001157, 1001158, 1001159, 1001160, 1001161, 1001162, 1001163, 1001164, 1001165, 1001166, 1001167, 1001168, 1001169, 1001170, 1001171, 1001172, 1001173, 1001174, 1001175, 1001176, 1001177, 1001178, 1001179, 1001180, 1001181, 1001182, 1001183, 1001184, 1001185, 1001186, 1001187, 1001188, 1001189, 1001190, 1001191, 1001192, 1001193, 1001194, 1001195, 1001196, 1001197, 1001198, 1001199, 1001200, 1001201, 1001202, 1001203, 1001204, 1001205, 1001206, 1001207, 1001208, 1001209, 1001210, 1001211, 1001212, 1001213, 1001214, 1001215, 1001216, 1001217, 1001218, 1001219, 1001220, 1001221, 1001222, 1001223, 1001224, 1001225, 1001226, 1001227, 1001228, 1001229, 1001230, 1001231, 1001232, 1001233, 1001234, 1001235, 1001236, 1001237, 1001238, 1001239, 1001240, 1001241, 1001242, 1001243, 1001244, 1001245, 1001246, 1001247, 1001248, 1001249, 1001250, 1001251, 1001252, 1001253, 1001254, 1001255, 1001256, 1001257, 1001258, 1001259, 1001260, 1001261, 1001262, 1001263, 1001264, 1001265, 1001266, 1001267, 1001268, 1001269, 1001270, 1001271, 1001272, 1001273, 1001274, 1001275, 1001276, 1001277, 1001278, 1001279, 1001280, 1001281, 1001282, 1001283, 1001284, 1001285, 1001286, 1001287, 1001288, 1001289, 1001290, 1001291, 1001292, 1001293, 1001294, 1001295, 1001296, 1001297, 1001298, 1001299, 1001300, 1001301, 1001302, 1001303, 1001304, 1001305, 1001306, 1001307, 1001308, 1001309, 1001310, 1001311, 1001312, 1001313, 1001314, 1001315, 1001316, 1001317, 1001318, 1001319, 1001320, 1001321, 1001322, 1001323, 1001324, 1001325, 1001326, 1001327, 1001328, 1001329, 1001330, 1001331, 1001332, 1001333, 1001334, 1001335, 1001336, 1001337, 1001338, 1001339, 1001340, 1001341, 1001342, 1001343, 1001344, 1001345, 1001346, 1001347, 1001348, 1001349, 1001350, 1001351, 1001352, 1001353, 1001354, 1001355, 1001356, 1001357, 1001358, 1001359, 1001360, 1001361, 1001362, 1001363, 1001364, 1001365, 1001366, 1001367, 1001368, 1001369, 1001370, 1001371, 1001372, 1001373, 1001374, 1001375, 1001376, 1001377, 1001378, 1001379, 1001380, 1001381, 1001382, 1001383, 1001384, 1001385, 1001386, 1001387, 1001388, 1001389, 1001390, 1001391, 1001392, 1001393, 1001394, 1001395, 1001396, 1001397, 1001398, 1001399, 1001400, 1001401, 1001402, 1001403, 1001404, 1001405, 1001406, 1001407, 1001408, 1001409, 1001410, 1001411, 1001412, 1001413, 1001414, 1001415, 1001416, 1001417, 1001418, 1001419, 1001420, 1001421, 1001422, 1001423, 1001424, 1001425, 1001426, 1001427, 1001428, 1001429, 1001430, 1001431, 1001432, 1001433, 1001434, 1001435, 1001436, 1001437, 1001438, 1001439, 1001440, 1001441, 1001442, 1001443, 1001444, 1001445, 1001446, 1001447, 1001448, 1001449, 1001450, 1001451, 1001452, 1001453, 1001454, 1001455, 1001456, 1001457, 1001458, 1001459, 1001460, 1001461, 1001462, 1001463, 1001464, 1001465, 1001466, 1001467, 1001468, 1001469, 1001470, 1001471, 1001472, 1001473, 1001474, 1001475, 1001476, 1001477, 1001478, 1001479, 1001480, 1001481, 1001482, 1001483, 1001484, 1001485, 1001486, 1001487, 1001488, 1001489, 1001490, 1001491, 1001492, 1001493, 1001494, 1001495, 1001496, 1001497, 1001498, 1001499, 1001500, 1001501, 1001502, 1001503, 1001504, 1001505, 1001506, 1001507, 1001508, 1001509, 1001510, 1001511}
return cwordtask_en

