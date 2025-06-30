-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/npc/ctouchconfig.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ctouchconfig = {}
ctouchconfig.Data = {
[1] = {id = 1, role_id = 1, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[2] = {id = 2, role_id = 1, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[3] = {id = 3, role_id = 1, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[4] = {id = 4, role_id = 1, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[5] = {id = 5, role_id = 1, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5", "touch,5"}
}
, 
[6] = {id = 6, role_id = 2, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[7] = {id = 7, role_id = 2, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[8] = {id = 8, role_id = 2, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[9] = {id = 9, role_id = 2, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[10] = {id = 10, role_id = 2, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5", "touch,5"}
}
, 
[11] = {id = 11, role_id = 3, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[12] = {id = 12, role_id = 3, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[13] = {id = 13, role_id = 3, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[14] = {id = 14, role_id = 3, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[15] = {id = 15, role_id = 3, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5", "touch,5"}
}
, 
[16] = {id = 16, role_id = 4, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[17] = {id = 17, role_id = 4, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[18] = {id = 18, role_id = 4, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[19] = {id = 19, role_id = 4, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[20] = {id = 20, role_id = 4, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[21] = {id = 21, role_id = 6, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[22] = {id = 22, role_id = 6, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[23] = {id = 23, role_id = 6, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[24] = {id = 24, role_id = 6, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[25] = {id = 25, role_id = 6, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[26] = {id = 26, role_id = 8, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[27] = {id = 27, role_id = 8, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[28] = {id = 28, role_id = 8, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[29] = {id = 29, role_id = 8, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[30] = {id = 30, role_id = 8, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[31] = {id = 31, role_id = 9, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[32] = {id = 32, role_id = 9, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[33] = {id = 33, role_id = 9, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[34] = {id = 34, role_id = 9, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[35] = {id = 35, role_id = 9, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[36] = {id = 36, role_id = 10, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[37] = {id = 37, role_id = 10, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[38] = {id = 38, role_id = 10, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[39] = {id = 39, role_id = 10, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[40] = {id = 40, role_id = 10, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[41] = {id = 41, role_id = 11, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[42] = {id = 42, role_id = 11, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[43] = {id = 43, role_id = 11, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[44] = {id = 44, role_id = 11, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[45] = {id = 45, role_id = 11, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[46] = {id = 46, role_id = 12, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[47] = {id = 47, role_id = 12, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[48] = {id = 48, role_id = 12, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[49] = {id = 49, role_id = 12, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[50] = {id = 50, role_id = 12, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[51] = {id = 51, role_id = 13, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[52] = {id = 52, role_id = 13, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[53] = {id = 53, role_id = 13, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[54] = {id = 54, role_id = 13, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[55] = {id = 55, role_id = 13, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[56] = {id = 56, role_id = 14, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[57] = {id = 57, role_id = 14, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[58] = {id = 58, role_id = 14, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[59] = {id = 59, role_id = 14, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[60] = {id = 60, role_id = 14, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[61] = {id = 61, role_id = 15, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[62] = {id = 62, role_id = 15, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[63] = {id = 63, role_id = 15, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[64] = {id = 64, role_id = 15, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[65] = {id = 65, role_id = 15, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[66] = {id = 66, role_id = 16, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[67] = {id = 67, role_id = 16, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[68] = {id = 68, role_id = 16, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[69] = {id = 69, role_id = 16, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[70] = {id = 70, role_id = 16, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[71] = {id = 71, role_id = 17, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[72] = {id = 72, role_id = 17, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[73] = {id = 73, role_id = 17, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[74] = {id = 74, role_id = 17, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[75] = {id = 75, role_id = 17, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[76] = {id = 76, role_id = 18, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[77] = {id = 77, role_id = 18, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[78] = {id = 78, role_id = 18, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[79] = {id = 79, role_id = 18, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[80] = {id = 80, role_id = 18, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[81] = {id = 81, role_id = 19, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[82] = {id = 82, role_id = 19, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[83] = {id = 83, role_id = 19, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[84] = {id = 84, role_id = 19, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[85] = {id = 85, role_id = 19, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[86] = {id = 86, role_id = 22, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[87] = {id = 87, role_id = 22, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[88] = {id = 88, role_id = 22, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[89] = {id = 89, role_id = 22, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[90] = {id = 90, role_id = 22, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[91] = {id = 91, role_id = 23, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[92] = {id = 92, role_id = 23, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[93] = {id = 93, role_id = 23, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[94] = {id = 94, role_id = 23, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[95] = {id = 95, role_id = 23, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[96] = {id = 96, role_id = 24, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[97] = {id = 97, role_id = 24, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[98] = {id = 98, role_id = 24, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[99] = {id = 99, role_id = 24, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[100] = {id = 100, role_id = 24, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[101] = {id = 101, role_id = 25, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[102] = {id = 102, role_id = 25, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[103] = {id = 103, role_id = 25, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[104] = {id = 104, role_id = 25, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[105] = {id = 105, role_id = 25, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[106] = {id = 106, role_id = 27, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[107] = {id = 107, role_id = 27, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[108] = {id = 108, role_id = 27, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[109] = {id = 109, role_id = 27, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[110] = {id = 110, role_id = 27, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[111] = {id = 111, role_id = 28, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[112] = {id = 112, role_id = 28, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[113] = {id = 113, role_id = 28, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[114] = {id = 114, role_id = 28, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[115] = {id = 115, role_id = 28, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[116] = {id = 116, role_id = 29, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[117] = {id = 117, role_id = 29, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[118] = {id = 118, role_id = 29, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[119] = {id = 119, role_id = 29, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[120] = {id = 120, role_id = 29, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[121] = {id = 121, role_id = 30, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[122] = {id = 122, role_id = 30, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[123] = {id = 123, role_id = 30, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[124] = {id = 124, role_id = 30, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[125] = {id = 125, role_id = 30, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[126] = {id = 126, role_id = 32, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[127] = {id = 127, role_id = 32, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[128] = {id = 128, role_id = 32, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[129] = {id = 129, role_id = 32, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[130] = {id = 130, role_id = 32, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[131] = {id = 131, role_id = 33, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[132] = {id = 132, role_id = 33, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[133] = {id = 133, role_id = 33, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[134] = {id = 134, role_id = 33, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[135] = {id = 135, role_id = 33, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[136] = {id = 136, role_id = 34, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[137] = {id = 137, role_id = 34, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[138] = {id = 138, role_id = 34, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[139] = {id = 139, role_id = 34, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[140] = {id = 140, role_id = 34, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[141] = {id = 141, role_id = 35, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[142] = {id = 142, role_id = 35, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[143] = {id = 143, role_id = 35, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[144] = {id = 144, role_id = 35, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[145] = {id = 145, role_id = 35, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[146] = {id = 146, role_id = 36, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[147] = {id = 147, role_id = 36, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[148] = {id = 148, role_id = 36, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[149] = {id = 149, role_id = 36, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[150] = {id = 150, role_id = 36, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[151] = {id = 151, role_id = 38, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[152] = {id = 152, role_id = 38, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[153] = {id = 153, role_id = 38, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[154] = {id = 154, role_id = 38, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[155] = {id = 155, role_id = 38, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[156] = {id = 156, role_id = 39, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[157] = {id = 157, role_id = 39, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[158] = {id = 158, role_id = 39, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[159] = {id = 159, role_id = 39, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[160] = {id = 160, role_id = 39, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[161] = {id = 161, role_id = 40, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[162] = {id = 162, role_id = 40, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[163] = {id = 163, role_id = 40, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[164] = {id = 164, role_id = 40, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[165] = {id = 165, role_id = 40, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[166] = {id = 166, role_id = 41, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[167] = {id = 167, role_id = 41, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[168] = {id = 168, role_id = 41, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[169] = {id = 169, role_id = 41, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[170] = {id = 170, role_id = 41, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[171] = {id = 171, role_id = 42, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[172] = {id = 172, role_id = 42, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[173] = {id = 173, role_id = 42, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[174] = {id = 174, role_id = 42, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[175] = {id = 175, role_id = 42, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[176] = {id = 176, role_id = 43, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[177] = {id = 177, role_id = 43, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[178] = {id = 178, role_id = 43, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[179] = {id = 179, role_id = 43, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[180] = {id = 180, role_id = 43, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[181] = {id = 181, role_id = 44, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[182] = {id = 182, role_id = 44, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[183] = {id = 183, role_id = 44, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[184] = {id = 184, role_id = 44, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[185] = {id = 185, role_id = 44, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[186] = {id = 186, role_id = 45, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[187] = {id = 187, role_id = 45, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[188] = {id = 188, role_id = 45, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[189] = {id = 189, role_id = 45, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[190] = {id = 190, role_id = 45, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[191] = {id = 191, role_id = 47, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[192] = {id = 192, role_id = 47, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[193] = {id = 193, role_id = 47, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[194] = {id = 194, role_id = 47, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[195] = {id = 195, role_id = 47, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[196] = {id = 196, role_id = 48, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[197] = {id = 197, role_id = 48, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[198] = {id = 198, role_id = 48, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[199] = {id = 199, role_id = 48, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[200] = {id = 200, role_id = 48, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[201] = {id = 201, role_id = 49, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[202] = {id = 202, role_id = 49, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[203] = {id = 203, role_id = 49, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[204] = {id = 204, role_id = 49, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[205] = {id = 205, role_id = 49, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[206] = {id = 206, role_id = 51, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[207] = {id = 207, role_id = 51, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[208] = {id = 208, role_id = 51, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[209] = {id = 209, role_id = 51, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[210] = {id = 210, role_id = 51, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[211] = {id = 211, role_id = 52, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[212] = {id = 212, role_id = 52, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[213] = {id = 213, role_id = 52, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[214] = {id = 214, role_id = 52, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[215] = {id = 215, role_id = 52, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[216] = {id = 216, role_id = 53, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[217] = {id = 217, role_id = 53, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[218] = {id = 218, role_id = 53, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[219] = {id = 219, role_id = 53, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[220] = {id = 220, role_id = 53, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[221] = {id = 221, role_id = 54, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[222] = {id = 222, role_id = 54, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[223] = {id = 223, role_id = 54, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[224] = {id = 224, role_id = 54, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[225] = {id = 225, role_id = 54, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[226] = {id = 226, role_id = 55, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[227] = {id = 227, role_id = 55, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[228] = {id = 228, role_id = 55, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[229] = {id = 229, role_id = 55, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[230] = {id = 230, role_id = 55, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[231] = {id = 231, role_id = 56, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[232] = {id = 232, role_id = 56, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[233] = {id = 233, role_id = 56, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[234] = {id = 234, role_id = 56, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[235] = {id = 235, role_id = 56, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[236] = {id = 236, role_id = 57, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[237] = {id = 237, role_id = 57, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[238] = {id = 238, role_id = 57, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[239] = {id = 239, role_id = 57, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[240] = {id = 240, role_id = 57, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[241] = {id = 241, role_id = 59, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[242] = {id = 242, role_id = 59, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[243] = {id = 243, role_id = 59, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[244] = {id = 244, role_id = 59, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[245] = {id = 245, role_id = 59, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[246] = {id = 246, role_id = 61, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[247] = {id = 247, role_id = 61, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[248] = {id = 248, role_id = 61, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[249] = {id = 249, role_id = 61, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[250] = {id = 250, role_id = 61, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[251] = {id = 251, role_id = 63, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[252] = {id = 252, role_id = 63, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[253] = {id = 253, role_id = 63, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[254] = {id = 254, role_id = 63, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[255] = {id = 255, role_id = 63, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[256] = {id = 256, role_id = 64, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[257] = {id = 257, role_id = 64, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[258] = {id = 258, role_id = 64, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[259] = {id = 259, role_id = 64, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[260] = {id = 260, role_id = 64, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[261] = {id = 261, role_id = 65, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[262] = {id = 262, role_id = 65, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[263] = {id = 263, role_id = 65, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[264] = {id = 264, role_id = 65, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[265] = {id = 265, role_id = 65, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[266] = {id = 266, role_id = 66, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[267] = {id = 267, role_id = 66, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[268] = {id = 268, role_id = 66, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[269] = {id = 269, role_id = 66, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[270] = {id = 270, role_id = 66, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[271] = {id = 271, role_id = 67, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[272] = {id = 272, role_id = 67, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[273] = {id = 273, role_id = 67, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[274] = {id = 274, role_id = 67, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[275] = {id = 275, role_id = 67, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[276] = {id = 276, role_id = 68, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[277] = {id = 277, role_id = 68, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[278] = {id = 278, role_id = 68, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[279] = {id = 279, role_id = 68, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[280] = {id = 280, role_id = 68, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[281] = {id = 281, role_id = 69, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[282] = {id = 282, role_id = 69, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[283] = {id = 283, role_id = 69, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[284] = {id = 284, role_id = 69, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[285] = {id = 285, role_id = 69, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[286] = {id = 286, role_id = 70, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[287] = {id = 287, role_id = 70, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[288] = {id = 288, role_id = 70, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[289] = {id = 289, role_id = 70, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[290] = {id = 290, role_id = 70, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[291] = {id = 291, role_id = 71, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[292] = {id = 292, role_id = 71, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[293] = {id = 293, role_id = 71, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[294] = {id = 294, role_id = 71, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[295] = {id = 295, role_id = 71, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[296] = {id = 296, role_id = 72, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[297] = {id = 297, role_id = 72, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[298] = {id = 298, role_id = 72, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[299] = {id = 299, role_id = 72, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[300] = {id = 300, role_id = 72, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[301] = {id = 301, role_id = 73, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[302] = {id = 302, role_id = 73, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[303] = {id = 303, role_id = 73, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[304] = {id = 304, role_id = 73, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[305] = {id = 305, role_id = 73, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[306] = {id = 306, role_id = 74, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[307] = {id = 307, role_id = 74, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[308] = {id = 308, role_id = 74, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[309] = {id = 309, role_id = 74, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[310] = {id = 310, role_id = 74, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[311] = {id = 311, role_id = 75, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[312] = {id = 312, role_id = 75, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[313] = {id = 313, role_id = 75, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[314] = {id = 314, role_id = 75, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[315] = {id = 315, role_id = 75, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[316] = {id = 316, role_id = 76, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[317] = {id = 317, role_id = 76, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[318] = {id = 318, role_id = 76, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[319] = {id = 319, role_id = 76, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[320] = {id = 320, role_id = 76, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[321] = {id = 321, role_id = 78, area = "Head", 
state = {"smile", "happy", "positive", "talk", "shock"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1", "touch,3"}
}
, 
[322] = {id = 322, role_id = 78, area = "Face", 
state = {"happy", "positive", "talk", "shock"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,2", "touch,3"}
}
, 
[323] = {id = 323, role_id = 78, area = "Breast", 
state = {"angry", "negative", "shock"}
, 
volume_id = {"Emotion,2", "Emotion,2", "touch,2"}
}
, 
[324] = {id = 324, role_id = 78, area = "Skirt", 
state = {"angry", "negative", "shock"}
, 
volume_id = {"Emotion,2", "Emotion,2", "touch,2"}
}
, 
[325] = {id = 325, role_id = 78, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[326] = {id = 326, role_id = 79, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[327] = {id = 327, role_id = 79, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,3", "Emotion,1", "touch,3"}
}
, 
[328] = {id = 328, role_id = 79, area = "Breast", 
state = {"angry", "negative", "angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2", "touch,2", "touch,2"}
}
, 
[329] = {id = 329, role_id = 79, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[330] = {id = 330, role_id = 79, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[331] = {id = 331, role_id = 81, area = "Head", 
state = {"smile", "happy", "positive", "talk", "negative"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1", "Emotion,2"}
}
, 
[332] = {id = 332, role_id = 81, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,3", "Emotion,1", "touch,3"}
}
, 
[333] = {id = 333, role_id = 81, area = "Breast", 
state = {"angry", "negative", "angry", "negative"}
, 
volume_id = {"touch,2", "touch,2", "touch,2", "touch,2"}
}
, 
[334] = {id = 334, role_id = 81, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"touch,4", "touch,4"}
}
, 
[335] = {id = 335, role_id = 81, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[336] = {id = 336, role_id = 89, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[337] = {id = 337, role_id = 89, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,3", "Emotion,1", "touch,3"}
}
, 
[338] = {id = 338, role_id = 89, area = "Breast", 
state = {"angry", "negative", "angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2", "touch,2", "touch,2"}
}
, 
[339] = {id = 339, role_id = 89, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[340] = {id = 340, role_id = 89, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[341] = {id = 341, role_id = 90, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[342] = {id = 342, role_id = 90, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,3", "Emotion,1", "touch,3"}
}
, 
[343] = {id = 343, role_id = 90, area = "Breast", 
state = {"angry", "negative", "angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2", "touch,2", "touch,2"}
}
, 
[344] = {id = 344, role_id = 90, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[345] = {id = 345, role_id = 90, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[346] = {id = 346, role_id = 83, area = "Head", 
state = {"negative", "angry"}
, 
volume_id = {"touch,1", "touch,1"}
}
, 
[347] = {id = 347, role_id = 83, area = "Face", 
state = {"negative", "angry", "talk"}
, 
volume_id = {"touch,3", "touch,3", "touch,3"}
}
, 
[348] = {id = 348, role_id = 83, area = "Breast", 
state = {"angry", "angry", "shock"}
, 
volume_id = {"touch,2", "Emotion,2", "touch,2"}
}
, 
[349] = {id = 349, role_id = 83, area = "Skirt", 
state = {"angry", "angry"}
, 
volume_id = {"touch,4", "Emotion,2"}
}
, 
[350] = {id = 350, role_id = 83, area = "Leg", 
state = {"talk", "negative"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[351] = {id = 351, role_id = 95, area = "Head", 
state = {"shy", "smile"}
, 
volume_id = {"touch,1", "touch,1"}
}
, 
[352] = {id = 352, role_id = 95, area = "Face", 
state = {"smile", "shy"}
, 
volume_id = {"touch,3", "touch,3"}
}
, 
[353] = {id = 353, role_id = 95, area = "Breast", 
state = {"shock", "negative", "talk"}
, 
volume_id = {"touch,2", "Emotion,2", "touch,2"}
}
, 
[354] = {id = 354, role_id = 95, area = "Skirt", 
state = {"shy", "negative", "talk", "angry"}
, 
volume_id = {"touch,4", "Emotion,2", "touch,4", "touch,4"}
}
, 
[355] = {id = 355, role_id = 95, area = "Leg", 
state = {"shy", "negative", "angry"}
, 
volume_id = {"touch,5", "touch,5", "Emotion,2"}
}
, 
[356] = {id = 356, role_id = 80, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[357] = {id = 357, role_id = 80, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[358] = {id = 358, role_id = 80, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[359] = {id = 359, role_id = 80, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[360] = {id = 360, role_id = 80, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[361] = {id = 361, role_id = 108, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[362] = {id = 362, role_id = 108, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[363] = {id = 363, role_id = 108, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[364] = {id = 364, role_id = 108, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[365] = {id = 365, role_id = 108, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[366] = {id = 366, role_id = 110, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"touch,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[367] = {id = 367, role_id = 110, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"touch,2", "Emotion,1", "touch,3"}
}
, 
[368] = {id = 368, role_id = 110, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[369] = {id = 369, role_id = 110, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "Emotion,2"}
}
, 
[370] = {id = 370, role_id = 110, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"touch,5", "touch,5"}
}
, 
[371] = {id = 371, role_id = 100, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[372] = {id = 372, role_id = 100, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[373] = {id = 373, role_id = 100, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[374] = {id = 374, role_id = 100, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[375] = {id = 375, role_id = 100, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[376] = {id = 376, role_id = 106, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[377] = {id = 377, role_id = 106, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[378] = {id = 378, role_id = 106, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[379] = {id = 379, role_id = 106, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[380] = {id = 380, role_id = 106, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[381] = {id = 381, role_id = 86, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[382] = {id = 382, role_id = 86, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[383] = {id = 383, role_id = 86, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[384] = {id = 384, role_id = 86, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[385] = {id = 385, role_id = 86, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[386] = {id = 386, role_id = 99, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[387] = {id = 387, role_id = 99, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[388] = {id = 388, role_id = 99, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[389] = {id = 389, role_id = 99, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[390] = {id = 390, role_id = 99, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[391] = {id = 391, role_id = 91, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[392] = {id = 392, role_id = 91, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[393] = {id = 393, role_id = 91, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[394] = {id = 394, role_id = 91, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[395] = {id = 395, role_id = 91, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[396] = {id = 396, role_id = 92, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[397] = {id = 397, role_id = 92, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[398] = {id = 398, role_id = 92, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[399] = {id = 399, role_id = 92, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[400] = {id = 400, role_id = 92, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[401] = {id = 401, role_id = 103, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[402] = {id = 402, role_id = 103, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[403] = {id = 403, role_id = 103, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[404] = {id = 404, role_id = 103, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[405] = {id = 405, role_id = 103, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[406] = {id = 406, role_id = 102, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[407] = {id = 407, role_id = 102, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[408] = {id = 408, role_id = 102, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[409] = {id = 409, role_id = 102, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[410] = {id = 410, role_id = 102, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[411] = {id = 411, role_id = 84, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[412] = {id = 412, role_id = 84, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[413] = {id = 413, role_id = 84, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[414] = {id = 414, role_id = 84, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[415] = {id = 415, role_id = 84, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[416] = {id = 416, role_id = 85, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[417] = {id = 417, role_id = 85, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[418] = {id = 418, role_id = 85, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[419] = {id = 419, role_id = 85, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[420] = {id = 420, role_id = 85, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[421] = {id = 421, role_id = 94, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[422] = {id = 422, role_id = 94, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[423] = {id = 423, role_id = 94, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[424] = {id = 424, role_id = 94, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[425] = {id = 425, role_id = 94, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[426] = {id = 426, role_id = 101, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[427] = {id = 427, role_id = 101, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[428] = {id = 428, role_id = 101, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[429] = {id = 429, role_id = 101, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[430] = {id = 430, role_id = 101, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[431] = {id = 431, role_id = 97, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[432] = {id = 432, role_id = 97, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[433] = {id = 433, role_id = 97, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[434] = {id = 434, role_id = 97, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[435] = {id = 435, role_id = 97, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[436] = {id = 436, role_id = 88, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[437] = {id = 437, role_id = 88, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[438] = {id = 438, role_id = 88, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[439] = {id = 439, role_id = 88, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[440] = {id = 440, role_id = 88, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[441] = {id = 441, role_id = 112, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[442] = {id = 442, role_id = 112, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[443] = {id = 443, role_id = 112, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[444] = {id = 444, role_id = 112, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[445] = {id = 445, role_id = 112, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[446] = {id = 446, role_id = 104, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[447] = {id = 447, role_id = 104, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[448] = {id = 448, role_id = 104, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[449] = {id = 449, role_id = 104, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[450] = {id = 450, role_id = 104, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[451] = {id = 451, role_id = 120, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[452] = {id = 452, role_id = 120, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[453] = {id = 453, role_id = 120, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[454] = {id = 454, role_id = 120, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[455] = {id = 455, role_id = 120, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[456] = {id = 456, role_id = 111, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[457] = {id = 457, role_id = 111, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[458] = {id = 458, role_id = 111, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[459] = {id = 459, role_id = 111, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[460] = {id = 460, role_id = 111, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[461] = {id = 461, role_id = 113, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[462] = {id = 462, role_id = 113, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[463] = {id = 463, role_id = 113, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[464] = {id = 464, role_id = 113, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[465] = {id = 465, role_id = 113, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[466] = {id = 466, role_id = 109, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[467] = {id = 467, role_id = 109, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[468] = {id = 468, role_id = 109, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[469] = {id = 469, role_id = 109, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[470] = {id = 470, role_id = 109, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[471] = {id = 471, role_id = 115, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[472] = {id = 472, role_id = 115, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[473] = {id = 473, role_id = 115, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[474] = {id = 474, role_id = 115, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[475] = {id = 475, role_id = 115, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[476] = {id = 476, role_id = 109, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[477] = {id = 477, role_id = 109, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[478] = {id = 478, role_id = 109, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[479] = {id = 479, role_id = 109, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[480] = {id = 480, role_id = 109, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[481] = {id = 481, role_id = 107, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[482] = {id = 482, role_id = 107, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[483] = {id = 483, role_id = 107, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[484] = {id = 484, role_id = 107, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[485] = {id = 485, role_id = 107, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[486] = {id = 486, role_id = 119, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[487] = {id = 487, role_id = 119, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[488] = {id = 488, role_id = 119, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[489] = {id = 489, role_id = 119, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[490] = {id = 490, role_id = 119, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[491] = {id = 491, role_id = 105, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[492] = {id = 492, role_id = 105, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[493] = {id = 493, role_id = 105, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[494] = {id = 494, role_id = 105, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[495] = {id = 495, role_id = 105, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[496] = {id = 496, role_id = 122, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[497] = {id = 497, role_id = 122, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[498] = {id = 498, role_id = 122, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[499] = {id = 499, role_id = 122, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[500] = {id = 500, role_id = 122, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[501] = {id = 501, role_id = 118, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[502] = {id = 502, role_id = 118, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[503] = {id = 503, role_id = 118, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[504] = {id = 504, role_id = 118, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[505] = {id = 505, role_id = 118, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[506] = {id = 506, role_id = 93, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[507] = {id = 507, role_id = 93, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[508] = {id = 508, role_id = 93, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[509] = {id = 509, role_id = 93, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[510] = {id = 510, role_id = 93, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[516] = {id = 516, role_id = 117, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[517] = {id = 517, role_id = 117, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[518] = {id = 518, role_id = 117, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[519] = {id = 519, role_id = 117, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[520] = {id = 520, role_id = 117, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[521] = {id = 521, role_id = 82, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[522] = {id = 522, role_id = 82, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[523] = {id = 523, role_id = 82, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[524] = {id = 524, role_id = 82, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[525] = {id = 525, role_id = 82, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[526] = {id = 526, role_id = 130, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[527] = {id = 527, role_id = 130, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[528] = {id = 528, role_id = 130, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[529] = {id = 529, role_id = 130, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[530] = {id = 530, role_id = 130, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[531] = {id = 531, role_id = 123, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[532] = {id = 532, role_id = 123, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[533] = {id = 533, role_id = 123, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[534] = {id = 534, role_id = 123, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[535] = {id = 535, role_id = 123, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[536] = {id = 536, role_id = 124, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[537] = {id = 537, role_id = 124, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[538] = {id = 538, role_id = 124, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[539] = {id = 539, role_id = 124, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[540] = {id = 540, role_id = 124, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[541] = {id = 541, role_id = 121, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[542] = {id = 542, role_id = 121, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[543] = {id = 543, role_id = 121, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[544] = {id = 544, role_id = 121, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[545] = {id = 545, role_id = 121, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[546] = {id = 546, role_id = 116, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[547] = {id = 547, role_id = 116, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[548] = {id = 548, role_id = 116, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[549] = {id = 549, role_id = 116, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[550] = {id = 550, role_id = 116, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[556] = {id = 556, role_id = 126, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[557] = {id = 557, role_id = 126, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[558] = {id = 558, role_id = 126, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[559] = {id = 559, role_id = 126, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[560] = {id = 560, role_id = 126, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
, 
[561] = {id = 561, role_id = 98, area = "Head", 
state = {"smile", "happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "Emotion,1", "touch,1", "touch,1"}
}
, 
[562] = {id = 562, role_id = 98, area = "Breast", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,2"}
}
, 
[563] = {id = 563, role_id = 98, area = "Face", 
state = {"happy", "positive", "talk"}
, 
volume_id = {"Emotion,1", "touch,3", "touch,3"}
}
, 
[564] = {id = 564, role_id = 98, area = "Skirt", 
state = {"angry", "negative"}
, 
volume_id = {"Emotion,2", "touch,4"}
}
, 
[565] = {id = 565, role_id = 98, area = "Leg", 
state = {"negative", "talk"}
, 
volume_id = {"Emotion,2", "touch,5"}
}
}
ctouchconfig.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 497, 498, 499, 500, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 516, 517, 518, 519, 520, 521, 522, 523, 524, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 549, 550, 556, 557, 558, 559, 560, 561, 562, 563, 564, 565}
return ctouchconfig

