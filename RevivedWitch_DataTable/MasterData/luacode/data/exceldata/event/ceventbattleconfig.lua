-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/event/ceventbattleconfig.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ceventbattleconfig = {}
ceventbattleconfig.Data = {
[1] = {id = 1, scene = "12005", battleId = "10006", condition = 172, effect = 100190, failEternalEffect = 100194, battleStartOnEnter = 0, conditionRetry = 176, effectRetry = 0, winEffect = 100191, winEternalEffect = 100199, retreat = 1201, level = 15, minBreakLevel = 0, minRoleLevel = 15, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[2] = {id = 2, scene = "12021", battleId = "10009", condition = 185, effect = 100210, failEternalEffect = 100213, battleStartOnEnter = 0, conditionRetry = 186, effectRetry = 100211, winEffect = 100489, winEternalEffect = 100212, retreat = 1202, level = 50, minBreakLevel = 1, minRoleLevel = 20, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[3] = {id = 3, scene = "12025", battleId = "10010", condition = 44, effect = 100202, failEternalEffect = 100349, battleStartOnEnter = 0, conditionRetry = 85, effectRetry = 0, winEffect = 100204, winEternalEffect = 100203, retreat = 1203, level = 75, minBreakLevel = 2, minRoleLevel = 5, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[4] = {id = 4, scene = "10007", battleId = "10004", condition = 100, effect = 100116, failEternalEffect = 100264, battleStartOnEnter = 0, conditionRetry = 177, effectRetry = 100195, winEffect = 100130, winEternalEffect = 100224, retreat = 1199, level = 6, minBreakLevel = 0, minRoleLevel = 6, isShowMinimapIcon = 1, coordinate = "15,9", imageId = 3}
, 
[5] = {id = 5, scene = "12013", battleId = "10007", condition = 183, effect = 100214, failEternalEffect = 100270, battleStartOnEnter = 0, conditionRetry = 217, effectRetry = 0, winEffect = 100215, winEternalEffect = 100269, retreat = 1204, level = 35, minBreakLevel = 1, minRoleLevel = 5, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[6] = {id = 6, scene = "13005", battleId = "10012", condition = 240, effect = 100335, failEternalEffect = 100336, battleStartOnEnter = 0, conditionRetry = 281, effectRetry = 0, winEffect = 100337, winEternalEffect = 100338, retreat = 1205, level = 95, minBreakLevel = 2, minRoleLevel = 25, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[7] = {id = 7, scene = "13010", battleId = "10013", condition = 245, effect = 100291, failEternalEffect = 0, battleStartOnEnter = 0, conditionRetry = 246, effectRetry = 0, winEffect = 100292, winEternalEffect = 100293, retreat = 1206, level = 100, minBreakLevel = 2, minRoleLevel = 30, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[8] = {id = 8, scene = "13014", battleId = "10014", condition = 249, effect = 100296, failEternalEffect = 0, battleStartOnEnter = 0, conditionRetry = 250, effectRetry = 100297, winEffect = 100298, winEternalEffect = 100299, retreat = 1207, level = 115, minBreakLevel = 2, minRoleLevel = 45, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[9] = {id = 9, scene = "13020", battleId = "10015", condition = 261, effect = 100310, failEternalEffect = 100311, battleStartOnEnter = 0, conditionRetry = 262, effectRetry = 0, winEffect = 100312, winEternalEffect = 100341, retreat = 1208, level = 120, minBreakLevel = 2, minRoleLevel = 50, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[10] = {id = 10, scene = "13022", battleId = "10016", condition = 271, effect = 100322, failEternalEffect = 0, battleStartOnEnter = 0, conditionRetry = 272, effectRetry = 0, winEffect = 100323, winEternalEffect = 100324, retreat = 1209, level = 125, minBreakLevel = 2, minRoleLevel = 55, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[11] = {id = 11, scene = "13027", battleId = "10018", condition = 265, effect = 100315, failEternalEffect = 0, battleStartOnEnter = 0, conditionRetry = 266, effectRetry = 0, winEffect = 100316, winEternalEffect = 100355, retreat = 1210, level = 130, minBreakLevel = 2, minRoleLevel = 60, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[12] = {id = 12, scene = "13030", battleId = "10017", condition = 268, effect = 100318, failEternalEffect = 0, battleStartOnEnter = 0, conditionRetry = 269, effectRetry = 0, winEffect = 100319, winEternalEffect = 100320, retreat = 1211, level = 135, minBreakLevel = 3, minRoleLevel = 5, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[13] = {id = 13, scene = "10015", battleId = "10011", condition = 275, effect = 100327, failEternalEffect = 0, battleStartOnEnter = 0, conditionRetry = 276, effectRetry = 100328, winEffect = 100329, winEternalEffect = 100342, retreat = 1200, level = 80, minBreakLevel = 2, minRoleLevel = 10, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[14] = {id = 14, scene = "13035", battleId = "10019", condition = 212, effect = 100263, failEternalEffect = 0, battleStartOnEnter = 0, conditionRetry = 295, effectRetry = 0, winEffect = 100344, winEternalEffect = 100354, retreat = 1219, level = 140, minBreakLevel = 3, minRoleLevel = 10, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[15] = {id = 15, scene = "10023", battleId = "10020", condition = 123, effect = 100407, failEternalEffect = 0, battleStartOnEnter = 0, conditionRetry = 126, effectRetry = 0, winEffect = 100408, winEternalEffect = 100409, retreat = 0, level = 145, minBreakLevel = 3, minRoleLevel = 15, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[16] = {id = 16, scene = "10025", battleId = "10021", condition = 124, effect = 100410, failEternalEffect = 100411, battleStartOnEnter = 0, conditionRetry = 127, effectRetry = 0, winEffect = 100412, winEternalEffect = 100413, retreat = 1234, level = 145, minBreakLevel = 3, minRoleLevel = 15, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[17] = {id = 17, scene = "10031", battleId = "10022", condition = 125, effect = 100414, failEternalEffect = 100415, battleStartOnEnter = 0, conditionRetry = 128, effectRetry = 0, winEffect = 100416, winEternalEffect = 100417, retreat = 1237, level = 150, minBreakLevel = 3, minRoleLevel = 20, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[18] = {id = 18, scene = "14006", battleId = "10023", condition = 136, effect = 100427, failEternalEffect = 100428, battleStartOnEnter = 0, conditionRetry = 137, effectRetry = 0, winEffect = 100429, winEternalEffect = 100430, retreat = 1251, level = 170, minBreakLevel = 3, minRoleLevel = 40, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[19] = {id = 19, scene = "14008", battleId = "10024", condition = 138, effect = 100431, failEternalEffect = 100432, battleStartOnEnter = 0, conditionRetry = 139, effectRetry = 0, winEffect = 100433, winEternalEffect = 100434, retreat = 1256, level = 170, minBreakLevel = 3, minRoleLevel = 40, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[20] = {id = 20, scene = "14011", battleId = "10025", condition = 143, effect = 100438, failEternalEffect = 100439, battleStartOnEnter = 0, conditionRetry = 144, effectRetry = 0, winEffect = 100440, winEternalEffect = 100441, retreat = 1261, level = 175, minBreakLevel = 3, minRoleLevel = 45, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[21] = {id = 21, scene = "14016", battleId = "10026", condition = 148, effect = 100445, failEternalEffect = 100446, battleStartOnEnter = 0, conditionRetry = 149, effectRetry = 100447, winEffect = 100448, winEternalEffect = 100449, retreat = 1268, level = 180, minBreakLevel = 3, minRoleLevel = 50, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[22] = {id = 22, scene = "14020", battleId = "10027", condition = 151, effect = 100451, failEternalEffect = 0, battleStartOnEnter = 0, conditionRetry = 152, effectRetry = 0, winEffect = 100452, winEternalEffect = 100453, retreat = 1272, level = 185, minBreakLevel = 3, minRoleLevel = 55, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[23] = {id = 23, scene = "14021", battleId = "10028", condition = 153, effect = 100454, failEternalEffect = 0, battleStartOnEnter = 0, conditionRetry = 154, effectRetry = 0, winEffect = 100455, winEternalEffect = 100456, retreat = 1275, level = 190, minBreakLevel = 3, minRoleLevel = 60, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[24] = {id = 24, scene = "14028", battleId = "10029", condition = 156, effect = 100458, failEternalEffect = 100459, battleStartOnEnter = 0, conditionRetry = 157, effectRetry = 0, winEffect = 100460, winEternalEffect = 100461, retreat = 1279, level = 190, minBreakLevel = 3, minRoleLevel = 60, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[25] = {id = 25, scene = "14035", battleId = "10030", condition = 160, effect = 100464, failEternalEffect = 0, battleStartOnEnter = 0, conditionRetry = 161, effectRetry = 0, winEffect = 100465, winEternalEffect = 100466, retreat = 1286, level = 195, minBreakLevel = 3, minRoleLevel = 60, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[26] = {id = 26, scene = "14038", battleId = "10031", condition = 162, effect = 100467, failEternalEffect = 0, battleStartOnEnter = 0, conditionRetry = 163, effectRetry = 0, winEffect = 100468, winEternalEffect = 100469, retreat = 1287, level = 205, minBreakLevel = 4, minRoleLevel = 5, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[27] = {id = 27, scene = "10041", battleId = "10034", condition = 341, effect = 100514, failEternalEffect = 100515, battleStartOnEnter = 0, conditionRetry = 342, effectRetry = 100516, winEffect = 100517, winEternalEffect = 100518, retreat = 1315, level = 220, minBreakLevel = 4, minRoleLevel = 20, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[28] = {id = 28, scene = "60007", battleId = "6013", condition = 385, effect = 100521, failEternalEffect = 0, battleStartOnEnter = 1, conditionRetry = 0, effectRetry = 0, winEffect = 100522, winEternalEffect = 0, retreat = 0, level = 50, minBreakLevel = 1, minRoleLevel = 20, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[29] = {id = 29, scene = "15002", battleId = "10035", condition = 343, effect = 100525, failEternalEffect = 100526, battleStartOnEnter = 0, conditionRetry = 344, effectRetry = 0, winEffect = 100527, winEternalEffect = 100528, retreat = 1321, level = 220, minBreakLevel = 4, minRoleLevel = 20, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[30] = {id = 30, scene = "15003", battleId = "10036", condition = 347, effect = 100530, failEternalEffect = 100531, battleStartOnEnter = 0, conditionRetry = 348, effectRetry = 0, winEffect = 100532, winEternalEffect = 100533, retreat = 1325, level = 220, minBreakLevel = 4, minRoleLevel = 20, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[31] = {id = 31, scene = "15007", battleId = "10037", condition = 351, effect = 100536, failEternalEffect = 100537, battleStartOnEnter = 0, conditionRetry = 352, effectRetry = 100538, winEffect = 100539, winEternalEffect = 100540, retreat = 1331, level = 235, minBreakLevel = 4, minRoleLevel = 35, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[32] = {id = 32, scene = "15012", battleId = "10038", condition = 358, effect = 100547, failEternalEffect = 100548, battleStartOnEnter = 1, conditionRetry = 359, effectRetry = 100549, winEffect = 100550, winEternalEffect = 100551, retreat = 1340, level = 235, minBreakLevel = 4, minRoleLevel = 35, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[33] = {id = 33, scene = "15017", battleId = "10039", condition = 366, effect = 100556, failEternalEffect = 100557, battleStartOnEnter = 0, conditionRetry = 367, effectRetry = 0, winEffect = 100558, winEternalEffect = 100559, retreat = 1350, level = 250, minBreakLevel = 4, minRoleLevel = 50, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[34] = {id = 34, scene = "15024", battleId = "10040", condition = 374, effect = 100566, failEternalEffect = 100567, battleStartOnEnter = 0, conditionRetry = 375, effectRetry = 0, winEffect = 100568, winEternalEffect = 100569, retreat = 1359, level = 250, minBreakLevel = 4, minRoleLevel = 50, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[35] = {id = 35, scene = "15030", battleId = "10041", condition = 380, effect = 100574, failEternalEffect = 100575, battleStartOnEnter = 0, conditionRetry = 381, effectRetry = 0, winEffect = 100576, winEternalEffect = 100577, retreat = 1366, level = 265, minBreakLevel = 4, minRoleLevel = 65, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[36] = {id = 36, scene = "15035", battleId = "10042", condition = 390, effect = 100581, failEternalEffect = 0, battleStartOnEnter = 0, conditionRetry = 391, effectRetry = 100583, winEffect = 100584, winEternalEffect = 100585, retreat = 1387, level = 280, minBreakLevel = 4, minRoleLevel = 80, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[37] = {id = 37, scene = "60002", battleId = "6005", condition = 399, effect = 100593, failEternalEffect = 0, battleStartOnEnter = 1, conditionRetry = 400, effectRetry = 0, winEffect = 100594, winEternalEffect = 0, retreat = 0, level = 75, minBreakLevel = 2, minRoleLevel = 5, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[38] = {id = 38, scene = "60004", battleId = "6010", condition = 407, effect = 100601, failEternalEffect = 0, battleStartOnEnter = 1, conditionRetry = 0, effectRetry = 0, winEffect = 100602, winEternalEffect = 0, retreat = 0, level = 75, minBreakLevel = 2, minRoleLevel = 5, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[39] = {id = 39, scene = "60005", battleId = "6011", condition = 408, effect = 100603, failEternalEffect = 0, battleStartOnEnter = 1, conditionRetry = 0, effectRetry = 0, winEffect = 100604, winEternalEffect = 0, retreat = 0, level = 75, minBreakLevel = 2, minRoleLevel = 5, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[40] = {id = 40, scene = "10038", battleId = "10033", condition = 411, effect = 100611, failEternalEffect = 100608, battleStartOnEnter = 0, conditionRetry = 412, effectRetry = 0, winEffect = 100610, winEternalEffect = 100609, retreat = 1393, level = 205, minBreakLevel = 4, minRoleLevel = 5, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[41] = {id = 41, scene = "13025", battleId = "10043", condition = 416, effect = 100615, failEternalEffect = 100616, battleStartOnEnter = 0, conditionRetry = 417, effectRetry = 0, winEffect = 100617, winEternalEffect = 100618, retreat = 1399, level = 130, minBreakLevel = 2, minRoleLevel = 60, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[42] = {id = 42, scene = "60008", battleId = "6018", condition = 46, effect = 100657, failEternalEffect = 0, battleStartOnEnter = 1, conditionRetry = 0, effectRetry = 0, winEffect = 100658, winEternalEffect = 0, retreat = 0, level = 50, minBreakLevel = 1, minRoleLevel = 20, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[43] = {id = 43, scene = "60009", battleId = "6018", condition = 460, effect = 100659, failEternalEffect = 0, battleStartOnEnter = 1, conditionRetry = 0, effectRetry = 0, winEffect = 100660, winEternalEffect = 0, retreat = 0, level = 50, minBreakLevel = 1, minRoleLevel = 20, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[44] = {id = 44, scene = "60010", battleId = "6023", condition = 462, effect = 100661, failEternalEffect = 0, battleStartOnEnter = 1, conditionRetry = 0, effectRetry = 0, winEffect = 100662, winEternalEffect = 0, retreat = 0, level = 50, minBreakLevel = 1, minRoleLevel = 20, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[45] = {id = 45, scene = "60011", battleId = "6026", condition = 464, effect = 100663, failEternalEffect = 0, battleStartOnEnter = 1, conditionRetry = 0, effectRetry = 0, winEffect = 100664, winEternalEffect = 0, retreat = 0, level = 50, minBreakLevel = 1, minRoleLevel = 20, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[46] = {id = 46, scene = "16035", battleId = "10051", condition = 470, effect = 100669, failEternalEffect = 0, battleStartOnEnter = 0, conditionRetry = 470, effectRetry = 100703, winEffect = 100670, winEternalEffect = 0, retreat = 1454, level = 290, minBreakLevel = 4, minRoleLevel = 90, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[47] = {id = 47, scene = "16010", battleId = "10045", condition = 474, effect = 100674, failEternalEffect = 0, battleStartOnEnter = 0, conditionRetry = 474, effectRetry = 100704, winEffect = 100675, winEternalEffect = 0, retreat = 1461, level = 280, minBreakLevel = 4, minRoleLevel = 80, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[48] = {id = 48, scene = "16030", battleId = "10049", condition = 487, effect = 100688, failEternalEffect = 0, battleStartOnEnter = 0, conditionRetry = 487, effectRetry = 100705, winEffect = 100689, winEternalEffect = 0, retreat = 1480, level = 290, minBreakLevel = 4, minRoleLevel = 90, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[50] = {id = 50, scene = "16020", battleId = "10047", condition = 496, effect = 100699, failEternalEffect = 0, battleStartOnEnter = 0, conditionRetry = 496, effectRetry = 100706, winEffect = 100700, winEternalEffect = 0, retreat = 1491, level = 290, minBreakLevel = 4, minRoleLevel = 90, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
, 
[51] = {id = 51, scene = "16025", battleId = "10048", condition = 497, effect = 100701, failEternalEffect = 0, battleStartOnEnter = 0, conditionRetry = 497, effectRetry = 100707, winEffect = 100702, winEternalEffect = 0, retreat = 1492, level = 290, minBreakLevel = 4, minRoleLevel = 90, isShowMinimapIcon = 0, coordinate = "0", imageId = 0}
}
ceventbattleconfig.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 50, 51}
return ceventbattleconfig

