-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/word/cwordyard_en.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cwordyard_en = {}
cwordyard_en.Data = {
[800001] = {id = 800001, text = "Magic Tree"}
, 
[800002] = {id = 800002, text = "Mirror of the Otherworld"}
, 
[800003] = {id = 800003, text = "Firefly Lampstand"}
, 
[800004] = {id = 800004, text = "Alchemy Lab"}
, 
[800005] = {id = 800005, text = "Cottage"}
, 
[800006] = {id = 800006, text = "Ancient Castle"}
, 
[800007] = {id = 800007, text = "Basement Library"}
, 
[800008] = {id = 800008, text = "Liminal Cave"}
, 
[800009] = {id = 800009, text = "Blue Garden"}
, 
[800010] = {id = 800010, text = "Swamp"}
, 
[800011] = {id = 800011, text = "Pine Forest of Monsters"}
, 
[800012] = {id = 800012, text = "Hunting Grounds"}
, 
[800013] = {id = 800013, text = "Bay of Wolves"}
, 
[800014] = {id = 800014, text = "Ice Cavern"}
, 
[800015] = {id = 800015, text = "Storage Room"}
, 
[800016] = {id = 800016, text = "Arctic Mine"}
, 
[800017] = {id = 800017, text = "Weapons Chamber"}
, 
[800018] = {id = 800018, text = "Ancient Battlefield"}
, 
[800019] = {id = 800019, text = "An ancient castle deep in the forest, long uninhabited."}
, 
[800020] = {id = 800020, text = "A rarely-visited library. Its bookshelves are covered with dust."}
, 
[800021] = {id = 800021, text = "A cave that sees no light all year round. Rustling noises can be heard echoing from within."}
, 
[800022] = {id = 800022, text = "A sea of blue flowers crafted by nature, just like the garden of a goddess."}
, 
[800023] = {id = 800023, text = "A sprawling swampland crawling with monsters."}
, 
[800024] = {id = 800024, text = "A vast pine forest that reeks of the odor of monsters."}
, 
[800025] = {id = 800025, text = "A habitat for rare and unique birds and beasts. It\'s an ideal hunting ground."}
, 
[800026] = {id = 800026, text = "Countless wolf packs gather here, as though guided by something."}
, 
[800027] = {id = 800027, text = "A frigid Ice Cavern that has not thawed for thousands of years."}
, 
[800028] = {id = 800028, text = "A storage room for the old nobles that has all sorts of items on display."}
, 
[800029] = {id = 800029, text = "A gigantic mine sparsely trodden. Many moons have passed since it last saw the breath of living creatures."}
, 
[800030] = {id = 800030, text = "The expeditionary force\'s armory, its banners are all worn beyond recognition."}
, 
[800031] = {id = 800031, text = "A bleak, ancient battlefield where the smoke of wars past has long since cleared."}
, 
[800032] = {id = 800032, text = "<color=#8CECFAff>Novice</color>"}
, 
[800033] = {id = 800033, text = "<color=#8CECFAff>Explorer</color>"}
, 
[800034] = {id = 800034, text = "<color=#FBFAA5ff>Combination</color>"}
, 
[800035] = {id = 800035, text = "<color=#FBFAA5ff>Alchemy</color>"}
, 
[800036] = {id = 800036, text = "<color=#F5A09Bff>Housework Novice</color>"}
, 
[800037] = {id = 800037, text = "<color=#F5A09Bff>Housework Jourmeyman</color>"}
, 
[800038] = {id = 800038, text = "When exploring the <color=#8CECFAff>Mirror of the Otherworld</color>, the generation rate of byproducts increases by <color=#FFCA65ff>6%</color>."}
, 
[800039] = {id = 800039, text = "When exploring the <color=#8CECFAff>Mirror of the Otherworld </color>, the generation rate of byproducts increases by <color=#FFCA65ff>8%</color>."}
, 
[800040] = {id = 800040, text = "When alchemizing <color=#FBFAA5ff>Quartz</color>, increases byproduct drop rate by <color=#FFCA65ff>6%</color>."}
, 
[800041] = {id = 800041, text = "When alchemizing <color=#FBFAA5ff>Quartz</color>, increases byproduct drop rate by <color=#FFCA65ff>8%</color>."}
, 
[800042] = {id = 800042, text = "In the <color=#F5A09Bff>Cottage</color>, the Energy recovery rate of all Dolls on this floor increases by <color=#FFCA65ff>6%</color>."}
, 
[800043] = {id = 800043, text = "In the <color=#F5A09Bff>Cottage</color>, the Energy recovery rate of all Dolls on this floor increases by <color=#FFCA65ff>8%</color>."}
, 
[800044] = {id = 800044, text = "White Light Limit; 100; <color=#FFCA65ff>500</color>"}
, 
[800045] = {id = 800045, text = "White Light Limit; 500; <color=#FFCA65ff>2,000</color>"}
, 
[800046] = {id = 800046, text = "Unlock Mirror of the Otherworld"}
, 
[800047] = {id = 800047, text = "Unlock more <color=#A8D5FDff>Easy</color> Exploration spots"}
, 
[800048] = {id = 800048, text = "Unlock more <color=#F6B6FFff>Normal</color> Exploration spots"}
, 
[800049] = {id = 800049, text = "Unlock more <color=#F9DB86ff>Hard</color> Exploration spots"}
, 
[800050] = {id = 800050, text = "Light the Firefly Lampstand"}
, 
[800051] = {id = 800051, text = "Chromatic Light Limit; 0; <color=#FFCA65ff>2,000</color>"}
, 
[800052] = {id = 800052, text = "Unlock Alchemy Lab"}
, 
[800053] = {id = 800053, text = "You can alchemize <color=#F6B6FFff>Purple</color> Quartz"}
, 
[800054] = {id = 800054, text = "You can alchemize <color=#F9DB86ff>Gold</color> Materials"}
, 
[800055] = {id = 800055, text = "Build Cottage"}
, 
[800056] = {id = 800056, text = "Add second floor to the Cottage"}
, 
[800057] = {id = 800057, text = "Material"}
, 
[800058] = {id = 800058, text = "Quartz"}
, 
[800059] = {id = 800059, text = "Floor"}
, 
[800060] = {id = 800060, text = "Wallpaper"}
, 
[800061] = {id = 800061, text = "Windows"}
, 
[800062] = {id = 800062, text = "Bulky Item"}
, 
[800063] = {id = 800063, text = "Compact Item"}
, 
[800064] = {id = 800064, text = "Carpet"}
, 
[800065] = {id = 800065, text = "Wall Decor"}
, 
[800066] = {id = 800066, text = "Witch Chamber"}
, 
[800067] = {id = 800067, text = "Gothic Chamber"}
, 
[800068] = {id = 800068, text = "European Chamber"}
, 
[800069] = {id = 800069, text = "Add third floor to the Cottage"}
, 
[800070] = {id = 800070, text = "<color=#8CECFAff>Adventurer</color>"}
, 
[800071] = {id = 800071, text = "<color=#FBFAA5ff>Midas Touch</color>"}
, 
[800072] = {id = 800072, text = "<color=#F5A09Bff>Versatile Butler</color>"}
, 
[800073] = {id = 800073, text = "When exploring the <color=#8CECFAff>Mirror of the Otherworld</color>, the generation rate of byproducts increases by <color=#FFCA65ff>10%</color>."}
, 
[800074] = {id = 800074, text = "When alchemizing <color=#FBFAA5ff>Quartz</color>, increases byproduct drop rate by <color=#FFCA65ff>10%</color>."}
, 
[800075] = {id = 800075, text = "In the <color=#F5A09Bff>Cottage</color>, the Energy recovery rate of all Dolls on this floor increases by <color=#FFCA65ff>10%</color>."}
, 
[800076] = {id = 800076, text = "Firefly Lampstand can absorb Dark Light"}
, 
[800077] = {id = 800077, text = "Dark Light Limit; 100; <color=#FFCA65ff>2,000</color>"}
, 
[800078] = {id = 800078, text = "Building Level Limit Increased"}
, 
[800079] = {id = 800079, text = "Teams Dispatched; 1; <color=#FFCA65ff>2</color>"}
, 
[800080] = {id = 800080, text = "Teams Dispatched; 2; <color=#FFCA65ff>3</color>"}
, 
[800081] = {id = 800081, text = "Teams Dispatched; 3; <color=#FFCA65ff>4</color>"}
, 
[800082] = {id = 800082, text = "First"}
, 
[800083] = {id = 800083, text = "Second"}
, 
[800084] = {id = 800084, text = "Third"}
, 
[800085] = {id = 800085, text = "Currently settled <color=#FFFFFFff>$parameter1$</color>/$parameter2$"}
, 
[800086] = {id = 800086, text = "Dispatch Dolls to help <color=#FBFAA5ff>alchemize</color>, <color=#FFCA65ff> increasing the drop rate of byproducts</color>."}
, 
[800087] = {id = 800087, text = "Dispatch Dolls to <color=#FFCA65ff>increase Energy recovery rate</color> of all Dolls on the same floor."}
, 
[800088] = {id = 800088, text = "Dispatch Dolls to explore the <color=#8CECFAff>Mirror of the Otherworld</color>, <color=#FFCA65ff> increasing the drop rate of byproducts</color>."}
, 
[800089] = {id = 800089, text = "The Witch and Dolls have been fiddling with bottles and jars in their spare time. What did they come up with today?"}
, 
[800090] = {id = 800090, text = "Maybe at their pinnacle, alchemy and magic will bestow true life to Dolls."}
, 
[800091] = {id = 800091, text = "Both alchemy and magic can give Dolls life, but what\'s the difference?"}
, 
[800092] = {id = 800092, text = "When tired of waiting in the tower, Erina might rest under the tree and continue waiting for the Witch to return."}
, 
[800093] = {id = 800093, text = "How tall can the Magic Tree grow? Everyone is curious."}
, 
[800094] = {id = 800094, text = "Stepping into the courtyard and looking at dots of fluorescence on the Magic Tree, you may wonder who will outlive the other: you or the tree?"}
, 
[800095] = {id = 800095, text = "This will be the best resting place."}
, 
[800096] = {id = 800096, text = "Everyone likes the tea made by Erina."}
, 
[800097] = {id = 800097, text = "The wooden hut reminds one of simpler times past."}
, 
[800098] = {id = 800098, text = "Every adventure is full of surprises."}
, 
[800099] = {id = 800099, text = "Where does this strange mirror come from?"}
, 
[800100] = {id = 800100, text = "\"You are not truly yourself when you think you are.\" \"You are yourself when you think you aren\'t.\""}
, 
[800101] = {id = 800101, text = "Fluorescence represents the fire of life. Basked in its brilliance, you can see why the courtyard is so vibrant."}
, 
[800102] = {id = 800102, text = "The most anticipated event at the courtyard at summer\'s end is dolling up in festive costumes and enjoying the \"Requiem\" of the fireflies in the courtyard with the Dolls."}
, 
[800103] = {id = 800103, text = "\"Requiem, requiem.\" \"Where art thou, rest seekers?\""}
, 
[800104] = {id = 800104, text = "The source of life that controls the <color=#FFCA65ff>expansion of all buildings</color> in the Witch Courtyard."}
, 
[800105] = {id = 800105, text = "Fireflies <color=#FFCA65ff>collect all kinds of fluorescence</color> and maintain the ecological balance of the Witch Courtyard."}
, 
[800106] = {id = 800106, text = "Analyst"}
, 
[800107] = {id = 800107, text = "Deconstructor"}
, 
[800108] = {id = 800108, text = "Apprentice"}
, 
[800109] = {id = 800109, text = "Reforger"}
, 
[800110] = {id = 800110, text = "Consummator"}
, 
[800111] = {id = 800111, text = "Alchemy Bonus"}
, 
[800112] = {id = 800112, text = "Lv.$parameter1$ Alchemy Required"}
, 
[800113] = {id = 800113, text = "Bonus:"}
, 
[800114] = {id = 800114, text = "The generation of basic byproducts increases by <color=#FFCA65ff>$parameter1$%</color>"}
, 
[800115] = {id = 800115, text = "Thick as Thieves—\nDoll Alchemy Bonus: <color=#FFCA65ff>x$parameter1$</color>"}
, 
[800116] = {id = 800116, text = "Creatio ex Nihilo—\n<color=#FFCA65ff>$parameter1$%</color> chance of making the amount of byproducts <color=#FFCA65ff>x$parameter2$</color>."}
, 
[800117] = {id = 800117, text = "<color=#FBFAA5ff>Creatio ex Nihilo Triggered</color>"}
, 
[800118] = {id = 800118, text = "Unlocks at Alchemy Lab Lv.$parameter1$"}
, 
[800119] = {id = 800119, text = "<color=#93B4E0ff>Alchemy Lab Lv.1</color>"}
, 
[800120] = {id = 800120, text = "<color=#F6B6FFff>Alchemy Lab Lv.2</color>"}
, 
[800121] = {id = 800121, text = "<color=#F9DB86ff>Alchemy Lab Lv.3</color>"}
, 
[800122] = {id = 800122, text = "<color=#A6B8ECff>Co</color><color=#BDB0EBff>lor</color><color=#CCA4F1ff>Qua</color><color=#EEB5E8ff>lity</color>"}
, 
[800123] = {id = 800123, text = "<color=#FFFFFFff>Exhausted</color>"}
, 
[800124] = {id = 800124, text = "<color=#FFFFFFff>Dolls are Exhausted, Courtyard skills inactive.</color>"}
, 
[800125] = {id = 800125, text = "<color=#FFFFFFff>Insufficient Energy. When Energy drains, Courtyard skill will be inactive.</color>"}
, 
[800126] = {id = 800126, text = "<color=#9E9887ff>Generation of basic byproducts:</color>"}
, 
[800127] = {id = 800127, text = "<color=#9E9887ff>Consume Alchemy EXP</color> <color=#FBFAA5ff>$parameter1$</color>"}
, 
[800128] = {id = 800128, text = "<color=#9E9887ff>No Alchemy Bonus</color>"}
, 
[800129] = {id = 800129, text = "<color=#EC4C1Aff>(x$parameter1$)</color>"}
, 
[800130] = {id = 800130, text = "<color=#F9DB86ff>Alchemy Ledger</color>"}
, 
[800131] = {id = 800131, text = "<color=#FFFFFFff>EXP</color><color=#FDC964ff>+$parameter1$</color>"}
, 
[800132] = {id = 800132, text = "<color=#9E9887ff>$parameter1$</color>"}
, 
[800133] = {id = 800133, text = "<color=#FBFAA5ff>$parameter1$</color>"}
, 
[800134] = {id = 800134, text = "<color=#FBFAA5ff>$parameter1$</color>"}
, 
[800135] = {id = 800135, text = "-"}
, 
[800136] = {id = 800136, text = "<color=#9E9887ff>$parameter1$</color>"}
, 
[800137] = {id = 800137, text = "<color=#FBFAA5ff> + $parameter1$</color>"}
, 
[800138] = {id = 800138, text = "<color=#FFDB72ff>+$parameter1$/min</color>"}
, 
[800139] = {id = 800139, text = "<color=#FFFFFFff>Uncollected</color>"}
, 
[800140] = {id = 800140, text = "<color=#FFFFFFff>Full</color>"}
, 
[800141] = {id = 800141, text = "<color=#FFDB72ff>Dispatch Fireflies</color>"}
, 
[800142] = {id = 800142, text = "<color=#FFFFFFff>Total Fireflies</color>"}
, 
[800143] = {id = 800143, text = "<color=#FFFFFFff>$parameter1$/$parameter2$</color>"}
, 
[800144] = {id = 800144, text = "<color=#FFDB72ff>$parameter1$</color><color=#FFFFFFff>/$parameter2$</color>"}
, 
[800145] = {id = 800145, text = "<color=#DF4242ff>0</color><color=#FFFFFFff>/$parameter1$</color>"}
, 
[800146] = {id = 800146, text = "<color=#FFFFFFff>+$parameter1$</color>"}
, 
[800147] = {id = 800147, text = "<color=#FFFFFFff>-$parameter1$</color>"}
, 
[800148] = {id = 800148, text = "<color=#FFFFFFff>Dispatch All</color>"}
, 
[800149] = {id = 800149, text = "<color=#FFFFFFff>Recall All</color>"}
, 
[800150] = {id = 800150, text = "<color=#FFFFFFff>Dispatch</color>"}
, 
[800151] = {id = 800151, text = "<color=#FFFFFFff>You need to dispatch 1 Firefly to collect White Light, 3 to collect Dark Light, and 5 to collect Chromatic Light.</color>"}
, 
[800152] = {id = 800152, text = "<color=#FFFFFFff>$parameter1$</color>"}
, 
[800153] = {id = 800153, text = "<color=#FFFFFFff>Glister and glitter over here, endless yearning across the river.</color>"}
, 
[800154] = {id = 800154, text = "<color=#FFFFFFff>The fireflies, burdened with longing, dye it colorfully.</color>"}
, 
[800155] = {id = 800155, text = "<color=#FFFFFFff>The pitch-black ocean is dotted with pale light.</color>"}
, 
[800156] = {id = 800156, text = "<color=#FFFFFFff>Can you feel that faraway longing in your slumber?</color>"}
, 
[800157] = {id = 800157, text = "<color=#FFFFFFff>+</color>"}
, 
[800158] = {id = 800158, text = "<color=#FFFFFFff>MAX</color>"}
, 
[800159] = {id = 800159, text = "Dark Light Limit; 1,000; <color=#FFCA65ff>2,000</color>"}
, 
[800160] = {id = 800160, text = "Fluorescence Training"}
, 
[800161] = {id = 800161, text = "Fluorescence Enhancement"}
, 
[800162] = {id = 800162, text = "Fluorescence Mastery"}
, 
[800163] = {id = 800163, text = "<color=#A8D5FDff>Easy</color>"}
, 
[800164] = {id = 800164, text = "<color=#F6B6FFff>Normal</color>"}
, 
[800165] = {id = 800165, text = "<color=#F9DB86ff>Hard</color>"}
, 
[800166] = {id = 800166, text = "Expert"}
, 
[800167] = {id = 800167, text = "Unlock <color=#F9DB86ff>Fluorescence Villa</color>"}
, 
[800168] = {id = 800168, text = "Training Session Limit; 3; <color=#FFCA65ff>5</color>"}
, 
[800169] = {id = 800169, text = "Unlock <color=#F6B6FFff>Normal</color> training sessions"}
, 
[800170] = {id = 800170, text = "Training Session Limit; 5; <color=#FFCA65ff>6</color>"}
, 
[800171] = {id = 800171, text = "Unlock <color=#F9DB86ff>Hard</color>&Expert training sessions"}
, 
[800172] = {id = 800172, text = "Fluorescence Villa"}
, 
[800173] = {id = 800173, text = "Training List"}
, 
[800174] = {id = 800174, text = "<color=#FFCA65ff>$parameter1$</color>"}
, 
[800175] = {id = 800175, text = "<color=#DF4242ff>-$parameter1$</color>"}
, 
[800176] = {id = 800176, text = "$parameter1$:$parameter2$:$parameter3$"}
, 
[800177] = {id = 800177, text = "Training Finished"}
, 
[800178] = {id = 800178, text = "Available at Training School Lv.$parameter1$"}
, 
[800179] = {id = 800179, text = "Lv.$parameter1$/$parameter2$"}
, 
[800180] = {id = 800180, text = "Fluorescence Villa"}
, 
[800181] = {id = 800181, text = "Training..."}
, 
[800182] = {id = 800182, text = ""}
, 
[800183] = {id = 800183, text = ""}
, 
[800184] = {id = 800184, text = "A <color=#7AA9D4ff>training place</color> where fluorescence is used to <color=#FFCA65ff>enhance the power of Dolls</color>."}
, 
[800185] = {id = 800185, text = "The power of longing brings miracles."}
, 
[800186] = {id = 800186, text = "Some are training hard, while others are slacking off."}
, 
[800187] = {id = 800187, text = "Rumor has it that when all kinds of fluorescence are converged to a point, wonderful things will happen."}
, 
[800188] = {id = 800188, text = "Ascending Order"}
, 
[800189] = {id = 800189, text = "Descending Order"}
, 
[800190] = {id = 800190, text = "Unlock the <color=#DBEB7Dff>Music Box</color>"}
, 
[800191] = {id = 800191, text = "Music Box"}
, 
[800192] = {id = 800192, text = "An antique music box found in the Cottage, judging by its well-kept condition, the previous owner must have cherished it."}
, 
[800193] = {id = 800193, text = ""}
, 
[800194] = {id = 800194, text = ""}
, 
[800195] = {id = 800195, text = ""}
, 
[800196] = {id = 800196, text = ""}
, 
[800197] = {id = 800197, text = ""}
, 
[800198] = {id = 800198, text = ""}
, 
[800199] = {id = 800199, text = ""}
, 
[800200] = {id = 800200, text = ""}
, 
[800201] = {id = 800201, text = ""}
, 
[800202] = {id = 800202, text = ""}
, 
[800203] = {id = 800203, text = ""}
, 
[800204] = {id = 800204, text = ""}
, 
[800205] = {id = 800205, text = ""}
, 
[800206] = {id = 800206, text = ""}
, 
[800207] = {id = 800207, text = ""}
, 
[800208] = {id = 800208, text = ""}
, 
[800209] = {id = 800209, text = ""}
, 
[800210] = {id = 800210, text = ""}
, 
[800211] = {id = 800211, text = ""}
, 
[800212] = {id = 800212, text = ""}
, 
[800213] = {id = 800213, text = ""}
, 
[800214] = {id = 800214, text = ""}
, 
[800215] = {id = 800215, text = ""}
, 
[800216] = {id = 800216, text = ""}
, 
[800217] = {id = 800217, text = ""}
, 
[800218] = {id = 800218, text = ""}
, 
[800219] = {id = 800219, text = ""}
, 
[800220] = {id = 800220, text = ""}
, 
[800221] = {id = 800221, text = ""}
, 
[800222] = {id = 800222, text = "Clear Main Story $parameter1$ to unlock the next music piece"}
, 
[800223] = {id = 800223, text = "Awakening"}
, 
[800224] = {id = 800224, text = "Revived Witch"}
, 
[800225] = {id = 800225, text = "The Forest"}
, 
[800226] = {id = 800226, text = "Mysterious Black Cat"}
, 
[800227] = {id = 800227, text = "Tower Atrium"}
, 
[800228] = {id = 800228, text = "The Guardian"}
, 
[800229] = {id = 800229, text = "Victory Fanfare"}
, 
[800230] = {id = 800230, text = "Main Menu"}
, 
[800231] = {id = 800231, text = "Chrono Tower"}
, 
[800232] = {id = 800232, text = "Spellbooks"}
, 
[800233] = {id = 800233, text = "Through the Mirror"}
, 
[800234] = {id = 800234, text = "Keeper of Time"}
, 
[800235] = {id = 800235, text = "Magic Forest of Irminsul"}
, 
[800236] = {id = 800236, text = "Forest Defenders"}
, 
[800237] = {id = 800237, text = "Irminsul Night"}
, 
[800238] = {id = 800238, text = "Frog Chevalier"}
, 
[800239] = {id = 800239, text = "Heart of the Forest"}
, 
[800240] = {id = 800240, text = "Forest Goddess"}
, 
[800241] = {id = 800241, text = "Anemone"}
, 
[800242] = {id = 800242, text = "Snegurochka"}
, 
[800243] = {id = 800243, text = "Campfire"}
, 
[800244] = {id = 800244, text = "Ice Plains of Snegurochka"}
, 
[800245] = {id = 800245, text = "Hunters and Wolves"}
, 
[800246] = {id = 800246, text = "Heart of Ice"}
, 
[800247] = {id = 800247, text = "Ice Goddess"}
, 
[800248] = {id = 800248, text = "Goddess\' Regret"}
, 
[800249] = {id = 800249, text = "The Silver Lake"}
, 
[800250] = {id = 800250, text = "Before the Storm"}
, 
[800251] = {id = 800251, text = "Together We Can Save this World"}
, 
[800252] = {id = 800252, text = "Descent"}
, 
[800253] = {id = 800253, text = "Lava Lake"}
, 
[800254] = {id = 800254, text = "The Root of Magma"}
, 
[800255] = {id = 800255, text = "Heart of Fire"}
, 
[800256] = {id = 800256, text = "All the World Against Me"}
, 
[800257] = {id = 800257, text = "The Beginning of the End"}
, 
[800258] = {id = 800258, text = "Cradle of Demise"}
, 
[800259] = {id = 800259, text = "Balance Is Restored"}
, 
[800260] = {id = 800260, text = ""}
, 
[800261] = {id = 800261, text = ""}
, 
[800262] = {id = 800262, text = ""}
, 
[800263] = {id = 800263, text = ""}
, 
[800264] = {id = 800264, text = "Seth Tsui"}
, 
[800265] = {id = 800265, text = "Serenity-I -"}
, 
[800266] = {id = 800266, text = "Calling-I -"}
, 
[800267] = {id = 800267, text = "Echoes of Lost Time"}
, 
[800268] = {id = 800268, text = "Illusions Forgotten by Time"}
, 
[800269] = {id = 800269, text = "Serenity-II -"}
, 
[800270] = {id = 800270, text = "Calling-II -"}
, 
[800271] = {id = 800271, text = "Melancholy of Laksha"}
, 
[800272] = {id = 800272, text = "Teardrop of Memory"}
, 
[800273] = {id = 800273, text = "Fellagood\'s Ambition"}
, 
[800274] = {id = 800274, text = "Through the Maelstrom"}
, 
[800275] = {id = 800275, text = "Yesterday in Irminsul"}
, 
[800276] = {id = 800276, text = "Loss of Time"}
, 
[800277] = {id = 800277, text = "Close to the Heaven"}
, 
[800278] = {id = 800278, text = "Win by Myself"}
, 
[800279] = {id = 800279, text = "In the Clouds"}
, 
[800280] = {id = 800280, text = "Abgrund"}
, 
[800281] = {id = 800281, text = "To the Black Abyss"}
, 
[800282] = {id = 800282, text = "Cursed Tail"}
, 
[800283] = {id = 800283, text = "Caos Toccata "}
, 
[800284] = {id = 800284, text = "Banquet of Solaris Dimas"}
, 
[800285] = {id = 800285, text = ""}
, 
[800286] = {id = 800286, text = ""}
, 
[800287] = {id = 800287, text = ""}
, 
[800288] = {id = 800288, text = ""}
, 
[800289] = {id = 800289, text = ""}
, 
[800290] = {id = 800290, text = ""}
, 
[800291] = {id = 800291, text = ""}
, 
[800292] = {id = 800292, text = ""}
, 
[800293] = {id = 800293, text = ""}
, 
[800294] = {id = 800294, text = ""}
, 
[800295] = {id = 800295, text = ""}
, 
[800296] = {id = 800296, text = ""}
, 
[800297] = {id = 800297, text = ""}
, 
[800298] = {id = 800298, text = ""}
, 
[800299] = {id = 800299, text = ""}
, 
[800300] = {id = 800300, text = ""}
, 
[800301] = {id = 800301, text = ""}
, 
[800302] = {id = 800302, text = ""}
, 
[800303] = {id = 800303, text = ""}
, 
[800304] = {id = 800304, text = ""}
, 
[800305] = {id = 800305, text = ""}
, 
[800306] = {id = 800306, text = ""}
, 
[800307] = {id = 800307, text = ""}
, 
[800308] = {id = 800308, text = ""}
, 
[800309] = {id = 800309, text = ""}
, 
[800310] = {id = 800310, text = ""}
, 
[800311] = {id = 800311, text = ""}
, 
[800312] = {id = 800312, text = ""}
, 
[800313] = {id = 800313, text = ""}
, 
[800314] = {id = 800314, text = ""}
, 
[800315] = {id = 800315, text = "You can listen to music by turning on <color=#DBEB7Dff>Music Box</color>."}
, 
[800316] = {id = 800316, text = "You can alchemize more <color=#F9DB86ff>Gold</color> Materials now."}
, 
[800317] = {id = 800317, text = "You can alchemize <color=#F9DB86ff>Gold</color> Quartz now."}
, 
[800318] = {id = 800318, text = "You can alchemize <color=#93B4E0ff>Blue</color> Quartz now."}
, 
[800319] = {id = 800319, text = "<color=#FFFFFFff>-$parameter1$</color>"}
, 
[800320] = {id = 800320, text = "Theme"}
, 
[800321] = {id = 800321, text = "A simple room full of memories."}
, 
[800322] = {id = 800322, text = "A room with a sense of whimsy."}
, 
[800323] = {id = 800323, text = "This exquisite room brims with elegance."}
, 
[800324] = {id = 800324, text = "All"}
, 
[800325] = {id = 800325, text = "No furniture matching the keyword"}
, 
[800326] = {id = 800326, text = "Starry Garden"}
, 
[800327] = {id = 800327, text = "Take you into the romantic Starry Garden."}
, 
[800328] = {id = 800328, text = "Utility Room"}
, 
[800329] = {id = 800329, text = "Purple Garden"}
, 
[800330] = {id = 800330, text = "An unfrequented utility room where many useful items can be found."}
, 
[800331] = {id = 800331, text = "A garden full of purple flowers, among which seemingly hides something shimmering."}
, 
[800332] = {id = 800332, text = "Witch"}
, 
[800333] = {id = 800333, text = ""}
, 
[800334] = {id = 800334, text = ""}
, 
[800335] = {id = 800335, text = ""}
}
cwordyard_en.AllIds = {800001, 800002, 800003, 800004, 800005, 800006, 800007, 800008, 800009, 800010, 800011, 800012, 800013, 800014, 800015, 800016, 800017, 800018, 800019, 800020, 800021, 800022, 800023, 800024, 800025, 800026, 800027, 800028, 800029, 800030, 800031, 800032, 800033, 800034, 800035, 800036, 800037, 800038, 800039, 800040, 800041, 800042, 800043, 800044, 800045, 800046, 800047, 800048, 800049, 800050, 800051, 800052, 800053, 800054, 800055, 800056, 800057, 800058, 800059, 800060, 800061, 800062, 800063, 800064, 800065, 800066, 800067, 800068, 800069, 800070, 800071, 800072, 800073, 800074, 800075, 800076, 800077, 800078, 800079, 800080, 800081, 800082, 800083, 800084, 800085, 800086, 800087, 800088, 800089, 800090, 800091, 800092, 800093, 800094, 800095, 800096, 800097, 800098, 800099, 800100, 800101, 800102, 800103, 800104, 800105, 800106, 800107, 800108, 800109, 800110, 800111, 800112, 800113, 800114, 800115, 800116, 800117, 800118, 800119, 800120, 800121, 800122, 800123, 800124, 800125, 800126, 800127, 800128, 800129, 800130, 800131, 800132, 800133, 800134, 800135, 800136, 800137, 800138, 800139, 800140, 800141, 800142, 800143, 800144, 800145, 800146, 800147, 800148, 800149, 800150, 800151, 800152, 800153, 800154, 800155, 800156, 800157, 800158, 800159, 800160, 800161, 800162, 800163, 800164, 800165, 800166, 800167, 800168, 800169, 800170, 800171, 800172, 800173, 800174, 800175, 800176, 800177, 800178, 800179, 800180, 800181, 800182, 800183, 800184, 800185, 800186, 800187, 800188, 800189, 800190, 800191, 800192, 800193, 800194, 800195, 800196, 800197, 800198, 800199, 800200, 800201, 800202, 800203, 800204, 800205, 800206, 800207, 800208, 800209, 800210, 800211, 800212, 800213, 800214, 800215, 800216, 800217, 800218, 800219, 800220, 800221, 800222, 800223, 800224, 800225, 800226, 800227, 800228, 800229, 800230, 800231, 800232, 800233, 800234, 800235, 800236, 800237, 800238, 800239, 800240, 800241, 800242, 800243, 800244, 800245, 800246, 800247, 800248, 800249, 800250, 800251, 800252, 800253, 800254, 800255, 800256, 800257, 800258, 800259, 800260, 800261, 800262, 800263, 800264, 800265, 800266, 800267, 800268, 800269, 800270, 800271, 800272, 800273, 800274, 800275, 800276, 800277, 800278, 800279, 800280, 800281, 800282, 800283, 800284, 800285, 800286, 800287, 800288, 800289, 800290, 800291, 800292, 800293, 800294, 800295, 800296, 800297, 800298, 800299, 800300, 800301, 800302, 800303, 800304, 800305, 800306, 800307, 800308, 800309, 800310, 800311, 800312, 800313, 800314, 800315, 800316, 800317, 800318, 800319, 800320, 800321, 800322, 800323, 800324, 800325, 800326, 800327, 800328, 800329, 800330, 800331, 800332, 800333, 800334, 800335}
return cwordyard_en

