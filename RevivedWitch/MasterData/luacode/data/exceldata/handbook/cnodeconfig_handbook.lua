-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/handbook/cnodeconfig_handbook.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cnodeconfig_handbook = {}
cnodeconfig_handbook.Data = {
[1] = {id = 1, parentNodeid = 0, xAxisPan = 0, yAxisPan = 0, nodeType = 1, handbookId = 1, condition = 0, extraLinkNode = "0"}
, 
[2] = {id = 2, parentNodeid = 1, xAxisPan = -152, yAxisPan = 177, nodeType = 2, handbookId = 20008, condition = 0, extraLinkNode = "0"}
, 
[3] = {id = 3, parentNodeid = 1, xAxisPan = 0, yAxisPan = 177, nodeType = 2, handbookId = 20009, condition = 0, extraLinkNode = "0"}
, 
[4] = {id = 4, parentNodeid = 1, xAxisPan = 145, yAxisPan = 73, nodeType = 2, handbookId = 20010, condition = 0, extraLinkNode = "0"}
, 
[5] = {id = 5, parentNodeid = 1, xAxisPan = -720, yAxisPan = 663, nodeType = 3, handbookId = 1, condition = 0, extraLinkNode = "0"}
, 
[6] = {id = 6, parentNodeid = 5, xAxisPan = -720, yAxisPan = 461, nodeType = 4, handbookId = 40001, condition = 0, extraLinkNode = "0"}
, 
[7] = {id = 7, parentNodeid = 6, xAxisPan = -720, yAxisPan = 278, nodeType = 1, handbookId = 19, condition = 0, extraLinkNode = "0"}
, 
[8] = {id = 8, parentNodeid = 6, xAxisPan = -575, yAxisPan = 323, nodeType = 1, handbookId = 18, condition = 0, extraLinkNode = "0"}
, 
[9] = {id = 9, parentNodeid = 5, xAxisPan = -918, yAxisPan = 530, nodeType = 4, handbookId = 40002, condition = 0, extraLinkNode = "0"}
, 
[10] = {id = 10, parentNodeid = 9, xAxisPan = -1065, yAxisPan = 422, nodeType = 1, handbookId = 25, condition = 0, extraLinkNode = "0"}
, 
[11] = {id = 11, parentNodeid = 10, xAxisPan = -1172, yAxisPan = 312, nodeType = 1, handbookId = 24, condition = 0, extraLinkNode = "0"}
, 
[12] = {id = 12, parentNodeid = 9, xAxisPan = -918, yAxisPan = 310, nodeType = 1, handbookId = 23, condition = 0, extraLinkNode = "0"}
, 
[13] = {id = 13, parentNodeid = 5, xAxisPan = -972, yAxisPan = 663, nodeType = 4, handbookId = 40003, condition = 0, extraLinkNode = "0"}
, 
[14] = {id = 14, parentNodeid = 13, xAxisPan = -1167, yAxisPan = 663, nodeType = 1, handbookId = 4, condition = 0, extraLinkNode = "0"}
, 
[15] = {id = 15, parentNodeid = 14, xAxisPan = -1362, yAxisPan = 663, nodeType = 1, handbookId = 33, condition = 0, extraLinkNode = "0"}
, 
[16] = {id = 16, parentNodeid = 14, xAxisPan = -1362, yAxisPan = 504, nodeType = 1, handbookId = 37, condition = 0, extraLinkNode = "0"}
, 
[17] = {id = 17, parentNodeid = 5, xAxisPan = -910, yAxisPan = 782, nodeType = 4, handbookId = 40004, condition = 0, extraLinkNode = "0"}
, 
[18] = {id = 18, parentNodeid = 17, xAxisPan = -1078, yAxisPan = 930, nodeType = 2, handbookId = 20011, condition = 0, extraLinkNode = "0"}
, 
[19] = {id = 19, parentNodeid = 18, xAxisPan = -1205, yAxisPan = 930, nodeType = 2, handbookId = 20004, condition = 0, extraLinkNode = "0"}
, 
[20] = {id = 20, parentNodeid = 18, xAxisPan = -1144, yAxisPan = 1068, nodeType = 2, handbookId = 20001, condition = 0, extraLinkNode = "0"}
, 
[21] = {id = 21, parentNodeid = 19, xAxisPan = -1368, yAxisPan = 930, nodeType = 2, handbookId = 20012, condition = 0, extraLinkNode = "0"}
, 
[22] = {id = 22, parentNodeid = 5, xAxisPan = -720, yAxisPan = 876, nodeType = 4, handbookId = 40005, condition = 0, extraLinkNode = "0"}
, 
[23] = {id = 23, parentNodeid = 22, xAxisPan = -789, yAxisPan = 1042, nodeType = 2, handbookId = 20013, condition = 0, extraLinkNode = "0"}
, 
[24] = {id = 24, parentNodeid = 22, xAxisPan = -655, yAxisPan = 1042, nodeType = 2, handbookId = 20014, condition = 0, extraLinkNode = "0"}
, 
[25] = {id = 25, parentNodeid = 5, xAxisPan = -541, yAxisPan = 855, nodeType = 4, handbookId = 40006, condition = 0, extraLinkNode = "0"}
, 
[26] = {id = 26, parentNodeid = 25, xAxisPan = -360, yAxisPan = 1016, nodeType = 1, handbookId = 14, condition = 0, extraLinkNode = "0"}
, 
[27] = {id = 27, parentNodeid = 26, xAxisPan = -233, yAxisPan = 1066, nodeType = 1, handbookId = 13, condition = 0, extraLinkNode = "0"}
, 
[28] = {id = 28, parentNodeid = 27, xAxisPan = -107, yAxisPan = 1066, nodeType = 1, handbookId = 45, condition = 0, extraLinkNode = "0"}
, 
[29] = {id = 29, parentNodeid = 5, xAxisPan = -391, yAxisPan = 818, nodeType = 4, handbookId = 40007, condition = 0, extraLinkNode = "0"}
, 
[30] = {id = 30, parentNodeid = 29, xAxisPan = -233, yAxisPan = 902, nodeType = 1, handbookId = 17, condition = 0, extraLinkNode = "0"}
, 
[31] = {id = 31, parentNodeid = 30, xAxisPan = 52, yAxisPan = 947, nodeType = 1, handbookId = 2, condition = 0, extraLinkNode = "0"}
, 
[32] = {id = 32, parentNodeid = 30, xAxisPan = -109, yAxisPan = 794, nodeType = 1, handbookId = 47, condition = 0, extraLinkNode = "0"}
, 
[33] = {id = 33, parentNodeid = 32, xAxisPan = 7, yAxisPan = 794, nodeType = 1, handbookId = 38, condition = 0, extraLinkNode = "0"}
, 
[34] = {id = 34, parentNodeid = 5, xAxisPan = -281, yAxisPan = 663, nodeType = 4, handbookId = 40008, condition = 0, extraLinkNode = "0"}
, 
[35] = {id = 35, parentNodeid = 34, xAxisPan = -343, yAxisPan = 500, nodeType = 1, handbookId = 26, condition = 0, extraLinkNode = "0"}
, 
[36] = {id = 36, parentNodeid = 34, xAxisPan = -204, yAxisPan = 500, nodeType = 1, handbookId = 20, condition = 0, extraLinkNode = "0"}
, 
[37] = {id = 37, parentNodeid = 34, xAxisPan = -48, yAxisPan = 663, nodeType = 1, handbookId = 34, condition = 0, extraLinkNode = "0"}
, 
[38] = {id = 38, parentNodeid = 1, xAxisPan = -700, yAxisPan = -400, nodeType = 3, handbookId = 2, condition = 0, extraLinkNode = "0"}
, 
[39] = {id = 39, parentNodeid = 38, xAxisPan = -800, yAxisPan = -234, nodeType = 4, handbookId = 40009, condition = 0, extraLinkNode = "0"}
, 
[40] = {id = 40, parentNodeid = 39, xAxisPan = -900, yAxisPan = -66, nodeType = 1, handbookId = 3, condition = 0, extraLinkNode = "0"}
, 
[41] = {id = 41, parentNodeid = 39, xAxisPan = -726, yAxisPan = -66, nodeType = 1, handbookId = 9, condition = 0, extraLinkNode = "0"}
, 
[42] = {id = 42, parentNodeid = 38, xAxisPan = -950, yAxisPan = -400, nodeType = 4, handbookId = 40010, condition = 0, extraLinkNode = "0"}
, 
[43] = {id = 43, parentNodeid = 42, xAxisPan = -1090, yAxisPan = -250, nodeType = 2, handbookId = 20007, condition = 0, extraLinkNode = "0"}
, 
[44] = {id = 44, parentNodeid = 43, xAxisPan = -1220, yAxisPan = -120, nodeType = 2, handbookId = 20005, condition = 0, extraLinkNode = "0"}
, 
[45] = {id = 45, parentNodeid = 44, xAxisPan = -1347, yAxisPan = 2, nodeType = 2, handbookId = 20006, condition = 0, extraLinkNode = "0"}
, 
[46] = {id = 46, parentNodeid = 42, xAxisPan = -1151, yAxisPan = -400, nodeType = 2, handbookId = 20015, condition = 0, extraLinkNode = "0"}
, 
[47] = {id = 47, parentNodeid = 46, xAxisPan = -1357, yAxisPan = -400, nodeType = 2, handbookId = 20016, condition = 0, extraLinkNode = "0"}
, 
[48] = {id = 48, parentNodeid = 42, xAxisPan = -1078, yAxisPan = -566, nodeType = 2, handbookId = 20003, condition = 0, extraLinkNode = "0"}
, 
[49] = {id = 49, parentNodeid = 42, xAxisPan = -950, yAxisPan = -626, nodeType = 2, handbookId = 20002, condition = 0, extraLinkNode = "0"}
, 
[50] = {id = 50, parentNodeid = 38, xAxisPan = -800, yAxisPan = -557, nodeType = 4, handbookId = 40011, condition = 0, extraLinkNode = "0"}
, 
[51] = {id = 51, parentNodeid = 50, xAxisPan = -800, yAxisPan = -731, nodeType = 1, handbookId = 43, condition = 0, extraLinkNode = "0"}
, 
[52] = {id = 52, parentNodeid = 50, xAxisPan = -935, yAxisPan = -826, nodeType = 1, handbookId = 39, condition = 0, extraLinkNode = "0"}
, 
[53] = {id = 53, parentNodeid = 50, xAxisPan = -686, yAxisPan = -768, nodeType = 1, handbookId = 36, condition = 0, extraLinkNode = "0"}
, 
[54] = {id = 54, parentNodeid = 1, xAxisPan = 122, yAxisPan = -356, nodeType = 3, handbookId = 3, condition = 0, extraLinkNode = "0"}
, 
[55] = {id = 55, parentNodeid = 54, xAxisPan = -68, yAxisPan = -495, nodeType = 4, handbookId = 40012, condition = 0, extraLinkNode = "0"}
, 
[56] = {id = 56, parentNodeid = 55, xAxisPan = -144, yAxisPan = -326, nodeType = 1, handbookId = 21, condition = 0, extraLinkNode = "0"}
, 
[57] = {id = 57, parentNodeid = 55, xAxisPan = -255, yAxisPan = -495, nodeType = 1, handbookId = 22, condition = 0, extraLinkNode = "0"}
, 
[58] = {id = 58, parentNodeid = 55, xAxisPan = -144, yAxisPan = -667, nodeType = 1, handbookId = 15, condition = 0, extraLinkNode = "0"}
, 
[59] = {id = 59, parentNodeid = 54, xAxisPan = 122, yAxisPan = -600, nodeType = 4, handbookId = 40013, condition = 0, extraLinkNode = "0"}
, 
[60] = {id = 60, parentNodeid = 59, xAxisPan = 122, yAxisPan = -749, nodeType = 2, handbookId = 20017, condition = 0, extraLinkNode = "0"}
, 
[61] = {id = 61, parentNodeid = 60, xAxisPan = 63, yAxisPan = -899, nodeType = 2, handbookId = 20018, condition = 0, extraLinkNode = "0"}
, 
[62] = {id = 62, parentNodeid = 60, xAxisPan = 177, yAxisPan = -899, nodeType = 2, handbookId = 20019, condition = 0, extraLinkNode = "0"}
, 
[63] = {id = 63, parentNodeid = 59, xAxisPan = 311, yAxisPan = -701, nodeType = 2, handbookId = 20020, condition = 0, extraLinkNode = "0"}
, 
[64] = {id = 64, parentNodeid = 63, xAxisPan = 432, yAxisPan = -701, nodeType = 2, handbookId = 20021, condition = 0, extraLinkNode = "0"}
, 
[65] = {id = 65, parentNodeid = 63, xAxisPan = 377, yAxisPan = -859, nodeType = 2, handbookId = 20022, condition = 0, extraLinkNode = "0"}
, 
[66] = {id = 66, parentNodeid = 54, xAxisPan = 298, yAxisPan = -473, nodeType = 4, handbookId = 40014, condition = 0, extraLinkNode = "0"}
, 
[67] = {id = 67, parentNodeid = 66, xAxisPan = 340, yAxisPan = -473, nodeType = 1, handbookId = 35, condition = 0, extraLinkNode = "0"}
, 
[68] = {id = 68, parentNodeid = 1, xAxisPan = 988, yAxisPan = -344, nodeType = 3, handbookId = 4, condition = 0, extraLinkNode = "0"}
, 
[69] = {id = 69, parentNodeid = 68, xAxisPan = 988, yAxisPan = -527, nodeType = 4, handbookId = 40015, condition = 0, extraLinkNode = "0"}
, 
[70] = {id = 70, parentNodeid = 69, xAxisPan = 988, yAxisPan = -675, nodeType = 1, handbookId = 46, condition = 0, extraLinkNode = "0"}
, 
[71] = {id = 71, parentNodeid = 70, xAxisPan = 933, yAxisPan = -820, nodeType = 1, handbookId = 11, condition = 0, extraLinkNode = "0"}
, 
[72] = {id = 72, parentNodeid = 70, xAxisPan = 1041, yAxisPan = -820, nodeType = 1, handbookId = 10, condition = 0, extraLinkNode = "0"}
, 
[73] = {id = 73, parentNodeid = 71, xAxisPan = 767, yAxisPan = -820, nodeType = 1, handbookId = 40, condition = 0, extraLinkNode = "0"}
, 
[74] = {id = 74, parentNodeid = 73, xAxisPan = 659, yAxisPan = -932, nodeType = 1, handbookId = 28, condition = 0, extraLinkNode = "0"}
, 
[75] = {id = 75, parentNodeid = 68, xAxisPan = 1187, yAxisPan = -441, nodeType = 4, handbookId = 40017, condition = 0, extraLinkNode = "0"}
, 
[76] = {id = 76, parentNodeid = 75, xAxisPan = 1361, yAxisPan = -441, nodeType = 2, handbookId = 20023, condition = 0, extraLinkNode = "0"}
, 
[77] = {id = 77, parentNodeid = 76, xAxisPan = 1473, yAxisPan = -548, nodeType = 2, handbookId = 20024, condition = 0, extraLinkNode = "0"}
, 
[78] = {id = 78, parentNodeid = 68, xAxisPan = 1182, yAxisPan = -245, nodeType = 4, handbookId = 40016, condition = 0, extraLinkNode = "0"}
, 
[79] = {id = 79, parentNodeid = 78, xAxisPan = 1360, yAxisPan = -241, nodeType = 2, handbookId = 20025, condition = 0, extraLinkNode = "0"}
, 
[80] = {id = 80, parentNodeid = 1, xAxisPan = 1659, yAxisPan = 15, nodeType = 3, handbookId = 5, condition = 0, extraLinkNode = "0"}
, 
[81] = {id = 81, parentNodeid = 80, xAxisPan = 1801, yAxisPan = -152, nodeType = 4, handbookId = 40019, condition = 0, extraLinkNode = "0"}
, 
[82] = {id = 82, parentNodeid = 81, xAxisPan = 1973, yAxisPan = -305, nodeType = 1, handbookId = 41, condition = 0, extraLinkNode = "0"}
, 
[83] = {id = 83, parentNodeid = 82, xAxisPan = 1861, yAxisPan = -419, nodeType = 1, handbookId = 44, condition = 0, extraLinkNode = "0"}
, 
[84] = {id = 84, parentNodeid = 80, xAxisPan = 1906, yAxisPan = 21, nodeType = 4, handbookId = 40018, condition = 0, extraLinkNode = "0"}
, 
[85] = {id = 85, parentNodeid = 84, xAxisPan = 2102, yAxisPan = -42, nodeType = 2, handbookId = 20026, condition = 0, extraLinkNode = "0"}
, 
[86] = {id = 86, parentNodeid = 85, xAxisPan = 2167, yAxisPan = -202, nodeType = 2, handbookId = 20027, condition = 0, extraLinkNode = "0"}
, 
[87] = {id = 87, parentNodeid = 85, xAxisPan = 2251, yAxisPan = -42, nodeType = 2, handbookId = 20028, condition = 0, extraLinkNode = "0"}
, 
[88] = {id = 88, parentNodeid = 1, xAxisPan = 1771, yAxisPan = 456, nodeType = 3, handbookId = 6, condition = 0, extraLinkNode = "0"}
, 
[89] = {id = 89, parentNodeid = 88, xAxisPan = 1626, yAxisPan = 600, nodeType = 4, handbookId = 40020, condition = 0, extraLinkNode = "0"}
, 
[90] = {id = 90, parentNodeid = 89, xAxisPan = 1495, yAxisPan = 745, nodeType = 2, handbookId = 20029, condition = 0, extraLinkNode = "0"}
, 
[91] = {id = 91, parentNodeid = 90, xAxisPan = 1631, yAxisPan = 859, nodeType = 1, handbookId = 29, condition = 0, extraLinkNode = "0"}
, 
[92] = {id = 92, parentNodeid = 88, xAxisPan = 1921, yAxisPan = 600, nodeType = 4, handbookId = 40021, condition = 0, extraLinkNode = "0"}
, 
[93] = {id = 93, parentNodeid = 92, xAxisPan = 2094, yAxisPan = 779, nodeType = 2, handbookId = 20030, condition = 0, extraLinkNode = "0"}
, 
[94] = {id = 94, parentNodeid = 93, xAxisPan = 1949, yAxisPan = 939, nodeType = 2, handbookId = 20031, condition = 0, extraLinkNode = "0"}
, 
[95] = {id = 95, parentNodeid = 94, xAxisPan = 2096, yAxisPan = 1068, nodeType = 1, handbookId = 30, condition = 0, extraLinkNode = "0"}
, 
[96] = {id = 96, parentNodeid = 93, xAxisPan = 2210, yAxisPan = 937, nodeType = 1, handbookId = 6, condition = 0, extraLinkNode = "0"}
, 
[97] = {id = 97, parentNodeid = 93, xAxisPan = 2244, yAxisPan = 779, nodeType = 2, handbookId = 20032, condition = 0, extraLinkNode = "0"}
, 
[98] = {id = 98, parentNodeid = 93, xAxisPan = 2206, yAxisPan = 611, nodeType = 2, handbookId = 20033, condition = 0, extraLinkNode = "0"}
, 
[99] = {id = 99, parentNodeid = 98, xAxisPan = 2206, yAxisPan = 454, nodeType = 2, handbookId = 20034, condition = 0, extraLinkNode = "0"}
, 
[100] = {id = 100, parentNodeid = 1, xAxisPan = 700, yAxisPan = 388, nodeType = 3, handbookId = 7, condition = 0, extraLinkNode = "0"}
, 
[101] = {id = 101, parentNodeid = 100, xAxisPan = 543, yAxisPan = 586, nodeType = 4, handbookId = 40024, condition = 0, extraLinkNode = "0"}
, 
[102] = {id = 102, parentNodeid = 101, xAxisPan = 356, yAxisPan = 771, nodeType = 1, handbookId = 16, condition = 0, extraLinkNode = "0"}
, 
[103] = {id = 103, parentNodeid = 101, xAxisPan = 334, yAxisPan = 583, nodeType = 1, handbookId = 31, condition = 0, extraLinkNode = "0"}
, 
[104] = {id = 104, parentNodeid = 101, xAxisPan = 448, yAxisPan = 452, nodeType = 1, handbookId = 8, condition = 0, extraLinkNode = "0"}
, 
[105] = {id = 105, parentNodeid = 100, xAxisPan = 700, yAxisPan = 599, nodeType = 4, handbookId = 40023, condition = 0, extraLinkNode = "0"}
, 
[106] = {id = 106, parentNodeid = 105, xAxisPan = 700, yAxisPan = 771, nodeType = 2, handbookId = 20035, condition = 0, extraLinkNode = "0"}
, 
[107] = {id = 107, parentNodeid = 106, xAxisPan = 554, yAxisPan = 771, nodeType = 2, handbookId = 20036, condition = 0, extraLinkNode = "0"}
, 
[108] = {id = 108, parentNodeid = 106, xAxisPan = 575, yAxisPan = 954, nodeType = 2, handbookId = 20037, condition = 0, extraLinkNode = "0"}
, 
[109] = {id = 109, parentNodeid = 106, xAxisPan = 1032, yAxisPan = 771, nodeType = 2, handbookId = 20038, condition = 0, extraLinkNode = "0"}
, 
[110] = {id = 110, parentNodeid = 100, xAxisPan = 862, yAxisPan = 540, nodeType = 4, handbookId = 40022, condition = 0, extraLinkNode = "0"}
, 
[111] = {id = 111, parentNodeid = 110, xAxisPan = 1030, yAxisPan = 640, nodeType = 1, handbookId = 5, condition = 0, extraLinkNode = "0"}
, 
[112] = {id = 112, parentNodeid = 110, xAxisPan = 1030, yAxisPan = 440, nodeType = 1, handbookId = 49, condition = 0, extraLinkNode = "0"}
}
cnodeconfig_handbook.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112}
return cnodeconfig_handbook

