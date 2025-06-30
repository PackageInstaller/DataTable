-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/dungeonselect/cdungeonselectmainline.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cdungeonselectmainline = {}
cdungeonselectmainline.Data = {
[1] = {id = 1, floor = "1-1", sort = 1, name = "时之塔第2层", nameTextID = 1900001, sceneid = 10001, sceneimage = 10243, minEquipLevel = 0, minSkillLevel = 1, magic = 2, unlockLv = 0, describe = "神秘之塔内部隐藏着未知的秘密，魔女决定入塔一探究竟", describeTextID = 1900068, spirit = 6, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {10002, 10003}
, 
chestrewardItems = {35008, 31005, 76000}
, 
chestrewardItemNums = {20, 1, 2}
, 
recommendid = {}
, isBoss = 0, 
monsterid = {102, 103}
, wordId = 0, back = 0}
, 
[2] = {id = 2, floor = "1-2", sort = 2, name = "时之塔第5层", nameTextID = 1900002, sceneid = 10004, sceneimage = 10243, minEquipLevel = 0, minSkillLevel = 1, magic = 3, unlockLv = 0, describe = "黑暗深处散发着危险的气息……", describeTextID = 1900069, spirit = 6, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {10005}
, 
chestrewardItems = {35008, 31008, 76000}
, 
chestrewardItemNums = {20, 1, 2}
, 
recommendid = {}
, isBoss = 1, 
monsterid = {105, 107}
, wordId = 1900460, back = 0}
, 
[3] = {id = 3, floor = "1-3", sort = 3, name = "时之塔第7层", nameTextID = 1900003, sceneid = 10007, sceneimage = 10243, minEquipLevel = 0, minSkillLevel = 1, magic = 6, unlockLv = 0, describe = "即将集齐镜之碎片，很快就能解开疑惑了", describeTextID = 1900070, spirit = 6, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {10009, 10010}
, 
chestrewardItems = {35008, 31011, 76000}
, 
chestrewardItemNums = {20, 1, 2}
, 
recommendid = {}
, isBoss = 1, 
monsterid = {102, 104, 103, 301, 107}
, wordId = 1900460, back = 1}
, 
[4] = {id = 4, floor = "1-4", sort = 4, name = "伊敏瑟伦之间", nameTextID = 1900004, sceneid = 10011, sceneimage = 10243, minEquipLevel = 0, minSkillLevel = 1, magic = 10, unlockLv = 0, describe = "神秘之间，似乎通向未知的世界", describeTextID = 1900071, spirit = 0, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {}
, 
chestrewardItems = {}
, 
chestrewardItemNums = {}
, 
recommendid = {}
, isBoss = 1, 
monsterid = {108}
, wordId = 1900461, back = 0}
, 
[5] = {id = 5, floor = "2-1", sort = 5, name = "森林入口", nameTextID = 1900005, sceneid = 12002, sceneimage = 10244, minEquipLevel = 0, minSkillLevel = 1, magic = 10, unlockLv = 0, describe = "森林的入口", describeTextID = 1900072, spirit = 8, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {12003}
, 
chestrewardItems = {35008, 76000}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {13, 15, 3, 14}
, isBoss = 0, 
monsterid = {214, 210, 218}
, wordId = 1900461, back = 0}
, 
[6] = {id = 6, floor = "2-2", sort = 6, name = "森之西", nameTextID = 1900006, sceneid = 12004, sceneimage = 10244, minEquipLevel = 0, minSkillLevel = 1, magic = 15, unlockLv = 0, describe = "树木疯长的森林西部地区", describeTextID = 1900073, spirit = 8, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {12005}
, 
chestrewardItems = {35008, 31017, 76000}
, 
chestrewardItemNums = {20, 1, 2}
, 
recommendid = {13, 15, 3, 14}
, isBoss = 1, 
monsterid = {214, 210, 206, 220}
, wordId = 1900461, back = 1}
, 
[7] = {id = 7, floor = "2-3", sort = 7, name = "林中空地", nameTextID = 1900007, sceneid = 12006, sceneimage = 10244, minEquipLevel = 0, minSkillLevel = 1, magic = 15, unlockLv = 0, describe = "森林中部的空旷地区", describeTextID = 1900074, spirit = 10, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {12007}
, 
chestrewardItems = {35008, 76000}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {13, 15, 3, 14}
, isBoss = 0, 
monsterid = {210, 218, 206}
, wordId = 1900462, back = 0}
, 
[8] = {id = 8, floor = "2-4", sort = 8, name = "商业区入口", nameTextID = 1900008, sceneid = 12008, sceneimage = 10244, minEquipLevel = 5, minSkillLevel = 1, magic = 20, unlockLv = 0, describe = "曾经热闹繁华的商业区的入口", describeTextID = 1900075, spirit = 10, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {12009}
, 
chestrewardItems = {35008, 76000}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {13, 15, 3, 14}
, isBoss = 0, 
monsterid = {214, 201, 206}
, wordId = 1900462, back = 0}
, 
[9] = {id = 9, floor = "2-5", sort = 9, name = "商业区", nameTextID = 1900009, sceneid = 12010, sceneimage = 10244, minEquipLevel = 5, minSkillLevel = 1, magic = 25, unlockLv = 0, describe = "商业区的中心地区", describeTextID = 1900076, spirit = 10, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {12011}
, 
chestrewardItems = {35008, 76000}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {13, 15, 3, 14}
, isBoss = 0, 
monsterid = {210, 209, 213, 212}
, wordId = 1900463, back = 0}
, 
[10] = {id = 10, floor = "2-6", sort = 10, name = "商业区南", nameTextID = 1900010, sceneid = 12012, sceneimage = 10244, minEquipLevel = 5, minSkillLevel = 2, magic = 35, unlockLv = 0, describe = "商业区的南部地区", describeTextID = 1900077, spirit = 12, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {12013}
, 
chestrewardItems = {35008, 31005, 76000}
, 
chestrewardItemNums = {20, 1, 2}
, 
recommendid = {11, 8, 13, 15, 3}
, isBoss = 1, 
monsterid = {201, 218, 212, 220, 222, 221}
, wordId = 1900463, back = 1}
, 
[11] = {id = 11, floor = "2-7", sort = 11, name = "哨戒营", nameTextID = 1900011, sceneid = 12014, sceneimage = 10244, minEquipLevel = 5, minSkillLevel = 2, magic = 35, unlockLv = 0, describe = "哨戒营内部区域", describeTextID = 1900078, spirit = 12, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {12015}
, 
chestrewardItems = {35008, 76000}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {13, 15, 3, 14}
, isBoss = 0, 
monsterid = {206, 208, 219}
, wordId = 1900463, back = 0}
, 
[12] = {id = 12, floor = "2-8", sort = 12, name = "沼", nameTextID = 1900012, sceneid = 12016, sceneimage = 10244, minEquipLevel = 5, minSkillLevel = 2, magic = 40, unlockLv = 0, describe = "四周被沼泽包围的密林地区", describeTextID = 1900079, spirit = 12, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {12017}
, 
chestrewardItems = {35008, 31008, 76000}
, 
chestrewardItemNums = {20, 1, 2}
, 
recommendid = {1, 7, 15, 11}
, isBoss = 1, 
monsterid = {218, 212, 213, 220, 223}
, wordId = 1900463, back = 1}
, 
[13] = {id = 13, floor = "2-9", sort = 13, name = "近卫营外围", nameTextID = 1900013, sceneid = 12018, sceneimage = 10244, minEquipLevel = 5, minSkillLevel = 2, magic = 45, unlockLv = 0, describe = "近卫营的外围，近卫武士们曾在此训练", describeTextID = 1900080, spirit = 14, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {12019}
, 
chestrewardItems = {35008, 76000}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {13, 15, 3, 14}
, isBoss = 0, 
monsterid = {219, 209, 222, 221}
, wordId = 1901718, back = 0}
, 
[14] = {id = 14, floor = "2-10", sort = 14, name = "祭祀场外围", nameTextID = 1900014, sceneid = 12020, sceneimage = 10244, minEquipLevel = 10, minSkillLevel = 2, magic = 50, unlockLv = 0, describe = "祭祀场的外围，看着残垣断壁，可以想象出昔日的盛世", describeTextID = 1900081, spirit = 14, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {12021}
, 
chestrewardItems = {35008, 31011, 76000}
, 
chestrewardItemNums = {20, 1, 2}
, 
recommendid = {1, 7, 15, 14}
, isBoss = 1, 
monsterid = {208, 212, 213, 209, 227}
, wordId = 1901718, back = 1}
, 
[15] = {id = 15, floor = "2-11", sort = 15, name = "艾琳岛", nameTextID = 1900015, sceneid = 12022, sceneimage = 10244, minEquipLevel = 10, minSkillLevel = 2, magic = 50, unlockLv = 0, describe = "地平线的尽头，三面环水的小岛", describeTextID = 1900082, spirit = 14, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {12023}
, 
chestrewardItems = {35008, 76000}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {13, 15, 3, 14}
, isBoss = 0, 
monsterid = {219, 208, 222}
, wordId = 1901718, back = 0}
, 
[16] = {id = 16, floor = "2-12", sort = 16, name = "巨木外围", nameTextID = 1900016, sceneid = 12024, sceneimage = 10244, minEquipLevel = 10, minSkillLevel = 2, magic = 60, unlockLv = 0, describe = "巨大遗迹的入口", describeTextID = 1900083, spirit = 16, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {}
, 
chestrewardItems = {35008, 76000}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {13, 15, 3, 14}
, isBoss = 0, 
monsterid = {219, 208, 209}
, wordId = 1901718, back = 0}
, 
[17] = {id = 17, floor = "2-13", sort = 17, name = "巨木", nameTextID = 1900017, sceneid = 12025, sceneimage = 10244, minEquipLevel = 10, minSkillLevel = 2, magic = 75, unlockLv = 0, describe = "守护者的御座就在巨大树木的根部", describeTextID = 1900084, spirit = 1, 
firstItems = {35008, 31091}
, 
firstItemNums = {30, 1}
, 
itemid = {}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {}
, 
chestrewardItems = {}
, 
chestrewardItemNums = {}
, 
recommendid = {14, 9, 15, 3}
, isBoss = 1, 
monsterid = {228}
, wordId = 1901718, back = 0}
, 
[18] = {id = 18, floor = "2.5-1", sort = 18, name = "时之塔第11层", nameTextID = 1900018, sceneid = 10012, sceneimage = 10243, minEquipLevel = 15, minSkillLevel = 2, magic = 75, unlockLv = 5, describe = "时之塔第11层", describeTextID = 1900085, spirit = 16, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {10013}
, 
chestrewardItems = {35008, 76001}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {3, 14, 9, 15}
, isBoss = 0, 
monsterid = {102, 104, 301, 304, 303}
, wordId = 1901718, back = 0}
, 
[19] = {id = 19, floor = "2.5-2", sort = 19, name = "时之塔第13层", nameTextID = 1900019, sceneid = 10014, sceneimage = 10243, minEquipLevel = 15, minSkillLevel = 3, magic = 80, unlockLv = 5, describe = "时之塔第13层", describeTextID = 1900086, spirit = 16, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {10015}
, 
chestrewardItems = {35008, 31017, 76001}
, 
chestrewardItemNums = {20, 1, 2}
, 
recommendid = {3, 14, 1, 15}
, isBoss = 1, 
monsterid = {103, 105, 306}
, wordId = 1901718, back = 1}
, 
[20] = {id = 20, floor = "2.5-3", sort = 20, name = "时之塔第15层", nameTextID = 1900020, sceneid = 10016, sceneimage = 10243, minEquipLevel = 15, minSkillLevel = 3, magic = 80, unlockLv = 5, describe = "时之塔第15层", describeTextID = 1900087, spirit = 18, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {10017}
, 
chestrewardItems = {35008, 76001}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {3, 14, 9, 15}
, isBoss = 0, 
monsterid = {301, 302, 105}
, wordId = 1901718, back = 0}
, 
[21] = {id = 21, floor = "2.5-4", sort = 21, name = "时之塔第17层", nameTextID = 1900021, sceneid = 10018, sceneimage = 10243, minEquipLevel = 15, minSkillLevel = 3, magic = 85, unlockLv = 5, describe = "时之塔第17层", describeTextID = 1900088, spirit = 18, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {10019}
, 
chestrewardItems = {35008, 76001}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {3, 14, 9, 15}
, isBoss = 0, 
monsterid = {302, 304, 303, 305}
, wordId = 1901718, back = 0}
, 
[22] = {id = 22, floor = "2.5-5", sort = 22, name = "时之塔第19层", nameTextID = 1900022, sceneid = 10020, sceneimage = 10243, minEquipLevel = 15, minSkillLevel = 3, magic = 85, unlockLv = 5, describe = "时之塔第19层", describeTextID = 1900089, spirit = 18, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {}
, 
chestrewardItems = {35008, 76001}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {3, 14, 9, 15}
, isBoss = 0, 
monsterid = {302, 305}
, wordId = 1901718, back = 0}
, 
[23] = {id = 23, floor = "2.5-6", sort = 23, name = "谢波契卡之间", nameTextID = 1900023, sceneid = 10021, sceneimage = 10243, minEquipLevel = 15, minSkillLevel = 3, magic = 85, unlockLv = 5, describe = "神秘之间，似乎通向未知的世界", describeTextID = 1900090, spirit = 1, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {}
, 
chestrewardItems = {35008, 76001}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {}
, isBoss = 0, 
monsterid = {}
, wordId = 1901718, back = 0}
, 
[24] = {id = 24, floor = "3-1", sort = 24, name = "山脚", nameTextID = 1900024, sceneid = 13001, sceneimage = 10244, minEquipLevel = 25, minSkillLevel = 3, magic = 90, unlockLv = 5, describe = "谢波契卡的山脚", describeTextID = 1900091, spirit = 20, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {13002}
, 
chestrewardItems = {35008, 76001}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {3, 1, 8, 15, 11}
, isBoss = 0, 
monsterid = {409, 410}
, wordId = 1901718, back = 0}
, 
[25] = {id = 25, floor = "3-2", sort = 25, name = "村外冰原·南部", nameTextID = 1900025, sceneid = 13003, sceneimage = 10244, minEquipLevel = 25, minSkillLevel = 3, magic = 90, unlockLv = 5, describe = "村外冰原的南部地区", describeTextID = 1900092, spirit = 20, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {13004}
, 
chestrewardItems = {35008, 76001}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {3, 1, 8, 15, 11}
, isBoss = 0, 
monsterid = {410, 405, 409, 404}
, wordId = 1901718, back = 0}
, 
[26] = {id = 26, floor = "3-3", sort = 26, name = "村外冰原·东部", nameTextID = 1900026, sceneid = 13005, sceneimage = 10244, minEquipLevel = 25, minSkillLevel = 3, magic = 95, unlockLv = 5, describe = "村外冰原的东部地区", describeTextID = 1900093, spirit = 20, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {13006}
, 
chestrewardItems = {35008, 76001}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {3, 1, 8, 15, 11}
, isBoss = 0, 
monsterid = {401, 405, 404, 406}
, wordId = 1901718, back = 0}
, 
[27] = {id = 27, floor = "3-4", sort = 27, name = "山脚猎场·南部", nameTextID = 1900027, sceneid = 13007, sceneimage = 10244, minEquipLevel = 25, minSkillLevel = 3, magic = 95, unlockLv = 5, describe = "山脚猎场的南部地区", describeTextID = 1900094, spirit = 20, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {13008}
, 
chestrewardItems = {35008, 31005, 76001}
, 
chestrewardItemNums = {20, 1, 2}
, 
recommendid = {3, 1, 8, 15, 11}
, isBoss = 0, 
monsterid = {410, 411, 401, 409}
, wordId = 1901718, back = 0}
, 
[28] = {id = 28, floor = "3-5", sort = 28, name = "山脚猎场·北部", nameTextID = 1900028, sceneid = 13009, sceneimage = 10244, minEquipLevel = 25, minSkillLevel = 3, magic = 100, unlockLv = 5, describe = "山脚猎场的北部地区", describeTextID = 1900095, spirit = 20, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {13010}
, 
chestrewardItems = {35008, 31008, 76001}
, 
chestrewardItemNums = {20, 1, 2}
, 
recommendid = {8, 7, 15, 11}
, isBoss = 1, 
monsterid = {405, 404, 402}
, wordId = 1901718, back = 1}
, 
[29] = {id = 29, floor = "3-6", sort = 29, name = "冰湖猎场·前段", nameTextID = 1900029, sceneid = 13011, sceneimage = 10244, minEquipLevel = 25, minSkillLevel = 3, magic = 110, unlockLv = 5, describe = "冰湖猎场的外部地区", describeTextID = 1900096, spirit = 20, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {13012}
, 
chestrewardItems = {35008, 76001}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {3, 1, 8, 15, 11}
, isBoss = 0, 
monsterid = {410, 409, 408, 411}
, wordId = 1900476, back = 0}
, 
[30] = {id = 30, floor = "3-7", sort = 30, name = "冰湖猎场·后段", nameTextID = 1900030, sceneid = 13013, sceneimage = 10244, minEquipLevel = 25, minSkillLevel = 3, magic = 115, unlockLv = 5, describe = "冰湖猎场的核心区域", describeTextID = 1900097, spirit = 20, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {13014}
, 
chestrewardItems = {35008, 31011, 76001}
, 
chestrewardItemNums = {20, 1, 2}
, 
recommendid = {11, 7, 9, 15}
, isBoss = 1, 
monsterid = {401, 402, 404, 420}
, wordId = 1900476, back = 1}
, 
[31] = {id = 31, floor = "3-8", sort = 31, name = "山腰冰原", nameTextID = 1900031, sceneid = 13015, sceneimage = 10244, minEquipLevel = 25, minSkillLevel = 3, magic = 115, unlockLv = 5, describe = "半山腰的冰原，积雪覆盖", describeTextID = 1900098, spirit = 20, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {13016}
, 
chestrewardItems = {35008, 76001}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {3, 1, 8, 15, 11}
, isBoss = 0, 
monsterid = {401, 411, 408}
, wordId = 1900476, back = 0}
, 
[32] = {id = 32, floor = "3-9", sort = 32, name = "山腰岔路", nameTextID = 1900032, sceneid = 13017, sceneimage = 10244, minEquipLevel = 25, minSkillLevel = 3, magic = 120, unlockLv = 5, describe = "半山腰的岔路", describeTextID = 1900099, spirit = 20, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {13018}
, 
chestrewardItems = {35008, 76001}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {3, 1, 8, 15, 11}
, isBoss = 0, 
monsterid = {405, 402}
, wordId = 1900476, back = 0}
, 
[33] = {id = 33, floor = "3-10", sort = 33, name = "洞窟出口", nameTextID = 1900033, sceneid = 13019, sceneimage = 10244, minEquipLevel = 25, minSkillLevel = 3, magic = 120, unlockLv = 5, describe = "半山腰的洞窟，能够暂避风雪", describeTextID = 1900100, spirit = 20, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {13020}
, 
chestrewardItems = {35008, 31014, 76001}
, 
chestrewardItemNums = {20, 1, 2}
, 
recommendid = {11, 7, 9, 15}
, isBoss = 0, 
monsterid = {413, 403, 415}
, wordId = 1900476, back = 0}
, 
[34] = {id = 34, floor = "3-11", sort = 34, name = "冰封之路", nameTextID = 1900034, sceneid = 13021, sceneimage = 10244, minEquipLevel = 25, minSkillLevel = 3, magic = 125, unlockLv = 5, describe = "完全被冰雪覆盖的道路", describeTextID = 1900101, spirit = 20, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {13022}
, 
chestrewardItems = {35008, 31017, 76001}
, 
chestrewardItemNums = {20, 1, 2}
, 
recommendid = {11, 7, 9, 15}
, isBoss = 1, 
monsterid = {402, 411, 408, 416}
, wordId = 1900476, back = 1}
, 
[35] = {id = 35, floor = "3-12", sort = 35, name = "骑士团营地", nameTextID = 1900035, sceneid = 13023, sceneimage = 10244, minEquipLevel = 25, minSkillLevel = 3, magic = 130, unlockLv = 5, describe = "冰雪骑士团的营地", describeTextID = 1900102, spirit = 20, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {13024}
, 
chestrewardItems = {35008, 76001}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {3, 1, 8, 15, 11}
, isBoss = 0, 
monsterid = {413, 414}
, wordId = 1900476, back = 0}
, 
[36] = {id = 36, floor = "3-13", sort = 36, name = "崎岖山路", nameTextID = 1900036, sceneid = 13025, sceneimage = 10244, minEquipLevel = 25, minSkillLevel = 3, magic = 130, unlockLv = 5, describe = "陡峭的山崖间的小路", describeTextID = 1900103, spirit = 20, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {13026}
, 
chestrewardItems = {35008, 76001}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {3, 1, 8, 15, 11}
, isBoss = 0, 
monsterid = {402, 403, 705}
, wordId = 1900476, back = 0}
, 
[37] = {id = 37, floor = "3-14", sort = 37, name = "冰封湖面", nameTextID = 1900037, sceneid = 13027, sceneimage = 10244, minEquipLevel = 25, minSkillLevel = 3, magic = 130, unlockLv = 5, describe = "完全冻住的湖面，往来行走完全没问题", describeTextID = 1900104, spirit = 20, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {13028}
, 
chestrewardItems = {35008, 31005, 76001}
, 
chestrewardItemNums = {20, 1, 2}
, 
recommendid = {11, 7, 9, 15}
, isBoss = 0, 
monsterid = {403, 414, 412, 420}
, wordId = 1900476, back = 0}
, 
[38] = {id = 38, floor = "3-15", sort = 38, name = "山顶冰原", nameTextID = 1900038, sceneid = 13029, sceneimage = 10244, minEquipLevel = 25, minSkillLevel = 3, magic = 135, unlockLv = 5, describe = "山顶的平原，积雪越来越深", describeTextID = 1900105, spirit = 20, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {13030}
, 
chestrewardItems = {35008, 31008, 76001}
, 
chestrewardItemNums = {20, 1, 2}
, 
recommendid = {11, 7, 1, 15}
, isBoss = 1, 
monsterid = {403, 412, 419}
, wordId = 1900476, back = 1}
, 
[39] = {id = 39, floor = "3-16", sort = 39, name = "入口小路", nameTextID = 1900039, sceneid = 13031, sceneimage = 10244, minEquipLevel = 25, minSkillLevel = 3, magic = 135, unlockLv = 5, describe = "冰雪城堡前段的小路", describeTextID = 1900106, spirit = 20, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {13032}
, 
chestrewardItems = {35008, 76001}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {3, 1, 8, 15, 11}
, isBoss = 0, 
monsterid = {414, 413, 415}
, wordId = 1900484, back = 0}
, 
[40] = {id = 40, floor = "3-17", sort = 40, name = "城堡中段", nameTextID = 1900040, sceneid = 13033, sceneimage = 10244, minEquipLevel = 25, minSkillLevel = 3, magic = 135, unlockLv = 5, describe = "冰雪城堡的中段", describeTextID = 1900107, spirit = 20, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {13034}
, 
chestrewardItems = {35008, 76001}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {3, 1, 8, 15, 11}
, isBoss = 0, 
monsterid = {414, 413, 416}
, wordId = 1900484, back = 0}
, 
[41] = {id = 41, floor = "3-18", sort = 41, name = "圣女广场", nameTextID = 1900041, sceneid = 13035, sceneimage = 10244, minEquipLevel = 25, minSkillLevel = 4, magic = 140, unlockLv = 5, describe = "守护者所在之地，广场中央有一个大大的魔法阵", describeTextID = 1900108, spirit = 1, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {}
, 
chestrewardItems = {}
, 
chestrewardItemNums = {}
, 
recommendid = {11, 9, 13, 15}
, isBoss = 1, 
monsterid = {421}
, wordId = 1900484, back = 0}
, 
[42] = {id = 42, floor = "3.5-1", sort = 42, name = "时之塔第21层", nameTextID = 1900042, sceneid = 10022, sceneimage = 10243, minEquipLevel = 30, minSkillLevel = 4, magic = 140, unlockLv = 12, describe = "时之塔第21层", describeTextID = 1900109, spirit = 22, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {10023}
, 
chestrewardItems = {35008, 76001}
, 
chestrewardItemNums = {20, 3}
, 
recommendid = {2, 9, 15, 14, 10}
, isBoss = 0, 
monsterid = {501, 302, 305, 504}
, wordId = 0, back = 0}
, 
[43] = {id = 43, floor = "3.5-2", sort = 43, name = "时之塔第23层", nameTextID = 1900043, sceneid = 10024, sceneimage = 10243, minEquipLevel = 30, minSkillLevel = 4, magic = 145, unlockLv = 12, describe = "时之塔第23层", describeTextID = 1900110, spirit = 22, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {10025}
, 
chestrewardItems = {35008, 31014, 76001}
, 
chestrewardItemNums = {20, 1, 3}
, 
recommendid = {2, 9, 15, 14, 10}
, isBoss = 1, 
monsterid = {502, 503, 305, 505}
, wordId = 0, back = 1}
, 
[44] = {id = 44, floor = "3.5-3", sort = 44, name = "时之塔第25层", nameTextID = 1900044, sceneid = 10026, sceneimage = 10243, minEquipLevel = 30, minSkillLevel = 4, magic = 145, unlockLv = 12, describe = "时之塔第25层", describeTextID = 1900111, spirit = 22, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {10027}
, 
chestrewardItems = {35008, 31017, 76001}
, 
chestrewardItemNums = {20, 1, 3}
, 
recommendid = {2, 9, 15, 14, 10}
, isBoss = 0, 
monsterid = {501, 502, 504}
, wordId = 0, back = 0}
, 
[45] = {id = 45, floor = "3.5-4", sort = 45, name = "时之塔第27层", nameTextID = 1900045, sceneid = 10028, sceneimage = 10243, minEquipLevel = 30, minSkillLevel = 4, magic = 150, unlockLv = 12, describe = "时之塔第27层", describeTextID = 1900112, spirit = 22, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {10029}
, 
chestrewardItems = {35008, 76001}
, 
chestrewardItemNums = {20, 3}
, 
recommendid = {2, 9, 15, 14, 10}
, isBoss = 0, 
monsterid = {503, 501, 504}
, wordId = 0, back = 0}
, 
[46] = {id = 46, floor = "3.5-5", sort = 46, name = "时之塔第29层", nameTextID = 1900046, sceneid = 10030, sceneimage = 10243, minEquipLevel = 30, minSkillLevel = 4, magic = 150, unlockLv = 12, describe = "时之塔第29层", describeTextID = 1900113, spirit = 22, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {}
, 
chestrewardItems = {35008, 76001}
, 
chestrewardItemNums = {20, 3}
, 
recommendid = {2, 9, 15, 14, 10}
, isBoss = 0, 
monsterid = {503, 502}
, wordId = 0, back = 0}
, 
[47] = {id = 47, floor = "3.5-6", sort = 47, name = "逆之间", nameTextID = 1900047, sceneid = 10031, sceneimage = 10243, minEquipLevel = 30, minSkillLevel = 4, magic = 150, unlockLv = 12, describe = "神秘之间，似乎通向未知的世界", describeTextID = 1900114, spirit = 1, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {}
, 
chestrewardItems = {35008, 31005, 76001}
, 
chestrewardItemNums = {20, 1, 3}
, 
recommendid = {2, 1, 9, 15, 14}
, isBoss = 1, 
monsterid = {506}
, wordId = 0, back = 0}
, 
[48] = {id = 48, floor = "4-1", sort = 48, name = "山脚", nameTextID = 1900048, sceneid = 14001, sceneimage = 10244, minEquipLevel = 30, minSkillLevel = 4, magic = 160, unlockLv = 12, describe = "谢波契卡的山脚", describeTextID = 1900115, spirit = 24, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {14002}
, 
chestrewardItems = {35008, 76002}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {3, 16, 17, 11, 4}
, isBoss = 0, 
monsterid = {604, 603}
, wordId = 0, back = 0}
, 
[49] = {id = 49, floor = "4-2", sort = 49, name = "山底结界", nameTextID = 1900049, sceneid = 14003, sceneimage = 10244, minEquipLevel = 30, minSkillLevel = 4, magic = 160, unlockLv = 12, describe = "村外冰原的南部地区", describeTextID = 1900116, spirit = 24, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {14004}
, 
chestrewardItems = {35008, 76002}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {3, 16, 17, 11, 4}
, isBoss = 0, 
monsterid = {604, 603}
, wordId = 0, back = 0}
, 
[50] = {id = 50, floor = "4-3", sort = 50, name = "村外冰原·东部", nameTextID = 1900050, sceneid = 14005, sceneimage = 10244, minEquipLevel = 30, minSkillLevel = 4, magic = 170, unlockLv = 12, describe = "村外冰原的东部地区", describeTextID = 1900117, spirit = 24, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {14006}
, 
chestrewardItems = {35008, 31008, 76002}
, 
chestrewardItemNums = {20, 1, 2}
, 
recommendid = {11, 7, 15, 17, 4}
, isBoss = 1, 
monsterid = {601, 602, 412, 420}
, wordId = 0, back = 1}
, 
[51] = {id = 51, floor = "4-4", sort = 51, name = "山脚猎场·前段", nameTextID = 1900051, sceneid = 14007, sceneimage = 10244, minEquipLevel = 30, minSkillLevel = 4, magic = 170, unlockLv = 12, describe = "山脚猎场的外部区域", describeTextID = 1900118, spirit = 24, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {14008}
, 
chestrewardItems = {35008, 31011, 76002}
, 
chestrewardItemNums = {20, 1, 2}
, 
recommendid = {3, 16, 17, 11, 4}
, isBoss = 0, 
monsterid = {405, 606}
, wordId = 0, back = 0}
, 
[52] = {id = 52, floor = "4-5", sort = 52, name = "猎场结界·前段", nameTextID = 1900052, sceneid = 14009, sceneimage = 10244, minEquipLevel = 30, minSkillLevel = 4, magic = 170, unlockLv = 12, describe = "山脚猎场的外部区域", describeTextID = 1900119, spirit = 24, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {14010}
, 
chestrewardItems = {35008, 76002}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {3, 16, 17, 11, 4}
, isBoss = 0, 
monsterid = {405, 601, 412}
, wordId = 0, back = 0}
, 
[53] = {id = 53, floor = "4-6", sort = 53, name = "冰湖猎场·前段", nameTextID = 1900053, sceneid = 14011, sceneimage = 10244, minEquipLevel = 30, minSkillLevel = 4, magic = 175, unlockLv = 12, describe = "冰湖猎场的外部区域", describeTextID = 1900120, spirit = 24, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {14012}
, 
chestrewardItems = {35008, 31014, 76002}
, 
chestrewardItemNums = {20, 1, 2}
, 
recommendid = {3, 16, 17, 11, 4}
, isBoss = 1, 
monsterid = {403, 413, 415, 414}
, wordId = 0, back = 1}
, 
[54] = {id = 54, floor = "4-7", sort = 54, name = "山腰小路", nameTextID = 1900054, sceneid = 14013, sceneimage = 10244, minEquipLevel = 30, minSkillLevel = 4, magic = 175, unlockLv = 12, describe = "通往山腰冰原的小路", describeTextID = 1900121, spirit = 24, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {14014}
, 
chestrewardItems = {35008, 76002}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {3, 16, 17, 11, 4}
, isBoss = 0, 
monsterid = {602, 601, 403}
, wordId = 0, back = 0}
, 
[55] = {id = 55, floor = "4-8", sort = 55, name = "山腰结界·前段", nameTextID = 1900055, sceneid = 14015, sceneimage = 10244, minEquipLevel = 30, minSkillLevel = 4, magic = 180, unlockLv = 12, describe = "山腰结界的外部区域", describeTextID = 1900122, spirit = 24, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {14016}
, 
chestrewardItems = {35008, 31017, 76002}
, 
chestrewardItemNums = {20, 1, 2}
, 
recommendid = {14, 18, 15, 4}
, isBoss = 1, 
monsterid = {413, 414, 416, 421}
, wordId = 0, back = 1}
, 
[56] = {id = 56, floor = "4-9", sort = 56, name = "结界外小路", nameTextID = 1900056, sceneid = 14017, sceneimage = 10244, minEquipLevel = 30, minSkillLevel = 4, magic = 180, unlockLv = 12, describe = "山腰结界外面的已一条小路", describeTextID = 1900123, spirit = 24, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {14018}
, 
chestrewardItems = {35008, 76002}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {}
, isBoss = 0, 
monsterid = {}
, wordId = 0, back = 0}
, 
[57] = {id = 57, floor = "4-10", sort = 57, name = "冰封之路", nameTextID = 1900057, sceneid = 14019, sceneimage = 10244, minEquipLevel = 30, minSkillLevel = 4, magic = 185, unlockLv = 12, describe = "完全被冰雪覆盖的道路", describeTextID = 1900124, spirit = 24, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {14020}
, 
chestrewardItems = {35008, 31005, 76002}
, 
chestrewardItemNums = {20, 1, 2}
, 
recommendid = {3, 16, 17, 11, 4}
, isBoss = 0, 
monsterid = {414, 413, 606}
, wordId = 0, back = 0}
, 
[58] = {id = 58, floor = "4-11", sort = 58, name = "骑士团营地", nameTextID = 1900058, sceneid = 14021, sceneimage = 10244, minEquipLevel = 30, minSkillLevel = 4, magic = 190, unlockLv = 12, describe = "冰雪骑士团的营地", describeTextID = 1900125, spirit = 24, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {14022}
, 
chestrewardItems = {35008, 31008, 76002}
, 
chestrewardItemNums = {20, 1, 2}
, 
recommendid = {18, 16, 17, 11, 4}
, isBoss = 1, 
monsterid = {602, 412, 608}
, wordId = 0, back = 1}
, 
[59] = {id = 59, floor = "4-12", sort = 59, name = "冰封湖面", nameTextID = 1900059, sceneid = 14023, sceneimage = 10244, minEquipLevel = 30, minSkillLevel = 4, magic = 190, unlockLv = 12, describe = "完全冻住的湖面，往来行走完全没问题", describeTextID = 1900126, spirit = 24, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {14024}
, 
chestrewardItems = {35008, 76002}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {3, 16, 17, 11, 4}
, isBoss = 0, 
monsterid = {602, 601}
, wordId = 0, back = 0}
, 
[60] = {id = 60, floor = "4-13", sort = 60, name = "城堡入口", nameTextID = 1900060, sceneid = 14025, sceneimage = 10244, minEquipLevel = 30, minSkillLevel = 4, magic = 190, unlockLv = 12, describe = "通往冰雪城堡的入口", describeTextID = 1900127, spirit = 24, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {14026}
, 
chestrewardItems = {35008, 76002}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {3, 16, 17, 11, 4}
, isBoss = 0, 
monsterid = {603, 604, 412}
, wordId = 0, back = 0}
, 
[61] = {id = 61, floor = "4-14", sort = 61, name = "城堡前段", nameTextID = 1900061, sceneid = 14027, sceneimage = 10244, minEquipLevel = 30, minSkillLevel = 4, magic = 190, unlockLv = 12, describe = "冰雪城堡的前段", describeTextID = 1900128, spirit = 24, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {14028}
, 
chestrewardItems = {35008, 31011, 76002}
, 
chestrewardItemNums = {20, 1, 2}
, 
recommendid = {18, 2, 16, 11}
, isBoss = 1, 
monsterid = {609}
, wordId = 0, back = 1}
, 
[62] = {id = 62, floor = "4-15", sort = 62, name = "地下洞穴-1", nameTextID = 1900062, sceneid = 14029, sceneimage = 10244, minEquipLevel = 30, minSkillLevel = 4, magic = 195, unlockLv = 12, describe = "地下洞穴的外部区域", describeTextID = 1900129, spirit = 24, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {14030}
, 
chestrewardItems = {35008, 76002}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {16, 8, 14, 4, 6}
, isBoss = 0, 
monsterid = {605, 606}
, wordId = 0, back = 0}
, 
[63] = {id = 63, floor = "4-16", sort = 63, name = "地下洞穴-3", nameTextID = 1900063, sceneid = 14031, sceneimage = 10244, minEquipLevel = 30, minSkillLevel = 4, magic = 195, unlockLv = 12, describe = "地下洞穴中段区域", describeTextID = 1900130, spirit = 24, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {14032}
, 
chestrewardItems = {35008, 76002}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {16, 8, 14, 4, 6}
, isBoss = 0, 
monsterid = {606, 605, 607, 608}
, wordId = 0, back = 0}
, 
[64] = {id = 64, floor = "4-17", sort = 64, name = "地下洞穴-5", nameTextID = 1900064, sceneid = 14033, sceneimage = 10244, minEquipLevel = 30, minSkillLevel = 4, magic = 195, unlockLv = 12, describe = "地下洞穴内部区域", describeTextID = 1900131, spirit = 24, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74003}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {14034}
, 
chestrewardItems = {35008, 76002}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {16, 8, 14, 4, 6}
, isBoss = 0, 
monsterid = {607, 608}
, wordId = 0, back = 0}
, 
[65] = {id = 65, floor = "4-18", sort = 65, name = "地下广场", nameTextID = 1900065, sceneid = 14035, sceneimage = 10244, minEquipLevel = 30, minSkillLevel = 4, magic = 195, unlockLv = 12, describe = "守护者的广场，被熔岩所包围", describeTextID = 1900132, spirit = 1, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {}
, 
chestrewardItems = {}
, 
chestrewardItemNums = {}
, 
recommendid = {18, 3, 16, 14, 6}
, isBoss = 1, 
monsterid = {610}
, wordId = 0, back = 1}
, 
[66] = {id = 66, floor = "4-19", sort = 66, name = "城堡入口", nameTextID = 1900066, sceneid = 14036, sceneimage = 10244, minEquipLevel = 30, minSkillLevel = 4, magic = 195, unlockLv = 12, describe = "通往冰雪城堡的入口", describeTextID = 1900133, spirit = 1, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {14037}
, 
chestrewardItems = {35008, 76002}
, 
chestrewardItemNums = {20, 2}
, 
recommendid = {}
, isBoss = 0, 
monsterid = {}
, wordId = 0, back = 0}
, 
[67] = {id = 67, floor = "4-20", sort = 67, name = "地下广场", nameTextID = 1900067, sceneid = 14038, sceneimage = 10244, minEquipLevel = 30, minSkillLevel = 4, magic = 205, unlockLv = 12, describe = "守护者的广场，被熔岩所包围", describeTextID = 1900134, spirit = 1, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {}
, 
chestrewardItems = {}
, 
chestrewardItemNums = {}
, 
recommendid = {18, 3, 16, 14, 6}
, isBoss = 1, 
monsterid = {610}
, wordId = 0, back = 0}
, 
[68] = {id = 68, floor = "4.5-1", sort = 68, name = "时之塔第31层", nameTextID = 1900351, sceneid = 10032, sceneimage = 10243, minEquipLevel = 30, minSkillLevel = 4, magic = 205, unlockLv = 22, describe = "时之塔第31层", describeTextID = 1900357, spirit = 24, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74001}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {10033}
, 
chestrewardItems = {35008, 76002}
, 
chestrewardItemNums = {20, 3}
, 
recommendid = {1, 8, 11, 16, 6}
, isBoss = 0, 
monsterid = {501, 701, 703}
, wordId = 0, back = 0}
, 
[69] = {id = 69, floor = "4.5-2", sort = 69, name = "时之塔第33层", nameTextID = 1900352, sceneid = 10034, sceneimage = 10243, minEquipLevel = 30, minSkillLevel = 4, magic = 205, unlockLv = 22, describe = "时之塔第33层", describeTextID = 1900358, spirit = 24, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74001}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {10035}
, 
chestrewardItems = {35008, 31005, 76002}
, 
chestrewardItemNums = {20, 1, 3}
, 
recommendid = {8, 11, 16, 6}
, isBoss = 0, 
monsterid = {501, 701, 703}
, wordId = 0, back = 0}
, 
[70] = {id = 70, floor = "4.5-3", sort = 70, name = "时之塔第35层", nameTextID = 1900353, sceneid = 10036, sceneimage = 10243, minEquipLevel = 30, minSkillLevel = 4, magic = 205, unlockLv = 22, describe = "时之塔第35层", describeTextID = 1900359, spirit = 24, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74001}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {10037}
, 
chestrewardItems = {35008, 76002}
, 
chestrewardItemNums = {20, 3}
, 
recommendid = {11, 16, 13, 6}
, isBoss = 0, 
monsterid = {702, 703, 701}
, wordId = 0, back = 0}
, 
[71] = {id = 71, floor = "4.5-4", sort = 71, name = "时之塔第37层", nameTextID = 1900354, sceneid = 10038, sceneimage = 10243, minEquipLevel = 30, minSkillLevel = 4, magic = 205, unlockLv = 22, describe = "时之塔第37层", describeTextID = 1900360, spirit = 24, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74001}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {10039}
, 
chestrewardItems = {35008, 31008, 76002}
, 
chestrewardItemNums = {20, 1, 3}
, 
recommendid = {14, 11, 6}
, isBoss = 1, 
monsterid = {702, 704, 705}
, wordId = 0, back = 1}
, 
[72] = {id = 72, floor = "4.5-5", sort = 72, name = "时之塔第39层", nameTextID = 1900355, sceneid = 10040, sceneimage = 10243, minEquipLevel = 30, minSkillLevel = 4, magic = 205, unlockLv = 22, describe = "时之塔第39层", describeTextID = 1900361, spirit = 24, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {74001}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {}
, 
chestrewardItems = {35008, 76002}
, 
chestrewardItemNums = {20, 3}
, 
recommendid = {14, 11, 6}
, isBoss = 0, 
monsterid = {702, 704}
, wordId = 0, back = 0}
, 
[73] = {id = 73, floor = "4.5-6", sort = 73, name = "嘉庇艾尔之间", nameTextID = 1900356, sceneid = 10041, sceneimage = 10243, minEquipLevel = 30, minSkillLevel = 4, magic = 220, unlockLv = 22, describe = "神秘之间，似乎通向未知的世界", describeTextID = 1900362, spirit = 1, 
firstItems = {35008}
, 
firstItemNums = {30}
, 
itemid = {}
, 
suredropItems = {35002, 35020}
, 
smallnodeid = {}
, 
chestrewardItems = {}
, 
chestrewardItemNums = {}
, 
recommendid = {14, 7, 16, 6}
, isBoss = 1, 
monsterid = {706}
, wordId = 0, back = 0}
}
cdungeonselectmainline.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73}
return cdungeonselectmainline

