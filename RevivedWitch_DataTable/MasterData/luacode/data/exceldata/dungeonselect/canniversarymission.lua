-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/dungeonselect/canniversarymission.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local canniversarymission = {}
canniversarymission.Data = {
[1] = {id = 1, eventid = 1, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[2] = {id = 2, eventid = 1, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[3] = {id = 3, eventid = 2, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[4] = {id = 4, eventid = 2, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[5] = {id = 5, eventid = 3, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[6] = {id = 6, eventid = 3, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[7] = {id = 7, eventid = 4, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[8] = {id = 8, eventid = 4, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[9] = {id = 9, eventid = 5, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[10] = {id = 10, eventid = 5, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[11] = {id = 11, eventid = 6, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[12] = {id = 12, eventid = 6, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[13] = {id = 13, eventid = 7, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[14] = {id = 14, eventid = 7, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[15] = {id = 15, eventid = 8, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[16] = {id = 16, eventid = 8, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[17] = {id = 17, eventid = 9, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[18] = {id = 18, eventid = 9, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[19] = {id = 19, eventid = 10, missiontype = 1, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[20] = {id = 20, eventid = 10, missiontype = 2, levelid = 40001407, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[21] = {id = 21, eventid = 11, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[22] = {id = 22, eventid = 11, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[23] = {id = 23, eventid = 12, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[24] = {id = 24, eventid = 12, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[25] = {id = 25, eventid = 13, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[26] = {id = 26, eventid = 13, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[27] = {id = 27, eventid = 14, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[28] = {id = 28, eventid = 14, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[29] = {id = 29, eventid = 15, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[30] = {id = 30, eventid = 15, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[31] = {id = 31, eventid = 16, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[32] = {id = 32, eventid = 16, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[33] = {id = 33, eventid = 17, missiontype = 1, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[34] = {id = 34, eventid = 17, missiontype = 2, levelid = 40001407, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[35] = {id = 35, eventid = 18, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[36] = {id = 36, eventid = 18, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[37] = {id = 37, eventid = 19, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[38] = {id = 38, eventid = 19, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[39] = {id = 39, eventid = 20, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[40] = {id = 40, eventid = 20, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[41] = {id = 41, eventid = 21, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[42] = {id = 42, eventid = 21, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[43] = {id = 43, eventid = 22, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[44] = {id = 44, eventid = 22, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[45] = {id = 45, eventid = 23, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[46] = {id = 46, eventid = 23, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[47] = {id = 47, eventid = 24, missiontype = 1, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[48] = {id = 48, eventid = 24, missiontype = 2, levelid = 40001407, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[49] = {id = 49, eventid = 25, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[50] = {id = 50, eventid = 25, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[51] = {id = 51, eventid = 26, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[52] = {id = 52, eventid = 26, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[53] = {id = 53, eventid = 27, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[54] = {id = 54, eventid = 27, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[55] = {id = 55, eventid = 28, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[56] = {id = 56, eventid = 28, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[57] = {id = 57, eventid = 29, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[58] = {id = 58, eventid = 29, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[59] = {id = 59, eventid = 30, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[60] = {id = 60, eventid = 30, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[61] = {id = 61, eventid = 31, missiontype = 1, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[62] = {id = 62, eventid = 31, missiontype = 2, levelid = 40001407, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[63] = {id = 63, eventid = 32, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[64] = {id = 64, eventid = 32, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[65] = {id = 65, eventid = 33, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[66] = {id = 66, eventid = 33, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[67] = {id = 67, eventid = 34, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[68] = {id = 68, eventid = 34, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[69] = {id = 69, eventid = 35, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[70] = {id = 70, eventid = 35, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[71] = {id = 71, eventid = 36, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[72] = {id = 72, eventid = 36, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[73] = {id = 73, eventid = 37, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[74] = {id = 74, eventid = 37, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[75] = {id = 75, eventid = 38, missiontype = 1, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[76] = {id = 76, eventid = 38, missiontype = 2, levelid = 40001407, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[77] = {id = 77, eventid = 39, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[78] = {id = 78, eventid = 39, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[79] = {id = 79, eventid = 40, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[80] = {id = 80, eventid = 40, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[81] = {id = 81, eventid = 41, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[82] = {id = 82, eventid = 41, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[83] = {id = 83, eventid = 42, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[84] = {id = 84, eventid = 42, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[85] = {id = 85, eventid = 43, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[86] = {id = 86, eventid = 43, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[87] = {id = 87, eventid = 44, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[88] = {id = 88, eventid = 44, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[89] = {id = 89, eventid = 45, missiontype = 1, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[90] = {id = 90, eventid = 45, missiontype = 2, levelid = 40001407, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[91] = {id = 91, eventid = 46, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[92] = {id = 92, eventid = 46, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[93] = {id = 93, eventid = 47, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[94] = {id = 94, eventid = 47, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[95] = {id = 95, eventid = 48, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[96] = {id = 96, eventid = 48, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[97] = {id = 97, eventid = 49, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[98] = {id = 98, eventid = 49, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[99] = {id = 99, eventid = 50, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[100] = {id = 100, eventid = 50, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[101] = {id = 101, eventid = 51, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[102] = {id = 102, eventid = 51, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[103] = {id = 103, eventid = 52, missiontype = 1, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[104] = {id = 104, eventid = 52, missiontype = 2, levelid = 40001407, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[105] = {id = 105, eventid = 53, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[106] = {id = 106, eventid = 53, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[107] = {id = 107, eventid = 54, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[108] = {id = 108, eventid = 54, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[109] = {id = 109, eventid = 55, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[110] = {id = 110, eventid = 55, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[111] = {id = 111, eventid = 56, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[112] = {id = 112, eventid = 56, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[113] = {id = 113, eventid = 57, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[114] = {id = 114, eventid = 57, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[115] = {id = 115, eventid = 58, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[116] = {id = 116, eventid = 58, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[117] = {id = 117, eventid = 59, missiontype = 1, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[118] = {id = 118, eventid = 59, missiontype = 2, levelid = 40001407, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[119] = {id = 119, eventid = 60, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[120] = {id = 120, eventid = 60, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[121] = {id = 121, eventid = 61, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[122] = {id = 122, eventid = 61, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[123] = {id = 123, eventid = 62, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[124] = {id = 124, eventid = 62, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[125] = {id = 125, eventid = 63, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[126] = {id = 126, eventid = 63, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[127] = {id = 127, eventid = 64, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[128] = {id = 128, eventid = 64, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[129] = {id = 129, eventid = 65, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[130] = {id = 130, eventid = 65, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[131] = {id = 131, eventid = 66, missiontype = 1, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[132] = {id = 132, eventid = 66, missiontype = 2, levelid = 40001407, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[133] = {id = 133, eventid = 67, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[134] = {id = 134, eventid = 67, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[135] = {id = 135, eventid = 68, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[136] = {id = 136, eventid = 68, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[137] = {id = 137, eventid = 69, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[138] = {id = 138, eventid = 69, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[139] = {id = 139, eventid = 70, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[140] = {id = 140, eventid = 70, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[141] = {id = 141, eventid = 71, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[142] = {id = 142, eventid = 71, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[143] = {id = 143, eventid = 72, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[144] = {id = 144, eventid = 72, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[145] = {id = 145, eventid = 73, missiontype = 1, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[146] = {id = 146, eventid = 73, missiontype = 2, levelid = 40001407, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[147] = {id = 147, eventid = 74, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[148] = {id = 148, eventid = 74, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[149] = {id = 149, eventid = 75, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[150] = {id = 150, eventid = 75, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[151] = {id = 151, eventid = 76, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[152] = {id = 152, eventid = 76, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[153] = {id = 153, eventid = 77, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[154] = {id = 154, eventid = 77, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[155] = {id = 155, eventid = 78, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[156] = {id = 156, eventid = 78, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[157] = {id = 157, eventid = 79, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[158] = {id = 158, eventid = 79, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[159] = {id = 159, eventid = 80, missiontype = 1, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[160] = {id = 160, eventid = 80, missiontype = 2, levelid = 40001407, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[161] = {id = 161, eventid = 81, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[162] = {id = 162, eventid = 81, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[163] = {id = 163, eventid = 82, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[164] = {id = 164, eventid = 82, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[165] = {id = 165, eventid = 83, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[166] = {id = 166, eventid = 83, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[167] = {id = 167, eventid = 84, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[168] = {id = 168, eventid = 84, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[169] = {id = 169, eventid = 85, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[170] = {id = 170, eventid = 85, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[171] = {id = 171, eventid = 86, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[172] = {id = 172, eventid = 86, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[173] = {id = 173, eventid = 87, missiontype = 1, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[174] = {id = 174, eventid = 87, missiontype = 2, levelid = 40001407, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[175] = {id = 175, eventid = 88, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[176] = {id = 176, eventid = 88, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[177] = {id = 177, eventid = 89, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[178] = {id = 178, eventid = 89, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[179] = {id = 179, eventid = 90, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[180] = {id = 180, eventid = 90, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[181] = {id = 181, eventid = 91, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[182] = {id = 182, eventid = 91, missiontype = 2, levelid = 40001404, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[183] = {id = 183, eventid = 92, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[184] = {id = 184, eventid = 92, missiontype = 2, levelid = 40001405, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[185] = {id = 185, eventid = 93, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[186] = {id = 186, eventid = 93, missiontype = 2, levelid = 40001406, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[187] = {id = 187, eventid = 94, missiontype = 1, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[188] = {id = 188, eventid = 94, missiontype = 2, levelid = 40001407, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[189] = {id = 189, eventid = 95, missiontype = 1, levelid = 40001401, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[190] = {id = 190, eventid = 95, missiontype = 2, levelid = 40001409, battlecount = 3, itemid = 31387, itemnum = 5}
, 
[191] = {id = 191, eventid = 96, missiontype = 1, levelid = 40001402, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[192] = {id = 192, eventid = 96, missiontype = 2, levelid = 40001410, battlecount = 3, itemid = 31390, itemnum = 5}
, 
[193] = {id = 193, eventid = 97, missiontype = 1, levelid = 40001403, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[194] = {id = 194, eventid = 97, missiontype = 2, levelid = 40001411, battlecount = 3, itemid = 31384, itemnum = 5}
, 
[195] = {id = 195, eventid = 98, missiontype = 1, levelid = 40001404, battlecount = 3, itemid = 31383, itemnum = 5}
, 
[196] = {id = 196, eventid = 98, missiontype = 2, levelid = 40001412, battlecount = 3, itemid = 31381, itemnum = 5}
, 
[197] = {id = 197, eventid = 99, missiontype = 1, levelid = 40001405, battlecount = 3, itemid = 31380, itemnum = 5}
, 
[198] = {id = 198, eventid = 99, missiontype = 2, levelid = 40001413, battlecount = 3, itemid = 31387, itemnum = 5}
, 
[199] = {id = 199, eventid = 100, missiontype = 1, levelid = 40001406, battlecount = 3, itemid = 31386, itemnum = 5}
, 
[200] = {id = 200, eventid = 100, missiontype = 2, levelid = 40001414, battlecount = 3, itemid = 31390, itemnum = 5}
, 
[201] = {id = 201, eventid = 101, missiontype = 1, levelid = 40001407, battlecount = 3, itemid = 31389, itemnum = 5}
, 
[202] = {id = 202, eventid = 101, missiontype = 2, levelid = 40001415, battlecount = 3, itemid = 31384, itemnum = 5}
}
canniversarymission.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202}
return canniversarymission

