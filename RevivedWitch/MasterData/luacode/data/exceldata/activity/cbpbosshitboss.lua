-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/activity/cbpbosshitboss.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cbpbosshitboss = {}
cbpbosshitboss.Data = {
[1] = {id = 1, bpID = 39001, nameID = 1300106, handbookID = 221, enemyHP = 80, enemyATK = 25, enemyLevel = 1, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-135"}
, 
[2] = {id = 2, bpID = 39001, nameID = 1300107, handbookID = 222, enemyHP = 90, enemyATK = 35, enemyLevel = 2, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-182"}
, 
[3] = {id = 3, bpID = 39001, nameID = 1300140, handbookID = 502, enemyHP = 112, enemyATK = 40, enemyLevel = 3, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[4] = {id = 4, bpID = 39001, nameID = 1300141, handbookID = 503, enemyHP = 144, enemyATK = 50, enemyLevel = 4, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-182"}
, 
[5] = {id = 5, bpID = 39001, nameID = 1300142, handbookID = 504, enemyHP = 176, enemyATK = 55, enemyLevel = 5, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[6] = {id = 6, bpID = 39001, nameID = 1300129, handbookID = 412, enemyHP = 208, enemyATK = 60, enemyLevel = 6, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[7] = {id = 7, bpID = 39001, nameID = 1300130, handbookID = 413, enemyHP = 240, enemyATK = 70, enemyLevel = 7, itemID = 35058, itemNum = 20, scale = 0.6, position = "0;-135"}
, 
[8] = {id = 8, bpID = 39001, nameID = 1300131, handbookID = 414, enemyHP = 272, enemyATK = 75, enemyLevel = 8, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[9] = {id = 9, bpID = 39001, nameID = 1300132, handbookID = 415, enemyHP = 304, enemyATK = 80, enemyLevel = 9, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[10] = {id = 10, bpID = 39001, nameID = 1300133, handbookID = 416, enemyHP = 336, enemyATK = 90, enemyLevel = 10, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[11] = {id = 11, bpID = 39001, nameID = 1300134, handbookID = 419, enemyHP = 372, enemyATK = 95, enemyLevel = 11, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[12] = {id = 12, bpID = 39001, nameID = 1303518, handbookID = 813, enemyHP = 408, enemyATK = 100, enemyLevel = 12, itemID = 35058, itemNum = 25, scale = 0.5, position = "0;-135"}
, 
[13] = {id = 13, bpID = 39001, nameID = 1303519, handbookID = 814, enemyHP = 440, enemyATK = 110, enemyLevel = 13, itemID = 35058, itemNum = 25, scale = 0.45, position = "0;-135"}
, 
[14] = {id = 14, bpID = 39001, nameID = 1303521, handbookID = 901, enemyHP = 472, enemyATK = 115, enemyLevel = 14, itemID = 35058, itemNum = 25, scale = 0.4, position = "0;-154"}
, 
[15] = {id = 15, bpID = 39001, nameID = 1303540, handbookID = 10003, enemyHP = 536, enemyATK = 120, enemyLevel = 16, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-135"}
, 
[16] = {id = 16, bpID = 39001, nameID = 1303530, handbookID = 11001, enemyHP = 568, enemyATK = 120, enemyLevel = 17, itemID = 35058, itemNum = 30, scale = 0.6, position = "0;-135"}
, 
[17] = {id = 17, bpID = 39001, nameID = 1303534, handbookID = 11005, enemyHP = 600, enemyATK = 120, enemyLevel = 18, itemID = 35058, itemNum = 30, scale = 0.55, position = "0;-136"}
, 
[18] = {id = 18, bpID = 39001, nameID = 1300135, handbookID = 420, enemyHP = 664, enemyATK = 120, enemyLevel = 20, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-137"}
, 
[19] = {id = 19, bpID = 39001, nameID = 1300086, handbookID = 107, enemyHP = 728, enemyATK = 130, enemyLevel = 22, itemID = 35058, itemNum = 30, scale = 0.45, position = "0;-138"}
, 
[20] = {id = 20, bpID = 39001, nameID = 1300087, handbookID = 108, enemyHP = 792, enemyATK = 140, enemyLevel = 24, itemID = 35058, itemNum = 30, scale = 0.35, position = "0;-139"}
, 
[21] = {id = 21, bpID = 39002, nameID = 1300106, handbookID = 221, enemyHP = 80, enemyATK = 25, enemyLevel = 1, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-135"}
, 
[22] = {id = 22, bpID = 39002, nameID = 1300107, handbookID = 222, enemyHP = 90, enemyATK = 35, enemyLevel = 2, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-182"}
, 
[23] = {id = 23, bpID = 39002, nameID = 1300140, handbookID = 502, enemyHP = 112, enemyATK = 40, enemyLevel = 3, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[24] = {id = 24, bpID = 39002, nameID = 1300141, handbookID = 503, enemyHP = 144, enemyATK = 50, enemyLevel = 4, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-182"}
, 
[25] = {id = 25, bpID = 39002, nameID = 1300142, handbookID = 504, enemyHP = 176, enemyATK = 55, enemyLevel = 5, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[26] = {id = 26, bpID = 39002, nameID = 1300129, handbookID = 412, enemyHP = 208, enemyATK = 60, enemyLevel = 6, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[27] = {id = 27, bpID = 39002, nameID = 1300130, handbookID = 413, enemyHP = 240, enemyATK = 70, enemyLevel = 7, itemID = 35058, itemNum = 20, scale = 0.6, position = "0;-135"}
, 
[28] = {id = 28, bpID = 39002, nameID = 1300131, handbookID = 414, enemyHP = 272, enemyATK = 75, enemyLevel = 8, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[29] = {id = 29, bpID = 39002, nameID = 1300132, handbookID = 415, enemyHP = 304, enemyATK = 80, enemyLevel = 9, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[30] = {id = 30, bpID = 39002, nameID = 1300133, handbookID = 416, enemyHP = 336, enemyATK = 90, enemyLevel = 10, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[31] = {id = 31, bpID = 39002, nameID = 1300134, handbookID = 419, enemyHP = 372, enemyATK = 95, enemyLevel = 11, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[32] = {id = 32, bpID = 39002, nameID = 1303518, handbookID = 813, enemyHP = 408, enemyATK = 100, enemyLevel = 12, itemID = 35058, itemNum = 25, scale = 0.5, position = "0;-135"}
, 
[33] = {id = 33, bpID = 39002, nameID = 1303519, handbookID = 814, enemyHP = 440, enemyATK = 110, enemyLevel = 13, itemID = 35058, itemNum = 25, scale = 0.45, position = "0;-135"}
, 
[34] = {id = 34, bpID = 39002, nameID = 1303521, handbookID = 901, enemyHP = 472, enemyATK = 115, enemyLevel = 14, itemID = 35058, itemNum = 25, scale = 0.4, position = "0;-154"}
, 
[35] = {id = 35, bpID = 39002, nameID = 1303540, handbookID = 10003, enemyHP = 536, enemyATK = 120, enemyLevel = 16, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-135"}
, 
[36] = {id = 36, bpID = 39002, nameID = 1303530, handbookID = 11001, enemyHP = 568, enemyATK = 120, enemyLevel = 17, itemID = 35058, itemNum = 30, scale = 0.6, position = "0;-135"}
, 
[37] = {id = 37, bpID = 39002, nameID = 1303534, handbookID = 11005, enemyHP = 600, enemyATK = 120, enemyLevel = 18, itemID = 35058, itemNum = 30, scale = 0.55, position = "0;-136"}
, 
[38] = {id = 38, bpID = 39002, nameID = 1300135, handbookID = 420, enemyHP = 664, enemyATK = 120, enemyLevel = 20, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-137"}
, 
[39] = {id = 39, bpID = 39002, nameID = 1300086, handbookID = 107, enemyHP = 728, enemyATK = 130, enemyLevel = 22, itemID = 35058, itemNum = 30, scale = 0.45, position = "0;-138"}
, 
[40] = {id = 40, bpID = 39002, nameID = 1300087, handbookID = 108, enemyHP = 792, enemyATK = 140, enemyLevel = 24, itemID = 35058, itemNum = 30, scale = 0.35, position = "0;-139"}
, 
[41] = {id = 41, bpID = 39003, nameID = 1300106, handbookID = 221, enemyHP = 80, enemyATK = 25, enemyLevel = 1, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-135"}
, 
[42] = {id = 42, bpID = 39003, nameID = 1300107, handbookID = 222, enemyHP = 90, enemyATK = 35, enemyLevel = 2, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-182"}
, 
[43] = {id = 43, bpID = 39003, nameID = 1300140, handbookID = 502, enemyHP = 112, enemyATK = 40, enemyLevel = 3, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[44] = {id = 44, bpID = 39003, nameID = 1300141, handbookID = 503, enemyHP = 144, enemyATK = 50, enemyLevel = 4, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-182"}
, 
[45] = {id = 45, bpID = 39003, nameID = 1300142, handbookID = 504, enemyHP = 176, enemyATK = 55, enemyLevel = 5, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[46] = {id = 46, bpID = 39003, nameID = 1300129, handbookID = 412, enemyHP = 208, enemyATK = 60, enemyLevel = 6, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[47] = {id = 47, bpID = 39003, nameID = 1300130, handbookID = 413, enemyHP = 240, enemyATK = 70, enemyLevel = 7, itemID = 35058, itemNum = 20, scale = 0.6, position = "0;-135"}
, 
[48] = {id = 48, bpID = 39003, nameID = 1300131, handbookID = 414, enemyHP = 272, enemyATK = 75, enemyLevel = 8, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[49] = {id = 49, bpID = 39003, nameID = 1300132, handbookID = 415, enemyHP = 304, enemyATK = 80, enemyLevel = 9, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[50] = {id = 50, bpID = 39003, nameID = 1300133, handbookID = 416, enemyHP = 336, enemyATK = 90, enemyLevel = 10, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[51] = {id = 51, bpID = 39003, nameID = 1300134, handbookID = 419, enemyHP = 372, enemyATK = 95, enemyLevel = 11, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[52] = {id = 52, bpID = 39003, nameID = 1303518, handbookID = 813, enemyHP = 408, enemyATK = 100, enemyLevel = 12, itemID = 35058, itemNum = 25, scale = 0.5, position = "0;-135"}
, 
[53] = {id = 53, bpID = 39003, nameID = 1303519, handbookID = 814, enemyHP = 440, enemyATK = 110, enemyLevel = 13, itemID = 35058, itemNum = 25, scale = 0.45, position = "0;-135"}
, 
[54] = {id = 54, bpID = 39003, nameID = 1303521, handbookID = 901, enemyHP = 472, enemyATK = 115, enemyLevel = 14, itemID = 35058, itemNum = 25, scale = 0.4, position = "0;-154"}
, 
[55] = {id = 55, bpID = 39003, nameID = 1303540, handbookID = 10003, enemyHP = 536, enemyATK = 120, enemyLevel = 16, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-135"}
, 
[56] = {id = 56, bpID = 39003, nameID = 1303530, handbookID = 11001, enemyHP = 568, enemyATK = 120, enemyLevel = 17, itemID = 35058, itemNum = 30, scale = 0.6, position = "0;-135"}
, 
[57] = {id = 57, bpID = 39003, nameID = 1303534, handbookID = 11005, enemyHP = 600, enemyATK = 120, enemyLevel = 18, itemID = 35058, itemNum = 30, scale = 0.55, position = "0;-136"}
, 
[58] = {id = 58, bpID = 39003, nameID = 1300135, handbookID = 420, enemyHP = 664, enemyATK = 120, enemyLevel = 20, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-137"}
, 
[59] = {id = 59, bpID = 39003, nameID = 1300086, handbookID = 107, enemyHP = 728, enemyATK = 130, enemyLevel = 22, itemID = 35058, itemNum = 30, scale = 0.45, position = "0;-138"}
, 
[60] = {id = 60, bpID = 39003, nameID = 1300087, handbookID = 108, enemyHP = 792, enemyATK = 140, enemyLevel = 24, itemID = 35058, itemNum = 30, scale = 0.35, position = "0;-139"}
, 
[61] = {id = 61, bpID = 39004, nameID = 1300106, handbookID = 221, enemyHP = 80, enemyATK = 25, enemyLevel = 1, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-135"}
, 
[62] = {id = 62, bpID = 39004, nameID = 1300107, handbookID = 222, enemyHP = 90, enemyATK = 35, enemyLevel = 2, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-182"}
, 
[63] = {id = 63, bpID = 39004, nameID = 1300140, handbookID = 502, enemyHP = 112, enemyATK = 40, enemyLevel = 3, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[64] = {id = 64, bpID = 39004, nameID = 1300141, handbookID = 503, enemyHP = 144, enemyATK = 50, enemyLevel = 4, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-182"}
, 
[65] = {id = 65, bpID = 39004, nameID = 1300142, handbookID = 504, enemyHP = 176, enemyATK = 55, enemyLevel = 5, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[66] = {id = 66, bpID = 39004, nameID = 1300129, handbookID = 412, enemyHP = 208, enemyATK = 60, enemyLevel = 6, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[67] = {id = 67, bpID = 39004, nameID = 1300130, handbookID = 413, enemyHP = 240, enemyATK = 70, enemyLevel = 7, itemID = 35058, itemNum = 20, scale = 0.6, position = "0;-135"}
, 
[68] = {id = 68, bpID = 39004, nameID = 1300131, handbookID = 414, enemyHP = 272, enemyATK = 75, enemyLevel = 8, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[69] = {id = 69, bpID = 39004, nameID = 1300132, handbookID = 415, enemyHP = 304, enemyATK = 80, enemyLevel = 9, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[70] = {id = 70, bpID = 39004, nameID = 1300133, handbookID = 416, enemyHP = 336, enemyATK = 90, enemyLevel = 10, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[71] = {id = 71, bpID = 39004, nameID = 1300134, handbookID = 419, enemyHP = 372, enemyATK = 95, enemyLevel = 11, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[72] = {id = 72, bpID = 39004, nameID = 1303518, handbookID = 813, enemyHP = 408, enemyATK = 100, enemyLevel = 12, itemID = 35058, itemNum = 25, scale = 0.5, position = "0;-135"}
, 
[73] = {id = 73, bpID = 39004, nameID = 1303519, handbookID = 814, enemyHP = 440, enemyATK = 110, enemyLevel = 13, itemID = 35058, itemNum = 25, scale = 0.45, position = "0;-135"}
, 
[74] = {id = 74, bpID = 39004, nameID = 1303521, handbookID = 901, enemyHP = 472, enemyATK = 115, enemyLevel = 14, itemID = 35058, itemNum = 25, scale = 0.4, position = "0;-154"}
, 
[75] = {id = 75, bpID = 39004, nameID = 1303540, handbookID = 10003, enemyHP = 536, enemyATK = 120, enemyLevel = 16, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-135"}
, 
[76] = {id = 76, bpID = 39004, nameID = 1303530, handbookID = 11001, enemyHP = 568, enemyATK = 120, enemyLevel = 17, itemID = 35058, itemNum = 30, scale = 0.6, position = "0;-135"}
, 
[77] = {id = 77, bpID = 39004, nameID = 1303534, handbookID = 11005, enemyHP = 600, enemyATK = 120, enemyLevel = 18, itemID = 35058, itemNum = 30, scale = 0.55, position = "0;-136"}
, 
[78] = {id = 78, bpID = 39004, nameID = 1300135, handbookID = 420, enemyHP = 664, enemyATK = 120, enemyLevel = 20, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-137"}
, 
[79] = {id = 79, bpID = 39004, nameID = 1300086, handbookID = 107, enemyHP = 728, enemyATK = 130, enemyLevel = 22, itemID = 35058, itemNum = 30, scale = 0.45, position = "0;-138"}
, 
[80] = {id = 80, bpID = 39004, nameID = 1300087, handbookID = 108, enemyHP = 792, enemyATK = 140, enemyLevel = 24, itemID = 35058, itemNum = 30, scale = 0.35, position = "0;-139"}
, 
[81] = {id = 81, bpID = 39005, nameID = 1300106, handbookID = 221, enemyHP = 80, enemyATK = 25, enemyLevel = 1, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-135"}
, 
[82] = {id = 82, bpID = 39005, nameID = 1300107, handbookID = 222, enemyHP = 90, enemyATK = 35, enemyLevel = 2, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-182"}
, 
[83] = {id = 83, bpID = 39005, nameID = 1300140, handbookID = 502, enemyHP = 112, enemyATK = 40, enemyLevel = 3, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[84] = {id = 84, bpID = 39005, nameID = 1300141, handbookID = 503, enemyHP = 144, enemyATK = 50, enemyLevel = 4, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-182"}
, 
[85] = {id = 85, bpID = 39005, nameID = 1300142, handbookID = 504, enemyHP = 176, enemyATK = 55, enemyLevel = 5, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[86] = {id = 86, bpID = 39005, nameID = 1300129, handbookID = 412, enemyHP = 208, enemyATK = 60, enemyLevel = 6, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[87] = {id = 87, bpID = 39005, nameID = 1300130, handbookID = 413, enemyHP = 240, enemyATK = 70, enemyLevel = 7, itemID = 35058, itemNum = 20, scale = 0.6, position = "0;-135"}
, 
[88] = {id = 88, bpID = 39005, nameID = 1300131, handbookID = 414, enemyHP = 272, enemyATK = 75, enemyLevel = 8, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[89] = {id = 89, bpID = 39005, nameID = 1300132, handbookID = 415, enemyHP = 304, enemyATK = 80, enemyLevel = 9, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[90] = {id = 90, bpID = 39005, nameID = 1300133, handbookID = 416, enemyHP = 336, enemyATK = 90, enemyLevel = 10, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[91] = {id = 91, bpID = 39005, nameID = 1300134, handbookID = 419, enemyHP = 372, enemyATK = 95, enemyLevel = 11, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[92] = {id = 92, bpID = 39005, nameID = 1303518, handbookID = 813, enemyHP = 408, enemyATK = 100, enemyLevel = 12, itemID = 35058, itemNum = 25, scale = 0.5, position = "0;-135"}
, 
[93] = {id = 93, bpID = 39005, nameID = 1303519, handbookID = 814, enemyHP = 440, enemyATK = 110, enemyLevel = 13, itemID = 35058, itemNum = 25, scale = 0.45, position = "0;-135"}
, 
[94] = {id = 94, bpID = 39005, nameID = 1303521, handbookID = 901, enemyHP = 472, enemyATK = 115, enemyLevel = 14, itemID = 35058, itemNum = 25, scale = 0.4, position = "0;-154"}
, 
[95] = {id = 95, bpID = 39005, nameID = 1303540, handbookID = 10003, enemyHP = 536, enemyATK = 120, enemyLevel = 16, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-135"}
, 
[96] = {id = 96, bpID = 39005, nameID = 1303530, handbookID = 11001, enemyHP = 568, enemyATK = 120, enemyLevel = 17, itemID = 35058, itemNum = 30, scale = 0.6, position = "0;-135"}
, 
[97] = {id = 97, bpID = 39005, nameID = 1303534, handbookID = 11005, enemyHP = 600, enemyATK = 120, enemyLevel = 18, itemID = 35058, itemNum = 30, scale = 0.55, position = "0;-136"}
, 
[98] = {id = 98, bpID = 39005, nameID = 1300135, handbookID = 420, enemyHP = 664, enemyATK = 120, enemyLevel = 20, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-137"}
, 
[99] = {id = 99, bpID = 39005, nameID = 1300086, handbookID = 107, enemyHP = 728, enemyATK = 130, enemyLevel = 22, itemID = 35058, itemNum = 30, scale = 0.45, position = "0;-138"}
, 
[100] = {id = 100, bpID = 39005, nameID = 1300087, handbookID = 108, enemyHP = 792, enemyATK = 140, enemyLevel = 24, itemID = 35058, itemNum = 30, scale = 0.35, position = "0;-139"}
, 
[101] = {id = 101, bpID = 39006, nameID = 1300106, handbookID = 221, enemyHP = 80, enemyATK = 25, enemyLevel = 1, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-135"}
, 
[102] = {id = 102, bpID = 39006, nameID = 1300107, handbookID = 222, enemyHP = 90, enemyATK = 35, enemyLevel = 2, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-182"}
, 
[103] = {id = 103, bpID = 39006, nameID = 1300140, handbookID = 502, enemyHP = 112, enemyATK = 40, enemyLevel = 3, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[104] = {id = 104, bpID = 39006, nameID = 1300141, handbookID = 503, enemyHP = 144, enemyATK = 50, enemyLevel = 4, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-182"}
, 
[105] = {id = 105, bpID = 39006, nameID = 1300142, handbookID = 504, enemyHP = 176, enemyATK = 55, enemyLevel = 5, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[106] = {id = 106, bpID = 39006, nameID = 1300129, handbookID = 412, enemyHP = 208, enemyATK = 60, enemyLevel = 6, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[107] = {id = 107, bpID = 39006, nameID = 1300130, handbookID = 413, enemyHP = 240, enemyATK = 70, enemyLevel = 7, itemID = 35058, itemNum = 20, scale = 0.6, position = "0;-135"}
, 
[108] = {id = 108, bpID = 39006, nameID = 1300131, handbookID = 414, enemyHP = 272, enemyATK = 75, enemyLevel = 8, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[109] = {id = 109, bpID = 39006, nameID = 1300132, handbookID = 415, enemyHP = 304, enemyATK = 80, enemyLevel = 9, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[110] = {id = 110, bpID = 39006, nameID = 1300133, handbookID = 416, enemyHP = 336, enemyATK = 90, enemyLevel = 10, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[111] = {id = 111, bpID = 39006, nameID = 1300134, handbookID = 419, enemyHP = 372, enemyATK = 95, enemyLevel = 11, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[112] = {id = 112, bpID = 39006, nameID = 1303518, handbookID = 813, enemyHP = 408, enemyATK = 100, enemyLevel = 12, itemID = 35058, itemNum = 25, scale = 0.5, position = "0;-135"}
, 
[113] = {id = 113, bpID = 39006, nameID = 1303519, handbookID = 814, enemyHP = 440, enemyATK = 110, enemyLevel = 13, itemID = 35058, itemNum = 25, scale = 0.45, position = "0;-135"}
, 
[114] = {id = 114, bpID = 39006, nameID = 1303521, handbookID = 901, enemyHP = 472, enemyATK = 115, enemyLevel = 14, itemID = 35058, itemNum = 25, scale = 0.4, position = "0;-154"}
, 
[115] = {id = 115, bpID = 39006, nameID = 1303540, handbookID = 10003, enemyHP = 536, enemyATK = 120, enemyLevel = 16, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-135"}
, 
[116] = {id = 116, bpID = 39006, nameID = 1303530, handbookID = 11001, enemyHP = 568, enemyATK = 120, enemyLevel = 17, itemID = 35058, itemNum = 30, scale = 0.6, position = "0;-135"}
, 
[117] = {id = 117, bpID = 39006, nameID = 1303534, handbookID = 11005, enemyHP = 600, enemyATK = 120, enemyLevel = 18, itemID = 35058, itemNum = 30, scale = 0.55, position = "0;-136"}
, 
[118] = {id = 118, bpID = 39006, nameID = 1300135, handbookID = 420, enemyHP = 664, enemyATK = 120, enemyLevel = 20, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-137"}
, 
[119] = {id = 119, bpID = 39006, nameID = 1300086, handbookID = 107, enemyHP = 728, enemyATK = 130, enemyLevel = 22, itemID = 35058, itemNum = 30, scale = 0.45, position = "0;-138"}
, 
[120] = {id = 120, bpID = 39006, nameID = 1300087, handbookID = 108, enemyHP = 792, enemyATK = 140, enemyLevel = 24, itemID = 35058, itemNum = 30, scale = 0.35, position = "0;-139"}
, 
[121] = {id = 121, bpID = 39007, nameID = 1300106, handbookID = 221, enemyHP = 80, enemyATK = 25, enemyLevel = 1, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-135"}
, 
[122] = {id = 122, bpID = 39007, nameID = 1300107, handbookID = 222, enemyHP = 90, enemyATK = 35, enemyLevel = 2, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-182"}
, 
[123] = {id = 123, bpID = 39007, nameID = 1300140, handbookID = 502, enemyHP = 112, enemyATK = 40, enemyLevel = 3, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[124] = {id = 124, bpID = 39007, nameID = 1300141, handbookID = 503, enemyHP = 144, enemyATK = 50, enemyLevel = 4, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-182"}
, 
[125] = {id = 125, bpID = 39007, nameID = 1300142, handbookID = 504, enemyHP = 176, enemyATK = 55, enemyLevel = 5, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[126] = {id = 126, bpID = 39007, nameID = 1300129, handbookID = 412, enemyHP = 208, enemyATK = 60, enemyLevel = 6, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[127] = {id = 127, bpID = 39007, nameID = 1300130, handbookID = 413, enemyHP = 240, enemyATK = 70, enemyLevel = 7, itemID = 35058, itemNum = 20, scale = 0.6, position = "0;-135"}
, 
[128] = {id = 128, bpID = 39007, nameID = 1300131, handbookID = 414, enemyHP = 272, enemyATK = 75, enemyLevel = 8, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[129] = {id = 129, bpID = 39007, nameID = 1300132, handbookID = 415, enemyHP = 304, enemyATK = 80, enemyLevel = 9, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[130] = {id = 130, bpID = 39007, nameID = 1300133, handbookID = 416, enemyHP = 336, enemyATK = 90, enemyLevel = 10, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[131] = {id = 131, bpID = 39007, nameID = 1300134, handbookID = 419, enemyHP = 372, enemyATK = 95, enemyLevel = 11, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[132] = {id = 132, bpID = 39007, nameID = 1303518, handbookID = 813, enemyHP = 408, enemyATK = 100, enemyLevel = 12, itemID = 35058, itemNum = 25, scale = 0.5, position = "0;-135"}
, 
[133] = {id = 133, bpID = 39007, nameID = 1303519, handbookID = 814, enemyHP = 440, enemyATK = 110, enemyLevel = 13, itemID = 35058, itemNum = 25, scale = 0.45, position = "0;-135"}
, 
[134] = {id = 134, bpID = 39007, nameID = 1303521, handbookID = 901, enemyHP = 472, enemyATK = 115, enemyLevel = 14, itemID = 35058, itemNum = 25, scale = 0.4, position = "0;-154"}
, 
[135] = {id = 135, bpID = 39007, nameID = 1303540, handbookID = 10003, enemyHP = 536, enemyATK = 120, enemyLevel = 16, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-135"}
, 
[136] = {id = 136, bpID = 39007, nameID = 1303530, handbookID = 11001, enemyHP = 568, enemyATK = 120, enemyLevel = 17, itemID = 35058, itemNum = 30, scale = 0.6, position = "0;-135"}
, 
[137] = {id = 137, bpID = 39007, nameID = 1303534, handbookID = 11005, enemyHP = 600, enemyATK = 120, enemyLevel = 18, itemID = 35058, itemNum = 30, scale = 0.55, position = "0;-136"}
, 
[138] = {id = 138, bpID = 39007, nameID = 1300135, handbookID = 420, enemyHP = 664, enemyATK = 120, enemyLevel = 20, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-137"}
, 
[139] = {id = 139, bpID = 39007, nameID = 1300086, handbookID = 107, enemyHP = 728, enemyATK = 130, enemyLevel = 22, itemID = 35058, itemNum = 30, scale = 0.45, position = "0;-138"}
, 
[140] = {id = 140, bpID = 39007, nameID = 1300087, handbookID = 108, enemyHP = 792, enemyATK = 140, enemyLevel = 24, itemID = 35058, itemNum = 30, scale = 0.35, position = "0;-139"}
, 
[141] = {id = 141, bpID = 39008, nameID = 1300106, handbookID = 221, enemyHP = 80, enemyATK = 25, enemyLevel = 1, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-135"}
, 
[142] = {id = 142, bpID = 39008, nameID = 1300107, handbookID = 222, enemyHP = 90, enemyATK = 35, enemyLevel = 2, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-182"}
, 
[143] = {id = 143, bpID = 39008, nameID = 1300140, handbookID = 502, enemyHP = 112, enemyATK = 40, enemyLevel = 3, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[144] = {id = 144, bpID = 39008, nameID = 1300141, handbookID = 503, enemyHP = 144, enemyATK = 50, enemyLevel = 4, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-182"}
, 
[145] = {id = 145, bpID = 39008, nameID = 1300142, handbookID = 504, enemyHP = 176, enemyATK = 55, enemyLevel = 5, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[146] = {id = 146, bpID = 39008, nameID = 1300129, handbookID = 412, enemyHP = 208, enemyATK = 60, enemyLevel = 6, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[147] = {id = 147, bpID = 39008, nameID = 1300130, handbookID = 413, enemyHP = 240, enemyATK = 70, enemyLevel = 7, itemID = 35058, itemNum = 20, scale = 0.6, position = "0;-135"}
, 
[148] = {id = 148, bpID = 39008, nameID = 1300131, handbookID = 414, enemyHP = 272, enemyATK = 75, enemyLevel = 8, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[149] = {id = 149, bpID = 39008, nameID = 1300132, handbookID = 415, enemyHP = 304, enemyATK = 80, enemyLevel = 9, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[150] = {id = 150, bpID = 39008, nameID = 1300133, handbookID = 416, enemyHP = 336, enemyATK = 90, enemyLevel = 10, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[151] = {id = 151, bpID = 39008, nameID = 1300134, handbookID = 419, enemyHP = 372, enemyATK = 95, enemyLevel = 11, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[152] = {id = 152, bpID = 39008, nameID = 1303518, handbookID = 813, enemyHP = 408, enemyATK = 100, enemyLevel = 12, itemID = 35058, itemNum = 25, scale = 0.5, position = "0;-135"}
, 
[153] = {id = 153, bpID = 39008, nameID = 1303519, handbookID = 814, enemyHP = 440, enemyATK = 110, enemyLevel = 13, itemID = 35058, itemNum = 25, scale = 0.45, position = "0;-135"}
, 
[154] = {id = 154, bpID = 39008, nameID = 1303521, handbookID = 901, enemyHP = 472, enemyATK = 115, enemyLevel = 14, itemID = 35058, itemNum = 25, scale = 0.4, position = "0;-154"}
, 
[155] = {id = 155, bpID = 39008, nameID = 1303540, handbookID = 10003, enemyHP = 536, enemyATK = 120, enemyLevel = 16, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-135"}
, 
[156] = {id = 156, bpID = 39008, nameID = 1303530, handbookID = 11001, enemyHP = 568, enemyATK = 120, enemyLevel = 17, itemID = 35058, itemNum = 30, scale = 0.6, position = "0;-135"}
, 
[157] = {id = 157, bpID = 39008, nameID = 1303534, handbookID = 11005, enemyHP = 600, enemyATK = 120, enemyLevel = 18, itemID = 35058, itemNum = 30, scale = 0.55, position = "0;-136"}
, 
[158] = {id = 158, bpID = 39008, nameID = 1300135, handbookID = 420, enemyHP = 664, enemyATK = 120, enemyLevel = 20, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-137"}
, 
[159] = {id = 159, bpID = 39008, nameID = 1300086, handbookID = 107, enemyHP = 728, enemyATK = 130, enemyLevel = 22, itemID = 35058, itemNum = 30, scale = 0.45, position = "0;-138"}
, 
[160] = {id = 160, bpID = 39008, nameID = 1300087, handbookID = 108, enemyHP = 792, enemyATK = 140, enemyLevel = 24, itemID = 35058, itemNum = 30, scale = 0.35, position = "0;-139"}
, 
[161] = {id = 161, bpID = 39009, nameID = 1300106, handbookID = 221, enemyHP = 80, enemyATK = 25, enemyLevel = 1, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-135"}
, 
[162] = {id = 162, bpID = 39009, nameID = 1300107, handbookID = 222, enemyHP = 90, enemyATK = 35, enemyLevel = 2, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-182"}
, 
[163] = {id = 163, bpID = 39009, nameID = 1300140, handbookID = 502, enemyHP = 112, enemyATK = 40, enemyLevel = 3, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[164] = {id = 164, bpID = 39009, nameID = 1300141, handbookID = 503, enemyHP = 144, enemyATK = 50, enemyLevel = 4, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-182"}
, 
[165] = {id = 165, bpID = 39009, nameID = 1300142, handbookID = 504, enemyHP = 176, enemyATK = 55, enemyLevel = 5, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[166] = {id = 166, bpID = 39009, nameID = 1300129, handbookID = 412, enemyHP = 208, enemyATK = 60, enemyLevel = 6, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[167] = {id = 167, bpID = 39009, nameID = 1300130, handbookID = 413, enemyHP = 240, enemyATK = 70, enemyLevel = 7, itemID = 35058, itemNum = 20, scale = 0.6, position = "0;-135"}
, 
[168] = {id = 168, bpID = 39009, nameID = 1300131, handbookID = 414, enemyHP = 272, enemyATK = 75, enemyLevel = 8, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[169] = {id = 169, bpID = 39009, nameID = 1300132, handbookID = 415, enemyHP = 304, enemyATK = 80, enemyLevel = 9, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[170] = {id = 170, bpID = 39009, nameID = 1300133, handbookID = 416, enemyHP = 336, enemyATK = 90, enemyLevel = 10, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[171] = {id = 171, bpID = 39009, nameID = 1300134, handbookID = 419, enemyHP = 372, enemyATK = 95, enemyLevel = 11, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[172] = {id = 172, bpID = 39009, nameID = 1303518, handbookID = 813, enemyHP = 408, enemyATK = 100, enemyLevel = 12, itemID = 35058, itemNum = 25, scale = 0.5, position = "0;-135"}
, 
[173] = {id = 173, bpID = 39009, nameID = 1303519, handbookID = 814, enemyHP = 440, enemyATK = 110, enemyLevel = 13, itemID = 35058, itemNum = 25, scale = 0.45, position = "0;-135"}
, 
[174] = {id = 174, bpID = 39009, nameID = 1303521, handbookID = 901, enemyHP = 472, enemyATK = 115, enemyLevel = 14, itemID = 35058, itemNum = 25, scale = 0.4, position = "0;-154"}
, 
[175] = {id = 175, bpID = 39009, nameID = 1303540, handbookID = 10003, enemyHP = 536, enemyATK = 120, enemyLevel = 16, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-135"}
, 
[176] = {id = 176, bpID = 39009, nameID = 1303530, handbookID = 11001, enemyHP = 568, enemyATK = 120, enemyLevel = 17, itemID = 35058, itemNum = 30, scale = 0.6, position = "0;-135"}
, 
[177] = {id = 177, bpID = 39009, nameID = 1303534, handbookID = 11005, enemyHP = 600, enemyATK = 120, enemyLevel = 18, itemID = 35058, itemNum = 30, scale = 0.55, position = "0;-136"}
, 
[178] = {id = 178, bpID = 39009, nameID = 1300135, handbookID = 420, enemyHP = 664, enemyATK = 120, enemyLevel = 20, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-137"}
, 
[179] = {id = 179, bpID = 39009, nameID = 1300086, handbookID = 107, enemyHP = 728, enemyATK = 130, enemyLevel = 22, itemID = 35058, itemNum = 30, scale = 0.45, position = "0;-138"}
, 
[180] = {id = 180, bpID = 39009, nameID = 1300087, handbookID = 108, enemyHP = 792, enemyATK = 140, enemyLevel = 24, itemID = 35058, itemNum = 30, scale = 0.35, position = "0;-139"}
, 
[181] = {id = 181, bpID = 39010, nameID = 1300106, handbookID = 221, enemyHP = 80, enemyATK = 25, enemyLevel = 1, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-135"}
, 
[182] = {id = 182, bpID = 39010, nameID = 1300107, handbookID = 222, enemyHP = 90, enemyATK = 35, enemyLevel = 2, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-182"}
, 
[183] = {id = 183, bpID = 39010, nameID = 1300140, handbookID = 502, enemyHP = 112, enemyATK = 40, enemyLevel = 3, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[184] = {id = 184, bpID = 39010, nameID = 1300141, handbookID = 503, enemyHP = 144, enemyATK = 50, enemyLevel = 4, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-182"}
, 
[185] = {id = 185, bpID = 39010, nameID = 1300142, handbookID = 504, enemyHP = 176, enemyATK = 55, enemyLevel = 5, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[186] = {id = 186, bpID = 39010, nameID = 1300129, handbookID = 412, enemyHP = 208, enemyATK = 60, enemyLevel = 6, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[187] = {id = 187, bpID = 39010, nameID = 1300130, handbookID = 413, enemyHP = 240, enemyATK = 70, enemyLevel = 7, itemID = 35058, itemNum = 20, scale = 0.6, position = "0;-135"}
, 
[188] = {id = 188, bpID = 39010, nameID = 1300131, handbookID = 414, enemyHP = 272, enemyATK = 75, enemyLevel = 8, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[189] = {id = 189, bpID = 39010, nameID = 1300132, handbookID = 415, enemyHP = 304, enemyATK = 80, enemyLevel = 9, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[190] = {id = 190, bpID = 39010, nameID = 1300133, handbookID = 416, enemyHP = 336, enemyATK = 90, enemyLevel = 10, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[191] = {id = 191, bpID = 39010, nameID = 1300134, handbookID = 419, enemyHP = 372, enemyATK = 95, enemyLevel = 11, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[192] = {id = 192, bpID = 39010, nameID = 1303518, handbookID = 813, enemyHP = 408, enemyATK = 100, enemyLevel = 12, itemID = 35058, itemNum = 25, scale = 0.5, position = "0;-135"}
, 
[193] = {id = 193, bpID = 39010, nameID = 1303519, handbookID = 814, enemyHP = 440, enemyATK = 110, enemyLevel = 13, itemID = 35058, itemNum = 25, scale = 0.45, position = "0;-135"}
, 
[194] = {id = 194, bpID = 39010, nameID = 1303521, handbookID = 901, enemyHP = 472, enemyATK = 115, enemyLevel = 14, itemID = 35058, itemNum = 25, scale = 0.4, position = "0;-154"}
, 
[195] = {id = 195, bpID = 39010, nameID = 1303540, handbookID = 10003, enemyHP = 536, enemyATK = 120, enemyLevel = 16, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-135"}
, 
[196] = {id = 196, bpID = 39010, nameID = 1303530, handbookID = 11001, enemyHP = 568, enemyATK = 120, enemyLevel = 17, itemID = 35058, itemNum = 30, scale = 0.6, position = "0;-135"}
, 
[197] = {id = 197, bpID = 39010, nameID = 1303534, handbookID = 11005, enemyHP = 600, enemyATK = 120, enemyLevel = 18, itemID = 35058, itemNum = 30, scale = 0.55, position = "0;-136"}
, 
[198] = {id = 198, bpID = 39010, nameID = 1300135, handbookID = 420, enemyHP = 664, enemyATK = 120, enemyLevel = 20, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-137"}
, 
[199] = {id = 199, bpID = 39010, nameID = 1300086, handbookID = 107, enemyHP = 728, enemyATK = 130, enemyLevel = 22, itemID = 35058, itemNum = 30, scale = 0.45, position = "0;-138"}
, 
[200] = {id = 200, bpID = 39010, nameID = 1300087, handbookID = 108, enemyHP = 792, enemyATK = 140, enemyLevel = 24, itemID = 35058, itemNum = 30, scale = 0.35, position = "0;-139"}
, 
[201] = {id = 201, bpID = 39011, nameID = 1300106, handbookID = 221, enemyHP = 80, enemyATK = 25, enemyLevel = 1, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-135"}
, 
[202] = {id = 202, bpID = 39011, nameID = 1300107, handbookID = 222, enemyHP = 90, enemyATK = 35, enemyLevel = 2, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-182"}
, 
[203] = {id = 203, bpID = 39011, nameID = 1300140, handbookID = 502, enemyHP = 112, enemyATK = 40, enemyLevel = 3, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[204] = {id = 204, bpID = 39011, nameID = 1300141, handbookID = 503, enemyHP = 144, enemyATK = 50, enemyLevel = 4, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-182"}
, 
[205] = {id = 205, bpID = 39011, nameID = 1300142, handbookID = 504, enemyHP = 176, enemyATK = 55, enemyLevel = 5, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[206] = {id = 206, bpID = 39011, nameID = 1300129, handbookID = 412, enemyHP = 208, enemyATK = 60, enemyLevel = 6, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[207] = {id = 207, bpID = 39011, nameID = 1300130, handbookID = 413, enemyHP = 240, enemyATK = 70, enemyLevel = 7, itemID = 35058, itemNum = 20, scale = 0.6, position = "0;-135"}
, 
[208] = {id = 208, bpID = 39011, nameID = 1300131, handbookID = 414, enemyHP = 272, enemyATK = 75, enemyLevel = 8, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[209] = {id = 209, bpID = 39011, nameID = 1300132, handbookID = 415, enemyHP = 304, enemyATK = 80, enemyLevel = 9, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[210] = {id = 210, bpID = 39011, nameID = 1300133, handbookID = 416, enemyHP = 336, enemyATK = 90, enemyLevel = 10, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[211] = {id = 211, bpID = 39011, nameID = 1300134, handbookID = 419, enemyHP = 372, enemyATK = 95, enemyLevel = 11, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[212] = {id = 212, bpID = 39011, nameID = 1303518, handbookID = 813, enemyHP = 408, enemyATK = 100, enemyLevel = 12, itemID = 35058, itemNum = 25, scale = 0.5, position = "0;-135"}
, 
[213] = {id = 213, bpID = 39011, nameID = 1303519, handbookID = 814, enemyHP = 440, enemyATK = 110, enemyLevel = 13, itemID = 35058, itemNum = 25, scale = 0.45, position = "0;-135"}
, 
[214] = {id = 214, bpID = 39011, nameID = 1303521, handbookID = 901, enemyHP = 472, enemyATK = 115, enemyLevel = 14, itemID = 35058, itemNum = 25, scale = 0.4, position = "0;-154"}
, 
[215] = {id = 215, bpID = 39011, nameID = 1303540, handbookID = 10003, enemyHP = 536, enemyATK = 120, enemyLevel = 16, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-135"}
, 
[216] = {id = 216, bpID = 39011, nameID = 1303530, handbookID = 11001, enemyHP = 568, enemyATK = 120, enemyLevel = 17, itemID = 35058, itemNum = 30, scale = 0.6, position = "0;-135"}
, 
[217] = {id = 217, bpID = 39011, nameID = 1303534, handbookID = 11005, enemyHP = 600, enemyATK = 120, enemyLevel = 18, itemID = 35058, itemNum = 30, scale = 0.55, position = "0;-136"}
, 
[218] = {id = 218, bpID = 39011, nameID = 1300135, handbookID = 420, enemyHP = 664, enemyATK = 120, enemyLevel = 20, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-137"}
, 
[219] = {id = 219, bpID = 39011, nameID = 1300086, handbookID = 107, enemyHP = 728, enemyATK = 130, enemyLevel = 22, itemID = 35058, itemNum = 30, scale = 0.45, position = "0;-138"}
, 
[220] = {id = 220, bpID = 39011, nameID = 1300087, handbookID = 108, enemyHP = 792, enemyATK = 140, enemyLevel = 24, itemID = 35058, itemNum = 30, scale = 0.35, position = "0;-139"}
, 
[221] = {id = 221, bpID = 39012, nameID = 1300106, handbookID = 221, enemyHP = 80, enemyATK = 25, enemyLevel = 1, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-135"}
, 
[222] = {id = 222, bpID = 39012, nameID = 1300107, handbookID = 222, enemyHP = 90, enemyATK = 35, enemyLevel = 2, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-182"}
, 
[223] = {id = 223, bpID = 39012, nameID = 1300140, handbookID = 502, enemyHP = 112, enemyATK = 40, enemyLevel = 3, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[224] = {id = 224, bpID = 39012, nameID = 1300141, handbookID = 503, enemyHP = 144, enemyATK = 50, enemyLevel = 4, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-182"}
, 
[225] = {id = 225, bpID = 39012, nameID = 1300142, handbookID = 504, enemyHP = 176, enemyATK = 55, enemyLevel = 5, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[226] = {id = 226, bpID = 39012, nameID = 1300129, handbookID = 412, enemyHP = 208, enemyATK = 60, enemyLevel = 6, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[227] = {id = 227, bpID = 39012, nameID = 1300130, handbookID = 413, enemyHP = 240, enemyATK = 70, enemyLevel = 7, itemID = 35058, itemNum = 20, scale = 0.6, position = "0;-135"}
, 
[228] = {id = 228, bpID = 39012, nameID = 1300131, handbookID = 414, enemyHP = 272, enemyATK = 75, enemyLevel = 8, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[229] = {id = 229, bpID = 39012, nameID = 1300132, handbookID = 415, enemyHP = 304, enemyATK = 80, enemyLevel = 9, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[230] = {id = 230, bpID = 39012, nameID = 1300133, handbookID = 416, enemyHP = 336, enemyATK = 90, enemyLevel = 10, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[231] = {id = 231, bpID = 39012, nameID = 1300134, handbookID = 419, enemyHP = 372, enemyATK = 95, enemyLevel = 11, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[232] = {id = 232, bpID = 39012, nameID = 1303518, handbookID = 813, enemyHP = 408, enemyATK = 100, enemyLevel = 12, itemID = 35058, itemNum = 25, scale = 0.5, position = "0;-135"}
, 
[233] = {id = 233, bpID = 39012, nameID = 1303519, handbookID = 814, enemyHP = 440, enemyATK = 110, enemyLevel = 13, itemID = 35058, itemNum = 25, scale = 0.45, position = "0;-135"}
, 
[234] = {id = 234, bpID = 39012, nameID = 1303521, handbookID = 901, enemyHP = 472, enemyATK = 115, enemyLevel = 14, itemID = 35058, itemNum = 25, scale = 0.4, position = "0;-154"}
, 
[235] = {id = 235, bpID = 39012, nameID = 1303540, handbookID = 10003, enemyHP = 536, enemyATK = 120, enemyLevel = 16, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-135"}
, 
[236] = {id = 236, bpID = 39012, nameID = 1303530, handbookID = 11001, enemyHP = 568, enemyATK = 120, enemyLevel = 17, itemID = 35058, itemNum = 30, scale = 0.6, position = "0;-135"}
, 
[237] = {id = 237, bpID = 39012, nameID = 1303534, handbookID = 11005, enemyHP = 600, enemyATK = 120, enemyLevel = 18, itemID = 35058, itemNum = 30, scale = 0.55, position = "0;-136"}
, 
[238] = {id = 238, bpID = 39012, nameID = 1300135, handbookID = 420, enemyHP = 664, enemyATK = 120, enemyLevel = 20, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-137"}
, 
[239] = {id = 239, bpID = 39012, nameID = 1300086, handbookID = 107, enemyHP = 728, enemyATK = 130, enemyLevel = 22, itemID = 35058, itemNum = 30, scale = 0.45, position = "0;-138"}
, 
[240] = {id = 240, bpID = 39012, nameID = 1300087, handbookID = 108, enemyHP = 792, enemyATK = 140, enemyLevel = 24, itemID = 35058, itemNum = 30, scale = 0.35, position = "0;-139"}
, 
[241] = {id = 241, bpID = 39013, nameID = 1300106, handbookID = 221, enemyHP = 80, enemyATK = 25, enemyLevel = 1, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-135"}
, 
[242] = {id = 242, bpID = 39013, nameID = 1300107, handbookID = 222, enemyHP = 90, enemyATK = 35, enemyLevel = 2, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-182"}
, 
[243] = {id = 243, bpID = 39013, nameID = 1300140, handbookID = 502, enemyHP = 112, enemyATK = 40, enemyLevel = 3, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[244] = {id = 244, bpID = 39013, nameID = 1300141, handbookID = 503, enemyHP = 144, enemyATK = 50, enemyLevel = 4, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-182"}
, 
[245] = {id = 245, bpID = 39013, nameID = 1300142, handbookID = 504, enemyHP = 176, enemyATK = 55, enemyLevel = 5, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[246] = {id = 246, bpID = 39013, nameID = 1300129, handbookID = 412, enemyHP = 208, enemyATK = 60, enemyLevel = 6, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[247] = {id = 247, bpID = 39013, nameID = 1300130, handbookID = 413, enemyHP = 240, enemyATK = 70, enemyLevel = 7, itemID = 35058, itemNum = 20, scale = 0.6, position = "0;-135"}
, 
[248] = {id = 248, bpID = 39013, nameID = 1300131, handbookID = 414, enemyHP = 272, enemyATK = 75, enemyLevel = 8, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[249] = {id = 249, bpID = 39013, nameID = 1300132, handbookID = 415, enemyHP = 304, enemyATK = 80, enemyLevel = 9, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[250] = {id = 250, bpID = 39013, nameID = 1300133, handbookID = 416, enemyHP = 336, enemyATK = 90, enemyLevel = 10, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[251] = {id = 251, bpID = 39013, nameID = 1300134, handbookID = 419, enemyHP = 372, enemyATK = 95, enemyLevel = 11, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[252] = {id = 252, bpID = 39013, nameID = 1303518, handbookID = 813, enemyHP = 408, enemyATK = 100, enemyLevel = 12, itemID = 35058, itemNum = 25, scale = 0.5, position = "0;-135"}
, 
[253] = {id = 253, bpID = 39013, nameID = 1303519, handbookID = 814, enemyHP = 440, enemyATK = 110, enemyLevel = 13, itemID = 35058, itemNum = 25, scale = 0.45, position = "0;-135"}
, 
[254] = {id = 254, bpID = 39013, nameID = 1303521, handbookID = 901, enemyHP = 472, enemyATK = 115, enemyLevel = 14, itemID = 35058, itemNum = 25, scale = 0.4, position = "0;-154"}
, 
[255] = {id = 255, bpID = 39013, nameID = 1303540, handbookID = 10003, enemyHP = 536, enemyATK = 120, enemyLevel = 16, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-135"}
, 
[256] = {id = 256, bpID = 39013, nameID = 1303530, handbookID = 11001, enemyHP = 568, enemyATK = 120, enemyLevel = 17, itemID = 35058, itemNum = 30, scale = 0.6, position = "0;-135"}
, 
[257] = {id = 257, bpID = 39013, nameID = 1303534, handbookID = 11005, enemyHP = 600, enemyATK = 120, enemyLevel = 18, itemID = 35058, itemNum = 30, scale = 0.55, position = "0;-136"}
, 
[258] = {id = 258, bpID = 39013, nameID = 1300135, handbookID = 420, enemyHP = 664, enemyATK = 120, enemyLevel = 20, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-137"}
, 
[259] = {id = 259, bpID = 39013, nameID = 1300086, handbookID = 107, enemyHP = 728, enemyATK = 130, enemyLevel = 22, itemID = 35058, itemNum = 30, scale = 0.45, position = "0;-138"}
, 
[260] = {id = 260, bpID = 39013, nameID = 1300087, handbookID = 108, enemyHP = 792, enemyATK = 140, enemyLevel = 24, itemID = 35058, itemNum = 30, scale = 0.35, position = "0;-139"}
, 
[261] = {id = 261, bpID = 39014, nameID = 1300106, handbookID = 221, enemyHP = 80, enemyATK = 25, enemyLevel = 1, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-135"}
, 
[262] = {id = 262, bpID = 39014, nameID = 1300107, handbookID = 222, enemyHP = 90, enemyATK = 35, enemyLevel = 2, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-182"}
, 
[263] = {id = 263, bpID = 39014, nameID = 1300140, handbookID = 502, enemyHP = 112, enemyATK = 40, enemyLevel = 3, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[264] = {id = 264, bpID = 39014, nameID = 1300141, handbookID = 503, enemyHP = 144, enemyATK = 50, enemyLevel = 4, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-182"}
, 
[265] = {id = 265, bpID = 39014, nameID = 1300142, handbookID = 504, enemyHP = 176, enemyATK = 55, enemyLevel = 5, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[266] = {id = 266, bpID = 39014, nameID = 1300129, handbookID = 412, enemyHP = 208, enemyATK = 60, enemyLevel = 6, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[267] = {id = 267, bpID = 39014, nameID = 1300130, handbookID = 413, enemyHP = 240, enemyATK = 70, enemyLevel = 7, itemID = 35058, itemNum = 20, scale = 0.6, position = "0;-135"}
, 
[268] = {id = 268, bpID = 39014, nameID = 1300131, handbookID = 414, enemyHP = 272, enemyATK = 75, enemyLevel = 8, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[269] = {id = 269, bpID = 39014, nameID = 1300132, handbookID = 415, enemyHP = 304, enemyATK = 80, enemyLevel = 9, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[270] = {id = 270, bpID = 39014, nameID = 1300133, handbookID = 416, enemyHP = 336, enemyATK = 90, enemyLevel = 10, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[271] = {id = 271, bpID = 39014, nameID = 1300134, handbookID = 419, enemyHP = 372, enemyATK = 95, enemyLevel = 11, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[272] = {id = 272, bpID = 39014, nameID = 1303518, handbookID = 813, enemyHP = 408, enemyATK = 100, enemyLevel = 12, itemID = 35058, itemNum = 25, scale = 0.5, position = "0;-135"}
, 
[273] = {id = 273, bpID = 39014, nameID = 1303519, handbookID = 814, enemyHP = 440, enemyATK = 110, enemyLevel = 13, itemID = 35058, itemNum = 25, scale = 0.45, position = "0;-135"}
, 
[274] = {id = 274, bpID = 39014, nameID = 1303521, handbookID = 901, enemyHP = 472, enemyATK = 115, enemyLevel = 14, itemID = 35058, itemNum = 25, scale = 0.4, position = "0;-154"}
, 
[275] = {id = 275, bpID = 39014, nameID = 1303540, handbookID = 10003, enemyHP = 536, enemyATK = 120, enemyLevel = 16, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-135"}
, 
[276] = {id = 276, bpID = 39014, nameID = 1303530, handbookID = 11001, enemyHP = 568, enemyATK = 120, enemyLevel = 17, itemID = 35058, itemNum = 30, scale = 0.6, position = "0;-135"}
, 
[277] = {id = 277, bpID = 39014, nameID = 1303534, handbookID = 11005, enemyHP = 600, enemyATK = 120, enemyLevel = 18, itemID = 35058, itemNum = 30, scale = 0.55, position = "0;-136"}
, 
[278] = {id = 278, bpID = 39014, nameID = 1300135, handbookID = 420, enemyHP = 664, enemyATK = 120, enemyLevel = 20, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-137"}
, 
[279] = {id = 279, bpID = 39014, nameID = 1300086, handbookID = 107, enemyHP = 728, enemyATK = 130, enemyLevel = 22, itemID = 35058, itemNum = 30, scale = 0.45, position = "0;-138"}
, 
[280] = {id = 280, bpID = 39014, nameID = 1300087, handbookID = 108, enemyHP = 792, enemyATK = 140, enemyLevel = 24, itemID = 35058, itemNum = 30, scale = 0.35, position = "0;-139"}
, 
[281] = {id = 281, bpID = 39015, nameID = 1300106, handbookID = 221, enemyHP = 80, enemyATK = 25, enemyLevel = 1, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-135"}
, 
[282] = {id = 282, bpID = 39015, nameID = 1300107, handbookID = 222, enemyHP = 90, enemyATK = 35, enemyLevel = 2, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-182"}
, 
[283] = {id = 283, bpID = 39015, nameID = 1300140, handbookID = 502, enemyHP = 112, enemyATK = 40, enemyLevel = 3, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[284] = {id = 284, bpID = 39015, nameID = 1300141, handbookID = 503, enemyHP = 144, enemyATK = 50, enemyLevel = 4, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-182"}
, 
[285] = {id = 285, bpID = 39015, nameID = 1300142, handbookID = 504, enemyHP = 176, enemyATK = 55, enemyLevel = 5, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[286] = {id = 286, bpID = 39015, nameID = 1300129, handbookID = 412, enemyHP = 208, enemyATK = 60, enemyLevel = 6, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[287] = {id = 287, bpID = 39015, nameID = 1300130, handbookID = 413, enemyHP = 240, enemyATK = 70, enemyLevel = 7, itemID = 35058, itemNum = 20, scale = 0.6, position = "0;-135"}
, 
[288] = {id = 288, bpID = 39015, nameID = 1300131, handbookID = 414, enemyHP = 272, enemyATK = 75, enemyLevel = 8, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[289] = {id = 289, bpID = 39015, nameID = 1300132, handbookID = 415, enemyHP = 304, enemyATK = 80, enemyLevel = 9, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[290] = {id = 290, bpID = 39015, nameID = 1300133, handbookID = 416, enemyHP = 336, enemyATK = 90, enemyLevel = 10, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[291] = {id = 291, bpID = 39015, nameID = 1300134, handbookID = 419, enemyHP = 372, enemyATK = 95, enemyLevel = 11, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[292] = {id = 292, bpID = 39015, nameID = 1303518, handbookID = 813, enemyHP = 408, enemyATK = 100, enemyLevel = 12, itemID = 35058, itemNum = 25, scale = 0.5, position = "0;-135"}
, 
[293] = {id = 293, bpID = 39015, nameID = 1303519, handbookID = 814, enemyHP = 440, enemyATK = 110, enemyLevel = 13, itemID = 35058, itemNum = 25, scale = 0.45, position = "0;-135"}
, 
[294] = {id = 294, bpID = 39015, nameID = 1303521, handbookID = 901, enemyHP = 472, enemyATK = 115, enemyLevel = 14, itemID = 35058, itemNum = 25, scale = 0.4, position = "0;-154"}
, 
[295] = {id = 295, bpID = 39015, nameID = 1303540, handbookID = 10003, enemyHP = 536, enemyATK = 120, enemyLevel = 16, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-135"}
, 
[296] = {id = 296, bpID = 39015, nameID = 1303530, handbookID = 11001, enemyHP = 568, enemyATK = 120, enemyLevel = 17, itemID = 35058, itemNum = 30, scale = 0.6, position = "0;-135"}
, 
[297] = {id = 297, bpID = 39015, nameID = 1303534, handbookID = 11005, enemyHP = 600, enemyATK = 120, enemyLevel = 18, itemID = 35058, itemNum = 30, scale = 0.55, position = "0;-136"}
, 
[298] = {id = 298, bpID = 39015, nameID = 1300135, handbookID = 420, enemyHP = 664, enemyATK = 120, enemyLevel = 20, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-137"}
, 
[299] = {id = 299, bpID = 39015, nameID = 1300086, handbookID = 107, enemyHP = 728, enemyATK = 130, enemyLevel = 22, itemID = 35058, itemNum = 30, scale = 0.45, position = "0;-138"}
, 
[300] = {id = 300, bpID = 39015, nameID = 1300087, handbookID = 108, enemyHP = 792, enemyATK = 140, enemyLevel = 24, itemID = 35058, itemNum = 30, scale = 0.35, position = "0;-139"}
, 
[301] = {id = 301, bpID = 39016, nameID = 1300106, handbookID = 221, enemyHP = 80, enemyATK = 25, enemyLevel = 1, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-135"}
, 
[302] = {id = 302, bpID = 39016, nameID = 1300107, handbookID = 222, enemyHP = 90, enemyATK = 35, enemyLevel = 2, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-182"}
, 
[303] = {id = 303, bpID = 39016, nameID = 1300140, handbookID = 502, enemyHP = 112, enemyATK = 40, enemyLevel = 3, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[304] = {id = 304, bpID = 39016, nameID = 1300141, handbookID = 503, enemyHP = 144, enemyATK = 50, enemyLevel = 4, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-182"}
, 
[305] = {id = 305, bpID = 39016, nameID = 1300142, handbookID = 504, enemyHP = 176, enemyATK = 55, enemyLevel = 5, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[306] = {id = 306, bpID = 39016, nameID = 1300129, handbookID = 412, enemyHP = 208, enemyATK = 60, enemyLevel = 6, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[307] = {id = 307, bpID = 39016, nameID = 1300130, handbookID = 413, enemyHP = 240, enemyATK = 70, enemyLevel = 7, itemID = 35058, itemNum = 20, scale = 0.6, position = "0;-135"}
, 
[308] = {id = 308, bpID = 39016, nameID = 1300131, handbookID = 414, enemyHP = 272, enemyATK = 75, enemyLevel = 8, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[309] = {id = 309, bpID = 39016, nameID = 1300132, handbookID = 415, enemyHP = 304, enemyATK = 80, enemyLevel = 9, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[310] = {id = 310, bpID = 39016, nameID = 1300133, handbookID = 416, enemyHP = 336, enemyATK = 90, enemyLevel = 10, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[311] = {id = 311, bpID = 39016, nameID = 1300134, handbookID = 419, enemyHP = 372, enemyATK = 95, enemyLevel = 11, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[312] = {id = 312, bpID = 39016, nameID = 1303518, handbookID = 813, enemyHP = 408, enemyATK = 100, enemyLevel = 12, itemID = 35058, itemNum = 25, scale = 0.5, position = "0;-135"}
, 
[313] = {id = 313, bpID = 39016, nameID = 1303519, handbookID = 814, enemyHP = 440, enemyATK = 110, enemyLevel = 13, itemID = 35058, itemNum = 25, scale = 0.45, position = "0;-135"}
, 
[314] = {id = 314, bpID = 39016, nameID = 1303521, handbookID = 901, enemyHP = 472, enemyATK = 115, enemyLevel = 14, itemID = 35058, itemNum = 25, scale = 0.4, position = "0;-154"}
, 
[315] = {id = 315, bpID = 39016, nameID = 1303540, handbookID = 10003, enemyHP = 536, enemyATK = 120, enemyLevel = 16, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-135"}
, 
[316] = {id = 316, bpID = 39016, nameID = 1303530, handbookID = 11001, enemyHP = 568, enemyATK = 120, enemyLevel = 17, itemID = 35058, itemNum = 30, scale = 0.6, position = "0;-135"}
, 
[317] = {id = 317, bpID = 39016, nameID = 1303534, handbookID = 11005, enemyHP = 600, enemyATK = 120, enemyLevel = 18, itemID = 35058, itemNum = 30, scale = 0.55, position = "0;-136"}
, 
[318] = {id = 318, bpID = 39016, nameID = 1300135, handbookID = 420, enemyHP = 664, enemyATK = 120, enemyLevel = 20, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-137"}
, 
[319] = {id = 319, bpID = 39016, nameID = 1300086, handbookID = 107, enemyHP = 728, enemyATK = 130, enemyLevel = 22, itemID = 35058, itemNum = 30, scale = 0.45, position = "0;-138"}
, 
[320] = {id = 320, bpID = 39016, nameID = 1300087, handbookID = 108, enemyHP = 792, enemyATK = 140, enemyLevel = 24, itemID = 35058, itemNum = 30, scale = 0.35, position = "0;-139"}
, 
[321] = {id = 321, bpID = 39017, nameID = 1300106, handbookID = 221, enemyHP = 80, enemyATK = 25, enemyLevel = 1, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-135"}
, 
[322] = {id = 322, bpID = 39017, nameID = 1300107, handbookID = 222, enemyHP = 90, enemyATK = 35, enemyLevel = 2, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-182"}
, 
[323] = {id = 323, bpID = 39017, nameID = 1300140, handbookID = 502, enemyHP = 112, enemyATK = 40, enemyLevel = 3, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[324] = {id = 324, bpID = 39017, nameID = 1300141, handbookID = 503, enemyHP = 144, enemyATK = 50, enemyLevel = 4, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-182"}
, 
[325] = {id = 325, bpID = 39017, nameID = 1300142, handbookID = 504, enemyHP = 176, enemyATK = 55, enemyLevel = 5, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[326] = {id = 326, bpID = 39017, nameID = 1300129, handbookID = 412, enemyHP = 208, enemyATK = 60, enemyLevel = 6, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[327] = {id = 327, bpID = 39017, nameID = 1300130, handbookID = 413, enemyHP = 240, enemyATK = 70, enemyLevel = 7, itemID = 35058, itemNum = 20, scale = 0.6, position = "0;-135"}
, 
[328] = {id = 328, bpID = 39017, nameID = 1300131, handbookID = 414, enemyHP = 272, enemyATK = 75, enemyLevel = 8, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[329] = {id = 329, bpID = 39017, nameID = 1300132, handbookID = 415, enemyHP = 304, enemyATK = 80, enemyLevel = 9, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[330] = {id = 330, bpID = 39017, nameID = 1300133, handbookID = 416, enemyHP = 336, enemyATK = 90, enemyLevel = 10, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[331] = {id = 331, bpID = 39017, nameID = 1300134, handbookID = 419, enemyHP = 372, enemyATK = 95, enemyLevel = 11, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[332] = {id = 332, bpID = 39017, nameID = 1303518, handbookID = 813, enemyHP = 408, enemyATK = 100, enemyLevel = 12, itemID = 35058, itemNum = 25, scale = 0.5, position = "0;-135"}
, 
[333] = {id = 333, bpID = 39017, nameID = 1303519, handbookID = 814, enemyHP = 440, enemyATK = 110, enemyLevel = 13, itemID = 35058, itemNum = 25, scale = 0.45, position = "0;-135"}
, 
[334] = {id = 334, bpID = 39017, nameID = 1303521, handbookID = 901, enemyHP = 472, enemyATK = 115, enemyLevel = 14, itemID = 35058, itemNum = 25, scale = 0.4, position = "0;-154"}
, 
[335] = {id = 335, bpID = 39017, nameID = 1303540, handbookID = 10003, enemyHP = 536, enemyATK = 120, enemyLevel = 16, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-135"}
, 
[336] = {id = 336, bpID = 39017, nameID = 1303530, handbookID = 11001, enemyHP = 568, enemyATK = 120, enemyLevel = 17, itemID = 35058, itemNum = 30, scale = 0.6, position = "0;-135"}
, 
[337] = {id = 337, bpID = 39017, nameID = 1303534, handbookID = 11005, enemyHP = 600, enemyATK = 120, enemyLevel = 18, itemID = 35058, itemNum = 30, scale = 0.55, position = "0;-136"}
, 
[338] = {id = 338, bpID = 39017, nameID = 1300135, handbookID = 420, enemyHP = 664, enemyATK = 120, enemyLevel = 20, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-137"}
, 
[339] = {id = 339, bpID = 39017, nameID = 1300086, handbookID = 107, enemyHP = 728, enemyATK = 130, enemyLevel = 22, itemID = 35058, itemNum = 30, scale = 0.45, position = "0;-138"}
, 
[340] = {id = 340, bpID = 39017, nameID = 1300087, handbookID = 108, enemyHP = 792, enemyATK = 140, enemyLevel = 24, itemID = 35058, itemNum = 30, scale = 0.35, position = "0;-139"}
, 
[341] = {id = 341, bpID = 39018, nameID = 1300106, handbookID = 221, enemyHP = 80, enemyATK = 25, enemyLevel = 1, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-135"}
, 
[342] = {id = 342, bpID = 39018, nameID = 1300107, handbookID = 222, enemyHP = 90, enemyATK = 35, enemyLevel = 2, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-182"}
, 
[343] = {id = 343, bpID = 39018, nameID = 1300140, handbookID = 502, enemyHP = 112, enemyATK = 40, enemyLevel = 3, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[344] = {id = 344, bpID = 39018, nameID = 1300141, handbookID = 503, enemyHP = 144, enemyATK = 50, enemyLevel = 4, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-182"}
, 
[345] = {id = 345, bpID = 39018, nameID = 1300142, handbookID = 504, enemyHP = 176, enemyATK = 55, enemyLevel = 5, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[346] = {id = 346, bpID = 39018, nameID = 1300129, handbookID = 412, enemyHP = 208, enemyATK = 60, enemyLevel = 6, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[347] = {id = 347, bpID = 39018, nameID = 1300130, handbookID = 413, enemyHP = 240, enemyATK = 70, enemyLevel = 7, itemID = 35058, itemNum = 20, scale = 0.6, position = "0;-135"}
, 
[348] = {id = 348, bpID = 39018, nameID = 1300131, handbookID = 414, enemyHP = 272, enemyATK = 75, enemyLevel = 8, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[349] = {id = 349, bpID = 39018, nameID = 1300132, handbookID = 415, enemyHP = 304, enemyATK = 80, enemyLevel = 9, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[350] = {id = 350, bpID = 39018, nameID = 1300133, handbookID = 416, enemyHP = 336, enemyATK = 90, enemyLevel = 10, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[351] = {id = 351, bpID = 39018, nameID = 1300134, handbookID = 419, enemyHP = 372, enemyATK = 95, enemyLevel = 11, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[352] = {id = 352, bpID = 39018, nameID = 1303518, handbookID = 813, enemyHP = 408, enemyATK = 100, enemyLevel = 12, itemID = 35058, itemNum = 25, scale = 0.5, position = "0;-135"}
, 
[353] = {id = 353, bpID = 39018, nameID = 1303519, handbookID = 814, enemyHP = 440, enemyATK = 110, enemyLevel = 13, itemID = 35058, itemNum = 25, scale = 0.45, position = "0;-135"}
, 
[354] = {id = 354, bpID = 39018, nameID = 1303521, handbookID = 901, enemyHP = 472, enemyATK = 115, enemyLevel = 14, itemID = 35058, itemNum = 25, scale = 0.4, position = "0;-154"}
, 
[355] = {id = 355, bpID = 39018, nameID = 1303540, handbookID = 10003, enemyHP = 536, enemyATK = 120, enemyLevel = 16, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-135"}
, 
[356] = {id = 356, bpID = 39018, nameID = 1303530, handbookID = 11001, enemyHP = 568, enemyATK = 120, enemyLevel = 17, itemID = 35058, itemNum = 30, scale = 0.6, position = "0;-135"}
, 
[357] = {id = 357, bpID = 39018, nameID = 1303534, handbookID = 11005, enemyHP = 600, enemyATK = 120, enemyLevel = 18, itemID = 35058, itemNum = 30, scale = 0.55, position = "0;-136"}
, 
[358] = {id = 358, bpID = 39018, nameID = 1300135, handbookID = 420, enemyHP = 664, enemyATK = 120, enemyLevel = 20, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-137"}
, 
[359] = {id = 359, bpID = 39018, nameID = 1300086, handbookID = 107, enemyHP = 728, enemyATK = 130, enemyLevel = 22, itemID = 35058, itemNum = 30, scale = 0.45, position = "0;-138"}
, 
[360] = {id = 360, bpID = 39018, nameID = 1300087, handbookID = 108, enemyHP = 792, enemyATK = 140, enemyLevel = 24, itemID = 35058, itemNum = 30, scale = 0.35, position = "0;-139"}
, 
[361] = {id = 361, bpID = 39019, nameID = 1300106, handbookID = 221, enemyHP = 80, enemyATK = 25, enemyLevel = 1, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-135"}
, 
[362] = {id = 362, bpID = 39019, nameID = 1300107, handbookID = 222, enemyHP = 90, enemyATK = 35, enemyLevel = 2, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-182"}
, 
[363] = {id = 363, bpID = 39019, nameID = 1300140, handbookID = 502, enemyHP = 112, enemyATK = 40, enemyLevel = 3, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[364] = {id = 364, bpID = 39019, nameID = 1300141, handbookID = 503, enemyHP = 144, enemyATK = 50, enemyLevel = 4, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-182"}
, 
[365] = {id = 365, bpID = 39019, nameID = 1300142, handbookID = 504, enemyHP = 176, enemyATK = 55, enemyLevel = 5, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[366] = {id = 366, bpID = 39019, nameID = 1300129, handbookID = 412, enemyHP = 208, enemyATK = 60, enemyLevel = 6, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[367] = {id = 367, bpID = 39019, nameID = 1300130, handbookID = 413, enemyHP = 240, enemyATK = 70, enemyLevel = 7, itemID = 35058, itemNum = 20, scale = 0.6, position = "0;-135"}
, 
[368] = {id = 368, bpID = 39019, nameID = 1300131, handbookID = 414, enemyHP = 272, enemyATK = 75, enemyLevel = 8, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[369] = {id = 369, bpID = 39019, nameID = 1300132, handbookID = 415, enemyHP = 304, enemyATK = 80, enemyLevel = 9, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[370] = {id = 370, bpID = 39019, nameID = 1300133, handbookID = 416, enemyHP = 336, enemyATK = 90, enemyLevel = 10, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[371] = {id = 371, bpID = 39019, nameID = 1300134, handbookID = 419, enemyHP = 372, enemyATK = 95, enemyLevel = 11, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[372] = {id = 372, bpID = 39019, nameID = 1303518, handbookID = 813, enemyHP = 408, enemyATK = 100, enemyLevel = 12, itemID = 35058, itemNum = 25, scale = 0.5, position = "0;-135"}
, 
[373] = {id = 373, bpID = 39019, nameID = 1303519, handbookID = 814, enemyHP = 440, enemyATK = 110, enemyLevel = 13, itemID = 35058, itemNum = 25, scale = 0.45, position = "0;-135"}
, 
[374] = {id = 374, bpID = 39019, nameID = 1303521, handbookID = 901, enemyHP = 472, enemyATK = 115, enemyLevel = 14, itemID = 35058, itemNum = 25, scale = 0.4, position = "0;-154"}
, 
[375] = {id = 375, bpID = 39019, nameID = 1303540, handbookID = 10003, enemyHP = 536, enemyATK = 120, enemyLevel = 16, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-135"}
, 
[376] = {id = 376, bpID = 39019, nameID = 1303530, handbookID = 11001, enemyHP = 568, enemyATK = 120, enemyLevel = 17, itemID = 35058, itemNum = 30, scale = 0.6, position = "0;-135"}
, 
[377] = {id = 377, bpID = 39019, nameID = 1303534, handbookID = 11005, enemyHP = 600, enemyATK = 120, enemyLevel = 18, itemID = 35058, itemNum = 30, scale = 0.55, position = "0;-136"}
, 
[378] = {id = 378, bpID = 39019, nameID = 1300135, handbookID = 420, enemyHP = 664, enemyATK = 120, enemyLevel = 20, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-137"}
, 
[379] = {id = 379, bpID = 39019, nameID = 1300086, handbookID = 107, enemyHP = 728, enemyATK = 130, enemyLevel = 22, itemID = 35058, itemNum = 30, scale = 0.45, position = "0;-138"}
, 
[380] = {id = 380, bpID = 39019, nameID = 1300087, handbookID = 108, enemyHP = 792, enemyATK = 140, enemyLevel = 24, itemID = 35058, itemNum = 30, scale = 0.35, position = "0;-139"}
, 
[381] = {id = 381, bpID = 39020, nameID = 1300106, handbookID = 221, enemyHP = 80, enemyATK = 25, enemyLevel = 1, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-135"}
, 
[382] = {id = 382, bpID = 39020, nameID = 1300107, handbookID = 222, enemyHP = 90, enemyATK = 35, enemyLevel = 2, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-182"}
, 
[383] = {id = 383, bpID = 39020, nameID = 1300140, handbookID = 502, enemyHP = 112, enemyATK = 40, enemyLevel = 3, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[384] = {id = 384, bpID = 39020, nameID = 1300141, handbookID = 503, enemyHP = 144, enemyATK = 50, enemyLevel = 4, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-182"}
, 
[385] = {id = 385, bpID = 39020, nameID = 1300142, handbookID = 504, enemyHP = 176, enemyATK = 55, enemyLevel = 5, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[386] = {id = 386, bpID = 39020, nameID = 1300129, handbookID = 412, enemyHP = 208, enemyATK = 60, enemyLevel = 6, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[387] = {id = 387, bpID = 39020, nameID = 1300130, handbookID = 413, enemyHP = 240, enemyATK = 70, enemyLevel = 7, itemID = 35058, itemNum = 20, scale = 0.6, position = "0;-135"}
, 
[388] = {id = 388, bpID = 39020, nameID = 1300131, handbookID = 414, enemyHP = 272, enemyATK = 75, enemyLevel = 8, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[389] = {id = 389, bpID = 39020, nameID = 1300132, handbookID = 415, enemyHP = 304, enemyATK = 80, enemyLevel = 9, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[390] = {id = 390, bpID = 39020, nameID = 1300133, handbookID = 416, enemyHP = 336, enemyATK = 90, enemyLevel = 10, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[391] = {id = 391, bpID = 39020, nameID = 1300134, handbookID = 419, enemyHP = 372, enemyATK = 95, enemyLevel = 11, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[392] = {id = 392, bpID = 39020, nameID = 1303518, handbookID = 813, enemyHP = 408, enemyATK = 100, enemyLevel = 12, itemID = 35058, itemNum = 25, scale = 0.5, position = "0;-135"}
, 
[393] = {id = 393, bpID = 39020, nameID = 1303519, handbookID = 814, enemyHP = 440, enemyATK = 110, enemyLevel = 13, itemID = 35058, itemNum = 25, scale = 0.45, position = "0;-135"}
, 
[394] = {id = 394, bpID = 39020, nameID = 1303521, handbookID = 901, enemyHP = 472, enemyATK = 115, enemyLevel = 14, itemID = 35058, itemNum = 25, scale = 0.4, position = "0;-154"}
, 
[395] = {id = 395, bpID = 39020, nameID = 1303540, handbookID = 10003, enemyHP = 536, enemyATK = 120, enemyLevel = 16, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-135"}
, 
[396] = {id = 396, bpID = 39020, nameID = 1303530, handbookID = 11001, enemyHP = 568, enemyATK = 120, enemyLevel = 17, itemID = 35058, itemNum = 30, scale = 0.6, position = "0;-135"}
, 
[397] = {id = 397, bpID = 39020, nameID = 1303534, handbookID = 11005, enemyHP = 600, enemyATK = 120, enemyLevel = 18, itemID = 35058, itemNum = 30, scale = 0.55, position = "0;-136"}
, 
[398] = {id = 398, bpID = 39020, nameID = 1300135, handbookID = 420, enemyHP = 664, enemyATK = 120, enemyLevel = 20, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-137"}
, 
[399] = {id = 399, bpID = 39020, nameID = 1300086, handbookID = 107, enemyHP = 728, enemyATK = 130, enemyLevel = 22, itemID = 35058, itemNum = 30, scale = 0.45, position = "0;-138"}
, 
[400] = {id = 400, bpID = 39020, nameID = 1300087, handbookID = 108, enemyHP = 792, enemyATK = 140, enemyLevel = 24, itemID = 35058, itemNum = 30, scale = 0.35, position = "0;-139"}
, 
[401] = {id = 401, bpID = 39021, nameID = 1300106, handbookID = 221, enemyHP = 80, enemyATK = 25, enemyLevel = 1, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-135"}
, 
[402] = {id = 402, bpID = 39021, nameID = 1300107, handbookID = 222, enemyHP = 90, enemyATK = 35, enemyLevel = 2, itemID = 35058, itemNum = 20, scale = 0.55, position = "0;-182"}
, 
[403] = {id = 403, bpID = 39021, nameID = 1300140, handbookID = 502, enemyHP = 112, enemyATK = 40, enemyLevel = 3, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[404] = {id = 404, bpID = 39021, nameID = 1300141, handbookID = 503, enemyHP = 144, enemyATK = 50, enemyLevel = 4, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-182"}
, 
[405] = {id = 405, bpID = 39021, nameID = 1300142, handbookID = 504, enemyHP = 176, enemyATK = 55, enemyLevel = 5, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[406] = {id = 406, bpID = 39021, nameID = 1300129, handbookID = 412, enemyHP = 208, enemyATK = 60, enemyLevel = 6, itemID = 35058, itemNum = 20, scale = 0.5, position = "0;-135"}
, 
[407] = {id = 407, bpID = 39021, nameID = 1300130, handbookID = 413, enemyHP = 240, enemyATK = 70, enemyLevel = 7, itemID = 35058, itemNum = 20, scale = 0.6, position = "0;-135"}
, 
[408] = {id = 408, bpID = 39021, nameID = 1300131, handbookID = 414, enemyHP = 272, enemyATK = 75, enemyLevel = 8, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[409] = {id = 409, bpID = 39021, nameID = 1300132, handbookID = 415, enemyHP = 304, enemyATK = 80, enemyLevel = 9, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[410] = {id = 410, bpID = 39021, nameID = 1300133, handbookID = 416, enemyHP = 336, enemyATK = 90, enemyLevel = 10, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[411] = {id = 411, bpID = 39021, nameID = 1300134, handbookID = 419, enemyHP = 372, enemyATK = 95, enemyLevel = 11, itemID = 35058, itemNum = 25, scale = 0.6, position = "0;-135"}
, 
[412] = {id = 412, bpID = 39021, nameID = 1303518, handbookID = 813, enemyHP = 408, enemyATK = 100, enemyLevel = 12, itemID = 35058, itemNum = 25, scale = 0.5, position = "0;-135"}
, 
[413] = {id = 413, bpID = 39021, nameID = 1303519, handbookID = 814, enemyHP = 440, enemyATK = 110, enemyLevel = 13, itemID = 35058, itemNum = 25, scale = 0.45, position = "0;-135"}
, 
[414] = {id = 414, bpID = 39021, nameID = 1303521, handbookID = 901, enemyHP = 472, enemyATK = 115, enemyLevel = 14, itemID = 35058, itemNum = 25, scale = 0.4, position = "0;-154"}
, 
[415] = {id = 415, bpID = 39021, nameID = 1303540, handbookID = 10003, enemyHP = 536, enemyATK = 120, enemyLevel = 16, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-135"}
, 
[416] = {id = 416, bpID = 39021, nameID = 1303530, handbookID = 11001, enemyHP = 568, enemyATK = 120, enemyLevel = 17, itemID = 35058, itemNum = 30, scale = 0.6, position = "0;-135"}
, 
[417] = {id = 417, bpID = 39021, nameID = 1303534, handbookID = 11005, enemyHP = 600, enemyATK = 120, enemyLevel = 18, itemID = 35058, itemNum = 30, scale = 0.55, position = "0;-136"}
, 
[418] = {id = 418, bpID = 39021, nameID = 1300135, handbookID = 420, enemyHP = 664, enemyATK = 120, enemyLevel = 20, itemID = 35058, itemNum = 30, scale = 0.4, position = "0;-137"}
, 
[419] = {id = 419, bpID = 39021, nameID = 1300086, handbookID = 107, enemyHP = 728, enemyATK = 130, enemyLevel = 22, itemID = 35058, itemNum = 30, scale = 0.45, position = "0;-138"}
, 
[420] = {id = 420, bpID = 39021, nameID = 1300087, handbookID = 108, enemyHP = 792, enemyATK = 140, enemyLevel = 24, itemID = 35058, itemNum = 30, scale = 0.35, position = "0;-139"}
}
cbpbosshitboss.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420}
return cbpbosshitboss

