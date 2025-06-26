-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/role/croleevolutioncfg.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local croleevolutioncfg = {}
croleevolutioncfg.Data = {
[1] = {id = 1, evolutionType = 1, evolutionLevel = 1, exclusiveItem = "30068_1", currentItem = "", addProperty = 61, addPropertyValue = 97}
, 
[2] = {id = 2, evolutionType = 1, evolutionLevel = 2, exclusiveItem = "30070_1", currentItem = "", addProperty = 31, addPropertyValue = 437}
, 
[3] = {id = 3, evolutionType = 1, evolutionLevel = 3, exclusiveItem = "31020_1", currentItem = "", addProperty = 21, addPropertyValue = 1458}
, 
[4] = {id = 4, evolutionType = 2, evolutionLevel = 1, exclusiveItem = "78100_1", currentItem = "78015_4", addProperty = 51, addPropertyValue = 77}
, 
[5] = {id = 5, evolutionType = 2, evolutionLevel = 2, exclusiveItem = "78100_2", currentItem = "78015_8", addProperty = 21, addPropertyValue = 1458}
, 
[6] = {id = 6, evolutionType = 2, evolutionLevel = 3, exclusiveItem = "78100_3", currentItem = "78015_12", addProperty = 31, addPropertyValue = 291}
, 
[7] = {id = 7, evolutionType = 3, evolutionLevel = 1, exclusiveItem = "78101_1", currentItem = "78012_4", addProperty = 51, addPropertyValue = 97}
, 
[8] = {id = 8, evolutionType = 3, evolutionLevel = 2, exclusiveItem = "78101_2", currentItem = "78012_8", addProperty = 31, addPropertyValue = 413}
, 
[9] = {id = 9, evolutionType = 3, evolutionLevel = 3, exclusiveItem = "78101_3", currentItem = "78012_12", addProperty = 21, addPropertyValue = 2041}
, 
[10] = {id = 10, evolutionType = 4, evolutionLevel = 1, exclusiveItem = "78102_1", currentItem = "78005_4", addProperty = 61, addPropertyValue = 73}
, 
[11] = {id = 11, evolutionType = 4, evolutionLevel = 2, exclusiveItem = "78102_2", currentItem = "78005_8", addProperty = 31, addPropertyValue = 275}
, 
[12] = {id = 12, evolutionType = 4, evolutionLevel = 3, exclusiveItem = "78102_3", currentItem = "78005_12", addProperty = 21, addPropertyValue = 1377}
, 
[13] = {id = 13, evolutionType = 5, evolutionLevel = 1, exclusiveItem = "78103_1", currentItem = "78024_4", addProperty = 21, addPropertyValue = 1539}
, 
[14] = {id = 14, evolutionType = 5, evolutionLevel = 2, exclusiveItem = "78103_2", currentItem = "78024_8", addProperty = 61, addPropertyValue = 82}
, 
[15] = {id = 15, evolutionType = 5, evolutionLevel = 3, exclusiveItem = "78103_3", currentItem = "78024_12", addProperty = 31, addPropertyValue = 307}
, 
[16] = {id = 16, evolutionType = 6, evolutionLevel = 1, exclusiveItem = "78104_1", currentItem = "78034_4", addProperty = 61, addPropertyValue = 86}
, 
[17] = {id = 17, evolutionType = 6, evolutionLevel = 2, exclusiveItem = "78104_2", currentItem = "78034_8", addProperty = 21, addPropertyValue = 1620}
, 
[18] = {id = 18, evolutionType = 6, evolutionLevel = 3, exclusiveItem = "78104_3", currentItem = "78034_12", addProperty = 31, addPropertyValue = 324}
, 
[19] = {id = 19, evolutionType = 7, evolutionLevel = 1, exclusiveItem = "78105_1", currentItem = "78002_4", addProperty = 21, addPropertyValue = 1927}
, 
[20] = {id = 20, evolutionType = 7, evolutionLevel = 2, exclusiveItem = "78105_2", currentItem = "78002_8", addProperty = 61, addPropertyValue = 91}
, 
[21] = {id = 21, evolutionType = 7, evolutionLevel = 3, exclusiveItem = "78105_3", currentItem = "78002_12", addProperty = 31, addPropertyValue = 390}
, 
[22] = {id = 22, evolutionType = 8, evolutionLevel = 1, exclusiveItem = "78106_1", currentItem = "78031_4", addProperty = 21, addPropertyValue = 3240}
, 
[23] = {id = 23, evolutionType = 8, evolutionLevel = 2, exclusiveItem = "78106_2", currentItem = "78031_8", addProperty = 61, addPropertyValue = 216}
, 
[24] = {id = 24, evolutionType = 8, evolutionLevel = 3, exclusiveItem = "78106_3", currentItem = "78031_12", addProperty = 51, addPropertyValue = 216}
, 
[25] = {id = 25, evolutionType = 9, evolutionLevel = 1, exclusiveItem = "78107_1", currentItem = "78005_4", addProperty = 61, addPropertyValue = 73}
, 
[26] = {id = 26, evolutionType = 9, evolutionLevel = 2, exclusiveItem = "78107_2", currentItem = "78005_8", addProperty = 21, addPropertyValue = 1377}
, 
[27] = {id = 27, evolutionType = 9, evolutionLevel = 3, exclusiveItem = "78107_3", currentItem = "78005_12", addProperty = 31, addPropertyValue = 275}
, 
[28] = {id = 28, evolutionType = 10, evolutionLevel = 1, exclusiveItem = "78108_1", currentItem = "78035_4", addProperty = 61, addPropertyValue = 86}
, 
[29] = {id = 29, evolutionType = 10, evolutionLevel = 2, exclusiveItem = "78108_2", currentItem = "78035_8", addProperty = 21, addPropertyValue = 1620}
, 
[30] = {id = 30, evolutionType = 10, evolutionLevel = 3, exclusiveItem = "78108_3", currentItem = "78035_12", addProperty = 31, addPropertyValue = 324}
, 
[31] = {id = 31, evolutionType = 11, evolutionLevel = 1, exclusiveItem = "78109_1", currentItem = "78031_4", addProperty = 21, addPropertyValue = 3240}
, 
[32] = {id = 32, evolutionType = 11, evolutionLevel = 2, exclusiveItem = "78109_2", currentItem = "78031_8", addProperty = 51, addPropertyValue = 216}
, 
[33] = {id = 33, evolutionType = 11, evolutionLevel = 3, exclusiveItem = "78109_3", currentItem = "78031_12", addProperty = 61, addPropertyValue = 216}
, 
[34] = {id = 34, evolutionType = 12, evolutionLevel = 1, exclusiveItem = "78110_1", currentItem = "78036_4", addProperty = 61, addPropertyValue = 86}
, 
[35] = {id = 35, evolutionType = 12, evolutionLevel = 2, exclusiveItem = "78110_2", currentItem = "78036_8", addProperty = 31, addPropertyValue = 486}
, 
[36] = {id = 36, evolutionType = 12, evolutionLevel = 3, exclusiveItem = "78110_3", currentItem = "78036_12", addProperty = 21, addPropertyValue = 1620}
, 
[37] = {id = 37, evolutionType = 13, evolutionLevel = 1, exclusiveItem = "78111_1", currentItem = "78033_4", addProperty = 51, addPropertyValue = 64}
, 
[38] = {id = 38, evolutionType = 13, evolutionLevel = 2, exclusiveItem = "78111_2", currentItem = "78033_8", addProperty = 21, addPropertyValue = 1296}
, 
[39] = {id = 39, evolutionType = 13, evolutionLevel = 3, exclusiveItem = "78111_3", currentItem = "78033_12", addProperty = 31, addPropertyValue = 540}
, 
[40] = {id = 40, evolutionType = 14, evolutionLevel = 1, exclusiveItem = "78112_1", currentItem = "78013_4", addProperty = 51, addPropertyValue = 58}
, 
[41] = {id = 41, evolutionType = 14, evolutionLevel = 2, exclusiveItem = "78112_2", currentItem = "78013_8", addProperty = 21, addPropertyValue = 1166}
, 
[42] = {id = 42, evolutionType = 14, evolutionLevel = 3, exclusiveItem = "78112_3", currentItem = "78013_12", addProperty = 31, addPropertyValue = 486}
, 
[43] = {id = 43, evolutionType = 15, evolutionLevel = 1, exclusiveItem = "78113_1", currentItem = "78016_4", addProperty = 31, addPropertyValue = 437}
, 
[44] = {id = 44, evolutionType = 15, evolutionLevel = 2, exclusiveItem = "78113_2", currentItem = "78016_8", addProperty = 61, addPropertyValue = 77}
, 
[45] = {id = 45, evolutionType = 15, evolutionLevel = 3, exclusiveItem = "78113_3", currentItem = "78016_12", addProperty = 21, addPropertyValue = 1458}
, 
[46] = {id = 46, evolutionType = 16, evolutionLevel = 1, exclusiveItem = "78114_1", currentItem = "78012_4", addProperty = 31, addPropertyValue = 413}
, 
[47] = {id = 47, evolutionType = 16, evolutionLevel = 2, exclusiveItem = "78114_2", currentItem = "78012_8", addProperty = 51, addPropertyValue = 97}
, 
[48] = {id = 48, evolutionType = 16, evolutionLevel = 3, exclusiveItem = "78114_3", currentItem = "78012_12", addProperty = 21, addPropertyValue = 2041}
, 
[49] = {id = 49, evolutionType = 17, evolutionLevel = 1, exclusiveItem = "78115_1", currentItem = "78032_4", addProperty = 51, addPropertyValue = 108}
, 
[50] = {id = 50, evolutionType = 17, evolutionLevel = 2, exclusiveItem = "78115_2", currentItem = "78032_8", addProperty = 21, addPropertyValue = 2268}
, 
[51] = {id = 51, evolutionType = 17, evolutionLevel = 3, exclusiveItem = "78115_3", currentItem = "78032_12", addProperty = 31, addPropertyValue = 459}
, 
[52] = {id = 52, evolutionType = 18, evolutionLevel = 1, exclusiveItem = "78116_1", currentItem = "78024_4", addProperty = 21, addPropertyValue = 1539}
, 
[53] = {id = 53, evolutionType = 18, evolutionLevel = 2, exclusiveItem = "78116_2", currentItem = "78024_8", addProperty = 61, addPropertyValue = 82}
, 
[54] = {id = 54, evolutionType = 18, evolutionLevel = 3, exclusiveItem = "78116_3", currentItem = "78024_12", addProperty = 31, addPropertyValue = 307}
, 
[55] = {id = 55, evolutionType = 19, evolutionLevel = 1, exclusiveItem = "78117_1", currentItem = "78014_4", addProperty = 31, addPropertyValue = 291}
, 
[56] = {id = 56, evolutionType = 19, evolutionLevel = 2, exclusiveItem = "78117_2", currentItem = "78014_8", addProperty = 61, addPropertyValue = 77}
, 
[57] = {id = 57, evolutionType = 19, evolutionLevel = 3, exclusiveItem = "78117_3", currentItem = "78014_12", addProperty = 21, addPropertyValue = 1458}
, 
[58] = {id = 58, evolutionType = 20, evolutionLevel = 1, exclusiveItem = "78118_1", currentItem = "78002_4", addProperty = 51, addPropertyValue = 91}
, 
[59] = {id = 59, evolutionType = 20, evolutionLevel = 2, exclusiveItem = "78118_2", currentItem = "78002_8", addProperty = 31, addPropertyValue = 390}
, 
[60] = {id = 60, evolutionType = 20, evolutionLevel = 3, exclusiveItem = "78118_3", currentItem = "78002_12", addProperty = 21, addPropertyValue = 1927}
, 
[61] = {id = 61, evolutionType = 21, evolutionLevel = 1, exclusiveItem = "78119_1", currentItem = "78002_4", addProperty = 51, addPropertyValue = 91}
, 
[62] = {id = 62, evolutionType = 21, evolutionLevel = 2, exclusiveItem = "78119_2", currentItem = "78002_8", addProperty = 31, addPropertyValue = 390}
, 
[63] = {id = 63, evolutionType = 21, evolutionLevel = 3, exclusiveItem = "78119_3", currentItem = "78002_12", addProperty = 21, addPropertyValue = 1927}
, 
[64] = {id = 64, evolutionType = 22, evolutionLevel = 1, exclusiveItem = "78120_1", currentItem = "78034_4", addProperty = 51, addPropertyValue = 86}
, 
[65] = {id = 65, evolutionType = 22, evolutionLevel = 2, exclusiveItem = "78120_2", currentItem = "78034_8", addProperty = 21, addPropertyValue = 1620}
, 
[66] = {id = 66, evolutionType = 22, evolutionLevel = 3, exclusiveItem = "78120_3", currentItem = "78034_12", addProperty = 31, addPropertyValue = 324}
, 
[67] = {id = 67, evolutionType = 23, evolutionLevel = 1, exclusiveItem = "78121_1", currentItem = "78031_4", addProperty = 51, addPropertyValue = 216}
, 
[68] = {id = 68, evolutionType = 23, evolutionLevel = 2, exclusiveItem = "78121_2", currentItem = "78031_8", addProperty = 31, addPropertyValue = 216}
, 
[69] = {id = 69, evolutionType = 23, evolutionLevel = 3, exclusiveItem = "78121_3", currentItem = "78031_12", addProperty = 21, addPropertyValue = 3240}
, 
[70] = {id = 70, evolutionType = 24, evolutionLevel = 1, exclusiveItem = "78122_1", currentItem = "78014_4", addProperty = 51, addPropertyValue = 77}
, 
[71] = {id = 71, evolutionType = 24, evolutionLevel = 2, exclusiveItem = "78122_2", currentItem = "78014_8", addProperty = 31, addPropertyValue = 291}
, 
[72] = {id = 72, evolutionType = 24, evolutionLevel = 3, exclusiveItem = "78122_3", currentItem = "78014_12", addProperty = 21, addPropertyValue = 1458}
, 
[73] = {id = 73, evolutionType = 25, evolutionLevel = 1, exclusiveItem = "78123_1", currentItem = "78026_4", addProperty = 21, addPropertyValue = 1539}
, 
[74] = {id = 74, evolutionType = 25, evolutionLevel = 2, exclusiveItem = "78123_2", currentItem = "78026_8", addProperty = 51, addPropertyValue = 82}
, 
[75] = {id = 75, evolutionType = 25, evolutionLevel = 3, exclusiveItem = "78123_3", currentItem = "78026_12", addProperty = 31, addPropertyValue = 461}
, 
[76] = {id = 76, evolutionType = 26, evolutionLevel = 1, exclusiveItem = "78124_1", currentItem = "78013_4", addProperty = 31, addPropertyValue = 486}
, 
[77] = {id = 77, evolutionType = 26, evolutionLevel = 2, exclusiveItem = "78124_2", currentItem = "78013_8", addProperty = 51, addPropertyValue = 58}
, 
[78] = {id = 78, evolutionType = 26, evolutionLevel = 3, exclusiveItem = "78124_3", currentItem = "78013_12", addProperty = 21, addPropertyValue = 1166}
, 
[79] = {id = 79, evolutionType = 27, evolutionLevel = 1, exclusiveItem = "78125_1", currentItem = "78011_4", addProperty = 51, addPropertyValue = 194}
, 
[80] = {id = 80, evolutionType = 27, evolutionLevel = 2, exclusiveItem = "78125_2", currentItem = "78011_8", addProperty = 31, addPropertyValue = 194}
, 
[81] = {id = 81, evolutionType = 27, evolutionLevel = 3, exclusiveItem = "78125_3", currentItem = "78011_12", addProperty = 21, addPropertyValue = 2916}
, 
[82] = {id = 82, evolutionType = 28, evolutionLevel = 1, exclusiveItem = "78126_1", currentItem = "78026_4", addProperty = 61, addPropertyValue = 82}
, 
[83] = {id = 83, evolutionType = 28, evolutionLevel = 2, exclusiveItem = "78126_2", currentItem = "78026_8", addProperty = 21, addPropertyValue = 1539}
, 
[84] = {id = 84, evolutionType = 28, evolutionLevel = 3, exclusiveItem = "78126_3", currentItem = "78026_12", addProperty = 31, addPropertyValue = 461}
, 
[85] = {id = 85, evolutionType = 29, evolutionLevel = 1, exclusiveItem = "78127_1", currentItem = "78033_4", addProperty = 51, addPropertyValue = 64}
, 
[86] = {id = 86, evolutionType = 29, evolutionLevel = 2, exclusiveItem = "78127_2", currentItem = "78033_8", addProperty = 21, addPropertyValue = 1296}
, 
[87] = {id = 87, evolutionType = 29, evolutionLevel = 3, exclusiveItem = "78127_3", currentItem = "78033_12", addProperty = 31, addPropertyValue = 540}
, 
[88] = {id = 88, evolutionType = 30, evolutionLevel = 1, exclusiveItem = "78128_1", currentItem = "78024_4", addProperty = 51, addPropertyValue = 82}
, 
[89] = {id = 89, evolutionType = 30, evolutionLevel = 2, exclusiveItem = "78128_2", currentItem = "78024_8", addProperty = 61, addPropertyValue = 82}
, 
[90] = {id = 90, evolutionType = 30, evolutionLevel = 3, exclusiveItem = "78128_3", currentItem = "78024_12", addProperty = 21, addPropertyValue = 1539}
, 
[94] = {id = 94, evolutionType = 32, evolutionLevel = 1, exclusiveItem = "78130_1", currentItem = "78013_4", addProperty = 51, addPropertyValue = 58}
, 
[95] = {id = 95, evolutionType = 32, evolutionLevel = 2, exclusiveItem = "78130_2", currentItem = "78013_8", addProperty = 21, addPropertyValue = 1166}
, 
[96] = {id = 96, evolutionType = 32, evolutionLevel = 3, exclusiveItem = "78130_3", currentItem = "78013_12", addProperty = 31, addPropertyValue = 486}
, 
[97] = {id = 97, evolutionType = 33, evolutionLevel = 1, exclusiveItem = "78131_1", currentItem = "78025_4", addProperty = 51, addPropertyValue = 82}
, 
[98] = {id = 98, evolutionType = 33, evolutionLevel = 2, exclusiveItem = "78131_2", currentItem = "78025_8", addProperty = 21, addPropertyValue = 1539}
, 
[99] = {id = 99, evolutionType = 33, evolutionLevel = 3, exclusiveItem = "78131_3", currentItem = "78025_12", addProperty = 31, addPropertyValue = 307}
, 
[100] = {id = 100, evolutionType = 34, evolutionLevel = 1, exclusiveItem = "78132_1", currentItem = "78023_4", addProperty = 21, addPropertyValue = 1231}
, 
[101] = {id = 101, evolutionType = 34, evolutionLevel = 2, exclusiveItem = "78132_2", currentItem = "78023_8", addProperty = 51, addPropertyValue = 61}
, 
[102] = {id = 102, evolutionType = 34, evolutionLevel = 3, exclusiveItem = "78132_3", currentItem = "78023_12", addProperty = 31, addPropertyValue = 513}
, 
[103] = {id = 103, evolutionType = 35, evolutionLevel = 1, exclusiveItem = "78133_1", currentItem = "78036_4", addProperty = 61, addPropertyValue = 86}
, 
[104] = {id = 104, evolutionType = 35, evolutionLevel = 2, exclusiveItem = "78133_2", currentItem = "78036_8", addProperty = 21, addPropertyValue = 1620}
, 
[105] = {id = 105, evolutionType = 35, evolutionLevel = 3, exclusiveItem = "78133_3", currentItem = "78036_12", addProperty = 31, addPropertyValue = 486}
, 
[106] = {id = 106, evolutionType = 36, evolutionLevel = 1, exclusiveItem = "78134_1", currentItem = "78006_4", addProperty = 61, addPropertyValue = 73}
, 
[107] = {id = 107, evolutionType = 36, evolutionLevel = 2, exclusiveItem = "78134_2", currentItem = "78006_8", addProperty = 31, addPropertyValue = 413}
, 
[108] = {id = 108, evolutionType = 36, evolutionLevel = 3, exclusiveItem = "78134_3", currentItem = "78006_12", addProperty = 21, addPropertyValue = 1377}
, 
[112] = {id = 112, evolutionType = 38, evolutionLevel = 1, exclusiveItem = "78136_1", currentItem = "78034_4", addProperty = 61, addPropertyValue = 86}
, 
[113] = {id = 113, evolutionType = 38, evolutionLevel = 2, exclusiveItem = "78136_2", currentItem = "78034_8", addProperty = 21, addPropertyValue = 1620}
, 
[114] = {id = 114, evolutionType = 38, evolutionLevel = 3, exclusiveItem = "78136_3", currentItem = "78034_12", addProperty = 31, addPropertyValue = 324}
, 
[115] = {id = 115, evolutionType = 39, evolutionLevel = 1, exclusiveItem = "78137_1", currentItem = "78032_4", addProperty = 51, addPropertyValue = 108}
, 
[116] = {id = 116, evolutionType = 39, evolutionLevel = 2, exclusiveItem = "78137_2", currentItem = "78032_8", addProperty = 21, addPropertyValue = 2268}
, 
[117] = {id = 117, evolutionType = 39, evolutionLevel = 3, exclusiveItem = "78137_3", currentItem = "78032_12", addProperty = 31, addPropertyValue = 459}
, 
[118] = {id = 118, evolutionType = 40, evolutionLevel = 1, exclusiveItem = "78138_1", currentItem = "78016_4", addProperty = 61, addPropertyValue = 77}
, 
[119] = {id = 119, evolutionType = 40, evolutionLevel = 2, exclusiveItem = "78138_2", currentItem = "78016_8", addProperty = 31, addPropertyValue = 437}
, 
[120] = {id = 120, evolutionType = 40, evolutionLevel = 3, exclusiveItem = "78138_3", currentItem = "78016_12", addProperty = 21, addPropertyValue = 1458}
, 
[121] = {id = 121, evolutionType = 41, evolutionLevel = 1, exclusiveItem = "78139_1", currentItem = "78026_4", addProperty = 61, addPropertyValue = 82}
, 
[122] = {id = 122, evolutionType = 41, evolutionLevel = 2, exclusiveItem = "78139_2", currentItem = "78026_8", addProperty = 21, addPropertyValue = 1539}
, 
[123] = {id = 123, evolutionType = 41, evolutionLevel = 3, exclusiveItem = "78139_3", currentItem = "78026_12", addProperty = 31, addPropertyValue = 461}
, 
[124] = {id = 124, evolutionType = 42, evolutionLevel = 1, exclusiveItem = "78140_1", currentItem = "78026_4", addProperty = 21, addPropertyValue = 1539}
, 
[125] = {id = 125, evolutionType = 42, evolutionLevel = 2, exclusiveItem = "78140_2", currentItem = "78026_8", addProperty = 61, addPropertyValue = 82}
, 
[126] = {id = 126, evolutionType = 42, evolutionLevel = 3, exclusiveItem = "78140_3", currentItem = "78026_12", addProperty = 31, addPropertyValue = 461}
, 
[127] = {id = 127, evolutionType = 43, evolutionLevel = 1, exclusiveItem = "78141_1", currentItem = "78025_4", addProperty = 21, addPropertyValue = 1539}
, 
[128] = {id = 128, evolutionType = 43, evolutionLevel = 2, exclusiveItem = "78141_2", currentItem = "78025_8", addProperty = 61, addPropertyValue = 82}
, 
[129] = {id = 129, evolutionType = 43, evolutionLevel = 3, exclusiveItem = "78141_3", currentItem = "78025_12", addProperty = 31, addPropertyValue = 307}
, 
[130] = {id = 130, evolutionType = 44, evolutionLevel = 1, exclusiveItem = "78142_1", currentItem = "78006_4", addProperty = 61, addPropertyValue = 73}
, 
[131] = {id = 131, evolutionType = 44, evolutionLevel = 2, exclusiveItem = "78142_2", currentItem = "78006_8", addProperty = 31, addPropertyValue = 413}
, 
[132] = {id = 132, evolutionType = 44, evolutionLevel = 3, exclusiveItem = "78142_3", currentItem = "78006_12", addProperty = 21, addPropertyValue = 1377}
, 
[133] = {id = 133, evolutionType = 45, evolutionLevel = 1, exclusiveItem = "78144_1", currentItem = "78016_4", addProperty = 61, addPropertyValue = 77}
, 
[134] = {id = 134, evolutionType = 45, evolutionLevel = 2, exclusiveItem = "78144_2", currentItem = "78016_8", addProperty = 31, addPropertyValue = 437}
, 
[135] = {id = 135, evolutionType = 45, evolutionLevel = 3, exclusiveItem = "78144_3", currentItem = "78016_12", addProperty = 21, addPropertyValue = 1458}
, 
[136] = {id = 136, evolutionType = 46, evolutionLevel = 1, exclusiveItem = "78144_1", currentItem = "78002_4", addProperty = 51, addPropertyValue = 97}
, 
[137] = {id = 137, evolutionType = 46, evolutionLevel = 2, exclusiveItem = "78144_2", currentItem = "78002_8", addProperty = 31, addPropertyValue = 413}
, 
[138] = {id = 138, evolutionType = 46, evolutionLevel = 3, exclusiveItem = "78144_3", currentItem = "78002_12", addProperty = 21, addPropertyValue = 2041}
, 
[139] = {id = 139, evolutionType = 47, evolutionLevel = 1, exclusiveItem = "78145_1", currentItem = "78023_4", addProperty = 51, addPropertyValue = 61}
, 
[140] = {id = 140, evolutionType = 47, evolutionLevel = 2, exclusiveItem = "78145_2", currentItem = "78023_8", addProperty = 31, addPropertyValue = 513}
, 
[141] = {id = 141, evolutionType = 47, evolutionLevel = 3, exclusiveItem = "78145_3", currentItem = "78023_12", addProperty = 21, addPropertyValue = 1231}
, 
[142] = {id = 142, evolutionType = 48, evolutionLevel = 1, exclusiveItem = "78146_1", currentItem = "78022_4", addProperty = 51, addPropertyValue = 102}
, 
[143] = {id = 143, evolutionType = 48, evolutionLevel = 2, exclusiveItem = "78146_2", currentItem = "78022_8", addProperty = 31, addPropertyValue = 436}
, 
[144] = {id = 144, evolutionType = 48, evolutionLevel = 3, exclusiveItem = "78146_3", currentItem = "78022_12", addProperty = 21, addPropertyValue = 2154}
, 
[145] = {id = 145, evolutionType = 49, evolutionLevel = 1, exclusiveItem = "78147_1", currentItem = "78011_4", addProperty = 21, addPropertyValue = 2916}
, 
[146] = {id = 146, evolutionType = 49, evolutionLevel = 2, exclusiveItem = "78147_2", currentItem = "78011_8", addProperty = 51, addPropertyValue = 194}
, 
[147] = {id = 147, evolutionType = 49, evolutionLevel = 3, exclusiveItem = "78147_3", currentItem = "78011_12", addProperty = 61, addPropertyValue = 194}
, 
[148] = {id = 148, evolutionType = 50, evolutionLevel = 1, exclusiveItem = "78148_1", currentItem = "78032_4", addProperty = 51, addPropertyValue = 108}
, 
[149] = {id = 149, evolutionType = 50, evolutionLevel = 2, exclusiveItem = "78148_2", currentItem = "78032_8", addProperty = 31, addPropertyValue = 459}
, 
[150] = {id = 150, evolutionType = 50, evolutionLevel = 3, exclusiveItem = "78148_3", currentItem = "78032_12", addProperty = 21, addPropertyValue = 2268}
, 
[151] = {id = 151, evolutionType = 51, evolutionLevel = 1, exclusiveItem = "78149_1", currentItem = "78035_4", addProperty = 51, addPropertyValue = 86}
, 
[152] = {id = 152, evolutionType = 51, evolutionLevel = 2, exclusiveItem = "78149_2", currentItem = "78035_8", addProperty = 21, addPropertyValue = 1620}
, 
[153] = {id = 153, evolutionType = 51, evolutionLevel = 3, exclusiveItem = "78149_3", currentItem = "78035_12", addProperty = 31, addPropertyValue = 324}
, 
[154] = {id = 154, evolutionType = 52, evolutionLevel = 1, exclusiveItem = "78150_1", currentItem = "78015_4", addProperty = 51, addPropertyValue = 77}
, 
[155] = {id = 155, evolutionType = 52, evolutionLevel = 2, exclusiveItem = "78150_2", currentItem = "78015_8", addProperty = 31, addPropertyValue = 291}
, 
[156] = {id = 156, evolutionType = 52, evolutionLevel = 3, exclusiveItem = "78150_3", currentItem = "78015_12", addProperty = 21, addPropertyValue = 1458}
, 
[157] = {id = 157, evolutionType = 53, evolutionLevel = 1, exclusiveItem = "78151_1", currentItem = "78035_4", addProperty = 51, addPropertyValue = 86}
, 
[158] = {id = 158, evolutionType = 53, evolutionLevel = 2, exclusiveItem = "78151_2", currentItem = "78035_8", addProperty = 31, addPropertyValue = 324}
, 
[159] = {id = 159, evolutionType = 53, evolutionLevel = 3, exclusiveItem = "78151_3", currentItem = "78035_12", addProperty = 21, addPropertyValue = 1620}
, 
[160] = {id = 160, evolutionType = 54, evolutionLevel = 1, exclusiveItem = "78152_1", currentItem = "78025_4", addProperty = 21, addPropertyValue = 1539}
, 
[161] = {id = 161, evolutionType = 54, evolutionLevel = 2, exclusiveItem = "78152_2", currentItem = "78025_8", addProperty = 51, addPropertyValue = 82}
, 
[162] = {id = 162, evolutionType = 54, evolutionLevel = 3, exclusiveItem = "78152_3", currentItem = "78025_12", addProperty = 31, addPropertyValue = 307}
, 
[163] = {id = 163, evolutionType = 55, evolutionLevel = 1, exclusiveItem = "78153_1", currentItem = "78023_4", addProperty = 51, addPropertyValue = 61}
, 
[164] = {id = 164, evolutionType = 55, evolutionLevel = 2, exclusiveItem = "78153_2", currentItem = "78023_8", addProperty = 21, addPropertyValue = 1231}
, 
[165] = {id = 165, evolutionType = 55, evolutionLevel = 3, exclusiveItem = "78153_3", currentItem = "78023_12", addProperty = 31, addPropertyValue = 513}
, 
[166] = {id = 166, evolutionType = 56, evolutionLevel = 1, exclusiveItem = "78154_1", currentItem = "78034_4", addProperty = 61, addPropertyValue = 86}
, 
[167] = {id = 167, evolutionType = 56, evolutionLevel = 2, exclusiveItem = "78154_2", currentItem = "78034_8", addProperty = 21, addPropertyValue = 1620}
, 
[168] = {id = 168, evolutionType = 56, evolutionLevel = 3, exclusiveItem = "78154_3", currentItem = "78034_12", addProperty = 31, addPropertyValue = 324}
, 
[169] = {id = 169, evolutionType = 57, evolutionLevel = 1, exclusiveItem = "78148_1", currentItem = "78001_4", addProperty = 21, addPropertyValue = 2754}
, 
[170] = {id = 170, evolutionType = 57, evolutionLevel = 2, exclusiveItem = "78148_2", currentItem = "78001_8", addProperty = 51, addPropertyValue = 183}
, 
[171] = {id = 171, evolutionType = 57, evolutionLevel = 3, exclusiveItem = "78148_3", currentItem = "78001_12", addProperty = 61, addPropertyValue = 183}
, 
[172] = {id = 172, evolutionType = 58, evolutionLevel = 1, exclusiveItem = "78156_1", currentItem = "78013_4", addProperty = 31, addPropertyValue = 486}
, 
[173] = {id = 173, evolutionType = 58, evolutionLevel = 2, exclusiveItem = "78156_2", currentItem = "78013_8", addProperty = 51, addPropertyValue = 58}
, 
[174] = {id = 174, evolutionType = 58, evolutionLevel = 3, exclusiveItem = "78156_3", currentItem = "78013_12", addProperty = 21, addPropertyValue = 1166}
, 
[175] = {id = 175, evolutionType = 59, evolutionLevel = 1, exclusiveItem = "78157_1", currentItem = "78021_4", addProperty = 61, addPropertyValue = 205}
, 
[176] = {id = 176, evolutionType = 59, evolutionLevel = 2, exclusiveItem = "78157_2", currentItem = "78021_8", addProperty = 51, addPropertyValue = 205}
, 
[177] = {id = 177, evolutionType = 59, evolutionLevel = 3, exclusiveItem = "78157_3", currentItem = "78021_12", addProperty = 21, addPropertyValue = 3078}
, 
[178] = {id = 178, evolutionType = 60, evolutionLevel = 1, exclusiveItem = "78158_1", currentItem = "78034_4", addProperty = 61, addPropertyValue = 86}
, 
[179] = {id = 179, evolutionType = 60, evolutionLevel = 2, exclusiveItem = "78158_2", currentItem = "78034_8", addProperty = 31, addPropertyValue = 324}
, 
[180] = {id = 180, evolutionType = 60, evolutionLevel = 3, exclusiveItem = "78158_3", currentItem = "78034_12", addProperty = 21, addPropertyValue = 1620}
, 
[181] = {id = 181, evolutionType = 61, evolutionLevel = 1, exclusiveItem = "78159_1", currentItem = "78022_4", addProperty = 51, addPropertyValue = 102}
, 
[182] = {id = 182, evolutionType = 61, evolutionLevel = 2, exclusiveItem = "78159_2", currentItem = "78022_8", addProperty = 21, addPropertyValue = 2154}
, 
[183] = {id = 183, evolutionType = 61, evolutionLevel = 3, exclusiveItem = "78159_3", currentItem = "78022_12", addProperty = 31, addPropertyValue = 436}
, 
[184] = {id = 184, evolutionType = 62, evolutionLevel = 1, exclusiveItem = "78160_1", currentItem = "78036_4", addProperty = 61, addPropertyValue = 86}
, 
[185] = {id = 185, evolutionType = 62, evolutionLevel = 2, exclusiveItem = "78160_2", currentItem = "78036_8", addProperty = 21, addPropertyValue = 1620}
, 
[186] = {id = 186, evolutionType = 62, evolutionLevel = 3, exclusiveItem = "78160_3", currentItem = "78036_12", addProperty = 31, addPropertyValue = 486}
, 
[187] = {id = 187, evolutionType = 63, evolutionLevel = 1, exclusiveItem = "78161_1", currentItem = "78031_4", addProperty = 51, addPropertyValue = 216}
, 
[188] = {id = 188, evolutionType = 63, evolutionLevel = 2, exclusiveItem = "78161_2", currentItem = "78031_8", addProperty = 61, addPropertyValue = 216}
, 
[189] = {id = 189, evolutionType = 63, evolutionLevel = 3, exclusiveItem = "78161_3", currentItem = "78031_12", addProperty = 21, addPropertyValue = 3240}
, 
[190] = {id = 190, evolutionType = 64, evolutionLevel = 1, exclusiveItem = "78162_1", currentItem = "78033_4", addProperty = 51, addPropertyValue = 64}
, 
[191] = {id = 191, evolutionType = 64, evolutionLevel = 2, exclusiveItem = "78162_2", currentItem = "78033_8", addProperty = 21, addPropertyValue = 1296}
, 
[192] = {id = 192, evolutionType = 64, evolutionLevel = 3, exclusiveItem = "78162_3", currentItem = "78033_12", addProperty = 31, addPropertyValue = 540}
, 
[193] = {id = 193, evolutionType = 65, evolutionLevel = 1, exclusiveItem = "78163_1", currentItem = "78024_4", addProperty = 51, addPropertyValue = 82}
, 
[194] = {id = 194, evolutionType = 65, evolutionLevel = 2, exclusiveItem = "78163_2", currentItem = "78024_8", addProperty = 31, addPropertyValue = 307}
, 
[195] = {id = 195, evolutionType = 65, evolutionLevel = 3, exclusiveItem = "78163_3", currentItem = "78024_12", addProperty = 31, addPropertyValue = 307}
, 
[196] = {id = 196, evolutionType = 66, evolutionLevel = 1, exclusiveItem = "78164_1", currentItem = "78034_4", addProperty = 61, addPropertyValue = 86}
, 
[197] = {id = 197, evolutionType = 66, evolutionLevel = 2, exclusiveItem = "78164_2", currentItem = "78034_8", addProperty = 21, addPropertyValue = 1620}
, 
[198] = {id = 198, evolutionType = 66, evolutionLevel = 3, exclusiveItem = "78164_3", currentItem = "78034_12", addProperty = 31, addPropertyValue = 324}
, 
[199] = {id = 199, evolutionType = 67, evolutionLevel = 1, exclusiveItem = "78129_1", currentItem = "78032_4", addProperty = 51, addPropertyValue = 108}
, 
[200] = {id = 200, evolutionType = 67, evolutionLevel = 2, exclusiveItem = "78129_2", currentItem = "78032_8", addProperty = 21, addPropertyValue = 2268}
, 
[201] = {id = 201, evolutionType = 67, evolutionLevel = 3, exclusiveItem = "78129_3", currentItem = "78032_12", addProperty = 31, addPropertyValue = 459}
, 
[202] = {id = 202, evolutionType = 68, evolutionLevel = 1, exclusiveItem = "78166_1", currentItem = "78024_4", addProperty = 61, addPropertyValue = 73}
, 
[203] = {id = 203, evolutionType = 68, evolutionLevel = 2, exclusiveItem = "78166_2", currentItem = "78024_8", addProperty = 31, addPropertyValue = 275}
, 
[204] = {id = 204, evolutionType = 68, evolutionLevel = 3, exclusiveItem = "78166_3", currentItem = "78024_12", addProperty = 21, addPropertyValue = 1377}
, 
[205] = {id = 205, evolutionType = 69, evolutionLevel = 1, exclusiveItem = "78167_1", currentItem = "78026_4", addProperty = 61, addPropertyValue = 82}
, 
[206] = {id = 206, evolutionType = 69, evolutionLevel = 2, exclusiveItem = "78167_2", currentItem = "78026_8", addProperty = 31, addPropertyValue = 461}
, 
[207] = {id = 207, evolutionType = 69, evolutionLevel = 3, exclusiveItem = "78167_3", currentItem = "78026_12", addProperty = 21, addPropertyValue = 1539}
, 
[208] = {id = 208, evolutionType = 70, evolutionLevel = 1, exclusiveItem = "78168_1", currentItem = "78036_4", addProperty = 21, addPropertyValue = 1620}
, 
[209] = {id = 209, evolutionType = 70, evolutionLevel = 2, exclusiveItem = "78168_2", currentItem = "78036_8", addProperty = 61, addPropertyValue = 86}
, 
[210] = {id = 210, evolutionType = 70, evolutionLevel = 3, exclusiveItem = "78168_3", currentItem = "78036_12", addProperty = 31, addPropertyValue = 486}
, 
[211] = {id = 211, evolutionType = 71, evolutionLevel = 1, exclusiveItem = "78169_1", currentItem = "78033_4", addProperty = 51, addPropertyValue = 64}
, 
[212] = {id = 212, evolutionType = 71, evolutionLevel = 2, exclusiveItem = "78169_2", currentItem = "78033_8", addProperty = 21, addPropertyValue = 1296}
, 
[213] = {id = 213, evolutionType = 71, evolutionLevel = 3, exclusiveItem = "78169_3", currentItem = "78033_12", addProperty = 31, addPropertyValue = 540}
, 
[214] = {id = 214, evolutionType = 72, evolutionLevel = 1, exclusiveItem = "78170_1", currentItem = "78035_4", addProperty = 51, addPropertyValue = 86}
, 
[215] = {id = 215, evolutionType = 72, evolutionLevel = 2, exclusiveItem = "78170_2", currentItem = "78035_8", addProperty = 21, addPropertyValue = 1620}
, 
[216] = {id = 216, evolutionType = 72, evolutionLevel = 3, exclusiveItem = "78170_3", currentItem = "78035_12", addProperty = 31, addPropertyValue = 324}
, 
[217] = {id = 217, evolutionType = 73, evolutionLevel = 1, exclusiveItem = "78171_1", currentItem = "78015_4", addProperty = 61, addPropertyValue = 77}
, 
[218] = {id = 218, evolutionType = 73, evolutionLevel = 2, exclusiveItem = "78171_2", currentItem = "78015_8", addProperty = 21, addPropertyValue = 1458}
, 
[219] = {id = 219, evolutionType = 73, evolutionLevel = 3, exclusiveItem = "78171_3", currentItem = "78015_12", addProperty = 31, addPropertyValue = 291}
, 
[220] = {id = 220, evolutionType = 74, evolutionLevel = 1, exclusiveItem = "78172_1", currentItem = "78012_4", addProperty = 51, addPropertyValue = 97}
, 
[221] = {id = 221, evolutionType = 74, evolutionLevel = 2, exclusiveItem = "78172_2", currentItem = "78012_8", addProperty = 31, addPropertyValue = 413}
, 
[222] = {id = 222, evolutionType = 74, evolutionLevel = 3, exclusiveItem = "78172_3", currentItem = "78012_12", addProperty = 21, addPropertyValue = 2041}
, 
[223] = {id = 223, evolutionType = 75, evolutionLevel = 1, exclusiveItem = "78173_1", currentItem = "78002_4", addProperty = 51, addPropertyValue = 91}
, 
[224] = {id = 224, evolutionType = 75, evolutionLevel = 2, exclusiveItem = "78173_2", currentItem = "78002_8", addProperty = 31, addPropertyValue = 390}
, 
[225] = {id = 225, evolutionType = 75, evolutionLevel = 3, exclusiveItem = "78173_3", currentItem = "78002_12", addProperty = 21, addPropertyValue = 1927}
, 
[226] = {id = 226, evolutionType = 76, evolutionLevel = 1, exclusiveItem = "78174_1", currentItem = "78015_4", addProperty = 51, addPropertyValue = 77}
, 
[227] = {id = 227, evolutionType = 76, evolutionLevel = 2, exclusiveItem = "78174_2", currentItem = "78015_8", addProperty = 21, addPropertyValue = 1458}
, 
[228] = {id = 228, evolutionType = 76, evolutionLevel = 3, exclusiveItem = "78174_3", currentItem = "78015_12", addProperty = 31, addPropertyValue = 291}
, 
[229] = {id = 229, evolutionType = 77, evolutionLevel = 1, exclusiveItem = "78154_1", currentItem = "78034_4", addProperty = 61, addPropertyValue = 86}
, 
[230] = {id = 230, evolutionType = 77, evolutionLevel = 2, exclusiveItem = "78154_2", currentItem = "78034_8", addProperty = 21, addPropertyValue = 1620}
, 
[231] = {id = 231, evolutionType = 77, evolutionLevel = 3, exclusiveItem = "78154_3", currentItem = "78034_12", addProperty = 31, addPropertyValue = 324}
, 
[232] = {id = 232, evolutionType = 78, evolutionLevel = 1, exclusiveItem = "78178_1", currentItem = "78022_4", addProperty = 51, addPropertyValue = 102}
, 
[233] = {id = 233, evolutionType = 78, evolutionLevel = 2, exclusiveItem = "78178_2", currentItem = "78022_8", addProperty = 21, addPropertyValue = 2154}
, 
[234] = {id = 234, evolutionType = 78, evolutionLevel = 3, exclusiveItem = "78178_3", currentItem = "78022_12", addProperty = 21, addPropertyValue = 3240}
, 
[235] = {id = 235, evolutionType = 79, evolutionLevel = 1, exclusiveItem = "78179_1", currentItem = "78031_4", addProperty = 51, addPropertyValue = 216}
, 
[236] = {id = 236, evolutionType = 79, evolutionLevel = 2, exclusiveItem = "78179_2", currentItem = "78031_8", addProperty = 61, addPropertyValue = 216}
, 
[237] = {id = 237, evolutionType = 79, evolutionLevel = 3, exclusiveItem = "78179_3", currentItem = "78031_12", addProperty = 31, addPropertyValue = 324}
, 
[238] = {id = 238, evolutionType = 80, evolutionLevel = 1, exclusiveItem = "78160_1", currentItem = "78036_4", addProperty = 61, addPropertyValue = 86}
, 
[239] = {id = 239, evolutionType = 80, evolutionLevel = 2, exclusiveItem = "78160_2", currentItem = "78036_8", addProperty = 21, addPropertyValue = 1620}
, 
[240] = {id = 240, evolutionType = 80, evolutionLevel = 3, exclusiveItem = "78160_3", currentItem = "78036_12", addProperty = 31, addPropertyValue = 324}
, 
[241] = {id = 241, evolutionType = 81, evolutionLevel = 1, exclusiveItem = "78181_1", currentItem = "78034_4", addProperty = 61, addPropertyValue = 86}
, 
[242] = {id = 242, evolutionType = 81, evolutionLevel = 2, exclusiveItem = "78181_2", currentItem = "78034_8", addProperty = 21, addPropertyValue = 1620}
, 
[243] = {id = 243, evolutionType = 81, evolutionLevel = 3, exclusiveItem = "78181_3", currentItem = "78034_12", addProperty = 31, addPropertyValue = 324}
, 
[247] = {id = 247, evolutionType = 83, evolutionLevel = 1, exclusiveItem = "78183_1", currentItem = "78034_4", addProperty = 61, addPropertyValue = 86}
, 
[248] = {id = 248, evolutionType = 83, evolutionLevel = 2, exclusiveItem = "78183_2", currentItem = "78034_8", addProperty = 21, addPropertyValue = 1620}
, 
[249] = {id = 249, evolutionType = 83, evolutionLevel = 3, exclusiveItem = "78183_3", currentItem = "78034_12", addProperty = 31, addPropertyValue = 324}
, 
[250] = {id = 250, evolutionType = 84, evolutionLevel = 1, exclusiveItem = "78184_1", currentItem = "78033_4", addProperty = 61, addPropertyValue = 86}
, 
[251] = {id = 251, evolutionType = 84, evolutionLevel = 2, exclusiveItem = "78184_2", currentItem = "78033_8", addProperty = 21, addPropertyValue = 1620}
, 
[252] = {id = 252, evolutionType = 84, evolutionLevel = 3, exclusiveItem = "78184_3", currentItem = "78033_12", addProperty = 31, addPropertyValue = 324}
, 
[253] = {id = 253, evolutionType = 85, evolutionLevel = 1, exclusiveItem = "78185_1", currentItem = "78034_4", addProperty = 61, addPropertyValue = 86}
, 
[254] = {id = 254, evolutionType = 85, evolutionLevel = 2, exclusiveItem = "78185_2", currentItem = "78034_8", addProperty = 21, addPropertyValue = 1620}
, 
[255] = {id = 255, evolutionType = 85, evolutionLevel = 3, exclusiveItem = "78185_3", currentItem = "78034_12", addProperty = 31, addPropertyValue = 324}
, 
[256] = {id = 256, evolutionType = 86, evolutionLevel = 1, exclusiveItem = "78186_1", currentItem = "78023_4", addProperty = 51, addPropertyValue = 61}
, 
[257] = {id = 257, evolutionType = 86, evolutionLevel = 2, exclusiveItem = "78186_2", currentItem = "78023_8", addProperty = 21, addPropertyValue = 1231}
, 
[258] = {id = 258, evolutionType = 86, evolutionLevel = 3, exclusiveItem = "78186_3", currentItem = "78023_12", addProperty = 31, addPropertyValue = 513}
, 
[259] = {id = 259, evolutionType = 87, evolutionLevel = 1, exclusiveItem = "78154_1", currentItem = "78034_4", addProperty = 61, addPropertyValue = 86}
, 
[260] = {id = 260, evolutionType = 87, evolutionLevel = 2, exclusiveItem = "78154_2", currentItem = "78034_8", addProperty = 21, addPropertyValue = 1620}
, 
[261] = {id = 261, evolutionType = 87, evolutionLevel = 3, exclusiveItem = "78154_3", currentItem = "78034_12", addProperty = 31, addPropertyValue = 324}
, 
[262] = {id = 262, evolutionType = 88, evolutionLevel = 1, exclusiveItem = "78188_1", currentItem = "78032_4", addProperty = 51, addPropertyValue = 102}
, 
[263] = {id = 263, evolutionType = 88, evolutionLevel = 2, exclusiveItem = "78188_2", currentItem = "78032_8", addProperty = 21, addPropertyValue = 2154}
, 
[264] = {id = 264, evolutionType = 88, evolutionLevel = 3, exclusiveItem = "78188_3", currentItem = "78032_12", addProperty = 31, addPropertyValue = 436}
, 
[265] = {id = 265, evolutionType = 89, evolutionLevel = 1, exclusiveItem = "78189_1", currentItem = "78033_4", addProperty = 51, addPropertyValue = 64}
, 
[266] = {id = 266, evolutionType = 89, evolutionLevel = 2, exclusiveItem = "78189_2", currentItem = "78033_8", addProperty = 21, addPropertyValue = 1296}
, 
[267] = {id = 267, evolutionType = 89, evolutionLevel = 3, exclusiveItem = "78189_3", currentItem = "78033_12", addProperty = 31, addPropertyValue = 540}
, 
[268] = {id = 268, evolutionType = 90, evolutionLevel = 1, exclusiveItem = "78190_1", currentItem = "78032_4", addProperty = 51, addPropertyValue = 102}
, 
[269] = {id = 269, evolutionType = 90, evolutionLevel = 2, exclusiveItem = "78190_2", currentItem = "78032_8", addProperty = 21, addPropertyValue = 2154}
, 
[270] = {id = 270, evolutionType = 90, evolutionLevel = 3, exclusiveItem = "78190_3", currentItem = "78032_12", addProperty = 31, addPropertyValue = 436}
, 
[271] = {id = 271, evolutionType = 91, evolutionLevel = 1, exclusiveItem = "78191_1", currentItem = "78032_4", addProperty = 51, addPropertyValue = 102}
, 
[272] = {id = 272, evolutionType = 91, evolutionLevel = 2, exclusiveItem = "78191_2", currentItem = "78032_8", addProperty = 21, addPropertyValue = 2154}
, 
[273] = {id = 273, evolutionType = 91, evolutionLevel = 3, exclusiveItem = "78191_3", currentItem = "78032_12", addProperty = 31, addPropertyValue = 436}
, 
[274] = {id = 274, evolutionType = 92, evolutionLevel = 1, exclusiveItem = "78192_1", currentItem = "78032_4", addProperty = 51, addPropertyValue = 102}
, 
[275] = {id = 275, evolutionType = 92, evolutionLevel = 2, exclusiveItem = "78192_2", currentItem = "78032_8", addProperty = 21, addPropertyValue = 2154}
, 
[276] = {id = 276, evolutionType = 92, evolutionLevel = 3, exclusiveItem = "78192_3", currentItem = "78032_12", addProperty = 31, addPropertyValue = 436}
, 
[280] = {id = 280, evolutionType = 94, evolutionLevel = 1, exclusiveItem = "78194_1", currentItem = "78036_4", addProperty = 21, addPropertyValue = 1620}
, 
[281] = {id = 281, evolutionType = 94, evolutionLevel = 2, exclusiveItem = "78194_2", currentItem = "78036_8", addProperty = 61, addPropertyValue = 86}
, 
[282] = {id = 282, evolutionType = 94, evolutionLevel = 3, exclusiveItem = "78194_3", currentItem = "78036_12", addProperty = 31, addPropertyValue = 486}
, 
[283] = {id = 283, evolutionType = 95, evolutionLevel = 1, exclusiveItem = "78195_1", currentItem = "78036_4", addProperty = 21, addPropertyValue = 1620}
, 
[284] = {id = 284, evolutionType = 95, evolutionLevel = 2, exclusiveItem = "78195_2", currentItem = "78036_8", addProperty = 61, addPropertyValue = 86}
, 
[285] = {id = 285, evolutionType = 95, evolutionLevel = 3, exclusiveItem = "78195_3", currentItem = "78036_12", addProperty = 31, addPropertyValue = 486}
, 
[289] = {id = 289, evolutionType = 97, evolutionLevel = 1, exclusiveItem = "78197_1", currentItem = "78034_4", addProperty = 61, addPropertyValue = 86}
, 
[290] = {id = 290, evolutionType = 97, evolutionLevel = 2, exclusiveItem = "78197_2", currentItem = "78034_8", addProperty = 21, addPropertyValue = 1620}
, 
[291] = {id = 291, evolutionType = 97, evolutionLevel = 3, exclusiveItem = "78197_3", currentItem = "78034_12", addProperty = 31, addPropertyValue = 324}
, 
[292] = {id = 292, evolutionType = 98, evolutionLevel = 1, exclusiveItem = "78198_1", currentItem = "78034_4", addProperty = 61, addPropertyValue = 86}
, 
[293] = {id = 293, evolutionType = 98, evolutionLevel = 2, exclusiveItem = "78198_2", currentItem = "78034_8", addProperty = 21, addPropertyValue = 1620}
, 
[294] = {id = 294, evolutionType = 98, evolutionLevel = 3, exclusiveItem = "78198_3", currentItem = "78034_12", addProperty = 31, addPropertyValue = 324}
, 
[295] = {id = 295, evolutionType = 99, evolutionLevel = 1, exclusiveItem = "78199_1", currentItem = "78034_4", addProperty = 61, addPropertyValue = 86}
, 
[296] = {id = 296, evolutionType = 99, evolutionLevel = 2, exclusiveItem = "78199_2", currentItem = "78034_8", addProperty = 21, addPropertyValue = 1620}
, 
[297] = {id = 297, evolutionType = 99, evolutionLevel = 3, exclusiveItem = "78199_3", currentItem = "78034_12", addProperty = 31, addPropertyValue = 324}
, 
[298] = {id = 298, evolutionType = 100, evolutionLevel = 1, exclusiveItem = "781100_1", currentItem = "78035_4", addProperty = 21, addPropertyValue = 1620}
, 
[299] = {id = 299, evolutionType = 100, evolutionLevel = 2, exclusiveItem = "781100_2", currentItem = "78035_8", addProperty = 61, addPropertyValue = 86}
, 
[300] = {id = 300, evolutionType = 100, evolutionLevel = 3, exclusiveItem = "781100_3", currentItem = "78035_12", addProperty = 31, addPropertyValue = 486}
, 
[301] = {id = 301, evolutionType = 101, evolutionLevel = 1, exclusiveItem = "781101_1", currentItem = "78035_4", addProperty = 51, addPropertyValue = 86}
, 
[302] = {id = 302, evolutionType = 101, evolutionLevel = 2, exclusiveItem = "781101_2", currentItem = "78035_8", addProperty = 31, addPropertyValue = 324}
, 
[303] = {id = 303, evolutionType = 101, evolutionLevel = 3, exclusiveItem = "781101_3", currentItem = "78035_12", addProperty = 21, addPropertyValue = 1620}
, 
[304] = {id = 304, evolutionType = 102, evolutionLevel = 1, exclusiveItem = "781102_1", currentItem = "78035_4", addProperty = 51, addPropertyValue = 86}
, 
[305] = {id = 305, evolutionType = 102, evolutionLevel = 2, exclusiveItem = "781102_2", currentItem = "78035_8", addProperty = 31, addPropertyValue = 324}
, 
[306] = {id = 306, evolutionType = 102, evolutionLevel = 3, exclusiveItem = "781102_3", currentItem = "78035_12", addProperty = 21, addPropertyValue = 1620}
, 
[307] = {id = 307, evolutionType = 103, evolutionLevel = 1, exclusiveItem = "781103_1", currentItem = "78034_4", addProperty = 61, addPropertyValue = 86}
, 
[308] = {id = 308, evolutionType = 103, evolutionLevel = 2, exclusiveItem = "781103_2", currentItem = "78034_8", addProperty = 21, addPropertyValue = 1620}
, 
[309] = {id = 309, evolutionType = 103, evolutionLevel = 3, exclusiveItem = "781103_3", currentItem = "78034_12", addProperty = 31, addPropertyValue = 324}
, 
[310] = {id = 310, evolutionType = 104, evolutionLevel = 1, exclusiveItem = "781104_1", currentItem = "78036_4", addProperty = 21, addPropertyValue = 1620}
, 
[311] = {id = 311, evolutionType = 104, evolutionLevel = 2, exclusiveItem = "781104_2", currentItem = "78036_8", addProperty = 61, addPropertyValue = 86}
, 
[312] = {id = 312, evolutionType = 104, evolutionLevel = 3, exclusiveItem = "781104_3", currentItem = "78036_12", addProperty = 31, addPropertyValue = 486}
, 
[313] = {id = 313, evolutionType = 105, evolutionLevel = 1, exclusiveItem = "781105_1", currentItem = "78036_4", addProperty = 21, addPropertyValue = 1620}
, 
[314] = {id = 314, evolutionType = 105, evolutionLevel = 2, exclusiveItem = "781105_2", currentItem = "78036_8", addProperty = 61, addPropertyValue = 86}
, 
[315] = {id = 315, evolutionType = 105, evolutionLevel = 3, exclusiveItem = "781105_3", currentItem = "78036_12", addProperty = 31, addPropertyValue = 486}
, 
[316] = {id = 316, evolutionType = 106, evolutionLevel = 1, exclusiveItem = "781106_1", currentItem = "78033_4", addProperty = 21, addPropertyValue = 1620}
, 
[317] = {id = 317, evolutionType = 106, evolutionLevel = 2, exclusiveItem = "781106_2", currentItem = "78033_8", addProperty = 61, addPropertyValue = 86}
, 
[318] = {id = 318, evolutionType = 106, evolutionLevel = 3, exclusiveItem = "781106_3", currentItem = "78033_12", addProperty = 31, addPropertyValue = 486}
, 
[319] = {id = 319, evolutionType = 107, evolutionLevel = 1, exclusiveItem = "781107_1", currentItem = "78033_4", addProperty = 21, addPropertyValue = 1620}
, 
[320] = {id = 320, evolutionType = 107, evolutionLevel = 2, exclusiveItem = "781107_2", currentItem = "78033_8", addProperty = 61, addPropertyValue = 86}
, 
[321] = {id = 321, evolutionType = 107, evolutionLevel = 3, exclusiveItem = "781107_3", currentItem = "78033_12", addProperty = 31, addPropertyValue = 486}
, 
[322] = {id = 322, evolutionType = 108, evolutionLevel = 1, exclusiveItem = "781108_1", currentItem = "78031_4", addProperty = 21, addPropertyValue = 1620}
, 
[323] = {id = 323, evolutionType = 108, evolutionLevel = 2, exclusiveItem = "781108_2", currentItem = "78031_8", addProperty = 61, addPropertyValue = 86}
, 
[324] = {id = 324, evolutionType = 108, evolutionLevel = 3, exclusiveItem = "781108_3", currentItem = "78031_12", addProperty = 31, addPropertyValue = 486}
, 
[325] = {id = 325, evolutionType = 109, evolutionLevel = 1, exclusiveItem = "781109_1", currentItem = "78031_4", addProperty = 21, addPropertyValue = 1620}
, 
[326] = {id = 326, evolutionType = 109, evolutionLevel = 2, exclusiveItem = "781109_2", currentItem = "78031_8", addProperty = 61, addPropertyValue = 86}
, 
[327] = {id = 327, evolutionType = 109, evolutionLevel = 3, exclusiveItem = "781109_3", currentItem = "78031_12", addProperty = 31, addPropertyValue = 486}
, 
[328] = {id = 328, evolutionType = 110, evolutionLevel = 1, exclusiveItem = "781110_1", currentItem = "78032_4", addProperty = 21, addPropertyValue = 1620}
, 
[329] = {id = 329, evolutionType = 110, evolutionLevel = 2, exclusiveItem = "781110_2", currentItem = "78032_8", addProperty = 61, addPropertyValue = 86}
, 
[330] = {id = 330, evolutionType = 110, evolutionLevel = 3, exclusiveItem = "781110_3", currentItem = "78032_12", addProperty = 31, addPropertyValue = 486}
, 
[331] = {id = 331, evolutionType = 112, evolutionLevel = 1, exclusiveItem = "781112_1", currentItem = "78031_4", addProperty = 21, addPropertyValue = 1620}
, 
[332] = {id = 332, evolutionType = 112, evolutionLevel = 2, exclusiveItem = "781112_2", currentItem = "78031_8", addProperty = 61, addPropertyValue = 86}
, 
[333] = {id = 333, evolutionType = 112, evolutionLevel = 3, exclusiveItem = "781112_3", currentItem = "78031_12", addProperty = 31, addPropertyValue = 486}
, 
[334] = {id = 334, evolutionType = 113, evolutionLevel = 1, exclusiveItem = "781113_1", currentItem = "78036_4", addProperty = 21, addPropertyValue = 1620}
, 
[335] = {id = 335, evolutionType = 113, evolutionLevel = 2, exclusiveItem = "781113_2", currentItem = "78036_8", addProperty = 61, addPropertyValue = 86}
, 
[336] = {id = 336, evolutionType = 113, evolutionLevel = 3, exclusiveItem = "781113_3", currentItem = "78036_12", addProperty = 31, addPropertyValue = 486}
, 
[337] = {id = 337, evolutionType = 120, evolutionLevel = 1, exclusiveItem = "781120_1", currentItem = "78035_4", addProperty = 51, addPropertyValue = 86}
, 
[338] = {id = 338, evolutionType = 120, evolutionLevel = 2, exclusiveItem = "781120_2", currentItem = "78035_8", addProperty = 31, addPropertyValue = 324}
, 
[339] = {id = 339, evolutionType = 120, evolutionLevel = 3, exclusiveItem = "781120_3", currentItem = "78035_12", addProperty = 21, addPropertyValue = 1620}
, 
[340] = {id = 340, evolutionType = 111, evolutionLevel = 1, exclusiveItem = "781111_1", currentItem = "78032_4", addProperty = 51, addPropertyValue = 102}
, 
[341] = {id = 341, evolutionType = 111, evolutionLevel = 2, exclusiveItem = "781111_2", currentItem = "78032_8", addProperty = 21, addPropertyValue = 2154}
, 
[342] = {id = 342, evolutionType = 111, evolutionLevel = 3, exclusiveItem = "781111_3", currentItem = "78032_12", addProperty = 31, addPropertyValue = 436}
, 
[343] = {id = 343, evolutionType = 115, evolutionLevel = 1, exclusiveItem = "781115_1", currentItem = "78033_4", addProperty = 61, addPropertyValue = 86}
, 
[344] = {id = 344, evolutionType = 115, evolutionLevel = 2, exclusiveItem = "781115_2", currentItem = "78033_8", addProperty = 21, addPropertyValue = 1620}
, 
[345] = {id = 345, evolutionType = 115, evolutionLevel = 3, exclusiveItem = "781115_3", currentItem = "78033_12", addProperty = 31, addPropertyValue = 324}
, 
[346] = {id = 346, evolutionType = 119, evolutionLevel = 1, exclusiveItem = "781119_1", currentItem = "78036_4", addProperty = 21, addPropertyValue = 1620}
, 
[347] = {id = 347, evolutionType = 119, evolutionLevel = 2, exclusiveItem = "781119_2", currentItem = "78036_8", addProperty = 61, addPropertyValue = 86}
, 
[348] = {id = 348, evolutionType = 119, evolutionLevel = 3, exclusiveItem = "781119_3", currentItem = "78036_12", addProperty = 31, addPropertyValue = 486}
, 
[349] = {id = 349, evolutionType = 117, evolutionLevel = 1, exclusiveItem = "781117_1", currentItem = "78032_4", addProperty = 21, addPropertyValue = 1620}
, 
[350] = {id = 350, evolutionType = 117, evolutionLevel = 2, exclusiveItem = "781117_2", currentItem = "78032_8", addProperty = 61, addPropertyValue = 86}
, 
[351] = {id = 351, evolutionType = 117, evolutionLevel = 3, exclusiveItem = "781117_3", currentItem = "78032_12", addProperty = 31, addPropertyValue = 486}
, 
[352] = {id = 352, evolutionType = 122, evolutionLevel = 1, exclusiveItem = "781122_1", currentItem = "78032_4", addProperty = 21, addPropertyValue = 1620}
, 
[353] = {id = 353, evolutionType = 122, evolutionLevel = 2, exclusiveItem = "781122_2", currentItem = "78032_8", addProperty = 61, addPropertyValue = 86}
, 
[354] = {id = 354, evolutionType = 122, evolutionLevel = 3, exclusiveItem = "781122_3", currentItem = "78032_12", addProperty = 31, addPropertyValue = 486}
, 
[355] = {id = 355, evolutionType = 121, evolutionLevel = 1, exclusiveItem = "781121_1", currentItem = "78033_4", addProperty = 51, addPropertyValue = 64}
, 
[356] = {id = 356, evolutionType = 121, evolutionLevel = 2, exclusiveItem = "781121_2", currentItem = "78033_8", addProperty = 21, addPropertyValue = 1296}
, 
[357] = {id = 357, evolutionType = 121, evolutionLevel = 3, exclusiveItem = "781121_3", currentItem = "78033_12", addProperty = 31, addPropertyValue = 540}
, 
[358] = {id = 358, evolutionType = 123, evolutionLevel = 1, exclusiveItem = "781123_1", currentItem = "78034_4", addProperty = 61, addPropertyValue = 86}
, 
[359] = {id = 359, evolutionType = 123, evolutionLevel = 2, exclusiveItem = "781123_2", currentItem = "78034_8", addProperty = 21, addPropertyValue = 1620}
, 
[360] = {id = 360, evolutionType = 123, evolutionLevel = 3, exclusiveItem = "781123_3", currentItem = "78034_12", addProperty = 31, addPropertyValue = 324}
, 
[361] = {id = 361, evolutionType = 82, evolutionLevel = 1, exclusiveItem = "781082_1", currentItem = "78032_4", addProperty = 21, addPropertyValue = 1620}
, 
[362] = {id = 362, evolutionType = 82, evolutionLevel = 2, exclusiveItem = "781082_2", currentItem = "78032_8", addProperty = 61, addPropertyValue = 86}
, 
[363] = {id = 363, evolutionType = 82, evolutionLevel = 3, exclusiveItem = "781082_3", currentItem = "78032_12", addProperty = 31, addPropertyValue = 486}
, 
[364] = {id = 364, evolutionType = 124, evolutionLevel = 1, exclusiveItem = "781124_1", currentItem = "78033_4", addProperty = 61, addPropertyValue = 86}
, 
[365] = {id = 365, evolutionType = 124, evolutionLevel = 2, exclusiveItem = "781124_2", currentItem = "78033_8", addProperty = 21, addPropertyValue = 1620}
, 
[366] = {id = 366, evolutionType = 124, evolutionLevel = 3, exclusiveItem = "781124_3", currentItem = "78033_12", addProperty = 31, addPropertyValue = 324}
, 
[367] = {id = 367, evolutionType = 116, evolutionLevel = 1, exclusiveItem = "781116_1", currentItem = "78031_4", addProperty = 51, addPropertyValue = 216}
, 
[368] = {id = 368, evolutionType = 116, evolutionLevel = 2, exclusiveItem = "781116_2", currentItem = "78031_8", addProperty = 61, addPropertyValue = 216}
, 
[369] = {id = 369, evolutionType = 116, evolutionLevel = 3, exclusiveItem = "781116_3", currentItem = "78031_12", addProperty = 31, addPropertyValue = 324}
, 
[370] = {id = 370, evolutionType = 93, evolutionLevel = 1, exclusiveItem = "781093_1", currentItem = "78035_4", addProperty = 51, addPropertyValue = 86}
, 
[371] = {id = 371, evolutionType = 93, evolutionLevel = 2, exclusiveItem = "781093_2", currentItem = "78035_8", addProperty = 21, addPropertyValue = 1620}
, 
[372] = {id = 372, evolutionType = 93, evolutionLevel = 3, exclusiveItem = "781093_3", currentItem = "78035_12", addProperty = 31, addPropertyValue = 324}
, 
[373] = {id = 373, evolutionType = 118, evolutionLevel = 1, exclusiveItem = "781118_1", currentItem = "78036_4", addProperty = 61, addPropertyValue = 86}
, 
[374] = {id = 374, evolutionType = 118, evolutionLevel = 2, exclusiveItem = "781118_2", currentItem = "78036_8", addProperty = 21, addPropertyValue = 1620}
, 
[375] = {id = 375, evolutionType = 118, evolutionLevel = 3, exclusiveItem = "781118_3", currentItem = "78036_12", addProperty = 31, addPropertyValue = 324}
, 
[376] = {id = 376, evolutionType = 126, evolutionLevel = 1, exclusiveItem = "781126_1", currentItem = "78035_4", addProperty = 51, addPropertyValue = 86}
, 
[377] = {id = 377, evolutionType = 126, evolutionLevel = 2, exclusiveItem = "781126_2", currentItem = "78035_8", addProperty = 31, addPropertyValue = 324}
, 
[378] = {id = 378, evolutionType = 126, evolutionLevel = 3, exclusiveItem = "781126_3", currentItem = "78035_12", addProperty = 21, addPropertyValue = 1620}
, 
[382] = {id = 382, evolutionType = 130, evolutionLevel = 1, exclusiveItem = "781130_1", currentItem = "78032_4", addProperty = 21, addPropertyValue = 1620}
, 
[383] = {id = 383, evolutionType = 130, evolutionLevel = 2, exclusiveItem = "781130_2", currentItem = "78032_8", addProperty = 61, addPropertyValue = 86}
, 
[384] = {id = 384, evolutionType = 130, evolutionLevel = 3, exclusiveItem = "781130_3", currentItem = "78032_12", addProperty = 31, addPropertyValue = 486}
}
croleevolutioncfg.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 280, 281, 282, 283, 284, 285, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 382, 383, 384}
return croleevolutioncfg

