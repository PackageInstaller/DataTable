-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/dungeonselect/cautoexplore.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cautoexplore = {}
cautoexplore.Data = {
[1] = {id = 1, dungeontype = 2, sectionID = 1, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 130}
, 
[2] = {id = 2, dungeontype = 2, sectionID = 2, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 130}
, 
[3] = {id = 3, dungeontype = 2, sectionID = 3, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 130}
, 
[4] = {id = 4, dungeontype = 2, sectionID = 4, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 130}
, 
[5] = {id = 5, dungeontype = 2, sectionID = 5, foreGround = "ForeGroundW1", backGround = "BackGroundW1", bmgId = 135}
, 
[6] = {id = 6, dungeontype = 2, sectionID = 6, foreGround = "ForeGroundW1", backGround = "BackGroundW1", bmgId = 135}
, 
[7] = {id = 7, dungeontype = 2, sectionID = 7, foreGround = "ForeGroundW1", backGround = "BackGroundW1", bmgId = 135}
, 
[8] = {id = 8, dungeontype = 2, sectionID = 8, foreGround = "ForeGroundW1", backGround = "BackGroundW1", bmgId = 135}
, 
[9] = {id = 9, dungeontype = 2, sectionID = 9, foreGround = "ForeGroundW1", backGround = "BackGroundW1", bmgId = 135}
, 
[10] = {id = 10, dungeontype = 2, sectionID = 10, foreGround = "ForeGroundW1", backGround = "BackGroundW1", bmgId = 135}
, 
[11] = {id = 11, dungeontype = 2, sectionID = 11, foreGround = "ForeGroundW1", backGround = "BackGroundW1", bmgId = 135}
, 
[12] = {id = 12, dungeontype = 2, sectionID = 12, foreGround = "ForeGroundW1", backGround = "BackGroundW1", bmgId = 135}
, 
[13] = {id = 13, dungeontype = 2, sectionID = 13, foreGround = "ForeGroundW1", backGround = "BackGroundW1", bmgId = 135}
, 
[14] = {id = 14, dungeontype = 2, sectionID = 14, foreGround = "ForeGroundW1", backGround = "BackGroundW1", bmgId = 135}
, 
[15] = {id = 15, dungeontype = 2, sectionID = 15, foreGround = "ForeGroundW1", backGround = "BackGroundW1", bmgId = 135}
, 
[16] = {id = 16, dungeontype = 2, sectionID = 16, foreGround = "ForeGroundW1", backGround = "BackGroundW1", bmgId = 135}
, 
[17] = {id = 17, dungeontype = 2, sectionID = 17, foreGround = "ForeGroundW1", backGround = "BackGroundW1", bmgId = 135}
, 
[18] = {id = 18, dungeontype = 2, sectionID = 18, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 130}
, 
[19] = {id = 19, dungeontype = 2, sectionID = 19, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 130}
, 
[20] = {id = 20, dungeontype = 2, sectionID = 20, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 130}
, 
[21] = {id = 21, dungeontype = 2, sectionID = 21, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 130}
, 
[22] = {id = 22, dungeontype = 2, sectionID = 22, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 130}
, 
[23] = {id = 23, dungeontype = 2, sectionID = 23, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 130}
, 
[24] = {id = 24, dungeontype = 2, sectionID = 24, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 234}
, 
[25] = {id = 25, dungeontype = 2, sectionID = 25, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 234}
, 
[26] = {id = 26, dungeontype = 2, sectionID = 26, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 234}
, 
[27] = {id = 27, dungeontype = 2, sectionID = 27, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 234}
, 
[28] = {id = 28, dungeontype = 2, sectionID = 28, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 234}
, 
[29] = {id = 29, dungeontype = 2, sectionID = 29, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 234}
, 
[30] = {id = 30, dungeontype = 2, sectionID = 30, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 234}
, 
[31] = {id = 31, dungeontype = 2, sectionID = 31, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 234}
, 
[32] = {id = 32, dungeontype = 2, sectionID = 32, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 234}
, 
[33] = {id = 33, dungeontype = 2, sectionID = 33, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 234}
, 
[34] = {id = 34, dungeontype = 2, sectionID = 34, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 234}
, 
[35] = {id = 35, dungeontype = 2, sectionID = 35, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 234}
, 
[36] = {id = 36, dungeontype = 2, sectionID = 36, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 234}
, 
[37] = {id = 37, dungeontype = 2, sectionID = 37, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 234}
, 
[38] = {id = 38, dungeontype = 2, sectionID = 38, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 234}
, 
[39] = {id = 39, dungeontype = 2, sectionID = 39, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 234}
, 
[40] = {id = 40, dungeontype = 2, sectionID = 40, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 234}
, 
[41] = {id = 41, dungeontype = 2, sectionID = 41, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 234}
, 
[42] = {id = 42, dungeontype = 3, sectionID = 10101, foreGround = "ForeGroundT1", backGround = "BackGroundBattle4", bmgId = 130}
, 
[43] = {id = 43, dungeontype = 3, sectionID = 10102, foreGround = "ForeGroundT1", backGround = "BackGroundBattle4", bmgId = 130}
, 
[44] = {id = 44, dungeontype = 3, sectionID = 10103, foreGround = "ForeGroundT1", backGround = "BackGroundBattle4", bmgId = 135}
, 
[45] = {id = 45, dungeontype = 3, sectionID = 10104, foreGround = "ForeGroundT1", backGround = "BackGroundBattle4", bmgId = 135}
, 
[46] = {id = 46, dungeontype = 3, sectionID = 10105, foreGround = "ForeGroundT1", backGround = "BackGroundBattle4", bmgId = 234}
, 
[47] = {id = 47, dungeontype = 3, sectionID = 10106, foreGround = "ForeGroundT1", backGround = "BackGroundBattle4", bmgId = 234}
, 
[48] = {id = 48, dungeontype = 3, sectionID = 20101, foreGround = "ForeGroundT1", backGround = "BackGroundBattle5", bmgId = 130}
, 
[49] = {id = 49, dungeontype = 3, sectionID = 20102, foreGround = "ForeGroundT1", backGround = "BackGroundBattle5", bmgId = 135}
, 
[50] = {id = 50, dungeontype = 3, sectionID = 20103, foreGround = "ForeGroundT1", backGround = "BackGroundBattle5", bmgId = 234}
, 
[51] = {id = 51, dungeontype = 3, sectionID = 20201, foreGround = "ForeGroundT1", backGround = "BackGroundBattle6", bmgId = 130}
, 
[52] = {id = 52, dungeontype = 3, sectionID = 20202, foreGround = "ForeGroundT1", backGround = "BackGroundBattle6", bmgId = 135}
, 
[53] = {id = 53, dungeontype = 3, sectionID = 20203, foreGround = "ForeGroundT1", backGround = "BackGroundBattle6", bmgId = 234}
, 
[54] = {id = 54, dungeontype = 3, sectionID = 20301, foreGround = "ForeGroundT1", backGround = "BackGroundBattle7", bmgId = 130}
, 
[55] = {id = 55, dungeontype = 3, sectionID = 20302, foreGround = "ForeGroundT1", backGround = "BackGroundBattle7", bmgId = 135}
, 
[56] = {id = 56, dungeontype = 3, sectionID = 20303, foreGround = "ForeGroundT1", backGround = "BackGroundBattle7", bmgId = 234}
, 
[57] = {id = 57, dungeontype = 3, sectionID = 30101, foreGround = "ForeGroundT1", backGround = "BackGroundBattle3", bmgId = 130}
, 
[58] = {id = 58, dungeontype = 3, sectionID = 30102, foreGround = "ForeGroundT1", backGround = "BackGroundBattle3", bmgId = 130}
, 
[59] = {id = 59, dungeontype = 3, sectionID = 30103, foreGround = "ForeGroundT1", backGround = "BackGroundBattle3", bmgId = 130}
, 
[60] = {id = 60, dungeontype = 3, sectionID = 30104, foreGround = "ForeGroundT1", backGround = "BackGroundBattle3", bmgId = 130}
, 
[61] = {id = 61, dungeontype = 3, sectionID = 40101, foreGround = "ForeGroundT1", backGround = "BackGroundBattle2", bmgId = 130}
, 
[62] = {id = 62, dungeontype = 3, sectionID = 40102, foreGround = "ForeGroundT1", backGround = "BackGroundBattle2", bmgId = 130}
, 
[63] = {id = 63, dungeontype = 3, sectionID = 40103, foreGround = "ForeGroundT1", backGround = "BackGroundBattle2", bmgId = 135}
, 
[64] = {id = 64, dungeontype = 3, sectionID = 40104, foreGround = "ForeGroundT1", backGround = "BackGroundBattle2", bmgId = 234}
, 
[65] = {id = 65, dungeontype = 3, sectionID = 40201, foreGround = "ForeGroundT1", backGround = "BackGroundBattle2", bmgId = 130}
, 
[66] = {id = 66, dungeontype = 3, sectionID = 40202, foreGround = "ForeGroundT1", backGround = "BackGroundBattle2", bmgId = 130}
, 
[67] = {id = 67, dungeontype = 3, sectionID = 40203, foreGround = "ForeGroundT1", backGround = "BackGroundBattle2", bmgId = 135}
, 
[68] = {id = 68, dungeontype = 3, sectionID = 40204, foreGround = "ForeGroundT1", backGround = "BackGroundBattle2", bmgId = 234}
, 
[69] = {id = 69, dungeontype = 3, sectionID = 40301, foreGround = "ForeGroundT1", backGround = "BackGroundBattle2", bmgId = 130}
, 
[70] = {id = 70, dungeontype = 3, sectionID = 40302, foreGround = "ForeGroundT1", backGround = "BackGroundBattle2", bmgId = 130}
, 
[71] = {id = 71, dungeontype = 3, sectionID = 40303, foreGround = "ForeGroundT1", backGround = "BackGroundBattle2", bmgId = 135}
, 
[72] = {id = 72, dungeontype = 3, sectionID = 40304, foreGround = "ForeGroundT1", backGround = "BackGroundBattle2", bmgId = 234}
, 
[73] = {id = 73, dungeontype = 2, sectionID = 42, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 130}
, 
[74] = {id = 74, dungeontype = 2, sectionID = 43, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 130}
, 
[75] = {id = 75, dungeontype = 2, sectionID = 44, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 130}
, 
[76] = {id = 76, dungeontype = 2, sectionID = 45, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 130}
, 
[77] = {id = 77, dungeontype = 2, sectionID = 46, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 130}
, 
[78] = {id = 78, dungeontype = 2, sectionID = 47, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 130}
, 
[79] = {id = 79, dungeontype = 2, sectionID = 48, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 574}
, 
[80] = {id = 80, dungeontype = 2, sectionID = 49, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 574}
, 
[81] = {id = 81, dungeontype = 2, sectionID = 50, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 574}
, 
[82] = {id = 82, dungeontype = 2, sectionID = 51, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 575}
, 
[83] = {id = 83, dungeontype = 2, sectionID = 52, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 575}
, 
[84] = {id = 84, dungeontype = 2, sectionID = 53, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 575}
, 
[85] = {id = 85, dungeontype = 2, sectionID = 54, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 574}
, 
[86] = {id = 86, dungeontype = 2, sectionID = 55, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 574}
, 
[87] = {id = 87, dungeontype = 2, sectionID = 56, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 575}
, 
[88] = {id = 88, dungeontype = 2, sectionID = 57, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 575}
, 
[89] = {id = 89, dungeontype = 2, sectionID = 58, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 574}
, 
[90] = {id = 90, dungeontype = 2, sectionID = 59, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 574}
, 
[91] = {id = 91, dungeontype = 2, sectionID = 60, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 575}
, 
[92] = {id = 92, dungeontype = 2, sectionID = 61, foreGround = "ForeGroundW2", backGround = "BackGroundW2", bmgId = 575}
, 
[93] = {id = 93, dungeontype = 2, sectionID = 62, foreGround = "ForeGroundW4", backGround = "BackGroundW4", bmgId = 576}
, 
[94] = {id = 94, dungeontype = 2, sectionID = 63, foreGround = "ForeGroundW4", backGround = "BackGroundW4", bmgId = 576}
, 
[95] = {id = 95, dungeontype = 2, sectionID = 64, foreGround = "ForeGroundW4", backGround = "BackGroundW4", bmgId = 576}
, 
[96] = {id = 96, dungeontype = 2, sectionID = 65, foreGround = "ForeGroundW4", backGround = "BackGroundW4", bmgId = 576}
, 
[97] = {id = 97, dungeontype = 2, sectionID = 66, foreGround = "ForeGroundW4", backGround = "BackGroundW4", bmgId = 576}
, 
[98] = {id = 98, dungeontype = 2, sectionID = 67, foreGround = "ForeGroundW4", backGround = "BackGroundW4", bmgId = 576}
, 
[99] = {id = 99, dungeontype = 2, sectionID = 68, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 130}
, 
[100] = {id = 100, dungeontype = 2, sectionID = 69, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 130}
, 
[101] = {id = 101, dungeontype = 2, sectionID = 70, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 130}
, 
[102] = {id = 102, dungeontype = 2, sectionID = 71, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 130}
, 
[103] = {id = 103, dungeontype = 2, sectionID = 72, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 130}
, 
[104] = {id = 104, dungeontype = 2, sectionID = 73, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 130}
, 
[105] = {id = 105, dungeontype = 3, sectionID = 20104, foreGround = "ForeGroundT1", backGround = "BackGroundBattle5", bmgId = 130}
, 
[106] = {id = 106, dungeontype = 3, sectionID = 20105, foreGround = "ForeGroundT1", backGround = "BackGroundBattle5", bmgId = 135}
, 
[107] = {id = 107, dungeontype = 3, sectionID = 20106, foreGround = "ForeGroundT1", backGround = "BackGroundBattle5", bmgId = 234}
, 
[108] = {id = 108, dungeontype = 3, sectionID = 20204, foreGround = "ForeGroundT1", backGround = "BackGroundBattle6", bmgId = 130}
, 
[109] = {id = 109, dungeontype = 3, sectionID = 20205, foreGround = "ForeGroundT1", backGround = "BackGroundBattle6", bmgId = 135}
, 
[110] = {id = 110, dungeontype = 3, sectionID = 20206, foreGround = "ForeGroundT1", backGround = "BackGroundBattle6", bmgId = 234}
, 
[111] = {id = 111, dungeontype = 3, sectionID = 20304, foreGround = "ForeGroundT1", backGround = "BackGroundBattle7", bmgId = 130}
, 
[112] = {id = 112, dungeontype = 3, sectionID = 20305, foreGround = "ForeGroundT1", backGround = "BackGroundBattle7", bmgId = 135}
, 
[113] = {id = 113, dungeontype = 3, sectionID = 20306, foreGround = "ForeGroundT1", backGround = "BackGroundBattle7", bmgId = 234}
, 
[114] = {id = 114, dungeontype = 3, sectionID = 30105, foreGround = "ForeGroundT1", backGround = "BackGroundBattle3", bmgId = 130}
, 
[115] = {id = 115, dungeontype = 3, sectionID = 30106, foreGround = "ForeGroundT1", backGround = "BackGroundBattle3", bmgId = 130}
, 
[116] = {id = 116, dungeontype = 3, sectionID = 30107, foreGround = "ForeGroundT1", backGround = "BackGroundBattle3", bmgId = 130}
, 
[117] = {id = 117, dungeontype = 3, sectionID = 30108, foreGround = "ForeGroundT1", backGround = "BackGroundBattle3", bmgId = 130}
, 
[118] = {id = 118, dungeontype = 2, sectionID = 74, foreGround = "", backGround = "BackGroundW3", bmgId = 994}
, 
[119] = {id = 119, dungeontype = 2, sectionID = 75, foreGround = "", backGround = "BackGroundW3", bmgId = 995}
, 
[120] = {id = 120, dungeontype = 2, sectionID = 76, foreGround = "", backGround = "BackGroundW3", bmgId = 994}
, 
[121] = {id = 121, dungeontype = 2, sectionID = 77, foreGround = "", backGround = "BackGroundW3", bmgId = 995}
, 
[122] = {id = 122, dungeontype = 2, sectionID = 78, foreGround = "", backGround = "BackGroundW3", bmgId = 994}
, 
[123] = {id = 123, dungeontype = 2, sectionID = 79, foreGround = "", backGround = "BackGroundW3", bmgId = 995}
, 
[124] = {id = 124, dungeontype = 2, sectionID = 80, foreGround = "", backGround = "BackGroundW3", bmgId = 994}
, 
[125] = {id = 125, dungeontype = 2, sectionID = 81, foreGround = "", backGround = "BackGroundW3", bmgId = 995}
, 
[126] = {id = 126, dungeontype = 2, sectionID = 82, foreGround = "", backGround = "BackGroundW3", bmgId = 994}
, 
[127] = {id = 127, dungeontype = 2, sectionID = 83, foreGround = "", backGround = "BackGroundW3", bmgId = 995}
, 
[128] = {id = 128, dungeontype = 2, sectionID = 84, foreGround = "", backGround = "BackGroundW3", bmgId = 994}
, 
[129] = {id = 129, dungeontype = 2, sectionID = 85, foreGround = "", backGround = "BackGroundW3", bmgId = 995}
, 
[130] = {id = 130, dungeontype = 2, sectionID = 86, foreGround = "", backGround = "BackGroundW3", bmgId = 994}
, 
[131] = {id = 131, dungeontype = 2, sectionID = 87, foreGround = "", backGround = "BackGroundW3", bmgId = 995}
, 
[132] = {id = 132, dungeontype = 2, sectionID = 88, foreGround = "", backGround = "BackGroundW3", bmgId = 994}
, 
[133] = {id = 133, dungeontype = 2, sectionID = 89, foreGround = "", backGround = "BackGroundW3", bmgId = 995}
, 
[134] = {id = 134, dungeontype = 2, sectionID = 90, foreGround = "", backGround = "BackGroundW3", bmgId = 994}
, 
[135] = {id = 135, dungeontype = 2, sectionID = 91, foreGround = "", backGround = "BackGroundW3", bmgId = 995}
, 
[136] = {id = 136, dungeontype = 3, sectionID = 40105, foreGround = "ForeGroundT1", backGround = "BackGroundBattle2", bmgId = 130}
, 
[137] = {id = 137, dungeontype = 3, sectionID = 40106, foreGround = "ForeGroundT1", backGround = "BackGroundBattle2", bmgId = 130}
, 
[138] = {id = 138, dungeontype = 3, sectionID = 40107, foreGround = "ForeGroundT1", backGround = "BackGroundBattle2", bmgId = 135}
, 
[139] = {id = 139, dungeontype = 3, sectionID = 40108, foreGround = "ForeGroundT1", backGround = "BackGroundBattle2", bmgId = 234}
, 
[140] = {id = 140, dungeontype = 3, sectionID = 40205, foreGround = "ForeGroundT1", backGround = "BackGroundBattle2", bmgId = 130}
, 
[141] = {id = 141, dungeontype = 3, sectionID = 40206, foreGround = "ForeGroundT1", backGround = "BackGroundBattle2", bmgId = 130}
, 
[142] = {id = 142, dungeontype = 3, sectionID = 40207, foreGround = "ForeGroundT1", backGround = "BackGroundBattle2", bmgId = 135}
, 
[143] = {id = 143, dungeontype = 3, sectionID = 40208, foreGround = "ForeGroundT1", backGround = "BackGroundBattle2", bmgId = 234}
, 
[144] = {id = 144, dungeontype = 3, sectionID = 40305, foreGround = "ForeGroundT1", backGround = "BackGroundBattle2", bmgId = 130}
, 
[145] = {id = 145, dungeontype = 3, sectionID = 40306, foreGround = "ForeGroundT1", backGround = "BackGroundBattle2", bmgId = 130}
, 
[146] = {id = 146, dungeontype = 3, sectionID = 40307, foreGround = "ForeGroundT1", backGround = "BackGroundBattle2", bmgId = 135}
, 
[147] = {id = 147, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle2", bmgId = 234}
, 
[148] = {id = 148, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[149] = {id = 149, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[150] = {id = 150, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[151] = {id = 151, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[152] = {id = 152, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[153] = {id = 153, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[154] = {id = 154, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[155] = {id = 155, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[156] = {id = 156, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[157] = {id = 157, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[158] = {id = 158, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[159] = {id = 159, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[160] = {id = 160, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[161] = {id = 161, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[162] = {id = 162, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[163] = {id = 163, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[164] = {id = 164, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[165] = {id = 165, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[166] = {id = 166, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[167] = {id = 167, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[168] = {id = 168, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[169] = {id = 169, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[170] = {id = 170, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[171] = {id = 171, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[172] = {id = 172, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[173] = {id = 173, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[174] = {id = 174, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[175] = {id = 175, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[176] = {id = 176, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[177] = {id = 177, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[178] = {id = 178, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[179] = {id = 179, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[180] = {id = 180, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[181] = {id = 181, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[182] = {id = 182, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[183] = {id = 183, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[184] = {id = 184, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[185] = {id = 185, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[186] = {id = 186, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[187] = {id = 187, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[188] = {id = 188, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[189] = {id = 189, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[190] = {id = 190, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[191] = {id = 191, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[192] = {id = 192, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[193] = {id = 193, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[194] = {id = 194, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[195] = {id = 195, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[196] = {id = 196, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[197] = {id = 197, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[198] = {id = 198, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[199] = {id = 199, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[200] = {id = 200, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[201] = {id = 201, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[202] = {id = 202, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[203] = {id = 203, dungeontype = 3, sectionID = 40308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[204] = {id = 204, dungeontype = 8, sectionID = 18001401, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[205] = {id = 205, dungeontype = 8, sectionID = 18001402, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[206] = {id = 206, dungeontype = 8, sectionID = 18001403, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[207] = {id = 207, dungeontype = 8, sectionID = 18001404, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[208] = {id = 208, dungeontype = 8, sectionID = 18001405, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[209] = {id = 209, dungeontype = 8, sectionID = 18001406, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[210] = {id = 210, dungeontype = 8, sectionID = 18001407, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[211] = {id = 211, dungeontype = 8, sectionID = 18001408, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[212] = {id = 212, dungeontype = 8, sectionID = 18001409, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[213] = {id = 213, dungeontype = 8, sectionID = 18001410, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[214] = {id = 214, dungeontype = 8, sectionID = 18001411, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[215] = {id = 215, dungeontype = 8, sectionID = 18001412, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[216] = {id = 216, dungeontype = 8, sectionID = 18001413, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[217] = {id = 217, dungeontype = 8, sectionID = 18001414, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[218] = {id = 218, dungeontype = 8, sectionID = 18001415, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[219] = {id = 219, dungeontype = 8, sectionID = 18001416, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[220] = {id = 220, dungeontype = 8, sectionID = 18001417, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[221] = {id = 221, dungeontype = 8, sectionID = 18001418, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[222] = {id = 222, dungeontype = 8, sectionID = 18001419, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[223] = {id = 223, dungeontype = 8, sectionID = 18001420, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[224] = {id = 224, dungeontype = 8, sectionID = 18001421, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[225] = {id = 225, dungeontype = 8, sectionID = 18001422, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[226] = {id = 226, dungeontype = 8, sectionID = 18001423, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[227] = {id = 227, dungeontype = 8, sectionID = 18001424, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[228] = {id = 228, dungeontype = 8, sectionID = 18001425, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[229] = {id = 229, dungeontype = 8, sectionID = 18001426, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[230] = {id = 230, dungeontype = 8, sectionID = 18001427, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[231] = {id = 231, dungeontype = 8, sectionID = 18001428, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[232] = {id = 232, dungeontype = 8, sectionID = 18001429, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[233] = {id = 233, dungeontype = 8, sectionID = 18001430, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[234] = {id = 234, dungeontype = 8, sectionID = 18001431, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[235] = {id = 235, dungeontype = 8, sectionID = 18001432, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[236] = {id = 236, dungeontype = 8, sectionID = 18001433, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[237] = {id = 237, dungeontype = 8, sectionID = 18001434, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[238] = {id = 238, dungeontype = 8, sectionID = 18001435, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[239] = {id = 239, dungeontype = 8, sectionID = 18001436, foreGround = "ForeGroundT1", backGround = "BackGroundBattle9", bmgId = 1356}
, 
[240] = {id = 240, dungeontype = 8, sectionID = 27001401, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[241] = {id = 241, dungeontype = 8, sectionID = 27001402, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[242] = {id = 242, dungeontype = 8, sectionID = 27001403, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[243] = {id = 243, dungeontype = 8, sectionID = 27001404, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[244] = {id = 244, dungeontype = 8, sectionID = 27001405, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[245] = {id = 245, dungeontype = 8, sectionID = 27001406, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[246] = {id = 246, dungeontype = 8, sectionID = 27001407, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[247] = {id = 247, dungeontype = 8, sectionID = 27001408, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[248] = {id = 248, dungeontype = 8, sectionID = 27001409, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[249] = {id = 249, dungeontype = 8, sectionID = 27001410, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[250] = {id = 250, dungeontype = 8, sectionID = 27001411, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[251] = {id = 251, dungeontype = 8, sectionID = 27001412, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[252] = {id = 252, dungeontype = 8, sectionID = 27001413, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[253] = {id = 253, dungeontype = 8, sectionID = 27001414, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[254] = {id = 254, dungeontype = 8, sectionID = 27001415, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[255] = {id = 255, dungeontype = 8, sectionID = 27001416, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[256] = {id = 256, dungeontype = 8, sectionID = 27001417, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[257] = {id = 257, dungeontype = 8, sectionID = 27001418, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[258] = {id = 258, dungeontype = 8, sectionID = 27001419, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[259] = {id = 259, dungeontype = 8, sectionID = 27001420, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[260] = {id = 260, dungeontype = 8, sectionID = 27001421, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[261] = {id = 261, dungeontype = 8, sectionID = 27001422, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[262] = {id = 262, dungeontype = 8, sectionID = 27001423, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[263] = {id = 263, dungeontype = 8, sectionID = 27001424, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[264] = {id = 264, dungeontype = 8, sectionID = 27001425, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[265] = {id = 265, dungeontype = 8, sectionID = 27001426, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[266] = {id = 266, dungeontype = 8, sectionID = 27001427, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[267] = {id = 267, dungeontype = 8, sectionID = 27001428, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[268] = {id = 268, dungeontype = 8, sectionID = 27001429, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[269] = {id = 269, dungeontype = 8, sectionID = 27001430, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[270] = {id = 270, dungeontype = 8, sectionID = 27001431, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[271] = {id = 271, dungeontype = 8, sectionID = 27001432, foreGround = "ForeGroundT1", backGround = "BackGroundBattle10", bmgId = 1362}
, 
[272] = {id = 272, dungeontype = 8, sectionID = 40001401, foreGround = "", backGround = "BackGroundBattle11", bmgId = 135}
, 
[273] = {id = 273, dungeontype = 8, sectionID = 40001402, foreGround = "", backGround = "BackGroundBattle11", bmgId = 135}
, 
[274] = {id = 274, dungeontype = 8, sectionID = 40001403, foreGround = "", backGround = "BackGroundBattle11", bmgId = 135}
, 
[275] = {id = 275, dungeontype = 8, sectionID = 40001404, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 135}
, 
[276] = {id = 276, dungeontype = 8, sectionID = 40001405, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 135}
, 
[277] = {id = 277, dungeontype = 8, sectionID = 40001406, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 135}
, 
[278] = {id = 278, dungeontype = 8, sectionID = 40001407, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 135}
, 
[279] = {id = 279, dungeontype = 8, sectionID = 40001408, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 135}
, 
[280] = {id = 280, dungeontype = 8, sectionID = 40001409, foreGround = "", backGround = "BackGroundBattle11", bmgId = 135}
, 
[281] = {id = 281, dungeontype = 8, sectionID = 40001410, foreGround = "", backGround = "BackGroundBattle11", bmgId = 135}
, 
[282] = {id = 282, dungeontype = 8, sectionID = 40001411, foreGround = "", backGround = "BackGroundBattle11", bmgId = 135}
, 
[283] = {id = 283, dungeontype = 8, sectionID = 40001412, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 135}
, 
[284] = {id = 284, dungeontype = 8, sectionID = 40001413, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 135}
, 
[285] = {id = 285, dungeontype = 8, sectionID = 40001414, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 135}
, 
[286] = {id = 286, dungeontype = 8, sectionID = 40001415, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 135}
, 
[287] = {id = 287, dungeontype = 8, sectionID = 40001416, foreGround = "ForeGroundT1", backGround = "BackGroundT1", bmgId = 135}
, 
[288] = {id = 288, dungeontype = 8, sectionID = 10000, foreGround = "", backGround = "BackGroundBattle11", bmgId = 135}
, 
[289] = {id = 289, dungeontype = 8, sectionID = 10001, foreGround = "", backGround = "BackGroundBattle11", bmgId = 135}
, 
[290] = {id = 290, dungeontype = 8, sectionID = 10002, foreGround = "", backGround = "BackGroundBattle11", bmgId = 135}
, 
[291] = {id = 291, dungeontype = 8, sectionID = 10003, foreGround = "", backGround = "BackGroundBattle11", bmgId = 135}
, 
[292] = {id = 292, dungeontype = 8, sectionID = 10004, foreGround = "", backGround = "BackGroundBattle11", bmgId = 135}
, 
[293] = {id = 293, dungeontype = 8, sectionID = 10005, foreGround = "", backGround = "BackGroundBattle11", bmgId = 135}
, 
[294] = {id = 294, dungeontype = 8, sectionID = 10006, foreGround = "", backGround = "BackGroundBattle11", bmgId = 135}
, 
[295] = {id = 295, dungeontype = 8, sectionID = 10007, foreGround = "", backGround = "BackGroundBattle11", bmgId = 135}
, 
[296] = {id = 296, dungeontype = 8, sectionID = 10008, foreGround = "", backGround = "BackGroundBattle11", bmgId = 135}
, 
[297] = {id = 297, dungeontype = 8, sectionID = 10009, foreGround = "", backGround = "BackGroundBattle11", bmgId = 135}
, 
[298] = {id = 298, dungeontype = 8, sectionID = 10010, foreGround = "", backGround = "BackGroundBattle11", bmgId = 135}
, 
[299] = {id = 299, dungeontype = 8, sectionID = 10011, foreGround = "", backGround = "BackGroundBattle11", bmgId = 135}
, 
[300] = {id = 300, dungeontype = 8, sectionID = 10012, foreGround = "", backGround = "BackGroundBattle11", bmgId = 135}
, 
[301] = {id = 301, dungeontype = 8, sectionID = 10013, foreGround = "", backGround = "BackGroundBattle11", bmgId = 135}
, 
[302] = {id = 302, dungeontype = 8, sectionID = 10014, foreGround = "", backGround = "BackGroundBattle11", bmgId = 135}
, 
[303] = {id = 303, dungeontype = 8, sectionID = 10015, foreGround = "", backGround = "BackGroundBattle11", bmgId = 135}
, 
[304] = {id = 304, dungeontype = 8, sectionID = 10032, foreGround = "", backGround = "BackGroundBattle11", bmgId = 1252}
, 
[305] = {id = 305, dungeontype = 8, sectionID = 10033, foreGround = "", backGround = "BackGroundBattle11", bmgId = 1252}
, 
[306] = {id = 306, dungeontype = 8, sectionID = 10034, foreGround = "", backGround = "BackGroundBattle11", bmgId = 1252}
, 
[307] = {id = 307, dungeontype = 8, sectionID = 10035, foreGround = "", backGround = "BackGroundBattle11", bmgId = 1252}
, 
[308] = {id = 308, dungeontype = 8, sectionID = 10036, foreGround = "", backGround = "BackGroundBattle11", bmgId = 1252}
, 
[309] = {id = 309, dungeontype = 8, sectionID = 10037, foreGround = "", backGround = "BackGroundBattle11", bmgId = 1252}
, 
[310] = {id = 310, dungeontype = 8, sectionID = 10038, foreGround = "", backGround = "BackGroundBattle11", bmgId = 1252}
, 
[311] = {id = 311, dungeontype = 8, sectionID = 10039, foreGround = "", backGround = "BackGroundBattle11", bmgId = 1252}
, 
[312] = {id = 312, dungeontype = 8, sectionID = 10040, foreGround = "", backGround = "BackGroundBattle11", bmgId = 1253}
, 
[313] = {id = 313, dungeontype = 8, sectionID = 10041, foreGround = "", backGround = "BackGroundBattle11", bmgId = 1253}
, 
[314] = {id = 314, dungeontype = 8, sectionID = 10042, foreGround = "", backGround = "BackGroundBattle11", bmgId = 1253}
, 
[315] = {id = 315, dungeontype = 8, sectionID = 10043, foreGround = "", backGround = "BackGroundBattle11", bmgId = 1253}
, 
[316] = {id = 316, dungeontype = 8, sectionID = 10044, foreGround = "", backGround = "BackGroundBattle11", bmgId = 1253}
, 
[317] = {id = 317, dungeontype = 8, sectionID = 10045, foreGround = "", backGround = "BackGroundBattle11", bmgId = 1253}
, 
[318] = {id = 318, dungeontype = 8, sectionID = 10046, foreGround = "", backGround = "BackGroundBattle11", bmgId = 1253}
, 
[319] = {id = 319, dungeontype = 2, sectionID = 92, foreGround = "", backGround = "BackGroundW3 _n", bmgId = 1409}
, 
[320] = {id = 320, dungeontype = 2, sectionID = 93, foreGround = "", backGround = "BackGroundW3 _n", bmgId = 1409}
, 
[321] = {id = 321, dungeontype = 2, sectionID = 94, foreGround = "", backGround = "BackGroundW3 _n", bmgId = 1409}
, 
[322] = {id = 322, dungeontype = 2, sectionID = 95, foreGround = "", backGround = "BackGroundW3 _n", bmgId = 1409}
, 
[323] = {id = 323, dungeontype = 2, sectionID = 96, foreGround = "", backGround = "BackGroundW3 _n", bmgId = 1409}
, 
[324] = {id = 324, dungeontype = 2, sectionID = 97, foreGround = "", backGround = "BackGroundW3 _n", bmgId = 1409}
, 
[325] = {id = 325, dungeontype = 2, sectionID = 98, foreGround = "", backGround = "BackGroundW3 _n", bmgId = 1409}
, 
[326] = {id = 326, dungeontype = 2, sectionID = 99, foreGround = "", backGround = "BackGroundW3 _n", bmgId = 1409}
, 
[327] = {id = 327, dungeontype = 2, sectionID = 100, foreGround = "", backGround = "BackGroundW3 _n", bmgId = 1409}
, 
[328] = {id = 328, dungeontype = 2, sectionID = 101, foreGround = "", backGround = "BackGroundW3 _n", bmgId = 1409}
, 
[329] = {id = 329, dungeontype = 2, sectionID = 102, foreGround = "", backGround = "BackGroundW3 _n", bmgId = 1409}
, 
[330] = {id = 330, dungeontype = 2, sectionID = 103, foreGround = "", backGround = "BackGroundW3 _n", bmgId = 1409}
, 
[331] = {id = 331, dungeontype = 2, sectionID = 104, foreGround = "", backGround = "BackGroundW3 _n", bmgId = 1409}
, 
[332] = {id = 332, dungeontype = 2, sectionID = 105, foreGround = "", backGround = "BackGroundW3 _n", bmgId = 1409}
, 
[333] = {id = 333, dungeontype = 2, sectionID = 106, foreGround = "", backGround = "BackGroundW3 _n", bmgId = 1409}
, 
[334] = {id = 334, dungeontype = 2, sectionID = 107, foreGround = "", backGround = "BackGroundW3 _n", bmgId = 1409}
, 
[335] = {id = 335, dungeontype = 2, sectionID = 108, foreGround = "", backGround = "BackGroundW3 _n", bmgId = 1409}
, 
[336] = {id = 336, dungeontype = 2, sectionID = 109, foreGround = "", backGround = "BackGroundW3 _n", bmgId = 1409}
, 
[337] = {id = 337, dungeontype = 8, sectionID = 46001301, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[338] = {id = 338, dungeontype = 8, sectionID = 46001302, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[339] = {id = 339, dungeontype = 8, sectionID = 46001303, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[340] = {id = 340, dungeontype = 8, sectionID = 46001304, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[341] = {id = 341, dungeontype = 8, sectionID = 46001305, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[342] = {id = 342, dungeontype = 8, sectionID = 46001306, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[343] = {id = 343, dungeontype = 8, sectionID = 46001307, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[344] = {id = 344, dungeontype = 8, sectionID = 46001308, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[345] = {id = 345, dungeontype = 8, sectionID = 46001309, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
, 
[346] = {id = 346, dungeontype = 8, sectionID = 46001310, foreGround = "ForeGroundT1", backGround = "BackGroundBattle8", bmgId = 1324}
}
cautoexplore.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346}
return cautoexplore

