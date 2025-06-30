-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/npc/cnpc.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cnpc = {}
cnpc.Data = {
[10001] = {id = 10001, Name = "炼金术士", NameTextID = 900006, NPCShapeID = 1017, scene_id = 10005, situation = "36,7", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900001, disappear_id = 900002, chat_id = 14, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 1, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10002] = {id = 10002, Name = "索雷优", NameTextID = 900007, NPCShapeID = 10046, scene_id = 12014, situation = "17,11", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900023, disappear_id = 900024, chat_id = 13, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 1, turn = 0, reconnect = 1, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10003] = {id = 10003, Name = "厄迦姆", NameTextID = 900008, NPCShapeID = 20029, scene_id = 12008, situation = "15,8", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900025, disappear_id = 900026, chat_id = 10, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 0, reconnect = 1, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10004] = {id = 10004, Name = "厄迦姆", NameTextID = 900008, NPCShapeID = 20029, scene_id = 12011, situation = "16,6", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900027, disappear_id = 900028, chat_id = 10, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 0, reconnect = 1, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10005] = {id = 10005, Name = "厄迦姆", NameTextID = 900008, NPCShapeID = 20029, scene_id = 12018, situation = "26,25", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900029, disappear_id = 900030, chat_id = 16, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 0, reconnect = 1, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10009] = {id = 10009, Name = "索雷优", NameTextID = 900007, NPCShapeID = 10041, scene_id = 12012, situation = "20,10", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900003, disappear_id = 900004, chat_id = 9, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 0, reconnect = 1, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10010] = {id = 10010, Name = "厄迦姆", NameTextID = 900008, NPCShapeID = 20029, scene_id = 12007, situation = "19,29", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900005, disappear_id = 900006, chat_id = 10, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 0, reconnect = 1, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10011] = {id = 10011, Name = "毛虫兄长", NameTextID = 900009, NPCShapeID = 10022, scene_id = 12003, situation = "37,14", effect_id = 5, isrepeat = 0, isBubble = 1, appear_id = 900009, disappear_id = 900010, chat_id = 11, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 1, turn = 0, reconnect = 1, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10012] = {id = 10012, Name = "毛虫弟弟", NameTextID = 900010, NPCShapeID = 10023, scene_id = 12010, situation = "19,23", effect_id = 6, isrepeat = 0, isBubble = 0, appear_id = 900083, disappear_id = 900084, chat_id = 37, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 1, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10016] = {id = 10016, Name = "费吉亚", NameTextID = 900011, NPCShapeID = 5024, scene_id = 12002, situation = "24,5", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900007, disappear_id = 900008, chat_id = 1, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10017] = {id = 10017, Name = "费吉亚", NameTextID = 900011, NPCShapeID = 5024, scene_id = 12005, situation = "33,20", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900011, disappear_id = 900012, chat_id = 1, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 1, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10023] = {id = 10023, Name = "青蛙骑士", NameTextID = 900001, NPCShapeID = 5024, scene_id = 12024, situation = "30,8", effect_id = 7, isrepeat = 0, isBubble = 1, appear_id = 900019, disappear_id = 900020, chat_id = 1, isBlock = 1, length = "0.42", width = "0.2", isFacePlayer = 1, turn = 2, reconnect = 1, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10024] = {id = 10024, Name = "毛虫兄长", NameTextID = 900009, NPCShapeID = 10022, scene_id = 12024, situation = "35,8", effect_id = 8, isrepeat = 0, isBubble = 0, appear_id = 900021, disappear_id = 900022, chat_id = 15, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 1, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10025] = {id = 10025, Name = "索雷优", NameTextID = 900007, NPCShapeID = 10046, scene_id = 12016, situation = "8,12", effect_id = 13, isrepeat = 1, isBubble = 0, appear_id = 900031, disappear_id = 900032, chat_id = 13, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 1, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10027] = {id = 10027, Name = "狄璐卡", NameTextID = 900012, NPCShapeID = 1010, scene_id = 10010, situation = "5,9", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900037, disappear_id = 900038, chat_id = 17, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 1, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10028] = {id = 10028, Name = "费吉亚", NameTextID = 900011, NPCShapeID = 5024, scene_id = 12015, situation = "18,11", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900041, disappear_id = 900042, chat_id = 1, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10029] = {id = 10029, Name = "银弓", NameTextID = 900013, NPCShapeID = 5004, scene_id = 13003, situation = "14,12", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900043, disappear_id = 900044, chat_id = 20, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 1, turn = 3, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10030] = {id = 10030, Name = "冰雪骑士", NameTextID = 900014, NPCShapeID = 5009, scene_id = 13004, situation = "22,16", effect_id = 18, isrepeat = 0, isBubble = 0, appear_id = 900045, disappear_id = 900046, chat_id = 21, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 1, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10031] = {id = 10031, Name = "大叔", NameTextID = 900015, NPCShapeID = 5006, scene_id = 13101, situation = "8,4", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900047, disappear_id = 900048, chat_id = 22, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10032] = {id = 10032, Name = "老猎人", NameTextID = 900016, NPCShapeID = 5005, scene_id = 13008, situation = "22,11", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900049, disappear_id = 900050, chat_id = 23, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 1, turn = 3, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10033] = {id = 10033, Name = "老猎人", NameTextID = 900016, NPCShapeID = 5005, scene_id = 13010, situation = "15,12", effect_id = 19, isrepeat = 0, isBubble = 0, appear_id = 900051, disappear_id = 900052, chat_id = 24, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10034] = {id = 10034, Name = "银弓", NameTextID = 900013, NPCShapeID = 5004, scene_id = 13012, situation = "16,23", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900053, disappear_id = 900054, chat_id = 25, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 3, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10036] = {id = 10036, Name = "银弓", NameTextID = 900013, NPCShapeID = 5004, scene_id = 13016, situation = "12,18", effect_id = 20, isrepeat = 0, isBubble = 0, appear_id = 900057, disappear_id = 900058, chat_id = 27, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 3, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10038] = {id = 10038, Name = "芬里尔", NameTextID = 900017, NPCShapeID = 5013, scene_id = 13030, situation = "14,17", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900061, disappear_id = 900062, chat_id = 29, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 3, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10039] = {id = 10039, Name = "蹒跚的猎人", NameTextID = 900018, NPCShapeID = 5007, scene_id = 13001, situation = "29,29", effect_id = 14, isrepeat = 0, isBubble = 1, appear_id = 900063, disappear_id = 900064, chat_id = 30, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10040] = {id = 10040, Name = "气愤的村民", NameTextID = 900019, NPCShapeID = 5002, scene_id = 13001, situation = "35,34", effect_id = 15, isrepeat = 0, isBubble = 1, appear_id = 900065, disappear_id = 900066, chat_id = 31, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10041] = {id = 10041, Name = "朵布莉", NameTextID = 900020, NPCShapeID = 5002, scene_id = 13001, situation = "14,32", effect_id = 16, isrepeat = 0, isBubble = 0, appear_id = 900067, disappear_id = 900068, chat_id = 32, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10042] = {id = 10042, Name = "男村民", NameTextID = 900021, NPCShapeID = 5001, scene_id = 13001, situation = "33,28", effect_id = 17, isrepeat = 0, isBubble = 0, appear_id = 900069, disappear_id = 900070, chat_id = 33, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10043] = {id = 10043, Name = "偷粮食的小狐狸", NameTextID = 900022, NPCShapeID = 5011, scene_id = 13004, situation = "8,22", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900077, disappear_id = 900078, chat_id = 35, isBlock = 1, length = "0.2", width = "0.2", isFacePlayer = 0, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10044] = {id = 10044, Name = "安迪", NameTextID = 900023, NPCShapeID = 5001, scene_id = 13104, situation = "8,8", effect_id = 0, isrepeat = 0, isBubble = 1, appear_id = 900073, disappear_id = 900074, chat_id = 34, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10045] = {id = 10045, Name = "狼群首领", NameTextID = 900024, NPCShapeID = 5013, scene_id = 13015, situation = "15,5", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900075, disappear_id = 900076, chat_id = 26, isBlock = 1, length = "0.4", width = "0.56", isFacePlayer = 1, turn = 3, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10047] = {id = 10047, Name = "狄璐卡", NameTextID = 900012, NPCShapeID = 5021, scene_id = 10007, situation = "13,10", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900033, disappear_id = 900034, chat_id = 38, isBlock = 1, length = "0.25", width = "0.5", isFacePlayer = 0, turn = 5, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10048] = {id = 10048, Name = "热血的年轻人", NameTextID = 900025, NPCShapeID = 5003, scene_id = 13014, situation = "9,5", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900081, disappear_id = 900082, chat_id = 36, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 2, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10049] = {id = 10049, Name = "毛虫弟弟", NameTextID = 900010, NPCShapeID = 10023, scene_id = 12010, situation = "19,23", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900017, disappear_id = 900018, chat_id = 12, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 1, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10050] = {id = 10050, Name = "索雷优", NameTextID = 900007, NPCShapeID = 10041, scene_id = 12014, situation = "10,4", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900085, disappear_id = 900086, chat_id = 39, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 1, turn = 0, reconnect = 1, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10051] = {id = 10051, Name = "小狐狸", NameTextID = 900026, NPCShapeID = 5011, scene_id = 13034, situation = "8,33", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900087, disappear_id = 900088, chat_id = 40, isBlock = 1, length = "0.2", width = "0.2", isFacePlayer = 0, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10052] = {id = 10052, Name = "村民", NameTextID = 900027, NPCShapeID = 5020, scene_id = 11004, situation = "8,6", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900089, disappear_id = 900090, chat_id = 41, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10053] = {id = 10053, Name = "村民", NameTextID = 900027, NPCShapeID = 5019, scene_id = 11004, situation = "13,5", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900091, disappear_id = 900092, chat_id = 42, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10054] = {id = 10054, Name = "村民", NameTextID = 900027, NPCShapeID = 5018, scene_id = 11004, situation = "14,6", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900093, disappear_id = 900094, chat_id = 43, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10055] = {id = 10055, Name = "村民", NameTextID = 900027, NPCShapeID = 5019, scene_id = 11004, situation = "24,11", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900095, disappear_id = 900096, chat_id = 44, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10056] = {id = 10056, Name = "布露恩", NameTextID = 900028, NPCShapeID = 5015, scene_id = 10023, situation = "10,5", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900097, disappear_id = 900098, chat_id = 45, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 2, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10057] = {id = 10057, Name = "银弓", NameTextID = 900013, NPCShapeID = 5004, scene_id = 14004, situation = "21,16", effect_id = 22, isrepeat = 0, isBubble = 1, appear_id = 900099, disappear_id = 900100, chat_id = 46, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 1, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10058] = {id = 10058, Name = "老猎人", NameTextID = 900016, NPCShapeID = 5005, scene_id = 14022, situation = "20,20", effect_id = 23, isrepeat = 0, isBubble = 1, appear_id = 900101, disappear_id = 900102, chat_id = 47, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 1, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10059] = {id = 10059, Name = "热血的年轻人", NameTextID = 900025, NPCShapeID = 5003, scene_id = 14023, situation = "10,12", effect_id = 24, isrepeat = 0, isBubble = 0, appear_id = 900103, disappear_id = 900104, chat_id = 48, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 1, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10060] = {id = 10060, Name = "冻僵的小女孩", NameTextID = 900029, NPCShapeID = 5017, scene_id = 14018, situation = "9,12", effect_id = 25, isrepeat = 0, isBubble = 1, appear_id = 900105, disappear_id = 900106, chat_id = 16, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 1, turn = 0, reconnect = 1, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10061] = {id = 10061, Name = "小狐狸", NameTextID = 900026, NPCShapeID = 5011, scene_id = 14014, situation = "9,5", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900107, disappear_id = 900108, chat_id = 49, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 1, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10062] = {id = 10062, Name = "诺尔伊迪", NameTextID = 900079, NPCShapeID = 1013, scene_id = 10010, situation = "7,9", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900109, disappear_id = 900110, chat_id = 50, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 3, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10063] = {id = 10063, Name = "村民", NameTextID = 900027, NPCShapeID = 5026, scene_id = 15012, situation = "18,30", effect_id = 27, isrepeat = 0, isBubble = 0, appear_id = 900113, disappear_id = 900114, chat_id = 52, isBlock = 1, length = "0.2", width = "0.2", isFacePlayer = 0, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10064] = {id = 10064, Name = "村民", NameTextID = 900027, NPCShapeID = 5027, scene_id = 15012, situation = "24,29", effect_id = 28, isrepeat = 0, isBubble = 0, appear_id = 900115, disappear_id = 900116, chat_id = 53, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10065] = {id = 10065, Name = "村民", NameTextID = 900027, NPCShapeID = 5028, scene_id = 15012, situation = "16,23", effect_id = 29, isrepeat = 0, isBubble = 0, appear_id = 900117, disappear_id = 900118, chat_id = 54, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 1, turn = 3, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10066] = {id = 10066, Name = "村民", NameTextID = 900027, NPCShapeID = 5029, scene_id = 15012, situation = "25,29", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900119, disappear_id = 900120, chat_id = 55, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 1, turn = 3, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10067] = {id = 10067, Name = "村民", NameTextID = 900027, NPCShapeID = 5026, scene_id = 15012, situation = "18,30", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900121, disappear_id = 900122, chat_id = 56, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10068] = {id = 10068, Name = "村民", NameTextID = 900027, NPCShapeID = 5027, scene_id = 15012, situation = "24,29", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900123, disappear_id = 900124, chat_id = 57, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 0, turn = 0, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10069] = {id = 10069, Name = "村民", NameTextID = 900027, NPCShapeID = 5028, scene_id = 15012, situation = "16,23", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900125, disappear_id = 900126, chat_id = 58, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 1, turn = 3, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10070] = {id = 10070, Name = "村民", NameTextID = 900027, NPCShapeID = 5029, scene_id = 15012, situation = "25,29", effect_id = 0, isrepeat = 0, isBubble = 0, appear_id = 900127, disappear_id = 900128, chat_id = 59, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 1, turn = 3, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10071] = {id = 10071, Name = "上层居民", NameTextID = 900090, NPCShapeID = 5030, scene_id = 16007, situation = "13,16", effect_id = 30, isrepeat = 0, isBubble = 1, appear_id = 900129, disappear_id = 900130, chat_id = 60, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 1, turn = 3, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10072] = {id = 10072, Name = "虔诚的居民", NameTextID = 900091, NPCShapeID = 5031, scene_id = 16007, situation = "8,16", effect_id = 31, isrepeat = 0, isBubble = 1, appear_id = 900131, disappear_id = 900132, chat_id = 61, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 1, turn = 3, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
, 
[10073] = {id = 10073, Name = "多嘴的居民", NameTextID = 900092, NPCShapeID = 5032, scene_id = 16007, situation = "5,16", effect_id = 32, isrepeat = 0, isBubble = 1, appear_id = 900133, disappear_id = 900134, chat_id = 62, isBlock = 1, length = "0.3", width = "0.2", isFacePlayer = 1, turn = 3, reconnect = 0, 
serviceID = {}
, minimapIconID = 10364, isCovered = 1}
}
cnpc.AllIds = {10001, 10002, 10003, 10004, 10005, 10009, 10010, 10011, 10012, 10016, 10017, 10023, 10024, 10025, 10027, 10028, 10029, 10030, 10031, 10032, 10033, 10034, 10036, 10038, 10039, 10040, 10041, 10042, 10043, 10044, 10045, 10047, 10048, 10049, 10050, 10051, 10052, 10053, 10054, 10055, 10056, 10057, 10058, 10059, 10060, 10061, 10062, 10063, 10064, 10065, 10066, 10067, 10068, 10069, 10070, 10071, 10072, 10073}
return cnpc

