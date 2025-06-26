-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/npc/cmonsterconfig.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cmonsterconfig = {}
cmonsterconfig.Data = {
[10015] = {id = 10015, name = "歌唱家索雷优", nameTextID = 1400001, shapeID = 10041, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 40, hpConstant = "61261;61261;61261", attackConstant = "766", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201035, 201036}
, bodytype = 1, behaviacAI = "newbattleai10015", defaultBuff = "", MonsterType = 223, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[10016] = {id = 10016, name = "石像怪", nameTextID = 1400181, shapeID = 20154, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 1, hpConstant = "600", attackConstant = "15", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "40", damagereduce = "0", attackID = 0, 
skillid = {201641}
, bodytype = 1, behaviacAI = "newbattleaif109", defaultBuff = "", MonsterType = 109, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[10017] = {id = 10017, name = "巨狐", nameTextID = 1400002, shapeID = 10045, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 1, hpConstant = "600", attackConstant = "20", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "40", damagereduce = "0", attackID = 0, 
skillid = {201010}
, bodytype = 1, behaviacAI = "newbattleaif101", defaultBuff = "", MonsterType = 101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20001] = {id = 20001, name = "守护者 埃舍雷", nameTextID = 1400003, shapeID = 20001, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 75, hpConstant = "94248;94248;94248;94248;94248", attackConstant = "1226", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "25", damagereduce = "0", attackID = 201044, 
skillid = {201044, 201045, 201046, 201216, 201662}
, bodytype = 1, behaviacAI = "newbattleaif228", defaultBuff = "20116", MonsterType = 228, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20003] = {id = 20003, name = "石像鬼", nameTextID = 1400004, shapeID = 20003, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 5, hpConstant = "1800", attackConstant = "15", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "0", damagereduce = "0", attackID = 201017, 
skillid = {201017, 201008, 201363}
, bodytype = 1, behaviacAI = "newbattleaif106", defaultBuff = "20116", MonsterType = 106, soulQuantity = 10, MonsterStyle = 3, typeStyle = 0}
, 
[20004] = {id = 20004, name = "测试怪物", nameTextID = 1400005, shapeID = 20001, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 10, hpConstant = "20238", attackConstant = "120", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "0", damagereduce = "0", attackID = 201216, 
skillid = {201216}
, bodytype = 1, behaviacAI = "newbattleaitest05", defaultBuff = "20116", MonsterType = 33, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20005] = {id = 20005, name = "石像鬼", nameTextID = 1400004, shapeID = 20003, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 5, hpConstant = "1800", attackConstant = "15", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "0", damagereduce = "0", attackID = 201017, 
skillid = {201017, 201008, 201254, 201255, 201363}
, bodytype = 1, behaviacAI = "newbattleaif106_weak", defaultBuff = "20116", MonsterType = 106, soulQuantity = 10, MonsterStyle = 3, typeStyle = 0}
, 
[20007] = {id = 20007, name = "次元监视者", nameTextID = 1400006, shapeID = 20006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 10, hpConstant = "7700;7700;7700;7700", attackConstant = "80", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "0", damagereduce = "0", attackID = 201012, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215, 201260, 201261, 201262, 201263}
, bodytype = 1, behaviacAI = "newbattleai20007", defaultBuff = "20116", MonsterType = 108, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20008] = {id = 20008, name = "次元监视者", nameTextID = 1400006, shapeID = 20006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 10, hpConstant = "7700;7700;7700;7700", attackConstant = "80", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "0", damagereduce = "0", attackID = 201012, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215, 201260, 201261, 201262, 201263}
, bodytype = 1, behaviacAI = "newbattleai20007_weak", defaultBuff = "20116", MonsterType = 108, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20014] = {id = 20014, name = "司祭 弗莱尔", nameTextID = 1400007, shapeID = 20016, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 50, hpConstant = "70686;70686;70686;70686;70686", attackConstant = "894", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201025, 201026, 201031, 201049}
, bodytype = 1, behaviacAI = "newbattleai20014", defaultBuff = "", MonsterType = 227, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20015] = {id = 20015, name = "石巨人", nameTextID = 1400008, shapeID = 10043, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 15, hpConstant = "17731;17731;17731;17731", attackConstant = "120", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201027, 201028, 201029, 201037, 201059, 201642, 201643, 201644, 201645}
, bodytype = 1, behaviacAI = "newbattleai20015", defaultBuff = "20116", MonsterType = 220, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20054] = {id = 20054, name = "骑士 费吉亚", nameTextID = 1400009, shapeID = 5024, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 30, hpConstant = "28370", attackConstant = "500", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "25", damagereduce = "0", attackID = 0, 
skillid = {201032, 201033, 201034}
, bodytype = 1, behaviacAI = "newbattleai20054", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 4, typeStyle = 0}
, 
[20055] = {id = 20055, name = "木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 1, hpConstant = "30000000", attackConstant = "500", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "40", damagereduce = "0", attackID = 0, 
skillid = {201406, 201407, 201408}
, bodytype = 1, behaviacAI = "newbattleaimuzhuang", defaultBuff = "", MonsterType = 1, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20056] = {id = 20056, name = "怨念聚合体", nameTextID = 1400011, shapeID = 20030, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 8, hpConstant = "6000;6000;6000", attackConstant = "60", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "20", damagereduce = "0", attackID = 201042, 
skillid = {201038, 201039, 201040, 201042, 201256, 201257, 201258, 201259}
, bodytype = 1, behaviacAI = "newbattleai20057", defaultBuff = "20116", MonsterType = 107, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20057] = {id = 20057, name = "怨念聚合体", nameTextID = 1400011, shapeID = 20030, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 8, hpConstant = "6000;6000;6000", attackConstant = "60", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "20", damagereduce = "0", attackID = 201042, 
skillid = {201038, 201039, 201040, 201042, 201256, 201257, 201258, 201259}
, bodytype = 1, behaviacAI = "newbattleai20057", defaultBuff = "20116", MonsterType = 107, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20058] = {id = 20058, name = "怨念聚合体", nameTextID = 1400011, shapeID = 20030, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 8, hpConstant = "6000;6000;6000", attackConstant = "60", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "20", damagereduce = "0", attackID = 201042, 
skillid = {201038, 201039, 201040, 201042, 201256, 201257, 201258, 201259}
, bodytype = 1, behaviacAI = "newbattleai20057", defaultBuff = "20116", MonsterType = 107, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20130] = {id = 20130, name = "兰花螳螂", nameTextID = 1400012, shapeID = 20031, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 35, hpConstant = "27000", attackConstant = "500", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201050, 201051, 201052, 201061, 201060}
, bodytype = 1, behaviacAI = "newbattleai20130", defaultBuff = "", MonsterType = 221, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[20131] = {id = 20131, name = "幽灵螳螂", nameTextID = 1400013, shapeID = 20032, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 35, hpConstant = "27000", attackConstant = "500", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201053, 201054, 201055}
, bodytype = 1, behaviacAI = "newbattleai20131", defaultBuff = "", MonsterType = 222, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[20132] = {id = 20132, name = "孢子", nameTextID = 1400014, shapeID = 20033, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 75, hpConstant = "17992", attackConstant = "634", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201063, 201064}
, bodytype = 1, behaviacAI = "newbattleaif224", defaultBuff = "", MonsterType = 224, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20143] = {id = 20143, name = "孢子", nameTextID = 1400014, shapeID = 20033, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 40, hpConstant = "11695", attackConstant = "400", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201063, 201064}
, bodytype = 1, behaviacAI = "newbattleaif224", defaultBuff = "20116", MonsterType = 224, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20144] = {id = 20144, name = "孢子", nameTextID = 1400014, shapeID = 20033, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "15293", attackConstant = "532", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201063, 201064}
, bodytype = 1, behaviacAI = "newbattleaif224", defaultBuff = "20116", MonsterType = 224, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20160] = {id = 20160, name = "白熊 赫沃奥塔", nameTextID = 1400015, shapeID = 20072, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 130, hpConstant = "270613;270613;270613;270613;270613", attackConstant = "2918", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201159, 201160, 201161, 201162, 201213, 201272, 201307, 201306}
, bodytype = 1, behaviacAI = "newbattleaif420_2", defaultBuff = "20116", MonsterType = 420, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20161] = {id = 20161, name = "守护者 瑟希薇", nameTextID = 1400016, shapeID = 20061, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "444074;444074;444074;444074;444074", attackConstant = "5185", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201280, 201142, 201145, 201147, 201148, 201150, 201203, 201204, 201205, 201206, 201143, 201144, 201146, 201149, 201212, 201340, 201163}
, bodytype = 1, behaviacAI = "newbattleaif421", defaultBuff = "20116", MonsterType = 421, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20167] = {id = 20167, name = "热血的猎人", nameTextID = 1400017, shapeID = 20045, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 95, hpConstant = "220763;220763;220763", attackConstant = "2293", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201102, 201104, 201105, 201106}
, bodytype = 1, behaviacAI = "newbattleaIf406", defaultBuff = "", MonsterType = 406, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20168] = {id = 20168, name = "雪狼", nameTextID = 1400018, shapeID = 20042, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 100, hpConstant = "227884;227884;227884", attackConstant = "2380", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201088, 201089, 201090, 201091, 201210}
, bodytype = 1, behaviacAI = "newbattleaI20168", defaultBuff = "", MonsterType = 407, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20174] = {id = 20174, name = "骑士团团长", nameTextID = 1400019, shapeID = 20059, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 135, hpConstant = "277734;277734;277734;277734;277734", attackConstant = "3011", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201118, 201119, 201120, 201121, 201122, 201123, 201124, 201395, 201396, 201397, 201398, 201399}
, bodytype = 1, behaviacAI = "newbattleaif419_2", defaultBuff = "20116", MonsterType = 419, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20180] = {id = 20180, name = "骑士团哨兵队长", nameTextID = 1400020, shapeID = 20046, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "256370;256370;256370", attackConstant = "2736", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201133, 201134, 201135, 201136, 201393}
, bodytype = 1, behaviacAI = "newbattleaif415", defaultBuff = "", MonsterType = 415, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20181] = {id = 20181, name = "骑士团卫兵队长", nameTextID = 1400021, shapeID = 20047, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 125, hpConstant = "263491;263491;263491", attackConstant = "2827", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201137, 201138, 201139, 201140, 201394}
, bodytype = 1, behaviacAI = "newbattleaif416", defaultBuff = "", MonsterType = 416, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20182] = {id = 20182, name = "元素使 艾妮萌", nameTextID = 1400022, shapeID = 5014, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 80, hpConstant = "140000;140000;140000;140000", attackConstant = "1750", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201128, 201129, 201130, 201131, 201132, 201331, 201332, 201333}
, bodytype = 1, behaviacAI = "newbattleaif306", defaultBuff = "", MonsterType = 306, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20184] = {id = 20184, name = "冰墙", nameTextID = 1400023, shapeID = 20062, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 52, hpConstant = "13854", attackConstant = "478", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {}
, bodytype = 1, behaviacAI = "newbattleaif417", defaultBuff = "20116", MonsterType = 417, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20185] = {id = 20185, name = "骑士团哨兵", nameTextID = 1400024, shapeID = 20043, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "48943", attackConstant = "1375", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201097, 201098, 201101}
, bodytype = 1, behaviacAI = "newbattleaif413", defaultBuff = "", MonsterType = 413, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20186] = {id = 20186, name = "骑士团卫兵", nameTextID = 1400025, shapeID = 20038, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 125, hpConstant = "50302", attackConstant = "1419", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201099, 201100, 201101}
, bodytype = 1, behaviacAI = "newbattleaif414", defaultBuff = "", MonsterType = 414, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20187] = {id = 20187, name = "白熊 赫沃奥塔", nameTextID = 1400015, shapeID = 20072, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 115, hpConstant = "200000;200000;200000;200000;200000", attackConstant = "2250", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201159, 201160, 201161, 201162, 201213, 201272, 201307}
, bodytype = 1, behaviacAI = "newbattleaif420", defaultBuff = "20116", MonsterType = 420, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20188] = {id = 20188, name = "冰蕊", nameTextID = 1400026, shapeID = 20076, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "84777", attackConstant = "2527", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201211}
, bodytype = 1, behaviacAI = "newbattleaif418", defaultBuff = "20116", MonsterType = 418, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20189] = {id = 20189, name = "幼狼", nameTextID = 1400027, shapeID = 20034, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "36333", attackConstant = "1263", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201077, 201090, 201091}
, bodytype = 1, behaviacAI = "newbattleaif401", defaultBuff = "", MonsterType = 401, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20202] = {id = 20202, name = "骸骨蛇", nameTextID = 1400028, shapeID = 20080, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "452298;452298;452298", attackConstant = "5307", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201222, 201221, 201223, 201391}
, bodytype = 1, behaviacAI = "newbattleaif504_2", defaultBuff = "", MonsterType = 504, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20203] = {id = 20203, name = "献祭深渊的少女 古尔薇格", nameTextID = 1400029, shapeID = 1027, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "452298;452298;452298;452298", attackConstant = "5307", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201364, 201365, 201366, 201367, 201368, 201369, 201376, 201377, 201379, 201390}
, bodytype = 1, behaviacAI = "newbattleaif505", defaultBuff = "20116", MonsterType = 505, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20204] = {id = 20204, name = "炼金术师 德亚丝", nameTextID = 1400030, shapeID = 1017, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "380000;380000;380000;380000", attackConstant = "4600", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201281, 201282, 201283, 201284, 201285, 201286, 201287, 201289, 201485, 201486}
, bodytype = 1, behaviacAI = "newbattleai20204", defaultBuff = "20116", MonsterType = 506, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20205] = {id = 20205, name = "白熊 赫沃奥塔", nameTextID = 1400015, shapeID = 20072, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "400000;400000;400000;400000;400000", attackConstant = "4750", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201159, 201160, 201161, 201162, 201213, 201272}
, bodytype = 1, behaviacAI = "newbattleaif420_2", defaultBuff = "20116", MonsterType = 420, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20206] = {id = 20206, name = "冰封熔岩兽", nameTextID = 1400126, shapeID = 20082, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "500000", attackConstant = "5500", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 201237, 
skillid = {201237, 201236}
, bodytype = 1, behaviacAI = "newbattleaif606", defaultBuff = "", MonsterType = 606, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20207] = {id = 20207, name = "骑士团哨兵", nameTextID = 1400024, shapeID = 20043, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "500000", attackConstant = "5500", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201097, 201098, 201101}
, bodytype = 1, behaviacAI = "newbattleaif413", defaultBuff = "", MonsterType = 413, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20208] = {id = 20208, name = "骑士团卫兵", nameTextID = 1400025, shapeID = 20038, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "500000", attackConstant = "5500", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201099, 201100, 201101}
, bodytype = 1, behaviacAI = "newbattleaif414", defaultBuff = "", MonsterType = 414, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20209] = {id = 20209, name = "守护者瑟希薇", nameTextID = 1400032, shapeID = 20061, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "509863;509863;509863;509863;509863", attackConstant = "6187", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201280, 201142, 201145, 201147, 201148, 201150, 201203, 201204, 201205, 201206, 201143, 201144, 201146, 201149, 201212, 201340, 201163}
, bodytype = 1, behaviacAI = "newbattleaif421", defaultBuff = "20116", MonsterType = 421, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20210] = {id = 20210, name = "冰墙", nameTextID = 1400023, shapeID = 20062, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "97337", attackConstant = "2995", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {}
, bodytype = 1, behaviacAI = "newbattleaif417", defaultBuff = "20116", MonsterType = 417, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20211] = {id = 20211, name = "冰蕊", nameTextID = 1400026, shapeID = 20076, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "97337", attackConstant = "2995", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201211}
, bodytype = 1, behaviacAI = "newbattleaif418", defaultBuff = "20116", MonsterType = 418, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20212] = {id = 20212, name = "冰封熔岩兽", nameTextID = 1400126, shapeID = 20082, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 185, hpConstant = "250000", attackConstant = "3500", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 201237, 
skillid = {201237, 201236, 201238, 201239}
, bodytype = 1, behaviacAI = "newbattleaif606", defaultBuff = "", MonsterType = 606, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20213] = {id = 20213, name = "熔岩巨兽", nameTextID = 1400033, shapeID = 20084, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "526310;526310;526310;526310;526310", attackConstant = "6446", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201241, 201242, 201243, 201244, 201245, 201372}
, bodytype = 1, behaviacAI = "newbattleaif608_2", defaultBuff = "20116", MonsterType = 608, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20214] = {id = 20214, name = "熔岩兽", nameTextID = 1400034, shapeID = 20083, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "300000", attackConstant = "4000", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201239, 201238}
, bodytype = 1, behaviacAI = "newbattleaif607", defaultBuff = "", MonsterType = 607, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20215] = {id = 20215, name = "赤色战姬 凯忒丝", nameTextID = 1400035, shapeID = 1032, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "526310;526310;526310;526310;526310", attackConstant = "3200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201321, 201322, 201323, 201324, 201325, 201326, 201327, 201328, 201329, 201330}
, bodytype = 1, behaviacAI = "newbattleai20215", defaultBuff = "", MonsterType = 609, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20216] = {id = 20216, name = "地狱之焰 辛莫拉", nameTextID = 1400036, shapeID = 10047, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 195, hpConstant = "534534;534534;534534;534534", attackConstant = "6578", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201308, 201309, 201310, 201311, 201312, 201370, 201373}
, bodytype = 1, behaviacAI = "newbattleai20216", defaultBuff = "20116", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20217] = {id = 20217, name = "熔岩兽", nameTextID = 1400034, shapeID = 20076, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "105187", attackConstant = "3300", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201211}
, bodytype = 1, behaviacAI = "newbattleaif418", defaultBuff = "20116", MonsterType = 607, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20218] = {id = 20218, name = "地狱之焰 辛莫拉", nameTextID = 1400036, shapeID = 10048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "2729160;2729160;2729160;2729160", attackConstant = "24312", defConstant = "7560", magicattConstant = "0", magicDefConstant = "22680", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201313, 201314, 201315, 201316, 201317, 201318, 201319, 201370, 201371, 201374}
, bodytype = 1, behaviacAI = "newbattleai20218", defaultBuff = "20116", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20219] = {id = 20219, name = "熔岩兽", nameTextID = 1400034, shapeID = 20076, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "105187", attackConstant = "3300", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201211}
, bodytype = 1, behaviacAI = "newbattleaif418", defaultBuff = "20116", MonsterType = 607, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20220] = {id = 20220, name = "地狱之焰 辛莫拉", nameTextID = 1400036, shapeID = 10050, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "2729160;2729160;2729160;2729160", attackConstant = "24312", defConstant = "7560", magicattConstant = "0", magicDefConstant = "22680", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201308, 201309, 201310, 201311, 201312, 201370, 201373}
, bodytype = 1, behaviacAI = "newbattleai20220", defaultBuff = "20116", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20221] = {id = 20221, name = "怨念体", nameTextID = 1400037, shapeID = 20079, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "105187", attackConstant = "3300", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201219, 201218}
, bodytype = 1, behaviacAI = "newbattleaif502", defaultBuff = "", MonsterType = 502, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20222] = {id = 20222, name = "熔岩兽", nameTextID = 1400034, shapeID = 10051, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "105187", attackConstant = "3300", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201239, 201238}
, bodytype = 1, behaviacAI = "newbattleaif607_2", defaultBuff = "", MonsterType = 607, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20227] = {id = 20227, name = "元素使 艾妮萌", nameTextID = 1400022, shapeID = 5014, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "1000000", attackConstant = "6977", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201128, 201129, 201130, 201131, 201132, 201331, 201332, 201333}
, bodytype = 1, behaviacAI = "newbattleai20227", defaultBuff = "", MonsterType = 306, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20228] = {id = 20228, name = "双子绞杀者", nameTextID = 1400136, shapeID = 20141, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 265, hpConstant = "2000000;2000000;2000000", attackConstant = "14500", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201418, 201419, 201420, 201421, 201422, 201620}
, bodytype = 1, behaviacAI = "newbattleai20228", defaultBuff = "", MonsterType = 816, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20229] = {id = 20229, name = "暗影艾琳娜", nameTextID = 1400137, shapeID = 20140, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "750000;750000;750000", attackConstant = "5500", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201412, 201413, 201414, 201415, 201416, 201417}
, bodytype = 1, behaviacAI = "newbattleai20229", defaultBuff = "20943", MonsterType = 705, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20230] = {id = 20230, name = "牧师 费拉古德", nameTextID = 1400144, shapeID = 20124, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1750000;1750000;1750000;1750000", attackConstant = "13500", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201539, 201540, 201541, 201542, 201543, 201544}
, bodytype = 1, behaviacAI = "newbattleaif817", defaultBuff = "20116", MonsterType = 817, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20231] = {id = 20231, name = "空之主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20129, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 280, hpConstant = "2500000;2500000", attackConstant = "14000", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201566, 201567, 201568, 201569}
, bodytype = 1, behaviacAI = "newbattleaif818_tail", defaultBuff = "20116", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20232] = {id = 20232, name = "空之主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20130, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 280, hpConstant = "2500000;2500000;2500000", attackConstant = "14000", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201570, 201571, 201572, 201573, 201574, 201575}
, bodytype = 1, behaviacAI = "newbattleaif818_body", defaultBuff = "20116", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20233] = {id = 20233, name = "空之主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20131, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 280, hpConstant = "2500000;2500000;2500000;2500000", attackConstant = "14000", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201576, 201577, 201578, 201579, 201580, 201581, 201582}
, bodytype = 1, behaviacAI = "newbattleaif818_head", defaultBuff = "20116", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20234] = {id = 20234, name = "索拉迪乌斯的子嗣", nameTextID = 1400146, shapeID = 20132, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 280, hpConstant = "140000", attackConstant = "5000", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201583}
, bodytype = 1, behaviacAI = "newbattleaif819", defaultBuff = "20116", MonsterType = 819, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20235] = {id = 20235, name = "索拉迪乌斯的子嗣", nameTextID = 1400146, shapeID = 20133, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 280, hpConstant = "140000", attackConstant = "5000", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201583}
, bodytype = 1, behaviacAI = "newbattleaif819", defaultBuff = "20116", MonsterType = 819, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20236] = {id = 20236, name = "索拉迪乌斯的子嗣", nameTextID = 1400146, shapeID = 20134, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 280, hpConstant = "140000", attackConstant = "5000", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201583}
, bodytype = 1, behaviacAI = "newbattleaif819", defaultBuff = "20116", MonsterType = 819, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20237] = {id = 20237, name = "飞翼魔狼", nameTextID = 1400139, shapeID = 20107, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "1500000;1500000;1500000", attackConstant = "8000", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201444, 201445, 201446, 201447, 201448, 201449}
, bodytype = 1, behaviacAI = "newbattleaif809_1", defaultBuff = "20116", MonsterType = 809, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20238] = {id = 20238, name = "杀人蜂", nameTextID = 1400154, shapeID = 20116, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "1500000;1500000;1500000", attackConstant = "8000", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201490, 201491, 201492}
, bodytype = 1, behaviacAI = "newbattleaif812", defaultBuff = "", MonsterType = 812, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20239] = {id = 20239, name = "蝠翼飞狮", nameTextID = 1400157, shapeID = 20117, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 235, hpConstant = "1200000;1200000;1200000;1200000", attackConstant = "10000", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201514, 201515, 201516, 201517, 201518, 201519, 201520, 201615, 201619}
, bodytype = 1, behaviacAI = "newbattleaif901", defaultBuff = "20116", MonsterType = 901, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20240] = {id = 20240, name = "巨雷龙", nameTextID = 1400155, shapeID = 20127, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 235, hpConstant = "1600000;1600000;1600000;1600000", attackConstant = "13000", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201505, 201506, 201507, 201508}
, bodytype = 1, behaviacAI = "newbattleaif814", defaultBuff = "20116", MonsterType = 814, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20241] = {id = 20241, name = "杀人鲸", nameTextID = 1400156, shapeID = 20123, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1750000;1750000;1750000;1750000", attackConstant = "13500", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201509, 201510, 201511, 201512, 201513}
, bodytype = 1, behaviacAI = "newbattleaif815", defaultBuff = "20116", MonsterType = 815, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20242] = {id = 20242, name = "黑化炼金术士", nameTextID = 1400171, shapeID = 20136, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "1125000;1125000;1125000;1125000;1125000", attackConstant = "10000", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201561, 201562, 201563, 201564, 201565}
, bodytype = 1, behaviacAI = "newbattleaif706", defaultBuff = "", MonsterType = 706, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[20243] = {id = 20243, name = "暗影艾琳娜", nameTextID = 1400137, shapeID = 20140, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "909081;909081;909081", attackConstant = "6446", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201412, 201413, 201414, 201415, 201416, 201417}
, bodytype = 1, behaviacAI = "newbattleai20243", defaultBuff = "", MonsterType = 705, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20244] = {id = 20244, name = "卡蜜莉安1（boss战斗）", nameTextID = 1400228, shapeID = 20211, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 350, hpConstant = "1949400;1949400;1949400", attackConstant = "17893", defConstant = "7925", magicattConstant = "0", magicDefConstant = "23777", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201807, 201808, 201809, 201810, 201812}
, bodytype = 1, behaviacAI = "NewBattlebossW6_1", defaultBuff = "20116;20115;21795", MonsterType = 916, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20245] = {id = 20245, name = "卡蜜莉安2（boss战斗）", nameTextID = 1400228, shapeID = 20212, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 350, hpConstant = "2924100;2924100;2924100;2924100;2924100", attackConstant = "26839", defConstant = "7925", magicattConstant = "0", magicDefConstant = "23777", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201814, 201815, 201816, 201817, 201819, 201821, 201822, 201824, 201825, 201826, 201827}
, bodytype = 1, behaviacAI = "NewBattlebossW6_2", defaultBuff = "20116;21776;20115;21795", MonsterType = 917, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20246] = {id = 20246, name = "守卫神官", nameTextID = 1400240, shapeID = 20208, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 330, hpConstant = "3768840;3768840;3768840;3768840;3768840", attackConstant = "17894", defConstant = "23228", magicattConstant = "0", magicDefConstant = "7742", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201780, 201781, 201782, 201783, 201784, 201785, 201786, 201787}
, bodytype = 1, behaviacAI = "NewBattlebossW6_4", defaultBuff = "20116;20115;21797", MonsterType = 913, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[20247] = {id = 20247, name = "达修斯", nameTextID = 1400239, shapeID = 20215, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "2729160;2729160;2729160;2729160", attackConstant = "24312", defConstant = "7560", magicattConstant = "0", magicDefConstant = "22680", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201850, 201851, 201852, 201853}
, bodytype = 1, behaviacAI = "NewBattlemonW6_023", defaultBuff = "21794", MonsterType = 919, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[29001] = {id = 29001, name = "咒术书·雷", nameTextID = 1400050, shapeID = 20005, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 2, hpConstant = "1477", attackConstant = "34", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201009}
, bodytype = 1, behaviacAI = "newbattleaif103", defaultBuff = "", MonsterType = 103, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[29002] = {id = 29002, name = "魅魔", nameTextID = 1400051, shapeID = 20008, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 3, hpConstant = "5715", attackConstant = "40", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201018, 201019, 201663}
, bodytype = 1, behaviacAI = "NewBattleAI29002", defaultBuff = "", MonsterType = 105, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[29003] = {id = 29003, name = "古塔蝙蝠", nameTextID = 1400052, shapeID = 20007, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 2, hpConstant = "1477", attackConstant = "34", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201020}
, bodytype = 1, behaviacAI = "newbattleaif102", defaultBuff = "", MonsterType = 102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[29004] = {id = 29004, name = "咒术书·雷", nameTextID = 1400050, shapeID = 20005, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 6, hpConstant = "1969", attackConstant = "46", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201009}
, bodytype = 1, behaviacAI = "newbattleaif103", defaultBuff = "", MonsterType = 103, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[29005] = {id = 29005, name = "古塔蝙蝠", nameTextID = 1400052, shapeID = 20007, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 6, hpConstant = "1969", attackConstant = "46", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201020}
, bodytype = 1, behaviacAI = "newbattleaif102", defaultBuff = "", MonsterType = 102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[29006] = {id = 29006, name = "小蝙蝠", nameTextID = 1400053, shapeID = 20040, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 6, hpConstant = "844", attackConstant = "23", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201081}
, bodytype = 1, behaviacAI = "newbattleaif104", defaultBuff = "", MonsterType = 104, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[29007] = {id = 29007, name = "巫毒娃娃", nameTextID = 1400054, shapeID = 20049, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 7, hpConstant = "2092", attackConstant = "49", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201082}
, bodytype = 1, behaviacAI = "newbattleaif301", defaultBuff = "", MonsterType = 301, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[29008] = {id = 29008, name = "小蝙蝠", nameTextID = 1400053, shapeID = 20074, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 7, hpConstant = "896", attackConstant = "24", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201081}
, bodytype = 1, behaviacAI = "newbattleaif104", defaultBuff = "", MonsterType = 104, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[29009] = {id = 29009, name = "怨念体", nameTextID = 1400037, shapeID = 20079, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 7, hpConstant = "2092", attackConstant = "9", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "40", damagereduce = "0", attackID = 0, 
skillid = {201219, 201218}
, bodytype = 1, behaviacAI = "newbattleaif502", defaultBuff = "", MonsterType = 502, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[29010] = {id = 29010, name = "怨念体", nameTextID = 1400037, shapeID = 20079, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 7, hpConstant = "2092", attackConstant = "49", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201219, 201218}
, bodytype = 1, behaviacAI = "newbattleaif502", defaultBuff = "", MonsterType = 502, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[29011] = {id = 29011, name = "小蝙蝠", nameTextID = 1400053, shapeID = 20040, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 4, hpConstant = "500", attackConstant = "20", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201081}
, bodytype = 1, behaviacAI = "newbattleaif104", defaultBuff = "", MonsterType = 104, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[29012] = {id = 29012, name = "小蝙蝠", nameTextID = 1400053, shapeID = 20040, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 2, hpConstant = "400", attackConstant = "17", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201081}
, bodytype = 1, behaviacAI = "newbattleaif104", defaultBuff = "", MonsterType = 104, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[29013] = {id = 29013, name = "魅魔", nameTextID = 1400051, shapeID = 20008, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 3, hpConstant = "5715", attackConstant = "71", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201018, 201019, 201663}
, bodytype = 1, behaviacAI = "newbattleaif105", defaultBuff = "", MonsterType = 105, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30001] = {id = 30001, name = "伞菇", nameTextID = 1400055, shapeID = 20010, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 10, hpConstant = "2461", attackConstant = "58", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201024, 201158}
, bodytype = 1, behaviacAI = "newbattleaif210", defaultBuff = "", MonsterType = 210, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30002] = {id = 30002, name = "小史莱姆", nameTextID = 1400056, shapeID = 20053, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 10, hpConstant = "1055", attackConstant = "29", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201074}
, bodytype = 1, behaviacAI = "newbattleaif214", defaultBuff = "", MonsterType = 214, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30003] = {id = 30003, name = "松果球", nameTextID = 1400057, shapeID = 20054, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 10, hpConstant = "1055", attackConstant = "29", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201069, 201070, 201071}
, bodytype = 1, behaviacAI = "newbattleaif218", defaultBuff = "", MonsterType = 218, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30004] = {id = 30004, name = "伞菇", nameTextID = 1400055, shapeID = 20010, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 15, hpConstant = "3385", attackConstant = "80", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201024, 201158}
, bodytype = 1, behaviacAI = "newbattleaif210", defaultBuff = "", MonsterType = 210, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30005] = {id = 30005, name = "小史莱姆", nameTextID = 1400056, shapeID = 20053, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 15, hpConstant = "1450", attackConstant = "40", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201074}
, bodytype = 1, behaviacAI = "newbattleaif214", defaultBuff = "", MonsterType = 214, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30006] = {id = 30006, name = "连射藤蔓", nameTextID = 1400040, shapeID = 20012, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 15, hpConstant = "3385", attackConstant = "80", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201022, 201065, 201224}
, bodytype = 1, behaviacAI = "newbattleaif206", defaultBuff = "", MonsterType = 206, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30007] = {id = 30007, name = "伞菇", nameTextID = 1400055, shapeID = 20010, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 15, hpConstant = "3385", attackConstant = "80", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201024, 201158}
, bodytype = 1, behaviacAI = "newbattleaif210", defaultBuff = "", MonsterType = 210, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30008] = {id = 30008, name = "小史莱姆", nameTextID = 1400056, shapeID = 20053, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 15, hpConstant = "1450", attackConstant = "40", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201074}
, bodytype = 1, behaviacAI = "newbattleaif214", defaultBuff = "", MonsterType = 214, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30009] = {id = 30009, name = "连射藤蔓", nameTextID = 1400040, shapeID = 20012, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 15, hpConstant = "3385", attackConstant = "80", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201022, 201065, 201224}
, bodytype = 1, behaviacAI = "newbattleaif206", defaultBuff = "", MonsterType = 206, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30010] = {id = 30010, name = "松果球", nameTextID = 1400057, shapeID = 20054, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 15, hpConstant = "1450", attackConstant = "40", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201069, 201070, 201071}
, bodytype = 1, behaviacAI = "newbattleaif218", defaultBuff = "", MonsterType = 218, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30011] = {id = 30011, name = "小史莱姆", nameTextID = 1400056, shapeID = 20053, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "1740", attackConstant = "48", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201074}
, bodytype = 1, behaviacAI = "newbattleaif214", defaultBuff = "", MonsterType = 214, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30012] = {id = 30012, name = "史莱姆", nameTextID = 1400058, shapeID = 20023, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "4062", attackConstant = "97", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201023}
, bodytype = 1, behaviacAI = "newbattleaif201", defaultBuff = "", MonsterType = 201, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30013] = {id = 30013, name = "连射藤蔓", nameTextID = 1400040, shapeID = 20012, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "4062", attackConstant = "97", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201022, 201065, 201224}
, bodytype = 1, behaviacAI = "newbattleaif206", defaultBuff = "", MonsterType = 206, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30014] = {id = 30014, name = "毒伞菇", nameTextID = 1400059, shapeID = 20009, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 25, hpConstant = "4739", attackConstant = "113", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201024, 201066, 201158}
, bodytype = 1, behaviacAI = "newbattleaif209", defaultBuff = "", MonsterType = 209, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30015] = {id = 30015, name = "伞菇", nameTextID = 1400055, shapeID = 20010, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 25, hpConstant = "4739", attackConstant = "113", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201024, 201158}
, bodytype = 1, behaviacAI = "newbattleaif210", defaultBuff = "", MonsterType = 210, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30016] = {id = 30016, name = "花树精", nameTextID = 1400042, shapeID = 20028, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 25, hpConstant = "4739", attackConstant = "113", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201021, 201067, 201232}
, bodytype = 1, behaviacAI = "newbattleaif213", defaultBuff = "", MonsterType = 213, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30017] = {id = 30017, name = "松树精", nameTextID = 1400041, shapeID = 20027, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 25, hpConstant = "4739", attackConstant = "113", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201030, 201231}
, bodytype = 1, behaviacAI = "newbattleaif212", defaultBuff = "", MonsterType = 212, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30018] = {id = 30018, name = "史莱姆", nameTextID = 1400058, shapeID = 20023, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 35, hpConstant = "9744", attackConstant = "223", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201023}
, bodytype = 1, behaviacAI = "newbattleaif201", defaultBuff = "", MonsterType = 201, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30019] = {id = 30019, name = "松果球", nameTextID = 1400057, shapeID = 20054, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 35, hpConstant = "4176", attackConstant = "111", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201069, 201070, 201071}
, bodytype = 1, behaviacAI = "newbattleaif218", defaultBuff = "", MonsterType = 218, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30020] = {id = 30020, name = "松树精", nameTextID = 1400041, shapeID = 20027, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 35, hpConstant = "9744", attackConstant = "223", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201030, 201231}
, bodytype = 1, behaviacAI = "newbattleaif212", defaultBuff = "", MonsterType = 212, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30021] = {id = 30021, name = "石巨人", nameTextID = 1400008, shapeID = 10043, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 35, hpConstant = "34802", attackConstant = "465", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201027, 201028, 201029, 201037, 201059}
, bodytype = 1, behaviacAI = "newbattleaif220", defaultBuff = "20116", MonsterType = 220, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[30022] = {id = 30022, name = "连射藤蔓", nameTextID = 1400040, shapeID = 20012, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 35, hpConstant = "9744", attackConstant = "223", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201022, 201065, 201224}
, bodytype = 1, behaviacAI = "newbattleaif206", defaultBuff = "", MonsterType = 206, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30023] = {id = 30023, name = "变异藤蔓", nameTextID = 1400060, shapeID = 20015, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 35, hpConstant = "9744", attackConstant = "223", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201065, 201022, 201068}
, bodytype = 1, behaviacAI = "newbattleaif208", defaultBuff = "", MonsterType = 208, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30024] = {id = 30024, name = "独角仙", nameTextID = 1400061, shapeID = 20055, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 35, hpConstant = "8282", attackConstant = "223", defConstant = "1000", magicattConstant = "0", magicDefConstant = "1000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201072, 201073}
, bodytype = 1, behaviacAI = "newbattleaif219", defaultBuff = "", MonsterType = 219, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30025] = {id = 30025, name = "松果球", nameTextID = 1400057, shapeID = 20054, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 40, hpConstant = "4524", attackConstant = "121", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201069, 201070, 201071}
, bodytype = 1, behaviacAI = "newbattleaif218", defaultBuff = "", MonsterType = 218, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30026] = {id = 30026, name = "松树精", nameTextID = 1400041, shapeID = 20027, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 40, hpConstant = "10556", attackConstant = "242", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201030, 201231}
, bodytype = 1, behaviacAI = "newbattleaif212", defaultBuff = "", MonsterType = 212, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30027] = {id = 30027, name = "花树精", nameTextID = 1400042, shapeID = 20028, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 40, hpConstant = "10556", attackConstant = "242", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201021, 201067, 201232}
, bodytype = 1, behaviacAI = "newbattleaif213", defaultBuff = "", MonsterType = 213, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30028] = {id = 30028, name = "石巨人", nameTextID = 1400008, shapeID = 10043, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 45, hpConstant = "40602", attackConstant = "546", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201027, 201028, 201029, 201037, 201059}
, bodytype = 1, behaviacAI = "newbattleaif220", defaultBuff = "20116", MonsterType = 220, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[30029] = {id = 30029, name = "毒伞菇", nameTextID = 1400059, shapeID = 20009, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 45, hpConstant = "11368", attackConstant = "260", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201024, 201066, 201158}
, bodytype = 1, behaviacAI = "newbattleaif209", defaultBuff = "", MonsterType = 209, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30030] = {id = 30030, name = "幽灵螳螂", nameTextID = 1400013, shapeID = 20032, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 45, hpConstant = "40602", attackConstant = "420", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201053, 201054, 201055}
, bodytype = 1, behaviacAI = "newbattleaif222", defaultBuff = "", MonsterType = 222, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[30031] = {id = 30031, name = "独角仙", nameTextID = 1400061, shapeID = 20055, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 45, hpConstant = "9663", attackConstant = "260", defConstant = "1000", magicattConstant = "0", magicDefConstant = "1000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201072, 201073}
, bodytype = 1, behaviacAI = "newbattleaif219", defaultBuff = "", MonsterType = 219, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30032] = {id = 30032, name = "兰花螳螂", nameTextID = 1400012, shapeID = 20031, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 45, hpConstant = "40602", attackConstant = "420", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201050, 201051, 201052}
, bodytype = 1, behaviacAI = "newbattleaif221", defaultBuff = "", MonsterType = 221, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[30033] = {id = 30033, name = "变异藤蔓", nameTextID = 1400060, shapeID = 20015, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 50, hpConstant = "12180", attackConstant = "280", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201065, 201022, 201068}
, bodytype = 1, behaviacAI = "newbattleaif208", defaultBuff = "", MonsterType = 208, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30034] = {id = 30034, name = "松树精", nameTextID = 1400041, shapeID = 20027, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 50, hpConstant = "12180", attackConstant = "280", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201030, 201231}
, bodytype = 1, behaviacAI = "newbattleaif212", defaultBuff = "", MonsterType = 212, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30035] = {id = 30035, name = "花树精", nameTextID = 1400042, shapeID = 20028, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 50, hpConstant = "12180", attackConstant = "280", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201021, 201067, 201232}
, bodytype = 1, behaviacAI = "newbattleaif213", defaultBuff = "", MonsterType = 213, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30036] = {id = 30036, name = "毒伞菇", nameTextID = 1400059, shapeID = 20009, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 50, hpConstant = "12180", attackConstant = "280", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201024, 201066, 201158}
, bodytype = 1, behaviacAI = "newbattleaif209", defaultBuff = "", MonsterType = 209, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30037] = {id = 30037, name = "独角仙", nameTextID = 1400061, shapeID = 20055, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 50, hpConstant = "10353", attackConstant = "280", defConstant = "1000", magicattConstant = "0", magicDefConstant = "1000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201072, 201073}
, bodytype = 1, behaviacAI = "newbattleaif219", defaultBuff = "", MonsterType = 219, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30038] = {id = 30038, name = "变异藤蔓", nameTextID = 1400060, shapeID = 20015, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 50, hpConstant = "12180", attackConstant = "280", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201065, 201022, 201068}
, bodytype = 1, behaviacAI = "newbattleaif208", defaultBuff = "", MonsterType = 208, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30039] = {id = 30039, name = "幽灵螳螂", nameTextID = 1400013, shapeID = 20032, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 50, hpConstant = "43503", attackConstant = "451", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201053, 201054, 201055}
, bodytype = 1, behaviacAI = "newbattleaif222", defaultBuff = "", MonsterType = 222, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[30040] = {id = 30040, name = "独角仙", nameTextID = 1400061, shapeID = 20055, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "11734", attackConstant = "318", defConstant = "1000", magicattConstant = "0", magicDefConstant = "1000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201072, 201073}
, bodytype = 1, behaviacAI = "newbattleaif219", defaultBuff = "", MonsterType = 219, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30041] = {id = 30041, name = "变异藤蔓", nameTextID = 1400060, shapeID = 20015, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "13804", attackConstant = "318", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201065, 201022, 201068}
, bodytype = 1, behaviacAI = "newbattleaif208", defaultBuff = "", MonsterType = 208, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30042] = {id = 30042, name = "毒伞菇", nameTextID = 1400059, shapeID = 20009, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "13804", attackConstant = "318", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201024, 201066, 201158}
, bodytype = 1, behaviacAI = "newbattleaif209", defaultBuff = "", MonsterType = 209, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30043] = {id = 30043, name = "松果球", nameTextID = 1400057, shapeID = 20054, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 25, hpConstant = "2031", attackConstant = "56", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201069, 201070, 201071}
, bodytype = 1, behaviacAI = "newbattleaif218", defaultBuff = "", MonsterType = 218, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30044] = {id = 30044, name = "松果球", nameTextID = 1400057, shapeID = 20054, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 45, hpConstant = "4872", attackConstant = "130", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201069, 201070, 201071}
, bodytype = 1, behaviacAI = "newbattleaif218", defaultBuff = "", MonsterType = 218, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30045] = {id = 30045, name = "松果球", nameTextID = 1400057, shapeID = 20054, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 50, hpConstant = "5220", attackConstant = "140", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201069, 201070, 201071}
, bodytype = 1, behaviacAI = "newbattleaif218", defaultBuff = "", MonsterType = 218, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30046] = {id = 30046, name = "小史莱姆", nameTextID = 1400056, shapeID = 20053, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 35, hpConstant = "4176", attackConstant = "111", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201074}
, bodytype = 1, behaviacAI = "newbattleaif214", defaultBuff = "", MonsterType = 214, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30047] = {id = 30047, name = "史莱姆", nameTextID = 1400058, shapeID = 20023, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 35, hpConstant = "9744", attackConstant = "223", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201023}
, bodytype = 1, behaviacAI = "newbattleaif201_2", defaultBuff = "", MonsterType = 201, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30201] = {id = 30201, name = "雪球", nameTextID = 1400062, shapeID = 20035, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "28780", attackConstant = "652", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 409, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30202] = {id = 30202, name = "小雪球", nameTextID = 1400063, shapeID = 20041, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "12334", attackConstant = "326", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 410, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30203] = {id = 30203, name = "猎人", nameTextID = 1400064, shapeID = 20044, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "28780", attackConstant = "652", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201102, 201103}
, bodytype = 1, behaviacAI = "newbattleaif405", defaultBuff = "", MonsterType = 405, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30204] = {id = 30204, name = "小雪球", nameTextID = 1400063, shapeID = 20041, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "12334", attackConstant = "326", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 410, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30205] = {id = 30205, name = "雪球", nameTextID = 1400062, shapeID = 20035, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "28780", attackConstant = "652", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 409, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30206] = {id = 30206, name = "冰霜树精", nameTextID = 1400065, shapeID = 20036, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "28780", attackConstant = "652", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 404, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30207] = {id = 30207, name = "猎人", nameTextID = 1400064, shapeID = 20044, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 95, hpConstant = "39736", attackConstant = "675", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201102, 201103}
, bodytype = 1, behaviacAI = "newbattleaif405", defaultBuff = "", MonsterType = 405, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30208] = {id = 30208, name = "幼狼", nameTextID = 1400027, shapeID = 20034, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 95, hpConstant = "17029", attackConstant = "337", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201077, 201090, 201091}
, bodytype = 1, behaviacAI = "newbattleaif401", defaultBuff = "", MonsterType = 401, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30209] = {id = 30209, name = "冰霜树精", nameTextID = 1400065, shapeID = 20036, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 95, hpConstant = "39736", attackConstant = "675", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 404, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30210] = {id = 30210, name = "小雪球", nameTextID = 1400063, shapeID = 20041, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 95, hpConstant = "17029", attackConstant = "337", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 410, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30211] = {id = 30211, name = "雪怪", nameTextID = 1400066, shapeID = 20037, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 95, hpConstant = "63578", attackConstant = "675", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 411, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30212] = {id = 30212, name = "幼狼", nameTextID = 1400027, shapeID = 20034, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 95, hpConstant = "17029", attackConstant = "337", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201077, 201090, 201091}
, bodytype = 1, behaviacAI = "newbattleaif401", defaultBuff = "", MonsterType = 401, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30213] = {id = 30213, name = "雪球", nameTextID = 1400062, shapeID = 20035, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 95, hpConstant = "39736", attackConstant = "675", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 409, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30214] = {id = 30214, name = "猎人", nameTextID = 1400064, shapeID = 20044, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 100, hpConstant = "41018", attackConstant = "698", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201102, 201103}
, bodytype = 1, behaviacAI = "newbattleaif405", defaultBuff = "", MonsterType = 405, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30215] = {id = 30215, name = "冰霜树精", nameTextID = 1400065, shapeID = 20036, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 100, hpConstant = "41018", attackConstant = "698", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 404, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30216] = {id = 30216, name = "小雪球", nameTextID = 1400063, shapeID = 20041, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "18677", attackConstant = "372", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 410, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30217] = {id = 30217, name = "雪球", nameTextID = 1400062, shapeID = 20035, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "43581", attackConstant = "745", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 409, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30218] = {id = 30218, name = "雪女", nameTextID = 1400067, shapeID = 20039, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "155649", attackConstant = "1247", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 408, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[30219] = {id = 30219, name = "雪怪", nameTextID = 1400066, shapeID = 20037, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "69730", attackConstant = "745", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 411, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30220] = {id = 30220, name = "幼狼", nameTextID = 1400027, shapeID = 20034, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 115, hpConstant = "19227", attackConstant = "384", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201077, 201090, 201091}
, bodytype = 1, behaviacAI = "newbattleaif401", defaultBuff = "", MonsterType = 401, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30221] = {id = 30221, name = "白狼", nameTextID = 1400068, shapeID = 20042, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 115, hpConstant = "44863", attackConstant = "769", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 201088, 
skillid = {201088, 201089, 201090, 201091}
, bodytype = 1, behaviacAI = "newbattleaif402", defaultBuff = "", MonsterType = 402, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30222] = {id = 30222, name = "冰霜树精", nameTextID = 1400065, shapeID = 20036, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 115, hpConstant = "44863", attackConstant = "769", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 404, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30223] = {id = 30223, name = "幼狼", nameTextID = 1400027, shapeID = 20034, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 115, hpConstant = "19227", attackConstant = "384", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201077, 201090, 201091}
, bodytype = 1, behaviacAI = "newbattleaif401", defaultBuff = "", MonsterType = 401, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30224] = {id = 30224, name = "雪怪", nameTextID = 1400066, shapeID = 20037, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 115, hpConstant = "71781", attackConstant = "769", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 411, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30225] = {id = 30225, name = "雪女", nameTextID = 1400067, shapeID = 20039, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 115, hpConstant = "160227", attackConstant = "1289", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 408, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[30226] = {id = 30226, name = "猎人", nameTextID = 1400064, shapeID = 20044, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "46145", attackConstant = "793", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201102, 201103}
, bodytype = 1, behaviacAI = "newbattleaif405", defaultBuff = "", MonsterType = 405, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30227] = {id = 30227, name = "白狼", nameTextID = 1400068, shapeID = 20042, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "46145", attackConstant = "793", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 201088, 
skillid = {201088, 201089, 201090, 201091}
, bodytype = 1, behaviacAI = "newbattleaif402", defaultBuff = "", MonsterType = 402, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30228] = {id = 30228, name = "哨兵", nameTextID = 1400069, shapeID = 20043, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "46145", attackConstant = "793", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201097, 201098, 201101}
, bodytype = 1, behaviacAI = "newbattleaif413", defaultBuff = "", MonsterType = 413, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30229] = {id = 30229, name = "白熊", nameTextID = 1400070, shapeID = 20060, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "73832", attackConstant = "951", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201125, 201126, 201127}
, bodytype = 1, behaviacAI = "newbattleaif403", defaultBuff = "", MonsterType = 403, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30230] = {id = 30230, name = "白狼", nameTextID = 1400068, shapeID = 20042, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 125, hpConstant = "47427", attackConstant = "817", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 201088, 
skillid = {201088, 201089, 201090, 201091}
, bodytype = 1, behaviacAI = "newbattleaif402", defaultBuff = "", MonsterType = 402, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30231] = {id = 30231, name = "雪怪", nameTextID = 1400066, shapeID = 20037, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 125, hpConstant = "75883", attackConstant = "817", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 411, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30232] = {id = 30232, name = "雪女", nameTextID = 1400067, shapeID = 20039, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 125, hpConstant = "169382", attackConstant = "1374", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 408, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[30233] = {id = 30233, name = "哨兵", nameTextID = 1400069, shapeID = 20043, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 130, hpConstant = "48709", attackConstant = "841", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201097, 201098, 201101}
, bodytype = 1, behaviacAI = "newbattleaif413", defaultBuff = "", MonsterType = 413, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30234] = {id = 30234, name = "卫兵", nameTextID = 1400071, shapeID = 20038, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 130, hpConstant = "48709", attackConstant = "841", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201099, 201100, 201101}
, bodytype = 1, behaviacAI = "newbattleaif414", defaultBuff = "", MonsterType = 414, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30235] = {id = 30235, name = "白狼", nameTextID = 1400068, shapeID = 20042, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 130, hpConstant = "48709", attackConstant = "841", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 201088, 
skillid = {201088, 201089, 201090, 201091}
, bodytype = 1, behaviacAI = "newbattleaif402", defaultBuff = "", MonsterType = 402, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30236] = {id = 30236, name = "白熊", nameTextID = 1400070, shapeID = 20060, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 130, hpConstant = "77934", attackConstant = "1009", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201125, 201126, 201127}
, bodytype = 1, behaviacAI = "newbattleaif403", defaultBuff = "", MonsterType = 403, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30237] = {id = 30237, name = "白熊", nameTextID = 1400070, shapeID = 20060, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 130, hpConstant = "77934", attackConstant = "1009", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201125, 201126, 201127}
, bodytype = 1, behaviacAI = "newbattleaif403", defaultBuff = "", MonsterType = 403, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30238] = {id = 30238, name = "卫兵", nameTextID = 1400071, shapeID = 20038, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 130, hpConstant = "48709", attackConstant = "841", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201099, 201100, 201101}
, bodytype = 1, behaviacAI = "newbattleaif414", defaultBuff = "", MonsterType = 414, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30239] = {id = 30239, name = "冰霜巨人", nameTextID = 1400072, shapeID = 20048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 130, hpConstant = "173960", attackConstant = "1416", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 412, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30240] = {id = 30240, name = "白熊", nameTextID = 1400070, shapeID = 20060, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 135, hpConstant = "79985", attackConstant = "1038", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201125, 201126, 201127}
, bodytype = 1, behaviacAI = "newbattleaif403", defaultBuff = "", MonsterType = 403, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30241] = {id = 30241, name = "冰霜巨人", nameTextID = 1400072, shapeID = 20048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 135, hpConstant = "178538", attackConstant = "1460", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 412, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30242] = {id = 30242, name = "卫兵", nameTextID = 1400071, shapeID = 20038, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 135, hpConstant = "49990", attackConstant = "865", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201099, 201100, 201101}
, bodytype = 1, behaviacAI = "newbattleaif414", defaultBuff = "", MonsterType = 414, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30243] = {id = 30243, name = "哨兵", nameTextID = 1400069, shapeID = 20043, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 135, hpConstant = "49990", attackConstant = "865", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201097, 201098, 201101}
, bodytype = 1, behaviacAI = "newbattleaif413", defaultBuff = "", MonsterType = 413, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30244] = {id = 30244, name = "哨兵队长", nameTextID = 1400073, shapeID = 20046, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 135, hpConstant = "178538", attackConstant = "1460", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201133, 201134, 201135, 201136, 201393}
, bodytype = 1, behaviacAI = "newbattleaif415", defaultBuff = "", MonsterType = 415, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30245] = {id = 30245, name = "卫兵", nameTextID = 1400071, shapeID = 20038, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 135, hpConstant = "49990", attackConstant = "865", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201099, 201100, 201101}
, bodytype = 1, behaviacAI = "newbattleaif414", defaultBuff = "", MonsterType = 414, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30246] = {id = 30246, name = "哨兵", nameTextID = 1400069, shapeID = 20043, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 135, hpConstant = "49990", attackConstant = "865", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201097, 201098, 201101}
, bodytype = 1, behaviacAI = "newbattleaif413", defaultBuff = "", MonsterType = 413, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30247] = {id = 30247, name = "卫兵队长", nameTextID = 1400074, shapeID = 20047, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 135, hpConstant = "178538", attackConstant = "1460", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201137, 201138, 201139, 201140, 201394}
, bodytype = 1, behaviacAI = "newbattleaif416", defaultBuff = "", MonsterType = 416, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30248] = {id = 30248, name = "雪球", nameTextID = 1400062, shapeID = 20035, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "28780", attackConstant = "652", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409_2", defaultBuff = "", MonsterType = 409, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30249] = {id = 30249, name = "雪球", nameTextID = 1400062, shapeID = 20035, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "28780", attackConstant = "652", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409_2", defaultBuff = "", MonsterType = 409, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30250] = {id = 30250, name = "雪球", nameTextID = 1400062, shapeID = 20035, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 95, hpConstant = "39736", attackConstant = "675", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409_2", defaultBuff = "", MonsterType = 409, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30251] = {id = 30251, name = "雪球", nameTextID = 1400062, shapeID = 20035, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "43581", attackConstant = "745", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409_2", defaultBuff = "", MonsterType = 409, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30401] = {id = 30401, name = "古塔蝙蝠", nameTextID = 1400052, shapeID = 20007, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 75, hpConstant = "16241", attackConstant = "377", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201020}
, bodytype = 1, behaviacAI = "newbattleaif102", defaultBuff = "", MonsterType = 102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30402] = {id = 30402, name = "小蝙蝠", nameTextID = 1400053, shapeID = 20040, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 75, hpConstant = "6960", attackConstant = "188", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201081}
, bodytype = 1, behaviacAI = "newbattleaif104", defaultBuff = "", MonsterType = 104, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30403] = {id = 30403, name = "巫毒娃娃", nameTextID = 1400054, shapeID = 20049, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 75, hpConstant = "16241", attackConstant = "377", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201082}
, bodytype = 1, behaviacAI = "newbattleaif301", defaultBuff = "", MonsterType = 301, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30404] = {id = 30404, name = "幼鼠", nameTextID = 1400075, shapeID = 20051, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 75, hpConstant = "6960", attackConstant = "188", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201069}
, bodytype = 1, behaviacAI = "newbattleaif304", defaultBuff = "", MonsterType = 304, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30405] = {id = 30405, name = "巨鼠", nameTextID = 1400076, shapeID = 20052, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 75, hpConstant = "16241", attackConstant = "377", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201069, 201080}
, bodytype = 1, behaviacAI = "newbattleaif303", defaultBuff = "", MonsterType = 303, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30406] = {id = 30406, name = "咒术书", nameTextID = 1400077, shapeID = 20005, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 80, hpConstant = "26861", attackConstant = "606", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201009}
, bodytype = 1, behaviacAI = "newbattleaif103", defaultBuff = "", MonsterType = 103, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30407] = {id = 30407, name = "魅魔", nameTextID = 1400051, shapeID = 20008, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 80, hpConstant = "95933", attackConstant = "1205", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201018, 201019}
, bodytype = 1, behaviacAI = "newbattleaif105", defaultBuff = "", MonsterType = 105, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30408] = {id = 30408, name = "巫毒娃娃", nameTextID = 1400054, shapeID = 20049, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 80, hpConstant = "26861", attackConstant = "606", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201082}
, bodytype = 1, behaviacAI = "newbattleaif301", defaultBuff = "", MonsterType = 301, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30409] = {id = 30409, name = "幽灵水母", nameTextID = 1400078, shapeID = 20050, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 80, hpConstant = "26861", attackConstant = "606", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201083}
, bodytype = 1, behaviacAI = "newbattleaif302", defaultBuff = "", MonsterType = 302, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30410] = {id = 30410, name = "魅魔", nameTextID = 1400051, shapeID = 20008, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 80, hpConstant = "95933", attackConstant = "1205", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201018, 201019}
, bodytype = 1, behaviacAI = "newbattleaif105", defaultBuff = "", MonsterType = 105, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30411] = {id = 30411, name = "幼鼠", nameTextID = 1400075, shapeID = 20051, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 85, hpConstant = "11923", attackConstant = "314", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201069}
, bodytype = 1, behaviacAI = "newbattleaif304", defaultBuff = "", MonsterType = 304, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30412] = {id = 30412, name = "巨鼠", nameTextID = 1400076, shapeID = 20052, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 85, hpConstant = "27820", attackConstant = "629", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201069, 201080}
, bodytype = 1, behaviacAI = "newbattleaif303", defaultBuff = "", MonsterType = 303, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30413] = {id = 30413, name = "时空信徒", nameTextID = 1400079, shapeID = 20071, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 85, hpConstant = "99359", attackConstant = "1044", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201084, 201085, 201086}
, bodytype = 1, behaviacAI = "newbattleaif305", defaultBuff = "", MonsterType = 305, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30414] = {id = 30414, name = "幽灵水母", nameTextID = 1400078, shapeID = 20050, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 85, hpConstant = "27820", attackConstant = "629", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201083}
, bodytype = 1, behaviacAI = "newbattleaif302", defaultBuff = "", MonsterType = 302, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30415] = {id = 30415, name = "巨鼠", nameTextID = 1400076, shapeID = 20052, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 85, hpConstant = "27820", attackConstant = "629", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201069, 201080}
, bodytype = 1, behaviacAI = "newbattleaif303", defaultBuff = "", MonsterType = 303, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30416] = {id = 30416, name = "时空信徒", nameTextID = 1400079, shapeID = 20071, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 85, hpConstant = "99359", attackConstant = "1044", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201084, 201085, 201086}
, bodytype = 1, behaviacAI = "newbattleaif305", defaultBuff = "", MonsterType = 305, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30417] = {id = 30417, name = "小蝙蝠", nameTextID = 1400053, shapeID = 20073, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 75, hpConstant = "6960", attackConstant = "188", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201081}
, bodytype = 1, behaviacAI = "newbattleaif104", defaultBuff = "", MonsterType = 104, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30418] = {id = 30418, name = "小蝙蝠", nameTextID = 1400053, shapeID = 20074, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 75, hpConstant = "6960", attackConstant = "188", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201081}
, bodytype = 1, behaviacAI = "newbattleaif104", defaultBuff = "", MonsterType = 104, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30419] = {id = 30419, name = "魂火", nameTextID = 1400039, shapeID = 20078, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "79172", attackConstant = "1405", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201217}
, bodytype = 1, behaviacAI = "newbattleaif501", defaultBuff = "20616", MonsterType = 501, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30420] = {id = 30420, name = "幽灵水母", nameTextID = 1400078, shapeID = 20050, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "79172", attackConstant = "1405", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201083}
, bodytype = 1, behaviacAI = "newbattleaif302", defaultBuff = "", MonsterType = 302, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30421] = {id = 30421, name = "魂火", nameTextID = 1400039, shapeID = 20078, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "79172", attackConstant = "1405", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201217}
, bodytype = 1, behaviacAI = "newbattleaif501", defaultBuff = "20616", MonsterType = 501, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30422] = {id = 30422, name = "时空信徒", nameTextID = 1400079, shapeID = 20071, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "282757", attackConstant = "2441", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201084, 201085, 201086}
, bodytype = 1, behaviacAI = "newbattleaif305", defaultBuff = "", MonsterType = 305, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30423] = {id = 30423, name = "怨念体", nameTextID = 1400037, shapeID = 20079, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "80638", attackConstant = "1434", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201219, 201218}
, bodytype = 1, behaviacAI = "newbattleaif502", defaultBuff = "", MonsterType = 502, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30424] = {id = 30424, name = "魔法师之影", nameTextID = 1400038, shapeID = 20077, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "80638", attackConstant = "1434", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201220, 201279}
, bodytype = 1, behaviacAI = "newbattleaif503", defaultBuff = "", MonsterType = 503, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30425] = {id = 30425, name = "时空信徒", nameTextID = 1400079, shapeID = 20071, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "287993", attackConstant = "2496", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201084, 201085, 201086}
, bodytype = 1, behaviacAI = "newbattleaif305", defaultBuff = "", MonsterType = 305, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30426] = {id = 30426, name = "怨念体", nameTextID = 1400037, shapeID = 20079, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "80638", attackConstant = "1434", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201219, 201218}
, bodytype = 1, behaviacAI = "newbattleaif502", defaultBuff = "", MonsterType = 502, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30427] = {id = 30427, name = "骸骨蛇", nameTextID = 1400028, shapeID = 20080, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "287993", attackConstant = "2496", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201222, 201221, 201223}
, bodytype = 1, behaviacAI = "newbattleaif504", defaultBuff = "20116", MonsterType = 504, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30428] = {id = 30428, name = "魔法师之影", nameTextID = 1400038, shapeID = 20077, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "82104", attackConstant = "1464", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201220, 201279}
, bodytype = 1, behaviacAI = "newbattleaif503", defaultBuff = "", MonsterType = 503, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30429] = {id = 30429, name = "魂火", nameTextID = 1400039, shapeID = 20078, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "82104", attackConstant = "1464", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201217}
, bodytype = 1, behaviacAI = "newbattleaif501", defaultBuff = "20616", MonsterType = 501, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30430] = {id = 30430, name = "魔法师之影", nameTextID = 1400038, shapeID = 20077, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "82104", attackConstant = "1464", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201220, 201279}
, bodytype = 1, behaviacAI = "newbattleaif503", defaultBuff = "", MonsterType = 503, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30431] = {id = 30431, name = "骸骨蛇", nameTextID = 1400028, shapeID = 20080, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "293229", attackConstant = "2551", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201222, 201221, 201223}
, bodytype = 1, behaviacAI = "newbattleaif504", defaultBuff = "20116", MonsterType = 504, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30432] = {id = 30432, name = "怨念体", nameTextID = 1400037, shapeID = 20079, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "82104", attackConstant = "1464", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201219, 201218}
, bodytype = 1, behaviacAI = "newbattleaif502", defaultBuff = "", MonsterType = 502, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30434] = {id = 30434, name = "熔岩精灵", nameTextID = 1400125, shapeID = 20081, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 195, hpConstant = "95299", attackConstant = "1737", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201388, 201235}
, bodytype = 1, behaviacAI = "newbattleaif605", defaultBuff = "", MonsterType = 605, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30435] = {id = 30435, name = "被封印的熔岩兽", nameTextID = 1400126, shapeID = 20082, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 195, hpConstant = "95299", attackConstant = "1737", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201237, 201236}
, bodytype = 1, behaviacAI = "newbattleaif606", defaultBuff = "", MonsterType = 606, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30436] = {id = 30436, name = "被封印的熔岩兽", nameTextID = 1400126, shapeID = 20082, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 195, hpConstant = "95299", attackConstant = "1737", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201237, 201236}
, bodytype = 1, behaviacAI = "newbattleaif606", defaultBuff = "", MonsterType = 606, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30437] = {id = 30437, name = "被封印的熔岩兽", nameTextID = 1400126, shapeID = 20082, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 195, hpConstant = "95299", attackConstant = "1737", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201237, 201236}
, bodytype = 1, behaviacAI = "newbattleaif606", defaultBuff = "", MonsterType = 606, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30438] = {id = 30438, name = "熔岩精灵", nameTextID = 1400125, shapeID = 20081, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 195, hpConstant = "95299", attackConstant = "1737", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201388, 201235}
, bodytype = 1, behaviacAI = "newbattleaif605", defaultBuff = "", MonsterType = 605, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30439] = {id = 30439, name = "熔岩巨兽", nameTextID = 1400033, shapeID = 20084, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 195, hpConstant = "340355", attackConstant = "3064", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201241, 201242, 201243, 201244, 201245, 201372}
, bodytype = 1, behaviacAI = "newbattleaif608", defaultBuff = "", MonsterType = 608, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30440] = {id = 30440, name = "熔岩兽", nameTextID = 1400034, shapeID = 20083, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 195, hpConstant = "95299", attackConstant = "1737", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201239, 201238, 201240}
, bodytype = 1, behaviacAI = "newbattleaif607", defaultBuff = "", MonsterType = 607, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30441] = {id = 30441, name = "熔岩巨兽", nameTextID = 1400033, shapeID = 20084, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 195, hpConstant = "340355", attackConstant = "3064", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201241, 201242, 201243, 201244, 201245, 201372}
, bodytype = 1, behaviacAI = "newbattleaif608", defaultBuff = "", MonsterType = 608, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30442] = {id = 30442, name = "熔岩兽", nameTextID = 1400034, shapeID = 20083, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 195, hpConstant = "95299", attackConstant = "1737", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201239, 201238, 201240}
, bodytype = 1, behaviacAI = "newbattleaif607", defaultBuff = "", MonsterType = 607, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30443] = {id = 30443, name = "熔岩巨兽", nameTextID = 1400033, shapeID = 20084, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 195, hpConstant = "340355", attackConstant = "3064", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201241, 201242, 201243, 201244, 201245, 201372}
, bodytype = 1, behaviacAI = "newbattleaif608", defaultBuff = "", MonsterType = 608, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30444] = {id = 30444, name = "魂火", nameTextID = 1400039, shapeID = 20078, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "80638", attackConstant = "1434", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201217}
, bodytype = 1, behaviacAI = "newbattleaif501", defaultBuff = "20616", MonsterType = 501, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30501] = {id = 30501, name = "冰霜魔菇", nameTextID = 1400049, shapeID = 20088, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "85036", attackConstant = "1523", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201278}
, bodytype = 1, behaviacAI = "newbattleaItest15", defaultBuff = "", MonsterType = 604, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30502] = {id = 30502, name = "冰霜魔菇", nameTextID = 1400049, shapeID = 20088, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "85036", attackConstant = "1523", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201278}
, bodytype = 1, behaviacAI = "newbattleaItest15", defaultBuff = "", MonsterType = 604, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30503] = {id = 30503, name = "冰霜独角仙", nameTextID = 1400048, shapeID = 20087, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "85036", attackConstant = "1523", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201277, 201276, 201338}
, bodytype = 1, behaviacAI = "newbattleaItest14", defaultBuff = "", MonsterType = 603, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30504] = {id = 30504, name = "冰霜独角仙", nameTextID = 1400048, shapeID = 20087, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "85036", attackConstant = "1523", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201277, 201276, 201338}
, bodytype = 1, behaviacAI = "newbattleaItest14", defaultBuff = "", MonsterType = 603, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30505] = {id = 30505, name = "冰霜魔菇", nameTextID = 1400049, shapeID = 20088, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "85036", attackConstant = "1523", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201278}
, bodytype = 1, behaviacAI = "newbattleaItest15", defaultBuff = "", MonsterType = 604, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30506] = {id = 30506, name = "冰霜独角仙", nameTextID = 1400048, shapeID = 20087, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "85036", attackConstant = "1523", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201277, 201276, 201338}
, bodytype = 1, behaviacAI = "newbattleaItest14", defaultBuff = "", MonsterType = 603, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30507] = {id = 30507, name = "冰霜独角仙", nameTextID = 1400048, shapeID = 20087, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "85036", attackConstant = "1523", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201277, 201276, 201338}
, bodytype = 1, behaviacAI = "newbattleaItest14", defaultBuff = "", MonsterType = 603, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30508] = {id = 30508, name = "冰霜飞蛾", nameTextID = 1400046, shapeID = 20085, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "87968", attackConstant = "1583", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201273}
, bodytype = 1, behaviacAI = "newbattleaItest12", defaultBuff = "", MonsterType = 601, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30509] = {id = 30509, name = "冰霜飞蛾", nameTextID = 1400046, shapeID = 20085, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "87968", attackConstant = "1583", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201273}
, bodytype = 1, behaviacAI = "newbattleaItest12", defaultBuff = "", MonsterType = 601, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30510] = {id = 30510, name = "冰霜巨人", nameTextID = 1400104, shapeID = 20048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "314174", attackConstant = "2775", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 412, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30511] = {id = 30511, name = "冰霜飞蛾", nameTextID = 1400046, shapeID = 20085, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "87968", attackConstant = "1583", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201273}
, bodytype = 1, behaviacAI = "newbattleaItest12", defaultBuff = "", MonsterType = 601, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30512] = {id = 30512, name = "兰花树精", nameTextID = 1400047, shapeID = 20086, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "87968", attackConstant = "1583", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201274, 201275}
, bodytype = 1, behaviacAI = "newbattleaItest13", defaultBuff = "", MonsterType = 602, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30513] = {id = 30513, name = "猎人", nameTextID = 1400064, shapeID = 20044, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "87968", attackConstant = "1583", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201102, 201103}
, bodytype = 1, behaviacAI = "newbattleaif405", defaultBuff = "", MonsterType = 405, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30514] = {id = 30514, name = "猎人", nameTextID = 1400064, shapeID = 20044, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "87968", attackConstant = "1583", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201102, 201103}
, bodytype = 1, behaviacAI = "newbattleaif405", defaultBuff = "", MonsterType = 405, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30515] = {id = 30515, name = "猎人", nameTextID = 1400064, shapeID = 20044, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "87968", attackConstant = "1583", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201102, 201103}
, bodytype = 1, behaviacAI = "newbattleaif405", defaultBuff = "", MonsterType = 405, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30516] = {id = 30516, name = "猎人", nameTextID = 1400064, shapeID = 20044, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "87968", attackConstant = "1583", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201102, 201103}
, bodytype = 1, behaviacAI = "newbattleaif405", defaultBuff = "", MonsterType = 405, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30517] = {id = 30517, name = "猎人", nameTextID = 1400064, shapeID = 20044, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "87968", attackConstant = "1583", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201102, 201103}
, bodytype = 1, behaviacAI = "newbattleaif405", defaultBuff = "", MonsterType = 405, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30518] = {id = 30518, name = "猎人", nameTextID = 1400064, shapeID = 20044, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "87968", attackConstant = "1583", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201102, 201103}
, bodytype = 1, behaviacAI = "newbattleaif405", defaultBuff = "", MonsterType = 405, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30519] = {id = 30519, name = "冰霜飞蛾", nameTextID = 1400046, shapeID = 20085, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "87968", attackConstant = "1583", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201273}
, bodytype = 1, behaviacAI = "newbattleaItest12", defaultBuff = "", MonsterType = 601, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30520] = {id = 30520, name = "猎人", nameTextID = 1400064, shapeID = 20044, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "87968", attackConstant = "1583", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201102, 201103}
, bodytype = 1, behaviacAI = "newbattleaif405", defaultBuff = "", MonsterType = 405, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30521] = {id = 30521, name = "猎人", nameTextID = 1400064, shapeID = 20044, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "87968", attackConstant = "1583", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201102, 201103}
, bodytype = 1, behaviacAI = "newbattleaif405", defaultBuff = "", MonsterType = 405, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30522] = {id = 30522, name = "冰霜巨人", nameTextID = 1400104, shapeID = 20048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "314174", attackConstant = "2775", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 412, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30523] = {id = 30523, name = "白熊", nameTextID = 1400070, shapeID = 20060, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "89435", attackConstant = "1614", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201125, 201126, 201127}
, bodytype = 1, behaviacAI = "newbattleaif403", defaultBuff = "", MonsterType = 2015, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30524] = {id = 30524, name = "冰雪骑士团哨兵", nameTextID = 1400127, shapeID = 20043, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "89435", attackConstant = "1614", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201097, 201098, 201101}
, bodytype = 1, behaviacAI = "newbattleaif413", defaultBuff = "", MonsterType = 423, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30525] = {id = 30525, name = "冰雪骑士团哨兵", nameTextID = 1400127, shapeID = 20043, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "89435", attackConstant = "1614", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201097, 201098, 201101}
, bodytype = 1, behaviacAI = "newbattleaif413", defaultBuff = "", MonsterType = 423, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30526] = {id = 30526, name = "白熊", nameTextID = 1400070, shapeID = 20060, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "89435", attackConstant = "1614", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201125, 201126, 201127}
, bodytype = 1, behaviacAI = "newbattleaif403", defaultBuff = "", MonsterType = 2015, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30527] = {id = 30527, name = "哨兵", nameTextID = 1400069, shapeID = 20043, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "89435", attackConstant = "1614", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201097, 201098, 201101}
, bodytype = 1, behaviacAI = "newbattleaif413", defaultBuff = "", MonsterType = 413, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30528] = {id = 30528, name = "哨兵队长", nameTextID = 1400073, shapeID = 20046, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "319410", attackConstant = "2832", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201133, 201134, 201135, 201136, 201393}
, bodytype = 1, behaviacAI = "newbattleaif415", defaultBuff = "", MonsterType = 415, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30529] = {id = 30529, name = "哨兵", nameTextID = 1400069, shapeID = 20043, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "89435", attackConstant = "1614", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201097, 201098, 201101}
, bodytype = 1, behaviacAI = "newbattleaif413", defaultBuff = "", MonsterType = 413, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30530] = {id = 30530, name = "哨兵队长", nameTextID = 1400073, shapeID = 20046, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "319410", attackConstant = "2832", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201133, 201134, 201135, 201136, 201393}
, bodytype = 1, behaviacAI = "newbattleaif415", defaultBuff = "", MonsterType = 415, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30531] = {id = 30531, name = "冰霜飞蛾", nameTextID = 1400046, shapeID = 20085, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "89435", attackConstant = "1614", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201273}
, bodytype = 1, behaviacAI = "newbattleaItest12", defaultBuff = "", MonsterType = 601, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30532] = {id = 30532, name = "兰花树精", nameTextID = 1400047, shapeID = 20086, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "89435", attackConstant = "1614", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201274, 201275}
, bodytype = 1, behaviacAI = "newbattleaItest13", defaultBuff = "", MonsterType = 602, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30533] = {id = 30533, name = "冰霜飞蛾", nameTextID = 1400046, shapeID = 20085, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "89435", attackConstant = "1614", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201273}
, bodytype = 1, behaviacAI = "newbattleaItest12", defaultBuff = "", MonsterType = 601, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30534] = {id = 30534, name = "兰花树精", nameTextID = 1400047, shapeID = 20086, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "89435", attackConstant = "1614", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201274, 201275}
, bodytype = 1, behaviacAI = "newbattleaItest13", defaultBuff = "", MonsterType = 602, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30535] = {id = 30535, name = "白熊", nameTextID = 1400070, shapeID = 20060, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "89435", attackConstant = "1614", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201125, 201126, 201127}
, bodytype = 1, behaviacAI = "newbattleaif403", defaultBuff = "", MonsterType = 2015, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30536] = {id = 30536, name = "白熊", nameTextID = 1400070, shapeID = 20060, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "89435", attackConstant = "1614", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201125, 201126, 201127}
, bodytype = 1, behaviacAI = "newbattleaif403", defaultBuff = "", MonsterType = 2015, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30537] = {id = 30537, name = "冰雪骑士团哨兵", nameTextID = 1400127, shapeID = 20043, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "90901", attackConstant = "1644", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201097, 201098, 201101}
, bodytype = 1, behaviacAI = "newbattleaif413", defaultBuff = "", MonsterType = 423, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30538] = {id = 30538, name = "冰雪骑士团哨兵", nameTextID = 1400127, shapeID = 20043, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "90901", attackConstant = "1644", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201097, 201098, 201101}
, bodytype = 1, behaviacAI = "newbattleaif413", defaultBuff = "", MonsterType = 423, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30539] = {id = 30539, name = "卫兵", nameTextID = 1400071, shapeID = 20038, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "90901", attackConstant = "1644", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201099, 201100, 201101}
, bodytype = 1, behaviacAI = "newbattleaif414", defaultBuff = "", MonsterType = 414, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30540] = {id = 30540, name = "卫兵", nameTextID = 1400071, shapeID = 20038, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "90901", attackConstant = "1644", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201099, 201100, 201101}
, bodytype = 1, behaviacAI = "newbattleaif414", defaultBuff = "", MonsterType = 414, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30541] = {id = 30541, name = "卫兵队长", nameTextID = 1400074, shapeID = 20047, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "324647", attackConstant = "2889", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201137, 201138, 201139, 201140, 201394}
, bodytype = 1, behaviacAI = "newbattleaif416", defaultBuff = "", MonsterType = 416, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30542] = {id = 30542, name = "冰雪骑士团卫兵", nameTextID = 1400128, shapeID = 20038, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "90901", attackConstant = "1644", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201099, 201100, 201101}
, bodytype = 1, behaviacAI = "newbattleaif414", defaultBuff = "", MonsterType = 414, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30543] = {id = 30543, name = "冰雪骑士团卫兵", nameTextID = 1400128, shapeID = 20038, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "90901", attackConstant = "1644", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201099, 201100, 201101}
, bodytype = 1, behaviacAI = "newbattleaif414", defaultBuff = "", MonsterType = 414, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30544] = {id = 30544, name = "冰雪骑士团卫兵", nameTextID = 1400128, shapeID = 20038, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "90901", attackConstant = "1644", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201099, 201100, 201101}
, bodytype = 1, behaviacAI = "newbattleaif414", defaultBuff = "", MonsterType = 414, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30545] = {id = 30545, name = "冰雪骑士团卫兵", nameTextID = 1400128, shapeID = 20038, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "90901", attackConstant = "1644", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201099, 201100, 201101}
, bodytype = 1, behaviacAI = "newbattleaif414", defaultBuff = "", MonsterType = 414, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30546] = {id = 30546, name = "卫兵", nameTextID = 1400071, shapeID = 20038, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "90901", attackConstant = "1644", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201099, 201100, 201101}
, bodytype = 1, behaviacAI = "newbattleaif414", defaultBuff = "", MonsterType = 414, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30547] = {id = 30547, name = "卫兵", nameTextID = 1400071, shapeID = 20038, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "90901", attackConstant = "1644", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201099, 201100, 201101}
, bodytype = 1, behaviacAI = "newbattleaif414", defaultBuff = "", MonsterType = 414, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30548] = {id = 30548, name = "卫兵队长", nameTextID = 1400074, shapeID = 20047, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "324647", attackConstant = "2889", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201137, 201138, 201139, 201140, 201394}
, bodytype = 1, behaviacAI = "newbattleaif416", defaultBuff = "", MonsterType = 416, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30549] = {id = 30549, name = "冰雪骑士团哨兵", nameTextID = 1400127, shapeID = 20043, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 185, hpConstant = "92367", attackConstant = "1675", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201097, 201098, 201101}
, bodytype = 1, behaviacAI = "newbattleaif413", defaultBuff = "", MonsterType = 423, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30550] = {id = 30550, name = "冰雪骑士团卫兵", nameTextID = 1400128, shapeID = 20038, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 185, hpConstant = "92367", attackConstant = "1675", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201099, 201100, 201101}
, bodytype = 1, behaviacAI = "newbattleaif414", defaultBuff = "", MonsterType = 414, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30551] = {id = 30551, name = "冰雪骑士团卫兵", nameTextID = 1400128, shapeID = 20038, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 185, hpConstant = "92367", attackConstant = "1675", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201099, 201100, 201101}
, bodytype = 1, behaviacAI = "newbattleaif414", defaultBuff = "", MonsterType = 414, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30552] = {id = 30552, name = "冰雪骑士团卫兵", nameTextID = 1400128, shapeID = 20038, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 185, hpConstant = "92367", attackConstant = "1675", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201099, 201100, 201101}
, bodytype = 1, behaviacAI = "newbattleaif414", defaultBuff = "", MonsterType = 414, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30553] = {id = 30553, name = "兰花树精", nameTextID = 1400047, shapeID = 20086, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "93833", attackConstant = "1706", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201274, 201275}
, bodytype = 1, behaviacAI = "newbattleaItest13", defaultBuff = "", MonsterType = 602, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30554] = {id = 30554, name = "兰花树精", nameTextID = 1400047, shapeID = 20086, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "93833", attackConstant = "1706", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201274, 201275}
, bodytype = 1, behaviacAI = "newbattleaItest13", defaultBuff = "", MonsterType = 602, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30555] = {id = 30555, name = "冰霜巨人", nameTextID = 1400104, shapeID = 20048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "335119", attackConstant = "3005", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 412, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30556] = {id = 30556, name = "兰花树精", nameTextID = 1400047, shapeID = 20086, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "93833", attackConstant = "1706", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201274, 201275}
, bodytype = 1, behaviacAI = "newbattleaItest13", defaultBuff = "", MonsterType = 602, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30557] = {id = 30557, name = "冰霜飞蛾", nameTextID = 1400046, shapeID = 20085, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "93833", attackConstant = "1706", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201273}
, bodytype = 1, behaviacAI = "newbattleaItest12", defaultBuff = "", MonsterType = 601, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30558] = {id = 30558, name = "冰霜飞蛾", nameTextID = 1400046, shapeID = 20085, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "93833", attackConstant = "1706", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201273}
, bodytype = 1, behaviacAI = "newbattleaItest12", defaultBuff = "", MonsterType = 601, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30559] = {id = 30559, name = "兰花树精", nameTextID = 1400047, shapeID = 20086, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "93833", attackConstant = "1706", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201274, 201275}
, bodytype = 1, behaviacAI = "newbattleaItest13", defaultBuff = "", MonsterType = 602, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30560] = {id = 30560, name = "冰霜飞蛾", nameTextID = 1400046, shapeID = 20085, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "93833", attackConstant = "1706", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201273}
, bodytype = 1, behaviacAI = "newbattleaItest12", defaultBuff = "", MonsterType = 601, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30561] = {id = 30561, name = "冰霜魔菇", nameTextID = 1400049, shapeID = 20088, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "93833", attackConstant = "1706", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201278}
, bodytype = 1, behaviacAI = "newbattleaItest15", defaultBuff = "", MonsterType = 604, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30562] = {id = 30562, name = "冰霜独角仙", nameTextID = 1400048, shapeID = 20087, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "93833", attackConstant = "1706", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201277, 201276, 201338}
, bodytype = 1, behaviacAI = "newbattleaItest14", defaultBuff = "", MonsterType = 603, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30563] = {id = 30563, name = "冰霜魔菇", nameTextID = 1400049, shapeID = 20088, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "93833", attackConstant = "1706", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201278}
, bodytype = 1, behaviacAI = "newbattleaItest15", defaultBuff = "", MonsterType = 604, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30564] = {id = 30564, name = "冰霜独角仙", nameTextID = 1400048, shapeID = 20087, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "93833", attackConstant = "1706", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201277, 201276, 201338}
, bodytype = 1, behaviacAI = "newbattleaItest14", defaultBuff = "", MonsterType = 603, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30565] = {id = 30565, name = "冰霜巨人", nameTextID = 1400104, shapeID = 20048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "335119", attackConstant = "3005", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 412, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30566] = {id = 30566, name = "幻形幼虫", nameTextID = 1400147, shapeID = 20112, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "120555", attackConstant = "2950", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201476, 201477, 201478}
, bodytype = 1, behaviacAI = "newbattleaif801", defaultBuff = "", MonsterType = 801, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30567] = {id = 30567, name = "幻形虫", nameTextID = 1400148, shapeID = 20114, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "281295", attackConstant = "5901", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201479, 201480, 201481}
, bodytype = 1, behaviacAI = "newbattleaif802", defaultBuff = "", MonsterType = 802, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30568] = {id = 30568, name = "幻形幼虫", nameTextID = 1400147, shapeID = 20112, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "120555", attackConstant = "2950", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201476, 201477, 201478}
, bodytype = 1, behaviacAI = "newbattleaif801", defaultBuff = "", MonsterType = 801, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30569] = {id = 30569, name = "幻形幼虫", nameTextID = 1400147, shapeID = 20113, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "120555", attackConstant = "2950", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201476, 201477, 201478}
, bodytype = 1, behaviacAI = "newbattleaif801", defaultBuff = "", MonsterType = 801, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30570] = {id = 30570, name = "幻形幼虫", nameTextID = 1400147, shapeID = 20113, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "120555", attackConstant = "2950", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201476, 201477, 201478}
, bodytype = 1, behaviacAI = "newbattleaif801", defaultBuff = "", MonsterType = 801, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30571] = {id = 30571, name = "幻形虫", nameTextID = 1400148, shapeID = 20115, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "281295", attackConstant = "5901", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201479, 201480, 201481}
, bodytype = 1, behaviacAI = "newbattleaif802", defaultBuff = "", MonsterType = 802, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30572] = {id = 30572, name = "幻形幼虫", nameTextID = 1400147, shapeID = 20112, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "120555", attackConstant = "2950", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201476, 201477, 201478}
, bodytype = 1, behaviacAI = "newbattleaif801", defaultBuff = "", MonsterType = 801, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30573] = {id = 30573, name = "幻形虫", nameTextID = 1400148, shapeID = 20113, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "281295", attackConstant = "5901", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201479, 201480, 201481}
, bodytype = 1, behaviacAI = "newbattleaif802", defaultBuff = "", MonsterType = 802, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30574] = {id = 30574, name = "幻形飞蛾", nameTextID = 1400149, shapeID = 20125, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "281295", attackConstant = "5901", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201545, 201546, 201547, 201548, 201549}
, bodytype = 1, behaviacAI = "newbattleaif803", defaultBuff = "", MonsterType = 803, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30575] = {id = 30575, name = "嗜血蚊", nameTextID = 1400152, shapeID = 20100, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "281295", attackConstant = "5901", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201423, 201424, 201425}
, bodytype = 1, behaviacAI = "newbattleaif810", defaultBuff = "", MonsterType = 810, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30576] = {id = 30576, name = "嗜血蚊", nameTextID = 1400152, shapeID = 20100, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "281295", attackConstant = "5901", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201423, 201424, 201425}
, bodytype = 1, behaviacAI = "newbattleaif810", defaultBuff = "", MonsterType = 810, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30577] = {id = 30577, name = "嗜血蚊", nameTextID = 1400152, shapeID = 20100, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "281295", attackConstant = "5901", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201423, 201424, 201425}
, bodytype = 1, behaviacAI = "newbattleaif810", defaultBuff = "", MonsterType = 810, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30578] = {id = 30578, name = "杀人蜂", nameTextID = 1400154, shapeID = 20116, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "281295", attackConstant = "5901", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201490, 201491, 201492}
, bodytype = 1, behaviacAI = "newbattleaif812", defaultBuff = "", MonsterType = 812, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30579] = {id = 30579, name = "魔飞蛇", nameTextID = 1400142, shapeID = 20111, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "1205550", attackConstant = "12639", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201493, 201495, 201496, 201497, 201498, 201499, 201500, 201501}
, bodytype = 1, behaviacAI = "newbattleaif813", defaultBuff = "20116", MonsterType = 813, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[30580] = {id = 30580, name = "魔飞龙", nameTextID = 1400150, shapeID = 20109, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 235, hpConstant = "290272", attackConstant = "6152", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201473, 201474, 201475}
, bodytype = 1, behaviacAI = "newbattleaif806", defaultBuff = "", MonsterType = 806, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30581] = {id = 30581, name = "魔飞龙", nameTextID = 1400150, shapeID = 20109, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 235, hpConstant = "290272", attackConstant = "6152", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201473, 201474, 201475}
, bodytype = 1, behaviacAI = "newbattleaif806", defaultBuff = "", MonsterType = 806, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30582] = {id = 30582, name = "魔飞蛇", nameTextID = 1400142, shapeID = 20111, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 235, hpConstant = "1244025", attackConstant = "13199", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201493, 201495, 201496, 201497, 201498, 201499, 201500, 201501}
, bodytype = 1, behaviacAI = "newbattleaif813", defaultBuff = "20116", MonsterType = 813, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[30583] = {id = 30583, name = "针喙鸟", nameTextID = 1400153, shapeID = 20101, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 235, hpConstant = "290272", attackConstant = "6152", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201426, 201427, 201428}
, bodytype = 1, behaviacAI = "newbattleaif811", defaultBuff = "", MonsterType = 811, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30584] = {id = 30584, name = "魔飞龙", nameTextID = 1400150, shapeID = 20109, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 235, hpConstant = "290272", attackConstant = "6152", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201473, 201474, 201475}
, bodytype = 1, behaviacAI = "newbattleaif806", defaultBuff = "", MonsterType = 806, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30585] = {id = 30585, name = "针喙鸟", nameTextID = 1400153, shapeID = 20101, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 235, hpConstant = "290272", attackConstant = "6152", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201426, 201427, 201428}
, bodytype = 1, behaviacAI = "newbattleaif811", defaultBuff = "", MonsterType = 811, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30586] = {id = 30586, name = "魔飞龙", nameTextID = 1400150, shapeID = 20109, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 235, hpConstant = "290272", attackConstant = "6152", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201473, 201474, 201475}
, bodytype = 1, behaviacAI = "newbattleaif806", defaultBuff = "", MonsterType = 806, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30587] = {id = 30587, name = "针喙鸟", nameTextID = 1400153, shapeID = 20101, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201426, 201427, 201428}
, bodytype = 1, behaviacAI = "newbattleaif811", defaultBuff = "", MonsterType = 811, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30588] = {id = 30588, name = "针喙鸟", nameTextID = 1400153, shapeID = 20101, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201426, 201427, 201428}
, bodytype = 1, behaviacAI = "newbattleaif811", defaultBuff = "", MonsterType = 811, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30589] = {id = 30589, name = "孵化之卵", nameTextID = 1400140, shapeID = 20118, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201538, 201487, 201488, 201489}
, bodytype = 1, behaviacAI = "newbattleaif804_2", defaultBuff = "20116", MonsterType = 804, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30590] = {id = 30590, name = "孵化之卵", nameTextID = 1400140, shapeID = 20118, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201538, 201487, 201488, 201489}
, bodytype = 1, behaviacAI = "newbattleaif804", defaultBuff = "20116", MonsterType = 804, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30591] = {id = 30591, name = "孵化之卵", nameTextID = 1400140, shapeID = 20118, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201538, 201487, 201488, 201489}
, bodytype = 1, behaviacAI = "newbattleaif804", defaultBuff = "20116", MonsterType = 804, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30592] = {id = 30592, name = "幼飞蛇", nameTextID = 1400141, shapeID = 20110, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "128250", attackConstant = "3204", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201487, 201488, 201489}
, bodytype = 1, behaviacAI = "newbattleaif805", defaultBuff = "", MonsterType = 805, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30593] = {id = 30593, name = "孵化之卵", nameTextID = 1400140, shapeID = 20118, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201538, 201487, 201488, 201489}
, bodytype = 1, behaviacAI = "newbattleaif804", defaultBuff = "20116", MonsterType = 804, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30594] = {id = 30594, name = "幼飞蛇", nameTextID = 1400141, shapeID = 20110, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "128250", attackConstant = "3204", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201487, 201488, 201489}
, bodytype = 1, behaviacAI = "newbattleaif805", defaultBuff = "", MonsterType = 805, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30595] = {id = 30595, name = "巨雷龙", nameTextID = 1400155, shapeID = 20127, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1282500", attackConstant = "13770", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201505, 201506, 201507, 201508}
, bodytype = 1, behaviacAI = "newbattleaif814", defaultBuff = "20116", MonsterType = 814, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30596] = {id = 30596, name = "杀人蜂", nameTextID = 1400154, shapeID = 20116, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201490, 201491, 201492}
, bodytype = 1, behaviacAI = "newbattleaif812_1", defaultBuff = "", MonsterType = 812, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30597] = {id = 30597, name = "幼飞蛇", nameTextID = 1400141, shapeID = 20110, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "128250", attackConstant = "3204", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201487, 201488, 201489}
, bodytype = 1, behaviacAI = "newbattleaif805", defaultBuff = "", MonsterType = 805, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30598] = {id = 30598, name = "杀人蜂", nameTextID = 1400154, shapeID = 20116, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201490, 201491, 201492}
, bodytype = 1, behaviacAI = "newbattleaif812_1", defaultBuff = "", MonsterType = 812, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30599] = {id = 30599, name = "巨雷龙", nameTextID = 1400155, shapeID = 20127, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1282500", attackConstant = "13770", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201505, 201506, 201507, 201508}
, bodytype = 1, behaviacAI = "newbattleaif814", defaultBuff = "20116", MonsterType = 814, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30600] = {id = 30600, name = "嗜血蚊", nameTextID = 1400152, shapeID = 20100, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201423, 201424, 201425}
, bodytype = 1, behaviacAI = "newbattleaif810_1", defaultBuff = "", MonsterType = 810, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30601] = {id = 30601, name = "嗜血蚊", nameTextID = 1400152, shapeID = 20100, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201423, 201424, 201425}
, bodytype = 1, behaviacAI = "newbattleaif810_1", defaultBuff = "", MonsterType = 810, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30602] = {id = 30602, name = "嗜血蚊", nameTextID = 1400152, shapeID = 20100, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201423, 201424, 201425}
, bodytype = 1, behaviacAI = "newbattleaif810_1", defaultBuff = "", MonsterType = 810, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30603] = {id = 30603, name = "杀人蜂", nameTextID = 1400154, shapeID = 20116, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201490, 201491, 201492}
, bodytype = 1, behaviacAI = "newbattleaif812_1", defaultBuff = "", MonsterType = 812, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30604] = {id = 30604, name = "幻形虫", nameTextID = 1400148, shapeID = 20114, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201479, 201480, 201481}
, bodytype = 1, behaviacAI = "newbattleaif802_1", defaultBuff = "", MonsterType = 802, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30605] = {id = 30605, name = "幻形飞蛾", nameTextID = 1400149, shapeID = 20125, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201545, 201546, 201547, 201548, 201549}
, bodytype = 1, behaviacAI = "newbattleaif803_1", defaultBuff = "", MonsterType = 803, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30606] = {id = 30606, name = "幻形虫", nameTextID = 1400148, shapeID = 20115, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201479, 201480, 201481}
, bodytype = 1, behaviacAI = "newbattleaif802_1", defaultBuff = "", MonsterType = 802, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30607] = {id = 30607, name = "幻形飞蛾", nameTextID = 1400149, shapeID = 20126, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201545, 201546, 201547, 201548, 201549}
, bodytype = 1, behaviacAI = "newbattleaif803_1", defaultBuff = "", MonsterType = 803, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30608] = {id = 30608, name = "幻形飞蛾", nameTextID = 1400149, shapeID = 20125, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201545, 201546, 201547, 201548, 201549}
, bodytype = 1, behaviacAI = "newbattleaif803_1", defaultBuff = "", MonsterType = 803, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30609] = {id = 30609, name = "幻形飞蛾", nameTextID = 1400149, shapeID = 20126, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201545, 201546, 201547, 201548, 201549}
, bodytype = 1, behaviacAI = "newbattleaif803_1", defaultBuff = "", MonsterType = 803, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30610] = {id = 30610, name = "飞空鱼", nameTextID = 1400138, shapeID = 20099, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201429, 201430, 201431, 201432, 201433, 201434}
, bodytype = 1, behaviacAI = "newbattleaif807", defaultBuff = "", MonsterType = 807, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30611] = {id = 30611, name = "飞空鱼", nameTextID = 1400138, shapeID = 20099, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201429, 201430, 201431, 201432, 201433, 201434}
, bodytype = 1, behaviacAI = "newbattleaif807", defaultBuff = "", MonsterType = 807, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30612] = {id = 30612, name = "浮空锯齿鲨", nameTextID = 1400151, shapeID = 20092, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201400, 201401, 201402, 201403}
, bodytype = 1, behaviacAI = "newbattleaif808", defaultBuff = "", MonsterType = 808, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30613] = {id = 30613, name = "飞空鱼", nameTextID = 1400138, shapeID = 20099, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201429, 201430, 201431, 201432, 201433, 201434}
, bodytype = 1, behaviacAI = "newbattleaif807", defaultBuff = "", MonsterType = 807, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30614] = {id = 30614, name = "巨雷龙", nameTextID = 1400155, shapeID = 20127, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1282500", attackConstant = "13770", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201505, 201506, 201507, 201508}
, bodytype = 1, behaviacAI = "newbattleaif814", defaultBuff = "20116", MonsterType = 814, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30615] = {id = 30615, name = "浮空锯齿鲨", nameTextID = 1400151, shapeID = 20092, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201400, 201401, 201402, 201403}
, bodytype = 1, behaviacAI = "newbattleaif808", defaultBuff = "", MonsterType = 808, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30616] = {id = 30616, name = "飞空鱼", nameTextID = 1400138, shapeID = 20099, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201429, 201430, 201431, 201432, 201433, 201434}
, bodytype = 1, behaviacAI = "newbattleaif807", defaultBuff = "", MonsterType = 807, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30617] = {id = 30617, name = "浮空锯齿鲨", nameTextID = 1400151, shapeID = 20092, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201400, 201401, 201402, 201403}
, bodytype = 1, behaviacAI = "newbattleaif808", defaultBuff = "", MonsterType = 808, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30618] = {id = 30618, name = "飞空鱼", nameTextID = 1400138, shapeID = 20099, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201429, 201430, 201431, 201432, 201433, 201434}
, bodytype = 1, behaviacAI = "newbattleaif807", defaultBuff = "", MonsterType = 807, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30619] = {id = 30619, name = "浮空锯齿鲨", nameTextID = 1400151, shapeID = 20092, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201400, 201401, 201402, 201403}
, bodytype = 1, behaviacAI = "newbattleaif808", defaultBuff = "", MonsterType = 808, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30620] = {id = 30620, name = "飞空鱼", nameTextID = 1400138, shapeID = 20099, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201429, 201430, 201431, 201432, 201433, 201434}
, bodytype = 1, behaviacAI = "newbattleaif807", defaultBuff = "", MonsterType = 807, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30621] = {id = 30621, name = "杀人鲸", nameTextID = 1400156, shapeID = 20123, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1282500", attackConstant = "13770", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201509, 201510, 201511, 201512, 201513}
, bodytype = 1, behaviacAI = "newbattleaif815_1", defaultBuff = "20116", MonsterType = 815, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30622] = {id = 30622, name = "魔飞龙", nameTextID = 1400150, shapeID = 20109, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 265, hpConstant = "308227", attackConstant = "6666", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201473, 201474, 201475}
, bodytype = 1, behaviacAI = "newbattleaif806", defaultBuff = "", MonsterType = 806, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30623] = {id = 30623, name = "魔飞龙", nameTextID = 1400150, shapeID = 20109, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 265, hpConstant = "308227", attackConstant = "6666", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201473, 201474, 201475}
, bodytype = 1, behaviacAI = "newbattleaif806", defaultBuff = "", MonsterType = 806, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30624] = {id = 30624, name = "飞翼魔狼", nameTextID = 1400139, shapeID = 20107, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 265, hpConstant = "308227", attackConstant = "6666", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201444, 201445, 201446, 201447, 201448, 201449}
, bodytype = 1, behaviacAI = "newbattleaif809", defaultBuff = "", MonsterType = 809, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30625] = {id = 30625, name = "飞翼魔狼", nameTextID = 1400139, shapeID = 20107, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 265, hpConstant = "308227", attackConstant = "6666", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201444, 201445, 201446, 201447, 201448, 201449}
, bodytype = 1, behaviacAI = "newbattleaif809", defaultBuff = "", MonsterType = 809, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30626] = {id = 30626, name = "飞翼魔狼", nameTextID = 1400139, shapeID = 20107, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 265, hpConstant = "308227", attackConstant = "6666", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201444, 201445, 201446, 201447, 201448, 201449}
, bodytype = 1, behaviacAI = "newbattleaif809", defaultBuff = "", MonsterType = 809, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30627] = {id = 30627, name = "杀人鲸", nameTextID = 1400156, shapeID = 20123, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 265, hpConstant = "1320975", attackConstant = "14349", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201509, 201510, 201511, 201512, 201513}
, bodytype = 1, behaviacAI = "newbattleaif815_1", defaultBuff = "20116", MonsterType = 815, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30628] = {id = 30628, name = "飞翼魔狼", nameTextID = 1400139, shapeID = 20107, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 265, hpConstant = "308227", attackConstant = "6666", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201444, 201445, 201446, 201447, 201448, 201449}
, bodytype = 1, behaviacAI = "newbattleaif809", defaultBuff = "", MonsterType = 809, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30629] = {id = 30629, name = "杀人鲸", nameTextID = 1400156, shapeID = 20123, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 265, hpConstant = "1320975", attackConstant = "14349", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201509, 201510, 201511, 201512, 201513}
, bodytype = 1, behaviacAI = "newbattleaif815_1", defaultBuff = "20116", MonsterType = 815, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30630] = {id = 30630, name = "魂火", nameTextID = 1400039, shapeID = 20078, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "175312", attackConstant = "3300", defConstant = "0", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201217}
, bodytype = 1, behaviacAI = "newbattleaif501", defaultBuff = "20616", MonsterType = 501, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30631] = {id = 30631, name = "魂火", nameTextID = 1400039, shapeID = 20078, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "175312", attackConstant = "3300", defConstant = "0", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201217}
, bodytype = 1, behaviacAI = "newbattleaif501", defaultBuff = "20616", MonsterType = 501, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30632] = {id = 30632, name = "恶魔甲虫", nameTextID = 1400159, shapeID = 20119, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "175312", attackConstant = "3300", defConstant = "0", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201525, 201526}
, bodytype = 1, behaviacAI = "newbattleaif701", defaultBuff = "", MonsterType = 701, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30633] = {id = 30633, name = "恶魔犬", nameTextID = 1400160, shapeID = 20121, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "751338", attackConstant = "6843", defConstant = "0", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201527, 201528, 201529, 201530}
, bodytype = 1, behaviacAI = "newbattleaif703", defaultBuff = "20116", MonsterType = 703, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30634] = {id = 30634, name = "魂火", nameTextID = 1400039, shapeID = 20078, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "175312", attackConstant = "3300", defConstant = "0", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201217}
, bodytype = 1, behaviacAI = "newbattleaif501", defaultBuff = "20616", MonsterType = 501, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30635] = {id = 30635, name = "恶魔犬", nameTextID = 1400160, shapeID = 20121, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "751338", attackConstant = "6843", defConstant = "0", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201527, 201528, 201529, 201530}
, bodytype = 1, behaviacAI = "newbattleaif703", defaultBuff = "20116", MonsterType = 703, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30636] = {id = 30636, name = "恶魔甲虫", nameTextID = 1400159, shapeID = 20119, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "175312", attackConstant = "3300", defConstant = "0", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201525, 201526}
, bodytype = 1, behaviacAI = "newbattleaif701", defaultBuff = "", MonsterType = 701, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30637] = {id = 30637, name = "恶魔甲虫", nameTextID = 1400159, shapeID = 20119, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "175312", attackConstant = "3300", defConstant = "0", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201525, 201526}
, bodytype = 1, behaviacAI = "newbattleaif701", defaultBuff = "", MonsterType = 701, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30638] = {id = 30638, name = "小型时之塔守卫", nameTextID = 1400161, shapeID = 20120, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "175312", attackConstant = "3300", defConstant = "0", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201535, 201536}
, bodytype = 1, behaviacAI = "newbattleaif702", defaultBuff = "", MonsterType = 702, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30639] = {id = 30639, name = "恶魔犬", nameTextID = 1400160, shapeID = 20121, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "751338", attackConstant = "6843", defConstant = "0", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201527, 201528, 201529, 201530}
, bodytype = 1, behaviacAI = "newbattleaif703", defaultBuff = "20116", MonsterType = 703, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30640] = {id = 30640, name = "恶魔甲虫", nameTextID = 1400159, shapeID = 20119, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "175312", attackConstant = "3300", defConstant = "0", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201525, 201526}
, bodytype = 1, behaviacAI = "newbattleaif701", defaultBuff = "", MonsterType = 701, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30641] = {id = 30641, name = "小型时之塔守卫", nameTextID = 1400161, shapeID = 20120, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "175312", attackConstant = "3300", defConstant = "0", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201535, 201536}
, bodytype = 1, behaviacAI = "newbattleaif702", defaultBuff = "", MonsterType = 702, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30642] = {id = 30642, name = "小型时之塔守卫", nameTextID = 1400161, shapeID = 20120, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "175312", attackConstant = "3300", defConstant = "0", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201535, 201536}
, bodytype = 1, behaviacAI = "newbattleaif702", defaultBuff = "", MonsterType = 702, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30643] = {id = 30643, name = "时之塔中层守卫", nameTextID = 1400162, shapeID = 20122, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "751338", attackConstant = "6843", defConstant = "0", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201531, 201532, 201533, 201534}
, bodytype = 1, behaviacAI = "newbattleaif704", defaultBuff = "20116", MonsterType = 704, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30644] = {id = 30644, name = "小型时之塔守卫", nameTextID = 1400161, shapeID = 20120, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "175312", attackConstant = "3300", defConstant = "0", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201535, 201536}
, bodytype = 1, behaviacAI = "newbattleaif702", defaultBuff = "", MonsterType = 702, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30645] = {id = 30645, name = "小型时之塔守卫", nameTextID = 1400161, shapeID = 20120, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "175312", attackConstant = "3300", defConstant = "0", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201535, 201536}
, bodytype = 1, behaviacAI = "newbattleaif702", defaultBuff = "", MonsterType = 702, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30646] = {id = 30646, name = "时之塔中层守卫", nameTextID = 1400162, shapeID = 20122, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "751338", attackConstant = "6843", defConstant = "0", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201531, 201532, 201533, 201534}
, bodytype = 1, behaviacAI = "newbattleaif704", defaultBuff = "20116", MonsterType = 704, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30647] = {id = 30647, name = "魔能之手-火", nameTextID = 1400223, shapeID = 20202, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "439897", attackConstant = "7504", defConstant = "2075", magicattConstant = "0", magicDefConstant = "6227", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201758, 201759}
, bodytype = 1, behaviacAI = "NewBattlemonW3_53", defaultBuff = "21794", MonsterType = 907, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30648] = {id = 30648, name = "混沌分裂体", nameTextID = 1400230, shapeID = 20204, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "125685", attackConstant = "3126", defConstant = "1383", magicattConstant = "0", magicDefConstant = "4151", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201764, 201765}
, bodytype = 1, behaviacAI = "NewBattlemonW6_02", defaultBuff = "21794", MonsterType = 909, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30649] = {id = 30649, name = "秩序分裂体", nameTextID = 1400231, shapeID = 20205, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "125685", attackConstant = "3126", defConstant = "1383", magicattConstant = "0", magicDefConstant = "4151", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201762, 201763}
, bodytype = 1, behaviacAI = "NewBattlemonW6_03", defaultBuff = "21794", MonsterType = 910, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30650] = {id = 30650, name = "混沌分裂体", nameTextID = 1400230, shapeID = 20204, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "128250", attackConstant = "3212", defConstant = "1402", magicattConstant = "0", magicDefConstant = "4206", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201764, 201765}
, bodytype = 1, behaviacAI = "NewBattlemonW6_02", defaultBuff = "21794", MonsterType = 909, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30651] = {id = 30651, name = "秩序分裂体", nameTextID = 1400231, shapeID = 20205, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "128250", attackConstant = "3212", defConstant = "1402", magicattConstant = "0", magicDefConstant = "4206", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201762, 201763}
, bodytype = 1, behaviacAI = "NewBattlemonW6_03", defaultBuff = "21794", MonsterType = 910, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30652] = {id = 30652, name = "混沌之子", nameTextID = 1400232, shapeID = 20206, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "3847500", attackConstant = "13813", defConstant = "3505", magicattConstant = "0", magicDefConstant = "10516", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201764, 201767, 201769, 201771}
, bodytype = 1, behaviacAI = "NewBattlemonW3_12", defaultBuff = "21794", MonsterType = 911, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[30653] = {id = 30653, name = "秩序之子", nameTextID = 1400233, shapeID = 20207, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "3847500", attackConstant = "13813", defConstant = "3505", magicattConstant = "0", magicDefConstant = "10516", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201762, 201766, 201768, 201770}
, bodytype = 1, behaviacAI = "NewBattlemonW3_13", defaultBuff = "21794", MonsterType = 912, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[30654] = {id = 30654, name = "混沌分裂体", nameTextID = 1400230, shapeID = 20204, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 260, hpConstant = "130815", attackConstant = "3299", defConstant = "1420", magicattConstant = "0", magicDefConstant = "4261", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201764, 201765}
, bodytype = 1, behaviacAI = "NewBattlemonW6_02", defaultBuff = "21794", MonsterType = 909, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30655] = {id = 30655, name = "秩序分裂体", nameTextID = 1400231, shapeID = 20205, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 260, hpConstant = "130815", attackConstant = "3299", defConstant = "1420", magicattConstant = "0", magicDefConstant = "4261", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201762, 201763}
, bodytype = 1, behaviacAI = "NewBattlemonW6_03", defaultBuff = "21794", MonsterType = 910, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30656] = {id = 30656, name = "小精灵龙", nameTextID = 1400219, shapeID = 20197, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 260, hpConstant = "366282", attackConstant = "9238", defConstant = "2130", magicattConstant = "0", magicDefConstant = "6392", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201740, 201741}
, bodytype = 1, behaviacAI = "NewBattlemonW3_15", defaultBuff = "21794", MonsterType = 903, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30657] = {id = 30657, name = "精灵龙幼体", nameTextID = 1400221, shapeID = 20200, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 260, hpConstant = "305235", attackConstant = "7918", defConstant = "2130", magicattConstant = "0", magicDefConstant = "6392", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201754, 201755, 201740, 201741}
, bodytype = 1, behaviacAI = "NewBattlemonW3_14", defaultBuff = "21794", MonsterType = 905, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30658] = {id = 30658, name = "混沌之子", nameTextID = 1400232, shapeID = 20206, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 280, hpConstant = "1359450", attackConstant = "14991", defConstant = "3642", magicattConstant = "0", magicDefConstant = "10928", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201764, 201767, 201769, 201771}
, bodytype = 1, behaviacAI = "NewBattlemonW3_12", defaultBuff = "21794", MonsterType = 911, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[30659] = {id = 30659, name = "秩序之子", nameTextID = 1400233, shapeID = 20207, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 280, hpConstant = "1359450", attackConstant = "14991", defConstant = "3642", magicattConstant = "0", magicDefConstant = "10928", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201762, 201766, 201768, 201770}
, bodytype = 1, behaviacAI = "NewBattlemonW3_13", defaultBuff = "21794", MonsterType = 912, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[30660] = {id = 30660, name = "小精灵龙", nameTextID = 1400219, shapeID = 20197, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 270, hpConstant = "373464", attackConstant = "9483", defConstant = "2158", magicattConstant = "0", magicDefConstant = "6474", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201740, 201741}
, bodytype = 1, behaviacAI = "NewBattlemonW3_15", defaultBuff = "21794", MonsterType = 903, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30661] = {id = 30661, name = "精灵龙幼体", nameTextID = 1400221, shapeID = 20200, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 270, hpConstant = "311220", attackConstant = "8128", defConstant = "2158", magicattConstant = "0", magicDefConstant = "6474", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201754, 201755, 201740, 201741}
, bodytype = 1, behaviacAI = "NewBattlemonW3_14", defaultBuff = "21794", MonsterType = 905, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30662] = {id = 30662, name = "蝠翼飞狮", nameTextID = 1400157, shapeID = 20117, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 270, hpConstant = "1333800", attackConstant = "14594", defConstant = "3597", magicattConstant = "0", magicDefConstant = "10791", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201514, 201515, 201516, 201517, 201518, 201519, 201520}
, bodytype = 1, behaviacAI = "newbattleaif517", defaultBuff = "21794", MonsterType = 920, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30663] = {id = 30663, name = "精灵龙幼体", nameTextID = 1400221, shapeID = 20200, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 280, hpConstant = "317205", attackConstant = "8340", defConstant = "2185", magicattConstant = "0", magicDefConstant = "6557", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201754, 201755, 201740, 201741}
, bodytype = 1, behaviacAI = "NewBattlemonW3_14", defaultBuff = "21794", MonsterType = 905, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30664] = {id = 30664, name = "精灵龙", nameTextID = 1400220, shapeID = 20198, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 280, hpConstant = "2039175", attackConstant = "20987", defConstant = "3642", magicattConstant = "0", magicDefConstant = "10928", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201750, 201751}
, bodytype = 1, behaviacAI = "NewBattlemonW3_16", defaultBuff = "21794", MonsterType = 904, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[30665] = {id = 30665, name = "双子绞杀者", nameTextID = 1400136, shapeID = 20141, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "2680425;2680425;2680425;2680425", attackConstant = "18958", defConstant = "7468", magicattConstant = "0", magicDefConstant = "22405", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201418, 201419, 201420, 201421, 201422, 201620}
, bodytype = 1, behaviacAI = "newbattleai20228", defaultBuff = "21794", MonsterType = 921, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[30666] = {id = 30666, name = "魔能之手-风", nameTextID = 1400222, shapeID = 20201, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "484785", attackConstant = "8554", defConstant = "2213", magicattConstant = "0", magicDefConstant = "6639", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201756, 201757}
, bodytype = 1, behaviacAI = "NewBattlemonW3_52", defaultBuff = "21794", MonsterType = 906, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30667] = {id = 30667, name = "魔能之手-火", nameTextID = 1400223, shapeID = 20202, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "484785", attackConstant = "8554", defConstant = "2213", magicattConstant = "0", magicDefConstant = "6639", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201758, 201759}
, bodytype = 1, behaviacAI = "NewBattlemonW3_53", defaultBuff = "21794", MonsterType = 907, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30668] = {id = 30668, name = "魔能之手-水", nameTextID = 1400224, shapeID = 20203, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "484785", attackConstant = "8554", defConstant = "2213", magicattConstant = "0", magicDefConstant = "6639", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201760, 201761}
, bodytype = 1, behaviacAI = "NewBattlemonW3_54", defaultBuff = "21794", MonsterType = 908, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30669] = {id = 30669, name = "蝠翼飞狮", nameTextID = 1400157, shapeID = 20117, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1385100", attackConstant = "15392", defConstant = "3688", magicattConstant = "0", magicDefConstant = "11065", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201514, 201515, 201516, 201517, 201518, 201519, 201520}
, bodytype = 1, behaviacAI = "newbattleaif517", defaultBuff = "21794", MonsterType = 920, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30670] = {id = 30670, name = "达修斯", nameTextID = 1400239, shapeID = 20215, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "2729160;2729160;2729160;2729160", attackConstant = "24312", defConstant = "7560", magicattConstant = "0", magicDefConstant = "22680", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201850, 201851, 201852, 201853}
, bodytype = 1, behaviacAI = "NewBattlemonW6_023", defaultBuff = "21794", MonsterType = 919, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[30671] = {id = 30671, name = "魔能之手-风", nameTextID = 1400222, shapeID = 20201, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "493762", attackConstant = "8771", defConstant = "2240", magicattConstant = "0", magicDefConstant = "6721", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201756, 201757}
, bodytype = 1, behaviacAI = "NewBattlemonW3_52", defaultBuff = "21794", MonsterType = 906, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30672] = {id = 30672, name = "魔能之手-火", nameTextID = 1400223, shapeID = 20202, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "493762", attackConstant = "8771", defConstant = "2240", magicattConstant = "0", magicDefConstant = "6721", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201758, 201759}
, bodytype = 1, behaviacAI = "NewBattlemonW3_53", defaultBuff = "21794", MonsterType = 907, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30673] = {id = 30673, name = "魔能之手-水", nameTextID = 1400224, shapeID = 20203, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "493762", attackConstant = "8771", defConstant = "2240", magicattConstant = "0", magicDefConstant = "6721", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201760, 201761}
, bodytype = 1, behaviacAI = "NewBattlemonW3_54", defaultBuff = "21794", MonsterType = 908, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30674] = {id = 30674, name = "神族幻术师", nameTextID = 1400236, shapeID = 20210, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "1410750", attackConstant = "23697", defConstant = "3734", magicattConstant = "0", magicDefConstant = "11202", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201788, 201789}
, bodytype = 1, behaviacAI = "NewBattlemonW3_01", defaultBuff = "21794", MonsterType = 915, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30675] = {id = 30675, name = "飞马", nameTextID = 1400237, shapeID = 20213, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "2116125", attackConstant = "20538", defConstant = "3734", magicattConstant = "0", magicDefConstant = "11202", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201790, 201791, 201792, 201849}
, bodytype = 1, behaviacAI = "NewBattlemonW6_04", defaultBuff = "20115;21794", MonsterType = 918, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[30676] = {id = 30676, name = "守卫神官", nameTextID = 1400240, shapeID = 20208, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 330, hpConstant = "3768840;3768840;3768840;3768840;3768840", attackConstant = "25563", defConstant = "23228", magicattConstant = "0", magicDefConstant = "7742", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201780, 201781, 201782, 201783, 201784, 201785, 201786, 201787}
, bodytype = 1, behaviacAI = "NewBattlebossW6_4", defaultBuff = "20116;20115;21797", MonsterType = 913, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[30677] = {id = 30677, name = "魔能之手-风", nameTextID = 1400222, shapeID = 20201, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "502740", attackConstant = "8989", defConstant = "2268", magicattConstant = "0", magicDefConstant = "6804", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201756, 201757}
, bodytype = 1, behaviacAI = "NewBattlemonW3_52", defaultBuff = "21794", MonsterType = 906, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30678] = {id = 30678, name = "魔能之手-火", nameTextID = 1400223, shapeID = 20202, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "502740", attackConstant = "8989", defConstant = "2268", magicattConstant = "0", magicDefConstant = "6804", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201758, 201759}
, bodytype = 1, behaviacAI = "NewBattlemonW3_53", defaultBuff = "21794", MonsterType = 907, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30679] = {id = 30679, name = "魔能之手-水", nameTextID = 1400224, shapeID = 20203, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "502740", attackConstant = "8989", defConstant = "2268", magicattConstant = "0", magicDefConstant = "6804", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201760, 201761}
, bodytype = 1, behaviacAI = "NewBattlemonW3_54", defaultBuff = "21794", MonsterType = 908, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30680] = {id = 30680, name = "神族幻术师", nameTextID = 1400236, shapeID = 20210, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1436400", attackConstant = "24312", defConstant = "3780", magicattConstant = "0", magicDefConstant = "11340", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201788, 201789}
, bodytype = 1, behaviacAI = "NewBattlemonW3_01", defaultBuff = "21794", MonsterType = 915, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30681] = {id = 30681, name = "魔能之手-水", nameTextID = 1400224, shapeID = 20203, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 320, hpConstant = "511717", attackConstant = "9210", defConstant = "2295", magicattConstant = "0", magicDefConstant = "6886", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201760, 201761}
, bodytype = 1, behaviacAI = "NewBattlemonW3_54", defaultBuff = "21794", MonsterType = 908, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30682] = {id = 30682, name = "神族幻术师", nameTextID = 1400236, shapeID = 20210, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 320, hpConstant = "1462050", attackConstant = "24934", defConstant = "3825", magicattConstant = "0", magicDefConstant = "11477", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201788, 201789}
, bodytype = 1, behaviacAI = "NewBattlemonW3_01", defaultBuff = "21794", MonsterType = 915, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[30683] = {id = 30683, name = "卡蜜莉安1（boss战斗）", nameTextID = 1400228, shapeID = 20211, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 350, hpConstant = "1949400;1949400;1949400", attackConstant = "17893", defConstant = "7925", magicattConstant = "0", magicDefConstant = "23777", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201807, 201808, 201809, 201810, 201812}
, bodytype = 1, behaviacAI = "NewBattlebossW6_1", defaultBuff = "20116;20115;21795", MonsterType = 916, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[30684] = {id = 30684, name = "卡蜜莉安2（boss战斗）", nameTextID = 1400228, shapeID = 20212, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 350, hpConstant = "2924100;2924100;2924100;2924100;2924100", attackConstant = "26839", defConstant = "7925", magicattConstant = "0", magicDefConstant = "23777", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201814, 201815, 201816, 201817, 201819, 201821, 201822, 201824, 201825, 201826, 201827}
, bodytype = 1, behaviacAI = "NewBattlebossW6_2", defaultBuff = "20116;21776;20115;21795", MonsterType = 917, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[30685] = {id = 30685, name = "飞马", nameTextID = 1400237, shapeID = 20213, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "2154600", attackConstant = "21071", defConstant = "3780", magicattConstant = "0", magicDefConstant = "11340", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201790, 201791, 201792, 201849}
, bodytype = 1, behaviacAI = "NewBattlemonW6_04", defaultBuff = "20115;21794", MonsterType = 918, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[60001] = {id = 60001, name = "玛那副本1", nameTextID = 1400175, shapeID = 20093, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "20000;20000", attackConstant = "176", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201439, 201441}
, bodytype = 1, behaviacAI = "NewBattleAIfb25", defaultBuff = "20116", MonsterType = 11001, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60002] = {id = 60002, name = "玛那副本2", nameTextID = 1400175, shapeID = 20093, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 40, hpConstant = "60000;60000", attackConstant = "440", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201441, 201442, 201439, 201443}
, bodytype = 1, behaviacAI = "NewBattleAIfb26", defaultBuff = "20116", MonsterType = 11001, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60003] = {id = 60003, name = "玛那副本3", nameTextID = 1400175, shapeID = 20093, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 80, hpConstant = "160000;160000", attackConstant = "1100", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201437, 201443, 201442, 201441, 201613}
, bodytype = 1, behaviacAI = "NewBattleAIfb27", defaultBuff = "20116", MonsterType = 11001, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60004] = {id = 60004, name = "玛那副本4", nameTextID = 1400175, shapeID = 20093, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "450000;450000;450000", attackConstant = "2750", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201435, 201441, 201439, 201443, 201600, 201614}
, bodytype = 1, behaviacAI = "NewBattleAIfb28", defaultBuff = "20116", MonsterType = 11001, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60005] = {id = 60005, name = "玛那副本5", nameTextID = 1400175, shapeID = 20093, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "500000;500000;500000", attackConstant = "3080", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201436, 201442, 201600}
, bodytype = 1, behaviacAI = "NewBattleAIfb29", defaultBuff = "20848;20116", MonsterType = 11001, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60006] = {id = 60006, name = "玛那副本6", nameTextID = 1400175, shapeID = 20093, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "550000;550000;550000", attackConstant = "3740", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201438, 201435, 201442, 201600, 201614}
, bodytype = 1, behaviacAI = "NewBattleAIfb30", defaultBuff = "20848;20116", MonsterType = 11001, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60007] = {id = 60007, name = "突破-破坏刺杀1", nameTextID = 1400173, shapeID = 20094, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "30000", attackConstant = "56", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201593, 201405, 201600, 201601}
, bodytype = 1, behaviacAI = "NewBattleAIfb24", defaultBuff = "20116", MonsterType = 11006, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60008] = {id = 60008, name = "突破-破坏刺杀2", nameTextID = 1400173, shapeID = 20094, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "100000", attackConstant = "160", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201593, 201405, 201600, 201601}
, bodytype = 1, behaviacAI = "NewBattleAIfb24", defaultBuff = "20116", MonsterType = 11006, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60009] = {id = 60009, name = "突破-破坏刺杀3", nameTextID = 1400173, shapeID = 20094, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "200000;200000", attackConstant = "400", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201593, 201405, 201605, 201600, 201601}
, bodytype = 1, behaviacAI = "NewBattleAIfb32", defaultBuff = "20116", MonsterType = 11006, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60010] = {id = 60010, name = "突破-守护恢复1", nameTextID = 1400174, shapeID = 20095, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "80000", attackConstant = "250", defConstant = "99999", magicattConstant = "99999", magicDefConstant = "99999", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201598, 201599, 201597, 201601, 201600}
, bodytype = 1, behaviacAI = "NewBattleAIfb37", defaultBuff = "20116", MonsterType = 11008, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60011] = {id = 60011, name = "突破-守护恢复2", nameTextID = 1400174, shapeID = 20095, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "80000", attackConstant = "700", defConstant = "99999", magicattConstant = "99999", magicDefConstant = "99999", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201598, 201599, 201597, 201601, 201600}
, bodytype = 1, behaviacAI = "NewBattleAIfb37", defaultBuff = "20116", MonsterType = 11008, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60012] = {id = 60012, name = "突破-守护恢复3", nameTextID = 1400174, shapeID = 20095, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "96000;48000", attackConstant = "1500", defConstant = "99999", magicattConstant = "99999", magicDefConstant = "99999", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201598, 201599, 201597, 201606, 201601, 201600}
, bodytype = 1, behaviacAI = "NewBattleAIfb38", defaultBuff = "20116", MonsterType = 11008, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60013] = {id = 60013, name = "突破-特殊魔导1", nameTextID = 1400172, shapeID = 20096, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "30000", attackConstant = "70", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201522, 201523, 201608}
, bodytype = 1, behaviacAI = "NewBattleAIfb34", defaultBuff = "20116", MonsterType = 11007, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60014] = {id = 60014, name = "突破-特殊魔导2", nameTextID = 1400172, shapeID = 20096, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "100000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201522, 201523, 201608}
, bodytype = 1, behaviacAI = "NewBattleAIfb34", defaultBuff = "20116", MonsterType = 11007, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60015] = {id = 60015, name = "突破-特殊魔导3", nameTextID = 1400172, shapeID = 20096, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "200000;200000", attackConstant = "500", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201522, 201523, 201608, 201600, 201605, 201610}
, bodytype = 1, behaviacAI = "NewBattleAIfb35", defaultBuff = "20116", MonsterType = 11007, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60016] = {id = 60016, name = "恐惧", nameTextID = 1400131, shapeID = 20102, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 10, hpConstant = "15000", attackConstant = "76", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201453, 201450, 201451, 201452, 201454, 201455, 201456, 201457, 201458, 201459, 201460, 201461, 201462, 201463, 201465, 201466, 201467, 201468, 201469}
, bodytype = 1, behaviacAI = "NewBattleAIskillfb01", defaultBuff = "20116", MonsterType = 11002, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60017] = {id = 60017, name = "恐惧", nameTextID = 1400131, shapeID = 20102, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 30, hpConstant = "30000", attackConstant = "160", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201453, 201450, 201451, 201452, 201454, 201455, 201456, 201457, 201458, 201459, 201460, 201461, 201462, 201463, 201465, 201466, 201467, 201468, 201469}
, bodytype = 1, behaviacAI = "NewBattleAIskillfb01", defaultBuff = "20116", MonsterType = 11003, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60018] = {id = 60018, name = "恐惧", nameTextID = 1400131, shapeID = 20102, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 80, hpConstant = "150000;150000", attackConstant = "800", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201453, 201470, 201454, 201455, 201456, 201457, 201458, 201459, 201460, 201461, 201462, 201463, 201465, 201466, 201467, 201468, 201469}
, bodytype = 1, behaviacAI = "NewBattleAIskillfb02", defaultBuff = "20116", MonsterType = 11003, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60019] = {id = 60019, name = "恐惧", nameTextID = 1400131, shapeID = 20102, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 130, hpConstant = "200000;200000", attackConstant = "1200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201453, 201470, 201454, 201455, 201456, 201457, 201458, 201459, 201460, 201461, 201462, 201463, 201465, 201466, 201467, 201468, 201469}
, bodytype = 1, behaviacAI = "NewBattleAIskillfb02", defaultBuff = "20116", MonsterType = 11004, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60020] = {id = 60020, name = "恐惧", nameTextID = 1400131, shapeID = 20102, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "300000;300000;300000", attackConstant = "2080", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201453, 201470, 201471, 201458, 201459, 201460, 201461, 201462, 201463, 201465, 201466, 201467, 201468, 201469, 201455}
, bodytype = 1, behaviacAI = "NewBattleAIskillfb03", defaultBuff = "20116", MonsterType = 11004, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60021] = {id = 60021, name = "恐惧", nameTextID = 1400131, shapeID = 20102, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "400000;400000;400000", attackConstant = "2560", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201453, 201470, 201471, 201458, 201459, 201460, 201461, 201462, 201463, 201465, 201466, 201467, 201468, 201469, 201455}
, bodytype = 1, behaviacAI = "NewBattleAIskillfb03", defaultBuff = "20116", MonsterType = 11005, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60022] = {id = 60022, name = "恐惧", nameTextID = 1400131, shapeID = 20102, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "400000;400000;400000;400000", attackConstant = "2640", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201453, 201470, 201471, 201472, 201463, 201465, 201466, 201467, 201468, 201469, 201455, 201459}
, bodytype = 1, behaviacAI = "NewBattleAIskillfb04", defaultBuff = "20116", MonsterType = 11005, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60023] = {id = 60023, name = "恐惧", nameTextID = 1400131, shapeID = 20102, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "550000;550000;550000;550000", attackConstant = "5200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201453, 201470, 201471, 201472, 201463, 201465, 201466, 201467, 201468, 201469, 201455, 201459}
, bodytype = 1, behaviacAI = "NewBattleAIskillfb04", defaultBuff = "20116", MonsterType = 11005, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60024] = {id = 60024, name = "装备-破坏刺杀1", nameTextID = 1400135, shapeID = 20106, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "30000", attackConstant = "56", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201550, 201551, 201552, 201553, 201554, 201555, 201556, 201557, 201558, 201559, 201588, 201589}
, bodytype = 1, behaviacAI = "NewBattleAIEquipSword01", defaultBuff = "20116", MonsterType = 11009, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60025] = {id = 60025, name = "装备-破坏刺杀2", nameTextID = 1400135, shapeID = 20106, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 40, hpConstant = "80000", attackConstant = "136", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201550, 201551, 201552, 201553, 201554, 201555, 201556, 201557, 201558, 201559, 201588, 201589}
, bodytype = 1, behaviacAI = "NewBattleAIEquipSword01", defaultBuff = "20116", MonsterType = 11009, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60026] = {id = 60026, name = "装备-破坏刺杀3", nameTextID = 1400135, shapeID = 20106, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "150000;150000", attackConstant = "400", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201550, 201551, 201552, 201553, 201554, 201555, 201556, 201557, 201558, 201559, 201588, 201589}
, bodytype = 1, behaviacAI = "NewBattleAIEquipSword02", defaultBuff = "20116", MonsterType = 11009, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60027] = {id = 60027, name = "装备-破坏刺杀4", nameTextID = 1400135, shapeID = 20106, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "400000;400000", attackConstant = "800", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201550, 201551, 201552, 201553, 201554, 201555, 201556, 201557, 201558, 201559, 201588, 201589}
, bodytype = 1, behaviacAI = "NewBattleAIEquipSword02", defaultBuff = "20116", MonsterType = 11009, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60028] = {id = 60028, name = "装备-守护恢复1", nameTextID = 1400135, shapeID = 20106, deadtype = 2, bossOrNot = 1, showhp = 0, levelMode = 4, npcLevel = 20, hpConstant = "9999999", attackConstant = "160", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201550, 201551, 201552, 201553, 201554, 201555, 201556, 201557, 201558, 201559, 201588, 201589}
, bodytype = 1, behaviacAI = "NewBattleAIEquipHammer01", defaultBuff = "20936", MonsterType = 11009, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60029] = {id = 60029, name = "装备-守护恢复2", nameTextID = 1400135, shapeID = 20106, deadtype = 2, bossOrNot = 1, showhp = 0, levelMode = 4, npcLevel = 40, hpConstant = "9999999", attackConstant = "400", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201550, 201551, 201552, 201553, 201554, 201555, 201556, 201557, 201558, 201559, 201588, 201589}
, bodytype = 1, behaviacAI = "NewBattleAIEquipHammer01", defaultBuff = "20936", MonsterType = 11009, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60030] = {id = 60030, name = "装备-守护恢复3", nameTextID = 1400135, shapeID = 20106, deadtype = 2, bossOrNot = 1, showhp = 0, levelMode = 4, npcLevel = 90, hpConstant = "9999999", attackConstant = "1120", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201550, 201551, 201552, 201553, 201554, 201555, 201556, 201557, 201558, 201559, 201588, 201589}
, bodytype = 1, behaviacAI = "NewBattleAIEquipHammer02", defaultBuff = "20936", MonsterType = 11009, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60031] = {id = 60031, name = "装备-守护恢复4", nameTextID = 1400135, shapeID = 20106, deadtype = 2, bossOrNot = 1, showhp = 0, levelMode = 4, npcLevel = 140, hpConstant = "9999999", attackConstant = "2400", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201550, 201551, 201552, 201553, 201554, 201555, 201556, 201557, 201558, 201559, 201588, 201589}
, bodytype = 1, behaviacAI = "NewBattleAIEquipHammer02", defaultBuff = "20936", MonsterType = 11009, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60032] = {id = 60032, name = "装备-特殊魔导1", nameTextID = 1400135, shapeID = 20106, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "30000", attackConstant = "56", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201550, 201551, 201552, 201553, 201554, 201555, 201556, 201557, 201558, 201559, 201588, 201589}
, bodytype = 1, behaviacAI = "NewBattleAIEquipStaff01", defaultBuff = "20116", MonsterType = 11009, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60033] = {id = 60033, name = "装备-特殊魔导2", nameTextID = 1400135, shapeID = 20106, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 40, hpConstant = "80000", attackConstant = "136", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201550, 201551, 201552, 201553, 201554, 201555, 201556, 201557, 201558, 201559, 201588, 201589}
, bodytype = 1, behaviacAI = "NewBattleAIEquipStaff01", defaultBuff = "20116", MonsterType = 11009, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60034] = {id = 60034, name = "装备-特殊魔导3", nameTextID = 1400135, shapeID = 20106, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "150000;150000", attackConstant = "400", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201550, 201551, 201552, 201553, 201554, 201555, 201556, 201557, 201558, 201559, 201588, 201589}
, bodytype = 1, behaviacAI = "NewBattleAIEquipStaff02", defaultBuff = "20116", MonsterType = 11009, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60035] = {id = 60035, name = "装备-特殊魔导4", nameTextID = 1400135, shapeID = 20106, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "400000;400000", attackConstant = "800", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201550, 201551, 201552, 201553, 201554, 201555, 201556, 201557, 201558, 201559, 201588, 201589}
, bodytype = 1, behaviacAI = "NewBattleAIEquipStaff02", defaultBuff = "20116", MonsterType = 11009, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60036] = {id = 60036, name = "突破-破坏刺杀4", nameTextID = 1400173, shapeID = 20094, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "350000;350000", attackConstant = "480", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201593, 201405, 201605, 201600, 201601}
, bodytype = 1, behaviacAI = "NewBattleAIfb32", defaultBuff = "20116", MonsterType = 11006, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60037] = {id = 60037, name = "突破-破坏刺杀5", nameTextID = 1400173, shapeID = 20094, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "450000;450000;450000", attackConstant = "880", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201404, 201405, 201409, 201602, 201603, 201601}
, bodytype = 1, behaviacAI = "NewBattleAIfb33", defaultBuff = "20116", MonsterType = 11006, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60038] = {id = 60038, name = "突破-破坏刺杀6", nameTextID = 1400173, shapeID = 20094, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "550000;550000;550000", attackConstant = "1040", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201404, 201405, 201409, 201602, 201603, 201601}
, bodytype = 1, behaviacAI = "NewBattleAIfb33", defaultBuff = "20116", MonsterType = 11006, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60039] = {id = 60039, name = "突破-守护恢复4", nameTextID = 1400174, shapeID = 20095, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "96000;48000", attackConstant = "1800", defConstant = "99999", magicattConstant = "99999", magicDefConstant = "99999", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201598, 201599, 201597, 201606, 201601, 201600}
, bodytype = 1, behaviacAI = "NewBattleAIfb38", defaultBuff = "20116", MonsterType = 11008, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60040] = {id = 60040, name = "突破-守护恢复5", nameTextID = 1400174, shapeID = 20095, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "96000;48000", attackConstant = "3500", defConstant = "99999", magicattConstant = "99999", magicDefConstant = "99999", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201598, 201599, 201607, 201609, 201601, 201600}
, bodytype = 1, behaviacAI = "NewBattleAIfb39", defaultBuff = "20116", MonsterType = 11008, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60041] = {id = 60041, name = "突破-守护恢复6", nameTextID = 1400174, shapeID = 20095, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "96000;48000", attackConstant = "4000", defConstant = "99999", magicattConstant = "99999", magicDefConstant = "99999", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201598, 201599, 201607, 201609, 201601, 201600}
, bodytype = 1, behaviacAI = "NewBattleAIfb39", defaultBuff = "20116", MonsterType = 11008, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60042] = {id = 60042, name = "突破-特殊魔导4", nameTextID = 1400172, shapeID = 20096, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "350000;350000", attackConstant = "600", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201522, 201523, 201608, 201600, 201605, 201610}
, bodytype = 1, behaviacAI = "NewBattleAIfb35", defaultBuff = "20116", MonsterType = 11007, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60043] = {id = 60043, name = "突破-特殊魔导5", nameTextID = 1400172, shapeID = 20096, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "450000;450000;450000", attackConstant = "1100", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201523, 201524, 201608, 201609, 201603, 201611}
, bodytype = 1, behaviacAI = "NewBattleAIfb36", defaultBuff = "20116", MonsterType = 11007, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[60044] = {id = 60044, name = "突破-特殊魔导6", nameTextID = 1400172, shapeID = 20096, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "550000;550000;550000", attackConstant = "1300", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201523, 201524, 201608, 201609, 201603, 201611}
, bodytype = 1, behaviacAI = "NewBattleAIfb36", defaultBuff = "20116", MonsterType = 11007, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62001] = {id = 62001, name = "古塔蝙蝠", nameTextID = 1400052, shapeID = 50001, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "4485", attackConstant = "214", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "40", damagereduce = "0", attackID = 0, 
skillid = {201018, 201019, 201020}
, bodytype = 1, behaviacAI = "newbattleaif102", defaultBuff = "", MonsterType = 2001, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62002] = {id = 62002, name = "巫毒娃娃", nameTextID = 1400054, shapeID = 50002, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "4485", attackConstant = "214", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201082}
, bodytype = 1, behaviacAI = "newbattleaif301", defaultBuff = "", MonsterType = 2002, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62003] = {id = 62003, name = "幼鼠", nameTextID = 1400075, shapeID = 50003, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "4485", attackConstant = "214", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201069}
, bodytype = 1, behaviacAI = "newbattleaif304", defaultBuff = "", MonsterType = 2003, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62004] = {id = 62004, name = "幽灵水母", nameTextID = 1400078, shapeID = 50004, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "4485", attackConstant = "214", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201083}
, bodytype = 1, behaviacAI = "newbattleaif302", defaultBuff = "", MonsterType = 2004, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62005] = {id = 62005, name = "魅魔", nameTextID = 1400051, shapeID = 50005, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "16020", attackConstant = "214", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201018, 201019}
, bodytype = 1, behaviacAI = "newbattleaif105", defaultBuff = "", MonsterType = 2005, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62006] = {id = 62006, name = "史莱姆", nameTextID = 1400058, shapeID = 50007, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "4485", attackConstant = "214", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201023}
, bodytype = 1, behaviacAI = "newbattleaif201", defaultBuff = "", MonsterType = 2006, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62007] = {id = 62007, name = "连射藤蔓", nameTextID = 1400040, shapeID = 50008, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "4485", attackConstant = "214", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201022, 201065}
, bodytype = 1, behaviacAI = "newbattleaif206", defaultBuff = "", MonsterType = 2007, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62008] = {id = 62008, name = "伞菇", nameTextID = 1400055, shapeID = 50009, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "4485", attackConstant = "214", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201024, 201158}
, bodytype = 1, behaviacAI = "newbattleaif210", defaultBuff = "", MonsterType = 2008, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62009] = {id = 62009, name = "树精", nameTextID = 1400102, shapeID = 50010, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "4485", attackConstant = "214", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201030, 201231}
, bodytype = 1, behaviacAI = "newbattleaif212", defaultBuff = "", MonsterType = 2009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62010] = {id = 62010, name = "石头人", nameTextID = 1400103, shapeID = 50011, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "16020", attackConstant = "214", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201027, 201028, 201029, 201037, 201059}
, bodytype = 1, behaviacAI = "newbattleaif220", defaultBuff = "", MonsterType = 2010, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62011] = {id = 62011, name = "幽灵螳螂", nameTextID = 1400013, shapeID = 50012, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "16020", attackConstant = "214", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201053, 201054, 201055}
, bodytype = 1, behaviacAI = "newbattleaif222", defaultBuff = "", MonsterType = 2011, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62012] = {id = 62012, name = "雪球", nameTextID = 1400062, shapeID = 50014, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "4485", attackConstant = "214", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 2012, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62013] = {id = 62013, name = "冰树精", nameTextID = 1400043, shapeID = 50015, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "4485", attackConstant = "214", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 2013, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62014] = {id = 62014, name = "白狼", nameTextID = 1400068, shapeID = 50017, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "4485", attackConstant = "214", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 201088, 
skillid = {201088, 201089, 201090, 201091}
, bodytype = 1, behaviacAI = "newbattleaif402", defaultBuff = "", MonsterType = 2014, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62015] = {id = 62015, name = "白熊", nameTextID = 1400070, shapeID = 50018, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "4485", attackConstant = "214", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201125, 201126, 201127}
, bodytype = 1, behaviacAI = "newbattleaif403", defaultBuff = "", MonsterType = 2015, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62016] = {id = 62016, name = "雪女", nameTextID = 1400067, shapeID = 50021, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "16020", attackConstant = "214", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 2016, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62017] = {id = 62017, name = "冰雪巨人", nameTextID = 1400104, shapeID = 50019, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "16020", attackConstant = "214", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 2017, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62018] = {id = 62018, name = "怨念聚合体", nameTextID = 1400011, shapeID = 50006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "30000;30000;30000", attackConstant = "214", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "20", damagereduce = "0", attackID = 201303, 
skillid = {201301, 201040, 201303, 201300, 201264, 201265}
, bodytype = 1, behaviacAI = "newbattleai20057s", defaultBuff = "20116", MonsterType = 2018, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62019] = {id = 62019, name = "蝴蝶妖精", nameTextID = 1400007, shapeID = 50013, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "25000;25000;25000;25000;25000", attackConstant = "214", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201295, 201296, 201297, 201298, 201266}
, bodytype = 1, behaviacAI = "newbattleai20014s", defaultBuff = "", MonsterType = 2019, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62020] = {id = 62020, name = "白熊 赫沃奥塔", nameTextID = 1400130, shapeID = 50020, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "25000;25000;25000;25000;25000", attackConstant = "214", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201290, 201291, 201292, 201293, 201294, 201267, 201268, 201269, 201270, 201271, 201305, 201320}
, bodytype = 1, behaviacAI = "newbattleai59s", defaultBuff = "20116", MonsterType = 2020, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62021] = {id = 62021, name = "古塔蝙蝠", nameTextID = 1400052, shapeID = 50001, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 25, hpConstant = "5841", attackConstant = "262", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "40", damagereduce = "0", attackID = 0, 
skillid = {201018, 201019, 201020}
, bodytype = 1, behaviacAI = "newbattleaif102", defaultBuff = "", MonsterType = 2001, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62022] = {id = 62022, name = "巫毒娃娃", nameTextID = 1400054, shapeID = 50002, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 25, hpConstant = "5841", attackConstant = "262", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201082}
, bodytype = 1, behaviacAI = "newbattleaif301", defaultBuff = "", MonsterType = 2002, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62023] = {id = 62023, name = "幼鼠", nameTextID = 1400075, shapeID = 50003, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 25, hpConstant = "5841", attackConstant = "262", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201069}
, bodytype = 1, behaviacAI = "newbattleaif304", defaultBuff = "", MonsterType = 2003, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62024] = {id = 62024, name = "幽灵水母", nameTextID = 1400078, shapeID = 50004, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 25, hpConstant = "5841", attackConstant = "262", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201083}
, bodytype = 1, behaviacAI = "newbattleaif302", defaultBuff = "", MonsterType = 2004, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62025] = {id = 62025, name = "魅魔", nameTextID = 1400051, shapeID = 50005, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 25, hpConstant = "20861", attackConstant = "262", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201018, 201019}
, bodytype = 1, behaviacAI = "newbattleaif105", defaultBuff = "", MonsterType = 2005, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62026] = {id = 62026, name = "史莱姆", nameTextID = 1400058, shapeID = 50007, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 25, hpConstant = "5841", attackConstant = "262", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201023}
, bodytype = 1, behaviacAI = "newbattleaif201", defaultBuff = "", MonsterType = 2006, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62027] = {id = 62027, name = "连射藤蔓", nameTextID = 1400040, shapeID = 50008, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 25, hpConstant = "5841", attackConstant = "262", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201022, 201065}
, bodytype = 1, behaviacAI = "newbattleaif206", defaultBuff = "", MonsterType = 2007, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62028] = {id = 62028, name = "伞菇", nameTextID = 1400055, shapeID = 50009, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 25, hpConstant = "5841", attackConstant = "262", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201024, 201158}
, bodytype = 1, behaviacAI = "newbattleaif210", defaultBuff = "", MonsterType = 2008, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62029] = {id = 62029, name = "树精", nameTextID = 1400102, shapeID = 50010, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 25, hpConstant = "5841", attackConstant = "262", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201030, 201231}
, bodytype = 1, behaviacAI = "newbattleaif212", defaultBuff = "", MonsterType = 2009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62030] = {id = 62030, name = "石头人", nameTextID = 1400103, shapeID = 50011, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 25, hpConstant = "20861", attackConstant = "262", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201027, 201028, 201029, 201037, 201059}
, bodytype = 1, behaviacAI = "newbattleaif220", defaultBuff = "", MonsterType = 2010, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62031] = {id = 62031, name = "幽灵螳螂", nameTextID = 1400013, shapeID = 50012, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 25, hpConstant = "20861", attackConstant = "262", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201053, 201054, 201055}
, bodytype = 1, behaviacAI = "newbattleaif222", defaultBuff = "", MonsterType = 2011, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62032] = {id = 62032, name = "雪球", nameTextID = 1400062, shapeID = 50014, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 25, hpConstant = "5841", attackConstant = "262", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 2012, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62033] = {id = 62033, name = "冰树精", nameTextID = 1400043, shapeID = 50015, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 25, hpConstant = "5841", attackConstant = "262", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 2013, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62034] = {id = 62034, name = "白狼", nameTextID = 1400068, shapeID = 50017, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 25, hpConstant = "5841", attackConstant = "262", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 201088, 
skillid = {201088, 201089, 201090, 201091}
, bodytype = 1, behaviacAI = "newbattleaif402", defaultBuff = "", MonsterType = 2014, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62035] = {id = 62035, name = "白熊", nameTextID = 1400070, shapeID = 50018, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 25, hpConstant = "5841", attackConstant = "262", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201125, 201126, 201127}
, bodytype = 1, behaviacAI = "newbattleaif403", defaultBuff = "", MonsterType = 2015, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62036] = {id = 62036, name = "雪女", nameTextID = 1400067, shapeID = 50021, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 25, hpConstant = "20861", attackConstant = "262", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 2016, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62037] = {id = 62037, name = "冰雪巨人", nameTextID = 1400104, shapeID = 50019, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 25, hpConstant = "20861", attackConstant = "262", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 2017, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62038] = {id = 62038, name = "怨念聚合体", nameTextID = 1400011, shapeID = 50006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 25, hpConstant = "35000;35000;35000", attackConstant = "262", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "20", damagereduce = "0", attackID = 201303, 
skillid = {201301, 201040, 201303, 201300, 201264, 201265}
, bodytype = 1, behaviacAI = "newbattleai20057s", defaultBuff = "20116", MonsterType = 2018, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62039] = {id = 62039, name = "蝴蝶妖精", nameTextID = 1400007, shapeID = 50013, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 25, hpConstant = "30000;30000;30000;30000;30000", attackConstant = "262", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201295, 201296, 201297, 201298, 201266}
, bodytype = 1, behaviacAI = "newbattleai20014s", defaultBuff = "", MonsterType = 2019, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62040] = {id = 62040, name = "白熊 赫沃奥塔", nameTextID = 1400130, shapeID = 50020, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 25, hpConstant = "30000;30000;30000;30000;30000", attackConstant = "262", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201290, 201291, 201292, 201293, 201294, 201267, 201268, 201269, 201270, 201271, 201305, 201320}
, bodytype = 1, behaviacAI = "newbattleai59s", defaultBuff = "20116", MonsterType = 2020, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62041] = {id = 62041, name = "古塔蝙蝠", nameTextID = 1400052, shapeID = 50001, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "141296", attackConstant = "3292", defConstant = "2000", magicattConstant = "0", magicDefConstant = "2000", speedConstant = "40", damagereduce = "0", attackID = 0, 
skillid = {201018, 201019, 201020}
, bodytype = 1, behaviacAI = "newbattleaif102", defaultBuff = "", MonsterType = 2001, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62042] = {id = 62042, name = "巫毒娃娃", nameTextID = 1400054, shapeID = 50002, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "141296", attackConstant = "3292", defConstant = "2000", magicattConstant = "0", magicDefConstant = "2000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201082}
, bodytype = 1, behaviacAI = "newbattleaif301", defaultBuff = "", MonsterType = 2002, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62043] = {id = 62043, name = "幼鼠", nameTextID = 1400075, shapeID = 50003, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "141296", attackConstant = "3292", defConstant = "2000", magicattConstant = "0", magicDefConstant = "2000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201069}
, bodytype = 1, behaviacAI = "newbattleaif304", defaultBuff = "", MonsterType = 2003, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62044] = {id = 62044, name = "幽灵水母", nameTextID = 1400078, shapeID = 50004, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "141296", attackConstant = "3292", defConstant = "2000", magicattConstant = "0", magicDefConstant = "2000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201083}
, bodytype = 1, behaviacAI = "newbattleaif302", defaultBuff = "", MonsterType = 2004, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62045] = {id = 62045, name = "魅魔", nameTextID = 1400051, shapeID = 50005, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "627984", attackConstant = "7075", defConstant = "2000", magicattConstant = "0", magicDefConstant = "2000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201018, 201019}
, bodytype = 1, behaviacAI = "newbattleaif105", defaultBuff = "", MonsterType = 2005, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62046] = {id = 62046, name = "史莱姆", nameTextID = 1400058, shapeID = 50007, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "337554", attackConstant = "7099", defConstant = "4000", magicattConstant = "0", magicDefConstant = "4000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201023}
, bodytype = 1, behaviacAI = "newbattleaif201", defaultBuff = "", MonsterType = 2006, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62047] = {id = 62047, name = "连射藤蔓", nameTextID = 1400040, shapeID = 50008, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "337554", attackConstant = "7099", defConstant = "4000", magicattConstant = "0", magicDefConstant = "4000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201022, 201065}
, bodytype = 1, behaviacAI = "newbattleaif206", defaultBuff = "", MonsterType = 2007, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62048] = {id = 62048, name = "伞菇", nameTextID = 1400055, shapeID = 50009, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "337554", attackConstant = "7099", defConstant = "4000", magicattConstant = "0", magicDefConstant = "4000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201024, 201158}
, bodytype = 1, behaviacAI = "newbattleaif210", defaultBuff = "", MonsterType = 2008, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62049] = {id = 62049, name = "树精", nameTextID = 1400102, shapeID = 50010, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "337554", attackConstant = "7099", defConstant = "4000", magicattConstant = "0", magicDefConstant = "4000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201030, 201231}
, bodytype = 1, behaviacAI = "newbattleaif212", defaultBuff = "", MonsterType = 2009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62050] = {id = 62050, name = "石头人", nameTextID = 1400103, shapeID = 50011, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "1477440", attackConstant = "15660", defConstant = "4000", magicattConstant = "0", magicDefConstant = "4000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201027, 201028, 201029, 201037, 201059}
, bodytype = 1, behaviacAI = "newbattleaif220", defaultBuff = "", MonsterType = 2010, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62051] = {id = 62051, name = "幽灵螳螂", nameTextID = 1400013, shapeID = 50012, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "1477440", attackConstant = "15660", defConstant = "4000", magicattConstant = "0", magicDefConstant = "4000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201053, 201054, 201055}
, bodytype = 1, behaviacAI = "newbattleaif222", defaultBuff = "", MonsterType = 2011, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62052] = {id = 62052, name = "雪球", nameTextID = 1400062, shapeID = 50014, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 280, hpConstant = "412366", attackConstant = "9035", defConstant = "5000", magicattConstant = "0", magicDefConstant = "5000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 2012, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62053] = {id = 62053, name = "冰树精", nameTextID = 1400043, shapeID = 50015, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 330, hpConstant = "485982", attackConstant = "11004", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 2013, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62054] = {id = 62054, name = "白狼", nameTextID = 1400068, shapeID = 50017, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 330, hpConstant = "485982", attackConstant = "11004", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 201088, 
skillid = {201088, 201089, 201090, 201091}
, bodytype = 1, behaviacAI = "newbattleaif402", defaultBuff = "", MonsterType = 2014, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62055] = {id = 62055, name = "白熊", nameTextID = 1400070, shapeID = 50018, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 330, hpConstant = "485982", attackConstant = "11004", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201125, 201126, 201127}
, bodytype = 1, behaviacAI = "newbattleaif403", defaultBuff = "", MonsterType = 2015, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62056] = {id = 62056, name = "雪女", nameTextID = 1400067, shapeID = 50021, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 340, hpConstant = "2118690", attackConstant = "24451", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 2016, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62057] = {id = 62057, name = "冰雪巨人", nameTextID = 1400104, shapeID = 50019, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 340, hpConstant = "2118690", attackConstant = "24451", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 2017, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62058] = {id = 62058, name = "怨念聚合体", nameTextID = 1400011, shapeID = 50006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "852264;852264;852264;852264;852264", attackConstant = "5946", defConstant = "2000", magicattConstant = "0", magicDefConstant = "2000", speedConstant = "20", damagereduce = "0", attackID = 201303, 
skillid = {201301, 201040, 201303, 201300, 201264, 201265}
, bodytype = 1, behaviacAI = "newbattleai20057s", defaultBuff = "20116", MonsterType = 2018, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62059] = {id = 62059, name = "蝴蝶妖精", nameTextID = 1400007, shapeID = 50013, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1949400;1949400;1949400;1949400;1949400", attackConstant = "16575", defConstant = "4000", magicattConstant = "0", magicDefConstant = "4000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201295, 201296, 201297, 201298, 201266}
, bodytype = 1, behaviacAI = "newbattleai20014s", defaultBuff = "", MonsterType = 2019, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62060] = {id = 62060, name = "白熊 赫沃奥塔", nameTextID = 1400130, shapeID = 50020, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "1083456;1083456;1083456;1083456;1083456", attackConstant = "15613", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201290, 201291, 201292, 201293, 201294, 201267, 201268, 201269, 201270, 201271, 201305, 201320}
, bodytype = 1, behaviacAI = "newbattleai59s", defaultBuff = "20116", MonsterType = 2020, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62061] = {id = 62061, name = "古塔蝙蝠", nameTextID = 1400052, shapeID = 50001, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "153856", attackConstant = "3613", defConstant = "2500", magicattConstant = "0", magicDefConstant = "2500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201018, 201019, 201020}
, bodytype = 1, behaviacAI = "newbattleaif102", defaultBuff = "", MonsterType = 2001, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62062] = {id = 62062, name = "巫毒娃娃", nameTextID = 1400054, shapeID = 50002, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "153856", attackConstant = "3613", defConstant = "2500", magicattConstant = "0", magicDefConstant = "2500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201082}
, bodytype = 1, behaviacAI = "newbattleaif301", defaultBuff = "", MonsterType = 2002, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62063] = {id = 62063, name = "幼鼠", nameTextID = 1400075, shapeID = 50003, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "153856", attackConstant = "3613", defConstant = "2500", magicattConstant = "0", magicDefConstant = "2500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201069}
, bodytype = 1, behaviacAI = "newbattleaif304", defaultBuff = "", MonsterType = 2003, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62064] = {id = 62064, name = "幽灵水母", nameTextID = 1400078, shapeID = 50004, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "153856", attackConstant = "3613", defConstant = "2500", magicattConstant = "0", magicDefConstant = "2500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201083}
, bodytype = 1, behaviacAI = "newbattleaif302", defaultBuff = "", MonsterType = 2004, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62065] = {id = 62065, name = "魅魔", nameTextID = 1400051, shapeID = 50005, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "682932", attackConstant = "7770", defConstant = "2500", magicattConstant = "0", magicDefConstant = "2500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201018, 201019}
, bodytype = 1, behaviacAI = "newbattleaif105", defaultBuff = "", MonsterType = 2005, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62066] = {id = 62066, name = "史莱姆", nameTextID = 1400058, shapeID = 50007, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 260, hpConstant = "381543", attackConstant = "8247", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201023}
, bodytype = 1, behaviacAI = "newbattleaif201", defaultBuff = "", MonsterType = 2006, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62067] = {id = 62067, name = "连射藤蔓", nameTextID = 1400040, shapeID = 50008, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 260, hpConstant = "381543", attackConstant = "8247", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201022, 201065}
, bodytype = 1, behaviacAI = "newbattleaif206", defaultBuff = "", MonsterType = 2007, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62068] = {id = 62068, name = "伞菇", nameTextID = 1400055, shapeID = 50009, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 260, hpConstant = "381543", attackConstant = "8247", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201024, 201158}
, bodytype = 1, behaviacAI = "newbattleaif210", defaultBuff = "", MonsterType = 2008, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62069] = {id = 62069, name = "树精", nameTextID = 1400102, shapeID = 50010, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 260, hpConstant = "381543", attackConstant = "8247", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201030, 201231}
, bodytype = 1, behaviacAI = "newbattleaif212", defaultBuff = "", MonsterType = 2009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62070] = {id = 62070, name = "石头人", nameTextID = 1400103, shapeID = 50011, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 270, hpConstant = "1667250", attackConstant = "18242", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201027, 201028, 201029, 201037, 201059}
, bodytype = 1, behaviacAI = "newbattleaif220", defaultBuff = "", MonsterType = 2010, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62071] = {id = 62071, name = "幽灵螳螂", nameTextID = 1400013, shapeID = 50012, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 270, hpConstant = "1667250", attackConstant = "18242", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201053, 201054, 201055}
, bodytype = 1, behaviacAI = "newbattleaif222", defaultBuff = "", MonsterType = 2011, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62072] = {id = 62072, name = "雪球", nameTextID = 1400062, shapeID = 50014, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 360, hpConstant = "529373", attackConstant = "12220", defConstant = "6500", magicattConstant = "0", magicDefConstant = "6500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 2012, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62073] = {id = 62073, name = "冰树精", nameTextID = 1400043, shapeID = 50015, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 360, hpConstant = "529373", attackConstant = "12220", defConstant = "6500", magicattConstant = "0", magicDefConstant = "6500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 2013, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62074] = {id = 62074, name = "白狼", nameTextID = 1400068, shapeID = 50017, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 360, hpConstant = "529373", attackConstant = "12220", defConstant = "6500", magicattConstant = "0", magicDefConstant = "6500", speedConstant = "30", damagereduce = "0", attackID = 201088, 
skillid = {201088, 201089, 201090, 201091}
, bodytype = 1, behaviacAI = "newbattleaif402", defaultBuff = "", MonsterType = 2014, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62075] = {id = 62075, name = "白熊", nameTextID = 1400070, shapeID = 50018, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 360, hpConstant = "529373", attackConstant = "12220", defConstant = "6500", magicattConstant = "0", magicDefConstant = "6500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201125, 201126, 201127}
, bodytype = 1, behaviacAI = "newbattleaif403", defaultBuff = "", MonsterType = 2015, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62076] = {id = 62076, name = "雪女", nameTextID = 1400067, shapeID = 50021, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 370, hpConstant = "2305935", attackConstant = "27203", defConstant = "6500", magicattConstant = "0", magicDefConstant = "6500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 2016, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62077] = {id = 62077, name = "冰雪巨人", nameTextID = 1400104, shapeID = 50019, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 370, hpConstant = "2305935", attackConstant = "27203", defConstant = "6500", magicattConstant = "0", magicDefConstant = "6500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 2017, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62078] = {id = 62078, name = "怨念聚合体", nameTextID = 1400011, shapeID = 50006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 40, hpConstant = "61261;61261;61261;61261;61261", attackConstant = "766", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 201303, 
skillid = {201301, 201040, 201303, 201300, 201264, 201265}
, bodytype = 1, behaviacAI = "newbattleai20057s", defaultBuff = "20116", MonsterType = 2018, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62079] = {id = 62079, name = "蝴蝶妖精", nameTextID = 1400007, shapeID = 50013, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "2365272;2365272;2365272;2365272;2365272", attackConstant = "21070", defConstant = "5000", magicattConstant = "0", magicDefConstant = "5000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201295, 201296, 201297, 201298, 201266}
, bodytype = 1, behaviacAI = "newbattleai20014s", defaultBuff = "", MonsterType = 2019, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62080] = {id = 62080, name = "白熊 赫沃奥塔", nameTextID = 1400130, shapeID = 50020, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 420, hpConstant = "3265245;3265245;3265245;3265245;3265245", attackConstant = "31515", defConstant = "7000", magicattConstant = "0", magicDefConstant = "7000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201290, 201291, 201292, 201293, 201294, 201267, 201268, 201269, 201270, 201271, 201305, 201320}
, bodytype = 1, behaviacAI = "newbattleai59s", defaultBuff = "20116", MonsterType = 2020, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62081] = {id = 62081, name = "古塔蝙蝠", nameTextID = 1400052, shapeID = 50001, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "166939", attackConstant = "3952", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201018, 201019, 201020}
, bodytype = 1, behaviacAI = "newbattleaif102", defaultBuff = "", MonsterType = 2001, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62082] = {id = 62082, name = "巫毒娃娃", nameTextID = 1400054, shapeID = 50002, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "166939", attackConstant = "3952", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201082}
, bodytype = 1, behaviacAI = "newbattleaif301", defaultBuff = "", MonsterType = 2002, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62083] = {id = 62083, name = "幼鼠", nameTextID = 1400075, shapeID = 50003, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "166939", attackConstant = "3952", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201069}
, bodytype = 1, behaviacAI = "newbattleaif304", defaultBuff = "", MonsterType = 2003, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62084] = {id = 62084, name = "幽灵水母", nameTextID = 1400078, shapeID = 50004, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "166939", attackConstant = "3952", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201083}
, bodytype = 1, behaviacAI = "newbattleaif302", defaultBuff = "", MonsterType = 2004, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62085] = {id = 62085, name = "魅魔", nameTextID = 1400051, shapeID = 50005, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 32, hpConstant = "30412", attackConstant = "360", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201018, 201019}
, bodytype = 1, behaviacAI = "newbattleaif105", defaultBuff = "", MonsterType = 2005, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62086] = {id = 62086, name = "史莱姆", nameTextID = 1400058, shapeID = 50007, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 260, hpConstant = "381543", attackConstant = "8247", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201023}
, bodytype = 1, behaviacAI = "newbattleaif201", defaultBuff = "", MonsterType = 2006, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62087] = {id = 62087, name = "连射藤蔓", nameTextID = 1400040, shapeID = 50008, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 280, hpConstant = "412366", attackConstant = "9035", defConstant = "5000", magicattConstant = "0", magicDefConstant = "5000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201022, 201065}
, bodytype = 1, behaviacAI = "newbattleaif206", defaultBuff = "", MonsterType = 2007, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62088] = {id = 62088, name = "伞菇", nameTextID = 1400055, shapeID = 50009, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 280, hpConstant = "412366", attackConstant = "9035", defConstant = "5000", magicattConstant = "0", magicDefConstant = "5000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201024, 201158}
, bodytype = 1, behaviacAI = "newbattleaif210", defaultBuff = "", MonsterType = 2008, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62089] = {id = 62089, name = "树精", nameTextID = 1400102, shapeID = 50010, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 280, hpConstant = "412366", attackConstant = "9035", defConstant = "5000", magicattConstant = "0", magicDefConstant = "5000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201030, 201231}
, bodytype = 1, behaviacAI = "newbattleaif212", defaultBuff = "", MonsterType = 2009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62090] = {id = 62090, name = "石头人", nameTextID = 1400103, shapeID = 50011, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1800630", attackConstant = "20009", defConstant = "5000", magicattConstant = "0", magicDefConstant = "5000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201027, 201028, 201029, 201037, 201059}
, bodytype = 1, behaviacAI = "newbattleaif220", defaultBuff = "", MonsterType = 2010, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62091] = {id = 62091, name = "幽灵螳螂", nameTextID = 1400013, shapeID = 50012, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1800630", attackConstant = "20009", defConstant = "5000", magicattConstant = "0", magicDefConstant = "5000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201053, 201054, 201055}
, bodytype = 1, behaviacAI = "newbattleaif222", defaultBuff = "", MonsterType = 2011, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62092] = {id = 62092, name = "雪球", nameTextID = 1400062, shapeID = 50014, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 390, hpConstant = "574560", attackConstant = "13516", defConstant = "7000", magicattConstant = "0", magicDefConstant = "7000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 2012, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62093] = {id = 62093, name = "冰树精", nameTextID = 1400043, shapeID = 50015, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 390, hpConstant = "574560", attackConstant = "13516", defConstant = "7000", magicattConstant = "0", magicDefConstant = "7000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 2013, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62094] = {id = 62094, name = "白狼", nameTextID = 1400068, shapeID = 50017, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 390, hpConstant = "574560", attackConstant = "13516", defConstant = "7000", magicattConstant = "0", magicDefConstant = "7000", speedConstant = "30", damagereduce = "0", attackID = 201088, 
skillid = {201088, 201089, 201090, 201091}
, bodytype = 1, behaviacAI = "newbattleaif402", defaultBuff = "", MonsterType = 2014, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62095] = {id = 62095, name = "白熊", nameTextID = 1400070, shapeID = 50018, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 390, hpConstant = "574560", attackConstant = "13516", defConstant = "7000", magicattConstant = "0", magicDefConstant = "7000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201125, 201126, 201127}
, bodytype = 1, behaviacAI = "newbattleaif403", defaultBuff = "", MonsterType = 2015, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62096] = {id = 62096, name = "雪女", nameTextID = 1400067, shapeID = 50021, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 400, hpConstant = "2500875", attackConstant = "30145", defConstant = "7000", magicattConstant = "0", magicDefConstant = "7000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 2016, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62097] = {id = 62097, name = "冰雪巨人", nameTextID = 1400104, shapeID = 50019, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 400, hpConstant = "2500875", attackConstant = "30145", defConstant = "7000", magicattConstant = "0", magicDefConstant = "7000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 2017, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62098] = {id = 62098, name = "怨念聚合体", nameTextID = 1400011, shapeID = 50006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 50, hpConstant = "74220.3;74220.3;74220.3;74220.3;74220.3", attackConstant = "938", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 201303, 
skillid = {201301, 201040, 201303, 201300, 201264, 201265}
, bodytype = 1, behaviacAI = "newbattleai20057s", defaultBuff = "20116", MonsterType = 2018, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62099] = {id = 62099, name = "蝴蝶妖精", nameTextID = 1400007, shapeID = 50013, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "510685.1;510685.1;510685.1;510685.1;510685.1", attackConstant = "5962", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201295, 201296, 201297, 201298, 201266}
, bodytype = 1, behaviacAI = "newbattleai20014s", defaultBuff = "", MonsterType = 2019, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62100] = {id = 62100, name = "白熊 赫沃奥塔", nameTextID = 1400130, shapeID = 50020, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "1152112.5;1152112.5;1152112.5;1152112.5", attackConstant = "16735", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201290, 201291, 201292, 201293, 201294, 201267, 201268, 201269, 201270, 201271, 201305, 201320}
, bodytype = 1, behaviacAI = "newbattleai59s", defaultBuff = "20116", MonsterType = 2020, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62101] = {id = 62101, name = "古塔蝙蝠", nameTextID = 1400052, shapeID = 50001, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 36, hpConstant = "9114", attackConstant = "325", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201018, 201019, 201020}
, bodytype = 1, behaviacAI = "newbattleaif102", defaultBuff = "", MonsterType = 2001, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62102] = {id = 62102, name = "巫毒娃娃", nameTextID = 1400054, shapeID = 50002, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 36, hpConstant = "9114", attackConstant = "325", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201082}
, bodytype = 1, behaviacAI = "newbattleaif301", defaultBuff = "", MonsterType = 2002, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62103] = {id = 62103, name = "幼鼠", nameTextID = 1400075, shapeID = 50003, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 36, hpConstant = "9114", attackConstant = "325", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201069}
, bodytype = 1, behaviacAI = "newbattleaif304", defaultBuff = "", MonsterType = 2003, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62104] = {id = 62104, name = "幽灵水母", nameTextID = 1400078, shapeID = 50004, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 36, hpConstant = "9114", attackConstant = "325", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201083}
, bodytype = 1, behaviacAI = "newbattleaif302", defaultBuff = "", MonsterType = 2004, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62105] = {id = 62105, name = "魅魔", nameTextID = 1400051, shapeID = 50005, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "740124", attackConstant = "8503", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201018, 201019}
, bodytype = 1, behaviacAI = "newbattleaif105", defaultBuff = "", MonsterType = 2005, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62106] = {id = 62106, name = "史莱姆", nameTextID = 1400058, shapeID = 50007, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "9114", attackConstant = "325", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201023}
, bodytype = 1, behaviacAI = "newbattleaif201", defaultBuff = "", MonsterType = 2006, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62107] = {id = 62107, name = "连射藤蔓", nameTextID = 1400040, shapeID = 50008, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "9114", attackConstant = "325", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201022, 201065}
, bodytype = 1, behaviacAI = "newbattleaif206", defaultBuff = "", MonsterType = 2007, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62108] = {id = 62108, name = "伞菇", nameTextID = 1400055, shapeID = 50009, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "9114", attackConstant = "325", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201024, 201158}
, bodytype = 1, behaviacAI = "newbattleaif210", defaultBuff = "", MonsterType = 2008, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62109] = {id = 62109, name = "树精", nameTextID = 1400102, shapeID = 50010, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "9114", attackConstant = "325", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201030, 201231}
, bodytype = 1, behaviacAI = "newbattleaif212", defaultBuff = "", MonsterType = 2009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62110] = {id = 62110, name = "石头人", nameTextID = 1400103, shapeID = 50011, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1939140", attackConstant = "21880", defConstant = "5500", magicattConstant = "0", magicDefConstant = "5500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201027, 201028, 201029, 201037, 201059}
, bodytype = 1, behaviacAI = "newbattleaif220", defaultBuff = "", MonsterType = 2010, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62111] = {id = 62111, name = "幽灵螳螂", nameTextID = 1400013, shapeID = 50012, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1939140", attackConstant = "21880", defConstant = "5500", magicattConstant = "0", magicDefConstant = "5500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201053, 201054, 201055}
, bodytype = 1, behaviacAI = "newbattleaif222", defaultBuff = "", MonsterType = 2011, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62112] = {id = 62112, name = "雪球", nameTextID = 1400062, shapeID = 50014, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 80, hpConstant = "26308", attackConstant = "806", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 2012, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62113] = {id = 62113, name = "冰树精", nameTextID = 1400043, shapeID = 50015, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 80, hpConstant = "26308", attackConstant = "806", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 2013, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62114] = {id = 62114, name = "白狼", nameTextID = 1400068, shapeID = 50017, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 80, hpConstant = "26308", attackConstant = "806", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 201088, 
skillid = {201088, 201089, 201090, 201091}
, bodytype = 1, behaviacAI = "newbattleaif402", defaultBuff = "", MonsterType = 2014, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62115] = {id = 62115, name = "白熊", nameTextID = 1400070, shapeID = 50018, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 80, hpConstant = "26308", attackConstant = "806", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201125, 201126, 201127}
, bodytype = 1, behaviacAI = "newbattleaif403", defaultBuff = "", MonsterType = 2015, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62116] = {id = 62116, name = "雪女", nameTextID = 1400067, shapeID = 50021, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 430, hpConstant = "2790720", attackConstant = "34355", defConstant = "8000", magicattConstant = "0", magicDefConstant = "8000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 2016, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62117] = {id = 62117, name = "冰雪巨人", nameTextID = 1400104, shapeID = 50019, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 430, hpConstant = "2790720", attackConstant = "34355", defConstant = "8000", magicattConstant = "0", magicDefConstant = "8000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 2017, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62118] = {id = 62118, name = "怨念聚合体", nameTextID = 1400011, shapeID = 50006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "84115.5;84115.5;84115.5;84115.5;84115.5", attackConstant = "1076", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 201303, 
skillid = {201301, 201040, 201303, 201300, 201264, 201265}
, bodytype = 1, behaviacAI = "newbattleai20057s", defaultBuff = "20116", MonsterType = 2018, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62119] = {id = 62119, name = "蝴蝶妖精", nameTextID = 1400007, shapeID = 50013, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "548513.2;548513.2;548513.2;548513.2;548513.2", attackConstant = "6529", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201295, 201296, 201297, 201298, 201266}
, bodytype = 1, behaviacAI = "newbattleai20014s", defaultBuff = "", MonsterType = 2019, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62120] = {id = 62120, name = "白熊 赫沃奥塔", nameTextID = 1400130, shapeID = 50020, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 450, hpConstant = "3638880;3638880;3638880;3638880;3638880", attackConstant = "35857", defConstant = "8000", magicattConstant = "0", magicDefConstant = "8000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201290, 201291, 201292, 201293, 201294, 201267, 201268, 201269, 201270, 201271, 201305, 201320}
, bodytype = 1, behaviacAI = "newbattleai59s", defaultBuff = "20116", MonsterType = 2020, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62121] = {id = 62121, name = "古塔蝙蝠", nameTextID = 1400052, shapeID = 50001, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "186563", attackConstant = "4488", defConstant = "3500", magicattConstant = "0", magicDefConstant = "3500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201018, 201019, 201020}
, bodytype = 1, behaviacAI = "newbattleaif102", defaultBuff = "", MonsterType = 2001, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62122] = {id = 62122, name = "巫毒娃娃", nameTextID = 1400054, shapeID = 50002, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "186563", attackConstant = "4488", defConstant = "3500", magicattConstant = "0", magicDefConstant = "3500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201082}
, bodytype = 1, behaviacAI = "newbattleaif301", defaultBuff = "", MonsterType = 2002, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62123] = {id = 62123, name = "幼鼠", nameTextID = 1400075, shapeID = 50003, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "186563", attackConstant = "4488", defConstant = "3500", magicattConstant = "0", magicDefConstant = "3500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201069}
, bodytype = 1, behaviacAI = "newbattleaif304", defaultBuff = "", MonsterType = 2003, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62124] = {id = 62124, name = "幽灵水母", nameTextID = 1400078, shapeID = 50004, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "186563", attackConstant = "4488", defConstant = "3500", magicattConstant = "0", magicDefConstant = "3500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201083}
, bodytype = 1, behaviacAI = "newbattleaif302", defaultBuff = "", MonsterType = 2004, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62125] = {id = 62125, name = "魅魔", nameTextID = 1400051, shapeID = 50005, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 34, hpConstant = "31482", attackConstant = "375", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201018, 201019}
, bodytype = 1, behaviacAI = "newbattleaif105", defaultBuff = "", MonsterType = 2005, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62126] = {id = 62126, name = "史莱姆", nameTextID = 1400058, shapeID = 50007, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "444386", attackConstant = "9867", defConstant = "5500", magicattConstant = "0", magicDefConstant = "5500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201023}
, bodytype = 1, behaviacAI = "newbattleaif201", defaultBuff = "", MonsterType = 2006, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62127] = {id = 62127, name = "连射藤蔓", nameTextID = 1400040, shapeID = 50008, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "444386", attackConstant = "9867", defConstant = "5500", magicattConstant = "0", magicDefConstant = "5500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201022, 201065}
, bodytype = 1, behaviacAI = "newbattleaif206", defaultBuff = "", MonsterType = 2007, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62128] = {id = 62128, name = "伞菇", nameTextID = 1400055, shapeID = 50009, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "444386", attackConstant = "9867", defConstant = "5500", magicattConstant = "0", magicDefConstant = "5500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201024, 201158}
, bodytype = 1, behaviacAI = "newbattleaif210", defaultBuff = "", MonsterType = 2008, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62129] = {id = 62129, name = "树精", nameTextID = 1400102, shapeID = 50010, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "444386", attackConstant = "9867", defConstant = "5500", magicattConstant = "0", magicDefConstant = "5500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201030, 201231}
, bodytype = 1, behaviacAI = "newbattleaif212", defaultBuff = "", MonsterType = 2009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62130] = {id = 62130, name = "石头人", nameTextID = 1400103, shapeID = 50011, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "67964", attackConstant = "761", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201027, 201028, 201029, 201037, 201059}
, bodytype = 1, behaviacAI = "newbattleaif220", defaultBuff = "", MonsterType = 2010, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62131] = {id = 62131, name = "幽灵螳螂", nameTextID = 1400013, shapeID = 50012, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "67964", attackConstant = "761", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201053, 201054, 201055}
, bodytype = 1, behaviacAI = "newbattleaif222", defaultBuff = "", MonsterType = 2011, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62132] = {id = 62132, name = "雪球", nameTextID = 1400062, shapeID = 50014, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 420, hpConstant = "641592", attackConstant = "15376", defConstant = "8000", magicattConstant = "0", magicDefConstant = "8000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 2012, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62133] = {id = 62133, name = "冰树精", nameTextID = 1400043, shapeID = 50015, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 420, hpConstant = "641592", attackConstant = "15376", defConstant = "8000", magicattConstant = "0", magicDefConstant = "8000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 2013, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62134] = {id = 62134, name = "白狼", nameTextID = 1400068, shapeID = 50017, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 420, hpConstant = "641592", attackConstant = "15376", defConstant = "8000", magicattConstant = "0", magicDefConstant = "8000", speedConstant = "30", damagereduce = "0", attackID = 201088, 
skillid = {201088, 201089, 201090, 201091}
, bodytype = 1, behaviacAI = "newbattleaif402", defaultBuff = "", MonsterType = 2014, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62135] = {id = 62135, name = "白熊", nameTextID = 1400070, shapeID = 50018, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 420, hpConstant = "641592", attackConstant = "15376", defConstant = "8000", magicattConstant = "0", magicDefConstant = "8000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201125, 201126, 201127}
, bodytype = 1, behaviacAI = "newbattleaif403", defaultBuff = "", MonsterType = 2015, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62136] = {id = 62136, name = "雪女", nameTextID = 1400067, shapeID = 50021, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 80, hpConstant = "93960", attackConstant = "806", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 2016, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62137] = {id = 62137, name = "冰雪巨人", nameTextID = 1400104, shapeID = 50019, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 80, hpConstant = "93960", attackConstant = "806", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 2017, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62138] = {id = 62138, name = "怨念聚合体", nameTextID = 1400011, shapeID = 50006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 36, hpConstant = "116000;116000;116000;116000;116000", attackConstant = "574", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 201303, 
skillid = {201301, 201040, 201303, 201300, 201264, 201265}
, bodytype = 1, behaviacAI = "newbattleai20057s", defaultBuff = "20116", MonsterType = 2018, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62139] = {id = 62139, name = "蝴蝶妖精", nameTextID = 1400007, shapeID = 50013, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "244000;244000;244000;244000;244000", attackConstant = "574", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201295, 201296, 201297, 201298, 201266}
, bodytype = 1, behaviacAI = "newbattleai20014s", defaultBuff = "", MonsterType = 2019, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62140] = {id = 62140, name = "白熊 赫沃奥塔", nameTextID = 1400130, shapeID = 50020, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 80, hpConstant = "321000;321000;321000;321000;321000", attackConstant = "574", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201290, 201291, 201292, 201293, 201294, 201267, 201268, 201269, 201270, 201271, 201305, 201320}
, bodytype = 1, behaviacAI = "newbattleai59s", defaultBuff = "20116", MonsterType = 2020, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62141] = {id = 62141, name = "古塔蝙蝠", nameTextID = 1400052, shapeID = 50001, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "13333", attackConstant = "735", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201018, 201019, 201020}
, bodytype = 1, behaviacAI = "newbattleaif102", defaultBuff = "", MonsterType = 2001, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62142] = {id = 62142, name = "巫毒娃娃", nameTextID = 1400054, shapeID = 50002, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "13333", attackConstant = "735", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201082}
, bodytype = 1, behaviacAI = "newbattleaif301", defaultBuff = "", MonsterType = 2002, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62143] = {id = 62143, name = "幼鼠", nameTextID = 1400075, shapeID = 50003, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "13333", attackConstant = "735", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201069}
, bodytype = 1, behaviacAI = "newbattleaif304", defaultBuff = "", MonsterType = 2003, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62144] = {id = 62144, name = "幽灵水母", nameTextID = 1400078, shapeID = 50004, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "13333", attackConstant = "735", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201083}
, bodytype = 1, behaviacAI = "newbattleaif302", defaultBuff = "", MonsterType = 2004, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62145] = {id = 62145, name = "魅魔", nameTextID = 1400051, shapeID = 50005, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "47618", attackConstant = "735", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201018, 201019}
, bodytype = 1, behaviacAI = "newbattleaif105", defaultBuff = "", MonsterType = 2005, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62146] = {id = 62146, name = "史莱姆", nameTextID = 1400058, shapeID = 50007, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "13333", attackConstant = "735", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201023}
, bodytype = 1, behaviacAI = "newbattleaif201", defaultBuff = "", MonsterType = 2006, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62147] = {id = 62147, name = "连射藤蔓", nameTextID = 1400040, shapeID = 50008, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "13333", attackConstant = "735", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201022, 201065}
, bodytype = 1, behaviacAI = "newbattleaif206", defaultBuff = "", MonsterType = 2007, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62148] = {id = 62148, name = "伞菇", nameTextID = 1400055, shapeID = 50009, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "13333", attackConstant = "735", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201024, 201158}
, bodytype = 1, behaviacAI = "newbattleaif210", defaultBuff = "", MonsterType = 2008, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62149] = {id = 62149, name = "树精", nameTextID = 1400102, shapeID = 50010, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "13333", attackConstant = "735", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201030, 201231}
, bodytype = 1, behaviacAI = "newbattleaif212", defaultBuff = "", MonsterType = 2009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62150] = {id = 62150, name = "石头人", nameTextID = 1400103, shapeID = 50011, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "47618", attackConstant = "735", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201027, 201028, 201029, 201037, 201059}
, bodytype = 1, behaviacAI = "newbattleaif220", defaultBuff = "", MonsterType = 2010, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62151] = {id = 62151, name = "幽灵螳螂", nameTextID = 1400013, shapeID = 50012, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "47618", attackConstant = "735", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201053, 201054, 201055}
, bodytype = 1, behaviacAI = "newbattleaif222", defaultBuff = "", MonsterType = 2011, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62152] = {id = 62152, name = "雪球", nameTextID = 1400062, shapeID = 50014, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "13333", attackConstant = "735", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 2012, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62153] = {id = 62153, name = "冰树精", nameTextID = 1400043, shapeID = 50015, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "13333", attackConstant = "735", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 2013, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62154] = {id = 62154, name = "白狼", nameTextID = 1400068, shapeID = 50017, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "13333", attackConstant = "735", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 201088, 
skillid = {201088, 201089, 201090, 201091}
, bodytype = 1, behaviacAI = "newbattleaif402", defaultBuff = "", MonsterType = 2014, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62155] = {id = 62155, name = "白熊", nameTextID = 1400070, shapeID = 50018, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "13333", attackConstant = "735", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201125, 201126, 201127}
, bodytype = 1, behaviacAI = "newbattleaif403", defaultBuff = "", MonsterType = 2015, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62156] = {id = 62156, name = "雪女", nameTextID = 1400067, shapeID = 50021, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "47618", attackConstant = "735", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 2016, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62157] = {id = 62157, name = "冰雪巨人", nameTextID = 1400104, shapeID = 50019, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "47618", attackConstant = "735", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 2017, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62158] = {id = 62158, name = "怨念聚合体", nameTextID = 1400011, shapeID = 50006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "60000;60000;60000;60000;60000", attackConstant = "735", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 201303, 
skillid = {201301, 201040, 201303, 201300, 201264, 201265}
, bodytype = 1, behaviacAI = "newbattleai20057s", defaultBuff = "20116", MonsterType = 2018, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62159] = {id = 62159, name = "蝴蝶妖精", nameTextID = 1400007, shapeID = 50013, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "60000;60000;60000;60000;60000", attackConstant = "735", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201295, 201296, 201297, 201298, 201266}
, bodytype = 1, behaviacAI = "newbattleai20014s", defaultBuff = "", MonsterType = 2019, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62160] = {id = 62160, name = "白熊 赫沃奥塔", nameTextID = 1400130, shapeID = 50020, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 360, hpConstant = "2873740;2873740;2873740;2873740;2873740", attackConstant = "26571", defConstant = "6500", magicattConstant = "0", magicDefConstant = "6500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201290, 201291, 201292, 201293, 201294, 201267, 201268, 201269, 201270, 201271, 201305, 201320}
, bodytype = 1, behaviacAI = "newbattleai59s", defaultBuff = "20116", MonsterType = 2020, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62161] = {id = 62161, name = "古塔蝙蝠", nameTextID = 1400052, shapeID = 50001, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "15749", attackConstant = "918", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201018, 201019, 201020}
, bodytype = 1, behaviacAI = "newbattleaif102", defaultBuff = "", MonsterType = 2001, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62162] = {id = 62162, name = "巫毒娃娃", nameTextID = 1400054, shapeID = 50002, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "15749", attackConstant = "918", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201082}
, bodytype = 1, behaviacAI = "newbattleaif301", defaultBuff = "", MonsterType = 2002, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62163] = {id = 62163, name = "幼鼠", nameTextID = 1400075, shapeID = 50003, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "15749", attackConstant = "918", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201069}
, bodytype = 1, behaviacAI = "newbattleaif304", defaultBuff = "", MonsterType = 2003, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62164] = {id = 62164, name = "幽灵水母", nameTextID = 1400078, shapeID = 50004, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "15749", attackConstant = "918", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201083}
, bodytype = 1, behaviacAI = "newbattleaif302", defaultBuff = "", MonsterType = 2004, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62165] = {id = 62165, name = "魅魔", nameTextID = 1400051, shapeID = 50005, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "56247", attackConstant = "918", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201018, 201019}
, bodytype = 1, behaviacAI = "newbattleaif105", defaultBuff = "", MonsterType = 2005, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62166] = {id = 62166, name = "史莱姆", nameTextID = 1400058, shapeID = 50007, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "15749", attackConstant = "918", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201023}
, bodytype = 1, behaviacAI = "newbattleaif201", defaultBuff = "", MonsterType = 2006, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62167] = {id = 62167, name = "连射藤蔓", nameTextID = 1400040, shapeID = 50008, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "15749", attackConstant = "918", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201022, 201065}
, bodytype = 1, behaviacAI = "newbattleaif206", defaultBuff = "", MonsterType = 2007, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62168] = {id = 62168, name = "伞菇", nameTextID = 1400055, shapeID = 50009, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "15749", attackConstant = "918", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201024, 201158}
, bodytype = 1, behaviacAI = "newbattleaif210", defaultBuff = "", MonsterType = 2008, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62169] = {id = 62169, name = "树精", nameTextID = 1400102, shapeID = 50010, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "15749", attackConstant = "918", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201030, 201231}
, bodytype = 1, behaviacAI = "newbattleaif212", defaultBuff = "", MonsterType = 2009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62170] = {id = 62170, name = "石头人", nameTextID = 1400103, shapeID = 50011, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "56247", attackConstant = "918", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201027, 201028, 201029, 201037, 201059}
, bodytype = 1, behaviacAI = "newbattleaif220", defaultBuff = "", MonsterType = 2010, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62171] = {id = 62171, name = "幽灵螳螂", nameTextID = 1400013, shapeID = 50012, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "56247", attackConstant = "918", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201053, 201054, 201055}
, bodytype = 1, behaviacAI = "newbattleaif222", defaultBuff = "", MonsterType = 2011, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62172] = {id = 62172, name = "雪球", nameTextID = 1400062, shapeID = 50014, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "15749", attackConstant = "918", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 2012, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62173] = {id = 62173, name = "冰树精", nameTextID = 1400043, shapeID = 50015, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "15749", attackConstant = "918", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 2013, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62174] = {id = 62174, name = "白狼", nameTextID = 1400068, shapeID = 50017, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "15749", attackConstant = "918", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 201088, 
skillid = {201088, 201089, 201090, 201091}
, bodytype = 1, behaviacAI = "newbattleaif402", defaultBuff = "", MonsterType = 2014, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62175] = {id = 62175, name = "白熊", nameTextID = 1400070, shapeID = 50018, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "15749", attackConstant = "918", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201125, 201126, 201127}
, bodytype = 1, behaviacAI = "newbattleaif403", defaultBuff = "", MonsterType = 2015, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62176] = {id = 62176, name = "雪女", nameTextID = 1400067, shapeID = 50021, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "56247", attackConstant = "918", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 2016, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62177] = {id = 62177, name = "冰雪巨人", nameTextID = 1400104, shapeID = 50019, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "56247", attackConstant = "918", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 2017, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62178] = {id = 62178, name = "怨念聚合体", nameTextID = 1400011, shapeID = 50006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "70000;70000;70000;70000;70000", attackConstant = "918", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 201303, 
skillid = {201301, 201040, 201303, 201300, 201264, 201265}
, bodytype = 1, behaviacAI = "newbattleai20057s", defaultBuff = "20116", MonsterType = 2018, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62179] = {id = 62179, name = "蝴蝶妖精", nameTextID = 1400007, shapeID = 50013, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "70000;70000;70000;70000;70000", attackConstant = "918", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201295, 201296, 201297, 201298, 201266}
, bodytype = 1, behaviacAI = "newbattleai20014s", defaultBuff = "", MonsterType = 2019, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62180] = {id = 62180, name = "白熊 赫沃奥塔", nameTextID = 1400130, shapeID = 50020, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "70000;70000;70000;70000;70000", attackConstant = "918", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201290, 201291, 201292, 201293, 201294, 201267, 201268, 201269, 201270, 201271, 201305, 201320}
, bodytype = 1, behaviacAI = "newbattleai59s", defaultBuff = "20116", MonsterType = 2020, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62181] = {id = 62181, name = "时之塔中型守卫", nameTextID = 1400162, shapeID = 20122, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "730031", attackConstant = "6514", defConstant = "2500", magicattConstant = "0", magicDefConstant = "2500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201531, 201532, 201533, 201534}
, bodytype = 1, behaviacAI = "newbattleaif704", defaultBuff = "", MonsterType = 704, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62182] = {id = 62182, name = "时之塔中型守卫", nameTextID = 1400162, shapeID = 20122, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "682932", attackConstant = "5976", defConstant = "2500", magicattConstant = "0", magicDefConstant = "2500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201531, 201532, 201533, 201534}
, bodytype = 1, behaviacAI = "newbattleaif704", defaultBuff = "", MonsterType = 704, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62183] = {id = 62183, name = "时之塔中型守卫", nameTextID = 1400162, shapeID = 20122, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "740124", attackConstant = "6540", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201531, 201532, 201533, 201534}
, bodytype = 1, behaviacAI = "newbattleaif704", defaultBuff = "", MonsterType = 704, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62184] = {id = 62184, name = "时之塔中型守卫", nameTextID = 1400162, shapeID = 20122, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "825350", attackConstant = "7434", defConstant = "3500", magicattConstant = "0", magicDefConstant = "3500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201531, 201532, 201533, 201534}
, bodytype = 1, behaviacAI = "newbattleaif704", defaultBuff = "", MonsterType = 704, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62185] = {id = 62185, name = "时之塔中型守卫", nameTextID = 1400162, shapeID = 20122, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 36, hpConstant = "24698", attackConstant = "300", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201531, 201532, 201533, 201534}
, bodytype = 1, behaviacAI = "newbattleaif704", defaultBuff = "", MonsterType = 704, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62186] = {id = 62186, name = "恶魔犬", nameTextID = 1400160, shapeID = 20121, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "627984", attackConstant = "5443", defConstant = "2000", magicattConstant = "0", magicDefConstant = "2000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201527, 201528, 201529, 201530}
, bodytype = 1, behaviacAI = "newbattleaif703", defaultBuff = "", MonsterType = 703, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62187] = {id = 62187, name = "恶魔犬", nameTextID = 1400160, shapeID = 20121, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "682932", attackConstant = "5976", defConstant = "2500", magicattConstant = "0", magicDefConstant = "2500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201527, 201528, 201529, 201530}
, bodytype = 1, behaviacAI = "newbattleaif703", defaultBuff = "", MonsterType = 703, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62188] = {id = 62188, name = "恶魔犬", nameTextID = 1400160, shapeID = 20121, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "740124", attackConstant = "6540", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201527, 201528, 201529, 201530}
, bodytype = 1, behaviacAI = "newbattleaif703", defaultBuff = "", MonsterType = 703, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62189] = {id = 62189, name = "恶魔犬", nameTextID = 1400160, shapeID = 20121, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "825350", attackConstant = "7434", defConstant = "3500", magicattConstant = "0", magicDefConstant = "3500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201527, 201528, 201529, 201530}
, bodytype = 1, behaviacAI = "newbattleaif703", defaultBuff = "", MonsterType = 703, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62190] = {id = 62190, name = "恶魔犬", nameTextID = 1400160, shapeID = 20121, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 36, hpConstant = "24698", attackConstant = "300", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201527, 201528, 201529, 201530}
, bodytype = 1, behaviacAI = "newbattleaif703", defaultBuff = "", MonsterType = 703, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62191] = {id = 62191, name = "巨雷龙", nameTextID = 1400155, shapeID = 20127, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 260, hpConstant = "654075;654075;654075;654075;654075", attackConstant = "14155", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201505, 201506, 201507, 201508}
, bodytype = 1, behaviacAI = "newbattleaif814", defaultBuff = "", MonsterType = 814, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62192] = {id = 62192, name = "巨雷龙", nameTextID = 1400155, shapeID = 20127, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 270, hpConstant = "666900;666900;666900;666900;666900", attackConstant = "14545", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201505, 201506, 201507, 201508}
, bodytype = 1, behaviacAI = "newbattleaif814", defaultBuff = "", MonsterType = 814, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62193] = {id = 62193, name = "巨雷龙", nameTextID = 1400155, shapeID = 20127, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 280, hpConstant = "679725;679725;679725;679725;679725", attackConstant = "14939", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201505, 201506, 201507, 201508}
, bodytype = 1, behaviacAI = "newbattleaif814", defaultBuff = "", MonsterType = 814, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62194] = {id = 62194, name = "巨雷龙", nameTextID = 1400155, shapeID = 20127, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "692550;692550;692550;692550;692550", attackConstant = "15338", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201505, 201506, 201507, 201508}
, bodytype = 1, behaviacAI = "newbattleaif814", defaultBuff = "", MonsterType = 814, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62195] = {id = 62195, name = "巨雷龙", nameTextID = 1400155, shapeID = 20127, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "101512;101512;101512;101512;101512", attackConstant = "1004", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201505, 201506, 201507, 201508}
, bodytype = 1, behaviacAI = "newbattleaif814", defaultBuff = "", MonsterType = 814, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62196] = {id = 62196, name = "杀人鲸", nameTextID = 1400156, shapeID = 20123, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 255, hpConstant = "647662", attackConstant = "13962", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201509, 201510, 201511, 201512, 201513}
, bodytype = 1, behaviacAI = "newbattleaif815_1", defaultBuff = "", MonsterType = 815, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62197] = {id = 62197, name = "杀人鲸", nameTextID = 1400156, shapeID = 20123, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 265, hpConstant = "660487", attackConstant = "14349", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201509, 201510, 201511, 201512}
, bodytype = 1, behaviacAI = "newbattleaif815_1", defaultBuff = "", MonsterType = 815, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62198] = {id = 62198, name = "杀人鲸", nameTextID = 1400156, shapeID = 20123, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 275, hpConstant = "673312", attackConstant = "14742", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201509, 201510, 201511, 201512}
, bodytype = 1, behaviacAI = "newbattleaif815_1", defaultBuff = "", MonsterType = 815, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62199] = {id = 62199, name = "杀人鲸", nameTextID = 1400156, shapeID = 20123, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 285, hpConstant = "686137", attackConstant = "15138", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201509, 201510, 201511, 201512}
, bodytype = 1, behaviacAI = "newbattleaif815_1", defaultBuff = "", MonsterType = 815, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62200] = {id = 62200, name = "杀人鲸", nameTextID = 1400156, shapeID = 20123, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "74277", attackConstant = "965", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201509, 201510, 201511, 201512}
, bodytype = 1, behaviacAI = "newbattleaif815_1", defaultBuff = "", MonsterType = 815, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62201] = {id = 62201, name = "魔飞蛇", nameTextID = 1400142, shapeID = 20111, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 255, hpConstant = "647662", attackConstant = "13962", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201493, 201495, 201496, 201497, 201498, 201499, 201500, 201501}
, bodytype = 1, behaviacAI = "newbattleaif813", defaultBuff = "", MonsterType = 813, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62202] = {id = 62202, name = "魔飞蛇", nameTextID = 1400142, shapeID = 20111, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 265, hpConstant = "660487", attackConstant = "14349", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201493, 201495, 201496, 201497, 201498, 201499, 201500, 201501}
, bodytype = 1, behaviacAI = "newbattleaif813", defaultBuff = "", MonsterType = 813, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62203] = {id = 62203, name = "魔飞蛇", nameTextID = 1400142, shapeID = 20111, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 275, hpConstant = "673312", attackConstant = "14742", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201493, 201495, 201496, 201497, 201498, 201499, 201500, 201501}
, bodytype = 1, behaviacAI = "newbattleaif813", defaultBuff = "", MonsterType = 813, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62204] = {id = 62204, name = "魔飞蛇", nameTextID = 1400142, shapeID = 20111, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 285, hpConstant = "686137", attackConstant = "15138", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201493, 201495, 201496, 201497, 201498, 201499, 201500, 201501}
, bodytype = 1, behaviacAI = "newbattleaif813", defaultBuff = "", MonsterType = 813, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62205] = {id = 62205, name = "魔飞蛇", nameTextID = 1400142, shapeID = 20111, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "74277", attackConstant = "965", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201493, 201495, 201496, 201497, 201498, 201499, 201500, 201501}
, bodytype = 1, behaviacAI = "newbattleaif813", defaultBuff = "", MonsterType = 813, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[62206] = {id = 62206, name = "嗜血蚊", nameTextID = 1400152, shapeID = 20100, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "175959", attackConstant = "6237", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201423, 201424, 201425}
, bodytype = 1, behaviacAI = "newbattleaif810", defaultBuff = "", MonsterType = 810, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62207] = {id = 62207, name = "嗜血蚊", nameTextID = 1400152, shapeID = 20100, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "175959", attackConstant = "6237", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201423, 201424, 201425}
, bodytype = 1, behaviacAI = "newbattleaif810", defaultBuff = "", MonsterType = 810, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62208] = {id = 62208, name = "嗜血蚊", nameTextID = 1400152, shapeID = 20100, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "179550", attackConstant = "6408", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201423, 201424, 201425}
, bodytype = 1, behaviacAI = "newbattleaif810", defaultBuff = "", MonsterType = 810, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62209] = {id = 62209, name = "嗜血蚊", nameTextID = 1400152, shapeID = 20100, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "179550", attackConstant = "6408", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201423, 201424, 201425}
, bodytype = 1, behaviacAI = "newbattleaif810", defaultBuff = "", MonsterType = 810, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62210] = {id = 62210, name = "嗜血蚊", nameTextID = 1400152, shapeID = 20100, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "20797", attackConstant = "965", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201423, 201424, 201425}
, bodytype = 1, behaviacAI = "newbattleaif810", defaultBuff = "", MonsterType = 810, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62211] = {id = 62211, name = "幻形飞蛾", nameTextID = 1400149, shapeID = 20125, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "175959", attackConstant = "6237", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201545, 201546, 201547, 201548, 201549}
, bodytype = 1, behaviacAI = "newbattleaif803", defaultBuff = "", MonsterType = 803, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62212] = {id = 62212, name = "幻形飞蛾", nameTextID = 1400149, shapeID = 20125, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "175959", attackConstant = "6237", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201545, 201546, 201547, 201548, 201549}
, bodytype = 1, behaviacAI = "newbattleaif803", defaultBuff = "", MonsterType = 803, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62213] = {id = 62213, name = "幻形飞蛾", nameTextID = 1400149, shapeID = 20125, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "179550", attackConstant = "6408", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201545, 201546, 201547, 201548, 201549}
, bodytype = 1, behaviacAI = "newbattleaif803", defaultBuff = "", MonsterType = 803, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62214] = {id = 62214, name = "幻形飞蛾", nameTextID = 1400149, shapeID = 20125, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "179550", attackConstant = "6408", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201545, 201546, 201547, 201548, 201549}
, bodytype = 1, behaviacAI = "newbattleaif803", defaultBuff = "", MonsterType = 803, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62215] = {id = 62215, name = "幻形飞蛾", nameTextID = 1400149, shapeID = 20125, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "20797", attackConstant = "965", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201545, 201546, 201547, 201548, 201549}
, bodytype = 1, behaviacAI = "newbattleaif803", defaultBuff = "", MonsterType = 803, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62216] = {id = 62216, name = "浮空锯齿鲨", nameTextID = 1400151, shapeID = 20092, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 85, hpConstant = "19603", attackConstant = "848", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201400, 201401, 201402, 201403}
, bodytype = 1, behaviacAI = "newbattleaif808", defaultBuff = "", MonsterType = 808, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62217] = {id = 62217, name = "飞空鱼", nameTextID = 1400138, shapeID = 20099, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "175959", attackConstant = "6237", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201429, 201430, 201431, 201432, 201433, 201434}
, bodytype = 1, behaviacAI = "newbattleaif807", defaultBuff = "", MonsterType = 807, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62218] = {id = 62218, name = "浮空锯齿鲨", nameTextID = 1400151, shapeID = 20092, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 85, hpConstant = "19603", attackConstant = "884", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201400, 201401, 201402, 201403}
, bodytype = 1, behaviacAI = "newbattleaif808", defaultBuff = "", MonsterType = 808, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62219] = {id = 62219, name = "飞空鱼", nameTextID = 1400138, shapeID = 20099, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "175959", attackConstant = "6237", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201429, 201430, 201431, 201432, 201433, 201434}
, bodytype = 1, behaviacAI = "newbattleaif807", defaultBuff = "", MonsterType = 807, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62220] = {id = 62220, name = "浮空锯齿鲨", nameTextID = 1400151, shapeID = 20092, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 85, hpConstant = "19603", attackConstant = "921", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201400, 201401, 201402, 201403}
, bodytype = 1, behaviacAI = "newbattleaif808", defaultBuff = "", MonsterType = 808, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62221] = {id = 62221, name = "飞空鱼", nameTextID = 1400138, shapeID = 20099, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "179550", attackConstant = "6408", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201429, 201430, 201431, 201432, 201433, 201434}
, bodytype = 1, behaviacAI = "newbattleaif807", defaultBuff = "", MonsterType = 807, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62222] = {id = 62222, name = "浮空锯齿鲨", nameTextID = 1400151, shapeID = 20092, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "20797", attackConstant = "926", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201400, 201401, 201402, 201403}
, bodytype = 1, behaviacAI = "newbattleaif808", defaultBuff = "", MonsterType = 808, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62223] = {id = 62223, name = "飞空鱼", nameTextID = 1400138, shapeID = 20099, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "179550", attackConstant = "6408", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201429, 201430, 201431, 201432, 201433, 201434}
, bodytype = 1, behaviacAI = "newbattleaif807", defaultBuff = "", MonsterType = 807, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62224] = {id = 62224, name = "浮空锯齿鲨", nameTextID = 1400151, shapeID = 20092, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "20797", attackConstant = "965", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201400, 201401, 201402, 201403}
, bodytype = 1, behaviacAI = "newbattleaif808", defaultBuff = "", MonsterType = 808, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62225] = {id = 62225, name = "飞空鱼", nameTextID = 1400138, shapeID = 20099, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "20797", attackConstant = "965", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201429, 201430, 201431, 201432, 201433, 201434}
, bodytype = 1, behaviacAI = "newbattleaif807", defaultBuff = "", MonsterType = 807, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62226] = {id = 62226, name = "魔飞龙", nameTextID = 1400150, shapeID = 20109, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "175959", attackConstant = "6237", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201473, 201474, 201475}
, bodytype = 1, behaviacAI = "newbattleaif806", defaultBuff = "", MonsterType = 806, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62227] = {id = 62227, name = "夏日回响-挑战模式5", nameTextID = 1400150, shapeID = 20109, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "175959", attackConstant = "6237", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201473, 201474, 201475}
, bodytype = 1, behaviacAI = "newbattleaif806", defaultBuff = "", MonsterType = 806, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62228] = {id = 62228, name = "魔飞龙", nameTextID = 1400150, shapeID = 20109, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "179550", attackConstant = "6408", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201473, 201474, 201475}
, bodytype = 1, behaviacAI = "newbattleaif806", defaultBuff = "", MonsterType = 806, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62229] = {id = 62229, name = "魔飞龙", nameTextID = 1400150, shapeID = 20109, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "179550", attackConstant = "6408", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201473, 201474, 201475}
, bodytype = 1, behaviacAI = "newbattleaif806", defaultBuff = "", MonsterType = 806, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62230] = {id = 62230, name = "魔飞龙", nameTextID = 1400150, shapeID = 20109, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "20797", attackConstant = "965", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201473, 201474, 201475}
, bodytype = 1, behaviacAI = "newbattleaif806", defaultBuff = "", MonsterType = 806, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62231] = {id = 62231, name = "飞翼魔狼", nameTextID = 1400139, shapeID = 20107, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "175959", attackConstant = "6237", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201473, 201474, 201475, 201447, 201448, 201449}
, bodytype = 1, behaviacAI = "newbattleaif809", defaultBuff = "", MonsterType = 809, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62232] = {id = 62232, name = "飞翼魔狼", nameTextID = 1400139, shapeID = 20107, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "175959", attackConstant = "6237", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201473, 201474, 201475, 201447, 201448, 201449}
, bodytype = 1, behaviacAI = "newbattleaif809", defaultBuff = "", MonsterType = 809, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62233] = {id = 62233, name = "飞翼魔狼", nameTextID = 1400139, shapeID = 20107, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "179550", attackConstant = "6408", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201473, 201474, 201475, 201447, 201448, 201449}
, bodytype = 1, behaviacAI = "newbattleaif809", defaultBuff = "", MonsterType = 809, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62234] = {id = 62234, name = "飞翼魔狼", nameTextID = 1400139, shapeID = 20107, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "179550", attackConstant = "6408", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201473, 201474, 201475, 201447, 201448, 201449}
, bodytype = 1, behaviacAI = "newbattleaif809", defaultBuff = "", MonsterType = 809, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62235] = {id = 62235, name = "飞翼魔狼", nameTextID = 1400139, shapeID = 20107, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "20797", attackConstant = "965", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201473, 201474, 201475, 201447, 201448, 201449}
, bodytype = 1, behaviacAI = "newbattleaif809", defaultBuff = "", MonsterType = 809, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[62236] = {id = 62236, name = "装备-破坏刺杀5", nameTextID = 1400135, shapeID = 20106, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "500000;500000;500000", attackConstant = "880", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201550, 201551, 201552, 201553, 201554, 201555, 201556, 201557, 201558, 201559, 201588, 201589}
, bodytype = 1, behaviacAI = "NewBattleAIEquipSword03", defaultBuff = "20116", MonsterType = 11009, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62237] = {id = 62237, name = "装备-破坏刺杀6", nameTextID = 1400135, shapeID = 20106, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "700000;700000;700000", attackConstant = "1120", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201550, 201551, 201552, 201553, 201554, 201555, 201556, 201557, 201558, 201559, 201588, 201589}
, bodytype = 1, behaviacAI = "NewBattleAIEquipSword03", defaultBuff = "20116", MonsterType = 11009, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62238] = {id = 62238, name = "装备-破坏刺杀7", nameTextID = 1400135, shapeID = 20106, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "800000;800000;800000;800000", attackConstant = "1920", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201550, 201551, 201552, 201553, 201554, 201555, 201556, 201557, 201558, 201559, 201588, 201589}
, bodytype = 1, behaviacAI = "NewBattleAIEquipSword04", defaultBuff = "20116", MonsterType = 11009, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62239] = {id = 62239, name = "装备-破坏刺杀8", nameTextID = 1400135, shapeID = 20106, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 260, hpConstant = "850000;850000;850000;850000", attackConstant = "2160", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201550, 201551, 201552, 201553, 201554, 201555, 201556, 201557, 201558, 201559, 201588, 201589}
, bodytype = 1, behaviacAI = "NewBattleAIEquipSword04", defaultBuff = "20116", MonsterType = 11009, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62240] = {id = 62240, name = "装备-守护恢复5", nameTextID = 1400135, shapeID = 20106, deadtype = 2, bossOrNot = 1, showhp = 0, levelMode = 4, npcLevel = 160, hpConstant = "9999999", attackConstant = "2640", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201550, 201551, 201552, 201553, 201554, 201555, 201556, 201557, 201558, 201559, 201588, 201589}
, bodytype = 1, behaviacAI = "NewBattleAIEquipHammer03", defaultBuff = "20936", MonsterType = 11009, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62241] = {id = 62241, name = "装备-守护恢复6", nameTextID = 1400135, shapeID = 20106, deadtype = 2, bossOrNot = 1, showhp = 0, levelMode = 4, npcLevel = 210, hpConstant = "9999999", attackConstant = "3120", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201550, 201551, 201552, 201553, 201554, 201555, 201556, 201557, 201558, 201559, 201588, 201589}
, bodytype = 1, behaviacAI = "NewBattleAIEquipHammer03", defaultBuff = "20936", MonsterType = 11009, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62242] = {id = 62242, name = "装备-守护恢复7", nameTextID = 1400135, shapeID = 20106, deadtype = 2, bossOrNot = 1, showhp = 0, levelMode = 4, npcLevel = 220, hpConstant = "9999999", attackConstant = "5440", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201550, 201551, 201552, 201553, 201554, 201555, 201556, 201557, 201558, 201559, 201588, 201589}
, bodytype = 1, behaviacAI = "NewBattleAIEquipHammer04", defaultBuff = "20936", MonsterType = 11009, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62243] = {id = 62243, name = "装备-守护恢复8", nameTextID = 1400135, shapeID = 20106, deadtype = 2, bossOrNot = 1, showhp = 0, levelMode = 4, npcLevel = 260, hpConstant = "9999999", attackConstant = "6000", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201550, 201551, 201552, 201553, 201554, 201555, 201556, 201557, 201558, 201559, 201588, 201589}
, bodytype = 1, behaviacAI = "NewBattleAIEquipHammer04", defaultBuff = "20936", MonsterType = 11009, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62244] = {id = 62244, name = "装备-特殊魔导5", nameTextID = 1400135, shapeID = 20106, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "500000;500000;500000", attackConstant = "880", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201550, 201551, 201552, 201553, 201554, 201555, 201556, 201557, 201558, 201559, 201588, 201589}
, bodytype = 1, behaviacAI = "NewBattleAIEquipStaff03", defaultBuff = "20116", MonsterType = 11009, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62245] = {id = 62245, name = "装备-特殊魔导6", nameTextID = 1400135, shapeID = 20106, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "700000;700000;700000", attackConstant = "1120", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201550, 201551, 201552, 201553, 201554, 201555, 201556, 201557, 201558, 201559, 201588, 201589}
, bodytype = 1, behaviacAI = "NewBattleAIEquipStaff03", defaultBuff = "20116", MonsterType = 11009, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62246] = {id = 62246, name = "装备-特殊魔导7", nameTextID = 1400135, shapeID = 20106, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "800000;800000;800000;800000", attackConstant = "1920", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201550, 201551, 201552, 201553, 201554, 201555, 201556, 201557, 201558, 201559, 201588, 201589}
, bodytype = 1, behaviacAI = "NewBattleAIEquipStaff04", defaultBuff = "20116", MonsterType = 11009, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[62247] = {id = 62247, name = "装备-特殊魔导8", nameTextID = 1400135, shapeID = 20106, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 260, hpConstant = "850000;850000;850000;850000", attackConstant = "2160", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201550, 201551, 201552, 201553, 201554, 201555, 201556, 201557, 201558, 201559, 201588, 201589}
, bodytype = 1, behaviacAI = "NewBattleAIEquipStaff04", defaultBuff = "20116", MonsterType = 11009, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[63001] = {id = 63001, name = "怨念聚合体", nameTextID = 1400011, shapeID = 20030, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 70, hpConstant = "89535+(lv-70)*3365;89535+(lv-70)*3365;89535+(lv-70)*3365;89535+(lv-70)*3365;89535+(lv-70)*3365", attackConstant = "1158+(lv-70)*39", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "20", damagereduce = "0", attackID = 201042, 
skillid = {201039, 201040, 201042, 201038}
, bodytype = 1, behaviacAI = "newbattleai20133", defaultBuff = "20116", MonsterType = 107, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[63002] = {id = 63002, name = "次元监视者", nameTextID = 1400006, shapeID = 20006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 80, hpConstant = "157357+(lv-80)*2937;89535+(lv-70)*3365;89535+(lv-70)*3365;89535+(lv-70)*3365;89535+(lv-70)*3365", attackConstant = "2037+(lv-80)*34", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "0", damagereduce = "0", attackID = 201012, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215}
, bodytype = 1, behaviacAI = "newbattleai20007", defaultBuff = "20116", MonsterType = 108, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[63003] = {id = 63003, name = "司祭 弗莱尔", nameTextID = 1400007, shapeID = 20016, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 90, hpConstant = "168597+(lv-90)*2980;89535+(lv-70)*3365;89535+(lv-70)*3365;89535+(lv-70)*3365;89535+(lv-70)*3365", attackConstant = "2207+(lv-90)*35", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201025, 201026, 201031, 201049}
, bodytype = 1, behaviacAI = "newbattleai20014", defaultBuff = "20116", MonsterType = 227, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[63004] = {id = 63004, name = "守护者 埃舍雷", nameTextID = 1400003, shapeID = 20001, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 100, hpConstant = "227884+(lv-100)*2623;89535+(lv-70)*3365;89535+(lv-70)*3365;89535+(lv-70)*3365;89535+(lv-70)*3365", attackConstant = "2380+(lv-100)*36", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "25", damagereduce = "0", attackID = 201044, 
skillid = {201044, 201045, 201046, 201216, 201662}
, bodytype = 1, behaviacAI = "newbattleaif228", defaultBuff = "20116", MonsterType = 228, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[63006] = {id = 63006, name = "白熊 赫沃奥塔", nameTextID = 1400015, shapeID = 20072, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 120, hpConstant = "256370+(lv-120)*5230;89535+(lv-70)*3365;89535+(lv-70)*3365;89535+(lv-70)*3365;89535+(lv-70)*3365", attackConstant = "2736+(lv-120)*82", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201159, 201160, 201161, 201162, 201213, 201272}
, bodytype = 1, behaviacAI = "newbattleaif420_2", defaultBuff = "20116", MonsterType = 420, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[63008] = {id = 63008, name = "守护者 瑟希薇", nameTextID = 1400016, shapeID = 20061, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 140, hpConstant = "444074+(lv-140)*3980;89535+(lv-70)*3365;89535+(lv-70)*3365;89535+(lv-70)*3365;89535+(lv-70)*3365", attackConstant = "5185+(lv-140)*68", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201280, 201142, 201145, 201147, 201148, 201150, 201203, 201204, 201205, 201206, 201143, 201144, 201146, 201149, 201212, 201340, 201163}
, bodytype = 1, behaviacAI = "newbattleaif421", defaultBuff = "20116", MonsterType = 421, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[63011] = {id = 63011, name = "地狱之焰 辛莫拉", nameTextID = 1400036, shapeID = 10050, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 200, hpConstant = "542757+(lv-200)*4098;89535+(lv-70)*3365;89535+(lv-70)*3365;89535+(lv-70)*3365", attackConstant = "6710+(lv-200)*75", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201308, 201309, 201310, 201311, 201312, 201370, 201373}
, bodytype = 1, behaviacAI = "newbattleai20220", defaultBuff = "20116", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[63012] = {id = 63012, name = "天空主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20129, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 280, hpConstant = "2500000+(lv-280)*20833;2500000+(lv-280)*20833", attackConstant = "14000+(lv-280)*83", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201566, 201567, 201568, 201569}
, bodytype = 1, behaviacAI = "newbattleaif818_tail_TZ", defaultBuff = "20116", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[63013] = {id = 63013, name = "空之主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20130, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 230, hpConstant = "902880+(lv-230)*1567;902880+(lv-230)*1567;902880+(lv-230)*1567", attackConstant = "13011+(lv-230)*33", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201570, 201571, 201572, 201573, 201574, 201575}
, bodytype = 1, behaviacAI = "newbattleaif818_body_TZ", defaultBuff = "20116", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[63014] = {id = 63014, name = "空之主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20131, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 230, hpConstant = "902880+(lv-230)*1567;902880+(lv-230)*1567;902880+(lv-230)*1567;902880+(lv-230)*1567", attackConstant = "13011+(lv-230)*33", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201576, 201577, 201578, 201579, 201580, 201581, 201582}
, bodytype = 1, behaviacAI = "newbattleaif818_head_TZ", defaultBuff = "20116", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[63015] = {id = 63015, name = "地狱之焰 辛莫拉", nameTextID = 1400036, shapeID = 10048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "542757+(lv-200)*4098;89535+(lv-70)*3365;89535+(lv-70)*3365;89535+(lv-70)*3365", attackConstant = "6710+(lv-200)*75", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201313, 201314, 201315, 201316, 201317, 201318, 201319, 201370, 201371, 201374}
, bodytype = 1, behaviacAI = "newbattleai20218", defaultBuff = "20116", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[63016] = {id = 63016, name = "卡蜜莉安1（boss战斗）", nameTextID = 1400228, shapeID = 20211, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 350, hpConstant = "2000000+(lv-350)*16666;2000000+(lv-350)*16666;2000000+(lv-350)*16666", attackConstant = "18000+(lv-350)*100", defConstant = "7925", magicattConstant = "0", magicDefConstant = "23777", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201807, 201808, 201809, 201810, 201812}
, bodytype = 1, behaviacAI = "NewBattlebossW6_1_h", defaultBuff = "20116;20115", MonsterType = 916, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[63017] = {id = 63017, name = "卡蜜莉安2（boss战斗）", nameTextID = 1400228, shapeID = 20212, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 350, hpConstant = "3000000+(lv-350)*25000;3000000+(lv-350)*25000;3000000+(lv-350)*25000;3000000+(lv-350)*25000;3000000+(lv-350)*25000", attackConstant = "27000+(lv-350)*150", defConstant = "7925", magicattConstant = "0", magicDefConstant = "23777", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201814, 201815, 201816, 201817, 201819, 201821, 201822, 201824, 201825, 201826, 201827}
, bodytype = 1, behaviacAI = "NewBattlebossW6_2", defaultBuff = "20116;21776;20115", MonsterType = 917, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[64001] = {id = 64001, name = "时之巡逻者-紫", nameTextID = 1400163, shapeID = 50022, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "200000", attackConstant = "2500", defConstant = "0", magicattConstant = "0", magicDefConstant = "12000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201585, 201595}
, bodytype = 1, behaviacAI = "newbattleaif10001", defaultBuff = "", MonsterType = 10001, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[64002] = {id = 64002, name = "时之巡逻者-黄", nameTextID = 1400164, shapeID = 50023, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "250000", attackConstant = "2800", defConstant = "12000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201584, 201596}
, bodytype = 1, behaviacAI = "newbattleaif10002", defaultBuff = "", MonsterType = 10002, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[64003] = {id = 64003, name = "地狱守卫", nameTextID = 1400165, shapeID = 50024, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "900000;900000;900000", attackConstant = "13000", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201531, 201532, 201533, 201534}
, bodytype = 1, behaviacAI = "newbattleaif10004", defaultBuff = "20116", MonsterType = 10003, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[64004] = {id = 64004, name = "地狱恶魔犬", nameTextID = 1400166, shapeID = 50025, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "600000", attackConstant = "3362", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201527, 201528, 201529, 201530}
, bodytype = 1, behaviacAI = "newbattleaif10003", defaultBuff = "", MonsterType = 10004, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[64005] = {id = 64005, name = "不稳定岩核", nameTextID = 1400176, shapeID = 20081, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "50000", attackConstant = "2500", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201388, 201235, 201616, 201617}
, bodytype = 1, behaviacAI = "newbattleaif605_3", defaultBuff = "20939", MonsterType = 10005, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[64006] = {id = 64006, name = "熔岩兽", nameTextID = 1400177, shapeID = 20083, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "250000", attackConstant = "2800", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201239, 201238, 201240}
, bodytype = 1, behaviacAI = "newbattleaif607_3", defaultBuff = "", MonsterType = 10006, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[64007] = {id = 64007, name = "磷火熔岩兽", nameTextID = 1400178, shapeID = 50027, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "800000", attackConstant = "3362", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201239, 201238, 201240}
, bodytype = 1, behaviacAI = "newbattleaif607_3", defaultBuff = "", MonsterType = 10007, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[64008] = {id = 64008, name = "磷火巨兽", nameTextID = 1400179, shapeID = 50028, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "900000;900000;900000", attackConstant = "13000", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201241, 201242, 201243, 201244, 201245, 201372, 201621}
, bodytype = 1, behaviacAI = "newbattleaif608_3", defaultBuff = "20116", MonsterType = 10008, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[65001] = {id = 65001, name = "魂火", nameTextID = 1400039, shapeID = 20078, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "6960", attackConstant = "188", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201217}
, bodytype = 1, behaviacAI = "newbattleaif501", defaultBuff = "20616", MonsterType = 501, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[65002] = {id = 65002, name = "魂火", nameTextID = 1400039, shapeID = 20078, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "6960", attackConstant = "188", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201217}
, bodytype = 1, behaviacAI = "newbattleaif501", defaultBuff = "20616", MonsterType = 501, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[65003] = {id = 65003, name = "魂火", nameTextID = 1400039, shapeID = 20078, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "6960", attackConstant = "188", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201217}
, bodytype = 1, behaviacAI = "newbattleaif501", defaultBuff = "20616", MonsterType = 501, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[65004] = {id = 65004, name = "古塔蝙蝠", nameTextID = 1400052, shapeID = 20007, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 8, npcLevel = 70, hpConstant = "6960", attackConstant = "188", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201020}
, bodytype = 1, behaviacAI = "newbattleaif102", defaultBuff = "", MonsterType = 102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[65005] = {id = 65005, name = "古塔蝙蝠", nameTextID = 1400052, shapeID = 20007, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 8, npcLevel = 70, hpConstant = "6960", attackConstant = "188", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201020}
, bodytype = 1, behaviacAI = "newbattleaif102", defaultBuff = "", MonsterType = 102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[65006] = {id = 65006, name = "怨念体", nameTextID = 1400037, shapeID = 20079, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "16241", attackConstant = "377", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201219, 201218}
, bodytype = 1, behaviacAI = "newbattleaif502", defaultBuff = "", MonsterType = 502, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[65007] = {id = 65007, name = "怨念体", nameTextID = 1400037, shapeID = 20079, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "16241", attackConstant = "377", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201219, 201218}
, bodytype = 1, behaviacAI = "newbattleaif502", defaultBuff = "", MonsterType = 502, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[65008] = {id = 65008, name = "元素使 艾妮萌", nameTextID = 1400022, shapeID = 5014, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 75, hpConstant = "157357;157357;157357;157357", attackConstant = "2037", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201128, 201129, 201130, 201131, 201132, 201331, 201332, 201333}
, bodytype = 1, behaviacAI = "newbattleaif306", defaultBuff = "", MonsterType = 306, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66001] = {id = 66001, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 80, hpConstant = "21457", attackConstant = "517", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66002] = {id = 66002, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "22990", attackConstant = "559", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66003] = {id = 66003, name = "食魔", nameTextID = 1400184, shapeID = 20159, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "53644", attackConstant = "1118", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201650, 201651}
, bodytype = 1, behaviacAI = "NewBattleAITest31", defaultBuff = "", MonsterType = 10010, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66004] = {id = 66004, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 100, hpConstant = "31075", attackConstant = "601", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66005] = {id = 66005, name = "惑魔", nameTextID = 1400183, shapeID = 20158, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 100, hpConstant = "72508", attackConstant = "1203", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201648, 201649}
, bodytype = 1, behaviacAI = "NewBattleAITest30", defaultBuff = "", MonsterType = 10011, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66006] = {id = 66006, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "33017", attackConstant = "644", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66007] = {id = 66007, name = "食魔", nameTextID = 1400184, shapeID = 20159, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "77040", attackConstant = "1289", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201650, 201651}
, bodytype = 1, behaviacAI = "NewBattleAITest31", defaultBuff = "", MonsterType = 10010, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66008] = {id = 66008, name = "惑魔", nameTextID = 1400183, shapeID = 20158, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "77040", attackConstant = "1289", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201648, 201649}
, bodytype = 1, behaviacAI = "NewBattleAITest30", defaultBuff = "", MonsterType = 10011, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66009] = {id = 66009, name = "象魔", nameTextID = 1400187, shapeID = 20162, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "330174", attackConstant = "2561", defConstant = "0", magicattConstant = "0", magicDefConstant = "9000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201657, 201658, 201659, 201660}
, bodytype = 1, behaviacAI = "NewBattleAITest34", defaultBuff = "", MonsterType = 10014, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66010] = {id = 66010, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "34959", attackConstant = "688", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66011] = {id = 66011, name = "怠魔", nameTextID = 1400185, shapeID = 20160, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "81572", attackConstant = "1377", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201652, 201653}
, bodytype = 1, behaviacAI = "NewBattleAITest32", defaultBuff = "21198", MonsterType = 10012, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66012] = {id = 66012, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 130, hpConstant = "36901", attackConstant = "733", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66013] = {id = 66013, name = "怠魔", nameTextID = 1400185, shapeID = 20160, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 130, hpConstant = "86104", attackConstant = "1466", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201652, 201653}
, bodytype = 1, behaviacAI = "NewBattleAITest32", defaultBuff = "21198", MonsterType = 10012, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66014] = {id = 66014, name = "暴魔", nameTextID = 1400186, shapeID = 20161, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 130, hpConstant = "369018", attackConstant = "2925", defConstant = "9000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201654, 201655, 201656}
, bodytype = 1, behaviacAI = "NewBattleAITest33", defaultBuff = "20116", MonsterType = 10013, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66015] = {id = 66015, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "60555", attackConstant = "1266", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66016] = {id = 66016, name = "惑魔", nameTextID = 1400183, shapeID = 20158, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "141296", attackConstant = "2532", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201648, 201649}
, bodytype = 1, behaviacAI = "NewBattleAITest30", defaultBuff = "", MonsterType = 10011, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66017] = {id = 66017, name = "象魔", nameTextID = 1400187, shapeID = 20162, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "605556", attackConstant = "5197", defConstant = "0", magicattConstant = "0", magicDefConstant = "9000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201657, 201658, 201659, 201660}
, bodytype = 1, behaviacAI = "NewBattleAITest34", defaultBuff = "20116", MonsterType = 10014, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66018] = {id = 66018, name = "暴魔", nameTextID = 1400186, shapeID = 20161, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "605556", attackConstant = "5197", defConstant = "9000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201654, 201655, 201656}
, bodytype = 1, behaviacAI = "NewBattleAITest33", defaultBuff = "20116", MonsterType = 10013, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66019] = {id = 66019, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan02", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66020] = {id = 66020, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 100, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan03", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66021] = {id = 66021, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan06", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66022] = {id = 66022, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan04", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66023] = {id = 66023, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 130, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan01", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66024] = {id = 66024, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan05", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66025] = {id = 66025, name = "食魔", nameTextID = 1400184, shapeID = 20159, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "141296", attackConstant = "2532", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201650, 201651}
, bodytype = 1, behaviacAI = "NewBattleAITest31", defaultBuff = "", MonsterType = 10010, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66026] = {id = 66026, name = "怠魔", nameTextID = 1400185, shapeID = 20160, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "141296", attackConstant = "2532", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201652, 201653}
, bodytype = 1, behaviacAI = "NewBattleAITest32", defaultBuff = "21198", MonsterType = 10012, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66027] = {id = 66027, name = "命运的化身", nameTextID = 1400188, shapeID = 20163, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "823855;823855;823855", attackConstant = "5692", defConstant = "4000", magicattConstant = "0", magicDefConstant = "4000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201666, 201667, 201668, 201673}
, bodytype = 1, behaviacAI = "newbattleaif10015", defaultBuff = "21235;21237;21240;20116", MonsterType = 10015, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66028] = {id = 66028, name = "绝·命运的化身", nameTextID = 1400189, shapeID = 20164, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "823855;823855;823855;823855;823855", attackConstant = "5692", defConstant = "8000", magicattConstant = "0", magicDefConstant = "8000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201669, 201670, 201671, 201672, 201673}
, bodytype = 1, behaviacAI = "newbattleaif10016", defaultBuff = "21237;21238;21240;20116", MonsterType = 10016, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66029] = {id = 66029, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "67284", attackConstant = "1441", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66030] = {id = 66030, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "69526", attackConstant = "1501", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66031] = {id = 66031, name = "食魔", nameTextID = 1400184, shapeID = 20159, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "162229", attackConstant = "3002", defConstant = "0", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201650, 201651, 201675}
, bodytype = 1, behaviacAI = "NewBattleAITest31", defaultBuff = "", MonsterType = 10010, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66032] = {id = 66032, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "71769", attackConstant = "1561", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66033] = {id = 66033, name = "惑魔", nameTextID = 1400183, shapeID = 20158, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "167462", attackConstant = "3123", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201648, 201649, 201675}
, bodytype = 1, behaviacAI = "NewBattleAITest30_1", defaultBuff = "", MonsterType = 10011, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66034] = {id = 66034, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "74012", attackConstant = "1623", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66035] = {id = 66035, name = "食魔", nameTextID = 1400184, shapeID = 20159, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "172695", attackConstant = "3246", defConstant = "0", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201650, 201651, 201675}
, bodytype = 1, behaviacAI = "NewBattleAITest31", defaultBuff = "", MonsterType = 10010, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66036] = {id = 66036, name = "惑魔", nameTextID = 1400183, shapeID = 20158, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "172695", attackConstant = "3246", defConstant = "0", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201648, 201649}
, bodytype = 1, behaviacAI = "NewBattleAITest30_1", defaultBuff = "", MonsterType = 10011, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66037] = {id = 66037, name = "象魔", nameTextID = 1400187, shapeID = 20162, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "740124", attackConstant = "6730", defConstant = "0", magicattConstant = "0", magicDefConstant = "12000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201657, 201658, 201659, 201660, 201675}
, bodytype = 1, behaviacAI = "NewBattleAITest34_1", defaultBuff = "20116", MonsterType = 10014, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66038] = {id = 66038, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "76255", attackConstant = "1685", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66039] = {id = 66039, name = "怠魔", nameTextID = 1400185, shapeID = 20160, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "177928", attackConstant = "3370", defConstant = "0", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201652, 201653, 201675}
, bodytype = 1, behaviacAI = "NewBattleAITest32_1", defaultBuff = "21198", MonsterType = 10012, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66040] = {id = 66040, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "120555", attackConstant = "2958", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66041] = {id = 66041, name = "怠魔", nameTextID = 1400185, shapeID = 20160, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "281295", attackConstant = "5916", defConstant = "9000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201652, 201653, 201675}
, bodytype = 1, behaviacAI = "NewBattleAITest32_1", defaultBuff = "21198", MonsterType = 10012, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66042] = {id = 66042, name = "暴魔", nameTextID = 1400186, shapeID = 20161, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "1205550", attackConstant = "12675", defConstant = "12000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201654, 201655, 201656, 201675}
, bodytype = 1, behaviacAI = "NewBattleAITest33_1", defaultBuff = "20116", MonsterType = 10013, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66043] = {id = 66043, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "123120", attackConstant = "3042", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66044] = {id = 66044, name = "惑魔", nameTextID = 1400183, shapeID = 20158, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "287280", attackConstant = "6084", defConstant = "0", magicattConstant = "0", magicDefConstant = "9000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201648, 201649}
, bodytype = 1, behaviacAI = "NewBattleAITest30", defaultBuff = "", MonsterType = 10011, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66045] = {id = 66045, name = "象魔", nameTextID = 1400187, shapeID = 20162, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "1231200", attackConstant = "13050", defConstant = "0", magicattConstant = "0", magicDefConstant = "12000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201657, 201658, 201659, 201660, 201675}
, bodytype = 1, behaviacAI = "NewBattleAITest34_1", defaultBuff = "20116", MonsterType = 10014, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66046] = {id = 66046, name = "暴魔", nameTextID = 1400186, shapeID = 20161, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "1231200", attackConstant = "13050", defConstant = "12000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201654, 201655, 201656, 201675}
, bodytype = 1, behaviacAI = "NewBattleAITest33_1", defaultBuff = "20116", MonsterType = 10013, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66047] = {id = 66047, name = "食魔", nameTextID = 1400184, shapeID = 20159, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "287280", attackConstant = "6084", defConstant = "0", magicattConstant = "0", magicDefConstant = "9000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201650, 201651}
, bodytype = 1, behaviacAI = "NewBattleAITest31", defaultBuff = "", MonsterType = 10010, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66048] = {id = 66048, name = "怠魔", nameTextID = 1400185, shapeID = 20160, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "287280", attackConstant = "6084", defConstant = "9000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201652, 201653}
, bodytype = 1, behaviacAI = "NewBattleAITest32", defaultBuff = "21198", MonsterType = 10012, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66049] = {id = 66049, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan07", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66050] = {id = 66050, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan08", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66051] = {id = 66051, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan09", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66052] = {id = 66052, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan010", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66053] = {id = 66053, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan011", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66054] = {id = 66054, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan012", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66055] = {id = 66055, name = "命运的化身", nameTextID = 1400188, shapeID = 20163, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1624500;1624500;1624500", attackConstant = "13813", defConstant = "8000", magicattConstant = "0", magicDefConstant = "8000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201666, 201667, 201668, 201673}
, bodytype = 1, behaviacAI = "newbattleaif10015_h", defaultBuff = "21235;21237;21240;20116", MonsterType = 10015, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66056] = {id = 66056, name = "绝·命运的化身", nameTextID = 1400189, shapeID = 20164, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1624500;1624500;1624500;1624500;1624500", attackConstant = "13813", defConstant = "12000", magicattConstant = "0", magicDefConstant = "12000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201669, 201670, 201671, 201672, 201673}
, bodytype = 1, behaviacAI = "newbattleaif10016_h", defaultBuff = "21237;21238;21240;20116", MonsterType = 10016, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66057] = {id = 66057, name = "天空主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20129, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 300, hpConstant = "2500000+(lv-300)*20833;2500000+(lv-300)*20833", attackConstant = "14000+(lv-300)*83", defConstant = "8000", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201566, 201567, 201568, 201569}
, bodytype = 1, behaviacAI = "newbattleaif818_tail_TZ_2", defaultBuff = "20116", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66058] = {id = 66058, name = "空之主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20130, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 300, hpConstant = "2500000+(lv-300)*20833;2500000+(lv-300)*20833", attackConstant = "14000+(lv-300)*83", defConstant = "8000", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201570, 201571, 201572, 201573, 201574, 201575}
, bodytype = 1, behaviacAI = "newbattleaif818_body_TZ_2", defaultBuff = "20116", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66059] = {id = 66059, name = "空之主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20131, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 300, hpConstant = "2500000+(lv-300)*20833;2500000+(lv-300)*20833", attackConstant = "14000+(lv-300)*83", defConstant = "8000", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201576, 201577, 201578, 201579, 201580, 201581, 201582}
, bodytype = 1, behaviacAI = "newbattleaif818_head_TZ_2", defaultBuff = "20116", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66060] = {id = 66060, name = "牛头人", nameTextID = 1400190, shapeID = 20153, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "548513;548513;548513;548513;548513", attackConstant = "3362", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201638, 201639, 201640, 201683, 201684}
, bodytype = 1, behaviacAI = "NewBattleAIWeidingBoss01", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66061] = {id = 66061, name = "兰花螳螂", nameTextID = 1400012, shapeID = 20031, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "308385", attackConstant = "1243", defConstant = "2000", magicattConstant = "0", magicDefConstant = "2000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201050, 201051, 201052, 201061, 201060}
, bodytype = 1, behaviacAI = "newbattleai20130", defaultBuff = "", MonsterType = 221, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66062] = {id = 66062, name = "幽灵螳螂", nameTextID = 1400013, shapeID = 20032, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "510685;510685;510685;510685;510685 ", attackConstant = "2759", defConstant = "4000", magicattConstant = "0", magicDefConstant = "4000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201053, 201054, 201055}
, bodytype = 1, behaviacAI = "newbattleai20131", defaultBuff = "20116", MonsterType = 222, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66063] = {id = 66063, name = "白熊 赫沃奥塔", nameTextID = 1400015, shapeID = 20072, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "510685;510685;510685;510685;510685 ", attackConstant = "2759", defConstant = "4000", magicattConstant = "0", magicDefConstant = "4000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201159, 201160, 201161, 201162, 201213, 201272}
, bodytype = 1, behaviacAI = "newbattleaif420_2", defaultBuff = "20116", MonsterType = 420, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66064] = {id = 66064, name = "蝠翼飞狮", nameTextID = 1400157, shapeID = 20117, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "510685;510685;510685;510685;510685 ", attackConstant = "2759", defConstant = "4000", magicattConstant = "0", magicDefConstant = "4000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201514, 201515, 201516, 201517, 201518, 201519, 201520, 201615, 201619}
, bodytype = 1, behaviacAI = "newbattleaif901", defaultBuff = "20116", MonsterType = 901, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66065] = {id = 66065, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "999999", attackConstant = "0", defConstant = "99999", magicattConstant = "0", magicDefConstant = "99999", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {}
, bodytype = 1, behaviacAI = "NewBattleAIWeidingMuzhuang", defaultBuff = "21339", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66066] = {id = 66066, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 135, hpConstant = "88370", attackConstant = "755", defConstant = "2941", magicattConstant = "0", magicDefConstant = "2941", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66067] = {id = 66067, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 135, hpConstant = "88370", attackConstant = "755", defConstant = "2941", magicattConstant = "0", magicDefConstant = "2941", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66068] = {id = 66068, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "143913", attackConstant = "1294", defConstant = "6135", magicattConstant = "0", magicDefConstant = "4135", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66069] = {id = 66069, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "143913", attackConstant = "1294", defConstant = "4135", magicattConstant = "0", magicDefConstant = "8203", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66070] = {id = 66070, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "143913", attackConstant = "1294", defConstant = "6135", magicattConstant = "0", magicDefConstant = "4135", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66071] = {id = 66071, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "143913", attackConstant = "1294", defConstant = "6135", magicattConstant = "0", magicDefConstant = "4135", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66072] = {id = 66072, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 155, hpConstant = "149146", attackConstant = "1353", defConstant = "4221", magicattConstant = "0", magicDefConstant = "8331", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66073] = {id = 66073, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 155, hpConstant = "639198", attackConstant = "2706", defConstant = "4221", magicattConstant = "0", magicDefConstant = "4221", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66074] = {id = 66074, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 165, hpConstant = "154379", attackConstant = "1411", defConstant = "4306", magicattConstant = "0", magicDefConstant = "4306", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66075] = {id = 66075, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 165, hpConstant = "154379", attackConstant = "1411", defConstant = "6306", magicattConstant = "0", magicDefConstant = "4306", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66076] = {id = 66076, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 165, hpConstant = "154379", attackConstant = "1411", defConstant = "6306", magicattConstant = "0", magicDefConstant = "4306", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66077] = {id = 66077, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 165, hpConstant = "154379", attackConstant = "1411", defConstant = "4306", magicattConstant = "0", magicDefConstant = "8459", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66078] = {id = 66078, name = "美人鱼", nameTextID = 1400195, shapeID = 20166, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 165, hpConstant = "661626", attackConstant = "2823", defConstant = "4306", magicattConstant = "0", magicDefConstant = "4306", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01", defaultBuff = "", MonsterType = 11103, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66079] = {id = 66079, name = "小西瓜", nameTextID = 1400197, shapeID = 20172, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "159613", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201702, 201706}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon07", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66080] = {id = 66080, name = "大西瓜", nameTextID = 1400198, shapeID = 20173, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "159613", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201703, 201704, 201706}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon08", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66081] = {id = 66081, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "159613", attackConstant = "1471", defConstant = "6391", magicattConstant = "0", magicDefConstant = "4391", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66082] = {id = 66082, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "159613", attackConstant = "1471", defConstant = "4391", magicattConstant = "0", magicDefConstant = "8587", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66083] = {id = 66083, name = "美人鱼", nameTextID = 1400195, shapeID = 20166, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "684054", attackConstant = "2942", defConstant = "4391", magicattConstant = "0", magicDefConstant = "4391", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01", defaultBuff = "", MonsterType = 11103, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66084] = {id = 66084, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 185, hpConstant = "164846", attackConstant = "1531", defConstant = "4477", magicattConstant = "0", magicDefConstant = "8715", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66085] = {id = 66085, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 185, hpConstant = "706482", attackConstant = "3063", defConstant = "4477", magicattConstant = "0", magicDefConstant = "4477", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66086] = {id = 66086, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 185, hpConstant = "164846", attackConstant = "1531", defConstant = "6477", magicattConstant = "0", magicDefConstant = "4477", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66087] = {id = 66087, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 185, hpConstant = "164846", attackConstant = "1531", defConstant = "6477", magicattConstant = "0", magicDefConstant = "4477", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66088] = {id = 66088, name = "蟹宝王", nameTextID = 1400196, shapeID = 20171, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 185, hpConstant = "894877;894877;894877;894877;894877", attackConstant = "3185", defConstant = "11954", magicattConstant = "0", magicDefConstant = "4477", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201697, 201698, 201699, 201700, 201701}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon06", defaultBuff = "", MonsterType = 11105, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66089] = {id = 66089, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 195, hpConstant = "170079", attackConstant = "1592", defConstant = "4562", magicattConstant = "0", magicDefConstant = "8843", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66090] = {id = 66090, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 195, hpConstant = "728910", attackConstant = "3185", defConstant = "4562", magicattConstant = "0", magicDefConstant = "4562", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66091] = {id = 66091, name = "美人鱼", nameTextID = 1400195, shapeID = 20166, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 195, hpConstant = "728910", attackConstant = "3185", defConstant = "4562", magicattConstant = "0", magicDefConstant = "4562", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01", defaultBuff = "", MonsterType = 11103, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66092] = {id = 66092, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 215, hpConstant = "119273", attackConstant = "2916", defConstant = "8691", magicattConstant = "0", magicDefConstant = "6691", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66093] = {id = 66093, name = "蟹宝王", nameTextID = 1400196, shapeID = 20171, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 215, hpConstant = "1510785;1510785;1510785;1510785;1510785", attackConstant = "5833", defConstant = "16382", magicattConstant = "0", magicDefConstant = "6691", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201697, 201698, 201699, 201700, 201701}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon06", defaultBuff = "", MonsterType = 11105, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66094] = {id = 66094, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "672840", attackConstant = "2882", defConstant = "6349", magicattConstant = "0", magicDefConstant = "4349", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66095] = {id = 66095, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "672840", attackConstant = "2882", defConstant = "4349", magicattConstant = "0", magicDefConstant = "8523", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66096] = {id = 66096, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "717696", attackConstant = "3123", defConstant = "6519", magicattConstant = "0", magicDefConstant = "4519", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66097] = {id = 66097, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "717696", attackConstant = "3123", defConstant = "4519", magicattConstant = "0", magicDefConstant = "8779", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66098] = {id = 66098, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "762552", attackConstant = "3370", defConstant = "6690", magicattConstant = "0", magicDefConstant = "4690", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66099] = {id = 66099, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "762552", attackConstant = "3370", defConstant = "4690", magicattConstant = "0", magicDefConstant = "9035", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66100] = {id = 66100, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "1231200", attackConstant = "6084", defConstant = "8828", magicattConstant = "0", magicDefConstant = "6828", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66101] = {id = 66101, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "1231200", attackConstant = "6084", defConstant = "6828", magicattConstant = "0", magicDefConstant = "12242", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66102] = {id = 66102, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1282500", attackConstant = "6425", defConstant = "7011", magicattConstant = "0", magicDefConstant = "7011", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66103] = {id = 66103, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 270, hpConstant = "1333800", attackConstant = "6773", defConstant = "7194", magicattConstant = "0", magicDefConstant = "7194", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66104] = {id = 66104, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1385100", attackConstant = "7129", defConstant = "9377", magicattConstant = "0", magicDefConstant = "7377", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66105] = {id = 66105, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1385100", attackConstant = "7129", defConstant = "7377", magicattConstant = "0", magicDefConstant = "13065", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66106] = {id = 66106, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1385100", attackConstant = "7129", defConstant = "7377", magicattConstant = "0", magicDefConstant = "7377", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66107] = {id = 66107, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1385100", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAISummerLianzhan01", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66108] = {id = 66108, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1436400", attackConstant = "7491", defConstant = "9560", magicattConstant = "0", magicDefConstant = "7560", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66109] = {id = 66109, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1436400", attackConstant = "7491", defConstant = "7560", magicattConstant = "0", magicDefConstant = "13340", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66110] = {id = 66110, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1436400", attackConstant = "7491", defConstant = "7560", magicattConstant = "0", magicDefConstant = "7560", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66111] = {id = 66111, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1436400", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAISummerLianzhan02", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66112] = {id = 66112, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "672840", attackConstant = "2882", defConstant = "4349", magicattConstant = "0", magicDefConstant = "4349", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66113] = {id = 66113, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "672840", attackConstant = "2882", defConstant = "4349", magicattConstant = "0", magicDefConstant = "8523", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66114] = {id = 66114, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "717696", attackConstant = "3123", defConstant = "4519", magicattConstant = "0", magicDefConstant = "4519", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66115] = {id = 66115, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "717696", attackConstant = "3123", defConstant = "4519", magicattConstant = "0", magicDefConstant = "8779", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66116] = {id = 66116, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "762552", attackConstant = "3370", defConstant = "4690", magicattConstant = "0", magicDefConstant = "4690", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66117] = {id = 66117, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "762552", attackConstant = "3370", defConstant = "4690", magicattConstant = "0", magicDefConstant = "9035", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66118] = {id = 66118, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "1231200", attackConstant = "6084", defConstant = "6828", magicattConstant = "0", magicDefConstant = "6828", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66119] = {id = 66119, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "1231200", attackConstant = "6084", defConstant = "6828", magicattConstant = "0", magicDefConstant = "12242", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66120] = {id = 66120, name = "美人鱼", nameTextID = 1400195, shapeID = 20166, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1282500", attackConstant = "6425", defConstant = "7011", magicattConstant = "0", magicDefConstant = "7011", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01", defaultBuff = "", MonsterType = 11103, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66121] = {id = 66121, name = "美人鱼", nameTextID = 1400195, shapeID = 20166, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 270, hpConstant = "1333800", attackConstant = "6773", defConstant = "7194", magicattConstant = "0", magicDefConstant = "7194", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01", defaultBuff = "", MonsterType = 11103, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66122] = {id = 66122, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1385100", attackConstant = "7129", defConstant = "7377", magicattConstant = "0", magicDefConstant = "7377", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66123] = {id = 66123, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1385100", attackConstant = "7129", defConstant = "7377", magicattConstant = "0", magicDefConstant = "13065", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66124] = {id = 66124, name = "美人鱼", nameTextID = 1400195, shapeID = 20166, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1385100", attackConstant = "7129", defConstant = "7377", magicattConstant = "0", magicDefConstant = "7377", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01", defaultBuff = "", MonsterType = 11103, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66125] = {id = 66125, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1385100", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAISummerLianzhan03", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66126] = {id = 66126, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1436400", attackConstant = "7491", defConstant = "7560", magicattConstant = "0", magicDefConstant = "7560", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66127] = {id = 66127, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1436400", attackConstant = "7491", defConstant = "7560", magicattConstant = "0", magicDefConstant = "13340", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66128] = {id = 66128, name = "美人鱼", nameTextID = 1400195, shapeID = 20166, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1436400", attackConstant = "7491", defConstant = "7560", magicattConstant = "0", magicDefConstant = "7560", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01", defaultBuff = "", MonsterType = 11103, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66129] = {id = 66129, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1436400", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAISummerLianzhan04", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66130] = {id = 66130, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "672840", attackConstant = "2882", defConstant = "4349", magicattConstant = "0", magicDefConstant = "4349", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66131] = {id = 66131, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "672840", attackConstant = "2882", defConstant = "6349", magicattConstant = "0", magicDefConstant = "4349", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66132] = {id = 66132, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "717696", attackConstant = "3123", defConstant = "4519", magicattConstant = "0", magicDefConstant = "4519", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66133] = {id = 66133, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "717696", attackConstant = "3123", defConstant = "6519", magicattConstant = "0", magicDefConstant = "4519", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66134] = {id = 66134, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "762552", attackConstant = "3370", defConstant = "4690", magicattConstant = "0", magicDefConstant = "4690", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66135] = {id = 66135, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "762552", attackConstant = "3370", defConstant = "6690", magicattConstant = "0", magicDefConstant = "4690", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66136] = {id = 66136, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "1231200", attackConstant = "6084", defConstant = "6828", magicattConstant = "0", magicDefConstant = "6828", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66137] = {id = 66137, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "1231200", attackConstant = "6084", defConstant = "8828", magicattConstant = "0", magicDefConstant = "6828", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66138] = {id = 66138, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1282500", attackConstant = "6425", defConstant = "7011", magicattConstant = "0", magicDefConstant = "7011", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66139] = {id = 66139, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 270, hpConstant = "1333800", attackConstant = "6773", defConstant = "7194", magicattConstant = "0", magicDefConstant = "7194", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66140] = {id = 66140, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1385100", attackConstant = "7129", defConstant = "7377", magicattConstant = "0", magicDefConstant = "7377", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66141] = {id = 66141, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1385100", attackConstant = "7129", defConstant = "9377", magicattConstant = "0", magicDefConstant = "7377", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66142] = {id = 66142, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1385100", attackConstant = "7129", defConstant = "7377", magicattConstant = "0", magicDefConstant = "7377", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66143] = {id = 66143, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1385100", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAISummerLianzhan05", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66144] = {id = 66144, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1436400", attackConstant = "7491", defConstant = "7560", magicattConstant = "0", magicDefConstant = "7560", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66145] = {id = 66145, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1436400", attackConstant = "7491", defConstant = "9560", magicattConstant = "0", magicDefConstant = "7560", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66146] = {id = 66146, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1436400", attackConstant = "7491", defConstant = "7560", magicattConstant = "0", magicDefConstant = "7560", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66147] = {id = 66147, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1436400", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAISummerLianzhan06", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66148] = {id = 66148, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "672840", attackConstant = "2882", defConstant = "4349", magicattConstant = "0", magicDefConstant = "4349", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66149] = {id = 66149, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "717696", attackConstant = "3123", defConstant = "4519", magicattConstant = "0", magicDefConstant = "4519", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66150] = {id = 66150, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "762552", attackConstant = "3370", defConstant = "4690", magicattConstant = "0", magicDefConstant = "4690", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66151] = {id = 66151, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "1231200", attackConstant = "6084", defConstant = "6828", magicattConstant = "0", magicDefConstant = "6828", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66152] = {id = 66152, name = "美人鱼", nameTextID = 1400195, shapeID = 20166, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1282500", attackConstant = "6425", defConstant = "7011", magicattConstant = "0", magicDefConstant = "7011", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01", defaultBuff = "", MonsterType = 11103, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66153] = {id = 66153, name = "美人鱼", nameTextID = 1400195, shapeID = 20166, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 270, hpConstant = "1333800", attackConstant = "6773", defConstant = "7194", magicattConstant = "0", magicDefConstant = "7194", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01", defaultBuff = "", MonsterType = 11103, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66154] = {id = 66154, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1385100", attackConstant = "7129", defConstant = "7377", magicattConstant = "0", magicDefConstant = "7377", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66155] = {id = 66155, name = "美人鱼", nameTextID = 1400195, shapeID = 20166, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1385100", attackConstant = "7129", defConstant = "7377", magicattConstant = "0", magicDefConstant = "7377", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01", defaultBuff = "", MonsterType = 11103, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66156] = {id = 66156, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1385100", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAISummerLianzhan07", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66157] = {id = 66157, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1436400", attackConstant = "7491", defConstant = "7560", magicattConstant = "0", magicDefConstant = "7560", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66158] = {id = 66158, name = "美人鱼", nameTextID = 1400195, shapeID = 20166, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1436400", attackConstant = "7491", defConstant = "7560", magicattConstant = "0", magicDefConstant = "7560", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01", defaultBuff = "", MonsterType = 11103, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66159] = {id = 66159, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1436400", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAISummerLianzhan08", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66160] = {id = 66160, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "672840", attackConstant = "2882", defConstant = "4349", magicattConstant = "0", magicDefConstant = "8523", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66161] = {id = 66161, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "717696", attackConstant = "3123", defConstant = "4519", magicattConstant = "0", magicDefConstant = "8779", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66162] = {id = 66162, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "762552", attackConstant = "3370", defConstant = "4690", magicattConstant = "0", magicDefConstant = "9035", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66163] = {id = 66163, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "1231200", attackConstant = "6084", defConstant = "6828", magicattConstant = "0", magicDefConstant = "12242", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66164] = {id = 66164, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1282500", attackConstant = "6425", defConstant = "7011", magicattConstant = "0", magicDefConstant = "7011", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66165] = {id = 66165, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 270, hpConstant = "1333800", attackConstant = "6773", defConstant = "7194", magicattConstant = "0", magicDefConstant = "7194", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66166] = {id = 66166, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1385100", attackConstant = "7129", defConstant = "7377", magicattConstant = "0", magicDefConstant = "13065", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66167] = {id = 66167, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1385100", attackConstant = "7129", defConstant = "7377", magicattConstant = "0", magicDefConstant = "7377", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66168] = {id = 66168, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1385100", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAISummerLianzhan09", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66169] = {id = 66169, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1436400", attackConstant = "7491", defConstant = "7560", magicattConstant = "0", magicDefConstant = "13340", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66170] = {id = 66170, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1436400", attackConstant = "7491", defConstant = "7560", magicattConstant = "0", magicDefConstant = "7560", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66171] = {id = 66171, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1436400", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAISummerLianzhan10", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66172] = {id = 66172, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "672840", attackConstant = "2882", defConstant = "6349", magicattConstant = "0", magicDefConstant = "4349", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66173] = {id = 66173, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "717696", attackConstant = "3123", defConstant = "6519", magicattConstant = "0", magicDefConstant = "4519", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66174] = {id = 66174, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "762552", attackConstant = "3370", defConstant = "6690", magicattConstant = "0", magicDefConstant = "4690", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66175] = {id = 66175, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "1231200", attackConstant = "6084", defConstant = "8828", magicattConstant = "0", magicDefConstant = "6828", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66176] = {id = 66176, name = "美人鱼", nameTextID = 1400195, shapeID = 20166, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1282500", attackConstant = "6425", defConstant = "7011", magicattConstant = "0", magicDefConstant = "7011", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01", defaultBuff = "", MonsterType = 11103, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66177] = {id = 66177, name = "美人鱼", nameTextID = 1400195, shapeID = 20166, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 270, hpConstant = "1333800", attackConstant = "6773", defConstant = "7194", magicattConstant = "0", magicDefConstant = "7194", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01", defaultBuff = "", MonsterType = 11103, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66178] = {id = 66178, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1385100", attackConstant = "7129", defConstant = "9377", magicattConstant = "0", magicDefConstant = "7377", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66179] = {id = 66179, name = "美人鱼", nameTextID = 1400195, shapeID = 20166, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1385100", attackConstant = "7129", defConstant = "7377", magicattConstant = "0", magicDefConstant = "7377", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01", defaultBuff = "", MonsterType = 11103, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66180] = {id = 66180, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1385100", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAISummerLianzhan11", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66181] = {id = 66181, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1436400", attackConstant = "7491", defConstant = "9560", magicattConstant = "0", magicDefConstant = "7560", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66182] = {id = 66182, name = "美人鱼", nameTextID = 1400195, shapeID = 20166, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1436400", attackConstant = "7491", defConstant = "7560", magicattConstant = "0", magicDefConstant = "7560", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01", defaultBuff = "", MonsterType = 11103, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66183] = {id = 66183, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1436400", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAISummerLianzhan12", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66184] = {id = 66184, name = "蟹宝王", nameTextID = 1400196, shapeID = 20171, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "965899;965899;965899;965899;965899", attackConstant = "3371", defConstant = "12380", magicattConstant = "0", magicDefConstant = "4690", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201697, 201698, 201699, 201700, 201701}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon06", defaultBuff = "", MonsterType = 11105, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66185] = {id = 66185, name = "蟹宝王", nameTextID = 1400196, shapeID = 20171, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "1559520;1559520;1559520;1559520;1559520", attackConstant = "6084", defConstant = "16656", magicattConstant = "0", magicDefConstant = "6828", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201697, 201698, 201699, 201700, 201701}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon06", defaultBuff = "", MonsterType = 11105, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66186] = {id = 66186, name = "蟹宝王", nameTextID = 1400196, shapeID = 20171, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1624500;1624500;1624500;1624500;1624500", attackConstant = "6425", defConstant = "17022", magicattConstant = "0", magicDefConstant = "7011", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201697, 201698, 201699, 201700, 201701}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon06", defaultBuff = "", MonsterType = 11105, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66187] = {id = 66187, name = "蟹宝王", nameTextID = 1400196, shapeID = 20171, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 270, hpConstant = "1689480;1689480;1689480;1689480;1689480", attackConstant = "6674", defConstant = "17388", magicattConstant = "0", magicDefConstant = "7194", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201697, 201698, 201699, 201700, 201701}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon06", defaultBuff = "", MonsterType = 11105, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66188] = {id = 66188, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1385100", attackConstant = "7129", defConstant = "7377", magicattConstant = "0", magicDefConstant = "7377", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66189] = {id = 66189, name = "蟹宝王", nameTextID = 1400196, shapeID = 20171, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1754460;1754460;1754460;1754460;1754460", attackConstant = "7129", defConstant = "17754", magicattConstant = "0", magicDefConstant = "7377", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201697, 201698, 201699, 201700, 201701}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon06", defaultBuff = "", MonsterType = 11105, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66190] = {id = 66190, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAISummerLianzhan13", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66191] = {id = 66191, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1436400", attackConstant = "7491", defConstant = "7560", magicattConstant = "0", magicDefConstant = "7560", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66192] = {id = 66192, name = "蟹宝王", nameTextID = 1400196, shapeID = 20171, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1819440;1819440;1819440;1819440;1819440", attackConstant = "7491", defConstant = "18120", magicattConstant = "0", magicDefConstant = "7560", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201697, 201698, 201699, 201700, 201701}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon06", defaultBuff = "", MonsterType = 11105, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66193] = {id = 66193, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 310, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAISummerLianzhan14", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66194] = {id = 66194, name = "美人鱼", nameTextID = 1400195, shapeID = 20166, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 330, hpConstant = "1487700", attackConstant = "7861", defConstant = "7742", magicattConstant = "0", magicDefConstant = "7742", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01", defaultBuff = "", MonsterType = 11103, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66195] = {id = 66195, name = "蟹宝王", nameTextID = 1400196, shapeID = 20171, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 330, hpConstant = "1884420;1884420;1884420;1884420;1884420", attackConstant = "7861", defConstant = "18485", magicattConstant = "0", magicDefConstant = "7742", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201697, 201698, 201699, 201700, 201701}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon06", defaultBuff = "", MonsterType = 11105, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66196] = {id = 66196, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 330, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAISummerLianzhan15", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66197] = {id = 66197, name = "美人鱼", nameTextID = 1400195, shapeID = 20166, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 350, hpConstant = "1539000", attackConstant = "8237", defConstant = "7925", magicattConstant = "0", magicDefConstant = "7925", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01", defaultBuff = "", MonsterType = 11103, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66198] = {id = 66198, name = "蟹宝王", nameTextID = 1400196, shapeID = 20171, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 350, hpConstant = "1949400;1949400;1949400;1949400;1949400", attackConstant = "8237", defConstant = "18851", magicattConstant = "0", magicDefConstant = "7925", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201697, 201698, 201699, 201700, 201701}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon06", defaultBuff = "", MonsterType = 11105, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66199] = {id = 66199, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 350, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "500", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAISummerLianzhan16", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66200] = {id = 66200, name = "小西瓜", nameTextID = 1400197, shapeID = 20172, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "29999999", attackConstant = "0", defConstant = "4000", magicattConstant = "0", magicDefConstant = "4000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201702, 201706}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon07", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66201] = {id = 66201, name = "大西瓜", nameTextID = 1400198, shapeID = 20173, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "29999999", attackConstant = "0", defConstant = "4000", magicattConstant = "0", magicDefConstant = "4000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201703, 201704, 201706}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon08", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66202] = {id = 66202, name = "炸弹西瓜", nameTextID = 1400199, shapeID = 20174, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "29999999", attackConstant = "7000", defConstant = "6000", magicattConstant = "7000", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201703, 201705, 201706}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon09", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66203] = {id = 66203, name = "司祭 弗莱尔", nameTextID = 1400007, shapeID = 20016, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "737783;737783;737783;737783;737783", attackConstant = "5867", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201025, 201026, 201031, 201049}
, bodytype = 1, behaviacAI = "newbattleai20014", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66204] = {id = 66204, name = "骑士团长", nameTextID = 1400019, shapeID = 20059, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "510685;510685;510685;510685;510685 ", attackConstant = "5554", defConstant = "2000", magicattConstant = "0", magicDefConstant = "2000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201118, 201119, 201120, 201121, 201122, 201123, 201124, 201395, 201396, 201397, 201398, 201399}
, bodytype = 1, behaviacAI = "newbattleaif419_2", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66205] = {id = 66205, name = "雪狼", nameTextID = 1400018, shapeID = 20042, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "851141;851141;851141", attackConstant = "5554", defConstant = "4000", magicattConstant = "0", magicDefConstant = "4000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201088, 201089, 201090, 201091, 201210}
, bodytype = 1, behaviacAI = "newbattleaI20168", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66206] = {id = 66206, name = "骑士团卫兵队长", nameTextID = 1400021, shapeID = 20047, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "1539000", attackConstant = "2777", defConstant = "4000", magicattConstant = "0", magicDefConstant = "4000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201137, 201138, 201139, 201140, 201394}
, bodytype = 1, behaviacAI = "newbattleaif416", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66207] = {id = 66207, name = "骑士团哨兵队长", nameTextID = 1400020, shapeID = 20046, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "1127168;1127168;1127168", attackConstant = "5554", defConstant = "4000", magicattConstant = "0", magicDefConstant = "4000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201133, 201134, 201135, 201136, 201393}
, bodytype = 1, behaviacAI = "newbattleaif415", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66208] = {id = 66208, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "999999", attackConstant = "0", defConstant = "99999", magicattConstant = "0", magicDefConstant = "99999", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {}
, bodytype = 1, behaviacAI = "NewBattleAIWeidingMuzhuang", defaultBuff = "21339", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66209] = {id = 66209, name = "万圣节时钟怪", nameTextID = 1400200, shapeID = 20175, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "510685;510685;510685;510685;510685 ", attackConstant = "5554", defConstant = "2000", magicattConstant = "0", magicDefConstant = "2000", speedConstant = "30", damagereduce = "0", attackID = 201012, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215}
, bodytype = 1, behaviacAI = "newbattleai20007", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66210] = {id = 66210, name = "万圣节怨念聚合体", nameTextID = 1400201, shapeID = 20176, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "851141;851141;851141", attackConstant = "5554", defConstant = "4000", magicattConstant = "0", magicDefConstant = "4000", speedConstant = "30", damagereduce = "0", attackID = 201042, 
skillid = {201039, 201040, 201042, 201038}
, bodytype = 1, behaviacAI = "newbattleai20133", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66211] = {id = 66211, name = "万圣节石巨人", nameTextID = 1400202, shapeID = 20177, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "737783;737783;737783;737783;737783", attackConstant = "5867", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201027, 201028, 201029, 201037, 201059, 201642, 201643, 201644, 201645}
, bodytype = 1, behaviacAI = "newbattleai20015", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66212] = {id = 66212, name = "万圣节骸骨蛇", nameTextID = 1400203, shapeID = 20178, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "1127168;1127168;1127168", attackConstant = "5554", defConstant = "4000", magicattConstant = "0", magicDefConstant = "4000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201222, 201221, 201223}
, bodytype = 1, behaviacAI = "newbattleaif504", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66213] = {id = 66213, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "999999", attackConstant = "0", defConstant = "99999", magicattConstant = "0", magicDefConstant = "99999", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {}
, bodytype = 1, behaviacAI = "NewBattleAIWeidingMuzhuang", defaultBuff = "21339", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66214] = {id = 66214, name = "魂火", nameTextID = 1400039, shapeID = 20078, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "60555", attackConstant = "1266", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201217}
, bodytype = 1, behaviacAI = "newbattleaif501", defaultBuff = "20616", MonsterType = 501, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66215] = {id = 66215, name = "魂火", nameTextID = 1400039, shapeID = 20078, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "60555", attackConstant = "1266", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201217}
, bodytype = 1, behaviacAI = "newbattleaif501", defaultBuff = "20616", MonsterType = 501, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66216] = {id = 66216, name = "魂火", nameTextID = 1400039, shapeID = 20078, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "60555", attackConstant = "1266", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201217}
, bodytype = 1, behaviacAI = "newbattleaif501", defaultBuff = "20616", MonsterType = 501, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66217] = {id = 66217, name = "巨鼠", nameTextID = 1400076, shapeID = 20052, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "141296", attackConstant = "1266", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201069, 201080}
, bodytype = 1, behaviacAI = "newbattleaif303", defaultBuff = "", MonsterType = 303, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66218] = {id = 66218, name = "巨鼠", nameTextID = 1400076, shapeID = 20052, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "141296", attackConstant = "1266", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201069, 201080}
, bodytype = 1, behaviacAI = "newbattleaif303", defaultBuff = "", MonsterType = 303, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66219] = {id = 66219, name = "魅魔", nameTextID = 1400051, shapeID = 50005, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "605556", attackConstant = "2882", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201018, 201019}
, bodytype = 1, behaviacAI = "newbattleaif105", defaultBuff = "", MonsterType = 2005, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66220] = {id = 66220, name = "魅魔", nameTextID = 1400051, shapeID = 50005, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "605556", attackConstant = "2882", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201018, 201019}
, bodytype = 1, behaviacAI = "newbattleaif105", defaultBuff = "", MonsterType = 2005, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66221] = {id = 66221, name = "献祭深渊的少女 古尔薇格", nameTextID = 1400029, shapeID = 1027, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "852264", attackConstant = "2882", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201364, 201365, 201366, 201367, 201368, 201369, 201376, 201377, 201379, 201390}
, bodytype = 1, behaviacAI = "newbattleaif505", defaultBuff = "20116", MonsterType = 505, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66222] = {id = 66222, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 135, hpConstant = "88370", attackConstant = "755", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66223] = {id = 66223, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 135, hpConstant = "88370", attackConstant = "755", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66224] = {id = 66224, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "143913", attackConstant = "1294", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66225] = {id = 66225, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "143913", attackConstant = "1294", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66226] = {id = 66226, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 155, hpConstant = "154379", attackConstant = "1411", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66227] = {id = 66227, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 155, hpConstant = "154379", attackConstant = "1411", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66228] = {id = 66228, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 165, hpConstant = "149146", attackConstant = "1353", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66229] = {id = 66229, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 165, hpConstant = "639198", attackConstant = "2706", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66230] = {id = 66230, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "639198", attackConstant = "2706", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66231] = {id = 66231, name = "雪怪", nameTextID = 1400205, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 185, hpConstant = "164846", attackConstant = "1531", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66232] = {id = 66232, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 185, hpConstant = "706482", attackConstant = "3063", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66233] = {id = 66233, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 195, hpConstant = "170079", attackConstant = "1592", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66234] = {id = 66234, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 195, hpConstant = "728910", attackConstant = "3185", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66235] = {id = 66235, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "728910", attackConstant = "3185", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66236] = {id = 66236, name = "雪狼 芬里尔", nameTextID = 1400210, shapeID = 20185, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 215, hpConstant = "1510785;1510785;1510785;1510785;1510785", attackConstant = "5833", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201088, 201089, 201090, 201091, 201210}
, bodytype = 1, behaviacAI = "newbattleaI20168", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66237] = {id = 66237, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 135, hpConstant = "88370", attackConstant = "755", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66238] = {id = 66238, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 135, hpConstant = "88370", attackConstant = "755", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66239] = {id = 66239, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "143913", attackConstant = "1294", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66240] = {id = 66240, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "143913", attackConstant = "1294", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66241] = {id = 66241, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 155, hpConstant = "154379", attackConstant = "1411", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66242] = {id = 66242, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 155, hpConstant = "154379", attackConstant = "1411", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66243] = {id = 66243, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 165, hpConstant = "639198", attackConstant = "2706", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66244] = {id = 66244, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "149146", attackConstant = "1353", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66245] = {id = 66245, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "639198", attackConstant = "2706", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66246] = {id = 66246, name = "雪怪", nameTextID = 1400205, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 185, hpConstant = "164846", attackConstant = "1531", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66247] = {id = 66247, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 195, hpConstant = "170079", attackConstant = "1592", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66248] = {id = 66248, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 195, hpConstant = "170079", attackConstant = "1592", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66249] = {id = 66249, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 195, hpConstant = "728910", attackConstant = "3185", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66250] = {id = 66250, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "728910", attackConstant = "3185", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66251] = {id = 66251, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 195, hpConstant = "728910", attackConstant = "3185", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66252] = {id = 66252, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "728910", attackConstant = "3185", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66253] = {id = 66253, name = "雪狼 芬里尔", nameTextID = 1400210, shapeID = 20185, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 215, hpConstant = "1510785;1510785;1510785;1510785;1510785", attackConstant = "5833", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201088, 201089, 201090, 201091, 201210}
, bodytype = 1, behaviacAI = "newbattleaI20168", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66254] = {id = 66254, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "67284", attackConstant = "1441", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66255] = {id = 66255, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "67284", attackConstant = "1441", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66256] = {id = 66256, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "69526", attackConstant = "1501", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66257] = {id = 66257, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "69526", attackConstant = "1501", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66258] = {id = 66258, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "71769", attackConstant = "1561", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66259] = {id = 66259, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "71769", attackConstant = "1561", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66260] = {id = 66260, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "172695", attackConstant = "3246", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66261] = {id = 66261, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "172695", attackConstant = "3246", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66262] = {id = 66262, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "76255", attackConstant = "1685", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66263] = {id = 66263, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "76255", attackConstant = "1685", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66264] = {id = 66264, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "281295", attackConstant = "5916", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66265] = {id = 66265, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "281295", attackConstant = "5916", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66266] = {id = 66266, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "287280", attackConstant = "6084", defConstant = "1500", magicattConstant = "0", magicDefConstant = "1500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66267] = {id = 66267, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "287280", attackConstant = "6084", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66268] = {id = 66268, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "293265", attackConstant = "6253", defConstant = "1500", magicattConstant = "0", magicDefConstant = "1500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66269] = {id = 66269, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "293265", attackConstant = "6253", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66270] = {id = 66270, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "128250", attackConstant = "3212", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66271] = {id = 66271, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1282500", attackConstant = "3212", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66272] = {id = 66272, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 260, hpConstant = "305235", attackConstant = "6598", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66273] = {id = 66273, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 260, hpConstant = "1308150", attackConstant = "6598", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66274] = {id = 66274, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 270, hpConstant = "133380", attackConstant = "3386", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66275] = {id = 66275, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 270, hpConstant = "1333800", attackConstant = "3386", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66276] = {id = 66276, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 280, hpConstant = "317205", attackConstant = "6950", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66277] = {id = 66277, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 280, hpConstant = "1359450", attackConstant = "6950", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66278] = {id = 66278, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "67284", attackConstant = "1441", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66279] = {id = 66279, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "67284", attackConstant = "1441", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66280] = {id = 66280, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "69526", attackConstant = "1501", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66281] = {id = 66281, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "69526", attackConstant = "1501", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66282] = {id = 66282, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "71769", attackConstant = "1561", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66283] = {id = 66283, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "71769", attackConstant = "1561", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66284] = {id = 66284, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "172695", attackConstant = "3246", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66285] = {id = 66285, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "172695", attackConstant = "3246", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66286] = {id = 66286, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "76255", attackConstant = "1685", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66287] = {id = 66287, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "76255", attackConstant = "1685", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66288] = {id = 66288, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "281295", attackConstant = "5916", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66289] = {id = 66289, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "281295", attackConstant = "5916", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66290] = {id = 66290, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "287280", attackConstant = "6084", defConstant = "1500", magicattConstant = "0", magicDefConstant = "1500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66291] = {id = 66291, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "287280", attackConstant = "6084", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66292] = {id = 66292, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "293265", attackConstant = "6253", defConstant = "1500", magicattConstant = "0", magicDefConstant = "1500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66293] = {id = 66293, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "293265", attackConstant = "6253", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66294] = {id = 66294, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "128250", attackConstant = "3212", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66295] = {id = 66295, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1282500", attackConstant = "3212", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66296] = {id = 66296, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 260, hpConstant = "305235", attackConstant = "6598", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66297] = {id = 66297, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 260, hpConstant = "1308150", attackConstant = "6598", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66298] = {id = 66298, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 270, hpConstant = "133380", attackConstant = "3386", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66299] = {id = 66299, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 270, hpConstant = "1333800", attackConstant = "3386", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66300] = {id = 66300, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 280, hpConstant = "317205", attackConstant = "6950", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66301] = {id = 66301, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 280, hpConstant = "1359450", attackConstant = "6950", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66302] = {id = 66302, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "67284", attackConstant = "1441", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66303] = {id = 66303, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "67284", attackConstant = "1441", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66304] = {id = 66304, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "69526", attackConstant = "1501", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66305] = {id = 66305, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "69526", attackConstant = "1501", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66306] = {id = 66306, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "71769", attackConstant = "1561", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66307] = {id = 66307, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "71769", attackConstant = "1561", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66308] = {id = 66308, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "172695", attackConstant = "3246", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66309] = {id = 66309, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "172695", attackConstant = "3246", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66310] = {id = 66310, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "76255", attackConstant = "1685", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66311] = {id = 66311, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "76255", attackConstant = "1685", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66312] = {id = 66312, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "281295", attackConstant = "5916", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66313] = {id = 66313, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "281295", attackConstant = "5916", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66314] = {id = 66314, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "287280", attackConstant = "6084", defConstant = "1500", magicattConstant = "0", magicDefConstant = "1500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66315] = {id = 66315, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "287280", attackConstant = "6084", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66316] = {id = 66316, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "293265", attackConstant = "6253", defConstant = "1500", magicattConstant = "0", magicDefConstant = "1500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66317] = {id = 66317, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "293265", attackConstant = "6253", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66318] = {id = 66318, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "128250", attackConstant = "3212", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66319] = {id = 66319, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1282500", attackConstant = "3212", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66320] = {id = 66320, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 260, hpConstant = "305235", attackConstant = "6598", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66321] = {id = 66321, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 260, hpConstant = "1308150", attackConstant = "6598", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66322] = {id = 66322, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 270, hpConstant = "133380", attackConstant = "3386", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66323] = {id = 66323, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 270, hpConstant = "1333800", attackConstant = "3386", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66324] = {id = 66324, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 280, hpConstant = "317205", attackConstant = "6950", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66325] = {id = 66325, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 280, hpConstant = "1359450", attackConstant = "6950", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66326] = {id = 66326, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 130, hpConstant = "369018", attackConstant = "1466", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66327] = {id = 66327, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 130, hpConstant = "369018", attackConstant = "1466", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66328] = {id = 66328, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 135, hpConstant = "378729", attackConstant = "1511", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66329] = {id = 66329, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 135, hpConstant = "378729", attackConstant = "1511", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66330] = {id = 66330, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "605556", attackConstant = "2532", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66331] = {id = 66331, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "605556", attackConstant = "2532", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66332] = {id = 66332, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "616770", attackConstant = "2590", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66333] = {id = 66333, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "616770", attackConstant = "2590", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66334] = {id = 66334, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "627984", attackConstant = "2648", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66335] = {id = 66335, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "627984", attackConstant = "2648", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66336] = {id = 66336, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 155, hpConstant = "639198", attackConstant = "2706", defConstant = "500", magicattConstant = "0", magicDefConstant = "500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66337] = {id = 66337, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 155, hpConstant = "639198", attackConstant = "2706", defConstant = "500", magicattConstant = "0", magicDefConstant = "500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66338] = {id = 66338, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "650412", attackConstant = "2764", defConstant = "500", magicattConstant = "0", magicDefConstant = "500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66339] = {id = 66339, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "650412", attackConstant = "2764", defConstant = "500", magicattConstant = "0", magicDefConstant = "500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66340] = {id = 66340, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 165, hpConstant = "661626", attackConstant = "2823", defConstant = "500", magicattConstant = "0", magicDefConstant = "500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66341] = {id = 66341, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 165, hpConstant = "661626", attackConstant = "2823", defConstant = "500", magicattConstant = "0", magicDefConstant = "500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66342] = {id = 66342, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "672840", attackConstant = "2883", defConstant = "500", magicattConstant = "0", magicDefConstant = "500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66343] = {id = 66343, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "672840", attackConstant = "2883", defConstant = "500", magicattConstant = "0", magicDefConstant = "500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66344] = {id = 66344, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "684054", attackConstant = "2942", defConstant = "500", magicattConstant = "0", magicDefConstant = "500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66345] = {id = 66345, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "684054", attackConstant = "2942", defConstant = "500", magicattConstant = "0", magicDefConstant = "500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66346] = {id = 66346, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "695268", attackConstant = "3002", defConstant = "1000", magicattConstant = "0", magicDefConstant = "1000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66347] = {id = 66347, name = "小雪球", nameTextID = 1400204, shapeID = 20179, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "695268", attackConstant = "3002", defConstant = "1000", magicattConstant = "0", magicDefConstant = "1000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201076}
, bodytype = 1, behaviacAI = "newbattleaif410", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66348] = {id = 66348, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 185, hpConstant = "706482", attackConstant = "3063", defConstant = "1000", magicattConstant = "0", magicDefConstant = "1000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66349] = {id = 66349, name = "雪球", nameTextID = 1400205, shapeID = 20180, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 185, hpConstant = "706482", attackConstant = "3063", defConstant = "1000", magicattConstant = "0", magicDefConstant = "1000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201075}
, bodytype = 1, behaviacAI = "newbattleaif409", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66350] = {id = 66350, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "717696", attackConstant = "3124", defConstant = "1000", magicattConstant = "0", magicDefConstant = "1000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66351] = {id = 66351, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "717696", attackConstant = "3124", defConstant = "1000", magicattConstant = "0", magicDefConstant = "1000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66352] = {id = 66352, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 195, hpConstant = "728910", attackConstant = "3185", defConstant = "1000", magicattConstant = "0", magicDefConstant = "1000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66353] = {id = 66353, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 195, hpConstant = "728910", attackConstant = "3185", defConstant = "1000", magicattConstant = "0", magicDefConstant = "1000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66354] = {id = 66354, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "740124", attackConstant = "3247", defConstant = "1000", magicattConstant = "0", magicDefConstant = "1000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66355] = {id = 66355, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "740124", attackConstant = "3247", defConstant = "1000", magicattConstant = "0", magicDefConstant = "1000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66356] = {id = 66356, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "751338", attackConstant = "3309", defConstant = "1500", magicattConstant = "0", magicDefConstant = "1500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66357] = {id = 66357, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "751338", attackConstant = "3309", defConstant = "1500", magicattConstant = "0", magicDefConstant = "1500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66358] = {id = 66358, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "762552", attackConstant = "3371", defConstant = "1500", magicattConstant = "0", magicDefConstant = "1500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66359] = {id = 66359, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "762552", attackConstant = "3371", defConstant = "1500", magicattConstant = "0", magicDefConstant = "1500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66360] = {id = 66360, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 215, hpConstant = "1192725", attackConstant = "5833", defConstant = "1500", magicattConstant = "0", magicDefConstant = "1500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66361] = {id = 66361, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 215, hpConstant = "1192725", attackConstant = "5833", defConstant = "1500", magicattConstant = "0", magicDefConstant = "1500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66362] = {id = 66362, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "1205550", attackConstant = "5916", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66363] = {id = 66363, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "1205550", attackConstant = "5916", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66364] = {id = 66364, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 225, hpConstant = "1218375", attackConstant = "6000", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66365] = {id = 66365, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 225, hpConstant = "1218375", attackConstant = "6000", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66366] = {id = 66366, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "1231200", attackConstant = "6084", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66367] = {id = 66367, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "1231200", attackConstant = "6084", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66368] = {id = 66368, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 235, hpConstant = "1244025", attackConstant = "6169", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66369] = {id = 66369, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 235, hpConstant = "1244025", attackConstant = "6169", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66370] = {id = 66370, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "1256850", attackConstant = "6254", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66371] = {id = 66371, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "1256850", attackConstant = "6254", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66372] = {id = 66372, name = "冰树精", nameTextID = 1400208, shapeID = 20181, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 245, hpConstant = "1269675", attackConstant = "6339", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201092, 201233}
, bodytype = 1, behaviacAI = "newbattleaif404", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66373] = {id = 66373, name = "冰巨人", nameTextID = 1400209, shapeID = 20184, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 245, hpConstant = "1269675", attackConstant = "6339", defConstant = "3000", magicattConstant = "0", magicDefConstant = "3000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201110, 201111, 201112, 201113, 201114, 201209, 201392}
, bodytype = 1, behaviacAI = "newbattleaif412", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66374] = {id = 66374, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1282500", attackConstant = "6425", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66375] = {id = 66375, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1282500", attackConstant = "6425", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66376] = {id = 66376, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 255, hpConstant = "1295325", attackConstant = "6512", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66377] = {id = 66377, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 255, hpConstant = "1295325", attackConstant = "6512", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66378] = {id = 66378, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 260, hpConstant = "1308150", attackConstant = "6599", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66379] = {id = 66379, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 260, hpConstant = "1308150", attackConstant = "6599", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66380] = {id = 66380, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 265, hpConstant = "1320975", attackConstant = "6686", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66381] = {id = 66381, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 265, hpConstant = "1320975", attackConstant = "6686", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66382] = {id = 66382, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 270, hpConstant = "1333900", attackConstant = "6774", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66383] = {id = 66383, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 270, hpConstant = "1333900", attackConstant = "6774", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66384] = {id = 66384, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 275, hpConstant = "1346625", attackConstant = "6862", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66385] = {id = 66385, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 275, hpConstant = "1346625", attackConstant = "6862", defConstant = "4500", magicattConstant = "0", magicDefConstant = "4500", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66386] = {id = 66386, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 280, hpConstant = "1359450", attackConstant = "6951", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66387] = {id = 66387, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 280, hpConstant = "1359450", attackConstant = "6951", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66388] = {id = 66388, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 285, hpConstant = "1372275", attackConstant = "7040", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66389] = {id = 66389, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 285, hpConstant = "1372275", attackConstant = "7040", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66390] = {id = 66390, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1385100", attackConstant = "7129", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66391] = {id = 66391, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 290, hpConstant = "1385100", attackConstant = "7129", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66392] = {id = 66392, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 295, hpConstant = "1397925", attackConstant = "7219", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66393] = {id = 66393, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 295, hpConstant = "1397925", attackConstant = "7219", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66394] = {id = 66394, name = "雪怪", nameTextID = 1400206, shapeID = 20182, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "1410750", attackConstant = "7309", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201093, 201094, 201095, 201096, 201116, 201117}
, bodytype = 1, behaviacAI = "newbattleaif411", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66395] = {id = 66395, name = "雪女", nameTextID = 1400207, shapeID = 20183, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "1410750", attackConstant = "7309", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201107, 201108, 201109}
, bodytype = 1, behaviacAI = "newbattleaif408", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66396] = {id = 66396, name = "雪狼 芬里尔", nameTextID = 1400210, shapeID = 20185, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 240, hpConstant = "Math.min(2653350+(lv-230)*54150,9999999);Math.min(2653350+(lv-230)*54150,9999999);Math.min(2653350+(lv-230)*54150,9999999)", attackConstant = "6252+(lv-230)*170", defConstant = "8000", magicattConstant = "0", magicDefConstant = "8000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201088, 201089, 201090, 201091, 201210}
, bodytype = 1, behaviacAI = "newbattleaI20168", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66397] = {id = 66397, name = "雪狼 芬里尔", nameTextID = 1400210, shapeID = 20185, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 215, hpConstant = "2517975;2517975;2517975", attackConstant = "5833", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201088, 201089, 201090, 201091, 201210}
, bodytype = 1, behaviacAI = "newbattleaI20168", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66398] = {id = 66398, name = "祟-水银", nameTextID = 1400212, shapeID = 20186, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 300, hpConstant = "10000000;10000000;10000000", attackConstant = "7309", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201707, 201708, 201711, 201714, 201717}
, bodytype = 1, behaviacAI = "newbattleaichunmon01", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66399] = {id = 66399, name = "祟-盐石", nameTextID = 1400213, shapeID = 20187, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 300, hpConstant = "10000000;10000000;10000000", attackConstant = "7309", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201707, 201709, 201712, 201715, 201717}
, bodytype = 1, behaviacAI = "newbattleaichunmon02", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66400] = {id = 66400, name = "祟-硫火", nameTextID = 1400211, shapeID = 20188, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 300, hpConstant = "10000000;10000000;10000000", attackConstant = "7309", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201707, 201710, 201713, 201716, 201717}
, bodytype = 1, behaviacAI = "newbattleaichunmon03", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66401] = {id = 66401, name = "年兽-盐石", nameTextID = 1400214, shapeID = 20189, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 300, hpConstant = "10000000;10000000;10000000", attackConstant = "7309", defConstant = "8000", magicattConstant = "0", magicDefConstant = "8000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201717, 201718, 201719, 201730, 201721, 201722, 201727, 201731, 201723, 201724, 201728, 201732, 201725, 201726, 201729}
, bodytype = 1, behaviacAI = "NewBattleAIChunBoss01", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66402] = {id = 66402, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "999999", attackConstant = "0", defConstant = "99999", magicattConstant = "0", magicDefConstant = "99999", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {}
, bodytype = 1, behaviacAI = "NewBattleAINianshouMuzhuang", defaultBuff = "21339", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[66403] = {id = 66403, name = "年兽-水银", nameTextID = 1400214, shapeID = 20190, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 300, hpConstant = "10000000;10000000;10000000", attackConstant = "7309", defConstant = "8000", magicattConstant = "0", magicDefConstant = "8000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201717, 201718, 201719, 201731, 201723, 201724, 201728}
, bodytype = 1, behaviacAI = "NewBattleAIChunBoss02", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66404] = {id = 66404, name = "年兽-硫火", nameTextID = 1400214, shapeID = 20191, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 300, hpConstant = "10000000;10000000;10000000", attackConstant = "7309", defConstant = "8000", magicattConstant = "0", magicDefConstant = "8000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201717, 201718, 201719, 201732, 201725, 201726, 201729}
, bodytype = 1, behaviacAI = "NewBattleAIChunBoss03", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66405] = {id = 66405, name = "厌恶之情", nameTextID = 1400216, shapeID = 20194, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 135, hpConstant = "88370", attackConstant = "755", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201736}
, bodytype = 1, behaviacAI = "NewBattleAIVltMon02", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66406] = {id = 66406, name = "爱慕之心", nameTextID = 1400218, shapeID = 20195, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 145, hpConstant = "143913", attackConstant = "1294", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201738, 201739}
, bodytype = 1, behaviacAI = "NewBattleAIVltMon04", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66407] = {id = 66407, name = "厌恶之情", nameTextID = 1400216, shapeID = 20194, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 155, hpConstant = "154379", attackConstant = "1411", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201736}
, bodytype = 1, behaviacAI = "NewBattleAIVltMon02", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66408] = {id = 66408, name = "爱慕之心", nameTextID = 1400218, shapeID = 20195, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 165, hpConstant = "164845", attackConstant = "1353", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201738, 201739}
, bodytype = 1, behaviacAI = "NewBattleAIVltMon04", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66409] = {id = 66409, name = "厌恶之情", nameTextID = 1400216, shapeID = 20194, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 175, hpConstant = "175311", attackConstant = "1411", defConstant = "2000", magicattConstant = "0", magicDefConstant = "2000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201736}
, bodytype = 1, behaviacAI = "NewBattleAIVltMon02", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66410] = {id = 66410, name = "爱慕之心", nameTextID = 1400218, shapeID = 20195, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 185, hpConstant = "185777", attackConstant = "1531", defConstant = "2000", magicattConstant = "0", magicDefConstant = "2000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201738, 201739, 201109}
, bodytype = 1, behaviacAI = "NewBattleAIVltMon04", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66411] = {id = 66411, name = "卑琐之人", nameTextID = 1400215, shapeID = 20192, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 195, hpConstant = "1510785;1510785;1510785", attackConstant = "3185", defConstant = "4000", magicattConstant = "0", magicDefConstant = "4000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201733, 201734, 201735}
, bodytype = 1, behaviacAI = "NewBattleAIVltMon01", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66412] = {id = 66412, name = "配置的解药", nameTextID = 1400217, shapeID = 20193, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 205, hpConstant = "728910", attackConstant = "3185", defConstant = "4000", magicattConstant = "0", magicDefConstant = "4000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201737}
, bodytype = 1, behaviacAI = "NewBattleAIVltMon03", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66413] = {id = 66413, name = "厌恶之情", nameTextID = 1400216, shapeID = 20194, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "423800", attackConstant = "1266", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201736}
, bodytype = 1, behaviacAI = "NewBattleAIVltMon02", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66414] = {id = 66414, name = "厌恶之情", nameTextID = 1400216, shapeID = 20194, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "486600", attackConstant = "1501", defConstant = "2000", magicattConstant = "0", magicDefConstant = "2000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201736}
, bodytype = 1, behaviacAI = "NewBattleAIVltMon02", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66415] = {id = 66415, name = "厌恶之情", nameTextID = 1400216, shapeID = 20194, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "843800", attackConstant = "2958", defConstant = "4000", magicattConstant = "0", magicDefConstant = "4000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201736}
, bodytype = 1, behaviacAI = "NewBattleAIVltMon02", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66416] = {id = 66416, name = "厌恶之情", nameTextID = 1400216, shapeID = 20194, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 260, hpConstant = "1010785;1010785;1010785", attackConstant = "3280", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201736}
, bodytype = 1, behaviacAI = "NewBattleAIVltMon02", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66417] = {id = 66417, name = "爱慕之心", nameTextID = 1400218, shapeID = 20195, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "423800", attackConstant = "1266", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201738, 201739}
, bodytype = 1, behaviacAI = "NewBattleAIVltMon04", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66418] = {id = 66418, name = "爱慕之心", nameTextID = 1400218, shapeID = 20195, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "486600", attackConstant = "1501", defConstant = "2000", magicattConstant = "0", magicDefConstant = "2000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201738, 201739}
, bodytype = 1, behaviacAI = "NewBattleAIVltMon04", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66419] = {id = 66419, name = "爱慕之心", nameTextID = 1400218, shapeID = 20195, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "843800", attackConstant = "2958", defConstant = "4000", magicattConstant = "0", magicDefConstant = "4000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201738, 201739}
, bodytype = 1, behaviacAI = "NewBattleAIVltMon04", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66420] = {id = 66420, name = "爱慕之心", nameTextID = 1400218, shapeID = 20195, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 260, hpConstant = "1010785;1010785;1010785", attackConstant = "3280", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201738, 201739}
, bodytype = 1, behaviacAI = "NewBattleAIVltMon04", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[66421] = {id = 66421, name = "配置的解药", nameTextID = 1400217, shapeID = 20193, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "423800", attackConstant = "1266", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201737}
, bodytype = 1, behaviacAI = "NewBattleAIVltMon03", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66422] = {id = 66422, name = "配置的解药", nameTextID = 1400217, shapeID = 20193, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "486600", attackConstant = "1501", defConstant = "2000", magicattConstant = "0", magicDefConstant = "2000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201737}
, bodytype = 1, behaviacAI = "NewBattleAIVltMon03", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66423] = {id = 66423, name = "配置的解药", nameTextID = 1400217, shapeID = 20193, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "843800", attackConstant = "2958", defConstant = "4000", magicattConstant = "0", magicDefConstant = "4000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201737}
, bodytype = 1, behaviacAI = "NewBattleAIVltMon03", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66424] = {id = 66424, name = "配置的解药", nameTextID = 1400217, shapeID = 20193, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 260, hpConstant = "1010785;1010785;1010785", attackConstant = "3280", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201737}
, bodytype = 1, behaviacAI = "NewBattleAIVltMon03", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[66425] = {id = 66425, name = "卑琐之人", nameTextID = 1400215, shapeID = 20192, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "423800", attackConstant = "1266", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201733, 201734, 201735}
, bodytype = 1, behaviacAI = "NewBattleAIVltMon01", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66426] = {id = 66426, name = "卑琐之人", nameTextID = 1400215, shapeID = 20192, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "486600", attackConstant = "1501", defConstant = "2000", magicattConstant = "0", magicDefConstant = "2000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201733, 201734, 201735}
, bodytype = 1, behaviacAI = "NewBattleAIVltMon01", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66427] = {id = 66427, name = "卑琐之人", nameTextID = 1400215, shapeID = 20192, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "843800", attackConstant = "2958", defConstant = "4000", magicattConstant = "0", magicDefConstant = "4000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201733, 201734, 201735}
, bodytype = 1, behaviacAI = "NewBattleAIVltMon01", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66428] = {id = 66428, name = "卑琐之人", nameTextID = 1400215, shapeID = 20192, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 260, hpConstant = "1510785;1510785;1510785", attackConstant = "4500", defConstant = "6000", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201733, 201734, 201735}
, bodytype = 1, behaviacAI = "NewBattleAIVltMon01", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66432] = {id = 66432, name = "守护者 埃舍雷", nameTextID = 1400003, shapeID = 20001, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 100, hpConstant = "393619;393619;393619;393619;393619", attackConstant = "2384", defConstant = "888", magicattConstant = "0", magicDefConstant = "1776", speedConstant = "25", damagereduce = "0", attackID = 201044, 
skillid = {201044, 201045, 201046, 201216, 201662}
, bodytype = 1, behaviacAI = "newbattleaif228", defaultBuff = "20116;21761", MonsterType = 228, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66433] = {id = 66433, name = "守护者 埃舍雷", nameTextID = 1400003, shapeID = 20001, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "418220;418220;418220;418220;418220", attackConstant = "2561", defConstant = "914", magicattConstant = "0", magicDefConstant = "1829", speedConstant = "25", damagereduce = "0", attackID = 201044, 
skillid = {201044, 201045, 201046, 201216, 201662}
, bodytype = 1, behaviacAI = "newbattleaif228", defaultBuff = "20116;21761", MonsterType = 228, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66434] = {id = 66434, name = "守护者 埃舍雷", nameTextID = 1400003, shapeID = 20001, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "442821;442821;442821;442821;442821", attackConstant = "2741", defConstant = "941", magicattConstant = "0", magicDefConstant = "1882", speedConstant = "25", damagereduce = "0", attackID = 201044, 
skillid = {201044, 201045, 201046, 201216, 201662}
, bodytype = 1, behaviacAI = "newbattleaif228", defaultBuff = "20116;21761", MonsterType = 228, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66435] = {id = 66435, name = "守护者 埃舍雷", nameTextID = 1400003, shapeID = 20001, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "767037;767037;767037;767037;767037", attackConstant = "5197", defConstant = "1364", magicattConstant = "0", magicDefConstant = "2728", speedConstant = "25", damagereduce = "0", attackID = 201044, 
skillid = {201044, 201045, 201046, 201216, 201662}
, bodytype = 1, behaviacAI = "newbattleaif228", defaultBuff = "20116;21761", MonsterType = 228, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66436] = {id = 66436, name = "守护者 埃舍雷", nameTextID = 1400003, shapeID = 20001, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "795446;795446;795446;795446;795446", attackConstant = "5443", defConstant = "1392", magicattConstant = "0", magicDefConstant = "2785", speedConstant = "25", damagereduce = "0", attackID = 201044, 
skillid = {201044, 201045, 201046, 201216, 201662}
, bodytype = 1, behaviacAI = "newbattleaif228", defaultBuff = "20116;21761", MonsterType = 228, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66437] = {id = 66437, name = "守护者 埃舍雷", nameTextID = 1400003, shapeID = 20001, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "823855;823855;823855;823855;823855", attackConstant = "5692", defConstant = "1421", magicattConstant = "0", magicDefConstant = "2842", speedConstant = "25", damagereduce = "0", attackID = 201044, 
skillid = {201044, 201045, 201046, 201216, 201662}
, bodytype = 1, behaviacAI = "newbattleaif228", defaultBuff = "20116;21761", MonsterType = 228, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66438] = {id = 66438, name = "守护者 埃舍雷", nameTextID = 1400003, shapeID = 20001, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "937490;937490;937490;937490;937490", attackConstant = "6730", defConstant = "1535", magicattConstant = "0", magicDefConstant = "3070", speedConstant = "25", damagereduce = "0", attackID = 201044, 
skillid = {201044, 201045, 201046, 201216, 201662}
, bodytype = 1, behaviacAI = "newbattleaif228", defaultBuff = "20116;21761", MonsterType = 228, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66439] = {id = 66439, name = "守护者 埃舍雷", nameTextID = 1400003, shapeID = 20001, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "1527030;1527030;1527030;1527030;1527030", attackConstant = "12675", defConstant = "2245", magicattConstant = "0", magicDefConstant = "4491", speedConstant = "25", damagereduce = "0", attackID = 201044, 
skillid = {201044, 201045, 201046, 201216, 201662}
, bodytype = 1, behaviacAI = "newbattleaif228", defaultBuff = "20116;21761", MonsterType = 228, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66440] = {id = 66440, name = "守护者 埃舍雷", nameTextID = 1400003, shapeID = 20001, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "1592010;1592010;1592010;1592010;1592010", attackConstant = "13429", defConstant = "2306", magicattConstant = "0", magicDefConstant = "4613", speedConstant = "25", damagereduce = "75", attackID = 201044, 
skillid = {201044, 201045, 201046, 201216, 201662}
, bodytype = 1, behaviacAI = "newbattleaif228", defaultBuff = "20116;21761", MonsterType = 228, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66441] = {id = 66441, name = "守护者 埃舍雷", nameTextID = 1400003, shapeID = 20001, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "1786950;1786950;1786950;1786950;1786950", attackConstant = "15798", defConstant = "2489", magicattConstant = "0", magicDefConstant = "4979", speedConstant = "25", damagereduce = "151", attackID = 201044, 
skillid = {201044, 201045, 201046, 201216, 201662}
, bodytype = 1, behaviacAI = "newbattleaif228", defaultBuff = "20116;21761", MonsterType = 228, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66442] = {id = 66442, name = "守护者 埃舍雷", nameTextID = 1400003, shapeID = 20001, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 320, hpConstant = "1851930;1851930;1851930;1851930;1851930", attackConstant = "16623", defConstant = "2550", magicattConstant = "0", magicDefConstant = "5100", speedConstant = "25", damagereduce = "221", attackID = 201044, 
skillid = {201044, 201045, 201046, 201216, 201662}
, bodytype = 1, behaviacAI = "newbattleaif228", defaultBuff = "20116;21761", MonsterType = 228, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66443] = {id = 66443, name = "守护者 埃舍雷", nameTextID = 1400003, shapeID = 20001, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 340, hpConstant = "1916910;1916910;1916910;1916910;1916910", attackConstant = "17465", defConstant = "2611", magicattConstant = "0", magicDefConstant = "5222", speedConstant = "25", damagereduce = "285", attackID = 201044, 
skillid = {201044, 201045, 201046, 201216, 201662}
, bodytype = 1, behaviacAI = "newbattleaif228", defaultBuff = "20116;21761", MonsterType = 228, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66444] = {id = 66444, name = "守护者 埃舍雷", nameTextID = 1400003, shapeID = 20001, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 400, hpConstant = "2111850;2111850;2111850;2111850;2111850", attackConstant = "20097", defConstant = "2794", magicattConstant = "0", magicDefConstant = "5588", speedConstant = "25", damagereduce = "344", attackID = 201044, 
skillid = {201044, 201045, 201046, 201216, 201662}
, bodytype = 1, behaviacAI = "newbattleaif228", defaultBuff = "20116;21761", MonsterType = 228, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66445] = {id = 66445, name = "守护者 埃舍雷", nameTextID = 1400003, shapeID = 20001, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 420, hpConstant = "2176830;2176830;2176830;2176830;2176830", attackConstant = "21010", defConstant = "2855", magicattConstant = "0", magicDefConstant = "5710", speedConstant = "25", damagereduce = "398", attackID = 201044, 
skillid = {201044, 201045, 201046, 201216, 201662}
, bodytype = 1, behaviacAI = "newbattleaif228", defaultBuff = "20116;21761", MonsterType = 228, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66446] = {id = 66446, name = "守护者 埃舍雷", nameTextID = 1400003, shapeID = 20001, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 440, hpConstant = "2241810;2241810;2241810;2241810;2241810", attackConstant = "21940", defConstant = "2916", magicattConstant = "0", magicDefConstant = "5832", speedConstant = "25", damagereduce = "447", attackID = 201044, 
skillid = {201044, 201045, 201046, 201216, 201662}
, bodytype = 1, behaviacAI = "newbattleaif228", defaultBuff = "20116;21761", MonsterType = 228, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66447] = {id = 66447, name = "守护者 埃舍雷", nameTextID = 1400003, shapeID = 20001, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 560, hpConstant = "2631690;2631690;2631690;2631690;2631690", attackConstant = "27889", defConstant = "3282", magicattConstant = "0", magicDefConstant = "6564", speedConstant = "25", damagereduce = "493", attackID = 201044, 
skillid = {201044, 201045, 201046, 201216, 201662}
, bodytype = 1, behaviacAI = "newbattleaif228", defaultBuff = "20116;21761", MonsterType = 228, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66448] = {id = 66448, name = "守护者 埃舍雷", nameTextID = 1400003, shapeID = 20001, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 620, hpConstant = "2826630;2826630;2826630;2826630;2826630", attackConstant = "31100", defConstant = "3465", magicattConstant = "0", magicDefConstant = "6930", speedConstant = "25", damagereduce = "627", attackID = 201044, 
skillid = {201044, 201045, 201046, 201216, 201662}
, bodytype = 1, behaviacAI = "newbattleaif228", defaultBuff = "20116;21761", MonsterType = 228, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66449] = {id = 66449, name = "守护者 埃舍雷", nameTextID = 1400003, shapeID = 20001, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 680, hpConstant = "3021570;3021570;3021570;3021570;3021570", attackConstant = "34470", defConstant = "3647", magicattConstant = "0", magicDefConstant = "7295", speedConstant = "25", damagereduce = "915", attackID = 201044, 
skillid = {201044, 201045, 201046, 201216, 201662}
, bodytype = 1, behaviacAI = "newbattleaif228", defaultBuff = "20116;21761", MonsterType = 228, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66450] = {id = 66450, name = "司祭 弗莱尔", nameTextID = 1400007, shapeID = 20016, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 100, hpConstant = "393619;393619;393619;393619;393619", attackConstant = "2384", defConstant = "888", magicattConstant = "0", magicDefConstant = "1776", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201025, 201026, 201031, 201049}
, bodytype = 1, behaviacAI = "newbattleai20014", defaultBuff = "20116;21763;21754", MonsterType = 227, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66451] = {id = 66451, name = "司祭 弗莱尔", nameTextID = 1400007, shapeID = 20016, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "418220;418220;418220;418220;418220", attackConstant = "2561", defConstant = "914", magicattConstant = "0", magicDefConstant = "1829", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201025, 201026, 201031, 201049}
, bodytype = 1, behaviacAI = "newbattleai20014", defaultBuff = "20116;21763;21754", MonsterType = 227, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66452] = {id = 66452, name = "司祭 弗莱尔", nameTextID = 1400007, shapeID = 20016, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "442821;442821;442821;442821;442821", attackConstant = "2741", defConstant = "941", magicattConstant = "0", magicDefConstant = "1882", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201025, 201026, 201031, 201049}
, bodytype = 1, behaviacAI = "newbattleai20014", defaultBuff = "20116;21763;21754", MonsterType = 227, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66453] = {id = 66453, name = "司祭 弗莱尔", nameTextID = 1400007, shapeID = 20016, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "767037;767037;767037;767037;767037", attackConstant = "5197", defConstant = "1364", magicattConstant = "0", magicDefConstant = "2728", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201025, 201026, 201031, 201049}
, bodytype = 1, behaviacAI = "newbattleai20014", defaultBuff = "20116;21763;21754", MonsterType = 227, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66454] = {id = 66454, name = "司祭 弗莱尔", nameTextID = 1400007, shapeID = 20016, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "795446;795446;795446;795446;795446", attackConstant = "5443", defConstant = "1392", magicattConstant = "0", magicDefConstant = "2785", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201025, 201026, 201031, 201049}
, bodytype = 1, behaviacAI = "newbattleai20014", defaultBuff = "20116;21763;21754", MonsterType = 227, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66455] = {id = 66455, name = "司祭 弗莱尔", nameTextID = 1400007, shapeID = 20016, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "823855;823855;823855;823855;823855", attackConstant = "5692", defConstant = "1421", magicattConstant = "0", magicDefConstant = "2842", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201025, 201026, 201031, 201049}
, bodytype = 1, behaviacAI = "newbattleai20014", defaultBuff = "20116;21763;21754", MonsterType = 227, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66456] = {id = 66456, name = "司祭 弗莱尔", nameTextID = 1400007, shapeID = 20016, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "937490;937490;937490;937490;937490", attackConstant = "6730", defConstant = "1535", magicattConstant = "0", magicDefConstant = "3070", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201025, 201026, 201031, 201049}
, bodytype = 1, behaviacAI = "newbattleai20014", defaultBuff = "20116;21763;21754", MonsterType = 227, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66457] = {id = 66457, name = "司祭 弗莱尔", nameTextID = 1400007, shapeID = 20016, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "1527030;1527030;1527030;1527030;1527030", attackConstant = "12675", defConstant = "2245", magicattConstant = "0", magicDefConstant = "4491", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201025, 201026, 201031, 201049}
, bodytype = 1, behaviacAI = "newbattleai20014", defaultBuff = "20116;21763;21754", MonsterType = 227, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66458] = {id = 66458, name = "司祭 弗莱尔", nameTextID = 1400007, shapeID = 20016, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "1592010;1592010;1592010;1592010;1592010", attackConstant = "13429", defConstant = "2306", magicattConstant = "0", magicDefConstant = "4613", speedConstant = "30", damagereduce = "75", attackID = 0, 
skillid = {201025, 201026, 201031, 201049}
, bodytype = 1, behaviacAI = "newbattleai20014", defaultBuff = "20116;21763;21754", MonsterType = 227, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66459] = {id = 66459, name = "司祭 弗莱尔", nameTextID = 1400007, shapeID = 20016, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "1786950;1786950;1786950;1786950;1786950", attackConstant = "15798", defConstant = "2489", magicattConstant = "0", magicDefConstant = "4979", speedConstant = "30", damagereduce = "151", attackID = 0, 
skillid = {201025, 201026, 201031, 201049}
, bodytype = 1, behaviacAI = "newbattleai20014", defaultBuff = "20116;21763;21754", MonsterType = 227, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66460] = {id = 66460, name = "司祭 弗莱尔", nameTextID = 1400007, shapeID = 20016, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 320, hpConstant = "1851930;1851930;1851930;1851930;1851930", attackConstant = "16623", defConstant = "2550", magicattConstant = "0", magicDefConstant = "5100", speedConstant = "30", damagereduce = "221", attackID = 0, 
skillid = {201025, 201026, 201031, 201049}
, bodytype = 1, behaviacAI = "newbattleai20014", defaultBuff = "20116;21763;21754", MonsterType = 227, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66461] = {id = 66461, name = "司祭 弗莱尔", nameTextID = 1400007, shapeID = 20016, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 340, hpConstant = "1916910;1916910;1916910;1916910;1916910", attackConstant = "17465", defConstant = "2611", magicattConstant = "0", magicDefConstant = "5222", speedConstant = "30", damagereduce = "285", attackID = 0, 
skillid = {201025, 201026, 201031, 201049}
, bodytype = 1, behaviacAI = "newbattleai20014", defaultBuff = "20116;21763;21754", MonsterType = 227, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66462] = {id = 66462, name = "司祭 弗莱尔", nameTextID = 1400007, shapeID = 20016, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 400, hpConstant = "2111850;2111850;2111850;2111850;2111850", attackConstant = "20097", defConstant = "2794", magicattConstant = "0", magicDefConstant = "5588", speedConstant = "30", damagereduce = "344", attackID = 0, 
skillid = {201025, 201026, 201031, 201049}
, bodytype = 1, behaviacAI = "newbattleai20014", defaultBuff = "20116;21763;21754", MonsterType = 227, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66463] = {id = 66463, name = "司祭 弗莱尔", nameTextID = 1400007, shapeID = 20016, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 420, hpConstant = "2176830;2176830;2176830;2176830;2176830", attackConstant = "21010", defConstant = "2855", magicattConstant = "0", magicDefConstant = "5710", speedConstant = "30", damagereduce = "398", attackID = 0, 
skillid = {201025, 201026, 201031, 201049}
, bodytype = 1, behaviacAI = "newbattleai20014", defaultBuff = "20116;21763;21754", MonsterType = 227, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66464] = {id = 66464, name = "司祭 弗莱尔", nameTextID = 1400007, shapeID = 20016, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 440, hpConstant = "2241810;2241810;2241810;2241810;2241810", attackConstant = "21940", defConstant = "2916", magicattConstant = "0", magicDefConstant = "5832", speedConstant = "30", damagereduce = "447", attackID = 0, 
skillid = {201025, 201026, 201031, 201049}
, bodytype = 1, behaviacAI = "newbattleai20014", defaultBuff = "20116;21763;21754", MonsterType = 227, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66465] = {id = 66465, name = "司祭 弗莱尔", nameTextID = 1400007, shapeID = 20016, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 560, hpConstant = "2631690;2631690;2631690;2631690;2631690", attackConstant = "27889", defConstant = "3282", magicattConstant = "0", magicDefConstant = "6564", speedConstant = "30", damagereduce = "493", attackID = 0, 
skillid = {201025, 201026, 201031, 201049}
, bodytype = 1, behaviacAI = "newbattleai20014", defaultBuff = "20116;21763;21754", MonsterType = 227, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66466] = {id = 66466, name = "司祭 弗莱尔", nameTextID = 1400007, shapeID = 20016, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 620, hpConstant = "2826630;2826630;2826630;2826630;2826630", attackConstant = "31100", defConstant = "3465", magicattConstant = "0", magicDefConstant = "6930", speedConstant = "30", damagereduce = "627", attackID = 0, 
skillid = {201025, 201026, 201031, 201049}
, bodytype = 1, behaviacAI = "newbattleai20014", defaultBuff = "20116;21763;21754", MonsterType = 227, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66467] = {id = 66467, name = "司祭 弗莱尔", nameTextID = 1400007, shapeID = 20016, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 680, hpConstant = "3021570;3021570;3021570;3021570;3021570", attackConstant = "34470", defConstant = "3647", magicattConstant = "0", magicDefConstant = "7295", speedConstant = "30", damagereduce = "915", attackID = 0, 
skillid = {201025, 201026, 201031, 201049}
, bodytype = 1, behaviacAI = "newbattleai20014", defaultBuff = "20116;21763;21754", MonsterType = 227, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66468] = {id = 66468, name = "次元监视者", nameTextID = 1400006, shapeID = 20006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 100, hpConstant = "393619;393619;393619;393619;393619", attackConstant = "2384", defConstant = "1776", magicattConstant = "0", magicDefConstant = "888", speedConstant = "30", damagereduce = "0", attackID = 201012, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215}
, bodytype = 1, behaviacAI = "NewBattleAI20007_bossrush", defaultBuff = "20116;21761", MonsterType = 108, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66469] = {id = 66469, name = "次元监视者", nameTextID = 1400006, shapeID = 20006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "418220;418220;418220;418220;418220", attackConstant = "2561", defConstant = "1829", magicattConstant = "0", magicDefConstant = "914", speedConstant = "30", damagereduce = "0", attackID = 201012, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215}
, bodytype = 1, behaviacAI = "NewBattleAI20007_bossrush", defaultBuff = "20116;21761", MonsterType = 108, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66470] = {id = 66470, name = "次元监视者", nameTextID = 1400006, shapeID = 20006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "442821;442821;442821;442821;442821", attackConstant = "2741", defConstant = "1882", magicattConstant = "0", magicDefConstant = "941", speedConstant = "30", damagereduce = "0", attackID = 201012, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215}
, bodytype = 1, behaviacAI = "NewBattleAI20007_bossrush", defaultBuff = "20116;21761", MonsterType = 108, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66471] = {id = 66471, name = "次元监视者", nameTextID = 1400006, shapeID = 20006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "767037;767037;767037;767037;767037", attackConstant = "5197", defConstant = "2728", magicattConstant = "0", magicDefConstant = "1364", speedConstant = "30", damagereduce = "0", attackID = 201012, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215}
, bodytype = 1, behaviacAI = "NewBattleAI20007_bossrush", defaultBuff = "20116;21761", MonsterType = 108, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66472] = {id = 66472, name = "次元监视者", nameTextID = 1400006, shapeID = 20006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "795446;795446;795446;795446;795446", attackConstant = "5443", defConstant = "2785", magicattConstant = "0", magicDefConstant = "1392", speedConstant = "30", damagereduce = "0", attackID = 201012, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215}
, bodytype = 1, behaviacAI = "NewBattleAI20007_bossrush", defaultBuff = "20116;21761", MonsterType = 108, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66473] = {id = 66473, name = "次元监视者", nameTextID = 1400006, shapeID = 20006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "823855;823855;823855;823855;823855", attackConstant = "5692", defConstant = "2842", magicattConstant = "0", magicDefConstant = "1421", speedConstant = "30", damagereduce = "0", attackID = 201012, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215}
, bodytype = 1, behaviacAI = "NewBattleAI20007_bossrush", defaultBuff = "20116;21761", MonsterType = 108, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66474] = {id = 66474, name = "次元监视者", nameTextID = 1400006, shapeID = 20006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "937490;937490;937490;937490;937490", attackConstant = "6730", defConstant = "3070", magicattConstant = "0", magicDefConstant = "1535", speedConstant = "30", damagereduce = "0", attackID = 201012, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215}
, bodytype = 1, behaviacAI = "NewBattleAI20007_bossrush", defaultBuff = "20116;21761", MonsterType = 108, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66475] = {id = 66475, name = "次元监视者", nameTextID = 1400006, shapeID = 20006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "1527030;1527030;1527030;1527030;1527030", attackConstant = "12675", defConstant = "4491", magicattConstant = "0", magicDefConstant = "2245", speedConstant = "30", damagereduce = "0", attackID = 201012, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215}
, bodytype = 1, behaviacAI = "NewBattleAI20007_bossrush", defaultBuff = "20116;21761", MonsterType = 108, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66476] = {id = 66476, name = "次元监视者", nameTextID = 1400006, shapeID = 20006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "1592010;1592010;1592010;1592010;1592010", attackConstant = "13429", defConstant = "4613", magicattConstant = "0", magicDefConstant = "2306", speedConstant = "30", damagereduce = "75", attackID = 201012, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215}
, bodytype = 1, behaviacAI = "NewBattleAI20007_bossrush", defaultBuff = "20116;21761", MonsterType = 108, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66477] = {id = 66477, name = "次元监视者", nameTextID = 1400006, shapeID = 20006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "1786950;1786950;1786950;1786950;1786950", attackConstant = "15798", defConstant = "4979", magicattConstant = "0", magicDefConstant = "2489", speedConstant = "30", damagereduce = "151", attackID = 201012, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215}
, bodytype = 1, behaviacAI = "NewBattleAI20007_bossrush", defaultBuff = "20116;21761", MonsterType = 108, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66478] = {id = 66478, name = "次元监视者", nameTextID = 1400006, shapeID = 20006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 320, hpConstant = "1851930;1851930;1851930;1851930;1851930", attackConstant = "16623", defConstant = "5100", magicattConstant = "0", magicDefConstant = "2550", speedConstant = "30", damagereduce = "221", attackID = 201012, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215}
, bodytype = 1, behaviacAI = "NewBattleAI20007_bossrush", defaultBuff = "20116;21761", MonsterType = 108, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66479] = {id = 66479, name = "次元监视者", nameTextID = 1400006, shapeID = 20006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 340, hpConstant = "1916910;1916910;1916910;1916910;1916910", attackConstant = "17465", defConstant = "5222", magicattConstant = "0", magicDefConstant = "2611", speedConstant = "30", damagereduce = "285", attackID = 201012, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215}
, bodytype = 1, behaviacAI = "NewBattleAI20007_bossrush", defaultBuff = "20116;21761", MonsterType = 108, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66480] = {id = 66480, name = "次元监视者", nameTextID = 1400006, shapeID = 20006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 400, hpConstant = "2111850;2111850;2111850;2111850;2111850", attackConstant = "20097", defConstant = "5588", magicattConstant = "0", magicDefConstant = "2794", speedConstant = "30", damagereduce = "344", attackID = 201012, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215}
, bodytype = 1, behaviacAI = "NewBattleAI20007_bossrush", defaultBuff = "20116;21761", MonsterType = 108, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66481] = {id = 66481, name = "次元监视者", nameTextID = 1400006, shapeID = 20006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 420, hpConstant = "2176830;2176830;2176830;2176830;2176830", attackConstant = "21010", defConstant = "5710", magicattConstant = "0", magicDefConstant = "2855", speedConstant = "30", damagereduce = "398", attackID = 201012, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215}
, bodytype = 1, behaviacAI = "NewBattleAI20007_bossrush", defaultBuff = "20116;21761", MonsterType = 108, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66482] = {id = 66482, name = "次元监视者", nameTextID = 1400006, shapeID = 20006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 440, hpConstant = "2241810;2241810;2241810;2241810;2241810", attackConstant = "21940", defConstant = "5832", magicattConstant = "0", magicDefConstant = "2916", speedConstant = "30", damagereduce = "447", attackID = 201012, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215}
, bodytype = 1, behaviacAI = "NewBattleAI20007_bossrush", defaultBuff = "20116;21761", MonsterType = 108, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66483] = {id = 66483, name = "次元监视者", nameTextID = 1400006, shapeID = 20006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 560, hpConstant = "2631690;2631690;2631690;2631690;2631690", attackConstant = "27889", defConstant = "6564", magicattConstant = "0", magicDefConstant = "3282", speedConstant = "30", damagereduce = "493", attackID = 201012, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215}
, bodytype = 1, behaviacAI = "NewBattleAI20007_bossrush", defaultBuff = "20116;21761", MonsterType = 108, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66484] = {id = 66484, name = "次元监视者", nameTextID = 1400006, shapeID = 20006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 620, hpConstant = "2826630;2826630;2826630;2826630;2826630", attackConstant = "31100", defConstant = "6930", magicattConstant = "0", magicDefConstant = "3465", speedConstant = "30", damagereduce = "627", attackID = 201012, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215}
, bodytype = 1, behaviacAI = "NewBattleAI20007_bossrush", defaultBuff = "20116;21761", MonsterType = 108, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66485] = {id = 66485, name = "次元监视者", nameTextID = 1400006, shapeID = 20006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 680, hpConstant = "3021570;3021570;3021570;3021570;3021570", attackConstant = "34470", defConstant = "7295", magicattConstant = "0", magicDefConstant = "3647", speedConstant = "30", damagereduce = "915", attackID = 201012, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215}
, bodytype = 1, behaviacAI = "NewBattleAI20007_bossrush", defaultBuff = "20116;21761", MonsterType = 108, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66486] = {id = 66486, name = "怨念聚合体", nameTextID = 1400011, shapeID = 20030, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 100, hpConstant = "393619;393619;393619;393619;393619", attackConstant = "2384", defConstant = "888", magicattConstant = "0", magicDefConstant = "1776", speedConstant = "30", damagereduce = "0", attackID = 201042, 
skillid = {201039, 201040, 201042, 201038}
, bodytype = 1, behaviacAI = "newbattleai20133", defaultBuff = "20116;21763;21755", MonsterType = 107, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66487] = {id = 66487, name = "怨念聚合体", nameTextID = 1400011, shapeID = 20030, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "418220;418220;418220;418220;418220", attackConstant = "2561", defConstant = "914", magicattConstant = "0", magicDefConstant = "1829", speedConstant = "30", damagereduce = "0", attackID = 201042, 
skillid = {201039, 201040, 201042, 201038}
, bodytype = 1, behaviacAI = "newbattleai20133", defaultBuff = "20116;21763;21755", MonsterType = 107, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66488] = {id = 66488, name = "怨念聚合体", nameTextID = 1400011, shapeID = 20030, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "442821;442821;442821;442821;442821", attackConstant = "2741", defConstant = "941", magicattConstant = "0", magicDefConstant = "1882", speedConstant = "30", damagereduce = "0", attackID = 201042, 
skillid = {201039, 201040, 201042, 201038}
, bodytype = 1, behaviacAI = "newbattleai20133", defaultBuff = "20116;21763;21755", MonsterType = 107, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66489] = {id = 66489, name = "怨念聚合体", nameTextID = 1400011, shapeID = 20030, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "767037;767037;767037;767037;767037", attackConstant = "5197", defConstant = "1364", magicattConstant = "0", magicDefConstant = "2728", speedConstant = "30", damagereduce = "0", attackID = 201042, 
skillid = {201039, 201040, 201042, 201038}
, bodytype = 1, behaviacAI = "newbattleai20133", defaultBuff = "20116;21763;21755", MonsterType = 107, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66490] = {id = 66490, name = "怨念聚合体", nameTextID = 1400011, shapeID = 20030, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "795446;795446;795446;795446;795446", attackConstant = "5443", defConstant = "1392", magicattConstant = "0", magicDefConstant = "2785", speedConstant = "30", damagereduce = "0", attackID = 201042, 
skillid = {201039, 201040, 201042, 201038}
, bodytype = 1, behaviacAI = "newbattleai20133", defaultBuff = "20116;21763;21755", MonsterType = 107, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66491] = {id = 66491, name = "怨念聚合体", nameTextID = 1400011, shapeID = 20030, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "823855;823855;823855;823855;823855", attackConstant = "5692", defConstant = "1421", magicattConstant = "0", magicDefConstant = "2842", speedConstant = "30", damagereduce = "0", attackID = 201042, 
skillid = {201039, 201040, 201042, 201038}
, bodytype = 1, behaviacAI = "newbattleai20133", defaultBuff = "20116;21763;21755", MonsterType = 107, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66492] = {id = 66492, name = "怨念聚合体", nameTextID = 1400011, shapeID = 20030, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "937490;937490;937490;937490;937490", attackConstant = "6730", defConstant = "1535", magicattConstant = "0", magicDefConstant = "3070", speedConstant = "30", damagereduce = "0", attackID = 201042, 
skillid = {201039, 201040, 201042, 201038}
, bodytype = 1, behaviacAI = "newbattleai20133", defaultBuff = "20116;21763;21755", MonsterType = 107, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66493] = {id = 66493, name = "怨念聚合体", nameTextID = 1400011, shapeID = 20030, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "1527030;1527030;1527030;1527030;1527030", attackConstant = "12675", defConstant = "2245", magicattConstant = "0", magicDefConstant = "4491", speedConstant = "30", damagereduce = "0", attackID = 201042, 
skillid = {201039, 201040, 201042, 201038}
, bodytype = 1, behaviacAI = "newbattleai20133", defaultBuff = "20116;21763;21755", MonsterType = 107, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66494] = {id = 66494, name = "怨念聚合体", nameTextID = 1400011, shapeID = 20030, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "1592010;1592010;1592010;1592010;1592010", attackConstant = "13429", defConstant = "2306", magicattConstant = "0", magicDefConstant = "4613", speedConstant = "30", damagereduce = "75", attackID = 201042, 
skillid = {201039, 201040, 201042, 201038}
, bodytype = 1, behaviacAI = "newbattleai20133", defaultBuff = "20116;21763;21755", MonsterType = 107, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66495] = {id = 66495, name = "怨念聚合体", nameTextID = 1400011, shapeID = 20030, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "1786950;1786950;1786950;1786950;1786950", attackConstant = "15798", defConstant = "2489", magicattConstant = "0", magicDefConstant = "4979", speedConstant = "30", damagereduce = "151", attackID = 201042, 
skillid = {201039, 201040, 201042, 201038}
, bodytype = 1, behaviacAI = "newbattleai20133", defaultBuff = "20116;21763;21755", MonsterType = 107, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66496] = {id = 66496, name = "怨念聚合体", nameTextID = 1400011, shapeID = 20030, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 320, hpConstant = "1851930;1851930;1851930;1851930;1851930", attackConstant = "16623", defConstant = "2550", magicattConstant = "0", magicDefConstant = "5100", speedConstant = "30", damagereduce = "221", attackID = 201042, 
skillid = {201039, 201040, 201042, 201038}
, bodytype = 1, behaviacAI = "newbattleai20133", defaultBuff = "20116;21763;21755", MonsterType = 107, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66497] = {id = 66497, name = "怨念聚合体", nameTextID = 1400011, shapeID = 20030, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 340, hpConstant = "1916910;1916910;1916910;1916910;1916910", attackConstant = "17465", defConstant = "2611", magicattConstant = "0", magicDefConstant = "5222", speedConstant = "30", damagereduce = "285", attackID = 201042, 
skillid = {201039, 201040, 201042, 201038}
, bodytype = 1, behaviacAI = "newbattleai20133", defaultBuff = "20116;21763;21755", MonsterType = 107, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66498] = {id = 66498, name = "怨念聚合体", nameTextID = 1400011, shapeID = 20030, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 400, hpConstant = "2111850;2111850;2111850;2111850;2111850", attackConstant = "20097", defConstant = "2794", magicattConstant = "0", magicDefConstant = "5588", speedConstant = "30", damagereduce = "344", attackID = 201042, 
skillid = {201039, 201040, 201042, 201038}
, bodytype = 1, behaviacAI = "newbattleai20133", defaultBuff = "20116;21763;21755", MonsterType = 107, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66499] = {id = 66499, name = "怨念聚合体", nameTextID = 1400011, shapeID = 20030, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 420, hpConstant = "2176830;2176830;2176830;2176830;2176830", attackConstant = "21010", defConstant = "2855", magicattConstant = "0", magicDefConstant = "5710", speedConstant = "30", damagereduce = "398", attackID = 201042, 
skillid = {201039, 201040, 201042, 201038}
, bodytype = 1, behaviacAI = "newbattleai20133", defaultBuff = "20116;21763;21755", MonsterType = 107, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66500] = {id = 66500, name = "怨念聚合体", nameTextID = 1400011, shapeID = 20030, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 440, hpConstant = "2241810;2241810;2241810;2241810;2241810", attackConstant = "21940", defConstant = "2916", magicattConstant = "0", magicDefConstant = "5832", speedConstant = "30", damagereduce = "447", attackID = 201042, 
skillid = {201039, 201040, 201042, 201038}
, bodytype = 1, behaviacAI = "newbattleai20133", defaultBuff = "20116;21763;21755", MonsterType = 107, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66501] = {id = 66501, name = "怨念聚合体", nameTextID = 1400011, shapeID = 20030, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 560, hpConstant = "2631690;2631690;2631690;2631690;2631690", attackConstant = "27889", defConstant = "3282", magicattConstant = "0", magicDefConstant = "6564", speedConstant = "30", damagereduce = "493", attackID = 201042, 
skillid = {201039, 201040, 201042, 201038}
, bodytype = 1, behaviacAI = "newbattleai20133", defaultBuff = "20116;21763;21755", MonsterType = 107, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66502] = {id = 66502, name = "怨念聚合体", nameTextID = 1400011, shapeID = 20030, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 620, hpConstant = "2826630;2826630;2826630;2826630;2826630", attackConstant = "31100", defConstant = "3465", magicattConstant = "0", magicDefConstant = "6930", speedConstant = "30", damagereduce = "627", attackID = 201042, 
skillid = {201039, 201040, 201042, 201038}
, bodytype = 1, behaviacAI = "newbattleai20133", defaultBuff = "20116;21763;21755", MonsterType = 107, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66503] = {id = 66503, name = "怨念聚合体", nameTextID = 1400011, shapeID = 20030, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 680, hpConstant = "3021570;3021570;3021570;3021570;3021570", attackConstant = "34470", defConstant = "3647", magicattConstant = "0", magicDefConstant = "7295", speedConstant = "30", damagereduce = "915", attackID = 201042, 
skillid = {201039, 201040, 201042, 201038}
, bodytype = 1, behaviacAI = "newbattleai20133", defaultBuff = "20116;21763;21755", MonsterType = 107, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66504] = {id = 66504, name = "白熊 赫沃奥塔", nameTextID = 1400015, shapeID = 20072, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 100, hpConstant = "393619;393619;393619;393619;393619", attackConstant = "2384", defConstant = "1776", magicattConstant = "0", magicDefConstant = "888", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201159, 201160, 201161, 201162, 201213, 201272}
, bodytype = 1, behaviacAI = "newbattleaif420_2", defaultBuff = "20116;21761", MonsterType = 420, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66505] = {id = 66505, name = "白熊 赫沃奥塔", nameTextID = 1400015, shapeID = 20072, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "418220;418220;418220;418220;418220", attackConstant = "2561", defConstant = "1829", magicattConstant = "0", magicDefConstant = "914", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201159, 201160, 201161, 201162, 201213, 201272}
, bodytype = 1, behaviacAI = "newbattleaif420_2", defaultBuff = "20116;21761", MonsterType = 420, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66506] = {id = 66506, name = "白熊 赫沃奥塔", nameTextID = 1400015, shapeID = 20072, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "442821;442821;442821;442821;442821", attackConstant = "2741", defConstant = "1882", magicattConstant = "0", magicDefConstant = "941", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201159, 201160, 201161, 201162, 201213, 201272}
, bodytype = 1, behaviacAI = "newbattleaif420_2", defaultBuff = "20116;21761", MonsterType = 420, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66507] = {id = 66507, name = "白熊 赫沃奥塔", nameTextID = 1400015, shapeID = 20072, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "767037;767037;767037;767037;767037", attackConstant = "5197", defConstant = "2728", magicattConstant = "0", magicDefConstant = "1364", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201159, 201160, 201161, 201162, 201213, 201272}
, bodytype = 1, behaviacAI = "newbattleaif420_2", defaultBuff = "20116;21761", MonsterType = 420, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66508] = {id = 66508, name = "白熊 赫沃奥塔", nameTextID = 1400015, shapeID = 20072, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "795446;795446;795446;795446;795446", attackConstant = "5443", defConstant = "2785", magicattConstant = "0", magicDefConstant = "1392", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201159, 201160, 201161, 201162, 201213, 201272}
, bodytype = 1, behaviacAI = "newbattleaif420_2", defaultBuff = "20116;21761", MonsterType = 420, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66509] = {id = 66509, name = "白熊 赫沃奥塔", nameTextID = 1400015, shapeID = 20072, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "823855;823855;823855;823855;823855", attackConstant = "5692", defConstant = "2842", magicattConstant = "0", magicDefConstant = "1421", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201159, 201160, 201161, 201162, 201213, 201272}
, bodytype = 1, behaviacAI = "newbattleaif420_2", defaultBuff = "20116;21761", MonsterType = 420, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66510] = {id = 66510, name = "白熊 赫沃奥塔", nameTextID = 1400015, shapeID = 20072, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "937490;937490;937490;937490;937490", attackConstant = "6730", defConstant = "3070", magicattConstant = "0", magicDefConstant = "1535", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201159, 201160, 201161, 201162, 201213, 201272}
, bodytype = 1, behaviacAI = "newbattleaif420_2", defaultBuff = "20116;21761", MonsterType = 420, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66511] = {id = 66511, name = "白熊 赫沃奥塔", nameTextID = 1400015, shapeID = 20072, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "1527030;1527030;1527030;1527030;1527030", attackConstant = "12675", defConstant = "4491", magicattConstant = "0", magicDefConstant = "2245", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201159, 201160, 201161, 201162, 201213, 201272}
, bodytype = 1, behaviacAI = "newbattleaif420_2", defaultBuff = "20116;21761", MonsterType = 420, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66512] = {id = 66512, name = "白熊 赫沃奥塔", nameTextID = 1400015, shapeID = 20072, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "1592010;1592010;1592010;1592010;1592010", attackConstant = "13429", defConstant = "4613", magicattConstant = "0", magicDefConstant = "2306", speedConstant = "30", damagereduce = "75", attackID = 0, 
skillid = {201159, 201160, 201161, 201162, 201213, 201272}
, bodytype = 1, behaviacAI = "newbattleaif420_2", defaultBuff = "20116;21761", MonsterType = 420, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66513] = {id = 66513, name = "白熊 赫沃奥塔", nameTextID = 1400015, shapeID = 20072, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "1786950;1786950;1786950;1786950;1786950", attackConstant = "15798", defConstant = "4979", magicattConstant = "0", magicDefConstant = "2489", speedConstant = "30", damagereduce = "151", attackID = 0, 
skillid = {201159, 201160, 201161, 201162, 201213, 201272}
, bodytype = 1, behaviacAI = "newbattleaif420_2", defaultBuff = "20116;21761", MonsterType = 420, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66514] = {id = 66514, name = "白熊 赫沃奥塔", nameTextID = 1400015, shapeID = 20072, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 320, hpConstant = "1851930;1851930;1851930;1851930;1851930", attackConstant = "16623", defConstant = "5100", magicattConstant = "0", magicDefConstant = "2550", speedConstant = "30", damagereduce = "221", attackID = 0, 
skillid = {201159, 201160, 201161, 201162, 201213, 201272}
, bodytype = 1, behaviacAI = "newbattleaif420_2", defaultBuff = "20116;21761", MonsterType = 420, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66515] = {id = 66515, name = "白熊 赫沃奥塔", nameTextID = 1400015, shapeID = 20072, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 340, hpConstant = "1916910;1916910;1916910;1916910;1916910", attackConstant = "17465", defConstant = "5222", magicattConstant = "0", magicDefConstant = "2611", speedConstant = "30", damagereduce = "285", attackID = 0, 
skillid = {201159, 201160, 201161, 201162, 201213, 201272}
, bodytype = 1, behaviacAI = "newbattleaif420_2", defaultBuff = "20116;21761", MonsterType = 420, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66516] = {id = 66516, name = "白熊 赫沃奥塔", nameTextID = 1400015, shapeID = 20072, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 400, hpConstant = "2111850;2111850;2111850;2111850;2111850", attackConstant = "20097", defConstant = "5588", magicattConstant = "0", magicDefConstant = "2794", speedConstant = "30", damagereduce = "344", attackID = 0, 
skillid = {201159, 201160, 201161, 201162, 201213, 201272}
, bodytype = 1, behaviacAI = "newbattleaif420_2", defaultBuff = "20116;21761", MonsterType = 420, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66517] = {id = 66517, name = "白熊 赫沃奥塔", nameTextID = 1400015, shapeID = 20072, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 420, hpConstant = "2176830;2176830;2176830;2176830;2176830", attackConstant = "21010", defConstant = "5710", magicattConstant = "0", magicDefConstant = "2855", speedConstant = "30", damagereduce = "398", attackID = 0, 
skillid = {201159, 201160, 201161, 201162, 201213, 201272}
, bodytype = 1, behaviacAI = "newbattleaif420_2", defaultBuff = "20116;21761", MonsterType = 420, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66518] = {id = 66518, name = "白熊 赫沃奥塔", nameTextID = 1400015, shapeID = 20072, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 440, hpConstant = "2241810;2241810;2241810;2241810;2241810", attackConstant = "21940", defConstant = "5832", magicattConstant = "0", magicDefConstant = "2916", speedConstant = "30", damagereduce = "447", attackID = 0, 
skillid = {201159, 201160, 201161, 201162, 201213, 201272}
, bodytype = 1, behaviacAI = "newbattleaif420_2", defaultBuff = "20116;21761", MonsterType = 420, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66519] = {id = 66519, name = "白熊 赫沃奥塔", nameTextID = 1400015, shapeID = 20072, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 560, hpConstant = "2631690;2631690;2631690;2631690;2631690", attackConstant = "27889", defConstant = "6564", magicattConstant = "0", magicDefConstant = "3282", speedConstant = "30", damagereduce = "493", attackID = 0, 
skillid = {201159, 201160, 201161, 201162, 201213, 201272}
, bodytype = 1, behaviacAI = "newbattleaif420_2", defaultBuff = "20116;21761", MonsterType = 420, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66520] = {id = 66520, name = "白熊 赫沃奥塔", nameTextID = 1400015, shapeID = 20072, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 620, hpConstant = "2826630;2826630;2826630;2826630;2826630", attackConstant = "31100", defConstant = "6930", magicattConstant = "0", magicDefConstant = "3465", speedConstant = "30", damagereduce = "627", attackID = 0, 
skillid = {201159, 201160, 201161, 201162, 201213, 201272}
, bodytype = 1, behaviacAI = "newbattleaif420_2", defaultBuff = "20116;21761", MonsterType = 420, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66521] = {id = 66521, name = "白熊 赫沃奥塔", nameTextID = 1400015, shapeID = 20072, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 680, hpConstant = "3021570;3021570;3021570;3021570;3021570", attackConstant = "34470", defConstant = "7295", magicattConstant = "0", magicDefConstant = "3647", speedConstant = "30", damagereduce = "915", attackID = 0, 
skillid = {201159, 201160, 201161, 201162, 201213, 201272}
, bodytype = 1, behaviacAI = "newbattleaif420_2", defaultBuff = "20116;21761", MonsterType = 420, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66522] = {id = 66522, name = "守护者 瑟希薇", nameTextID = 1400016, shapeID = 20061, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 100, hpConstant = "393619;393619;393619;393619;393619", attackConstant = "2384", defConstant = "1776", magicattConstant = "0", magicDefConstant = "1776", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201280, 201142, 201145, 201147, 201148, 201150, 201203, 201204, 201205, 201206, 201143, 201144, 201146, 201149, 201212, 201340, 201163}
, bodytype = 1, behaviacAI = "newbattleaif421", defaultBuff = "20116;21754;21763", MonsterType = 421, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66523] = {id = 66523, name = "守护者 瑟希薇", nameTextID = 1400016, shapeID = 20061, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "418220;418220;418220;418220;418220", attackConstant = "2561", defConstant = "1829", magicattConstant = "0", magicDefConstant = "1829", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201280, 201142, 201145, 201147, 201148, 201150, 201203, 201204, 201205, 201206, 201143, 201144, 201146, 201149, 201212, 201340, 201163}
, bodytype = 1, behaviacAI = "newbattleaif421", defaultBuff = "20116;21754;21763", MonsterType = 421, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66524] = {id = 66524, name = "守护者 瑟希薇", nameTextID = 1400016, shapeID = 20061, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "442821;442821;442821;442821;442821", attackConstant = "2741", defConstant = "1882", magicattConstant = "0", magicDefConstant = "1882", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201280, 201142, 201145, 201147, 201148, 201150, 201203, 201204, 201205, 201206, 201143, 201144, 201146, 201149, 201212, 201340, 201163}
, bodytype = 1, behaviacAI = "newbattleaif421", defaultBuff = "20116;21754;21763", MonsterType = 421, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66525] = {id = 66525, name = "守护者 瑟希薇", nameTextID = 1400016, shapeID = 20061, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "767037;767037;767037;767037;767037", attackConstant = "5197", defConstant = "2728", magicattConstant = "0", magicDefConstant = "2728", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201280, 201142, 201145, 201147, 201148, 201150, 201203, 201204, 201205, 201206, 201143, 201144, 201146, 201149, 201212, 201340, 201163}
, bodytype = 1, behaviacAI = "newbattleaif421", defaultBuff = "20116;21754;21763", MonsterType = 421, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66526] = {id = 66526, name = "守护者 瑟希薇", nameTextID = 1400016, shapeID = 20061, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "795446;795446;795446;795446;795446", attackConstant = "5443", defConstant = "2785", magicattConstant = "0", magicDefConstant = "2785", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201280, 201142, 201145, 201147, 201148, 201150, 201203, 201204, 201205, 201206, 201143, 201144, 201146, 201149, 201212, 201340, 201163}
, bodytype = 1, behaviacAI = "newbattleaif421", defaultBuff = "20116;21754;21763", MonsterType = 421, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66527] = {id = 66527, name = "守护者 瑟希薇", nameTextID = 1400016, shapeID = 20061, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "823855;823855;823855;823855;823855", attackConstant = "5692", defConstant = "2842", magicattConstant = "0", magicDefConstant = "2842", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201280, 201142, 201145, 201147, 201148, 201150, 201203, 201204, 201205, 201206, 201143, 201144, 201146, 201149, 201212, 201340, 201163}
, bodytype = 1, behaviacAI = "newbattleaif421", defaultBuff = "20116;21754;21763", MonsterType = 421, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66528] = {id = 66528, name = "守护者 瑟希薇", nameTextID = 1400016, shapeID = 20061, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "937490;937490;937490;937490;937490", attackConstant = "6730", defConstant = "3070", magicattConstant = "0", magicDefConstant = "3070", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201280, 201142, 201145, 201147, 201148, 201150, 201203, 201204, 201205, 201206, 201143, 201144, 201146, 201149, 201212, 201340, 201163}
, bodytype = 1, behaviacAI = "newbattleaif421", defaultBuff = "20116;21754;21763", MonsterType = 421, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66529] = {id = 66529, name = "守护者 瑟希薇", nameTextID = 1400016, shapeID = 20061, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "1527030;1527030;1527030;1527030;1527030", attackConstant = "12675", defConstant = "4491", magicattConstant = "0", magicDefConstant = "4491", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201280, 201142, 201145, 201147, 201148, 201150, 201203, 201204, 201205, 201206, 201143, 201144, 201146, 201149, 201212, 201340, 201163}
, bodytype = 1, behaviacAI = "newbattleaif421", defaultBuff = "20116;21754;21763", MonsterType = 421, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66530] = {id = 66530, name = "守护者 瑟希薇", nameTextID = 1400016, shapeID = 20061, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "1592010;1592010;1592010;1592010;1592010", attackConstant = "13429", defConstant = "4613", magicattConstant = "0", magicDefConstant = "4613", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201280, 201142, 201145, 201147, 201148, 201150, 201203, 201204, 201205, 201206, 201143, 201144, 201146, 201149, 201212, 201340, 201163}
, bodytype = 1, behaviacAI = "newbattleaif421", defaultBuff = "20116;21754;21763", MonsterType = 421, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66531] = {id = 66531, name = "守护者 瑟希薇", nameTextID = 1400016, shapeID = 20061, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "1786950;1786950;1786950;1786950;1786950", attackConstant = "15798", defConstant = "4979", magicattConstant = "0", magicDefConstant = "4979", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201280, 201142, 201145, 201147, 201148, 201150, 201203, 201204, 201205, 201206, 201143, 201144, 201146, 201149, 201212, 201340, 201163}
, bodytype = 1, behaviacAI = "newbattleaif421", defaultBuff = "20116;21754;21763", MonsterType = 421, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66532] = {id = 66532, name = "守护者 瑟希薇", nameTextID = 1400016, shapeID = 20061, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 320, hpConstant = "1851930;1851930;1851930;1851930;1851930", attackConstant = "16623", defConstant = "5100", magicattConstant = "0", magicDefConstant = "5100", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201280, 201142, 201145, 201147, 201148, 201150, 201203, 201204, 201205, 201206, 201143, 201144, 201146, 201149, 201212, 201340, 201163}
, bodytype = 1, behaviacAI = "newbattleaif421", defaultBuff = "20116;21754;21763", MonsterType = 421, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66533] = {id = 66533, name = "守护者 瑟希薇", nameTextID = 1400016, shapeID = 20061, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 340, hpConstant = "1916910;1916910;1916910;1916910;1916910", attackConstant = "17465", defConstant = "5222", magicattConstant = "0", magicDefConstant = "5222", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201280, 201142, 201145, 201147, 201148, 201150, 201203, 201204, 201205, 201206, 201143, 201144, 201146, 201149, 201212, 201340, 201163}
, bodytype = 1, behaviacAI = "newbattleaif421", defaultBuff = "20116;21754;21763", MonsterType = 421, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66534] = {id = 66534, name = "守护者 瑟希薇", nameTextID = 1400016, shapeID = 20061, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 400, hpConstant = "2111850;2111850;2111850;2111850;2111850", attackConstant = "20097", defConstant = "5588", magicattConstant = "0", magicDefConstant = "5588", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201280, 201142, 201145, 201147, 201148, 201150, 201203, 201204, 201205, 201206, 201143, 201144, 201146, 201149, 201212, 201340, 201163}
, bodytype = 1, behaviacAI = "newbattleaif421", defaultBuff = "20116;21754;21763", MonsterType = 421, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66535] = {id = 66535, name = "守护者 瑟希薇", nameTextID = 1400016, shapeID = 20061, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 420, hpConstant = "2176830;2176830;2176830;2176830;2176830", attackConstant = "21010", defConstant = "5710", magicattConstant = "0", magicDefConstant = "5710", speedConstant = "30", damagereduce = "100", attackID = 0, 
skillid = {201280, 201142, 201145, 201147, 201148, 201150, 201203, 201204, 201205, 201206, 201143, 201144, 201146, 201149, 201212, 201340, 201163}
, bodytype = 1, behaviacAI = "newbattleaif421", defaultBuff = "20116;21754;21763", MonsterType = 421, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66536] = {id = 66536, name = "守护者 瑟希薇", nameTextID = 1400016, shapeID = 20061, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 440, hpConstant = "2241810;2241810;2241810;2241810;2241810", attackConstant = "21940", defConstant = "5832", magicattConstant = "0", magicDefConstant = "5832", speedConstant = "30", damagereduce = "171", attackID = 0, 
skillid = {201280, 201142, 201145, 201147, 201148, 201150, 201203, 201204, 201205, 201206, 201143, 201144, 201146, 201149, 201212, 201340, 201163}
, bodytype = 1, behaviacAI = "newbattleaif421", defaultBuff = "20116;21754;21763", MonsterType = 421, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66537] = {id = 66537, name = "守护者 瑟希薇", nameTextID = 1400016, shapeID = 20061, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 560, hpConstant = "2631690;2631690;2631690;2631690;2631690", attackConstant = "27889", defConstant = "6564", magicattConstant = "0", magicDefConstant = "6564", speedConstant = "30", damagereduce = "233", attackID = 0, 
skillid = {201280, 201142, 201145, 201147, 201148, 201150, 201203, 201204, 201205, 201206, 201143, 201144, 201146, 201149, 201212, 201340, 201163}
, bodytype = 1, behaviacAI = "newbattleaif421", defaultBuff = "20116;21754;21763", MonsterType = 421, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66538] = {id = 66538, name = "守护者 瑟希薇", nameTextID = 1400016, shapeID = 20061, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 620, hpConstant = "2826630;2826630;2826630;2826630;2826630", attackConstant = "31100", defConstant = "6930", magicattConstant = "0", magicDefConstant = "6930", speedConstant = "30", damagereduce = "447", attackID = 0, 
skillid = {201280, 201142, 201145, 201147, 201148, 201150, 201203, 201204, 201205, 201206, 201143, 201144, 201146, 201149, 201212, 201340, 201163}
, bodytype = 1, behaviacAI = "newbattleaif421", defaultBuff = "20116;21754;21763", MonsterType = 421, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66539] = {id = 66539, name = "守护者 瑟希薇", nameTextID = 1400016, shapeID = 20061, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 680, hpConstant = "3021570;3021570;3021570;3021570;3021570", attackConstant = "34470", defConstant = "7295", magicattConstant = "0", magicDefConstant = "7295", speedConstant = "30", damagereduce = "871", attackID = 0, 
skillid = {201280, 201142, 201145, 201147, 201148, 201150, 201203, 201204, 201205, 201206, 201143, 201144, 201146, 201149, 201212, 201340, 201163}
, bodytype = 1, behaviacAI = "newbattleaif421", defaultBuff = "20116;21754;21763", MonsterType = 421, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66540] = {id = 66540, name = "地狱之焰 辛莫拉", nameTextID = 1400036, shapeID = 10050, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 100, hpConstant = "393619;393619;393619", attackConstant = "2384", defConstant = "888", magicattConstant = "0", magicDefConstant = "1776", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201308, 201309, 201310, 201311, 201312, 201370, 201373}
, bodytype = 1, behaviacAI = "newbattleai20220_w1", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66541] = {id = 66541, name = "地狱之焰 辛莫拉", nameTextID = 1400036, shapeID = 10050, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "418220;418220;418220", attackConstant = "2561", defConstant = "914", magicattConstant = "0", magicDefConstant = "1829", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201308, 201309, 201310, 201311, 201312, 201370, 201373}
, bodytype = 1, behaviacAI = "newbattleai20220_w2", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66542] = {id = 66542, name = "地狱之焰 辛莫拉", nameTextID = 1400036, shapeID = 10050, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "442821;442821;442821", attackConstant = "2741", defConstant = "941", magicattConstant = "0", magicDefConstant = "1882", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201308, 201309, 201310, 201311, 201312, 201370, 201373}
, bodytype = 1, behaviacAI = "newbattleai20220_w3", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66543] = {id = 66543, name = "地狱之焰 辛莫拉", nameTextID = 1400036, shapeID = 10050, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "767037;767037;767037", attackConstant = "5197", defConstant = "1364", magicattConstant = "0", magicDefConstant = "2728", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201308, 201309, 201310, 201311, 201312, 201370, 201373}
, bodytype = 1, behaviacAI = "newbattleai20220_w4", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66544] = {id = 66544, name = "地狱之焰 辛莫拉", nameTextID = 1400036, shapeID = 10050, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "795446;795446;795446", attackConstant = "5443", defConstant = "1392", magicattConstant = "0", magicDefConstant = "2785", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201308, 201309, 201310, 201311, 201312, 201370, 201373}
, bodytype = 1, behaviacAI = "newbattleai20220_w5", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66545] = {id = 66545, name = "地狱之焰 辛莫拉", nameTextID = 1400036, shapeID = 10050, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "823855;823855;823855", attackConstant = "5692", defConstant = "1421", magicattConstant = "0", magicDefConstant = "2842", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201308, 201309, 201310, 201311, 201312, 201370, 201373}
, bodytype = 1, behaviacAI = "newbattleai20220_w6", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66546] = {id = 66546, name = "地狱之焰 辛莫拉", nameTextID = 1400036, shapeID = 10050, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "937490;937490;937490", attackConstant = "6730", defConstant = "1535", magicattConstant = "0", magicDefConstant = "3070", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201308, 201309, 201310, 201311, 201312, 201370, 201373}
, bodytype = 1, behaviacAI = "newbattleai20220_w7", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66547] = {id = 66547, name = "地狱之焰 辛莫拉", nameTextID = 1400036, shapeID = 10050, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "1527030;1527030;1527030", attackConstant = "12675", defConstant = "2245", magicattConstant = "0", magicDefConstant = "4491", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201308, 201309, 201310, 201311, 201312, 201370, 201373}
, bodytype = 1, behaviacAI = "newbattleai20220_w8", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66548] = {id = 66548, name = "地狱之焰 辛莫拉", nameTextID = 1400036, shapeID = 10050, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "1592010;1592010;1592010", attackConstant = "13429", defConstant = "2306", magicattConstant = "0", magicDefConstant = "4613", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201308, 201309, 201310, 201311, 201312, 201370, 201373}
, bodytype = 1, behaviacAI = "newbattleai20220_w9", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66549] = {id = 66549, name = "地狱之焰 辛莫拉", nameTextID = 1400036, shapeID = 10050, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "1786950;1786950;1786950", attackConstant = "15798", defConstant = "2489", magicattConstant = "0", magicDefConstant = "4979", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201308, 201309, 201310, 201311, 201312, 201370, 201373}
, bodytype = 1, behaviacAI = "newbattleai20220_w10", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66550] = {id = 66550, name = "地狱之焰 辛莫拉", nameTextID = 1400036, shapeID = 10050, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 320, hpConstant = "1851930;1851930;1851930", attackConstant = "16623", defConstant = "2550", magicattConstant = "0", magicDefConstant = "5100", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201308, 201309, 201310, 201311, 201312, 201370, 201373}
, bodytype = 1, behaviacAI = "newbattleai20220_w11", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66551] = {id = 66551, name = "地狱之焰 辛莫拉", nameTextID = 1400036, shapeID = 10050, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 340, hpConstant = "1916910;1916910;1916910", attackConstant = "17465", defConstant = "2611", magicattConstant = "0", magicDefConstant = "5222", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201308, 201309, 201310, 201311, 201312, 201370, 201373}
, bodytype = 1, behaviacAI = "newbattleai20220_w12", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66552] = {id = 66552, name = "地狱之焰 辛莫拉", nameTextID = 1400036, shapeID = 10050, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 400, hpConstant = "2111850;2111850;2111850", attackConstant = "20097", defConstant = "2794", magicattConstant = "0", magicDefConstant = "5588", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201308, 201309, 201310, 201311, 201312, 201370, 201373}
, bodytype = 1, behaviacAI = "newbattleai20220_w13", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66553] = {id = 66553, name = "地狱之焰 辛莫拉", nameTextID = 1400036, shapeID = 10050, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 420, hpConstant = "2176830;2176830;2176830", attackConstant = "21010", defConstant = "2855", magicattConstant = "0", magicDefConstant = "5710", speedConstant = "30", damagereduce = "100", attackID = 0, 
skillid = {201308, 201309, 201310, 201311, 201312, 201370, 201373}
, bodytype = 1, behaviacAI = "newbattleai20220_w14", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66554] = {id = 66554, name = "地狱之焰 辛莫拉", nameTextID = 1400036, shapeID = 10050, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 440, hpConstant = "2241810;2241810;2241810", attackConstant = "21940", defConstant = "2916", magicattConstant = "0", magicDefConstant = "5832", speedConstant = "30", damagereduce = "171", attackID = 0, 
skillid = {201308, 201309, 201310, 201311, 201312, 201370, 201373}
, bodytype = 1, behaviacAI = "newbattleai20220_w15", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66555] = {id = 66555, name = "地狱之焰 辛莫拉", nameTextID = 1400036, shapeID = 10050, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 560, hpConstant = "2631690;2631690;2631690", attackConstant = "27889", defConstant = "3282", magicattConstant = "0", magicDefConstant = "6564", speedConstant = "30", damagereduce = "233", attackID = 0, 
skillid = {201308, 201309, 201310, 201311, 201312, 201370, 201373}
, bodytype = 1, behaviacAI = "newbattleai20220_w16", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66556] = {id = 66556, name = "地狱之焰 辛莫拉", nameTextID = 1400036, shapeID = 10050, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 620, hpConstant = "2826630;2826630;2826630", attackConstant = "31100", defConstant = "3465", magicattConstant = "0", magicDefConstant = "6930", speedConstant = "30", damagereduce = "447", attackID = 0, 
skillid = {201308, 201309, 201310, 201311, 201312, 201370, 201373}
, bodytype = 1, behaviacAI = "newbattleai20220_w17", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66557] = {id = 66557, name = "地狱之焰 辛莫拉", nameTextID = 1400036, shapeID = 10050, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 680, hpConstant = "3021570;3021570;3021570", attackConstant = "34470", defConstant = "3647", magicattConstant = "0", magicDefConstant = "7295", speedConstant = "30", damagereduce = "871", attackID = 0, 
skillid = {201308, 201309, 201310, 201311, 201312, 201370, 201373}
, bodytype = 1, behaviacAI = "newbattleai20220_w18", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66558] = {id = 66558, name = "地狱之焰 辛莫拉-2阶段", nameTextID = 1400036, shapeID = 10048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 100, hpConstant = "393619;393619;393619", attackConstant = "2384", defConstant = "888", magicattConstant = "0", magicDefConstant = "1776", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201313, 201314, 201315, 201316, 201317, 201318, 201319, 201370, 201371, 201374}
, bodytype = 1, behaviacAI = "newbattleai20218", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66559] = {id = 66559, name = "地狱之焰 辛莫拉-2阶段", nameTextID = 1400036, shapeID = 10048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "418220;418220;418220", attackConstant = "2561", defConstant = "914", magicattConstant = "0", magicDefConstant = "1829", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201313, 201314, 201315, 201316, 201317, 201318, 201319, 201370, 201371, 201374}
, bodytype = 1, behaviacAI = "newbattleai20218", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66560] = {id = 66560, name = "地狱之焰 辛莫拉-2阶段", nameTextID = 1400036, shapeID = 10048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "442821;442821;442821", attackConstant = "2741", defConstant = "941", magicattConstant = "0", magicDefConstant = "1882", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201313, 201314, 201315, 201316, 201317, 201318, 201319, 201370, 201371, 201374}
, bodytype = 1, behaviacAI = "newbattleai20218", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66561] = {id = 66561, name = "地狱之焰 辛莫拉-2阶段", nameTextID = 1400036, shapeID = 10048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "767037;767037;767037", attackConstant = "5197", defConstant = "1364", magicattConstant = "0", magicDefConstant = "2728", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201313, 201314, 201315, 201316, 201317, 201318, 201319, 201370, 201371, 201374}
, bodytype = 1, behaviacAI = "newbattleai20218", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66562] = {id = 66562, name = "地狱之焰 辛莫拉-2阶段", nameTextID = 1400036, shapeID = 10048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "795446;795446;795446", attackConstant = "5443", defConstant = "1392", magicattConstant = "0", magicDefConstant = "2785", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201313, 201314, 201315, 201316, 201317, 201318, 201319, 201370, 201371, 201374}
, bodytype = 1, behaviacAI = "newbattleai20218", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66563] = {id = 66563, name = "地狱之焰 辛莫拉-2阶段", nameTextID = 1400036, shapeID = 10048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "823855;823855;823855", attackConstant = "5692", defConstant = "1421", magicattConstant = "0", magicDefConstant = "2842", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201313, 201314, 201315, 201316, 201317, 201318, 201319, 201370, 201371, 201374}
, bodytype = 1, behaviacAI = "newbattleai20218", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66564] = {id = 66564, name = "地狱之焰 辛莫拉-2阶段", nameTextID = 1400036, shapeID = 10048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "937490;937490;937490", attackConstant = "6730", defConstant = "1535", magicattConstant = "0", magicDefConstant = "3070", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201313, 201314, 201315, 201316, 201317, 201318, 201319, 201370, 201371, 201374}
, bodytype = 1, behaviacAI = "newbattleai20218", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66565] = {id = 66565, name = "地狱之焰 辛莫拉-2阶段", nameTextID = 1400036, shapeID = 10048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "1527030;1527030;1527030", attackConstant = "12675", defConstant = "2245", magicattConstant = "0", magicDefConstant = "4491", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201313, 201314, 201315, 201316, 201317, 201318, 201319, 201370, 201371, 201374}
, bodytype = 1, behaviacAI = "newbattleai20218", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66566] = {id = 66566, name = "地狱之焰 辛莫拉-2阶段", nameTextID = 1400036, shapeID = 10048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "1592010;1592010;1592010", attackConstant = "13429", defConstant = "2306", magicattConstant = "0", magicDefConstant = "4613", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201313, 201314, 201315, 201316, 201317, 201318, 201319, 201370, 201371, 201374}
, bodytype = 1, behaviacAI = "newbattleai20218", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66567] = {id = 66567, name = "地狱之焰 辛莫拉-2阶段", nameTextID = 1400036, shapeID = 10048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "1786950;1786950;1786950", attackConstant = "15798", defConstant = "2489", magicattConstant = "0", magicDefConstant = "4979", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201313, 201314, 201315, 201316, 201317, 201318, 201319, 201370, 201371, 201374}
, bodytype = 1, behaviacAI = "newbattleai20218", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66568] = {id = 66568, name = "地狱之焰 辛莫拉-2阶段", nameTextID = 1400036, shapeID = 10048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 320, hpConstant = "1851930;1851930;1851930", attackConstant = "16623", defConstant = "2550", magicattConstant = "0", magicDefConstant = "5100", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201313, 201314, 201315, 201316, 201317, 201318, 201319, 201370, 201371, 201374}
, bodytype = 1, behaviacAI = "newbattleai20218", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66569] = {id = 66569, name = "地狱之焰 辛莫拉-2阶段", nameTextID = 1400036, shapeID = 10048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 340, hpConstant = "1916910;1916910;1916910", attackConstant = "17465", defConstant = "2611", magicattConstant = "0", magicDefConstant = "5222", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201313, 201314, 201315, 201316, 201317, 201318, 201319, 201370, 201371, 201374}
, bodytype = 1, behaviacAI = "newbattleai20218", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66570] = {id = 66570, name = "地狱之焰 辛莫拉-2阶段", nameTextID = 1400036, shapeID = 10048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 400, hpConstant = "2111850;2111850;2111850", attackConstant = "20097", defConstant = "2794", magicattConstant = "0", magicDefConstant = "5588", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201313, 201314, 201315, 201316, 201317, 201318, 201319, 201370, 201371, 201374}
, bodytype = 1, behaviacAI = "newbattleai20218", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66571] = {id = 66571, name = "地狱之焰 辛莫拉-2阶段", nameTextID = 1400036, shapeID = 10048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 420, hpConstant = "2176830;2176830;2176830", attackConstant = "21010", defConstant = "2855", magicattConstant = "0", magicDefConstant = "5710", speedConstant = "30", damagereduce = "100", attackID = 0, 
skillid = {201313, 201314, 201315, 201316, 201317, 201318, 201319, 201370, 201371, 201374}
, bodytype = 1, behaviacAI = "newbattleai20218", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66572] = {id = 66572, name = "地狱之焰 辛莫拉-2阶段", nameTextID = 1400036, shapeID = 10048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 440, hpConstant = "2241810;2241810;2241810", attackConstant = "21940", defConstant = "2916", magicattConstant = "0", magicDefConstant = "5832", speedConstant = "30", damagereduce = "171", attackID = 0, 
skillid = {201313, 201314, 201315, 201316, 201317, 201318, 201319, 201370, 201371, 201374}
, bodytype = 1, behaviacAI = "newbattleai20218", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66573] = {id = 66573, name = "地狱之焰 辛莫拉-2阶段", nameTextID = 1400036, shapeID = 10048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 560, hpConstant = "2631690;2631690;2631690", attackConstant = "27889", defConstant = "3282", magicattConstant = "0", magicDefConstant = "6564", speedConstant = "30", damagereduce = "233", attackID = 0, 
skillid = {201313, 201314, 201315, 201316, 201317, 201318, 201319, 201370, 201371, 201374}
, bodytype = 1, behaviacAI = "newbattleai20218", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66574] = {id = 66574, name = "地狱之焰 辛莫拉-2阶段", nameTextID = 1400036, shapeID = 10048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 620, hpConstant = "2826630;2826630;2826630", attackConstant = "31100", defConstant = "3465", magicattConstant = "0", magicDefConstant = "6930", speedConstant = "30", damagereduce = "447", attackID = 0, 
skillid = {201313, 201314, 201315, 201316, 201317, 201318, 201319, 201370, 201371, 201374}
, bodytype = 1, behaviacAI = "newbattleai20218", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66575] = {id = 66575, name = "地狱之焰 辛莫拉-2阶段", nameTextID = 1400036, shapeID = 10048, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 680, hpConstant = "3021570;3021570;3021570", attackConstant = "34470", defConstant = "3647", magicattConstant = "0", magicDefConstant = "7295", speedConstant = "30", damagereduce = "871", attackID = 0, 
skillid = {201313, 201314, 201315, 201316, 201317, 201318, 201319, 201370, 201371, 201374}
, bodytype = 1, behaviacAI = "newbattleai20218", defaultBuff = "20116;21761", MonsterType = 610, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66576] = {id = 66576, name = "天空主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20129, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 100, hpConstant = "393619;393619", attackConstant = "2384", defConstant = "1776", magicattConstant = "0", magicDefConstant = "1776", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201566, 201567, 201568, 201569}
, bodytype = 1, behaviacAI = "newbattleaif818_tail_w1", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66577] = {id = 66577, name = "天空主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20129, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "418220;418220", attackConstant = "2561", defConstant = "1829", magicattConstant = "0", magicDefConstant = "1829", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201566, 201567, 201568, 201569}
, bodytype = 1, behaviacAI = "newbattleaif818_tail_w2", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66578] = {id = 66578, name = "天空主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20129, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "442821;442821", attackConstant = "2741", defConstant = "1882", magicattConstant = "0", magicDefConstant = "1882", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201566, 201567, 201568, 201569}
, bodytype = 1, behaviacAI = "newbattleaif818_tail_w3", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66579] = {id = 66579, name = "天空主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20129, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "767037;767037", attackConstant = "5197", defConstant = "2728", magicattConstant = "0", magicDefConstant = "2728", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201566, 201567, 201568, 201569}
, bodytype = 1, behaviacAI = "newbattleaif818_tail_w4", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66580] = {id = 66580, name = "天空主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20129, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "795446;795446", attackConstant = "5443", defConstant = "2785", magicattConstant = "0", magicDefConstant = "2785", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201566, 201567, 201568, 201569}
, bodytype = 1, behaviacAI = "newbattleaif818_tail_w5", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66581] = {id = 66581, name = "天空主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20129, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "823855;823855", attackConstant = "5692", defConstant = "2842", magicattConstant = "0", magicDefConstant = "2842", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201566, 201567, 201568, 201569}
, bodytype = 1, behaviacAI = "newbattleaif818_tail_w6", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66582] = {id = 66582, name = "天空主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20129, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "937490;937490", attackConstant = "6730", defConstant = "3070", magicattConstant = "0", magicDefConstant = "3070", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201566, 201567, 201568, 201569}
, bodytype = 1, behaviacAI = "newbattleaif818_tail_w7", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66583] = {id = 66583, name = "天空主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20129, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "1527030;1527030", attackConstant = "12675", defConstant = "4491", magicattConstant = "0", magicDefConstant = "4491", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201566, 201567, 201568, 201569}
, bodytype = 1, behaviacAI = "newbattleaif818_tail_w8", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66584] = {id = 66584, name = "天空主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20129, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "1592010;1592010", attackConstant = "13429", defConstant = "4613", magicattConstant = "0", magicDefConstant = "4613", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201566, 201567, 201568, 201569}
, bodytype = 1, behaviacAI = "newbattleaif818_tail_w9", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66585] = {id = 66585, name = "天空主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20129, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "1786950;1786950", attackConstant = "15798", defConstant = "4979", magicattConstant = "0", magicDefConstant = "4979", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201566, 201567, 201568, 201569}
, bodytype = 1, behaviacAI = "newbattleaif818_tail_w10", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66586] = {id = 66586, name = "天空主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20129, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 320, hpConstant = "1851930;1851930", attackConstant = "16623", defConstant = "5100", magicattConstant = "0", magicDefConstant = "5100", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201566, 201567, 201568, 201569}
, bodytype = 1, behaviacAI = "newbattleaif818_tail_w11", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66587] = {id = 66587, name = "天空主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20129, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 340, hpConstant = "1916910;1916910", attackConstant = "17465", defConstant = "5222", magicattConstant = "0", magicDefConstant = "5222", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201566, 201567, 201568, 201569}
, bodytype = 1, behaviacAI = "newbattleaif818_tail_w12", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66588] = {id = 66588, name = "天空主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20129, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 400, hpConstant = "2111850;2111850", attackConstant = "20097", defConstant = "5588", magicattConstant = "0", magicDefConstant = "5588", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201566, 201567, 201568, 201569}
, bodytype = 1, behaviacAI = "newbattleaif818_tail_w13", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66589] = {id = 66589, name = "天空主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20129, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 420, hpConstant = "2176830;2176830", attackConstant = "21010", defConstant = "5710", magicattConstant = "0", magicDefConstant = "5710", speedConstant = "30", damagereduce = "100", attackID = 0, 
skillid = {201566, 201567, 201568, 201569}
, bodytype = 1, behaviacAI = "newbattleaif818_tail_w14", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66590] = {id = 66590, name = "天空主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20129, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 440, hpConstant = "2241810;2241810", attackConstant = "21940", defConstant = "5832", magicattConstant = "0", magicDefConstant = "5832", speedConstant = "30", damagereduce = "171", attackID = 0, 
skillid = {201566, 201567, 201568, 201569}
, bodytype = 1, behaviacAI = "newbattleaif818_tail_w15", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66591] = {id = 66591, name = "天空主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20129, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 560, hpConstant = "2631690;2631690", attackConstant = "27889", defConstant = "6564", magicattConstant = "0", magicDefConstant = "6564", speedConstant = "30", damagereduce = "233", attackID = 0, 
skillid = {201566, 201567, 201568, 201569}
, bodytype = 1, behaviacAI = "newbattleaif818_tail_w16", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66592] = {id = 66592, name = "天空主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20129, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 620, hpConstant = "2826630;2826630", attackConstant = "31100", defConstant = "6930", magicattConstant = "0", magicDefConstant = "6930", speedConstant = "30", damagereduce = "447", attackID = 0, 
skillid = {201566, 201567, 201568, 201569}
, bodytype = 1, behaviacAI = "newbattleaif818_tail_w17", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66593] = {id = 66593, name = "天空主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20129, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 680, hpConstant = "3021570;3021570", attackConstant = "34470", defConstant = "7295", magicattConstant = "0", magicDefConstant = "7295", speedConstant = "30", damagereduce = "871", attackID = 0, 
skillid = {201566, 201567, 201568, 201569}
, bodytype = 1, behaviacAI = "newbattleaif818_tail_w18", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66594] = {id = 66594, name = "索拉迪乌斯-2阶段", nameTextID = 1400145, shapeID = 20130, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 100, hpConstant = "393619;393619", attackConstant = "2384", defConstant = "1776", magicattConstant = "0", magicDefConstant = "1776", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201570, 201571, 201572, 201573, 201574, 201575}
, bodytype = 1, behaviacAI = "newbattleaif818_body_w1", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66595] = {id = 66595, name = "索拉迪乌斯-2阶段", nameTextID = 1400145, shapeID = 20130, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "418220;418220", attackConstant = "2561", defConstant = "1829", magicattConstant = "0", magicDefConstant = "1829", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201570, 201571, 201572, 201573, 201574, 201575}
, bodytype = 1, behaviacAI = "newbattleaif818_body_w2", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66596] = {id = 66596, name = "索拉迪乌斯-2阶段", nameTextID = 1400145, shapeID = 20130, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "442821;442821", attackConstant = "2741", defConstant = "1882", magicattConstant = "0", magicDefConstant = "1882", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201570, 201571, 201572, 201573, 201574, 201575}
, bodytype = 1, behaviacAI = "newbattleaif818_body_w3", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66597] = {id = 66597, name = "索拉迪乌斯-2阶段", nameTextID = 1400145, shapeID = 20130, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "767037;767037", attackConstant = "5197", defConstant = "2728", magicattConstant = "0", magicDefConstant = "2728", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201570, 201571, 201572, 201573, 201574, 201575}
, bodytype = 1, behaviacAI = "newbattleaif818_body_w4", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66598] = {id = 66598, name = "索拉迪乌斯-2阶段", nameTextID = 1400145, shapeID = 20130, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "795446;795446", attackConstant = "5443", defConstant = "2785", magicattConstant = "0", magicDefConstant = "2785", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201570, 201571, 201572, 201573, 201574, 201575}
, bodytype = 1, behaviacAI = "newbattleaif818_body_w5", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66599] = {id = 66599, name = "索拉迪乌斯-2阶段", nameTextID = 1400145, shapeID = 20130, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "823855;823855", attackConstant = "5692", defConstant = "2842", magicattConstant = "0", magicDefConstant = "2842", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201570, 201571, 201572, 201573, 201574, 201575}
, bodytype = 1, behaviacAI = "newbattleaif818_body_w6", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66600] = {id = 66600, name = "索拉迪乌斯-2阶段", nameTextID = 1400145, shapeID = 20130, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "937490;937490", attackConstant = "6730", defConstant = "3070", magicattConstant = "0", magicDefConstant = "3070", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201570, 201571, 201572, 201573, 201574, 201575}
, bodytype = 1, behaviacAI = "newbattleaif818_body_w7", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66601] = {id = 66601, name = "索拉迪乌斯-2阶段", nameTextID = 1400145, shapeID = 20130, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "1527030;1527030", attackConstant = "12675", defConstant = "4491", magicattConstant = "0", magicDefConstant = "4491", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201570, 201571, 201572, 201573, 201574, 201575}
, bodytype = 1, behaviacAI = "newbattleaif818_body_w8", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66602] = {id = 66602, name = "索拉迪乌斯-2阶段", nameTextID = 1400145, shapeID = 20130, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "1592010;1592010", attackConstant = "13429", defConstant = "4613", magicattConstant = "0", magicDefConstant = "4613", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201570, 201571, 201572, 201573, 201574, 201575}
, bodytype = 1, behaviacAI = "newbattleaif818_body_w9", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66603] = {id = 66603, name = "索拉迪乌斯-2阶段", nameTextID = 1400145, shapeID = 20130, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "1786950;1786950", attackConstant = "15798", defConstant = "4979", magicattConstant = "0", magicDefConstant = "4979", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201570, 201571, 201572, 201573, 201574, 201575}
, bodytype = 1, behaviacAI = "newbattleaif818_body_w10", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66604] = {id = 66604, name = "索拉迪乌斯-2阶段", nameTextID = 1400145, shapeID = 20130, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 320, hpConstant = "1851930;1851930", attackConstant = "16623", defConstant = "5100", magicattConstant = "0", magicDefConstant = "5100", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201570, 201571, 201572, 201573, 201574, 201575}
, bodytype = 1, behaviacAI = "newbattleaif818_body_w11", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66605] = {id = 66605, name = "索拉迪乌斯-2阶段", nameTextID = 1400145, shapeID = 20130, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 340, hpConstant = "1916910;1916910", attackConstant = "17465", defConstant = "5222", magicattConstant = "0", magicDefConstant = "5222", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201570, 201571, 201572, 201573, 201574, 201575}
, bodytype = 1, behaviacAI = "newbattleaif818_body_w12", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66606] = {id = 66606, name = "索拉迪乌斯-2阶段", nameTextID = 1400145, shapeID = 20130, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 400, hpConstant = "2111850;2111850", attackConstant = "20097", defConstant = "5588", magicattConstant = "0", magicDefConstant = "5588", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201570, 201571, 201572, 201573, 201574, 201575}
, bodytype = 1, behaviacAI = "newbattleaif818_body_w13", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66607] = {id = 66607, name = "索拉迪乌斯-2阶段", nameTextID = 1400145, shapeID = 20130, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 420, hpConstant = "2176830;2176830", attackConstant = "21010", defConstant = "5710", magicattConstant = "0", magicDefConstant = "5710", speedConstant = "30", damagereduce = "100", attackID = 0, 
skillid = {201570, 201571, 201572, 201573, 201574, 201575}
, bodytype = 1, behaviacAI = "newbattleaif818_body_w14", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66608] = {id = 66608, name = "索拉迪乌斯-2阶段", nameTextID = 1400145, shapeID = 20130, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 440, hpConstant = "2241810;2241810", attackConstant = "21940", defConstant = "5832", magicattConstant = "0", magicDefConstant = "5832", speedConstant = "30", damagereduce = "171", attackID = 0, 
skillid = {201570, 201571, 201572, 201573, 201574, 201575}
, bodytype = 1, behaviacAI = "newbattleaif818_body_w15", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66609] = {id = 66609, name = "索拉迪乌斯-2阶段", nameTextID = 1400145, shapeID = 20130, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 560, hpConstant = "2631690;2631690", attackConstant = "27889", defConstant = "6564", magicattConstant = "0", magicDefConstant = "6564", speedConstant = "30", damagereduce = "233", attackID = 0, 
skillid = {201570, 201571, 201572, 201573, 201574, 201575}
, bodytype = 1, behaviacAI = "newbattleaif818_body_w16", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66610] = {id = 66610, name = "索拉迪乌斯-2阶段", nameTextID = 1400145, shapeID = 20130, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 620, hpConstant = "2826630;2826630", attackConstant = "31100", defConstant = "6930", magicattConstant = "0", magicDefConstant = "6930", speedConstant = "30", damagereduce = "447", attackID = 0, 
skillid = {201570, 201571, 201572, 201573, 201574, 201575}
, bodytype = 1, behaviacAI = "newbattleaif818_body_w17", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66611] = {id = 66611, name = "索拉迪乌斯-2阶段", nameTextID = 1400145, shapeID = 20130, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 680, hpConstant = "3021570;3021570", attackConstant = "34470", defConstant = "7295", magicattConstant = "0", magicDefConstant = "7295", speedConstant = "30", damagereduce = "871", attackID = 0, 
skillid = {201570, 201571, 201572, 201573, 201574, 201575}
, bodytype = 1, behaviacAI = "newbattleaif818_body_w18", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66612] = {id = 66612, name = "索拉迪乌斯-3阶段", nameTextID = 1400145, shapeID = 20131, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 100, hpConstant = "393619;393619", attackConstant = "2384", defConstant = "1776", magicattConstant = "0", magicDefConstant = "1776", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201576, 201577, 201578, 201579, 201580, 201581, 201582}
, bodytype = 1, behaviacAI = "newbattleaif818_head_TZ", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66613] = {id = 66613, name = "索拉迪乌斯-3阶段", nameTextID = 1400145, shapeID = 20131, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "418220;418220", attackConstant = "2561", defConstant = "1829", magicattConstant = "0", magicDefConstant = "1829", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201576, 201577, 201578, 201579, 201580, 201581, 201582}
, bodytype = 1, behaviacAI = "newbattleaif818_head_TZ", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66614] = {id = 66614, name = "索拉迪乌斯-3阶段", nameTextID = 1400145, shapeID = 20131, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "442821;442821", attackConstant = "2741", defConstant = "1882", magicattConstant = "0", magicDefConstant = "1882", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201576, 201577, 201578, 201579, 201580, 201581, 201582}
, bodytype = 1, behaviacAI = "newbattleaif818_head_TZ", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66615] = {id = 66615, name = "索拉迪乌斯-3阶段", nameTextID = 1400145, shapeID = 20131, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "767037;767037", attackConstant = "5197", defConstant = "2728", magicattConstant = "0", magicDefConstant = "2728", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201576, 201577, 201578, 201579, 201580, 201581, 201582}
, bodytype = 1, behaviacAI = "newbattleaif818_head_TZ", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66616] = {id = 66616, name = "索拉迪乌斯-3阶段", nameTextID = 1400145, shapeID = 20131, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "795446;795446", attackConstant = "5443", defConstant = "2785", magicattConstant = "0", magicDefConstant = "2785", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201576, 201577, 201578, 201579, 201580, 201581, 201582}
, bodytype = 1, behaviacAI = "newbattleaif818_head_TZ", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66617] = {id = 66617, name = "索拉迪乌斯-3阶段", nameTextID = 1400145, shapeID = 20131, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "823855;823855", attackConstant = "5692", defConstant = "2842", magicattConstant = "0", magicDefConstant = "2842", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201576, 201577, 201578, 201579, 201580, 201581, 201582}
, bodytype = 1, behaviacAI = "newbattleaif818_head_TZ", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66618] = {id = 66618, name = "索拉迪乌斯-3阶段", nameTextID = 1400145, shapeID = 20131, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "937490;937490", attackConstant = "6730", defConstant = "3070", magicattConstant = "0", magicDefConstant = "3070", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201576, 201577, 201578, 201579, 201580, 201581, 201582}
, bodytype = 1, behaviacAI = "newbattleaif818_head_TZ", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66619] = {id = 66619, name = "索拉迪乌斯-3阶段", nameTextID = 1400145, shapeID = 20131, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "1527030;1527030", attackConstant = "12675", defConstant = "4491", magicattConstant = "0", magicDefConstant = "4491", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201576, 201577, 201578, 201579, 201580, 201581, 201582}
, bodytype = 1, behaviacAI = "newbattleaif818_head_TZ", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66620] = {id = 66620, name = "索拉迪乌斯-3阶段", nameTextID = 1400145, shapeID = 20131, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "1592010;1592010", attackConstant = "13429", defConstant = "4613", magicattConstant = "0", magicDefConstant = "4613", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201576, 201577, 201578, 201579, 201580, 201581, 201582}
, bodytype = 1, behaviacAI = "newbattleaif818_head_TZ", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66621] = {id = 66621, name = "索拉迪乌斯-3阶段", nameTextID = 1400145, shapeID = 20131, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "1786950;1786950", attackConstant = "15798", defConstant = "4979", magicattConstant = "0", magicDefConstant = "4979", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201576, 201577, 201578, 201579, 201580, 201581, 201582}
, bodytype = 1, behaviacAI = "newbattleaif818_head_TZ", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66622] = {id = 66622, name = "索拉迪乌斯-3阶段", nameTextID = 1400145, shapeID = 20131, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 320, hpConstant = "1851930;1851930", attackConstant = "16623", defConstant = "5100", magicattConstant = "0", magicDefConstant = "5100", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201576, 201577, 201578, 201579, 201580, 201581, 201582}
, bodytype = 1, behaviacAI = "newbattleaif818_head_TZ", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66623] = {id = 66623, name = "索拉迪乌斯-3阶段", nameTextID = 1400145, shapeID = 20131, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 340, hpConstant = "1916910;1916910", attackConstant = "17465", defConstant = "5222", magicattConstant = "0", magicDefConstant = "5222", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201576, 201577, 201578, 201579, 201580, 201581, 201582}
, bodytype = 1, behaviacAI = "newbattleaif818_head_TZ", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66624] = {id = 66624, name = "索拉迪乌斯-3阶段", nameTextID = 1400145, shapeID = 20131, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 400, hpConstant = "2111850;2111850", attackConstant = "20097", defConstant = "5588", magicattConstant = "0", magicDefConstant = "5588", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201576, 201577, 201578, 201579, 201580, 201581, 201582}
, bodytype = 1, behaviacAI = "newbattleaif818_head_TZ", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66625] = {id = 66625, name = "索拉迪乌斯-3阶段", nameTextID = 1400145, shapeID = 20131, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 420, hpConstant = "2176830;2176830", attackConstant = "21010", defConstant = "5710", magicattConstant = "0", magicDefConstant = "5710", speedConstant = "30", damagereduce = "100", attackID = 0, 
skillid = {201576, 201577, 201578, 201579, 201580, 201581, 201582}
, bodytype = 1, behaviacAI = "newbattleaif818_head_TZ", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66626] = {id = 66626, name = "索拉迪乌斯-3阶段", nameTextID = 1400145, shapeID = 20131, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 440, hpConstant = "2241810;2241810", attackConstant = "21940", defConstant = "5832", magicattConstant = "0", magicDefConstant = "5832", speedConstant = "30", damagereduce = "171", attackID = 0, 
skillid = {201576, 201577, 201578, 201579, 201580, 201581, 201582}
, bodytype = 1, behaviacAI = "newbattleaif818_head_TZ", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66627] = {id = 66627, name = "索拉迪乌斯-3阶段", nameTextID = 1400145, shapeID = 20131, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 560, hpConstant = "2631690;2631690", attackConstant = "27889", defConstant = "6564", magicattConstant = "0", magicDefConstant = "6564", speedConstant = "30", damagereduce = "233", attackID = 0, 
skillid = {201576, 201577, 201578, 201579, 201580, 201581, 201582}
, bodytype = 1, behaviacAI = "newbattleaif818_head_TZ", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66628] = {id = 66628, name = "索拉迪乌斯-3阶段", nameTextID = 1400145, shapeID = 20131, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 620, hpConstant = "2826630;2826630", attackConstant = "31100", defConstant = "6930", magicattConstant = "0", magicDefConstant = "6930", speedConstant = "30", damagereduce = "447", attackID = 0, 
skillid = {201576, 201577, 201578, 201579, 201580, 201581, 201582}
, bodytype = 1, behaviacAI = "newbattleaif818_head_TZ", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[66629] = {id = 66629, name = "索拉迪乌斯-3阶段", nameTextID = 1400145, shapeID = 20131, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 680, hpConstant = "3021570;3021570", attackConstant = "34470", defConstant = "7295", magicattConstant = "0", magicDefConstant = "7295", speedConstant = "30", damagereduce = "871", attackID = 0, 
skillid = {201576, 201577, 201578, 201579, 201580, 201581, 201582}
, bodytype = 1, behaviacAI = "newbattleaif818_head_TZ", defaultBuff = "20116;21755;21756", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67001] = {id = 67001, name = "云蛾野望", nameTextID = 1400238, shapeID = 20214, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "2471565;2471565;2471565;2471565;2471565", attackConstant = "5692", defConstant = "1421", magicattConstant = "0", magicDefConstant = "2842", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201794, 201795, 201796, 201797, 201798, 201799}
, bodytype = 1, behaviacAI = "NewBattlebossW6_3", defaultBuff = "20116", MonsterType = 12001, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67002] = {id = 67002, name = "云蛾野望", nameTextID = 1400238, shapeID = 20214, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "4873500;4873500;4873500;4873500;4873500", attackConstant = "13813", defConstant = "2306", magicattConstant = "0", magicDefConstant = "4613", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201794, 201795, 201796, 201797, 201798, 201799}
, bodytype = 1, behaviacAI = "NewBattlebossW6_3", defaultBuff = "20116", MonsterType = 12001, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67003] = {id = 67003, name = "云蛾野望", nameTextID = 1400238, shapeID = 20214, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 160, hpConstant = "823855+(lv-160)*5465;823855+(lv-160)*5465;823855+(lv-160)*5465;823855+(lv-160)*5465;823855+(lv-160)*5465", attackConstant = "5692+(lv-160)*71", defConstant = "1421", magicattConstant = "0", magicDefConstant = "2842", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201794, 201795, 201796, 201797, 201798, 201799}
, bodytype = 1, behaviacAI = "NewBattlebossW6_3", defaultBuff = "20116", MonsterType = 12001, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67004] = {id = 67004, name = "云蛾野望", nameTextID = 1400238, shapeID = 20214, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 250, hpConstant = "1624500+(lv-250)*2924;1624500+(lv-250)*2924;1624500+(lv-250)*2924;1624500+(lv-250)*2924;1624500+(lv-250)*2924", attackConstant = "13813+(lv-250)*33", defConstant = "2306", magicattConstant = "0", magicDefConstant = "4613", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201794, 201795, 201796, 201797, 201798, 201799}
, bodytype = 1, behaviacAI = "NewBattlebossW6_3", defaultBuff = "20116", MonsterType = 12001, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67011] = {id = 67011, name = "伞菇", nameTextID = 1400055, shapeID = 20010, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 80, hpConstant = "50068", attackConstant = "1033", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201024, 201158}
, bodytype = 1, behaviacAI = "newbattleaif210", defaultBuff = "", MonsterType = 210, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67012] = {id = 67012, name = "小史莱姆", nameTextID = 1400056, shapeID = 20053, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 80, hpConstant = "21457", attackConstant = "516", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201074}
, bodytype = 1, behaviacAI = "newbattleaif214", defaultBuff = "", MonsterType = 214, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67013] = {id = 67013, name = "松果球", nameTextID = 1400057, shapeID = 20054, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "22990", attackConstant = "558", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201069, 201070, 201071}
, bodytype = 1, behaviacAI = "newbattleaif218", defaultBuff = "", MonsterType = 218, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67014] = {id = 67014, name = "连射藤蔓", nameTextID = 1400040, shapeID = 20012, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 100, hpConstant = "72508", attackConstant = "1201", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201022, 201065}
, bodytype = 1, behaviacAI = "newbattleaif206", defaultBuff = "", MonsterType = 206, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67015] = {id = 67015, name = "独角仙", nameTextID = 1400061, shapeID = 20055, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "65484", attackConstant = "1287", defConstant = "333", magicattConstant = "0", magicDefConstant = "333", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201072, 201073}
, bodytype = 1, behaviacAI = "newbattleaif219", defaultBuff = "", MonsterType = 219, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67016] = {id = 67016, name = "幽灵螳螂", nameTextID = 1400013, shapeID = 20032, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "349596", attackConstant = "2736", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201053, 201054, 201055}
, bodytype = 1, behaviacAI = "newbattleaif222", defaultBuff = "20116", MonsterType = 222, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67017] = {id = 67017, name = "兰花螳螂", nameTextID = 1400012, shapeID = 20031, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 130, hpConstant = "369018", attackConstant = "2918", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201050, 201051, 201052}
, bodytype = 1, behaviacAI = "newbattleaif221", defaultBuff = "20116", MonsterType = 221, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67018] = {id = 67018, name = "石巨人", nameTextID = 1400008, shapeID = 10043, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "605556", attackConstant = "6741", defConstant = "1000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201027, 201028, 201029, 201037, 201059}
, bodytype = 1, behaviacAI = "newbattleaif220", defaultBuff = "20116", MonsterType = 220, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67021] = {id = 67021, name = "伞菇", nameTextID = 1400055, shapeID = 20010, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "156996", attackConstant = "2876", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201024, 201158}
, bodytype = 1, behaviacAI = "newbattleaif210", defaultBuff = "", MonsterType = 210, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67022] = {id = 67022, name = "小史莱姆", nameTextID = 1400056, shapeID = 20053, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "67284", attackConstant = "1438", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201074}
, bodytype = 1, behaviacAI = "newbattleaif214", defaultBuff = "", MonsterType = 214, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67023] = {id = 67023, name = "松果球", nameTextID = 1400057, shapeID = 20054, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "69526", attackConstant = "1497", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201069, 201070, 201071}
, bodytype = 1, behaviacAI = "newbattleaif218", defaultBuff = "", MonsterType = 218, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67024] = {id = 67024, name = "连射藤蔓", nameTextID = 1400040, shapeID = 20012, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "167462", attackConstant = "3116", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201022, 201065}
, bodytype = 1, behaviacAI = "newbattleaif206", defaultBuff = "", MonsterType = 206, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67025] = {id = 67025, name = "独角仙", nameTextID = 1400061, shapeID = 20055, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "146791", attackConstant = "3238", defConstant = "1000", magicattConstant = "0", magicDefConstant = "1000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201072, 201073}
, bodytype = 1, behaviacAI = "newbattleaif219", defaultBuff = "", MonsterType = 219, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67026] = {id = 67026, name = "幽灵螳螂", nameTextID = 1400013, shapeID = 20032, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "762552", attackConstant = "6977", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201053, 201054, 201055}
, bodytype = 1, behaviacAI = "newbattleaif222", defaultBuff = "20116", MonsterType = 222, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67027] = {id = 67027, name = "兰花螳螂", nameTextID = 1400012, shapeID = 20031, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "1205550", attackConstant = "12639", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201050, 201051, 201052}
, bodytype = 1, behaviacAI = "newbattleaif221", defaultBuff = "20116", MonsterType = 221, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67028] = {id = 67028, name = "石巨人", nameTextID = 1400008, shapeID = 10043, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "1231200", attackConstant = "16915", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201027, 201028, 201029, 201037, 201059}
, bodytype = 1, behaviacAI = "newbattleaif220", defaultBuff = "20116", MonsterType = 220, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67029] = {id = 67029, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 80, hpConstant = "21457", attackConstant = "517", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67030] = {id = 67030, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "22990", attackConstant = "559", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67031] = {id = 67031, name = "食魔", nameTextID = 1400184, shapeID = 20159, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "53644", attackConstant = "1118", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201650, 201651}
, bodytype = 1, behaviacAI = "NewBattleAITest31", defaultBuff = "", MonsterType = 10010, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67032] = {id = 67032, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 100, hpConstant = "31075", attackConstant = "601", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67033] = {id = 67033, name = "惑魔", nameTextID = 1400183, shapeID = 20158, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 100, hpConstant = "72508", attackConstant = "1203", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201648, 201649}
, bodytype = 1, behaviacAI = "NewBattleAITest30", defaultBuff = "", MonsterType = 10011, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67034] = {id = 67034, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "33017", attackConstant = "644", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67035] = {id = 67035, name = "食魔", nameTextID = 1400184, shapeID = 20159, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "77040", attackConstant = "1289", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201650, 201651}
, bodytype = 1, behaviacAI = "NewBattleAITest31", defaultBuff = "", MonsterType = 10010, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67036] = {id = 67036, name = "惑魔", nameTextID = 1400183, shapeID = 20158, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "77040", attackConstant = "1289", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201648, 201649}
, bodytype = 1, behaviacAI = "NewBattleAITest30", defaultBuff = "", MonsterType = 10011, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67037] = {id = 67037, name = "象魔", nameTextID = 1400187, shapeID = 20162, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "330174", attackConstant = "2561", defConstant = "0", magicattConstant = "0", magicDefConstant = "9000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201657, 201658, 201659, 201660}
, bodytype = 1, behaviacAI = "NewBattleAITest34", defaultBuff = "", MonsterType = 10014, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67038] = {id = 67038, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "34959", attackConstant = "688", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67039] = {id = 67039, name = "怠魔", nameTextID = 1400185, shapeID = 20160, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "81572", attackConstant = "1377", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201652, 201653}
, bodytype = 1, behaviacAI = "NewBattleAITest32", defaultBuff = "21198", MonsterType = 10012, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67040] = {id = 67040, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 130, hpConstant = "36901", attackConstant = "733", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67041] = {id = 67041, name = "怠魔", nameTextID = 1400185, shapeID = 20160, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 130, hpConstant = "86104", attackConstant = "1466", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201652, 201653}
, bodytype = 1, behaviacAI = "NewBattleAITest32", defaultBuff = "21198", MonsterType = 10012, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67042] = {id = 67042, name = "暴魔", nameTextID = 1400186, shapeID = 20161, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 130, hpConstant = "369018", attackConstant = "2925", defConstant = "9000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201654, 201655, 201656}
, bodytype = 1, behaviacAI = "NewBattleAITest33", defaultBuff = "20116", MonsterType = 10013, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67043] = {id = 67043, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "60555", attackConstant = "1266", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67044] = {id = 67044, name = "惑魔", nameTextID = 1400183, shapeID = 20158, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "141296", attackConstant = "2532", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201648, 201649}
, bodytype = 1, behaviacAI = "NewBattleAITest30", defaultBuff = "", MonsterType = 10011, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67045] = {id = 67045, name = "象魔", nameTextID = 1400187, shapeID = 20162, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "605556", attackConstant = "5197", defConstant = "0", magicattConstant = "0", magicDefConstant = "9000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201657, 201658, 201659, 201660}
, bodytype = 1, behaviacAI = "NewBattleAITest34", defaultBuff = "20116", MonsterType = 10014, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67046] = {id = 67046, name = "暴魔", nameTextID = 1400186, shapeID = 20161, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "605556", attackConstant = "5197", defConstant = "9000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201654, 201655, 201656}
, bodytype = 1, behaviacAI = "NewBattleAITest33", defaultBuff = "20116", MonsterType = 10013, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67047] = {id = 67047, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan02", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[67048] = {id = 67048, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 100, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan03", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[67049] = {id = 67049, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan06", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[67050] = {id = 67050, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan04", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[67051] = {id = 67051, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 130, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan01", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[67052] = {id = 67052, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan05", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[67053] = {id = 67053, name = "食魔", nameTextID = 1400184, shapeID = 20159, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "141296", attackConstant = "2532", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201650, 201651}
, bodytype = 1, behaviacAI = "NewBattleAITest31", defaultBuff = "", MonsterType = 10010, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67054] = {id = 67054, name = "怠魔", nameTextID = 1400185, shapeID = 20160, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "141296", attackConstant = "2532", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201652, 201653}
, bodytype = 1, behaviacAI = "NewBattleAITest32", defaultBuff = "21198", MonsterType = 10012, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67055] = {id = 67055, name = "命运的化身", nameTextID = 1400188, shapeID = 20163, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "823855;823855;823855", attackConstant = "5692", defConstant = "4000", magicattConstant = "0", magicDefConstant = "4000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201666, 201667, 201668, 201673}
, bodytype = 1, behaviacAI = "newbattleaif10015_ee", defaultBuff = "21235;21237;21240;20116", MonsterType = 10015, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67056] = {id = 67056, name = "绝·命运的化身", nameTextID = 1400189, shapeID = 20164, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "823855;823855;823855;823855;823855", attackConstant = "5692", defConstant = "8000", magicattConstant = "0", magicDefConstant = "8000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201669, 201670, 201671, 201672, 201673}
, bodytype = 1, behaviacAI = "newbattleaif10016", defaultBuff = "21237;21238;21240;20116", MonsterType = 10016, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67057] = {id = 67057, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "67284", attackConstant = "1441", defConstant = "3000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67058] = {id = 67058, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "69526", attackConstant = "1501", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67059] = {id = 67059, name = "食魔", nameTextID = 1400184, shapeID = 20159, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "162229", attackConstant = "3002", defConstant = "0", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201650, 201651, 201675}
, bodytype = 1, behaviacAI = "NewBattleAITest31", defaultBuff = "", MonsterType = 10010, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67060] = {id = 67060, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "71769", attackConstant = "1561", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67061] = {id = 67061, name = "惑魔", nameTextID = 1400183, shapeID = 20158, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "167462", attackConstant = "3123", defConstant = "6000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201648, 201649, 201675}
, bodytype = 1, behaviacAI = "NewBattleAITest30_1", defaultBuff = "", MonsterType = 10011, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67062] = {id = 67062, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "74012", attackConstant = "1623", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67063] = {id = 67063, name = "食魔", nameTextID = 1400184, shapeID = 20159, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "172695", attackConstant = "3246", defConstant = "0", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201650, 201651, 201675}
, bodytype = 1, behaviacAI = "NewBattleAITest31", defaultBuff = "", MonsterType = 10010, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67064] = {id = 67064, name = "惑魔", nameTextID = 1400183, shapeID = 20158, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "172695", attackConstant = "3246", defConstant = "0", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201648, 201649}
, bodytype = 1, behaviacAI = "NewBattleAITest30_1", defaultBuff = "", MonsterType = 10011, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67065] = {id = 67065, name = "象魔", nameTextID = 1400187, shapeID = 20162, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "740124", attackConstant = "6730", defConstant = "0", magicattConstant = "0", magicDefConstant = "12000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201657, 201658, 201659, 201660, 201675}
, bodytype = 1, behaviacAI = "NewBattleAITest34_1", defaultBuff = "20116", MonsterType = 10014, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67066] = {id = 67066, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "76255", attackConstant = "1685", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67067] = {id = 67067, name = "怠魔", nameTextID = 1400185, shapeID = 20160, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "177928", attackConstant = "3370", defConstant = "0", magicattConstant = "0", magicDefConstant = "6000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201652, 201653, 201675}
, bodytype = 1, behaviacAI = "NewBattleAITest32_1", defaultBuff = "21198", MonsterType = 10012, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67068] = {id = 67068, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "120555", attackConstant = "2958", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67069] = {id = 67069, name = "怠魔", nameTextID = 1400185, shapeID = 20160, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "281295", attackConstant = "5916", defConstant = "9000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201652, 201653, 201675}
, bodytype = 1, behaviacAI = "NewBattleAITest32_1", defaultBuff = "21198", MonsterType = 10012, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67070] = {id = 67070, name = "暴魔", nameTextID = 1400186, shapeID = 20161, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "1205550", attackConstant = "12675", defConstant = "12000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201654, 201655, 201656, 201675}
, bodytype = 1, behaviacAI = "NewBattleAITest33_1", defaultBuff = "20116", MonsterType = 10013, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67071] = {id = 67071, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "123120", attackConstant = "3042", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 10009, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67072] = {id = 67072, name = "惑魔", nameTextID = 1400183, shapeID = 20158, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "287280", attackConstant = "6084", defConstant = "0", magicattConstant = "0", magicDefConstant = "9000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201648, 201649}
, bodytype = 1, behaviacAI = "NewBattleAITest30", defaultBuff = "", MonsterType = 10011, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67073] = {id = 67073, name = "象魔", nameTextID = 1400187, shapeID = 20162, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "1231200", attackConstant = "13050", defConstant = "0", magicattConstant = "0", magicDefConstant = "12000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201657, 201658, 201659, 201660, 201675}
, bodytype = 1, behaviacAI = "NewBattleAITest34_1", defaultBuff = "20116", MonsterType = 10014, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67074] = {id = 67074, name = "暴魔", nameTextID = 1400186, shapeID = 20161, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "1231200", attackConstant = "13050", defConstant = "12000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201654, 201655, 201656, 201675}
, bodytype = 1, behaviacAI = "NewBattleAITest33_1", defaultBuff = "20116", MonsterType = 10013, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67075] = {id = 67075, name = "食魔", nameTextID = 1400184, shapeID = 20159, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "287280", attackConstant = "6084", defConstant = "0", magicattConstant = "0", magicDefConstant = "9000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201650, 201651}
, bodytype = 1, behaviacAI = "NewBattleAITest31", defaultBuff = "", MonsterType = 10010, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67076] = {id = 67076, name = "怠魔", nameTextID = 1400185, shapeID = 20160, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "287280", attackConstant = "6084", defConstant = "9000", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201652, 201653}
, bodytype = 1, behaviacAI = "NewBattleAITest32", defaultBuff = "21198", MonsterType = 10012, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67077] = {id = 67077, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan07", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[67078] = {id = 67078, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan08", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[67079] = {id = 67079, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan09", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[67080] = {id = 67080, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan010", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[67081] = {id = 67081, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan011", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[67082] = {id = 67082, name = "隐藏的木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665, 201675}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan012", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[67083] = {id = 67083, name = "命运的化身", nameTextID = 1400188, shapeID = 20163, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1624500;1624500;1624500", attackConstant = "13813", defConstant = "8000", magicattConstant = "0", magicDefConstant = "8000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201666, 201667, 201668, 201673}
, bodytype = 1, behaviacAI = "newbattleaif10015_hh", defaultBuff = "21235;21237;21240;20116", MonsterType = 10015, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67084] = {id = 67084, name = "绝·命运的化身", nameTextID = 1400189, shapeID = 20164, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1624500;1624500;1624500;1624500;1624500", attackConstant = "13813", defConstant = "12000", magicattConstant = "0", magicDefConstant = "12000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201669, 201670, 201671, 201672, 201673}
, bodytype = 1, behaviacAI = "newbattleaif10016_h", defaultBuff = "21237;21238;21240;20116", MonsterType = 10016, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67085] = {id = 67085, name = "命运的化身", nameTextID = 1400188, shapeID = 20163, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 250, hpConstant = "1624500+(lv-250)*2924;1624500+(lv-250)*2924;1624500+(lv-250)*2924", attackConstant = "13813+(lv-250)*33", defConstant = "8000", magicattConstant = "0", magicDefConstant = "8000", speedConstant = "30", damagereduce = "(lv-250)*5", attackID = 0, 
skillid = {201666, 201667, 201668, 201673}
, bodytype = 1, behaviacAI = "newbattleaif10015_hhh", defaultBuff = "21235;21237;21240;20116", MonsterType = 10015, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67086] = {id = 67086, name = "绝·命运的化身", nameTextID = 1400189, shapeID = 20164, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 250, hpConstant = "1624500+(lv-250)*2924;1624500+(lv-250)*2924;1624500+(lv-250)*2924;1624500+(lv-250)*2924;1624500+(lv-250)*2924", attackConstant = "13813+(lv-250)*33", defConstant = "12000", magicattConstant = "0", magicDefConstant = "12000", speedConstant = "30", damagereduce = "(lv-250)*5", attackID = 0, 
skillid = {201669, 201670, 201671, 201672, 201673}
, bodytype = 1, behaviacAI = "newbattleaif10016_h", defaultBuff = "21237;21238;21240;20116", MonsterType = 10016, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67100] = {id = 67100, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 80, hpConstant = "21457", attackConstant = "516", defConstant = "2506", magicattConstant = "0", magicDefConstant = "2506", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67101] = {id = 67101, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "53644", attackConstant = "1116", defConstant = "4585", magicattConstant = "0", magicDefConstant = "2585", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67102] = {id = 67102, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "22990", attackConstant = "558", defConstant = "2585", magicattConstant = "0", magicDefConstant = "2585", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67103] = {id = 67103, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 100, hpConstant = "72508", attackConstant = "1201", defConstant = "4664", magicattConstant = "0", magicDefConstant = "2664", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67104] = {id = 67104, name = "精灵龙", nameTextID = 1400220, shapeID = 20198, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "495261", attackConstant = "3579", defConstant = "1371", magicattConstant = "0", magicDefConstant = "4115", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201750, 201751}
, bodytype = 1, behaviacAI = "NewBattlemonW3_16", defaultBuff = "21794", MonsterType = 904, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67105] = {id = 67105, name = "美人鱼", nameTextID = 1400195, shapeID = 20166, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "349596", attackConstant = "2736", defConstant = "2823", magicattConstant = "0", magicDefConstant = "2823", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01_h", defaultBuff = "", MonsterType = 11103, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67106] = {id = 67106, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "81572", attackConstant = "1375", defConstant = "4823", magicattConstant = "0", magicDefConstant = "2823", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67107] = {id = 67107, name = "美人鱼", nameTextID = 1400195, shapeID = 20166, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 130, hpConstant = "369018", attackConstant = "2918", defConstant = "2902", magicattConstant = "0", magicDefConstant = "2902", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01_h", defaultBuff = "", MonsterType = 11103, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67108] = {id = 67108, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "605556", attackConstant = "5185", defConstant = "4092", magicattConstant = "0", magicDefConstant = "4092", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67109] = {id = 67109, name = "蟹宝王", nameTextID = 1400196, shapeID = 20171, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "823855;823855;823855;823855;823855", attackConstant = "5678", defConstant = "11527", magicattConstant = "0", magicDefConstant = "4263", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201697, 201698, 201699, 201700, 201701}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon06", defaultBuff = "20116", MonsterType = 11105, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67110] = {id = 67110, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "67284", attackConstant = "1438", defConstant = "4349", magicattConstant = "0", magicDefConstant = "4349", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67111] = {id = 67111, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "162229", attackConstant = "2995", defConstant = "6434", magicattConstant = "0", magicDefConstant = "4434", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67112] = {id = 67112, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "69526", attackConstant = "1497", defConstant = "4434", magicattConstant = "0", magicDefConstant = "4434", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67113] = {id = 67113, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "167462", attackConstant = "3116", defConstant = "6519", magicattConstant = "0", magicDefConstant = "4519", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67114] = {id = 67114, name = "精灵龙", nameTextID = 1400220, shapeID = 20198, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "1110186", attackConstant = "9394", defConstant = "2302", magicattConstant = "0", magicDefConstant = "6907", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201750, 201751}
, bodytype = 1, behaviacAI = "NewBattlemonW3_16", defaultBuff = "21794", MonsterType = 904, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67115] = {id = 67115, name = "美人鱼", nameTextID = 1400195, shapeID = 20166, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "762552", attackConstant = "6977", defConstant = "4690", magicattConstant = "0", magicDefConstant = "4690", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01_h", defaultBuff = "", MonsterType = 11103, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67116] = {id = 67116, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "177928", attackConstant = "3362", defConstant = "6690", magicattConstant = "0", magicDefConstant = "4690", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67117] = {id = 67117, name = "美人鱼", nameTextID = 1400195, shapeID = 20166, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "1205550", attackConstant = "12639", defConstant = "6736", magicattConstant = "0", magicDefConstant = "6736", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01_h", defaultBuff = "", MonsterType = 11103, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67118] = {id = 67118, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "1231200", attackConstant = "13011", defConstant = "6828", magicattConstant = "0", magicDefConstant = "6828", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67119] = {id = 67119, name = "蟹宝王", nameTextID = 1400196, shapeID = 20171, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1624500;1624500;1624500;1624500;1624500", attackConstant = "13770", defConstant = "17022", magicattConstant = "0", magicDefConstant = "7011", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201697, 201698, 201699, 201700, 201701}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon06", defaultBuff = "20116", MonsterType = 11105, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67120] = {id = 67120, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "34959", attackConstant = "687", defConstant = "2823", magicattConstant = "0", magicDefConstant = "2823", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67121] = {id = 67121, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "81572", attackConstant = "1375", defConstant = "4823", magicattConstant = "0", magicDefConstant = "2823", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67122] = {id = 67122, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 130, hpConstant = "86104", attackConstant = "1463", defConstant = "4902", magicattConstant = "0", magicDefConstant = "2902", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67123] = {id = 67123, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 130, hpConstant = "86104", attackConstant = "1463", defConstant = "2902", magicattConstant = "0", magicDefConstant = "6353", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67124] = {id = 67124, name = "精灵龙", nameTextID = 1400220, shapeID = 20198, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "908334", attackConstant = "7259", defConstant = "2046", magicattConstant = "0", magicDefConstant = "6139", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201750, 201751}
, bodytype = 1, behaviacAI = "NewBattlemonW3_16", defaultBuff = "21794", MonsterType = 904, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67125] = {id = 67125, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "627984", attackConstant = "5430", defConstant = "4178", magicattConstant = "0", magicDefConstant = "4178", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67126] = {id = 67126, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 150, hpConstant = "146529", attackConstant = "2642", defConstant = "4178", magicattConstant = "0", magicDefConstant = "8267", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67127] = {id = 67127, name = "美人鱼", nameTextID = 1400195, shapeID = 20166, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "695268", attackConstant = "6187", defConstant = "4434", magicattConstant = "0", magicDefConstant = "4434", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01_h", defaultBuff = "", MonsterType = 11103, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67128] = {id = 67128, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "695268", attackConstant = "6187", defConstant = "4434", magicattConstant = "0", magicDefConstant = "4434", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67129] = {id = 67129, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "120555", attackConstant = "2950", defConstant = "6736", magicattConstant = "0", magicDefConstant = "6736", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67130] = {id = 67130, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "281295", attackConstant = "5901", defConstant = "8736", magicattConstant = "0", magicDefConstant = "6736", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67131] = {id = 67131, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "287280", attackConstant = "6068", defConstant = "8828", magicattConstant = "0", magicDefConstant = "6828", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67132] = {id = 67132, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "287280", attackConstant = "6068", defConstant = "6828", magicattConstant = "0", magicDefConstant = "12242", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67133] = {id = 67133, name = "精灵龙", nameTextID = 1400220, shapeID = 20198, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "1885275", attackConstant = "18744", defConstant = "3459", magicattConstant = "0", magicDefConstant = "10379", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201750, 201751}
, bodytype = 1, behaviacAI = "NewBattlemonW3_16", defaultBuff = "21794", MonsterType = 904, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67134] = {id = 67134, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1282500", attackConstant = "13770", defConstant = "7011", magicattConstant = "0", magicDefConstant = "7011", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67135] = {id = 67135, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "299250", attackConstant = "6408", defConstant = "7011", magicattConstant = "0", magicDefConstant = "12516", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67136] = {id = 67136, name = "蟹宝王", nameTextID = 1400196, shapeID = 20171, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 280, hpConstant = "1721970;1721970;1721970;1721970;1721970", attackConstant = "14939", defConstant = "17571", magicattConstant = "0", magicDefConstant = "7285", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201697, 201698, 201699, 201700, 201701}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon06", defaultBuff = "20116", MonsterType = 11105, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67137] = {id = 67137, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 280, hpConstant = "1359450", attackConstant = "14939", defConstant = "7285", magicattConstant = "0", magicDefConstant = "7285", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67138] = {id = 67138, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "141075", attackConstant = "3643", defConstant = "7468", magicattConstant = "0", magicDefConstant = "7468", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 11101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67139] = {id = 67139, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "329175", attackConstant = "7286", defConstant = "9468", magicattConstant = "0", magicDefConstant = "7468", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67140] = {id = 67140, name = "开心蟹", nameTextID = 1400192, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "329175", attackConstant = "7286", defConstant = "9468", magicattConstant = "0", magicDefConstant = "7468", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 11102, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67141] = {id = 67141, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "329175", attackConstant = "7286", defConstant = "7468", magicattConstant = "0", magicDefConstant = "13202", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67142] = {id = 67142, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "1410750", attackConstant = "15741", defConstant = "7468", magicattConstant = "0", magicDefConstant = "7468", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67143] = {id = 67143, name = "珊瑚海马", nameTextID = 1400193, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "329175", attackConstant = "7286", defConstant = "7468", magicattConstant = "0", magicDefConstant = "13202", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 11106, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67144] = {id = 67144, name = "美人鱼", nameTextID = 1400195, shapeID = 20166, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "1410750", attackConstant = "15741", defConstant = "7468", magicattConstant = "0", magicDefConstant = "7468", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01_h", defaultBuff = "", MonsterType = 11103, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67145] = {id = 67145, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "1410750", attackConstant = "15741", defConstant = "7468", magicattConstant = "0", magicDefConstant = "7468", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67146] = {id = 67146, name = "蟹宝王", nameTextID = 1400196, shapeID = 20171, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "1786950;1786950;1786950;1786950;1786950", attackConstant = "15741", defConstant = "17937", magicattConstant = "0", magicDefConstant = "7468", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201697, 201698, 201699, 201700, 201701}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon06", defaultBuff = "20116", MonsterType = 11105, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67147] = {id = 67147, name = "珊瑚龙", nameTextID = 1400194, shapeID = 20168, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 300, hpConstant = "1410750", attackConstant = "15741", defConstant = "7468", magicattConstant = "0", magicDefConstant = "7468", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 11104, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67148] = {id = 67148, name = "小精灵龙", nameTextID = 1400219, shapeID = 20197, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "92448", attackConstant = "1802", defConstant = "823", magicattConstant = "0", magicDefConstant = "2469", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201740, 201741}
, bodytype = 1, behaviacAI = "NewBattlemonW3_15", defaultBuff = "", MonsterType = 903, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67149] = {id = 67149, name = "小精灵龙", nameTextID = 1400219, shapeID = 20197, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "169555", attackConstant = "3538", defConstant = "1227", magicattConstant = "0", magicDefConstant = "3683", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201740, 201741}
, bodytype = 1, behaviacAI = "NewBattlemonW3_15", defaultBuff = "", MonsterType = 903, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67150] = {id = 67150, name = "小精灵龙", nameTextID = 1400219, shapeID = 20197, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 240, hpConstant = "351918", attackConstant = "8732", defConstant = "2075", magicattConstant = "0", magicDefConstant = "6227", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201740, 201741}
, bodytype = 1, behaviacAI = "NewBattlemonW3_15", defaultBuff = "", MonsterType = 903, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67151] = {id = 67151, name = "巨狐", nameTextID = 1400002, shapeID = 10045, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 80, hpConstant = "50068", attackConstant = "206", defConstant = "2506", magicattConstant = "0", magicDefConstant = "2506", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201081}
, bodytype = 1, behaviacAI = "newbattleai1", defaultBuff = "", MonsterType = 101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67152] = {id = 67152, name = "石像鬼", nameTextID = 1400004, shapeID = 20003, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 90, hpConstant = "229905", attackConstant = "2210", defConstant = "2585", magicattConstant = "0", magicDefConstant = "2585", speedConstant = "0", damagereduce = "0", attackID = 0, 
skillid = {201017, 201017, 201008, 201363}
, bodytype = 1, behaviacAI = "newbattleaif106", defaultBuff = "20116", MonsterType = 106, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67153] = {id = 67153, name = "怨念体", nameTextID = 1400037, shapeID = 20079, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 100, hpConstant = "72508", attackConstant = "1203", defConstant = "2664", magicattConstant = "0", magicDefConstant = "2664", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201219, 201218}
, bodytype = 1, behaviacAI = "newbattleaif502", defaultBuff = "", MonsterType = 502, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67154] = {id = 67154, name = "万圣节怨念聚合体", nameTextID = 1400201, shapeID = 20176, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 110, hpConstant = "418220", attackConstant = "1280", defConstant = "2743", magicattConstant = "0", magicDefConstant = "2743", speedConstant = "30", damagereduce = "0", attackID = 201042, 
skillid = {201039, 201040, 201042, 201038}
, bodytype = 1, behaviacAI = "newbattleai20133", defaultBuff = "20116", MonsterType = 12101, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67155] = {id = 67155, name = "万圣节时钟怪", nameTextID = 1400200, shapeID = 20175, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 120, hpConstant = "575668", attackConstant = "1919", defConstant = "2823", magicattConstant = "0", magicDefConstant = "7234", speedConstant = "30", damagereduce = "0", attackID = 201012, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215}
, bodytype = 1, behaviacAI = "newbattleai20007", defaultBuff = "20116", MonsterType = 12102, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67156] = {id = 67156, name = "万圣节石巨人", nameTextID = 1400202, shapeID = 20177, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 130, hpConstant = "701134", attackConstant = "2340", defConstant = "9353", magicattConstant = "0", magicDefConstant = "2902", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201027, 201028, 201029, 201037, 201059, 201642, 201643, 201644, 201645}
, bodytype = 1, behaviacAI = "newbattleai20015", defaultBuff = "20116", MonsterType = 12103, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67157] = {id = 67157, name = "万圣节骸骨蛇", nameTextID = 1400203, shapeID = 20178, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "1303963", attackConstant = "5197", defConstant = "7092", magicattConstant = "0", magicDefConstant = "7092", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201222, 201221, 201223}
, bodytype = 1, behaviacAI = "newbattleaif504", defaultBuff = "20116", MonsterType = 12104, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67158] = {id = 67158, name = "地祇之子", nameTextID = 1400235, shapeID = 20209, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 160, hpConstant = "1235782;1235782;1235782;1235782;1235782", attackConstant = "5692", defConstant = "4224", magicattConstant = "0", magicDefConstant = "1421", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201860, 201861, 201862, 201863, 201864, 201866, 201867, 201868}
, bodytype = 1, behaviacAI = "NewBattlemonW3_40", defaultBuff = "20116;20115", MonsterType = 914, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67159] = {id = 67159, name = "巨狐", nameTextID = 1400002, shapeID = 10045, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "156996", attackConstant = "576", defConstant = "4349", magicattConstant = "0", magicDefConstant = "4349", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201081}
, bodytype = 1, behaviacAI = "newbattleai1", defaultBuff = "", MonsterType = 101, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67160] = {id = 67160, name = "石像鬼", nameTextID = 1400004, shapeID = 20003, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 180, hpConstant = "695268", attackConstant = "6204", defConstant = "4434", magicattConstant = "0", magicDefConstant = "4434", speedConstant = "0", damagereduce = "0", attackID = 0, 
skillid = {201017, 201017, 201008, 201363}
, bodytype = 1, behaviacAI = "newbattleaif106", defaultBuff = "20116", MonsterType = 106, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[67161] = {id = 67161, name = "怨念体", nameTextID = 1400037, shapeID = 20079, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 190, hpConstant = "167462", attackConstant = "3123", defConstant = "4519", magicattConstant = "0", magicDefConstant = "4519", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201219, 201218}
, bodytype = 1, behaviacAI = "newbattleaif502", defaultBuff = "", MonsterType = 502, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[67162] = {id = 67162, name = "万圣节怨念聚合体", nameTextID = 1400201, shapeID = 20176, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "937490", attackConstant = "3365", defConstant = "4605", magicattConstant = "0", magicDefConstant = "4605", speedConstant = "30", damagereduce = "0", attackID = 201042, 
skillid = {201039, 201040, 201042, 201038}
, bodytype = 1, behaviacAI = "newbattleai20133", defaultBuff = "20116", MonsterType = 12101, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67163] = {id = 67163, name = "万圣节时钟怪", nameTextID = 1400200, shapeID = 20175, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 210, hpConstant = "1255668", attackConstant = "4899", defConstant = "4690", magicattConstant = "0", magicDefConstant = "10035", speedConstant = "30", damagereduce = "0", attackID = 201012, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215}
, bodytype = 1, behaviacAI = "newbattleai20007", defaultBuff = "20116", MonsterType = 12102, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67164] = {id = 67164, name = "万圣节石巨人", nameTextID = 1400202, shapeID = 20177, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "2290545", attackConstant = "10140", defConstant = "15105", magicattConstant = "0", magicDefConstant = "6736", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201027, 201028, 201029, 201037, 201059, 201642, 201643, 201644, 201645}
, bodytype = 1, behaviacAI = "newbattleai20015", defaultBuff = "20116", MonsterType = 12103, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67165] = {id = 67165, name = "万圣节骸骨蛇", nameTextID = 1400203, shapeID = 20178, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 230, hpConstant = "2651184", attackConstant = "13050", defConstant = "9828", magicattConstant = "0", magicDefConstant = "9828", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201222, 201221, 201223}
, bodytype = 1, behaviacAI = "newbattleaif504", defaultBuff = "20116", MonsterType = 12104, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67166] = {id = 67166, name = "地祇之子", nameTextID = 1400235, shapeID = 20209, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "2436750;2436750;2436750;2436750;2436750", attackConstant = "13813", defConstant = "17620", magicattConstant = "0", magicDefConstant = "7011", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201860, 201861, 201862, 201863, 201864, 201866, 201867, 201868}
, bodytype = 1, behaviacAI = "NewBattlemonW3_40", defaultBuff = "20116;20115", MonsterType = 914, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67167] = {id = 67167, name = "地祇之子", nameTextID = 1400235, shapeID = 20209, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 160, hpConstant = "1235782+(lv-160)*3000;1235782+(lv-160)*3000;1235782+(lv-160)*3000;1235782+(lv-160)*3000;1235782+(lv-160)*3000", attackConstant = "5692+(lv-160)*71", defConstant = "12674", magicattConstant = "0", magicDefConstant = "4263", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201860, 201861, 201862, 201863, 201864, 201866, 201867, 201868}
, bodytype = 1, behaviacAI = "NewBattlemonW3_40", defaultBuff = "20116;20115", MonsterType = 914, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67168] = {id = 67168, name = "地祇之子", nameTextID = 1400235, shapeID = 20209, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 1, npcLevel = 250, hpConstant = "2436750+(lv-250)*3000;2436750+(lv-250)*3000;2436750+(lv-250)*3000;2436750+(lv-250)*3000;2436750+(lv-250)*3000", attackConstant = "13813+(lv-250)*33", defConstant = "17620", magicattConstant = "0", magicDefConstant = "7011", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201860, 201861, 201862, 201863, 201864, 201866, 201867, 201868}
, bodytype = 1, behaviacAI = "NewBattlemonW3_40", defaultBuff = "20116;20115", MonsterType = 914, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67169] = {id = 67169, name = "次元监视者", nameTextID = 1400006, shapeID = 20006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 350, hpConstant = "937490;937490;937490;937490;937490", attackConstant = "13813", defConstant = "5100", magicattConstant = "0", magicDefConstant = "2550", speedConstant = "30", damagereduce = "221", attackID = 201012, 
skillid = {201012, 201013, 201014, 201015, 201016, 201047, 201058, 201215}
, bodytype = 1, behaviacAI = "NewBattleAI20007_bossrush", defaultBuff = "20116;21761", MonsterType = 108, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67170] = {id = 67170, name = "祟-水银", nameTextID = 1400212, shapeID = 20186, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 350, hpConstant = "937490;937490;937490;937490;937490", attackConstant = "13813", defConstant = "5100", magicattConstant = "0", magicDefConstant = "2550", speedConstant = "30", damagereduce = "221", attackID = 0, 
skillid = {201707, 201708, 201711, 201714, 201717}
, bodytype = 1, behaviacAI = "newbattleaichunmon01", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67171] = {id = 67171, name = "蟹宝王", nameTextID = 1400196, shapeID = 20171, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 350, hpConstant = "937490;937490;937490;937490;937490", attackConstant = "13813", defConstant = "5100", magicattConstant = "0", magicDefConstant = "2550", speedConstant = "30", damagereduce = "221", attackID = 0, 
skillid = {201697, 201698, 201699, 201700, 201701}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon06", defaultBuff = "20116", MonsterType = 11105, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67172] = {id = 67172, name = "白熊 赫沃奥塔", nameTextID = 1400130, shapeID = 50020, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 350, hpConstant = "937490;937490;937490;937490;937490", attackConstant = "13813", defConstant = "5100", magicattConstant = "0", magicDefConstant = "2550", speedConstant = "30", damagereduce = "221", attackID = 0, 
skillid = {201290, 201291, 201292, 201293, 201294, 201267, 201268, 201269, 201270, 201271, 201305, 201320}
, bodytype = 1, behaviacAI = "newbattleai59s", defaultBuff = "20116", MonsterType = 2020, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67173] = {id = 67173, name = "地狱守卫", nameTextID = 1400165, shapeID = 50024, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 350, hpConstant = "937490;937490;937490;937490;937490", attackConstant = "13050", defConstant = "5100", magicattConstant = "0", magicDefConstant = "2550", speedConstant = "30", damagereduce = "221", attackID = 0, 
skillid = {201531, 201532, 201533, 201534}
, bodytype = 1, behaviacAI = "newbattleaif10004", defaultBuff = "20116", MonsterType = 10003, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[67174] = {id = 67174, name = "守卫神官", nameTextID = 1400240, shapeID = 20208, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 350, hpConstant = "937490;937490;937490;937490;937490", attackConstant = "13050", defConstant = "5100", magicattConstant = "0", magicDefConstant = "2550", speedConstant = "30", damagereduce = "221", attackID = 0, 
skillid = {201780, 201781, 201782, 201783, 201784, 201785, 201786, 201787}
, bodytype = 1, behaviacAI = "NewBattlebossW6_4", defaultBuff = "20116;20115;21797", MonsterType = 913, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[80001] = {id = 80001, name = "骸骨蛇", nameTextID = 1400028, shapeID = 20080, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "10000", attackConstant = "1", defConstant = "1", magicattConstant = "1", magicDefConstant = "1", speedConstant = "30", damagereduce = "0", attackID = 201222, 
skillid = {201222, 201221, 201223}
, bodytype = 1, behaviacAI = "newbattleaif504", defaultBuff = "", MonsterType = 67, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80002] = {id = 80002, name = "魔法师之影", nameTextID = 1400038, shapeID = 20077, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "10000", attackConstant = "1", defConstant = "1", magicattConstant = "1", magicDefConstant = "1", speedConstant = "30", damagereduce = "0", attackID = 201220, 
skillid = {201220, 201279}
, bodytype = 1, behaviacAI = "newbattleaif503", defaultBuff = "", MonsterType = 66, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80003] = {id = 80003, name = "怨念体", nameTextID = 1400037, shapeID = 20079, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "10000", attackConstant = "1", defConstant = "1", magicattConstant = "1", magicDefConstant = "1", speedConstant = "30", damagereduce = "0", attackID = 201219, 
skillid = {201219, 201218}
, bodytype = 1, behaviacAI = "newbattleaif502", defaultBuff = "", MonsterType = 65, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80004] = {id = 80004, name = "魂火", nameTextID = 1400039, shapeID = 20078, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "10000", attackConstant = "1", defConstant = "1", magicattConstant = "1", magicDefConstant = "1", speedConstant = "30", damagereduce = "0", attackID = 201217, 
skillid = {201217}
, bodytype = 1, behaviacAI = "newbattleaif501", defaultBuff = "", MonsterType = 64, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80005] = {id = 80005, name = "连射藤蔓", nameTextID = 1400040, shapeID = 20012, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "10000", attackConstant = "1", defConstant = "1", magicattConstant = "1", magicDefConstant = "1", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201224, 201065}
, bodytype = 1, behaviacAI = "newbattleaif206", defaultBuff = "", MonsterType = 13, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80006] = {id = 80006, name = "松树精", nameTextID = 1400041, shapeID = 20027, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "7900", attackConstant = "1", defConstant = "1", magicattConstant = "1", magicDefConstant = "1", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201231}
, bodytype = 1, behaviacAI = "newbattleaItest06", defaultBuff = "", MonsterType = 20, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80007] = {id = 80007, name = "花树精", nameTextID = 1400042, shapeID = 20028, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "7900", attackConstant = "1", defConstant = "1", magicattConstant = "1", magicDefConstant = "1", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201232, 201067}
, bodytype = 1, behaviacAI = "newbattleaif213", defaultBuff = "", MonsterType = 21, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80008] = {id = 80008, name = "冰树精", nameTextID = 1400043, shapeID = 20036, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "7900", attackConstant = "1", defConstant = "1", magicattConstant = "1", magicDefConstant = "1", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201233}
, bodytype = 1, behaviacAI = "newbattleaItest07", defaultBuff = "", MonsterType = 21, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80009] = {id = 80009, name = "火焰精灵", nameTextID = 1400044, shapeID = 20081, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "7900", attackConstant = "1", defConstant = "1", magicattConstant = "1", magicDefConstant = "1", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201234, 201235}
, bodytype = 1, behaviacAI = "newbattleaif605", defaultBuff = "", MonsterType = 74, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80010] = {id = 80010, name = "冰封熔岩兽", nameTextID = 1400045, shapeID = 20082, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "7900", attackConstant = "1", defConstant = "1", magicattConstant = "1", magicDefConstant = "1", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201237, 201236}
, bodytype = 1, behaviacAI = "newbattleaif606", defaultBuff = "", MonsterType = 75, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80011] = {id = 80011, name = "熔岩兽", nameTextID = 1400034, shapeID = 20083, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "7900", attackConstant = "1", defConstant = "1", magicattConstant = "1", magicDefConstant = "1", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201239, 201238, 201240}
, bodytype = 1, behaviacAI = "newbattleaif607", defaultBuff = "", MonsterType = 76, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80012] = {id = 80012, name = "熔岩巨兽", nameTextID = 1400033, shapeID = 20084, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "7900", attackConstant = "1", defConstant = "1", magicattConstant = "1", magicDefConstant = "1", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201241, 201242, 201243, 201244, 201245, 201372}
, bodytype = 1, behaviacAI = "newbattleaif608", defaultBuff = "", MonsterType = 77, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80013] = {id = 80013, name = "冰霜飞蛾", nameTextID = 1400046, shapeID = 20085, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "7900", attackConstant = "1", defConstant = "1", magicattConstant = "1", magicDefConstant = "1", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201273}
, bodytype = 1, behaviacAI = "newbattleaItest12", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80014] = {id = 80014, name = "兰花树精", nameTextID = 1400047, shapeID = 20086, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "7900", attackConstant = "1", defConstant = "1", magicattConstant = "1", magicDefConstant = "1", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201274, 201275}
, bodytype = 1, behaviacAI = "newbattleaItest13", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80015] = {id = 80015, name = "冰霜独角仙", nameTextID = 1400048, shapeID = 20087, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "7900", attackConstant = "1", defConstant = "1", magicattConstant = "1", magicDefConstant = "1", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201277, 201276, 201338}
, bodytype = 1, behaviacAI = "newbattleaItest17", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80016] = {id = 80016, name = "冰霜魔菇", nameTextID = 1400049, shapeID = 20088, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "7900", attackConstant = "1", defConstant = "1", magicattConstant = "1", magicDefConstant = "1", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201278}
, bodytype = 1, behaviacAI = "newbattleaItest15", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80017] = {id = 80017, name = "白熊 赫沃奥塔", nameTextID = 1400015, shapeID = 20072, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 55, hpConstant = "55000;65000;75000;85000;95000", attackConstant = "451", defConstant = "0", magicattConstant = "451", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201162}
, bodytype = 1, behaviacAI = "newbattleai59_3", defaultBuff = "20116", MonsterType = 59, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[80018] = {id = 80018, name = "元素使 艾妮萌", nameTextID = 1400022, shapeID = 5014, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 40, hpConstant = "50000;50000;50000;50000;50000", attackConstant = "321", defConstant = "0", magicattConstant = "321", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201128, 201129, 201130, 201131, 201132, 201331, 201332, 201333}
, bodytype = 1, behaviacAI = "newbattleai41a", defaultBuff = "", MonsterType = 41, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[80019] = {id = 80019, name = "守护者瑟希薇", nameTextID = 1400032, shapeID = 20061, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "40000;40000;40000;40000;40000", attackConstant = "300", defConstant = "0", magicattConstant = "300", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201141, 201142, 201145, 201147, 201148, 201150, 201203, 201204, 201205, 201206, 201143, 201144, 201146, 201149, 201212}
, bodytype = 1, behaviacAI = "newbattleai60cs", defaultBuff = "20116", MonsterType = 60, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[80020] = {id = 80020, name = "冰墙", nameTextID = 1400023, shapeID = 20076, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "5500", attackConstant = "67", defConstant = "0", magicattConstant = "67", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201211}
, bodytype = 1, behaviacAI = "newbattleai63cs", defaultBuff = "20116", MonsterType = 95, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80021] = {id = 80021, name = "冰蕊", nameTextID = 1400026, shapeID = 20076, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "5500", attackConstant = "67", defConstant = "0", magicattConstant = "67", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201211}
, bodytype = 1, behaviacAI = "newbattleai63cs", defaultBuff = "20116", MonsterType = 96, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80022] = {id = 80022, name = "怨念聚合体副本", nameTextID = 1400011, shapeID = 50006, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 30, hpConstant = "57000;57000;57000", attackConstant = "154", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201265}
, bodytype = 1, behaviacAI = "newbattleaItest18", defaultBuff = "20116", MonsterType = 2018, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[80023] = {id = 80023, name = "蝴蝶妖精副本", nameTextID = 1400105, shapeID = 50013, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 30, hpConstant = "34000;34000;34000;34000;34000", attackConstant = "118", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201266}
, bodytype = 1, behaviacAI = "newbattleaItest19", defaultBuff = "", MonsterType = 2019, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[80024] = {id = 80024, name = "火焰精灵", nameTextID = 1400044, shapeID = 20081, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "7900", attackConstant = "1", defConstant = "1", magicattConstant = "1", magicDefConstant = "1", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201234, 201235}
, bodytype = 1, behaviacAI = "newbattleaif605", defaultBuff = "", MonsterType = 74, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80025] = {id = 80025, name = "骑士团团长", nameTextID = 1400019, shapeID = 20059, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 55, hpConstant = "58000;58000;58000;58000;58000", attackConstant = "344", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201118, 201119, 201120, 201121, 201122, 201123, 201124, 201395, 201396, 201397, 201398, 201399}
, bodytype = 1, behaviacAI = "newbattleaif419_2", defaultBuff = "20116", MonsterType = 419, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[80026] = {id = 80026, name = "飞鱼", nameTextID = 1400046, shapeID = 20092, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "150000", attackConstant = "200", defConstant = "1", magicattConstant = "1", magicDefConstant = "1", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201400, 201401, 201402, 201403}
, bodytype = 1, behaviacAI = "newbattleaif506", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80027] = {id = 80027, name = "白熊", nameTextID = 1400015, shapeID = 20072, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000;50000;60000;70000;80000", attackConstant = "300", defConstant = "0", magicattConstant = "300", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201159, 201161, 201162}
, bodytype = 1, behaviacAI = "newbattleaifbaixiong1", defaultBuff = "20116", MonsterType = 420, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[80028] = {id = 80028, name = "飞鱼", nameTextID = 1400138, shapeID = 20099, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201429, 201430, 201431, 201432, 201433, 201434}
, bodytype = 1, behaviacAI = "newbattleaif509", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80029] = {id = 80029, name = "云间蚊", nameTextID = 1400046, shapeID = 20100, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "15000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201423, 201424, 201425}
, bodytype = 1, behaviacAI = "newbattleaif507", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80030] = {id = 80030, name = "针尾鸟", nameTextID = 1400046, shapeID = 20101, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "15000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201426, 201427, 201428}
, bodytype = 1, behaviacAI = "newbattleaif508", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80031] = {id = 80031, name = "魔狼", nameTextID = 1400139, shapeID = 20107, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201444, 201445, 201446, 201447, 201448, 201449}
, bodytype = 1, behaviacAI = "newbattleaif510", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80032] = {id = 80032, name = "浮游龙", nameTextID = 1400046, shapeID = 20109, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201473, 201474, 201475}
, bodytype = 1, behaviacAI = "newbattleaif511", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80033] = {id = 80033, name = "飞蛇幼体", nameTextID = 1400141, shapeID = 20110, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201487, 201488, 201489}
, bodytype = 1, behaviacAI = "newbattleaif512", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80034] = {id = 80034, name = "恐惧", nameTextID = 1400131, shapeID = 20102, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "16020;16020;16020", attackConstant = "144", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201450, 201451, 201452, 201453}
, bodytype = 1, behaviacAI = "NewBattleAI80034", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[80035] = {id = 80035, name = "恐惧", nameTextID = 1400131, shapeID = 20103, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "16020;16020;16020", attackConstant = "144", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201454, 201455, 201456, 201457}
, bodytype = 1, behaviacAI = "NewBattleAI80035", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[80036] = {id = 80036, name = "恐惧", nameTextID = 1400131, shapeID = 20104, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "16020;16020;16020", attackConstant = "144", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201458, 201459, 201460, 201461, 201462}
, bodytype = 1, behaviacAI = "NewBattleAI80036", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[80037] = {id = 80037, name = "恐惧", nameTextID = 1400131, shapeID = 20105, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 60, hpConstant = "16020;16020;16020", attackConstant = "144", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201463, 201465, 201466, 201467, 201468, 201469}
, bodytype = 1, behaviacAI = "NewBattleAI80037", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[80038] = {id = 80038, name = "飞蛇", nameTextID = 1400142, shapeID = 20111, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 40, hpConstant = "45000;45000;45000", attackConstant = "230", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201493, 201495, 201496, 201497, 201498, 201499, 201500, 201501}
, bodytype = 1, behaviacAI = "newbattleaif516", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[80039] = {id = 80039, name = "毛虫幼体", nameTextID = 1400046, shapeID = 20112, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "15000", attackConstant = "500", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201476, 201477, 201478}
, bodytype = 1, behaviacAI = "newbattleaif513", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80040] = {id = 80040, name = "毛虫", nameTextID = 1400046, shapeID = 20114, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "15000", attackConstant = "500", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201479, 201480, 201481}
, bodytype = 1, behaviacAI = "newbattleaif514", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80041] = {id = 80041, name = "杀人蜂", nameTextID = 1400046, shapeID = 20116, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "15000", attackConstant = "500", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201490, 201491, 201492}
, bodytype = 1, behaviacAI = "newbattleaif515", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80042] = {id = 80042, name = "蝠翼飞狮", nameTextID = 1400157, shapeID = 20117, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "58000;58000;58000", attackConstant = "344", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201514, 201515, 201516, 201517, 201518, 201519, 201520}
, bodytype = 1, behaviacAI = "newbattleaif517", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80043] = {id = 80043, name = "飞蛇幼体-测试用", nameTextID = 1400141, shapeID = 20110, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "10000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201487, 201488, 201489}
, bodytype = 1, behaviacAI = "newbattleaif512", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80044] = {id = 80044, name = "飞蛇幼体-变身", nameTextID = 1400141, shapeID = 20110, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "10000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201487, 201488, 201489}
, bodytype = 1, behaviacAI = "newbattleaif519", defaultBuff = "20766", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80045] = {id = 80045, name = "飞蛾", nameTextID = 1400141, shapeID = 20125, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "15000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201545, 201546, 201547, 201548, 201549}
, bodytype = 1, behaviacAI = "newbattleaif521", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80046] = {id = 80046, name = "雷龙", nameTextID = 1400141, shapeID = 20127, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "58000;58000;58000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201505, 201506, 201507, 201508}
, bodytype = 1, behaviacAI = "newbattleaif520", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80047] = {id = 80047, name = "鲸鲨", nameTextID = 1400141, shapeID = 20123, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "58000;58000;58000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201509, 201510, 201511, 201512, 201513}
, bodytype = 1, behaviacAI = "newbattleaif522", defaultBuff = "20874", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80048] = {id = 80048, name = "中层守卫", nameTextID = 1400141, shapeID = 20122, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "108000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201531, 201532, 201533, 201534}
, bodytype = 1, behaviacAI = "newbattleaif523", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80049] = {id = 80049, name = "恶魔犬", nameTextID = 1400141, shapeID = 20121, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "108000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201527, 201528, 201529, 201530}
, bodytype = 1, behaviacAI = "newbattleaif524", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80050] = {id = 80050, name = "小型守卫", nameTextID = 1400141, shapeID = 20120, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201535, 201536}
, bodytype = 1, behaviacAI = "newbattleaif525", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80051] = {id = 80051, name = "恶魔甲虫", nameTextID = 1400141, shapeID = 20119, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201525, 201526}
, bodytype = 1, behaviacAI = "newbattleaif526", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80052] = {id = 80052, name = "黑化炼金术士", nameTextID = 1400141, shapeID = 20136, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "58000;58000;58000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201561, 201562, 201563, 201564, 201565}
, bodytype = 1, behaviacAI = "newbattleaif527", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80053] = {id = 80053, name = "空之主宰 索拉迪乌斯", nameTextID = 1400145, shapeID = 20130, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "106462;106462;106462", attackConstant = "684", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201570, 201571, 201572, 201573, 201574, 201575}
, bodytype = 1, behaviacAI = "newbattleaif818_body_test", defaultBuff = "20116", MonsterType = 818, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[80054] = {id = 80054, name = "圆盘-1", nameTextID = 1400141, shapeID = 20145, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201622, 201626}
, bodytype = 1, behaviacAI = "NewBattleAITest20", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80055] = {id = 80055, name = "圆盘-2", nameTextID = 1400141, shapeID = 20146, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201623, 201627}
, bodytype = 1, behaviacAI = "NewBattleAITest21", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80056] = {id = 80056, name = "圆盘-3", nameTextID = 1400141, shapeID = 20147, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201624, 201628}
, bodytype = 1, behaviacAI = "NewBattleAITest22", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80057] = {id = 80057, name = "圆盘-4", nameTextID = 1400141, shapeID = 20148, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201625, 201629}
, bodytype = 1, behaviacAI = "NewBattleAITest23", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80058] = {id = 80058, name = "月亮-1", nameTextID = 1400141, shapeID = 20149, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201630, 201634}
, bodytype = 1, behaviacAI = "NewBattleAITest24", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80059] = {id = 80059, name = "月亮-2", nameTextID = 1400141, shapeID = 20150, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201631, 201635}
, bodytype = 1, behaviacAI = "NewBattleAITest25", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80060] = {id = 80060, name = "月亮-3", nameTextID = 1400141, shapeID = 20151, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201632, 201636}
, bodytype = 1, behaviacAI = "NewBattleAITest26", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80061] = {id = 80061, name = "月亮-4", nameTextID = 1400141, shapeID = 20152, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201633, 201637}
, bodytype = 1, behaviacAI = "NewBattleAITest27", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80062] = {id = 80062, name = "牛头人", nameTextID = 1400141, shapeID = 20153, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201638, 201639, 201640}
, bodytype = 1, behaviacAI = "NewBattleAITest28", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80063] = {id = 80063, name = "欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest29", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80064] = {id = 80064, name = "惑魔", nameTextID = 1400183, shapeID = 20158, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201648, 201649}
, bodytype = 1, behaviacAI = "NewBattleAITest30", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80065] = {id = 80065, name = "食魔", nameTextID = 1400184, shapeID = 20159, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201650, 201651}
, bodytype = 1, behaviacAI = "NewBattleAITest31", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80066] = {id = 80066, name = "怠魇", nameTextID = 1400185, shapeID = 20160, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201652, 201653}
, bodytype = 1, behaviacAI = "NewBattleAITest32", defaultBuff = "21198", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80067] = {id = 80067, name = "暴魇", nameTextID = 1400186, shapeID = 20161, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "100000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201654, 201655, 201656}
, bodytype = 1, behaviacAI = "NewBattleAITest33", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80068] = {id = 80068, name = "象魔", nameTextID = 1400187, shapeID = 20162, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201657, 201658, 201659, 201660}
, bodytype = 1, behaviacAI = "NewBattleAITest34", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80069] = {id = 80069, name = "欲魔-欲魔+怠魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "100000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest35", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80070] = {id = 80070, name = "欲魔-暴魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "100000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest36", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80071] = {id = 80071, name = "怠魇-暴魔", nameTextID = 1400185, shapeID = 20160, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "100000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201652, 201653}
, bodytype = 1, behaviacAI = "NewBattleAITest37", defaultBuff = "21198", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80072] = {id = 80072, name = "欲魔-欲魔+食魔+欲魔", nameTextID = 1400182, shapeID = 20157, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "100000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201646, 201647}
, bodytype = 1, behaviacAI = "NewBattleAITest38", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80073] = {id = 80073, name = "隐藏的木桩-测试用1", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan01", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[80074] = {id = 80074, name = "隐藏的木桩-测试用2", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan02", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[80075] = {id = 80075, name = "隐藏的木桩-测试用3", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan03", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[80076] = {id = 80076, name = "隐藏的木桩-测试用4", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan04", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[80077] = {id = 80077, name = "隐藏的木桩-测试用5", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan05", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[80078] = {id = 80078, name = "隐藏的木桩-测试用6", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "1", attackConstant = "0", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201664, 201665}
, bodytype = 1, behaviacAI = "NewBattleAItestLianzhan06", defaultBuff = "21209", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[80079] = {id = 80079, name = "美人鱼", nameTextID = 1400010, shapeID = 20166, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "100000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201685, 201686, 201687}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon01", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[80080] = {id = 80080, name = "珍珠章鱼", nameTextID = 1400010, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "100000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[80081] = {id = 80081, name = "珊瑚龙", nameTextID = 1400010, shapeID = 20168, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "100000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201690, 201691, 201692, 201693}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon03", defaultBuff = "20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[80082] = {id = 80082, name = "珊瑚海马", nameTextID = 1400010, shapeID = 20169, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "100000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201694, 201695}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon04", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[80083] = {id = 80083, name = "开心蟹", nameTextID = 1400010, shapeID = 20170, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "100000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201696}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon05", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[80084] = {id = 80084, name = "木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 1, hpConstant = "30000000", attackConstant = "500", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "40", damagereduce = "0", attackID = 0, 
skillid = {201406, 201407, 201408}
, bodytype = 1, behaviacAI = "newbattleaimuzhuang", defaultBuff = "21392", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80085] = {id = 80085, name = "木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 1, hpConstant = "30000000", attackConstant = "500", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "40", damagereduce = "0", attackID = 0, 
skillid = {201406, 201407, 201408}
, bodytype = 1, behaviacAI = "newbattleaimuzhuang", defaultBuff = "21393", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80086] = {id = 80086, name = "木桩", nameTextID = 1400010, shapeID = 20098, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 1, hpConstant = "30000000", attackConstant = "500", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "40", damagereduce = "0", attackID = 0, 
skillid = {201406, 201407, 201408}
, bodytype = 1, behaviacAI = "newbattleaimuzhuang", defaultBuff = "21394", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80087] = {id = 80087, name = "卫兵", nameTextID = 1400071, shapeID = 20038, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 1, hpConstant = "300000000", attackConstant = "1644", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201099, 201100, 201101}
, bodytype = 1, behaviacAI = "newbattleaif414", defaultBuff = "", MonsterType = 414, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80088] = {id = 80088, name = "小精灵龙", nameTextID = 1400219, shapeID = 20197, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "200", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201740, 201741}
, bodytype = 1, behaviacAI = "NewBattlemonW3_15", defaultBuff = "", MonsterType = 903, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80089] = {id = 80089, name = "精灵龙", nameTextID = 1400220, shapeID = 20198, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "200", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201750, 201751}
, bodytype = 1, behaviacAI = "NewBattlemonW3_16", defaultBuff = "", MonsterType = 904, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80090] = {id = 80090, name = "精灵龙幼体", nameTextID = 1400221, shapeID = 20200, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "200", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201754, 201755, 201740, 201741}
, bodytype = 1, behaviacAI = "NewBattlemonW3_14", defaultBuff = "", MonsterType = 905, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80091] = {id = 80091, name = "魔能之手-风", nameTextID = 1400222, shapeID = 20201, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "200", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201756, 201757}
, bodytype = 1, behaviacAI = "NewBattlemonW3_52", defaultBuff = "", MonsterType = 906, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80092] = {id = 80092, name = "魔能之手-火", nameTextID = 1400223, shapeID = 20202, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "200", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201758, 201759}
, bodytype = 1, behaviacAI = "NewBattlemonW3_53", defaultBuff = "", MonsterType = 907, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80093] = {id = 80093, name = "魔能之手-水", nameTextID = 1400224, shapeID = 20203, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "200", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201760, 201761}
, bodytype = 1, behaviacAI = "NewBattlemonW3_54", defaultBuff = "", MonsterType = 908, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80094] = {id = 80094, name = "混沌分裂体", nameTextID = 1400230, shapeID = 20204, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "10", magicattConstant = "200", magicDefConstant = "10", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201764, 201765}
, bodytype = 1, behaviacAI = "NewBattlemonW6_02", defaultBuff = "", MonsterType = 909, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80095] = {id = 80095, name = "秩序分裂体", nameTextID = 1400231, shapeID = 20205, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "10", magicattConstant = "200", magicDefConstant = "10", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201762, 201763}
, bodytype = 1, behaviacAI = "NewBattlemonW6_03", defaultBuff = "", MonsterType = 910, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80096] = {id = 80096, name = "混沌之子", nameTextID = 1400232, shapeID = 20206, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "10", magicattConstant = "200", magicDefConstant = "10", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201764, 201767, 201769, 201771}
, bodytype = 1, behaviacAI = "NewBattlemonW3_12", defaultBuff = "", MonsterType = 911, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80097] = {id = 80097, name = "秩序之子", nameTextID = 1400233, shapeID = 20207, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "10", magicattConstant = "200", magicDefConstant = "10", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201762, 201766, 201768, 201770}
, bodytype = 1, behaviacAI = "NewBattlemonW3_13", defaultBuff = "", MonsterType = 912, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80098] = {id = 80098, name = "古代机械魔像", nameTextID = 1400234, shapeID = 20208, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "10", magicattConstant = "200", magicDefConstant = "10", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201780, 201781, 201782, 201783, 201784, 201785, 201786, 201787}
, bodytype = 1, behaviacAI = "NewBattlebossW6_4", defaultBuff = "20116;20115", MonsterType = 913, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80099] = {id = 80099, name = "地祇之子", nameTextID = 1400235, shapeID = 20209, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "1000000", attackConstant = "5000", defConstant = "1000", magicattConstant = "0", magicDefConstant = "1000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201860, 201861, 201862, 201863, 201864, 201866, 201867, 201868}
, bodytype = 1, behaviacAI = "NewBattlemonW3_40", defaultBuff = "20116;20115", MonsterType = 914, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80100] = {id = 80100, name = "神族幻术师", nameTextID = 1400236, shapeID = 20210, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "10", magicattConstant = "200", magicDefConstant = "10", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201788, 201789}
, bodytype = 1, behaviacAI = "NewBattlemonW3_01", defaultBuff = "", MonsterType = 915, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80101] = {id = 80101, name = "魔能之手-风", nameTextID = 1400222, shapeID = 20201, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "200", defConstant = "0", magicattConstant = "200", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201756, 201757}
, bodytype = 1, behaviacAI = "NewBattlemonW3_52", defaultBuff = "21624", MonsterType = 906, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80102] = {id = 80102, name = "飞马", nameTextID = 1400237, shapeID = 20213, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "500", defConstant = "0", magicattConstant = "500", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201790, 201791, 201792, 201849}
, bodytype = 1, behaviacAI = "NewBattlemonW6_04", defaultBuff = "20115", MonsterType = 918, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[80103] = {id = 80103, name = "卡蜜莉安1（boss战斗）", nameTextID = 1400228, shapeID = 20211, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1000000;1000000", attackConstant = "5000", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201807, 201808, 201809, 201810, 201812}
, bodytype = 1, behaviacAI = "NewBattlebossW6_1", defaultBuff = "20116;20115", MonsterType = 916, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[80104] = {id = 80104, name = "卡蜜莉安2（boss战斗）", nameTextID = 1400228, shapeID = 20212, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 250, hpConstant = "1000000;1000000", attackConstant = "5000", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201814, 201815, 201816, 201817, 201819, 201821, 201822, 201824, 201825, 201826, 201827}
, bodytype = 1, behaviacAI = "NewBattlebossW6_2", defaultBuff = "20116;21776;20115", MonsterType = 917, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[80105] = {id = 80105, name = "达修斯", nameTextID = 1400239, shapeID = 20215, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "40000", attackConstant = "500", defConstant = "0", magicattConstant = "500", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201850, 201851, 201852, 201853}
, bodytype = 1, behaviacAI = "NewBattlemonW6_023", defaultBuff = "", MonsterType = 919, soulQuantity = 0, MonsterStyle = 2, typeStyle = 0}
, 
[80106] = {id = 80106, name = "地祇之子-二阶段", nameTextID = 1400235, shapeID = 20216, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "1000000", attackConstant = "5000", defConstant = "1000", magicattConstant = "0", magicDefConstant = "1000", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201863, 201864, 201866, 201867}
, bodytype = 1, behaviacAI = "NewBattlemonW3_40", defaultBuff = "20116;20115", MonsterType = 914, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[90001] = {id = 90001, name = "黄史莱姆", nameTextID = 1400121, shapeID = 20025, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 14, hpConstant = "100", attackConstant = "1", defConstant = "1", magicattConstant = "1", magicDefConstant = "1", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201023}
, bodytype = 1, behaviacAI = "newbattleai20012", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[90002] = {id = 90002, name = "绿伞菇", nameTextID = 1400122, shapeID = 20011, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 16, hpConstant = "100", attackConstant = "1", defConstant = "1", magicattConstant = "1", magicDefConstant = "1", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201024}
, bodytype = 1, behaviacAI = "newbattleai20013", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[90003] = {id = 90003, name = "连射藤蔓·粉", nameTextID = 1400123, shapeID = 20012, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 18, hpConstant = "100", attackConstant = "1", defConstant = "1", magicattConstant = "1", magicDefConstant = "1", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201022}
, bodytype = 1, behaviacAI = "newbattleai20011", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[90004] = {id = 90004, name = "黄史莱姆", nameTextID = 1400121, shapeID = 20025, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 14, hpConstant = "100", attackConstant = "1", defConstant = "1", magicattConstant = "1", magicDefConstant = "1", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201023}
, bodytype = 1, behaviacAI = "newbattleai20012", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[90005] = {id = 90005, name = "", nameTextID = 1400124, shapeID = 10049, deadtype = 2, bossOrNot = 1, showhp = 1, levelMode = 4, npcLevel = 30, hpConstant = "1", attackConstant = "1", defConstant = "0", magicattConstant = "1", magicDefConstant = "0", speedConstant = "25", damagereduce = "0", attackID = 0, 
skillid = {6022301, 19022, 6022402, 6022403, 6022404, 6022405}
, bodytype = 1, behaviacAI = "NewBattleAIchar028d", defaultBuff = "20116;21041", MonsterType = 0, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[90006] = {id = 90006, name = "熔岩精灵", nameTextID = 1400125, shapeID = 20097, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 63, hpConstant = "6655", attackConstant = "260", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201388}
, bodytype = 1, behaviacAI = "newbattleaif605_2", defaultBuff = "", MonsterType = 605, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[90007] = {id = 90007, name = "艾迪恩", nameTextID = 1400175, shapeID = 20108, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 40, hpConstant = "3864", attackConstant = "113", defConstant = "1", magicattConstant = "1", magicDefConstant = "1", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201440, 201502, 201612}
, bodytype = 1, behaviacAI = "NewBattleAIfb31", defaultBuff = "20849;20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[90008] = {id = 90008, name = "艾迪恩", nameTextID = 1400175, shapeID = 20108, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 70, hpConstant = "8434", attackConstant = "316", defConstant = "1", magicattConstant = "1", magicDefConstant = "1", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201440, 201502, 201612}
, bodytype = 1, behaviacAI = "NewBattleAIfb31", defaultBuff = "20849;20116", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[90009] = {id = 90009, name = "飞蛇蛋", nameTextID = 1400140, shapeID = 20118, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "8000", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201538, 201487, 201488, 201489}
, bodytype = 1, behaviacAI = "newbattleaif804", defaultBuff = "20116", MonsterType = 804, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[90010] = {id = 90010, name = "飞翼魔狼", nameTextID = 1400139, shapeID = 20107, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "57934", attackConstant = "635", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201444, 201445, 201446, 201447, 201448, 201449}
, bodytype = 1, behaviacAI = "newbattleaif809", defaultBuff = "20116", MonsterType = 809, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[90011] = {id = 90011, name = "飞蛇", nameTextID = 1400142, shapeID = 20111, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "57934", attackConstant = "635", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201493, 201495, 201496, 201497, 201498, 201499, 201500, 201501}
, bodytype = 1, behaviacAI = "newbattleaif813", defaultBuff = "20116", MonsterType = 813, soulQuantity = 0, MonsterStyle = 3, typeStyle = 0}
, 
[90012] = {id = 90012, name = "鲸鲨", nameTextID = 1400156, shapeID = 20123, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 220, hpConstant = "57934", attackConstant = "635", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201509, 201510, 201511, 201512, 201513}
, bodytype = 1, behaviacAI = "newbattleaif815_1", defaultBuff = "20116", MonsterType = 815, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[90013] = {id = 90013, name = "宝珠", nameTextID = 1400158, shapeID = 20128, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "10", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201590, 201591, 201594, 201604}
, bodytype = 1, behaviacAI = "NewBattleAIEquipStaffBall", defaultBuff = "20923;20938", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[90014] = {id = 90014, name = "宝珠", nameTextID = 1400158, shapeID = 20139, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "10", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201590, 201591, 201594, 201604}
, bodytype = 1, behaviacAI = "NewBattleAIEquipStaffBall", defaultBuff = "20923;20938", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[90015] = {id = 90015, name = "宝珠", nameTextID = 1400158, shapeID = 20128, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 20, hpConstant = "10", attackConstant = "200", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201590, 201591, 201594, 201604}
, bodytype = 1, behaviacAI = "NewBattleAIEquipStaffBall", defaultBuff = "20923;20938", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[90016] = {id = 90016, name = "恶魔犬-召唤", nameTextID = 1400180, shapeID = 20137, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 1, hpConstant = "1", attackConstant = "1", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201527, 201528, 201529, 201592}
, bodytype = 1, behaviacAI = "newbattleaif703_1", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[90017] = {id = 90017, name = "浮游龙", nameTextID = 1400150, shapeID = 20109, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 215, hpConstant = "14161", attackConstant = "550", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201473, 201474, 201475}
, bodytype = 1, behaviacAI = "newbattleaif806", defaultBuff = "", MonsterType = 806, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[90018] = {id = 90018, name = "孢子", nameTextID = 1400014, shapeID = 20033, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 75, hpConstant = "1", attackConstant = "1", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201063, 201064, 201661}
, bodytype = 1, behaviacAI = "newbattleaif224", defaultBuff = "", MonsterType = 224, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[90019] = {id = 90019, name = "冰墙", nameTextID = 1400023, shapeID = 20062, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "1", attackConstant = "1", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201661}
, bodytype = 1, behaviacAI = "newbattleaif417", defaultBuff = "20116", MonsterType = 417, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[90020] = {id = 90020, name = "冰蕊", nameTextID = 1400026, shapeID = 20076, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 140, hpConstant = "1", attackConstant = "1", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201211, 201661}
, bodytype = 1, behaviacAI = "newbattleaif418", defaultBuff = "20116", MonsterType = 418, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[90021] = {id = 90021, name = "象魔-镜中人", nameTextID = 1400187, shapeID = 20162, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 115, hpConstant = "93000", attackConstant = "854", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201657, 201658, 201659, 201660}
, bodytype = 1, behaviacAI = "NewBattleAITest39", defaultBuff = "21213", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[90022] = {id = 90022, name = "珍珠章鱼", nameTextID = 1400191, shapeID = 20167, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 170, hpConstant = "342027", attackConstant = "1458", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201688, 201689}
, bodytype = 1, behaviacAI = "NewBattleAISummerMon02", defaultBuff = "", MonsterType = 0, soulQuantity = 0, MonsterStyle = 1, typeStyle = 1}
, 
[90023] = {id = 90023, name = "小精灵龙", nameTextID = 1400219, shapeID = 20197, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "400000", attackConstant = "8000", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201740, 201741}
, bodytype = 1, behaviacAI = "NewBattlemonW3_15", defaultBuff = "", MonsterType = 903, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
, 
[90024] = {id = 90024, name = "魔能之手-风", nameTextID = 1400222, shapeID = 20201, deadtype = 2, bossOrNot = 0, showhp = 1, levelMode = 4, npcLevel = 200, hpConstant = "400000", attackConstant = "8000", defConstant = "0", magicattConstant = "0", magicDefConstant = "0", speedConstant = "30", damagereduce = "0", attackID = 0, 
skillid = {201756, 201757}
, bodytype = 1, behaviacAI = "NewBattlemonW3_52", defaultBuff = "21624", MonsterType = 906, soulQuantity = 0, MonsterStyle = 1, typeStyle = 0}
}
cmonsterconfig.AllIds = {10015, 10016, 10017, 20001, 20003, 20004, 20005, 20007, 20008, 20014, 20015, 20054, 20055, 20056, 20057, 20058, 20130, 20131, 20132, 20143, 20144, 20160, 20161, 20167, 20168, 20174, 20180, 20181, 20182, 20184, 20185, 20186, 20187, 20188, 20189, 20202, 20203, 20204, 20205, 20206, 20207, 20208, 20209, 20210, 20211, 20212, 20213, 20214, 20215, 20216, 20217, 20218, 20219, 20220, 20221, 20222, 20227, 20228, 20229, 20230, 20231, 20232, 20233, 20234, 20235, 20236, 20237, 20238, 20239, 20240, 20241, 20242, 20243, 20244, 20245, 20246, 20247, 29001, 29002, 29003, 29004, 29005, 29006, 29007, 29008, 29009, 29010, 29011, 29012, 29013, 30001, 30002, 30003, 30004, 30005, 30006, 30007, 30008, 30009, 30010, 30011, 30012, 30013, 30014, 30015, 30016, 30017, 30018, 30019, 30020, 30021, 30022, 30023, 30024, 30025, 30026, 30027, 30028, 30029, 30030, 30031, 30032, 30033, 30034, 30035, 30036, 30037, 30038, 30039, 30040, 30041, 30042, 30043, 30044, 30045, 30046, 30047, 30201, 30202, 30203, 30204, 30205, 30206, 30207, 30208, 30209, 30210, 30211, 30212, 30213, 30214, 30215, 30216, 30217, 30218, 30219, 30220, 30221, 30222, 30223, 30224, 30225, 30226, 30227, 30228, 30229, 30230, 30231, 30232, 30233, 30234, 30235, 30236, 30237, 30238, 30239, 30240, 30241, 30242, 30243, 30244, 30245, 30246, 30247, 30248, 30249, 30250, 30251, 30401, 30402, 30403, 30404, 30405, 30406, 30407, 30408, 30409, 30410, 30411, 30412, 30413, 30414, 30415, 30416, 30417, 30418, 30419, 30420, 30421, 30422, 30423, 30424, 30425, 30426, 30427, 30428, 30429, 30430, 30431, 30432, 30434, 30435, 30436, 30437, 30438, 30439, 30440, 30441, 30442, 30443, 30444, 30501, 30502, 30503, 30504, 30505, 30506, 30507, 30508, 30509, 30510, 30511, 30512, 30513, 30514, 30515, 30516, 30517, 30518, 30519, 30520, 30521, 30522, 30523, 30524, 30525, 30526, 30527, 30528, 30529, 30530, 30531, 30532, 30533, 30534, 30535, 30536, 30537, 30538, 30539, 30540, 30541, 30542, 30543, 30544, 30545, 30546, 30547, 30548, 30549, 30550, 30551, 30552, 30553, 30554, 30555, 30556, 30557, 30558, 30559, 30560, 30561, 30562, 30563, 30564, 30565, 30566, 30567, 30568, 30569, 30570, 30571, 30572, 30573, 30574, 30575, 30576, 30577, 30578, 30579, 30580, 30581, 30582, 30583, 30584, 30585, 30586, 30587, 30588, 30589, 30590, 30591, 30592, 30593, 30594, 30595, 30596, 30597, 30598, 30599, 30600, 30601, 30602, 30603, 30604, 30605, 30606, 30607, 30608, 30609, 30610, 30611, 30612, 30613, 30614, 30615, 30616, 30617, 30618, 30619, 30620, 30621, 30622, 30623, 30624, 30625, 30626, 30627, 30628, 30629, 30630, 30631, 30632, 30633, 30634, 30635, 30636, 30637, 30638, 30639, 30640, 30641, 30642, 30643, 30644, 30645, 30646, 30647, 30648, 30649, 30650, 30651, 30652, 30653, 30654, 30655, 30656, 30657, 30658, 30659, 30660, 30661, 30662, 30663, 30664, 30665, 30666, 30667, 30668, 30669, 30670, 30671, 30672, 30673, 30674, 30675, 30676, 30677, 30678, 30679, 30680, 30681, 30682, 30683, 30684, 30685, 60001, 60002, 60003, 60004, 60005, 60006, 60007, 60008, 60009, 60010, 60011, 60012, 60013, 60014, 60015, 60016, 60017, 60018, 60019, 60020, 60021, 60022, 60023, 60024, 60025, 60026, 60027, 60028, 60029, 60030, 60031, 60032, 60033, 60034, 60035, 60036, 60037, 60038, 60039, 60040, 60041, 60042, 60043, 60044, 62001, 62002, 62003, 62004, 62005, 62006, 62007, 62008, 62009, 62010, 62011, 62012, 62013, 62014, 62015, 62016, 62017, 62018, 62019, 62020, 62021, 62022, 62023, 62024, 62025, 62026, 62027, 62028, 62029, 62030, 62031, 62032, 62033, 62034, 62035, 62036, 62037, 62038, 62039, 62040, 62041, 62042, 62043, 62044, 62045, 62046, 62047, 62048, 62049, 62050, 62051, 62052, 62053, 62054, 62055, 62056, 62057, 62058, 62059, 62060, 62061, 62062, 62063, 62064, 62065, 62066, 62067, 62068, 62069, 62070, 62071, 62072, 62073, 62074, 62075, 62076, 62077, 62078, 62079, 62080, 62081, 62082, 62083, 62084, 62085, 62086, 62087, 62088, 62089, 62090, 62091, 62092, 62093, 62094, 62095, 62096, 62097, 62098, 62099, 62100, 62101, 62102, 62103, 62104, 62105, 62106, 62107, 62108, 62109, 62110, 62111, 62112, 62113, 62114, 62115, 62116, 62117, 62118, 62119, 62120, 62121, 62122, 62123, 62124, 62125, 62126, 62127, 62128, 62129, 62130, 62131, 62132, 62133, 62134, 62135, 62136, 62137, 62138, 62139, 62140, 62141, 62142, 62143, 62144, 62145, 62146, 62147, 62148, 62149, 62150, 62151, 62152, 62153, 62154, 62155, 62156, 62157, 62158, 62159, 62160, 62161, 62162, 62163, 62164, 62165, 62166, 62167, 62168, 62169, 62170, 62171, 62172, 62173, 62174, 62175, 62176, 62177, 62178, 62179, 62180, 62181, 62182, 62183, 62184, 62185, 62186, 62187, 62188, 62189, 62190, 62191, 62192, 62193, 62194, 62195, 62196, 62197, 62198, 62199, 62200, 62201, 62202, 62203, 62204, 62205, 62206, 62207, 62208, 62209, 62210, 62211, 62212, 62213, 62214, 62215, 62216, 62217, 62218, 62219, 62220, 62221, 62222, 62223, 62224, 62225, 62226, 62227, 62228, 62229, 62230, 62231, 62232, 62233, 62234, 62235, 62236, 62237, 62238, 62239, 62240, 62241, 62242, 62243, 62244, 62245, 62246, 62247, 63001, 63002, 63003, 63004, 63006, 63008, 63011, 63012, 63013, 63014, 63015, 63016, 63017, 64001, 64002, 64003, 64004, 64005, 64006, 64007, 64008, 65001, 65002, 65003, 65004, 65005, 65006, 65007, 65008, 66001, 66002, 66003, 66004, 66005, 66006, 66007, 66008, 66009, 66010, 66011, 66012, 66013, 66014, 66015, 66016, 66017, 66018, 66019, 66020, 66021, 66022, 66023, 66024, 66025, 66026, 66027, 66028, 66029, 66030, 66031, 66032, 66033, 66034, 66035, 66036, 66037, 66038, 66039, 66040, 66041, 66042, 66043, 66044, 66045, 66046, 66047, 66048, 66049, 66050, 66051, 66052, 66053, 66054, 66055, 66056, 66057, 66058, 66059, 66060, 66061, 66062, 66063, 66064, 66065, 66066, 66067, 66068, 66069, 66070, 66071, 66072, 66073, 66074, 66075, 66076, 66077, 66078, 66079, 66080, 66081, 66082, 66083, 66084, 66085, 66086, 66087, 66088, 66089, 66090, 66091, 66092, 66093, 66094, 66095, 66096, 66097, 66098, 66099, 66100, 66101, 66102, 66103, 66104, 66105, 66106, 66107, 66108, 66109, 66110, 66111, 66112, 66113, 66114, 66115, 66116, 66117, 66118, 66119, 66120, 66121, 66122, 66123, 66124, 66125, 66126, 66127, 66128, 66129, 66130, 66131, 66132, 66133, 66134, 66135, 66136, 66137, 66138, 66139, 66140, 66141, 66142, 66143, 66144, 66145, 66146, 66147, 66148, 66149, 66150, 66151, 66152, 66153, 66154, 66155, 66156, 66157, 66158, 66159, 66160, 66161, 66162, 66163, 66164, 66165, 66166, 66167, 66168, 66169, 66170, 66171, 66172, 66173, 66174, 66175, 66176, 66177, 66178, 66179, 66180, 66181, 66182, 66183, 66184, 66185, 66186, 66187, 66188, 66189, 66190, 66191, 66192, 66193, 66194, 66195, 66196, 66197, 66198, 66199, 66200, 66201, 66202, 66203, 66204, 66205, 66206, 66207, 66208, 66209, 66210, 66211, 66212, 66213, 66214, 66215, 66216, 66217, 66218, 66219, 66220, 66221, 66222, 66223, 66224, 66225, 66226, 66227, 66228, 66229, 66230, 66231, 66232, 66233, 66234, 66235, 66236, 66237, 66238, 66239, 66240, 66241, 66242, 66243, 66244, 66245, 66246, 66247, 66248, 66249, 66250, 66251, 66252, 66253, 66254, 66255, 66256, 66257, 66258, 66259, 66260, 66261, 66262, 66263, 66264, 66265, 66266, 66267, 66268, 66269, 66270, 66271, 66272, 66273, 66274, 66275, 66276, 66277, 66278, 66279, 66280, 66281, 66282, 66283, 66284, 66285, 66286, 66287, 66288, 66289, 66290, 66291, 66292, 66293, 66294, 66295, 66296, 66297, 66298, 66299, 66300, 66301, 66302, 66303, 66304, 66305, 66306, 66307, 66308, 66309, 66310, 66311, 66312, 66313, 66314, 66315, 66316, 66317, 66318, 66319, 66320, 66321, 66322, 66323, 66324, 66325, 66326, 66327, 66328, 66329, 66330, 66331, 66332, 66333, 66334, 66335, 66336, 66337, 66338, 66339, 66340, 66341, 66342, 66343, 66344, 66345, 66346, 66347, 66348, 66349, 66350, 66351, 66352, 66353, 66354, 66355, 66356, 66357, 66358, 66359, 66360, 66361, 66362, 66363, 66364, 66365, 66366, 66367, 66368, 66369, 66370, 66371, 66372, 66373, 66374, 66375, 66376, 66377, 66378, 66379, 66380, 66381, 66382, 66383, 66384, 66385, 66386, 66387, 66388, 66389, 66390, 66391, 66392, 66393, 66394, 66395, 66396, 66397, 66398, 66399, 66400, 66401, 66402, 66403, 66404, 66405, 66406, 66407, 66408, 66409, 66410, 66411, 66412, 66413, 66414, 66415, 66416, 66417, 66418, 66419, 66420, 66421, 66422, 66423, 66424, 66425, 66426, 66427, 66428, 66432, 66433, 66434, 66435, 66436, 66437, 66438, 66439, 66440, 66441, 66442, 66443, 66444, 66445, 66446, 66447, 66448, 66449, 66450, 66451, 66452, 66453, 66454, 66455, 66456, 66457, 66458, 66459, 66460, 66461, 66462, 66463, 66464, 66465, 66466, 66467, 66468, 66469, 66470, 66471, 66472, 66473, 66474, 66475, 66476, 66477, 66478, 66479, 66480, 66481, 66482, 66483, 66484, 66485, 66486, 66487, 66488, 66489, 66490, 66491, 66492, 66493, 66494, 66495, 66496, 66497, 66498, 66499, 66500, 66501, 66502, 66503, 66504, 66505, 66506, 66507, 66508, 66509, 66510, 66511, 66512, 66513, 66514, 66515, 66516, 66517, 66518, 66519, 66520, 66521, 66522, 66523, 66524, 66525, 66526, 66527, 66528, 66529, 66530, 66531, 66532, 66533, 66534, 66535, 66536, 66537, 66538, 66539, 66540, 66541, 66542, 66543, 66544, 66545, 66546, 66547, 66548, 66549, 66550, 66551, 66552, 66553, 66554, 66555, 66556, 66557, 66558, 66559, 66560, 66561, 66562, 66563, 66564, 66565, 66566, 66567, 66568, 66569, 66570, 66571, 66572, 66573, 66574, 66575, 66576, 66577, 66578, 66579, 66580, 66581, 66582, 66583, 66584, 66585, 66586, 66587, 66588, 66589, 66590, 66591, 66592, 66593, 66594, 66595, 66596, 66597, 66598, 66599, 66600, 66601, 66602, 66603, 66604, 66605, 66606, 66607, 66608, 66609, 66610, 66611, 66612, 66613, 66614, 66615, 66616, 66617, 66618, 66619, 66620, 66621, 66622, 66623, 66624, 66625, 66626, 66627, 66628, 66629, 67001, 67002, 67003, 67004, 67011, 67012, 67013, 67014, 67015, 67016, 67017, 67018, 67021, 67022, 67023, 67024, 67025, 67026, 67027, 67028, 67029, 67030, 67031, 67032, 67033, 67034, 67035, 67036, 67037, 67038, 67039, 67040, 67041, 67042, 67043, 67044, 67045, 67046, 67047, 67048, 67049, 67050, 67051, 67052, 67053, 67054, 67055, 67056, 67057, 67058, 67059, 67060, 67061, 67062, 67063, 67064, 67065, 67066, 67067, 67068, 67069, 67070, 67071, 67072, 67073, 67074, 67075, 67076, 67077, 67078, 67079, 67080, 67081, 67082, 67083, 67084, 67085, 67086, 67100, 67101, 67102, 67103, 67104, 67105, 67106, 67107, 67108, 67109, 67110, 67111, 67112, 67113, 67114, 67115, 67116, 67117, 67118, 67119, 67120, 67121, 67122, 67123, 67124, 67125, 67126, 67127, 67128, 67129, 67130, 67131, 67132, 67133, 67134, 67135, 67136, 67137, 67138, 67139, 67140, 67141, 67142, 67143, 67144, 67145, 67146, 67147, 67148, 67149, 67150, 67151, 67152, 67153, 67154, 67155, 67156, 67157, 67158, 67159, 67160, 67161, 67162, 67163, 67164, 67165, 67166, 67167, 67168, 67169, 67170, 67171, 67172, 67173, 67174, 80001, 80002, 80003, 80004, 80005, 80006, 80007, 80008, 80009, 80010, 80011, 80012, 80013, 80014, 80015, 80016, 80017, 80018, 80019, 80020, 80021, 80022, 80023, 80024, 80025, 80026, 80027, 80028, 80029, 80030, 80031, 80032, 80033, 80034, 80035, 80036, 80037, 80038, 80039, 80040, 80041, 80042, 80043, 80044, 80045, 80046, 80047, 80048, 80049, 80050, 80051, 80052, 80053, 80054, 80055, 80056, 80057, 80058, 80059, 80060, 80061, 80062, 80063, 80064, 80065, 80066, 80067, 80068, 80069, 80070, 80071, 80072, 80073, 80074, 80075, 80076, 80077, 80078, 80079, 80080, 80081, 80082, 80083, 80084, 80085, 80086, 80087, 80088, 80089, 80090, 80091, 80092, 80093, 80094, 80095, 80096, 80097, 80098, 80099, 80100, 80101, 80102, 80103, 80104, 80105, 80106, 90001, 90002, 90003, 90004, 90005, 90006, 90007, 90008, 90009, 90010, 90011, 90012, 90013, 90014, 90015, 90016, 90017, 90018, 90019, 90020, 90021, 90022, 90023, 90024}
return cmonsterconfig

