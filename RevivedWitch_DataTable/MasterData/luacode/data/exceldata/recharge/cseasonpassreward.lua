-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/recharge/cseasonpassreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cseasonpassreward = {}
cseasonpassreward.Data = {
[1] = {id = 1, ShopType = 2001, level = 1, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 40000, PayItemID = 35002, PayItemNum = 120000}
, 
[2] = {id = 2, ShopType = 2001, level = 2, CoinID = 35017, CoinNum = 20, ItemID = 74003, ItemNum = 3, PayItemID = 74003, PayItemNum = 10}
, 
[3] = {id = 3, ShopType = 2001, level = 3, CoinID = 35017, CoinNum = 20, ItemID = 76000, ItemNum = 5, PayItemID = 75003, PayItemNum = 5}
, 
[4] = {id = 4, ShopType = 2001, level = 4, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[5] = {id = 5, ShopType = 2001, level = 5, CoinID = 35017, CoinNum = 20, ItemID = 35008, ItemNum = 80, PayItemID = 40016, PayItemNum = 1}
, 
[6] = {id = 6, ShopType = 2001, level = 6, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[7] = {id = 7, ShopType = 2001, level = 7, CoinID = 35017, CoinNum = 30, ItemID = 74003, ItemNum = 3, PayItemID = 75003, PayItemNum = 5}
, 
[8] = {id = 8, ShopType = 2001, level = 8, CoinID = 35017, CoinNum = 30, ItemID = 76000, ItemNum = 5, PayItemID = 76000, PayItemNum = 20}
, 
[9] = {id = 9, ShopType = 2001, level = 9, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[10] = {id = 10, ShopType = 2001, level = 10, CoinID = 35017, CoinNum = 30, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[11] = {id = 11, ShopType = 2001, level = 11, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[12] = {id = 12, ShopType = 2001, level = 12, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75004, PayItemNum = 5}
, 
[13] = {id = 13, ShopType = 2001, level = 13, CoinID = 35017, CoinNum = 40, ItemID = 76000, ItemNum = 5, PayItemID = 76000, PayItemNum = 20}
, 
[14] = {id = 14, ShopType = 2001, level = 14, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[15] = {id = 15, ShopType = 2001, level = 15, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[16] = {id = 16, ShopType = 2001, level = 16, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[17] = {id = 17, ShopType = 2001, level = 17, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75004, PayItemNum = 10}
, 
[18] = {id = 18, ShopType = 2001, level = 18, CoinID = 35017, CoinNum = 40, ItemID = 76000, ItemNum = 5, PayItemID = 76000, PayItemNum = 20}
, 
[19] = {id = 19, ShopType = 2001, level = 19, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[20] = {id = 20, ShopType = 2001, level = 20, CoinID = 35017, CoinNum = 40, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[21] = {id = 21, ShopType = 2001, level = 21, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[22] = {id = 22, ShopType = 2001, level = 22, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75005, PayItemNum = 10}
, 
[23] = {id = 23, ShopType = 2001, level = 23, CoinID = 35017, CoinNum = 40, ItemID = 76001, ItemNum = 5, PayItemID = 76001, PayItemNum = 20}
, 
[24] = {id = 24, ShopType = 2001, level = 24, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[25] = {id = 25, ShopType = 2001, level = 25, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[26] = {id = 26, ShopType = 2001, level = 26, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[27] = {id = 27, ShopType = 2001, level = 27, CoinID = 35017, CoinNum = 40, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[28] = {id = 28, ShopType = 2001, level = 28, CoinID = 35017, CoinNum = 40, ItemID = 76001, ItemNum = 5, PayItemID = 75005, PayItemNum = 10}
, 
[29] = {id = 29, ShopType = 2001, level = 29, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[30] = {id = 30, ShopType = 2001, level = 30, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[31] = {id = 31, ShopType = 2001, level = 31, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[32] = {id = 32, ShopType = 2001, level = 32, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[33] = {id = 33, ShopType = 2001, level = 33, CoinID = 35017, CoinNum = 50, ItemID = 76001, ItemNum = 5, PayItemID = 76001, PayItemNum = 20}
, 
[34] = {id = 34, ShopType = 2001, level = 34, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[35] = {id = 35, ShopType = 2001, level = 35, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[36] = {id = 36, ShopType = 2001, level = 36, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[37] = {id = 37, ShopType = 2001, level = 37, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[38] = {id = 38, ShopType = 2001, level = 38, CoinID = 35017, CoinNum = 50, ItemID = 76002, ItemNum = 5, PayItemID = 76002, PayItemNum = 20}
, 
[39] = {id = 39, ShopType = 2001, level = 39, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[40] = {id = 40, ShopType = 2001, level = 40, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[41] = {id = 41, ShopType = 2001, level = 41, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[42] = {id = 42, ShopType = 2001, level = 42, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[43] = {id = 43, ShopType = 2001, level = 43, CoinID = 35017, CoinNum = 50, ItemID = 76002, ItemNum = 5, PayItemID = 76002, PayItemNum = 20}
, 
[44] = {id = 44, ShopType = 2001, level = 44, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[45] = {id = 45, ShopType = 2001, level = 45, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[46] = {id = 46, ShopType = 2001, level = 46, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[47] = {id = 47, ShopType = 2001, level = 47, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[48] = {id = 48, ShopType = 2001, level = 48, CoinID = 35017, CoinNum = 50, ItemID = 76002, ItemNum = 5, PayItemID = 76002, PayItemNum = 20}
, 
[49] = {id = 49, ShopType = 2001, level = 49, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[50] = {id = 50, ShopType = 2001, level = 50, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30077, PayItemNum = 1}
, 
[51] = {id = 51, ShopType = 2001, level = 51, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 0, PayItemNum = 0}
, 
[52] = {id = 52, ShopType = 2002, level = 1, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 40000, PayItemID = 35002, PayItemNum = 120000}
, 
[53] = {id = 53, ShopType = 2002, level = 2, CoinID = 35017, CoinNum = 20, ItemID = 74003, ItemNum = 3, PayItemID = 74003, PayItemNum = 10}
, 
[54] = {id = 54, ShopType = 2002, level = 3, CoinID = 35017, CoinNum = 20, ItemID = 76000, ItemNum = 5, PayItemID = 75006, PayItemNum = 5}
, 
[55] = {id = 55, ShopType = 2002, level = 4, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[56] = {id = 56, ShopType = 2002, level = 5, CoinID = 35017, CoinNum = 20, ItemID = 35008, ItemNum = 80, PayItemID = 40070, PayItemNum = 1}
, 
[57] = {id = 57, ShopType = 2002, level = 6, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[58] = {id = 58, ShopType = 2002, level = 7, CoinID = 35017, CoinNum = 30, ItemID = 74003, ItemNum = 3, PayItemID = 75006, PayItemNum = 5}
, 
[59] = {id = 59, ShopType = 2002, level = 8, CoinID = 35017, CoinNum = 30, ItemID = 76000, ItemNum = 5, PayItemID = 76000, PayItemNum = 20}
, 
[60] = {id = 60, ShopType = 2002, level = 9, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[61] = {id = 61, ShopType = 2002, level = 10, CoinID = 35017, CoinNum = 30, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[62] = {id = 62, ShopType = 2002, level = 11, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[63] = {id = 63, ShopType = 2002, level = 12, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75007, PayItemNum = 5}
, 
[64] = {id = 64, ShopType = 2002, level = 13, CoinID = 35017, CoinNum = 40, ItemID = 76000, ItemNum = 5, PayItemID = 76000, PayItemNum = 20}
, 
[65] = {id = 65, ShopType = 2002, level = 14, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[66] = {id = 66, ShopType = 2002, level = 15, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[67] = {id = 67, ShopType = 2002, level = 16, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[68] = {id = 68, ShopType = 2002, level = 17, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75007, PayItemNum = 10}
, 
[69] = {id = 69, ShopType = 2002, level = 18, CoinID = 35017, CoinNum = 40, ItemID = 76000, ItemNum = 5, PayItemID = 76000, PayItemNum = 20}
, 
[70] = {id = 70, ShopType = 2002, level = 19, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[71] = {id = 71, ShopType = 2002, level = 20, CoinID = 35017, CoinNum = 40, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[72] = {id = 72, ShopType = 2002, level = 21, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[73] = {id = 73, ShopType = 2002, level = 22, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75008, PayItemNum = 10}
, 
[74] = {id = 74, ShopType = 2002, level = 23, CoinID = 35017, CoinNum = 40, ItemID = 76001, ItemNum = 5, PayItemID = 76001, PayItemNum = 20}
, 
[75] = {id = 75, ShopType = 2002, level = 24, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[76] = {id = 76, ShopType = 2002, level = 25, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[77] = {id = 77, ShopType = 2002, level = 26, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[78] = {id = 78, ShopType = 2002, level = 27, CoinID = 35017, CoinNum = 40, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[79] = {id = 79, ShopType = 2002, level = 28, CoinID = 35017, CoinNum = 40, ItemID = 76001, ItemNum = 5, PayItemID = 75008, PayItemNum = 10}
, 
[80] = {id = 80, ShopType = 2002, level = 29, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[81] = {id = 81, ShopType = 2002, level = 30, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[82] = {id = 82, ShopType = 2002, level = 31, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[83] = {id = 83, ShopType = 2002, level = 32, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[84] = {id = 84, ShopType = 2002, level = 33, CoinID = 35017, CoinNum = 50, ItemID = 76001, ItemNum = 5, PayItemID = 76001, PayItemNum = 20}
, 
[85] = {id = 85, ShopType = 2002, level = 34, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[86] = {id = 86, ShopType = 2002, level = 35, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[87] = {id = 87, ShopType = 2002, level = 36, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[88] = {id = 88, ShopType = 2002, level = 37, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[89] = {id = 89, ShopType = 2002, level = 38, CoinID = 35017, CoinNum = 50, ItemID = 76002, ItemNum = 5, PayItemID = 76002, PayItemNum = 20}
, 
[90] = {id = 90, ShopType = 2002, level = 39, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[91] = {id = 91, ShopType = 2002, level = 40, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[92] = {id = 92, ShopType = 2002, level = 41, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[93] = {id = 93, ShopType = 2002, level = 42, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[94] = {id = 94, ShopType = 2002, level = 43, CoinID = 35017, CoinNum = 50, ItemID = 76002, ItemNum = 5, PayItemID = 76002, PayItemNum = 20}
, 
[95] = {id = 95, ShopType = 2002, level = 44, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[96] = {id = 96, ShopType = 2002, level = 45, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[97] = {id = 97, ShopType = 2002, level = 46, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[98] = {id = 98, ShopType = 2002, level = 47, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[99] = {id = 99, ShopType = 2002, level = 48, CoinID = 35017, CoinNum = 50, ItemID = 76002, ItemNum = 5, PayItemID = 76002, PayItemNum = 20}
, 
[100] = {id = 100, ShopType = 2002, level = 49, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[101] = {id = 101, ShopType = 2002, level = 50, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30077, PayItemNum = 1}
, 
[102] = {id = 102, ShopType = 2002, level = 51, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 0, PayItemNum = 0}
, 
[103] = {id = 103, ShopType = 2003, level = 1, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 40000, PayItemID = 35002, PayItemNum = 120000}
, 
[104] = {id = 104, ShopType = 2003, level = 2, CoinID = 35017, CoinNum = 20, ItemID = 74003, ItemNum = 3, PayItemID = 74003, PayItemNum = 10}
, 
[105] = {id = 105, ShopType = 2003, level = 3, CoinID = 35017, CoinNum = 20, ItemID = 76000, ItemNum = 5, PayItemID = 75009, PayItemNum = 5}
, 
[106] = {id = 106, ShopType = 2003, level = 4, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[107] = {id = 107, ShopType = 2003, level = 5, CoinID = 35017, CoinNum = 20, ItemID = 35008, ItemNum = 80, PayItemID = 40059, PayItemNum = 1}
, 
[108] = {id = 108, ShopType = 2003, level = 6, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[109] = {id = 109, ShopType = 2003, level = 7, CoinID = 35017, CoinNum = 30, ItemID = 74003, ItemNum = 3, PayItemID = 75009, PayItemNum = 5}
, 
[110] = {id = 110, ShopType = 2003, level = 8, CoinID = 35017, CoinNum = 30, ItemID = 76000, ItemNum = 5, PayItemID = 76000, PayItemNum = 20}
, 
[111] = {id = 111, ShopType = 2003, level = 9, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[112] = {id = 112, ShopType = 2003, level = 10, CoinID = 35017, CoinNum = 30, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[113] = {id = 113, ShopType = 2003, level = 11, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[114] = {id = 114, ShopType = 2003, level = 12, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75010, PayItemNum = 5}
, 
[115] = {id = 115, ShopType = 2003, level = 13, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[116] = {id = 116, ShopType = 2003, level = 14, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[117] = {id = 117, ShopType = 2003, level = 15, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[118] = {id = 118, ShopType = 2003, level = 16, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[119] = {id = 119, ShopType = 2003, level = 17, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75010, PayItemNum = 10}
, 
[120] = {id = 120, ShopType = 2003, level = 18, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[121] = {id = 121, ShopType = 2003, level = 19, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[122] = {id = 122, ShopType = 2003, level = 20, CoinID = 35017, CoinNum = 40, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[123] = {id = 123, ShopType = 2003, level = 21, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[124] = {id = 124, ShopType = 2003, level = 22, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75011, PayItemNum = 10}
, 
[125] = {id = 125, ShopType = 2003, level = 23, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[126] = {id = 126, ShopType = 2003, level = 24, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[127] = {id = 127, ShopType = 2003, level = 25, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[128] = {id = 128, ShopType = 2003, level = 26, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[129] = {id = 129, ShopType = 2003, level = 27, CoinID = 35017, CoinNum = 40, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[130] = {id = 130, ShopType = 2003, level = 28, CoinID = 35017, CoinNum = 40, ItemID = 79002, ItemNum = 20, PayItemID = 79002, PayItemNum = 30}
, 
[131] = {id = 131, ShopType = 2003, level = 29, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 75011, PayItemNum = 10}
, 
[132] = {id = 132, ShopType = 2003, level = 30, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[133] = {id = 133, ShopType = 2003, level = 31, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[134] = {id = 134, ShopType = 2003, level = 32, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[135] = {id = 135, ShopType = 2003, level = 33, CoinID = 35017, CoinNum = 50, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[136] = {id = 136, ShopType = 2003, level = 34, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[137] = {id = 137, ShopType = 2003, level = 35, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[138] = {id = 138, ShopType = 2003, level = 36, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[139] = {id = 139, ShopType = 2003, level = 37, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[140] = {id = 140, ShopType = 2003, level = 38, CoinID = 35017, CoinNum = 50, ItemID = 79002, ItemNum = 20, PayItemID = 79002, PayItemNum = 30}
, 
[141] = {id = 141, ShopType = 2003, level = 39, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[142] = {id = 142, ShopType = 2003, level = 40, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[143] = {id = 143, ShopType = 2003, level = 41, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[144] = {id = 144, ShopType = 2003, level = 42, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[145] = {id = 145, ShopType = 2003, level = 43, CoinID = 35017, CoinNum = 50, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[146] = {id = 146, ShopType = 2003, level = 44, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[147] = {id = 147, ShopType = 2003, level = 45, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[148] = {id = 148, ShopType = 2003, level = 46, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[149] = {id = 149, ShopType = 2003, level = 47, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[150] = {id = 150, ShopType = 2003, level = 48, CoinID = 35017, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 79004, PayItemNum = 1}
, 
[151] = {id = 151, ShopType = 2003, level = 49, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[152] = {id = 152, ShopType = 2003, level = 50, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30077, PayItemNum = 1}
, 
[153] = {id = 153, ShopType = 2003, level = 51, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 0, PayItemNum = 0}
, 
[154] = {id = 154, ShopType = 2004, level = 1, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 40000, PayItemID = 35002, PayItemNum = 120000}
, 
[155] = {id = 155, ShopType = 2004, level = 2, CoinID = 35017, CoinNum = 20, ItemID = 74003, ItemNum = 3, PayItemID = 74003, PayItemNum = 10}
, 
[156] = {id = 156, ShopType = 2004, level = 3, CoinID = 35017, CoinNum = 20, ItemID = 76000, ItemNum = 5, PayItemID = 75015, PayItemNum = 5}
, 
[157] = {id = 157, ShopType = 2004, level = 4, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[158] = {id = 158, ShopType = 2004, level = 5, CoinID = 35017, CoinNum = 20, ItemID = 35008, ItemNum = 80, PayItemID = 40078, PayItemNum = 1}
, 
[159] = {id = 159, ShopType = 2004, level = 6, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[160] = {id = 160, ShopType = 2004, level = 7, CoinID = 35017, CoinNum = 30, ItemID = 74003, ItemNum = 3, PayItemID = 75015, PayItemNum = 5}
, 
[161] = {id = 161, ShopType = 2004, level = 8, CoinID = 35017, CoinNum = 30, ItemID = 76000, ItemNum = 5, PayItemID = 76000, PayItemNum = 20}
, 
[162] = {id = 162, ShopType = 2004, level = 9, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[163] = {id = 163, ShopType = 2004, level = 10, CoinID = 35017, CoinNum = 30, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[164] = {id = 164, ShopType = 2004, level = 11, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[165] = {id = 165, ShopType = 2004, level = 12, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75016, PayItemNum = 5}
, 
[166] = {id = 166, ShopType = 2004, level = 13, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[167] = {id = 167, ShopType = 2004, level = 14, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[168] = {id = 168, ShopType = 2004, level = 15, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[169] = {id = 169, ShopType = 2004, level = 16, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[170] = {id = 170, ShopType = 2004, level = 17, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75016, PayItemNum = 10}
, 
[171] = {id = 171, ShopType = 2004, level = 18, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[172] = {id = 172, ShopType = 2004, level = 19, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[173] = {id = 173, ShopType = 2004, level = 20, CoinID = 35017, CoinNum = 40, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[174] = {id = 174, ShopType = 2004, level = 21, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[175] = {id = 175, ShopType = 2004, level = 22, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75017, PayItemNum = 10}
, 
[176] = {id = 176, ShopType = 2004, level = 23, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[177] = {id = 177, ShopType = 2004, level = 24, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[178] = {id = 178, ShopType = 2004, level = 25, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[179] = {id = 179, ShopType = 2004, level = 26, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[180] = {id = 180, ShopType = 2004, level = 27, CoinID = 35017, CoinNum = 40, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[181] = {id = 181, ShopType = 2004, level = 28, CoinID = 35017, CoinNum = 40, ItemID = 79002, ItemNum = 20, PayItemID = 79002, PayItemNum = 30}
, 
[182] = {id = 182, ShopType = 2004, level = 29, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 75017, PayItemNum = 10}
, 
[183] = {id = 183, ShopType = 2004, level = 30, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[184] = {id = 184, ShopType = 2004, level = 31, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[185] = {id = 185, ShopType = 2004, level = 32, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[186] = {id = 186, ShopType = 2004, level = 33, CoinID = 35017, CoinNum = 50, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[187] = {id = 187, ShopType = 2004, level = 34, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[188] = {id = 188, ShopType = 2004, level = 35, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[189] = {id = 189, ShopType = 2004, level = 36, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[190] = {id = 190, ShopType = 2004, level = 37, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[191] = {id = 191, ShopType = 2004, level = 38, CoinID = 35017, CoinNum = 50, ItemID = 79002, ItemNum = 20, PayItemID = 79002, PayItemNum = 30}
, 
[192] = {id = 192, ShopType = 2004, level = 39, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[193] = {id = 193, ShopType = 2004, level = 40, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[194] = {id = 194, ShopType = 2004, level = 41, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[195] = {id = 195, ShopType = 2004, level = 42, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[196] = {id = 196, ShopType = 2004, level = 43, CoinID = 35017, CoinNum = 50, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[197] = {id = 197, ShopType = 2004, level = 44, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[198] = {id = 198, ShopType = 2004, level = 45, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[199] = {id = 199, ShopType = 2004, level = 46, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[200] = {id = 200, ShopType = 2004, level = 47, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[201] = {id = 201, ShopType = 2004, level = 48, CoinID = 35017, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 79004, PayItemNum = 1}
, 
[202] = {id = 202, ShopType = 2004, level = 49, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[203] = {id = 203, ShopType = 2004, level = 50, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30077, PayItemNum = 1}
, 
[204] = {id = 204, ShopType = 2004, level = 51, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 0, PayItemNum = 0}
, 
[205] = {id = 205, ShopType = 2005, level = 1, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 40000, PayItemID = 35002, PayItemNum = 120000}
, 
[206] = {id = 206, ShopType = 2005, level = 2, CoinID = 35017, CoinNum = 20, ItemID = 74003, ItemNum = 3, PayItemID = 74003, PayItemNum = 10}
, 
[207] = {id = 207, ShopType = 2005, level = 3, CoinID = 35017, CoinNum = 20, ItemID = 76000, ItemNum = 5, PayItemID = 75009, PayItemNum = 5}
, 
[208] = {id = 208, ShopType = 2005, level = 4, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[209] = {id = 209, ShopType = 2005, level = 5, CoinID = 35017, CoinNum = 20, ItemID = 35008, ItemNum = 80, PayItemID = 40065, PayItemNum = 1}
, 
[210] = {id = 210, ShopType = 2005, level = 6, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[211] = {id = 211, ShopType = 2005, level = 7, CoinID = 35017, CoinNum = 30, ItemID = 74003, ItemNum = 3, PayItemID = 75009, PayItemNum = 5}
, 
[212] = {id = 212, ShopType = 2005, level = 8, CoinID = 35017, CoinNum = 30, ItemID = 76000, ItemNum = 5, PayItemID = 76000, PayItemNum = 20}
, 
[213] = {id = 213, ShopType = 2005, level = 9, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[214] = {id = 214, ShopType = 2005, level = 10, CoinID = 35017, CoinNum = 30, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[215] = {id = 215, ShopType = 2005, level = 11, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[216] = {id = 216, ShopType = 2005, level = 12, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75010, PayItemNum = 5}
, 
[217] = {id = 217, ShopType = 2005, level = 13, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[218] = {id = 218, ShopType = 2005, level = 14, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[219] = {id = 219, ShopType = 2005, level = 15, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[220] = {id = 220, ShopType = 2005, level = 16, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[221] = {id = 221, ShopType = 2005, level = 17, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75010, PayItemNum = 10}
, 
[222] = {id = 222, ShopType = 2005, level = 18, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[223] = {id = 223, ShopType = 2005, level = 19, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[224] = {id = 224, ShopType = 2005, level = 20, CoinID = 35017, CoinNum = 40, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[225] = {id = 225, ShopType = 2005, level = 21, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[226] = {id = 226, ShopType = 2005, level = 22, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75011, PayItemNum = 10}
, 
[227] = {id = 227, ShopType = 2005, level = 23, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[228] = {id = 228, ShopType = 2005, level = 24, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[229] = {id = 229, ShopType = 2005, level = 25, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[230] = {id = 230, ShopType = 2005, level = 26, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[231] = {id = 231, ShopType = 2005, level = 27, CoinID = 35017, CoinNum = 40, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[232] = {id = 232, ShopType = 2005, level = 28, CoinID = 35017, CoinNum = 40, ItemID = 79002, ItemNum = 20, PayItemID = 79002, PayItemNum = 30}
, 
[233] = {id = 233, ShopType = 2005, level = 29, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 75011, PayItemNum = 10}
, 
[234] = {id = 234, ShopType = 2005, level = 30, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[235] = {id = 235, ShopType = 2005, level = 31, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[236] = {id = 236, ShopType = 2005, level = 32, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[237] = {id = 237, ShopType = 2005, level = 33, CoinID = 35017, CoinNum = 50, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[238] = {id = 238, ShopType = 2005, level = 34, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[239] = {id = 239, ShopType = 2005, level = 35, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[240] = {id = 240, ShopType = 2005, level = 36, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[241] = {id = 241, ShopType = 2005, level = 37, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[242] = {id = 242, ShopType = 2005, level = 38, CoinID = 35017, CoinNum = 50, ItemID = 79002, ItemNum = 20, PayItemID = 79002, PayItemNum = 30}
, 
[243] = {id = 243, ShopType = 2005, level = 39, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[244] = {id = 244, ShopType = 2005, level = 40, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[245] = {id = 245, ShopType = 2005, level = 41, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[246] = {id = 246, ShopType = 2005, level = 42, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[247] = {id = 247, ShopType = 2005, level = 43, CoinID = 35017, CoinNum = 50, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[248] = {id = 248, ShopType = 2005, level = 44, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[249] = {id = 249, ShopType = 2005, level = 45, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[250] = {id = 250, ShopType = 2005, level = 46, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[251] = {id = 251, ShopType = 2005, level = 47, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[252] = {id = 252, ShopType = 2005, level = 48, CoinID = 35017, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 79004, PayItemNum = 1}
, 
[253] = {id = 253, ShopType = 2005, level = 49, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[254] = {id = 254, ShopType = 2005, level = 50, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30077, PayItemNum = 1}
, 
[255] = {id = 255, ShopType = 2005, level = 51, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 0, PayItemNum = 0}
, 
[256] = {id = 256, ShopType = 2006, level = 1, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 40000, PayItemID = 35002, PayItemNum = 120000}
, 
[257] = {id = 257, ShopType = 2006, level = 2, CoinID = 35017, CoinNum = 20, ItemID = 74003, ItemNum = 3, PayItemID = 74003, PayItemNum = 10}
, 
[258] = {id = 258, ShopType = 2006, level = 3, CoinID = 35017, CoinNum = 20, ItemID = 76000, ItemNum = 5, PayItemID = 75003, PayItemNum = 5}
, 
[259] = {id = 259, ShopType = 2006, level = 4, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[260] = {id = 260, ShopType = 2006, level = 5, CoinID = 35017, CoinNum = 20, ItemID = 35008, ItemNum = 80, PayItemID = 40090, PayItemNum = 1}
, 
[261] = {id = 261, ShopType = 2006, level = 6, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[262] = {id = 262, ShopType = 2006, level = 7, CoinID = 35017, CoinNum = 30, ItemID = 74003, ItemNum = 3, PayItemID = 75003, PayItemNum = 5}
, 
[263] = {id = 263, ShopType = 2006, level = 8, CoinID = 35017, CoinNum = 30, ItemID = 76000, ItemNum = 5, PayItemID = 76000, PayItemNum = 20}
, 
[264] = {id = 264, ShopType = 2006, level = 9, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[265] = {id = 265, ShopType = 2006, level = 10, CoinID = 35017, CoinNum = 30, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[266] = {id = 266, ShopType = 2006, level = 11, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[267] = {id = 267, ShopType = 2006, level = 12, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75004, PayItemNum = 5}
, 
[268] = {id = 268, ShopType = 2006, level = 13, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[269] = {id = 269, ShopType = 2006, level = 14, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[270] = {id = 270, ShopType = 2006, level = 15, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[271] = {id = 271, ShopType = 2006, level = 16, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[272] = {id = 272, ShopType = 2006, level = 17, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75004, PayItemNum = 10}
, 
[273] = {id = 273, ShopType = 2006, level = 18, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[274] = {id = 274, ShopType = 2006, level = 19, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[275] = {id = 275, ShopType = 2006, level = 20, CoinID = 35017, CoinNum = 40, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[276] = {id = 276, ShopType = 2006, level = 21, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[277] = {id = 277, ShopType = 2006, level = 22, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75005, PayItemNum = 10}
, 
[278] = {id = 278, ShopType = 2006, level = 23, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[279] = {id = 279, ShopType = 2006, level = 24, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[280] = {id = 280, ShopType = 2006, level = 25, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[281] = {id = 281, ShopType = 2006, level = 26, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[282] = {id = 282, ShopType = 2006, level = 27, CoinID = 35017, CoinNum = 40, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[283] = {id = 283, ShopType = 2006, level = 28, CoinID = 35017, CoinNum = 40, ItemID = 79002, ItemNum = 20, PayItemID = 79002, PayItemNum = 30}
, 
[284] = {id = 284, ShopType = 2006, level = 29, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 75005, PayItemNum = 10}
, 
[285] = {id = 285, ShopType = 2006, level = 30, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[286] = {id = 286, ShopType = 2006, level = 31, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[287] = {id = 287, ShopType = 2006, level = 32, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[288] = {id = 288, ShopType = 2006, level = 33, CoinID = 35017, CoinNum = 50, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[289] = {id = 289, ShopType = 2006, level = 34, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[290] = {id = 290, ShopType = 2006, level = 35, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[291] = {id = 291, ShopType = 2006, level = 36, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[292] = {id = 292, ShopType = 2006, level = 37, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[293] = {id = 293, ShopType = 2006, level = 38, CoinID = 35017, CoinNum = 50, ItemID = 79002, ItemNum = 20, PayItemID = 79002, PayItemNum = 30}
, 
[294] = {id = 294, ShopType = 2006, level = 39, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[295] = {id = 295, ShopType = 2006, level = 40, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[296] = {id = 296, ShopType = 2006, level = 41, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[297] = {id = 297, ShopType = 2006, level = 42, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[298] = {id = 298, ShopType = 2006, level = 43, CoinID = 35017, CoinNum = 50, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[299] = {id = 299, ShopType = 2006, level = 44, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[300] = {id = 300, ShopType = 2006, level = 45, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[301] = {id = 301, ShopType = 2006, level = 46, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[302] = {id = 302, ShopType = 2006, level = 47, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[303] = {id = 303, ShopType = 2006, level = 48, CoinID = 35017, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 79004, PayItemNum = 1}
, 
[304] = {id = 304, ShopType = 2006, level = 49, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[305] = {id = 305, ShopType = 2006, level = 50, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30077, PayItemNum = 1}
, 
[306] = {id = 306, ShopType = 2006, level = 51, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 0, PayItemNum = 0}
, 
[307] = {id = 307, ShopType = 2007, level = 1, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 40000, PayItemID = 35002, PayItemNum = 120000}
, 
[308] = {id = 308, ShopType = 2007, level = 2, CoinID = 35017, CoinNum = 20, ItemID = 74003, ItemNum = 3, PayItemID = 74003, PayItemNum = 10}
, 
[309] = {id = 309, ShopType = 2007, level = 3, CoinID = 35017, CoinNum = 20, ItemID = 76000, ItemNum = 5, PayItemID = 75012, PayItemNum = 5}
, 
[310] = {id = 310, ShopType = 2007, level = 4, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[311] = {id = 311, ShopType = 2007, level = 5, CoinID = 35017, CoinNum = 20, ItemID = 35008, ItemNum = 80, PayItemID = 40100, PayItemNum = 1}
, 
[312] = {id = 312, ShopType = 2007, level = 6, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[313] = {id = 313, ShopType = 2007, level = 7, CoinID = 35017, CoinNum = 30, ItemID = 74003, ItemNum = 3, PayItemID = 75012, PayItemNum = 5}
, 
[314] = {id = 314, ShopType = 2007, level = 8, CoinID = 35017, CoinNum = 30, ItemID = 76000, ItemNum = 5, PayItemID = 76000, PayItemNum = 20}
, 
[315] = {id = 315, ShopType = 2007, level = 9, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[316] = {id = 316, ShopType = 2007, level = 10, CoinID = 35017, CoinNum = 30, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[317] = {id = 317, ShopType = 2007, level = 11, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[318] = {id = 318, ShopType = 2007, level = 12, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75013, PayItemNum = 5}
, 
[319] = {id = 319, ShopType = 2007, level = 13, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[320] = {id = 320, ShopType = 2007, level = 14, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[321] = {id = 321, ShopType = 2007, level = 15, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[322] = {id = 322, ShopType = 2007, level = 16, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[323] = {id = 323, ShopType = 2007, level = 17, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75013, PayItemNum = 10}
, 
[324] = {id = 324, ShopType = 2007, level = 18, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[325] = {id = 325, ShopType = 2007, level = 19, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[326] = {id = 326, ShopType = 2007, level = 20, CoinID = 35017, CoinNum = 40, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[327] = {id = 327, ShopType = 2007, level = 21, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[328] = {id = 328, ShopType = 2007, level = 22, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75014, PayItemNum = 10}
, 
[329] = {id = 329, ShopType = 2007, level = 23, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[330] = {id = 330, ShopType = 2007, level = 24, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[331] = {id = 331, ShopType = 2007, level = 25, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[332] = {id = 332, ShopType = 2007, level = 26, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[333] = {id = 333, ShopType = 2007, level = 27, CoinID = 35017, CoinNum = 40, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[334] = {id = 334, ShopType = 2007, level = 28, CoinID = 35017, CoinNum = 40, ItemID = 79002, ItemNum = 20, PayItemID = 79002, PayItemNum = 30}
, 
[335] = {id = 335, ShopType = 2007, level = 29, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 75014, PayItemNum = 10}
, 
[336] = {id = 336, ShopType = 2007, level = 30, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[337] = {id = 337, ShopType = 2007, level = 31, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[338] = {id = 338, ShopType = 2007, level = 32, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[339] = {id = 339, ShopType = 2007, level = 33, CoinID = 35017, CoinNum = 50, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[340] = {id = 340, ShopType = 2007, level = 34, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[341] = {id = 341, ShopType = 2007, level = 35, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[342] = {id = 342, ShopType = 2007, level = 36, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[343] = {id = 343, ShopType = 2007, level = 37, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[344] = {id = 344, ShopType = 2007, level = 38, CoinID = 35017, CoinNum = 50, ItemID = 79002, ItemNum = 20, PayItemID = 79002, PayItemNum = 30}
, 
[345] = {id = 345, ShopType = 2007, level = 39, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[346] = {id = 346, ShopType = 2007, level = 40, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[347] = {id = 347, ShopType = 2007, level = 41, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[348] = {id = 348, ShopType = 2007, level = 42, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[349] = {id = 349, ShopType = 2007, level = 43, CoinID = 35017, CoinNum = 50, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[350] = {id = 350, ShopType = 2007, level = 44, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[351] = {id = 351, ShopType = 2007, level = 45, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[352] = {id = 352, ShopType = 2007, level = 46, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[353] = {id = 353, ShopType = 2007, level = 47, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[354] = {id = 354, ShopType = 2007, level = 48, CoinID = 35017, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 79004, PayItemNum = 1}
, 
[355] = {id = 355, ShopType = 2007, level = 49, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[356] = {id = 356, ShopType = 2007, level = 50, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30077, PayItemNum = 1}
, 
[357] = {id = 357, ShopType = 2007, level = 51, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 0, PayItemNum = 0}
, 
[358] = {id = 358, ShopType = 2008, level = 1, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 40000, PayItemID = 35002, PayItemNum = 120000}
, 
[359] = {id = 359, ShopType = 2008, level = 2, CoinID = 35017, CoinNum = 20, ItemID = 74003, ItemNum = 3, PayItemID = 74003, PayItemNum = 10}
, 
[360] = {id = 360, ShopType = 2008, level = 3, CoinID = 35017, CoinNum = 20, ItemID = 76000, ItemNum = 5, PayItemID = 75015, PayItemNum = 5}
, 
[361] = {id = 361, ShopType = 2008, level = 4, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[362] = {id = 362, ShopType = 2008, level = 5, CoinID = 35017, CoinNum = 20, ItemID = 35008, ItemNum = 80, PayItemID = 40103, PayItemNum = 1}
, 
[363] = {id = 363, ShopType = 2008, level = 6, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[364] = {id = 364, ShopType = 2008, level = 7, CoinID = 35017, CoinNum = 30, ItemID = 74003, ItemNum = 3, PayItemID = 75015, PayItemNum = 5}
, 
[365] = {id = 365, ShopType = 2008, level = 8, CoinID = 35017, CoinNum = 30, ItemID = 76000, ItemNum = 5, PayItemID = 76000, PayItemNum = 20}
, 
[366] = {id = 366, ShopType = 2008, level = 9, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[367] = {id = 367, ShopType = 2008, level = 10, CoinID = 35017, CoinNum = 30, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[368] = {id = 368, ShopType = 2008, level = 11, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[369] = {id = 369, ShopType = 2008, level = 12, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75016, PayItemNum = 5}
, 
[370] = {id = 370, ShopType = 2008, level = 13, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[371] = {id = 371, ShopType = 2008, level = 14, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[372] = {id = 372, ShopType = 2008, level = 15, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[373] = {id = 373, ShopType = 2008, level = 16, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[374] = {id = 374, ShopType = 2008, level = 17, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75016, PayItemNum = 10}
, 
[375] = {id = 375, ShopType = 2008, level = 18, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[376] = {id = 376, ShopType = 2008, level = 19, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[377] = {id = 377, ShopType = 2008, level = 20, CoinID = 35017, CoinNum = 40, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[378] = {id = 378, ShopType = 2008, level = 21, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[379] = {id = 379, ShopType = 2008, level = 22, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75017, PayItemNum = 10}
, 
[380] = {id = 380, ShopType = 2008, level = 23, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[381] = {id = 381, ShopType = 2008, level = 24, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[382] = {id = 382, ShopType = 2008, level = 25, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[383] = {id = 383, ShopType = 2008, level = 26, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[384] = {id = 384, ShopType = 2008, level = 27, CoinID = 35017, CoinNum = 40, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[385] = {id = 385, ShopType = 2008, level = 28, CoinID = 35017, CoinNum = 40, ItemID = 79002, ItemNum = 20, PayItemID = 79002, PayItemNum = 30}
, 
[386] = {id = 386, ShopType = 2008, level = 29, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 75017, PayItemNum = 10}
, 
[387] = {id = 387, ShopType = 2008, level = 30, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[388] = {id = 388, ShopType = 2008, level = 31, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[389] = {id = 389, ShopType = 2008, level = 32, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[390] = {id = 390, ShopType = 2008, level = 33, CoinID = 35017, CoinNum = 50, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[391] = {id = 391, ShopType = 2008, level = 34, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[392] = {id = 392, ShopType = 2008, level = 35, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[393] = {id = 393, ShopType = 2008, level = 36, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[394] = {id = 394, ShopType = 2008, level = 37, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[395] = {id = 395, ShopType = 2008, level = 38, CoinID = 35017, CoinNum = 50, ItemID = 79002, ItemNum = 20, PayItemID = 79002, PayItemNum = 30}
, 
[396] = {id = 396, ShopType = 2008, level = 39, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[397] = {id = 397, ShopType = 2008, level = 40, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[398] = {id = 398, ShopType = 2008, level = 41, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[399] = {id = 399, ShopType = 2008, level = 42, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[400] = {id = 400, ShopType = 2008, level = 43, CoinID = 35017, CoinNum = 50, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[401] = {id = 401, ShopType = 2008, level = 44, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[402] = {id = 402, ShopType = 2008, level = 45, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[403] = {id = 403, ShopType = 2008, level = 46, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[404] = {id = 404, ShopType = 2008, level = 47, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[405] = {id = 405, ShopType = 2008, level = 48, CoinID = 35017, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 79004, PayItemNum = 1}
, 
[406] = {id = 406, ShopType = 2008, level = 49, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[407] = {id = 407, ShopType = 2008, level = 50, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30077, PayItemNum = 1}
, 
[408] = {id = 408, ShopType = 2008, level = 51, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 0, PayItemNum = 0}
, 
[409] = {id = 409, ShopType = 2009, level = 1, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 40000, PayItemID = 35002, PayItemNum = 120000}
, 
[410] = {id = 410, ShopType = 2009, level = 2, CoinID = 35017, CoinNum = 20, ItemID = 74003, ItemNum = 3, PayItemID = 74003, PayItemNum = 10}
, 
[411] = {id = 411, ShopType = 2009, level = 3, CoinID = 35017, CoinNum = 20, ItemID = 76000, ItemNum = 5, PayItemID = 75009, PayItemNum = 5}
, 
[412] = {id = 412, ShopType = 2009, level = 4, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[413] = {id = 413, ShopType = 2009, level = 5, CoinID = 35017, CoinNum = 20, ItemID = 35008, ItemNum = 80, PayItemID = 40097, PayItemNum = 1}
, 
[414] = {id = 414, ShopType = 2009, level = 6, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[415] = {id = 415, ShopType = 2009, level = 7, CoinID = 35017, CoinNum = 30, ItemID = 74003, ItemNum = 3, PayItemID = 75009, PayItemNum = 5}
, 
[416] = {id = 416, ShopType = 2009, level = 8, CoinID = 35017, CoinNum = 30, ItemID = 76000, ItemNum = 5, PayItemID = 76000, PayItemNum = 20}
, 
[417] = {id = 417, ShopType = 2009, level = 9, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[418] = {id = 418, ShopType = 2009, level = 10, CoinID = 35017, CoinNum = 30, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[419] = {id = 419, ShopType = 2009, level = 11, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[420] = {id = 420, ShopType = 2009, level = 12, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75010, PayItemNum = 5}
, 
[421] = {id = 421, ShopType = 2009, level = 13, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[422] = {id = 422, ShopType = 2009, level = 14, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[423] = {id = 423, ShopType = 2009, level = 15, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[424] = {id = 424, ShopType = 2009, level = 16, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[425] = {id = 425, ShopType = 2009, level = 17, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75010, PayItemNum = 10}
, 
[426] = {id = 426, ShopType = 2009, level = 18, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[427] = {id = 427, ShopType = 2009, level = 19, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[428] = {id = 428, ShopType = 2009, level = 20, CoinID = 35017, CoinNum = 40, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[429] = {id = 429, ShopType = 2009, level = 21, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[430] = {id = 430, ShopType = 2009, level = 22, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75011, PayItemNum = 10}
, 
[431] = {id = 431, ShopType = 2009, level = 23, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[432] = {id = 432, ShopType = 2009, level = 24, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[433] = {id = 433, ShopType = 2009, level = 25, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[434] = {id = 434, ShopType = 2009, level = 26, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[435] = {id = 435, ShopType = 2009, level = 27, CoinID = 35017, CoinNum = 40, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[436] = {id = 436, ShopType = 2009, level = 28, CoinID = 35017, CoinNum = 40, ItemID = 79002, ItemNum = 20, PayItemID = 79002, PayItemNum = 30}
, 
[437] = {id = 437, ShopType = 2009, level = 29, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 75011, PayItemNum = 10}
, 
[438] = {id = 438, ShopType = 2009, level = 30, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[439] = {id = 439, ShopType = 2009, level = 31, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[440] = {id = 440, ShopType = 2009, level = 32, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[441] = {id = 441, ShopType = 2009, level = 33, CoinID = 35017, CoinNum = 50, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[442] = {id = 442, ShopType = 2009, level = 34, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[443] = {id = 443, ShopType = 2009, level = 35, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[444] = {id = 444, ShopType = 2009, level = 36, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[445] = {id = 445, ShopType = 2009, level = 37, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[446] = {id = 446, ShopType = 2009, level = 38, CoinID = 35017, CoinNum = 50, ItemID = 79002, ItemNum = 20, PayItemID = 79002, PayItemNum = 30}
, 
[447] = {id = 447, ShopType = 2009, level = 39, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[448] = {id = 448, ShopType = 2009, level = 40, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[449] = {id = 449, ShopType = 2009, level = 41, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[450] = {id = 450, ShopType = 2009, level = 42, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[451] = {id = 451, ShopType = 2009, level = 43, CoinID = 35017, CoinNum = 50, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[452] = {id = 452, ShopType = 2009, level = 44, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[453] = {id = 453, ShopType = 2009, level = 45, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[454] = {id = 454, ShopType = 2009, level = 46, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[455] = {id = 455, ShopType = 2009, level = 47, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[456] = {id = 456, ShopType = 2009, level = 48, CoinID = 35017, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 79004, PayItemNum = 1}
, 
[457] = {id = 457, ShopType = 2009, level = 49, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[458] = {id = 458, ShopType = 2009, level = 50, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30077, PayItemNum = 1}
, 
[459] = {id = 459, ShopType = 2009, level = 51, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 0, PayItemNum = 0}
, 
[460] = {id = 460, ShopType = 2010, level = 1, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 40000, PayItemID = 35002, PayItemNum = 120000}
, 
[461] = {id = 461, ShopType = 2010, level = 2, CoinID = 35017, CoinNum = 20, ItemID = 74003, ItemNum = 3, PayItemID = 74003, PayItemNum = 10}
, 
[462] = {id = 462, ShopType = 2010, level = 3, CoinID = 35017, CoinNum = 20, ItemID = 76000, ItemNum = 5, PayItemID = 75003, PayItemNum = 5}
, 
[463] = {id = 463, ShopType = 2010, level = 4, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[464] = {id = 464, ShopType = 2010, level = 5, CoinID = 35017, CoinNum = 20, ItemID = 35008, ItemNum = 80, PayItemID = 40116, PayItemNum = 1}
, 
[465] = {id = 465, ShopType = 2010, level = 6, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[466] = {id = 466, ShopType = 2010, level = 7, CoinID = 35017, CoinNum = 30, ItemID = 74003, ItemNum = 3, PayItemID = 75003, PayItemNum = 5}
, 
[467] = {id = 467, ShopType = 2010, level = 8, CoinID = 35017, CoinNum = 30, ItemID = 76000, ItemNum = 5, PayItemID = 76000, PayItemNum = 20}
, 
[468] = {id = 468, ShopType = 2010, level = 9, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[469] = {id = 469, ShopType = 2010, level = 10, CoinID = 35017, CoinNum = 30, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[470] = {id = 470, ShopType = 2010, level = 11, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[471] = {id = 471, ShopType = 2010, level = 12, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75004, PayItemNum = 5}
, 
[472] = {id = 472, ShopType = 2010, level = 13, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[473] = {id = 473, ShopType = 2010, level = 14, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[474] = {id = 474, ShopType = 2010, level = 15, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[475] = {id = 475, ShopType = 2010, level = 16, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[476] = {id = 476, ShopType = 2010, level = 17, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75004, PayItemNum = 10}
, 
[477] = {id = 477, ShopType = 2010, level = 18, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[478] = {id = 478, ShopType = 2010, level = 19, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[479] = {id = 479, ShopType = 2010, level = 20, CoinID = 35017, CoinNum = 40, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[480] = {id = 480, ShopType = 2010, level = 21, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[481] = {id = 481, ShopType = 2010, level = 22, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75005, PayItemNum = 10}
, 
[482] = {id = 482, ShopType = 2010, level = 23, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[483] = {id = 483, ShopType = 2010, level = 24, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[484] = {id = 484, ShopType = 2010, level = 25, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[485] = {id = 485, ShopType = 2010, level = 26, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[486] = {id = 486, ShopType = 2010, level = 27, CoinID = 35017, CoinNum = 40, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[487] = {id = 487, ShopType = 2010, level = 28, CoinID = 35017, CoinNum = 40, ItemID = 79002, ItemNum = 20, PayItemID = 79002, PayItemNum = 30}
, 
[488] = {id = 488, ShopType = 2010, level = 29, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 75005, PayItemNum = 10}
, 
[489] = {id = 489, ShopType = 2010, level = 30, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[490] = {id = 490, ShopType = 2010, level = 31, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[491] = {id = 491, ShopType = 2010, level = 32, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[492] = {id = 492, ShopType = 2010, level = 33, CoinID = 35017, CoinNum = 50, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[493] = {id = 493, ShopType = 2010, level = 34, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[494] = {id = 494, ShopType = 2010, level = 35, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[495] = {id = 495, ShopType = 2010, level = 36, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[496] = {id = 496, ShopType = 2010, level = 37, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[497] = {id = 497, ShopType = 2010, level = 38, CoinID = 35017, CoinNum = 50, ItemID = 79002, ItemNum = 20, PayItemID = 79002, PayItemNum = 30}
, 
[498] = {id = 498, ShopType = 2010, level = 39, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[499] = {id = 499, ShopType = 2010, level = 40, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[500] = {id = 500, ShopType = 2010, level = 41, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[501] = {id = 501, ShopType = 2010, level = 42, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[502] = {id = 502, ShopType = 2010, level = 43, CoinID = 35017, CoinNum = 50, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[503] = {id = 503, ShopType = 2010, level = 44, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[504] = {id = 504, ShopType = 2010, level = 45, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[505] = {id = 505, ShopType = 2010, level = 46, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[506] = {id = 506, ShopType = 2010, level = 47, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[507] = {id = 507, ShopType = 2010, level = 48, CoinID = 35017, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 79004, PayItemNum = 1}
, 
[508] = {id = 508, ShopType = 2010, level = 49, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[509] = {id = 509, ShopType = 2010, level = 50, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30077, PayItemNum = 1}
, 
[510] = {id = 510, ShopType = 2010, level = 51, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 0, PayItemNum = 0}
, 
[511] = {id = 511, ShopType = 2011, level = 1, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 40000, PayItemID = 35002, PayItemNum = 120000}
, 
[512] = {id = 512, ShopType = 2011, level = 2, CoinID = 35017, CoinNum = 20, ItemID = 74003, ItemNum = 3, PayItemID = 74003, PayItemNum = 10}
, 
[513] = {id = 513, ShopType = 2011, level = 3, CoinID = 35017, CoinNum = 20, ItemID = 76000, ItemNum = 5, PayItemID = 75003, PayItemNum = 5}
, 
[514] = {id = 514, ShopType = 2011, level = 4, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[515] = {id = 515, ShopType = 2011, level = 5, CoinID = 35017, CoinNum = 20, ItemID = 35008, ItemNum = 80, PayItemID = 40081, PayItemNum = 1}
, 
[516] = {id = 516, ShopType = 2011, level = 6, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[517] = {id = 517, ShopType = 2011, level = 7, CoinID = 35017, CoinNum = 30, ItemID = 74003, ItemNum = 3, PayItemID = 75003, PayItemNum = 5}
, 
[518] = {id = 518, ShopType = 2011, level = 8, CoinID = 35017, CoinNum = 30, ItemID = 76000, ItemNum = 5, PayItemID = 76000, PayItemNum = 20}
, 
[519] = {id = 519, ShopType = 2011, level = 9, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[520] = {id = 520, ShopType = 2011, level = 10, CoinID = 35017, CoinNum = 30, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[521] = {id = 521, ShopType = 2011, level = 11, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[522] = {id = 522, ShopType = 2011, level = 12, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75004, PayItemNum = 5}
, 
[523] = {id = 523, ShopType = 2011, level = 13, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[524] = {id = 524, ShopType = 2011, level = 14, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[525] = {id = 525, ShopType = 2011, level = 15, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[526] = {id = 526, ShopType = 2011, level = 16, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[527] = {id = 527, ShopType = 2011, level = 17, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75004, PayItemNum = 10}
, 
[528] = {id = 528, ShopType = 2011, level = 18, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[529] = {id = 529, ShopType = 2011, level = 19, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[530] = {id = 530, ShopType = 2011, level = 20, CoinID = 35017, CoinNum = 40, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[531] = {id = 531, ShopType = 2011, level = 21, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[532] = {id = 532, ShopType = 2011, level = 22, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75005, PayItemNum = 10}
, 
[533] = {id = 533, ShopType = 2011, level = 23, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[534] = {id = 534, ShopType = 2011, level = 24, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[535] = {id = 535, ShopType = 2011, level = 25, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[536] = {id = 536, ShopType = 2011, level = 26, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[537] = {id = 537, ShopType = 2011, level = 27, CoinID = 35017, CoinNum = 40, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[538] = {id = 538, ShopType = 2011, level = 28, CoinID = 35017, CoinNum = 40, ItemID = 79002, ItemNum = 20, PayItemID = 79002, PayItemNum = 30}
, 
[539] = {id = 539, ShopType = 2011, level = 29, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 75005, PayItemNum = 10}
, 
[540] = {id = 540, ShopType = 2011, level = 30, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[541] = {id = 541, ShopType = 2011, level = 31, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[542] = {id = 542, ShopType = 2011, level = 32, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[543] = {id = 543, ShopType = 2011, level = 33, CoinID = 35017, CoinNum = 50, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[544] = {id = 544, ShopType = 2011, level = 34, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[545] = {id = 545, ShopType = 2011, level = 35, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[546] = {id = 546, ShopType = 2011, level = 36, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[547] = {id = 547, ShopType = 2011, level = 37, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[548] = {id = 548, ShopType = 2011, level = 38, CoinID = 35017, CoinNum = 50, ItemID = 79002, ItemNum = 20, PayItemID = 79002, PayItemNum = 30}
, 
[549] = {id = 549, ShopType = 2011, level = 39, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[550] = {id = 550, ShopType = 2011, level = 40, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[551] = {id = 551, ShopType = 2011, level = 41, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[552] = {id = 552, ShopType = 2011, level = 42, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[553] = {id = 553, ShopType = 2011, level = 43, CoinID = 35017, CoinNum = 50, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[554] = {id = 554, ShopType = 2011, level = 44, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[555] = {id = 555, ShopType = 2011, level = 45, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[556] = {id = 556, ShopType = 2011, level = 46, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[557] = {id = 557, ShopType = 2011, level = 47, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[558] = {id = 558, ShopType = 2011, level = 48, CoinID = 35017, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 79004, PayItemNum = 1}
, 
[559] = {id = 559, ShopType = 2011, level = 49, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[560] = {id = 560, ShopType = 2011, level = 50, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30077, PayItemNum = 1}
, 
[561] = {id = 561, ShopType = 2011, level = 51, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 0, PayItemNum = 0}
, 
[562] = {id = 562, ShopType = 2012, level = 1, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 40000, PayItemID = 35002, PayItemNum = 120000}
, 
[563] = {id = 563, ShopType = 2012, level = 2, CoinID = 35017, CoinNum = 20, ItemID = 74003, ItemNum = 3, PayItemID = 74003, PayItemNum = 10}
, 
[564] = {id = 564, ShopType = 2012, level = 3, CoinID = 35017, CoinNum = 20, ItemID = 76000, ItemNum = 5, PayItemID = 75015, PayItemNum = 5}
, 
[565] = {id = 565, ShopType = 2012, level = 4, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[566] = {id = 566, ShopType = 2012, level = 5, CoinID = 35017, CoinNum = 20, ItemID = 35008, ItemNum = 80, PayItemID = 40117, PayItemNum = 1}
, 
[567] = {id = 567, ShopType = 2012, level = 6, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[568] = {id = 568, ShopType = 2012, level = 7, CoinID = 35017, CoinNum = 30, ItemID = 74003, ItemNum = 3, PayItemID = 75015, PayItemNum = 5}
, 
[569] = {id = 569, ShopType = 2012, level = 8, CoinID = 35017, CoinNum = 30, ItemID = 76000, ItemNum = 5, PayItemID = 76000, PayItemNum = 20}
, 
[570] = {id = 570, ShopType = 2012, level = 9, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[571] = {id = 571, ShopType = 2012, level = 10, CoinID = 35017, CoinNum = 30, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[572] = {id = 572, ShopType = 2012, level = 11, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[573] = {id = 573, ShopType = 2012, level = 12, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75016, PayItemNum = 5}
, 
[574] = {id = 574, ShopType = 2012, level = 13, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[575] = {id = 575, ShopType = 2012, level = 14, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[576] = {id = 576, ShopType = 2012, level = 15, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[577] = {id = 577, ShopType = 2012, level = 16, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[578] = {id = 578, ShopType = 2012, level = 17, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75016, PayItemNum = 10}
, 
[579] = {id = 579, ShopType = 2012, level = 18, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[580] = {id = 580, ShopType = 2012, level = 19, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[581] = {id = 581, ShopType = 2012, level = 20, CoinID = 35017, CoinNum = 40, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[582] = {id = 582, ShopType = 2012, level = 21, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[583] = {id = 583, ShopType = 2012, level = 22, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75017, PayItemNum = 10}
, 
[584] = {id = 584, ShopType = 2012, level = 23, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[585] = {id = 585, ShopType = 2012, level = 24, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[586] = {id = 586, ShopType = 2012, level = 25, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[587] = {id = 587, ShopType = 2012, level = 26, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[588] = {id = 588, ShopType = 2012, level = 27, CoinID = 35017, CoinNum = 40, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[589] = {id = 589, ShopType = 2012, level = 28, CoinID = 35017, CoinNum = 40, ItemID = 79002, ItemNum = 20, PayItemID = 79002, PayItemNum = 30}
, 
[590] = {id = 590, ShopType = 2012, level = 29, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 75017, PayItemNum = 10}
, 
[591] = {id = 591, ShopType = 2012, level = 30, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[592] = {id = 592, ShopType = 2012, level = 31, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[593] = {id = 593, ShopType = 2012, level = 32, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[594] = {id = 594, ShopType = 2012, level = 33, CoinID = 35017, CoinNum = 50, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[595] = {id = 595, ShopType = 2012, level = 34, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[596] = {id = 596, ShopType = 2012, level = 35, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[597] = {id = 597, ShopType = 2012, level = 36, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[598] = {id = 598, ShopType = 2012, level = 37, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[599] = {id = 599, ShopType = 2012, level = 38, CoinID = 35017, CoinNum = 50, ItemID = 79002, ItemNum = 20, PayItemID = 79002, PayItemNum = 30}
, 
[600] = {id = 600, ShopType = 2012, level = 39, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[601] = {id = 601, ShopType = 2012, level = 40, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[602] = {id = 602, ShopType = 2012, level = 41, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[603] = {id = 603, ShopType = 2012, level = 42, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[604] = {id = 604, ShopType = 2012, level = 43, CoinID = 35017, CoinNum = 50, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[605] = {id = 605, ShopType = 2012, level = 44, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[606] = {id = 606, ShopType = 2012, level = 45, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[607] = {id = 607, ShopType = 2012, level = 46, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[608] = {id = 608, ShopType = 2012, level = 47, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[609] = {id = 609, ShopType = 2012, level = 48, CoinID = 35017, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 79004, PayItemNum = 1}
, 
[610] = {id = 610, ShopType = 2012, level = 49, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[611] = {id = 611, ShopType = 2012, level = 50, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30077, PayItemNum = 1}
, 
[612] = {id = 612, ShopType = 2012, level = 51, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 0, PayItemNum = 0}
, 
[613] = {id = 613, ShopType = 2013, level = 1, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 40000, PayItemID = 35002, PayItemNum = 120000}
, 
[614] = {id = 614, ShopType = 2013, level = 2, CoinID = 35017, CoinNum = 20, ItemID = 74003, ItemNum = 3, PayItemID = 74003, PayItemNum = 10}
, 
[615] = {id = 615, ShopType = 2013, level = 3, CoinID = 35017, CoinNum = 20, ItemID = 76000, ItemNum = 5, PayItemID = 75003, PayItemNum = 5}
, 
[616] = {id = 616, ShopType = 2013, level = 4, CoinID = 35017, CoinNum = 20, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[617] = {id = 617, ShopType = 2013, level = 5, CoinID = 35017, CoinNum = 20, ItemID = 35008, ItemNum = 80, PayItemID = 40016, PayItemNum = 1}
, 
[618] = {id = 618, ShopType = 2013, level = 6, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 120000, PayItemID = 35002, PayItemNum = 360000}
, 
[619] = {id = 619, ShopType = 2013, level = 7, CoinID = 35017, CoinNum = 30, ItemID = 74003, ItemNum = 3, PayItemID = 75003, PayItemNum = 5}
, 
[620] = {id = 620, ShopType = 2013, level = 8, CoinID = 35017, CoinNum = 30, ItemID = 76000, ItemNum = 5, PayItemID = 76000, PayItemNum = 20}
, 
[621] = {id = 621, ShopType = 2013, level = 9, CoinID = 35017, CoinNum = 30, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[622] = {id = 622, ShopType = 2013, level = 10, CoinID = 35017, CoinNum = 30, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[623] = {id = 623, ShopType = 2013, level = 11, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[624] = {id = 624, ShopType = 2013, level = 12, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75004, PayItemNum = 5}
, 
[625] = {id = 625, ShopType = 2013, level = 13, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[626] = {id = 626, ShopType = 2013, level = 14, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[627] = {id = 627, ShopType = 2013, level = 15, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[628] = {id = 628, ShopType = 2013, level = 16, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[629] = {id = 629, ShopType = 2013, level = 17, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75004, PayItemNum = 10}
, 
[630] = {id = 630, ShopType = 2013, level = 18, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[631] = {id = 631, ShopType = 2013, level = 19, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[632] = {id = 632, ShopType = 2013, level = 20, CoinID = 35017, CoinNum = 40, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[633] = {id = 633, ShopType = 2013, level = 21, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[634] = {id = 634, ShopType = 2013, level = 22, CoinID = 35017, CoinNum = 40, ItemID = 74003, ItemNum = 10, PayItemID = 75005, PayItemNum = 10}
, 
[635] = {id = 635, ShopType = 2013, level = 23, CoinID = 35017, CoinNum = 40, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[636] = {id = 636, ShopType = 2013, level = 24, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[637] = {id = 637, ShopType = 2013, level = 25, CoinID = 35017, CoinNum = 40, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[638] = {id = 638, ShopType = 2013, level = 26, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[639] = {id = 639, ShopType = 2013, level = 27, CoinID = 35017, CoinNum = 40, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[640] = {id = 640, ShopType = 2013, level = 28, CoinID = 35017, CoinNum = 40, ItemID = 79002, ItemNum = 20, PayItemID = 79002, PayItemNum = 30}
, 
[641] = {id = 641, ShopType = 2013, level = 29, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 75005, PayItemNum = 10}
, 
[642] = {id = 642, ShopType = 2013, level = 30, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[643] = {id = 643, ShopType = 2013, level = 31, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[644] = {id = 644, ShopType = 2013, level = 32, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[645] = {id = 645, ShopType = 2013, level = 33, CoinID = 35017, CoinNum = 50, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[646] = {id = 646, ShopType = 2013, level = 34, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[647] = {id = 647, ShopType = 2013, level = 35, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[648] = {id = 648, ShopType = 2013, level = 36, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[649] = {id = 649, ShopType = 2013, level = 37, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[650] = {id = 650, ShopType = 2013, level = 38, CoinID = 35017, CoinNum = 50, ItemID = 79002, ItemNum = 20, PayItemID = 79002, PayItemNum = 30}
, 
[651] = {id = 651, ShopType = 2013, level = 39, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[652] = {id = 652, ShopType = 2013, level = 40, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 4}
, 
[653] = {id = 653, ShopType = 2013, level = 41, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[654] = {id = 654, ShopType = 2013, level = 42, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[655] = {id = 655, ShopType = 2013, level = 43, CoinID = 35017, CoinNum = 50, ItemID = 79001, ItemNum = 30, PayItemID = 79001, PayItemNum = 50}
, 
[656] = {id = 656, ShopType = 2013, level = 44, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[657] = {id = 657, ShopType = 2013, level = 45, CoinID = 35017, CoinNum = 50, ItemID = 35008, ItemNum = 80, PayItemID = 35008, PayItemNum = 320}
, 
[658] = {id = 658, ShopType = 2013, level = 46, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[659] = {id = 659, ShopType = 2013, level = 47, CoinID = 35017, CoinNum = 50, ItemID = 74000, ItemNum = 10, PayItemID = 74000, PayItemNum = 30}
, 
[660] = {id = 660, ShopType = 2013, level = 48, CoinID = 35017, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 79004, PayItemNum = 1}
, 
[661] = {id = 661, ShopType = 2013, level = 49, CoinID = 35017, CoinNum = 50, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 600000}
, 
[662] = {id = 662, ShopType = 2013, level = 50, CoinID = 35017, CoinNum = 50, ItemID = 30076, ItemNum = 1, PayItemID = 30077, PayItemNum = 1}
, 
[663] = {id = 663, ShopType = 2013, level = 51, CoinID = 35017, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 0, PayItemNum = 0}
}
cseasonpassreward.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 497, 498, 499, 500, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511, 512, 513, 514, 515, 516, 517, 518, 519, 520, 521, 522, 523, 524, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 549, 550, 551, 552, 553, 554, 555, 556, 557, 558, 559, 560, 561, 562, 563, 564, 565, 566, 567, 568, 569, 570, 571, 572, 573, 574, 575, 576, 577, 578, 579, 580, 581, 582, 583, 584, 585, 586, 587, 588, 589, 590, 591, 592, 593, 594, 595, 596, 597, 598, 599, 600, 601, 602, 603, 604, 605, 606, 607, 608, 609, 610, 611, 612, 613, 614, 615, 616, 617, 618, 619, 620, 621, 622, 623, 624, 625, 626, 627, 628, 629, 630, 631, 632, 633, 634, 635, 636, 637, 638, 639, 640, 641, 642, 643, 644, 645, 646, 647, 648, 649, 650, 651, 652, 653, 654, 655, 656, 657, 658, 659, 660, 661, 662, 663}
return cseasonpassreward

