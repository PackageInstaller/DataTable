-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/activity/clittlebattlepassreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local clittlebattlepassreward = {}
clittlebattlepassreward.Data = {
[101] = {id = 101, ShopType = 39001, level = 1, CoinID = 35058, CoinNum = 20, ItemID = 35002, ItemNum = 50000, PayItemID = 35002, PayItemNum = 100000}
, 
[102] = {id = 102, ShopType = 39001, level = 2, CoinID = 35058, CoinNum = 20, ItemID = 74003, ItemNum = 3, PayItemID = 74003, PayItemNum = 5}
, 
[103] = {id = 103, ShopType = 39001, level = 3, CoinID = 35058, CoinNum = 20, ItemID = 76002, ItemNum = 10, PayItemID = 76003, PayItemNum = 10}
, 
[104] = {id = 104, ShopType = 39001, level = 4, CoinID = 35058, CoinNum = 20, ItemID = 35002, ItemNum = 100000, PayItemID = 35002, PayItemNum = 200000}
, 
[105] = {id = 105, ShopType = 39001, level = 5, CoinID = 35058, CoinNum = 20, ItemID = 75004, ItemNum = 5, PayItemID = 35008, PayItemNum = 60}
, 
[106] = {id = 106, ShopType = 39001, level = 6, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 100000, PayItemID = 35002, PayItemNum = 200000}
, 
[107] = {id = 107, ShopType = 39001, level = 7, CoinID = 35058, CoinNum = 30, ItemID = 74000, ItemNum = 5, PayItemID = 74001, PayItemNum = 5}
, 
[108] = {id = 108, ShopType = 39001, level = 8, CoinID = 35058, CoinNum = 30, ItemID = 79001, ItemNum = 10, PayItemID = 79001, PayItemNum = 20}
, 
[109] = {id = 109, ShopType = 39001, level = 9, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 100000, PayItemID = 35002, PayItemNum = 200000}
, 
[110] = {id = 110, ShopType = 39001, level = 10, CoinID = 35058, CoinNum = 30, ItemID = 75007, ItemNum = 5, PayItemID = 35008, PayItemNum = 100}
, 
[111] = {id = 111, ShopType = 39001, level = 11, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 400000}
, 
[112] = {id = 112, ShopType = 39001, level = 12, CoinID = 35058, CoinNum = 40, ItemID = 74001, ItemNum = 5, PayItemID = 74001, PayItemNum = 10}
, 
[113] = {id = 113, ShopType = 39001, level = 13, CoinID = 35058, CoinNum = 40, ItemID = 76003, ItemNum = 10, PayItemID = 76004, PayItemNum = 10}
, 
[114] = {id = 114, ShopType = 39001, level = 14, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 400000}
, 
[115] = {id = 115, ShopType = 39001, level = 15, CoinID = 35058, CoinNum = 40, ItemID = 75018, ItemNum = 2, PayItemID = 35008, PayItemNum = 100}
, 
[116] = {id = 116, ShopType = 39001, level = 16, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 400000}
, 
[117] = {id = 117, ShopType = 39001, level = 17, CoinID = 35058, CoinNum = 40, ItemID = 79002, ItemNum = 2, PayItemID = 79002, PayItemNum = 5}
, 
[118] = {id = 118, ShopType = 39001, level = 18, CoinID = 35058, CoinNum = 40, ItemID = 76004, ItemNum = 10, PayItemID = 76005, PayItemNum = 10}
, 
[119] = {id = 119, ShopType = 39001, level = 19, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 400000}
, 
[120] = {id = 120, ShopType = 39001, level = 20, CoinID = 35058, CoinNum = 40, ItemID = 75005, ItemNum = 5, PayItemID = 35008, PayItemNum = 200}
, 
[121] = {id = 121, ShopType = 39001, level = 21, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 35002, PayItemNum = 400000}
, 
[122] = {id = 122, ShopType = 39001, level = 22, CoinID = 35058, CoinNum = 40, ItemID = 74002, ItemNum = 5, PayItemID = 74002, PayItemNum = 10}
, 
[123] = {id = 123, ShopType = 39001, level = 23, CoinID = 35058, CoinNum = 40, ItemID = 35026, ItemNum = 5, PayItemID = 35026, PayItemNum = 10}
, 
[124] = {id = 124, ShopType = 39001, level = 24, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 300000, PayItemID = 35002, PayItemNum = 600000}
, 
[125] = {id = 125, ShopType = 39001, level = 25, CoinID = 35058, CoinNum = 40, ItemID = 75008, ItemNum = 5, PayItemID = 95103, PayItemNum = 1}
, 
[126] = {id = 126, ShopType = 39001, level = 26, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 300000, PayItemID = 35002, PayItemNum = 600000}
, 
[127] = {id = 127, ShopType = 39001, level = 27, CoinID = 35058, CoinNum = 40, ItemID = 70002, ItemNum = 1, PayItemID = 70002, PayItemNum = 2}
, 
[128] = {id = 128, ShopType = 39001, level = 28, CoinID = 35058, CoinNum = 40, ItemID = 79002, ItemNum = 5, PayItemID = 79004, PayItemNum = 1}
, 
[129] = {id = 129, ShopType = 39001, level = 29, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 300000, PayItemID = 35002, PayItemNum = 600000}
, 
[130] = {id = 130, ShopType = 39001, level = 30, CoinID = 35058, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 30076, PayItemNum = 2}
, 
[131] = {id = 131, ShopType = 39001, level = -1, CoinID = 35058, CoinNum = 50, ItemID = 35002, ItemNum = 100000, PayItemID = 35002, PayItemNum = 200000}
, 
[132] = {id = 132, ShopType = 39001, level = -2, CoinID = 35058, CoinNum = 50, ItemID = 79001, ItemNum = 10, PayItemID = 79001, PayItemNum = 20}
, 
[133] = {id = 133, ShopType = 39001, level = -3, CoinID = 35058, CoinNum = 50, ItemID = 74002, ItemNum = 5, PayItemID = 35008, PayItemNum = 40}
, 
[134] = {id = 134, ShopType = 39002, level = 1, CoinID = 35058, CoinNum = 20, ItemID = 35002, ItemNum = 50000, PayItemID = 31380, PayItemNum = 5}
, 
[135] = {id = 135, ShopType = 39002, level = 2, CoinID = 35058, CoinNum = 20, ItemID = 31380, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[136] = {id = 136, ShopType = 39002, level = 3, CoinID = 35058, CoinNum = 20, ItemID = 74003, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[137] = {id = 137, ShopType = 39002, level = 4, CoinID = 35058, CoinNum = 20, ItemID = 31386, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[138] = {id = 138, ShopType = 39002, level = 5, CoinID = 35058, CoinNum = 20, ItemID = 79001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[139] = {id = 139, ShopType = 39002, level = 6, CoinID = 35058, CoinNum = 30, ItemID = 31383, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[140] = {id = 140, ShopType = 39002, level = 7, CoinID = 35058, CoinNum = 30, ItemID = 74000, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[141] = {id = 141, ShopType = 39002, level = 8, CoinID = 35058, CoinNum = 30, ItemID = 31389, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[142] = {id = 142, ShopType = 39002, level = 9, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 100000, PayItemID = 31380, PayItemNum = 5}
, 
[143] = {id = 143, ShopType = 39002, level = 10, CoinID = 35058, CoinNum = 30, ItemID = 70001, ItemNum = 1, PayItemID = 31386, PayItemNum = 5}
, 
[144] = {id = 144, ShopType = 39002, level = 11, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 5}
, 
[145] = {id = 145, ShopType = 39002, level = 12, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[146] = {id = 146, ShopType = 39002, level = 13, CoinID = 35058, CoinNum = 40, ItemID = 74001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[147] = {id = 147, ShopType = 39002, level = 14, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 10, PayItemID = 31386, PayItemNum = 5}
, 
[148] = {id = 148, ShopType = 39002, level = 15, CoinID = 35058, CoinNum = 40, ItemID = 74002, ItemNum = 10, PayItemID = 31383, PayItemNum = 5}
, 
[149] = {id = 149, ShopType = 39002, level = 16, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[150] = {id = 150, ShopType = 39002, level = 17, CoinID = 35058, CoinNum = 40, ItemID = 79002, ItemNum = 2, PayItemID = 31380, PayItemNum = 10}
, 
[151] = {id = 151, ShopType = 39002, level = 18, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 10, PayItemID = 31386, PayItemNum = 10}
, 
[152] = {id = 152, ShopType = 39002, level = 19, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 10}
, 
[153] = {id = 153, ShopType = 39002, level = 20, CoinID = 35058, CoinNum = 40, ItemID = 74004, ItemNum = 5, PayItemID = 31389, PayItemNum = 10}
, 
[154] = {id = 154, ShopType = 39002, level = 21, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31381, PayItemNum = 5}
, 
[155] = {id = 155, ShopType = 39002, level = 22, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 15, PayItemID = 31387, PayItemNum = 5}
, 
[156] = {id = 156, ShopType = 39002, level = 23, CoinID = 35058, CoinNum = 40, ItemID = 35026, ItemNum = 10, PayItemID = 31384, PayItemNum = 5}
, 
[157] = {id = 157, ShopType = 39002, level = 24, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 15, PayItemID = 31390, PayItemNum = 5}
, 
[158] = {id = 158, ShopType = 39002, level = 25, CoinID = 35058, CoinNum = 40, ItemID = 74005, ItemNum = 5, PayItemID = 95102, PayItemNum = 1}
, 
[159] = {id = 159, ShopType = 39002, level = 26, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 15, PayItemID = 31381, PayItemNum = 10}
, 
[160] = {id = 160, ShopType = 39002, level = 27, CoinID = 35058, CoinNum = 40, ItemID = 70002, ItemNum = 1, PayItemID = 31387, PayItemNum = 10}
, 
[161] = {id = 161, ShopType = 39002, level = 28, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 15, PayItemID = 31384, PayItemNum = 10}
, 
[162] = {id = 162, ShopType = 39002, level = 29, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 300000, PayItemID = 31390, PayItemNum = 10}
, 
[163] = {id = 163, ShopType = 39002, level = 30, CoinID = 35058, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 30076, PayItemNum = 2}
, 
[164] = {id = 164, ShopType = 39002, level = -1, CoinID = 35058, CoinNum = 50, ItemID = 35002, ItemNum = 100000, PayItemID = 35002, PayItemNum = 200000}
, 
[165] = {id = 165, ShopType = 39002, level = -2, CoinID = 35058, CoinNum = 50, ItemID = 79001, ItemNum = 10, PayItemID = 79001, PayItemNum = 20}
, 
[166] = {id = 166, ShopType = 39002, level = -3, CoinID = 35058, CoinNum = 50, ItemID = 74002, ItemNum = 5, PayItemID = 35008, PayItemNum = 40}
, 
[167] = {id = 167, ShopType = 39003, level = 1, CoinID = 35058, CoinNum = 20, ItemID = 35002, ItemNum = 50000, PayItemID = 31380, PayItemNum = 5}
, 
[168] = {id = 168, ShopType = 39003, level = 2, CoinID = 35058, CoinNum = 20, ItemID = 31380, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[169] = {id = 169, ShopType = 39003, level = 3, CoinID = 35058, CoinNum = 20, ItemID = 74003, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[170] = {id = 170, ShopType = 39003, level = 4, CoinID = 35058, CoinNum = 20, ItemID = 31386, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[171] = {id = 171, ShopType = 39003, level = 5, CoinID = 35058, CoinNum = 20, ItemID = 79001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[172] = {id = 172, ShopType = 39003, level = 6, CoinID = 35058, CoinNum = 30, ItemID = 31383, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[173] = {id = 173, ShopType = 39003, level = 7, CoinID = 35058, CoinNum = 30, ItemID = 74000, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[174] = {id = 174, ShopType = 39003, level = 8, CoinID = 35058, CoinNum = 30, ItemID = 31389, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[175] = {id = 175, ShopType = 39003, level = 9, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 100000, PayItemID = 31380, PayItemNum = 5}
, 
[176] = {id = 176, ShopType = 39003, level = 10, CoinID = 35058, CoinNum = 30, ItemID = 70001, ItemNum = 1, PayItemID = 31386, PayItemNum = 5}
, 
[177] = {id = 177, ShopType = 39003, level = 11, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 5}
, 
[178] = {id = 178, ShopType = 39003, level = 12, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[179] = {id = 179, ShopType = 39003, level = 13, CoinID = 35058, CoinNum = 40, ItemID = 74001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[180] = {id = 180, ShopType = 39003, level = 14, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 10, PayItemID = 31386, PayItemNum = 5}
, 
[181] = {id = 181, ShopType = 39003, level = 15, CoinID = 35058, CoinNum = 40, ItemID = 74002, ItemNum = 10, PayItemID = 31383, PayItemNum = 5}
, 
[182] = {id = 182, ShopType = 39003, level = 16, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[183] = {id = 183, ShopType = 39003, level = 17, CoinID = 35058, CoinNum = 40, ItemID = 79002, ItemNum = 2, PayItemID = 31380, PayItemNum = 10}
, 
[184] = {id = 184, ShopType = 39003, level = 18, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 10, PayItemID = 31386, PayItemNum = 10}
, 
[185] = {id = 185, ShopType = 39003, level = 19, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 10}
, 
[186] = {id = 186, ShopType = 39003, level = 20, CoinID = 35058, CoinNum = 40, ItemID = 74004, ItemNum = 5, PayItemID = 31389, PayItemNum = 10}
, 
[187] = {id = 187, ShopType = 39003, level = 21, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31381, PayItemNum = 5}
, 
[188] = {id = 188, ShopType = 39003, level = 22, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 15, PayItemID = 31387, PayItemNum = 5}
, 
[189] = {id = 189, ShopType = 39003, level = 23, CoinID = 35058, CoinNum = 40, ItemID = 35026, ItemNum = 10, PayItemID = 31384, PayItemNum = 5}
, 
[190] = {id = 190, ShopType = 39003, level = 24, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 15, PayItemID = 31390, PayItemNum = 5}
, 
[191] = {id = 191, ShopType = 39003, level = 25, CoinID = 35058, CoinNum = 40, ItemID = 74005, ItemNum = 5, PayItemID = 95094, PayItemNum = 1}
, 
[192] = {id = 192, ShopType = 39003, level = 26, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 15, PayItemID = 31381, PayItemNum = 10}
, 
[193] = {id = 193, ShopType = 39003, level = 27, CoinID = 35058, CoinNum = 40, ItemID = 70002, ItemNum = 1, PayItemID = 31387, PayItemNum = 10}
, 
[194] = {id = 194, ShopType = 39003, level = 28, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 15, PayItemID = 31384, PayItemNum = 10}
, 
[195] = {id = 195, ShopType = 39003, level = 29, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 300000, PayItemID = 31390, PayItemNum = 10}
, 
[196] = {id = 196, ShopType = 39003, level = 30, CoinID = 35058, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 30076, PayItemNum = 2}
, 
[197] = {id = 197, ShopType = 39003, level = -1, CoinID = 35058, CoinNum = 50, ItemID = 35002, ItemNum = 100000, PayItemID = 35002, PayItemNum = 200000}
, 
[198] = {id = 198, ShopType = 39003, level = -2, CoinID = 35058, CoinNum = 50, ItemID = 79001, ItemNum = 10, PayItemID = 79001, PayItemNum = 20}
, 
[199] = {id = 199, ShopType = 39003, level = -3, CoinID = 35058, CoinNum = 50, ItemID = 74002, ItemNum = 5, PayItemID = 35008, PayItemNum = 40}
, 
[200] = {id = 200, ShopType = 39004, level = 1, CoinID = 35058, CoinNum = 20, ItemID = 35002, ItemNum = 50000, PayItemID = 31380, PayItemNum = 5}
, 
[201] = {id = 201, ShopType = 39004, level = 2, CoinID = 35058, CoinNum = 20, ItemID = 31380, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[202] = {id = 202, ShopType = 39004, level = 3, CoinID = 35058, CoinNum = 20, ItemID = 74003, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[203] = {id = 203, ShopType = 39004, level = 4, CoinID = 35058, CoinNum = 20, ItemID = 31386, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[204] = {id = 204, ShopType = 39004, level = 5, CoinID = 35058, CoinNum = 20, ItemID = 79001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[205] = {id = 205, ShopType = 39004, level = 6, CoinID = 35058, CoinNum = 30, ItemID = 31383, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[206] = {id = 206, ShopType = 39004, level = 7, CoinID = 35058, CoinNum = 30, ItemID = 74000, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[207] = {id = 207, ShopType = 39004, level = 8, CoinID = 35058, CoinNum = 30, ItemID = 31389, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[208] = {id = 208, ShopType = 39004, level = 9, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 100000, PayItemID = 31380, PayItemNum = 5}
, 
[209] = {id = 209, ShopType = 39004, level = 10, CoinID = 35058, CoinNum = 30, ItemID = 70001, ItemNum = 1, PayItemID = 31386, PayItemNum = 5}
, 
[210] = {id = 210, ShopType = 39004, level = 11, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 5}
, 
[211] = {id = 211, ShopType = 39004, level = 12, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[212] = {id = 212, ShopType = 39004, level = 13, CoinID = 35058, CoinNum = 40, ItemID = 74001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[213] = {id = 213, ShopType = 39004, level = 14, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 10, PayItemID = 31386, PayItemNum = 5}
, 
[214] = {id = 214, ShopType = 39004, level = 15, CoinID = 35058, CoinNum = 40, ItemID = 74002, ItemNum = 10, PayItemID = 31383, PayItemNum = 5}
, 
[215] = {id = 215, ShopType = 39004, level = 16, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[216] = {id = 216, ShopType = 39004, level = 17, CoinID = 35058, CoinNum = 40, ItemID = 79002, ItemNum = 2, PayItemID = 31380, PayItemNum = 10}
, 
[217] = {id = 217, ShopType = 39004, level = 18, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 10, PayItemID = 31386, PayItemNum = 10}
, 
[218] = {id = 218, ShopType = 39004, level = 19, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 10}
, 
[219] = {id = 219, ShopType = 39004, level = 20, CoinID = 35058, CoinNum = 40, ItemID = 74004, ItemNum = 5, PayItemID = 31389, PayItemNum = 10}
, 
[220] = {id = 220, ShopType = 39004, level = 21, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31381, PayItemNum = 5}
, 
[221] = {id = 221, ShopType = 39004, level = 22, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 15, PayItemID = 31387, PayItemNum = 5}
, 
[222] = {id = 222, ShopType = 39004, level = 23, CoinID = 35058, CoinNum = 40, ItemID = 35026, ItemNum = 10, PayItemID = 31384, PayItemNum = 5}
, 
[223] = {id = 223, ShopType = 39004, level = 24, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 15, PayItemID = 31390, PayItemNum = 5}
, 
[224] = {id = 224, ShopType = 39004, level = 25, CoinID = 35058, CoinNum = 40, ItemID = 74005, ItemNum = 5, PayItemID = 95097, PayItemNum = 1}
, 
[225] = {id = 225, ShopType = 39004, level = 26, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 15, PayItemID = 31381, PayItemNum = 10}
, 
[226] = {id = 226, ShopType = 39004, level = 27, CoinID = 35058, CoinNum = 40, ItemID = 70002, ItemNum = 1, PayItemID = 31387, PayItemNum = 10}
, 
[227] = {id = 227, ShopType = 39004, level = 28, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 15, PayItemID = 31384, PayItemNum = 10}
, 
[228] = {id = 228, ShopType = 39004, level = 29, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 300000, PayItemID = 31390, PayItemNum = 10}
, 
[229] = {id = 229, ShopType = 39004, level = 30, CoinID = 35058, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 30076, PayItemNum = 2}
, 
[230] = {id = 230, ShopType = 39004, level = -1, CoinID = 35058, CoinNum = 50, ItemID = 35002, ItemNum = 100000, PayItemID = 35002, PayItemNum = 200000}
, 
[231] = {id = 231, ShopType = 39004, level = -2, CoinID = 35058, CoinNum = 50, ItemID = 79001, ItemNum = 10, PayItemID = 79001, PayItemNum = 20}
, 
[232] = {id = 232, ShopType = 39004, level = -3, CoinID = 35058, CoinNum = 50, ItemID = 74002, ItemNum = 5, PayItemID = 35008, PayItemNum = 40}
, 
[233] = {id = 233, ShopType = 39005, level = 1, CoinID = 35058, CoinNum = 20, ItemID = 35002, ItemNum = 50000, PayItemID = 31380, PayItemNum = 5}
, 
[234] = {id = 234, ShopType = 39005, level = 2, CoinID = 35058, CoinNum = 20, ItemID = 31380, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[235] = {id = 235, ShopType = 39005, level = 3, CoinID = 35058, CoinNum = 20, ItemID = 74003, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[236] = {id = 236, ShopType = 39005, level = 4, CoinID = 35058, CoinNum = 20, ItemID = 31386, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[237] = {id = 237, ShopType = 39005, level = 5, CoinID = 35058, CoinNum = 20, ItemID = 79001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[238] = {id = 238, ShopType = 39005, level = 6, CoinID = 35058, CoinNum = 30, ItemID = 31383, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[239] = {id = 239, ShopType = 39005, level = 7, CoinID = 35058, CoinNum = 30, ItemID = 74000, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[240] = {id = 240, ShopType = 39005, level = 8, CoinID = 35058, CoinNum = 30, ItemID = 31389, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[241] = {id = 241, ShopType = 39005, level = 9, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 100000, PayItemID = 31380, PayItemNum = 5}
, 
[242] = {id = 242, ShopType = 39005, level = 10, CoinID = 35058, CoinNum = 30, ItemID = 70001, ItemNum = 1, PayItemID = 31386, PayItemNum = 5}
, 
[243] = {id = 243, ShopType = 39005, level = 11, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 5}
, 
[244] = {id = 244, ShopType = 39005, level = 12, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[245] = {id = 245, ShopType = 39005, level = 13, CoinID = 35058, CoinNum = 40, ItemID = 74001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[246] = {id = 246, ShopType = 39005, level = 14, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 10, PayItemID = 31386, PayItemNum = 5}
, 
[247] = {id = 247, ShopType = 39005, level = 15, CoinID = 35058, CoinNum = 40, ItemID = 74002, ItemNum = 10, PayItemID = 31383, PayItemNum = 5}
, 
[248] = {id = 248, ShopType = 39005, level = 16, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[249] = {id = 249, ShopType = 39005, level = 17, CoinID = 35058, CoinNum = 40, ItemID = 79002, ItemNum = 2, PayItemID = 31380, PayItemNum = 10}
, 
[250] = {id = 250, ShopType = 39005, level = 18, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 10, PayItemID = 31386, PayItemNum = 10}
, 
[251] = {id = 251, ShopType = 39005, level = 19, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 10}
, 
[252] = {id = 252, ShopType = 39005, level = 20, CoinID = 35058, CoinNum = 40, ItemID = 74004, ItemNum = 5, PayItemID = 31389, PayItemNum = 10}
, 
[253] = {id = 253, ShopType = 39005, level = 21, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31381, PayItemNum = 5}
, 
[254] = {id = 254, ShopType = 39005, level = 22, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 15, PayItemID = 31387, PayItemNum = 5}
, 
[255] = {id = 255, ShopType = 39005, level = 23, CoinID = 35058, CoinNum = 40, ItemID = 35026, ItemNum = 10, PayItemID = 31384, PayItemNum = 5}
, 
[256] = {id = 256, ShopType = 39005, level = 24, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 15, PayItemID = 31390, PayItemNum = 5}
, 
[257] = {id = 257, ShopType = 39005, level = 25, CoinID = 35058, CoinNum = 40, ItemID = 74005, ItemNum = 5, PayItemID = 95112, PayItemNum = 1}
, 
[258] = {id = 258, ShopType = 39005, level = 26, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 15, PayItemID = 31381, PayItemNum = 10}
, 
[259] = {id = 259, ShopType = 39005, level = 27, CoinID = 35058, CoinNum = 40, ItemID = 70002, ItemNum = 1, PayItemID = 31387, PayItemNum = 10}
, 
[260] = {id = 260, ShopType = 39005, level = 28, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 15, PayItemID = 31384, PayItemNum = 10}
, 
[261] = {id = 261, ShopType = 39005, level = 29, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 300000, PayItemID = 31390, PayItemNum = 10}
, 
[262] = {id = 262, ShopType = 39005, level = 30, CoinID = 35058, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 30076, PayItemNum = 2}
, 
[263] = {id = 263, ShopType = 39005, level = -1, CoinID = 35058, CoinNum = 50, ItemID = 35002, ItemNum = 100000, PayItemID = 35002, PayItemNum = 200000}
, 
[264] = {id = 264, ShopType = 39005, level = -2, CoinID = 35058, CoinNum = 50, ItemID = 79001, ItemNum = 10, PayItemID = 79001, PayItemNum = 20}
, 
[265] = {id = 265, ShopType = 39005, level = -3, CoinID = 35058, CoinNum = 50, ItemID = 74002, ItemNum = 5, PayItemID = 35008, PayItemNum = 40}
, 
[266] = {id = 266, ShopType = 39006, level = 1, CoinID = 35058, CoinNum = 20, ItemID = 35002, ItemNum = 50000, PayItemID = 31380, PayItemNum = 5}
, 
[267] = {id = 267, ShopType = 39006, level = 2, CoinID = 35058, CoinNum = 20, ItemID = 31380, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[268] = {id = 268, ShopType = 39006, level = 3, CoinID = 35058, CoinNum = 20, ItemID = 74003, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[269] = {id = 269, ShopType = 39006, level = 4, CoinID = 35058, CoinNum = 20, ItemID = 31386, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[270] = {id = 270, ShopType = 39006, level = 5, CoinID = 35058, CoinNum = 20, ItemID = 79001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[271] = {id = 271, ShopType = 39006, level = 6, CoinID = 35058, CoinNum = 30, ItemID = 31383, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[272] = {id = 272, ShopType = 39006, level = 7, CoinID = 35058, CoinNum = 30, ItemID = 74000, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[273] = {id = 273, ShopType = 39006, level = 8, CoinID = 35058, CoinNum = 30, ItemID = 31389, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[274] = {id = 274, ShopType = 39006, level = 9, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 100000, PayItemID = 31380, PayItemNum = 5}
, 
[275] = {id = 275, ShopType = 39006, level = 10, CoinID = 35058, CoinNum = 30, ItemID = 70001, ItemNum = 1, PayItemID = 31386, PayItemNum = 5}
, 
[276] = {id = 276, ShopType = 39006, level = 11, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 5}
, 
[277] = {id = 277, ShopType = 39006, level = 12, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[278] = {id = 278, ShopType = 39006, level = 13, CoinID = 35058, CoinNum = 40, ItemID = 74001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[279] = {id = 279, ShopType = 39006, level = 14, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 10, PayItemID = 31386, PayItemNum = 5}
, 
[280] = {id = 280, ShopType = 39006, level = 15, CoinID = 35058, CoinNum = 40, ItemID = 74002, ItemNum = 10, PayItemID = 31383, PayItemNum = 5}
, 
[281] = {id = 281, ShopType = 39006, level = 16, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[282] = {id = 282, ShopType = 39006, level = 17, CoinID = 35058, CoinNum = 40, ItemID = 79002, ItemNum = 2, PayItemID = 31380, PayItemNum = 10}
, 
[283] = {id = 283, ShopType = 39006, level = 18, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 10, PayItemID = 31386, PayItemNum = 10}
, 
[284] = {id = 284, ShopType = 39006, level = 19, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 10}
, 
[285] = {id = 285, ShopType = 39006, level = 20, CoinID = 35058, CoinNum = 40, ItemID = 74004, ItemNum = 5, PayItemID = 31389, PayItemNum = 10}
, 
[286] = {id = 286, ShopType = 39006, level = 21, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31381, PayItemNum = 5}
, 
[287] = {id = 287, ShopType = 39006, level = 22, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 15, PayItemID = 31387, PayItemNum = 5}
, 
[288] = {id = 288, ShopType = 39006, level = 23, CoinID = 35058, CoinNum = 40, ItemID = 35026, ItemNum = 10, PayItemID = 31384, PayItemNum = 5}
, 
[289] = {id = 289, ShopType = 39006, level = 24, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 15, PayItemID = 31390, PayItemNum = 5}
, 
[290] = {id = 290, ShopType = 39006, level = 25, CoinID = 35058, CoinNum = 40, ItemID = 74005, ItemNum = 5, PayItemID = 95120, PayItemNum = 1}
, 
[291] = {id = 291, ShopType = 39006, level = 26, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 15, PayItemID = 31381, PayItemNum = 10}
, 
[292] = {id = 292, ShopType = 39006, level = 27, CoinID = 35058, CoinNum = 40, ItemID = 70002, ItemNum = 1, PayItemID = 31387, PayItemNum = 10}
, 
[293] = {id = 293, ShopType = 39006, level = 28, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 15, PayItemID = 31384, PayItemNum = 10}
, 
[294] = {id = 294, ShopType = 39006, level = 29, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 300000, PayItemID = 31390, PayItemNum = 10}
, 
[295] = {id = 295, ShopType = 39006, level = 30, CoinID = 35058, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 30076, PayItemNum = 2}
, 
[296] = {id = 296, ShopType = 39006, level = -1, CoinID = 35058, CoinNum = 50, ItemID = 35002, ItemNum = 100000, PayItemID = 35002, PayItemNum = 200000}
, 
[297] = {id = 297, ShopType = 39006, level = -2, CoinID = 35058, CoinNum = 50, ItemID = 79001, ItemNum = 10, PayItemID = 79001, PayItemNum = 20}
, 
[298] = {id = 298, ShopType = 39006, level = -3, CoinID = 35058, CoinNum = 50, ItemID = 74002, ItemNum = 5, PayItemID = 35008, PayItemNum = 40}
, 
[299] = {id = 299, ShopType = 39007, level = 1, CoinID = 35058, CoinNum = 20, ItemID = 35002, ItemNum = 50000, PayItemID = 31380, PayItemNum = 5}
, 
[300] = {id = 300, ShopType = 39007, level = 2, CoinID = 35058, CoinNum = 20, ItemID = 31380, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[301] = {id = 301, ShopType = 39007, level = 3, CoinID = 35058, CoinNum = 20, ItemID = 74003, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[302] = {id = 302, ShopType = 39007, level = 4, CoinID = 35058, CoinNum = 20, ItemID = 31386, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[303] = {id = 303, ShopType = 39007, level = 5, CoinID = 35058, CoinNum = 20, ItemID = 79001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[304] = {id = 304, ShopType = 39007, level = 6, CoinID = 35058, CoinNum = 30, ItemID = 31383, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[305] = {id = 305, ShopType = 39007, level = 7, CoinID = 35058, CoinNum = 30, ItemID = 74000, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[306] = {id = 306, ShopType = 39007, level = 8, CoinID = 35058, CoinNum = 30, ItemID = 31389, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[307] = {id = 307, ShopType = 39007, level = 9, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 100000, PayItemID = 31380, PayItemNum = 5}
, 
[308] = {id = 308, ShopType = 39007, level = 10, CoinID = 35058, CoinNum = 30, ItemID = 70001, ItemNum = 1, PayItemID = 31386, PayItemNum = 5}
, 
[309] = {id = 309, ShopType = 39007, level = 11, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 5}
, 
[310] = {id = 310, ShopType = 39007, level = 12, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[311] = {id = 311, ShopType = 39007, level = 13, CoinID = 35058, CoinNum = 40, ItemID = 74001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[312] = {id = 312, ShopType = 39007, level = 14, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 10, PayItemID = 31386, PayItemNum = 5}
, 
[313] = {id = 313, ShopType = 39007, level = 15, CoinID = 35058, CoinNum = 40, ItemID = 74002, ItemNum = 10, PayItemID = 31383, PayItemNum = 5}
, 
[314] = {id = 314, ShopType = 39007, level = 16, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[315] = {id = 315, ShopType = 39007, level = 17, CoinID = 35058, CoinNum = 40, ItemID = 79002, ItemNum = 2, PayItemID = 31380, PayItemNum = 10}
, 
[316] = {id = 316, ShopType = 39007, level = 18, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 10, PayItemID = 31386, PayItemNum = 10}
, 
[317] = {id = 317, ShopType = 39007, level = 19, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 10}
, 
[318] = {id = 318, ShopType = 39007, level = 20, CoinID = 35058, CoinNum = 40, ItemID = 74004, ItemNum = 5, PayItemID = 31389, PayItemNum = 10}
, 
[319] = {id = 319, ShopType = 39007, level = 21, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31381, PayItemNum = 5}
, 
[320] = {id = 320, ShopType = 39007, level = 22, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 15, PayItemID = 31387, PayItemNum = 5}
, 
[321] = {id = 321, ShopType = 39007, level = 23, CoinID = 35058, CoinNum = 40, ItemID = 35026, ItemNum = 10, PayItemID = 31384, PayItemNum = 5}
, 
[322] = {id = 322, ShopType = 39007, level = 24, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 15, PayItemID = 31390, PayItemNum = 5}
, 
[323] = {id = 323, ShopType = 39007, level = 25, CoinID = 35058, CoinNum = 40, ItemID = 74005, ItemNum = 5, PayItemID = 95111, PayItemNum = 1}
, 
[324] = {id = 324, ShopType = 39007, level = 26, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 15, PayItemID = 31381, PayItemNum = 10}
, 
[325] = {id = 325, ShopType = 39007, level = 27, CoinID = 35058, CoinNum = 40, ItemID = 70002, ItemNum = 1, PayItemID = 31387, PayItemNum = 10}
, 
[326] = {id = 326, ShopType = 39007, level = 28, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 15, PayItemID = 31384, PayItemNum = 10}
, 
[327] = {id = 327, ShopType = 39007, level = 29, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 300000, PayItemID = 31390, PayItemNum = 10}
, 
[328] = {id = 328, ShopType = 39007, level = 30, CoinID = 35058, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 30076, PayItemNum = 2}
, 
[329] = {id = 329, ShopType = 39007, level = -1, CoinID = 35058, CoinNum = 50, ItemID = 35002, ItemNum = 100000, PayItemID = 35002, PayItemNum = 200000}
, 
[330] = {id = 330, ShopType = 39007, level = -2, CoinID = 35058, CoinNum = 50, ItemID = 79001, ItemNum = 10, PayItemID = 79001, PayItemNum = 20}
, 
[331] = {id = 331, ShopType = 39007, level = -3, CoinID = 35058, CoinNum = 50, ItemID = 74002, ItemNum = 5, PayItemID = 35008, PayItemNum = 40}
, 
[332] = {id = 332, ShopType = 39008, level = 1, CoinID = 35058, CoinNum = 20, ItemID = 35002, ItemNum = 50000, PayItemID = 31380, PayItemNum = 5}
, 
[333] = {id = 333, ShopType = 39008, level = 2, CoinID = 35058, CoinNum = 20, ItemID = 31380, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[334] = {id = 334, ShopType = 39008, level = 3, CoinID = 35058, CoinNum = 20, ItemID = 74003, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[335] = {id = 335, ShopType = 39008, level = 4, CoinID = 35058, CoinNum = 20, ItemID = 31386, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[336] = {id = 336, ShopType = 39008, level = 5, CoinID = 35058, CoinNum = 20, ItemID = 79001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[337] = {id = 337, ShopType = 39008, level = 6, CoinID = 35058, CoinNum = 30, ItemID = 31383, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[338] = {id = 338, ShopType = 39008, level = 7, CoinID = 35058, CoinNum = 30, ItemID = 74000, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[339] = {id = 339, ShopType = 39008, level = 8, CoinID = 35058, CoinNum = 30, ItemID = 31389, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[340] = {id = 340, ShopType = 39008, level = 9, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 100000, PayItemID = 31380, PayItemNum = 5}
, 
[341] = {id = 341, ShopType = 39008, level = 10, CoinID = 35058, CoinNum = 30, ItemID = 70001, ItemNum = 1, PayItemID = 31386, PayItemNum = 5}
, 
[342] = {id = 342, ShopType = 39008, level = 11, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 5}
, 
[343] = {id = 343, ShopType = 39008, level = 12, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[344] = {id = 344, ShopType = 39008, level = 13, CoinID = 35058, CoinNum = 40, ItemID = 74001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[345] = {id = 345, ShopType = 39008, level = 14, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 10, PayItemID = 31386, PayItemNum = 5}
, 
[346] = {id = 346, ShopType = 39008, level = 15, CoinID = 35058, CoinNum = 40, ItemID = 74002, ItemNum = 10, PayItemID = 31383, PayItemNum = 5}
, 
[347] = {id = 347, ShopType = 39008, level = 16, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[348] = {id = 348, ShopType = 39008, level = 17, CoinID = 35058, CoinNum = 40, ItemID = 79002, ItemNum = 2, PayItemID = 31380, PayItemNum = 10}
, 
[349] = {id = 349, ShopType = 39008, level = 18, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 10, PayItemID = 31386, PayItemNum = 10}
, 
[350] = {id = 350, ShopType = 39008, level = 19, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 10}
, 
[351] = {id = 351, ShopType = 39008, level = 20, CoinID = 35058, CoinNum = 40, ItemID = 74004, ItemNum = 5, PayItemID = 31389, PayItemNum = 10}
, 
[352] = {id = 352, ShopType = 39008, level = 21, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31381, PayItemNum = 5}
, 
[353] = {id = 353, ShopType = 39008, level = 22, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 15, PayItemID = 31387, PayItemNum = 5}
, 
[354] = {id = 354, ShopType = 39008, level = 23, CoinID = 35058, CoinNum = 40, ItemID = 35026, ItemNum = 10, PayItemID = 31384, PayItemNum = 5}
, 
[355] = {id = 355, ShopType = 39008, level = 24, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 15, PayItemID = 31390, PayItemNum = 5}
, 
[356] = {id = 356, ShopType = 39008, level = 25, CoinID = 35058, CoinNum = 40, ItemID = 74005, ItemNum = 5, PayItemID = 95081, PayItemNum = 1}
, 
[357] = {id = 357, ShopType = 39008, level = 26, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 15, PayItemID = 31381, PayItemNum = 10}
, 
[358] = {id = 358, ShopType = 39008, level = 27, CoinID = 35058, CoinNum = 40, ItemID = 70002, ItemNum = 1, PayItemID = 31387, PayItemNum = 10}
, 
[359] = {id = 359, ShopType = 39008, level = 28, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 15, PayItemID = 31384, PayItemNum = 10}
, 
[360] = {id = 360, ShopType = 39008, level = 29, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 300000, PayItemID = 31390, PayItemNum = 10}
, 
[361] = {id = 361, ShopType = 39008, level = 30, CoinID = 35058, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 30076, PayItemNum = 2}
, 
[362] = {id = 362, ShopType = 39008, level = -1, CoinID = 35058, CoinNum = 50, ItemID = 35002, ItemNum = 100000, PayItemID = 35002, PayItemNum = 200000}
, 
[363] = {id = 363, ShopType = 39008, level = -2, CoinID = 35058, CoinNum = 50, ItemID = 79001, ItemNum = 10, PayItemID = 79001, PayItemNum = 20}
, 
[364] = {id = 364, ShopType = 39008, level = -3, CoinID = 35058, CoinNum = 50, ItemID = 74002, ItemNum = 5, PayItemID = 35008, PayItemNum = 40}
, 
[365] = {id = 365, ShopType = 39009, level = 1, CoinID = 35058, CoinNum = 20, ItemID = 35002, ItemNum = 50000, PayItemID = 31380, PayItemNum = 5}
, 
[366] = {id = 366, ShopType = 39009, level = 2, CoinID = 35058, CoinNum = 20, ItemID = 31380, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[367] = {id = 367, ShopType = 39009, level = 3, CoinID = 35058, CoinNum = 20, ItemID = 74003, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[368] = {id = 368, ShopType = 39009, level = 4, CoinID = 35058, CoinNum = 20, ItemID = 31386, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[369] = {id = 369, ShopType = 39009, level = 5, CoinID = 35058, CoinNum = 20, ItemID = 79001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[370] = {id = 370, ShopType = 39009, level = 6, CoinID = 35058, CoinNum = 30, ItemID = 31383, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[371] = {id = 371, ShopType = 39009, level = 7, CoinID = 35058, CoinNum = 30, ItemID = 74000, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[372] = {id = 372, ShopType = 39009, level = 8, CoinID = 35058, CoinNum = 30, ItemID = 31389, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[373] = {id = 373, ShopType = 39009, level = 9, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 100000, PayItemID = 31380, PayItemNum = 5}
, 
[374] = {id = 374, ShopType = 39009, level = 10, CoinID = 35058, CoinNum = 30, ItemID = 70001, ItemNum = 1, PayItemID = 31386, PayItemNum = 5}
, 
[375] = {id = 375, ShopType = 39009, level = 11, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 5}
, 
[376] = {id = 376, ShopType = 39009, level = 12, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[377] = {id = 377, ShopType = 39009, level = 13, CoinID = 35058, CoinNum = 40, ItemID = 74001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[378] = {id = 378, ShopType = 39009, level = 14, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 10, PayItemID = 31386, PayItemNum = 5}
, 
[379] = {id = 379, ShopType = 39009, level = 15, CoinID = 35058, CoinNum = 40, ItemID = 74002, ItemNum = 10, PayItemID = 31383, PayItemNum = 5}
, 
[380] = {id = 380, ShopType = 39009, level = 16, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[381] = {id = 381, ShopType = 39009, level = 17, CoinID = 35058, CoinNum = 40, ItemID = 79002, ItemNum = 2, PayItemID = 31380, PayItemNum = 10}
, 
[382] = {id = 382, ShopType = 39009, level = 18, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 10, PayItemID = 31386, PayItemNum = 10}
, 
[383] = {id = 383, ShopType = 39009, level = 19, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 10}
, 
[384] = {id = 384, ShopType = 39009, level = 20, CoinID = 35058, CoinNum = 40, ItemID = 74004, ItemNum = 5, PayItemID = 31389, PayItemNum = 10}
, 
[385] = {id = 385, ShopType = 39009, level = 21, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31381, PayItemNum = 5}
, 
[386] = {id = 386, ShopType = 39009, level = 22, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 15, PayItemID = 31387, PayItemNum = 5}
, 
[387] = {id = 387, ShopType = 39009, level = 23, CoinID = 35058, CoinNum = 40, ItemID = 35026, ItemNum = 10, PayItemID = 31384, PayItemNum = 5}
, 
[388] = {id = 388, ShopType = 39009, level = 24, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 15, PayItemID = 31390, PayItemNum = 5}
, 
[389] = {id = 389, ShopType = 39009, level = 25, CoinID = 35058, CoinNum = 40, ItemID = 74005, ItemNum = 5, PayItemID = 95023, PayItemNum = 1}
, 
[390] = {id = 390, ShopType = 39009, level = 26, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 15, PayItemID = 31381, PayItemNum = 10}
, 
[391] = {id = 391, ShopType = 39009, level = 27, CoinID = 35058, CoinNum = 40, ItemID = 70002, ItemNum = 1, PayItemID = 31387, PayItemNum = 10}
, 
[392] = {id = 392, ShopType = 39009, level = 28, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 15, PayItemID = 31384, PayItemNum = 10}
, 
[393] = {id = 393, ShopType = 39009, level = 29, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 300000, PayItemID = 31390, PayItemNum = 10}
, 
[394] = {id = 394, ShopType = 39009, level = 30, CoinID = 35058, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 30076, PayItemNum = 2}
, 
[395] = {id = 395, ShopType = 39009, level = -1, CoinID = 35058, CoinNum = 50, ItemID = 35002, ItemNum = 100000, PayItemID = 35002, PayItemNum = 200000}
, 
[396] = {id = 396, ShopType = 39009, level = -2, CoinID = 35058, CoinNum = 50, ItemID = 79001, ItemNum = 10, PayItemID = 79001, PayItemNum = 20}
, 
[397] = {id = 397, ShopType = 39009, level = -3, CoinID = 35058, CoinNum = 50, ItemID = 74002, ItemNum = 5, PayItemID = 35008, PayItemNum = 40}
, 
[398] = {id = 398, ShopType = 39010, level = 1, CoinID = 35058, CoinNum = 20, ItemID = 35002, ItemNum = 50000, PayItemID = 31380, PayItemNum = 5}
, 
[399] = {id = 399, ShopType = 39010, level = 2, CoinID = 35058, CoinNum = 20, ItemID = 31380, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[400] = {id = 400, ShopType = 39010, level = 3, CoinID = 35058, CoinNum = 20, ItemID = 74003, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[401] = {id = 401, ShopType = 39010, level = 4, CoinID = 35058, CoinNum = 20, ItemID = 31386, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[402] = {id = 402, ShopType = 39010, level = 5, CoinID = 35058, CoinNum = 20, ItemID = 79001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[403] = {id = 403, ShopType = 39010, level = 6, CoinID = 35058, CoinNum = 30, ItemID = 31383, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[404] = {id = 404, ShopType = 39010, level = 7, CoinID = 35058, CoinNum = 30, ItemID = 74000, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[405] = {id = 405, ShopType = 39010, level = 8, CoinID = 35058, CoinNum = 30, ItemID = 31389, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[406] = {id = 406, ShopType = 39010, level = 9, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 100000, PayItemID = 31380, PayItemNum = 5}
, 
[407] = {id = 407, ShopType = 39010, level = 10, CoinID = 35058, CoinNum = 30, ItemID = 70001, ItemNum = 1, PayItemID = 31386, PayItemNum = 5}
, 
[408] = {id = 408, ShopType = 39010, level = 11, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 5}
, 
[409] = {id = 409, ShopType = 39010, level = 12, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[410] = {id = 410, ShopType = 39010, level = 13, CoinID = 35058, CoinNum = 40, ItemID = 74001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[411] = {id = 411, ShopType = 39010, level = 14, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 10, PayItemID = 31386, PayItemNum = 5}
, 
[412] = {id = 412, ShopType = 39010, level = 15, CoinID = 35058, CoinNum = 40, ItemID = 74002, ItemNum = 10, PayItemID = 31383, PayItemNum = 5}
, 
[413] = {id = 413, ShopType = 39010, level = 16, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[414] = {id = 414, ShopType = 39010, level = 17, CoinID = 35058, CoinNum = 40, ItemID = 79002, ItemNum = 2, PayItemID = 31380, PayItemNum = 10}
, 
[415] = {id = 415, ShopType = 39010, level = 18, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 10, PayItemID = 31386, PayItemNum = 10}
, 
[416] = {id = 416, ShopType = 39010, level = 19, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 10}
, 
[417] = {id = 417, ShopType = 39010, level = 20, CoinID = 35058, CoinNum = 40, ItemID = 74004, ItemNum = 5, PayItemID = 31389, PayItemNum = 10}
, 
[418] = {id = 418, ShopType = 39010, level = 21, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31381, PayItemNum = 5}
, 
[419] = {id = 419, ShopType = 39010, level = 22, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 15, PayItemID = 31387, PayItemNum = 5}
, 
[420] = {id = 420, ShopType = 39010, level = 23, CoinID = 35058, CoinNum = 40, ItemID = 35026, ItemNum = 10, PayItemID = 31384, PayItemNum = 5}
, 
[421] = {id = 421, ShopType = 39010, level = 24, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 15, PayItemID = 31390, PayItemNum = 5}
, 
[422] = {id = 422, ShopType = 39010, level = 25, CoinID = 35058, CoinNum = 40, ItemID = 74005, ItemNum = 5, PayItemID = 95119, PayItemNum = 1}
, 
[423] = {id = 423, ShopType = 39010, level = 26, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 15, PayItemID = 31381, PayItemNum = 10}
, 
[424] = {id = 424, ShopType = 39010, level = 27, CoinID = 35058, CoinNum = 40, ItemID = 70002, ItemNum = 1, PayItemID = 31387, PayItemNum = 10}
, 
[425] = {id = 425, ShopType = 39010, level = 28, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 15, PayItemID = 31384, PayItemNum = 10}
, 
[426] = {id = 426, ShopType = 39010, level = 29, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 300000, PayItemID = 31390, PayItemNum = 10}
, 
[427] = {id = 427, ShopType = 39010, level = 30, CoinID = 35058, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 30076, PayItemNum = 2}
, 
[428] = {id = 428, ShopType = 39010, level = -1, CoinID = 35058, CoinNum = 50, ItemID = 35002, ItemNum = 100000, PayItemID = 35002, PayItemNum = 200000}
, 
[429] = {id = 429, ShopType = 39010, level = -2, CoinID = 35058, CoinNum = 50, ItemID = 79001, ItemNum = 10, PayItemID = 79001, PayItemNum = 20}
, 
[430] = {id = 430, ShopType = 39010, level = -3, CoinID = 35058, CoinNum = 50, ItemID = 74002, ItemNum = 5, PayItemID = 35008, PayItemNum = 40}
, 
[431] = {id = 431, ShopType = 39011, level = 1, CoinID = 35058, CoinNum = 20, ItemID = 35002, ItemNum = 50000, PayItemID = 31380, PayItemNum = 5}
, 
[432] = {id = 432, ShopType = 39011, level = 2, CoinID = 35058, CoinNum = 20, ItemID = 31380, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[433] = {id = 433, ShopType = 39011, level = 3, CoinID = 35058, CoinNum = 20, ItemID = 74003, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[434] = {id = 434, ShopType = 39011, level = 4, CoinID = 35058, CoinNum = 20, ItemID = 31386, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[435] = {id = 435, ShopType = 39011, level = 5, CoinID = 35058, CoinNum = 20, ItemID = 79001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[436] = {id = 436, ShopType = 39011, level = 6, CoinID = 35058, CoinNum = 30, ItemID = 31383, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[437] = {id = 437, ShopType = 39011, level = 7, CoinID = 35058, CoinNum = 30, ItemID = 74000, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[438] = {id = 438, ShopType = 39011, level = 8, CoinID = 35058, CoinNum = 30, ItemID = 31389, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[439] = {id = 439, ShopType = 39011, level = 9, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 100000, PayItemID = 31380, PayItemNum = 5}
, 
[440] = {id = 440, ShopType = 39011, level = 10, CoinID = 35058, CoinNum = 30, ItemID = 70001, ItemNum = 1, PayItemID = 31386, PayItemNum = 5}
, 
[441] = {id = 441, ShopType = 39011, level = 11, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 5}
, 
[442] = {id = 442, ShopType = 39011, level = 12, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[443] = {id = 443, ShopType = 39011, level = 13, CoinID = 35058, CoinNum = 40, ItemID = 74001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[444] = {id = 444, ShopType = 39011, level = 14, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 10, PayItemID = 31386, PayItemNum = 5}
, 
[445] = {id = 445, ShopType = 39011, level = 15, CoinID = 35058, CoinNum = 40, ItemID = 74002, ItemNum = 10, PayItemID = 31383, PayItemNum = 5}
, 
[446] = {id = 446, ShopType = 39011, level = 16, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[447] = {id = 447, ShopType = 39011, level = 17, CoinID = 35058, CoinNum = 40, ItemID = 79002, ItemNum = 2, PayItemID = 31380, PayItemNum = 10}
, 
[448] = {id = 448, ShopType = 39011, level = 18, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 10, PayItemID = 31386, PayItemNum = 10}
, 
[449] = {id = 449, ShopType = 39011, level = 19, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 10}
, 
[450] = {id = 450, ShopType = 39011, level = 20, CoinID = 35058, CoinNum = 40, ItemID = 74004, ItemNum = 5, PayItemID = 31389, PayItemNum = 10}
, 
[451] = {id = 451, ShopType = 39011, level = 21, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31381, PayItemNum = 5}
, 
[452] = {id = 452, ShopType = 39011, level = 22, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 15, PayItemID = 31387, PayItemNum = 5}
, 
[453] = {id = 453, ShopType = 39011, level = 23, CoinID = 35058, CoinNum = 40, ItemID = 35026, ItemNum = 10, PayItemID = 31384, PayItemNum = 5}
, 
[454] = {id = 454, ShopType = 39011, level = 24, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 15, PayItemID = 31390, PayItemNum = 5}
, 
[455] = {id = 455, ShopType = 39011, level = 25, CoinID = 35058, CoinNum = 40, ItemID = 74005, ItemNum = 5, PayItemID = 95107, PayItemNum = 1}
, 
[456] = {id = 456, ShopType = 39011, level = 26, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 15, PayItemID = 31381, PayItemNum = 10}
, 
[457] = {id = 457, ShopType = 39011, level = 27, CoinID = 35058, CoinNum = 40, ItemID = 70002, ItemNum = 1, PayItemID = 31387, PayItemNum = 10}
, 
[458] = {id = 458, ShopType = 39011, level = 28, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 15, PayItemID = 31384, PayItemNum = 10}
, 
[459] = {id = 459, ShopType = 39011, level = 29, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 300000, PayItemID = 31390, PayItemNum = 10}
, 
[460] = {id = 460, ShopType = 39011, level = 30, CoinID = 35058, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 30076, PayItemNum = 2}
, 
[461] = {id = 461, ShopType = 39011, level = -1, CoinID = 35058, CoinNum = 50, ItemID = 35002, ItemNum = 100000, PayItemID = 35002, PayItemNum = 200000}
, 
[462] = {id = 462, ShopType = 39011, level = -2, CoinID = 35058, CoinNum = 50, ItemID = 79001, ItemNum = 10, PayItemID = 79001, PayItemNum = 20}
, 
[463] = {id = 463, ShopType = 39011, level = -3, CoinID = 35058, CoinNum = 50, ItemID = 74002, ItemNum = 5, PayItemID = 35008, PayItemNum = 40}
, 
[464] = {id = 464, ShopType = 39012, level = 1, CoinID = 35058, CoinNum = 20, ItemID = 35002, ItemNum = 50000, PayItemID = 31380, PayItemNum = 5}
, 
[465] = {id = 465, ShopType = 39012, level = 2, CoinID = 35058, CoinNum = 20, ItemID = 31380, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[466] = {id = 466, ShopType = 39012, level = 3, CoinID = 35058, CoinNum = 20, ItemID = 74003, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[467] = {id = 467, ShopType = 39012, level = 4, CoinID = 35058, CoinNum = 20, ItemID = 31386, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[468] = {id = 468, ShopType = 39012, level = 5, CoinID = 35058, CoinNum = 20, ItemID = 79001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[469] = {id = 469, ShopType = 39012, level = 6, CoinID = 35058, CoinNum = 30, ItemID = 31383, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[470] = {id = 470, ShopType = 39012, level = 7, CoinID = 35058, CoinNum = 30, ItemID = 74000, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[471] = {id = 471, ShopType = 39012, level = 8, CoinID = 35058, CoinNum = 30, ItemID = 31389, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[472] = {id = 472, ShopType = 39012, level = 9, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 100000, PayItemID = 31380, PayItemNum = 5}
, 
[473] = {id = 473, ShopType = 39012, level = 10, CoinID = 35058, CoinNum = 30, ItemID = 70001, ItemNum = 1, PayItemID = 31386, PayItemNum = 5}
, 
[474] = {id = 474, ShopType = 39012, level = 11, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 5}
, 
[475] = {id = 475, ShopType = 39012, level = 12, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[476] = {id = 476, ShopType = 39012, level = 13, CoinID = 35058, CoinNum = 40, ItemID = 74001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[477] = {id = 477, ShopType = 39012, level = 14, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 10, PayItemID = 31386, PayItemNum = 5}
, 
[478] = {id = 478, ShopType = 39012, level = 15, CoinID = 35058, CoinNum = 40, ItemID = 74002, ItemNum = 10, PayItemID = 31383, PayItemNum = 5}
, 
[479] = {id = 479, ShopType = 39012, level = 16, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[480] = {id = 480, ShopType = 39012, level = 17, CoinID = 35058, CoinNum = 40, ItemID = 79002, ItemNum = 2, PayItemID = 31380, PayItemNum = 10}
, 
[481] = {id = 481, ShopType = 39012, level = 18, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 10, PayItemID = 31386, PayItemNum = 10}
, 
[482] = {id = 482, ShopType = 39012, level = 19, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 10}
, 
[483] = {id = 483, ShopType = 39012, level = 20, CoinID = 35058, CoinNum = 40, ItemID = 74004, ItemNum = 5, PayItemID = 31389, PayItemNum = 10}
, 
[484] = {id = 484, ShopType = 39012, level = 21, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31381, PayItemNum = 5}
, 
[485] = {id = 485, ShopType = 39012, level = 22, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 15, PayItemID = 31387, PayItemNum = 5}
, 
[486] = {id = 486, ShopType = 39012, level = 23, CoinID = 35058, CoinNum = 40, ItemID = 35026, ItemNum = 10, PayItemID = 31384, PayItemNum = 5}
, 
[487] = {id = 487, ShopType = 39012, level = 24, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 15, PayItemID = 31390, PayItemNum = 5}
, 
[488] = {id = 488, ShopType = 39012, level = 25, CoinID = 35058, CoinNum = 40, ItemID = 74005, ItemNum = 5, PayItemID = 95122, PayItemNum = 1}
, 
[489] = {id = 489, ShopType = 39012, level = 26, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 15, PayItemID = 31381, PayItemNum = 10}
, 
[490] = {id = 490, ShopType = 39012, level = 27, CoinID = 35058, CoinNum = 40, ItemID = 70002, ItemNum = 1, PayItemID = 31387, PayItemNum = 10}
, 
[491] = {id = 491, ShopType = 39012, level = 28, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 15, PayItemID = 31384, PayItemNum = 10}
, 
[492] = {id = 492, ShopType = 39012, level = 29, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 300000, PayItemID = 31390, PayItemNum = 10}
, 
[493] = {id = 493, ShopType = 39012, level = 30, CoinID = 35058, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 30076, PayItemNum = 2}
, 
[494] = {id = 494, ShopType = 39012, level = -1, CoinID = 35058, CoinNum = 50, ItemID = 35002, ItemNum = 100000, PayItemID = 35002, PayItemNum = 200000}
, 
[495] = {id = 495, ShopType = 39012, level = -2, CoinID = 35058, CoinNum = 50, ItemID = 79001, ItemNum = 10, PayItemID = 79001, PayItemNum = 20}
, 
[496] = {id = 496, ShopType = 39012, level = -3, CoinID = 35058, CoinNum = 50, ItemID = 74002, ItemNum = 5, PayItemID = 35008, PayItemNum = 40}
, 
[497] = {id = 497, ShopType = 39013, level = 1, CoinID = 35058, CoinNum = 20, ItemID = 35002, ItemNum = 50000, PayItemID = 31380, PayItemNum = 5}
, 
[498] = {id = 498, ShopType = 39013, level = 2, CoinID = 35058, CoinNum = 20, ItemID = 31380, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[499] = {id = 499, ShopType = 39013, level = 3, CoinID = 35058, CoinNum = 20, ItemID = 74003, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[500] = {id = 500, ShopType = 39013, level = 4, CoinID = 35058, CoinNum = 20, ItemID = 31386, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[501] = {id = 501, ShopType = 39013, level = 5, CoinID = 35058, CoinNum = 20, ItemID = 79001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[502] = {id = 502, ShopType = 39013, level = 6, CoinID = 35058, CoinNum = 30, ItemID = 31383, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[503] = {id = 503, ShopType = 39013, level = 7, CoinID = 35058, CoinNum = 30, ItemID = 74000, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[504] = {id = 504, ShopType = 39013, level = 8, CoinID = 35058, CoinNum = 30, ItemID = 31389, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[505] = {id = 505, ShopType = 39013, level = 9, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 100000, PayItemID = 31380, PayItemNum = 5}
, 
[506] = {id = 506, ShopType = 39013, level = 10, CoinID = 35058, CoinNum = 30, ItemID = 70001, ItemNum = 1, PayItemID = 31386, PayItemNum = 5}
, 
[507] = {id = 507, ShopType = 39013, level = 11, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 5}
, 
[508] = {id = 508, ShopType = 39013, level = 12, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[509] = {id = 509, ShopType = 39013, level = 13, CoinID = 35058, CoinNum = 40, ItemID = 74001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[510] = {id = 510, ShopType = 39013, level = 14, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 10, PayItemID = 31386, PayItemNum = 5}
, 
[511] = {id = 511, ShopType = 39013, level = 15, CoinID = 35058, CoinNum = 40, ItemID = 74002, ItemNum = 10, PayItemID = 31383, PayItemNum = 5}
, 
[512] = {id = 512, ShopType = 39013, level = 16, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[513] = {id = 513, ShopType = 39013, level = 17, CoinID = 35058, CoinNum = 40, ItemID = 79002, ItemNum = 2, PayItemID = 31380, PayItemNum = 10}
, 
[514] = {id = 514, ShopType = 39013, level = 18, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 10, PayItemID = 31386, PayItemNum = 10}
, 
[515] = {id = 515, ShopType = 39013, level = 19, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 10}
, 
[516] = {id = 516, ShopType = 39013, level = 20, CoinID = 35058, CoinNum = 40, ItemID = 74004, ItemNum = 5, PayItemID = 31389, PayItemNum = 10}
, 
[517] = {id = 517, ShopType = 39013, level = 21, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31381, PayItemNum = 5}
, 
[518] = {id = 518, ShopType = 39013, level = 22, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 15, PayItemID = 31387, PayItemNum = 5}
, 
[519] = {id = 519, ShopType = 39013, level = 23, CoinID = 35058, CoinNum = 40, ItemID = 35026, ItemNum = 10, PayItemID = 31384, PayItemNum = 5}
, 
[520] = {id = 520, ShopType = 39013, level = 24, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 15, PayItemID = 31390, PayItemNum = 5}
, 
[521] = {id = 521, ShopType = 39013, level = 25, CoinID = 35058, CoinNum = 40, ItemID = 74005, ItemNum = 5, PayItemID = 95072, PayItemNum = 1}
, 
[522] = {id = 522, ShopType = 39013, level = 26, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 15, PayItemID = 31381, PayItemNum = 10}
, 
[523] = {id = 523, ShopType = 39013, level = 27, CoinID = 35058, CoinNum = 40, ItemID = 70002, ItemNum = 1, PayItemID = 31387, PayItemNum = 10}
, 
[524] = {id = 524, ShopType = 39013, level = 28, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 15, PayItemID = 31384, PayItemNum = 10}
, 
[525] = {id = 525, ShopType = 39013, level = 29, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 300000, PayItemID = 31390, PayItemNum = 10}
, 
[526] = {id = 526, ShopType = 39013, level = 30, CoinID = 35058, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 30076, PayItemNum = 2}
, 
[527] = {id = 527, ShopType = 39013, level = -1, CoinID = 35058, CoinNum = 50, ItemID = 35002, ItemNum = 100000, PayItemID = 35002, PayItemNum = 200000}
, 
[528] = {id = 528, ShopType = 39013, level = -2, CoinID = 35058, CoinNum = 50, ItemID = 79001, ItemNum = 10, PayItemID = 79001, PayItemNum = 20}
, 
[529] = {id = 529, ShopType = 39013, level = -3, CoinID = 35058, CoinNum = 50, ItemID = 74002, ItemNum = 5, PayItemID = 35008, PayItemNum = 40}
, 
[530] = {id = 530, ShopType = 39014, level = 1, CoinID = 35058, CoinNum = 20, ItemID = 35002, ItemNum = 50000, PayItemID = 31380, PayItemNum = 5}
, 
[531] = {id = 531, ShopType = 39014, level = 2, CoinID = 35058, CoinNum = 20, ItemID = 31380, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[532] = {id = 532, ShopType = 39014, level = 3, CoinID = 35058, CoinNum = 20, ItemID = 74003, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[533] = {id = 533, ShopType = 39014, level = 4, CoinID = 35058, CoinNum = 20, ItemID = 31386, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[534] = {id = 534, ShopType = 39014, level = 5, CoinID = 35058, CoinNum = 20, ItemID = 79001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[535] = {id = 535, ShopType = 39014, level = 6, CoinID = 35058, CoinNum = 30, ItemID = 31383, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[536] = {id = 536, ShopType = 39014, level = 7, CoinID = 35058, CoinNum = 30, ItemID = 74000, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[537] = {id = 537, ShopType = 39014, level = 8, CoinID = 35058, CoinNum = 30, ItemID = 31389, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[538] = {id = 538, ShopType = 39014, level = 9, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 100000, PayItemID = 31380, PayItemNum = 5}
, 
[539] = {id = 539, ShopType = 39014, level = 10, CoinID = 35058, CoinNum = 30, ItemID = 70001, ItemNum = 1, PayItemID = 31386, PayItemNum = 5}
, 
[540] = {id = 540, ShopType = 39014, level = 11, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 5}
, 
[541] = {id = 541, ShopType = 39014, level = 12, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[542] = {id = 542, ShopType = 39014, level = 13, CoinID = 35058, CoinNum = 40, ItemID = 74001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[543] = {id = 543, ShopType = 39014, level = 14, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 10, PayItemID = 31386, PayItemNum = 5}
, 
[544] = {id = 544, ShopType = 39014, level = 15, CoinID = 35058, CoinNum = 40, ItemID = 74002, ItemNum = 10, PayItemID = 31383, PayItemNum = 5}
, 
[545] = {id = 545, ShopType = 39014, level = 16, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[546] = {id = 546, ShopType = 39014, level = 17, CoinID = 35058, CoinNum = 40, ItemID = 79002, ItemNum = 2, PayItemID = 31380, PayItemNum = 10}
, 
[547] = {id = 547, ShopType = 39014, level = 18, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 10, PayItemID = 31386, PayItemNum = 10}
, 
[548] = {id = 548, ShopType = 39014, level = 19, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 10}
, 
[549] = {id = 549, ShopType = 39014, level = 20, CoinID = 35058, CoinNum = 40, ItemID = 74004, ItemNum = 5, PayItemID = 31389, PayItemNum = 10}
, 
[550] = {id = 550, ShopType = 39014, level = 21, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31381, PayItemNum = 5}
, 
[551] = {id = 551, ShopType = 39014, level = 22, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 15, PayItemID = 31387, PayItemNum = 5}
, 
[552] = {id = 552, ShopType = 39014, level = 23, CoinID = 35058, CoinNum = 40, ItemID = 35026, ItemNum = 10, PayItemID = 31384, PayItemNum = 5}
, 
[553] = {id = 553, ShopType = 39014, level = 24, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 15, PayItemID = 31390, PayItemNum = 5}
, 
[554] = {id = 554, ShopType = 39014, level = 25, CoinID = 35058, CoinNum = 40, ItemID = 74005, ItemNum = 5, PayItemID = 95106, PayItemNum = 1}
, 
[555] = {id = 555, ShopType = 39014, level = 26, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 15, PayItemID = 31381, PayItemNum = 10}
, 
[556] = {id = 556, ShopType = 39014, level = 27, CoinID = 35058, CoinNum = 40, ItemID = 70002, ItemNum = 1, PayItemID = 31387, PayItemNum = 10}
, 
[557] = {id = 557, ShopType = 39014, level = 28, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 15, PayItemID = 31384, PayItemNum = 10}
, 
[558] = {id = 558, ShopType = 39014, level = 29, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 300000, PayItemID = 31390, PayItemNum = 10}
, 
[559] = {id = 559, ShopType = 39014, level = 30, CoinID = 35058, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 30076, PayItemNum = 2}
, 
[560] = {id = 560, ShopType = 39014, level = -1, CoinID = 35058, CoinNum = 50, ItemID = 35002, ItemNum = 100000, PayItemID = 35002, PayItemNum = 200000}
, 
[561] = {id = 561, ShopType = 39014, level = -2, CoinID = 35058, CoinNum = 50, ItemID = 79001, ItemNum = 10, PayItemID = 79001, PayItemNum = 20}
, 
[562] = {id = 562, ShopType = 39014, level = -3, CoinID = 35058, CoinNum = 50, ItemID = 74002, ItemNum = 5, PayItemID = 35008, PayItemNum = 40}
, 
[563] = {id = 563, ShopType = 39015, level = 1, CoinID = 35058, CoinNum = 20, ItemID = 35002, ItemNum = 50000, PayItemID = 31380, PayItemNum = 5}
, 
[564] = {id = 564, ShopType = 39015, level = 2, CoinID = 35058, CoinNum = 20, ItemID = 31380, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[565] = {id = 565, ShopType = 39015, level = 3, CoinID = 35058, CoinNum = 20, ItemID = 74003, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[566] = {id = 566, ShopType = 39015, level = 4, CoinID = 35058, CoinNum = 20, ItemID = 31386, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[567] = {id = 567, ShopType = 39015, level = 5, CoinID = 35058, CoinNum = 20, ItemID = 79001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[568] = {id = 568, ShopType = 39015, level = 6, CoinID = 35058, CoinNum = 30, ItemID = 31383, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[569] = {id = 569, ShopType = 39015, level = 7, CoinID = 35058, CoinNum = 30, ItemID = 74000, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[570] = {id = 570, ShopType = 39015, level = 8, CoinID = 35058, CoinNum = 30, ItemID = 31389, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[571] = {id = 571, ShopType = 39015, level = 9, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 100000, PayItemID = 31380, PayItemNum = 5}
, 
[572] = {id = 572, ShopType = 39015, level = 10, CoinID = 35058, CoinNum = 30, ItemID = 70001, ItemNum = 1, PayItemID = 31386, PayItemNum = 5}
, 
[573] = {id = 573, ShopType = 39015, level = 11, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 5}
, 
[574] = {id = 574, ShopType = 39015, level = 12, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[575] = {id = 575, ShopType = 39015, level = 13, CoinID = 35058, CoinNum = 40, ItemID = 74001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[576] = {id = 576, ShopType = 39015, level = 14, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 10, PayItemID = 31386, PayItemNum = 5}
, 
[577] = {id = 577, ShopType = 39015, level = 15, CoinID = 35058, CoinNum = 40, ItemID = 74002, ItemNum = 10, PayItemID = 31383, PayItemNum = 5}
, 
[578] = {id = 578, ShopType = 39015, level = 16, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[579] = {id = 579, ShopType = 39015, level = 17, CoinID = 35058, CoinNum = 40, ItemID = 79002, ItemNum = 2, PayItemID = 31380, PayItemNum = 10}
, 
[580] = {id = 580, ShopType = 39015, level = 18, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 10, PayItemID = 31386, PayItemNum = 10}
, 
[581] = {id = 581, ShopType = 39015, level = 19, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 10}
, 
[582] = {id = 582, ShopType = 39015, level = 20, CoinID = 35058, CoinNum = 40, ItemID = 74004, ItemNum = 5, PayItemID = 31389, PayItemNum = 10}
, 
[583] = {id = 583, ShopType = 39015, level = 21, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31381, PayItemNum = 5}
, 
[584] = {id = 584, ShopType = 39015, level = 22, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 15, PayItemID = 31387, PayItemNum = 5}
, 
[585] = {id = 585, ShopType = 39015, level = 23, CoinID = 35058, CoinNum = 40, ItemID = 35026, ItemNum = 10, PayItemID = 31384, PayItemNum = 5}
, 
[586] = {id = 586, ShopType = 39015, level = 24, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 15, PayItemID = 31390, PayItemNum = 5}
, 
[587] = {id = 587, ShopType = 39015, level = 25, CoinID = 35058, CoinNum = 40, ItemID = 74005, ItemNum = 5, PayItemID = 95091, PayItemNum = 1}
, 
[588] = {id = 588, ShopType = 39015, level = 26, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 15, PayItemID = 31381, PayItemNum = 10}
, 
[589] = {id = 589, ShopType = 39015, level = 27, CoinID = 35058, CoinNum = 40, ItemID = 70002, ItemNum = 1, PayItemID = 31387, PayItemNum = 10}
, 
[590] = {id = 590, ShopType = 39015, level = 28, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 15, PayItemID = 31384, PayItemNum = 10}
, 
[591] = {id = 591, ShopType = 39015, level = 29, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 300000, PayItemID = 31390, PayItemNum = 10}
, 
[592] = {id = 592, ShopType = 39015, level = 30, CoinID = 35058, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 30076, PayItemNum = 2}
, 
[593] = {id = 593, ShopType = 39015, level = -1, CoinID = 35058, CoinNum = 50, ItemID = 35002, ItemNum = 100000, PayItemID = 35002, PayItemNum = 200000}
, 
[594] = {id = 594, ShopType = 39015, level = -2, CoinID = 35058, CoinNum = 50, ItemID = 79001, ItemNum = 10, PayItemID = 79001, PayItemNum = 20}
, 
[595] = {id = 595, ShopType = 39015, level = -3, CoinID = 35058, CoinNum = 50, ItemID = 74002, ItemNum = 5, PayItemID = 35008, PayItemNum = 40}
, 
[596] = {id = 596, ShopType = 39016, level = 1, CoinID = 35058, CoinNum = 20, ItemID = 35002, ItemNum = 50000, PayItemID = 31380, PayItemNum = 5}
, 
[597] = {id = 597, ShopType = 39016, level = 2, CoinID = 35058, CoinNum = 20, ItemID = 31380, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[598] = {id = 598, ShopType = 39016, level = 3, CoinID = 35058, CoinNum = 20, ItemID = 74003, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[599] = {id = 599, ShopType = 39016, level = 4, CoinID = 35058, CoinNum = 20, ItemID = 31386, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[600] = {id = 600, ShopType = 39016, level = 5, CoinID = 35058, CoinNum = 20, ItemID = 79001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[601] = {id = 601, ShopType = 39016, level = 6, CoinID = 35058, CoinNum = 30, ItemID = 31383, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[602] = {id = 602, ShopType = 39016, level = 7, CoinID = 35058, CoinNum = 30, ItemID = 74000, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[603] = {id = 603, ShopType = 39016, level = 8, CoinID = 35058, CoinNum = 30, ItemID = 31389, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[604] = {id = 604, ShopType = 39016, level = 9, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 100000, PayItemID = 31380, PayItemNum = 5}
, 
[605] = {id = 605, ShopType = 39016, level = 10, CoinID = 35058, CoinNum = 30, ItemID = 70001, ItemNum = 1, PayItemID = 31386, PayItemNum = 5}
, 
[606] = {id = 606, ShopType = 39016, level = 11, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 5}
, 
[607] = {id = 607, ShopType = 39016, level = 12, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[608] = {id = 608, ShopType = 39016, level = 13, CoinID = 35058, CoinNum = 40, ItemID = 74001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[609] = {id = 609, ShopType = 39016, level = 14, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 10, PayItemID = 31386, PayItemNum = 5}
, 
[610] = {id = 610, ShopType = 39016, level = 15, CoinID = 35058, CoinNum = 40, ItemID = 74002, ItemNum = 10, PayItemID = 31383, PayItemNum = 5}
, 
[611] = {id = 611, ShopType = 39016, level = 16, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[612] = {id = 612, ShopType = 39016, level = 17, CoinID = 35058, CoinNum = 40, ItemID = 79002, ItemNum = 2, PayItemID = 31380, PayItemNum = 10}
, 
[613] = {id = 613, ShopType = 39016, level = 18, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 10, PayItemID = 31386, PayItemNum = 10}
, 
[614] = {id = 614, ShopType = 39016, level = 19, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 10}
, 
[615] = {id = 615, ShopType = 39016, level = 20, CoinID = 35058, CoinNum = 40, ItemID = 74004, ItemNum = 5, PayItemID = 31389, PayItemNum = 10}
, 
[616] = {id = 616, ShopType = 39016, level = 21, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31381, PayItemNum = 5}
, 
[617] = {id = 617, ShopType = 39016, level = 22, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 15, PayItemID = 31387, PayItemNum = 5}
, 
[618] = {id = 618, ShopType = 39016, level = 23, CoinID = 35058, CoinNum = 40, ItemID = 35026, ItemNum = 10, PayItemID = 31384, PayItemNum = 5}
, 
[619] = {id = 619, ShopType = 39016, level = 24, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 15, PayItemID = 31390, PayItemNum = 5}
, 
[620] = {id = 620, ShopType = 39016, level = 25, CoinID = 35058, CoinNum = 40, ItemID = 74005, ItemNum = 5, PayItemID = 95099, PayItemNum = 1}
, 
[621] = {id = 621, ShopType = 39016, level = 26, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 15, PayItemID = 31381, PayItemNum = 10}
, 
[622] = {id = 622, ShopType = 39016, level = 27, CoinID = 35058, CoinNum = 40, ItemID = 70002, ItemNum = 1, PayItemID = 31387, PayItemNum = 10}
, 
[623] = {id = 623, ShopType = 39016, level = 28, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 15, PayItemID = 31384, PayItemNum = 10}
, 
[624] = {id = 624, ShopType = 39016, level = 29, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 300000, PayItemID = 31390, PayItemNum = 10}
, 
[625] = {id = 625, ShopType = 39016, level = 30, CoinID = 35058, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 30076, PayItemNum = 2}
, 
[626] = {id = 626, ShopType = 39016, level = -1, CoinID = 35058, CoinNum = 50, ItemID = 35002, ItemNum = 100000, PayItemID = 35002, PayItemNum = 200000}
, 
[627] = {id = 627, ShopType = 39016, level = -2, CoinID = 35058, CoinNum = 50, ItemID = 79001, ItemNum = 10, PayItemID = 79001, PayItemNum = 20}
, 
[628] = {id = 628, ShopType = 39016, level = -3, CoinID = 35058, CoinNum = 50, ItemID = 74002, ItemNum = 5, PayItemID = 35008, PayItemNum = 40}
, 
[629] = {id = 629, ShopType = 39017, level = 1, CoinID = 35058, CoinNum = 20, ItemID = 35002, ItemNum = 50000, PayItemID = 31380, PayItemNum = 5}
, 
[630] = {id = 630, ShopType = 39017, level = 2, CoinID = 35058, CoinNum = 20, ItemID = 31380, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[631] = {id = 631, ShopType = 39017, level = 3, CoinID = 35058, CoinNum = 20, ItemID = 74003, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[632] = {id = 632, ShopType = 39017, level = 4, CoinID = 35058, CoinNum = 20, ItemID = 31386, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[633] = {id = 633, ShopType = 39017, level = 5, CoinID = 35058, CoinNum = 20, ItemID = 79001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[634] = {id = 634, ShopType = 39017, level = 6, CoinID = 35058, CoinNum = 30, ItemID = 31383, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[635] = {id = 635, ShopType = 39017, level = 7, CoinID = 35058, CoinNum = 30, ItemID = 74000, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[636] = {id = 636, ShopType = 39017, level = 8, CoinID = 35058, CoinNum = 30, ItemID = 31389, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[637] = {id = 637, ShopType = 39017, level = 9, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 100000, PayItemID = 31380, PayItemNum = 5}
, 
[638] = {id = 638, ShopType = 39017, level = 10, CoinID = 35058, CoinNum = 30, ItemID = 70001, ItemNum = 1, PayItemID = 31386, PayItemNum = 5}
, 
[639] = {id = 639, ShopType = 39017, level = 11, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 5}
, 
[640] = {id = 640, ShopType = 39017, level = 12, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[641] = {id = 641, ShopType = 39017, level = 13, CoinID = 35058, CoinNum = 40, ItemID = 74001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[642] = {id = 642, ShopType = 39017, level = 14, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 10, PayItemID = 31386, PayItemNum = 5}
, 
[643] = {id = 643, ShopType = 39017, level = 15, CoinID = 35058, CoinNum = 40, ItemID = 74002, ItemNum = 10, PayItemID = 31383, PayItemNum = 5}
, 
[644] = {id = 644, ShopType = 39017, level = 16, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[645] = {id = 645, ShopType = 39017, level = 17, CoinID = 35058, CoinNum = 40, ItemID = 79002, ItemNum = 2, PayItemID = 31380, PayItemNum = 10}
, 
[646] = {id = 646, ShopType = 39017, level = 18, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 10, PayItemID = 31386, PayItemNum = 10}
, 
[647] = {id = 647, ShopType = 39017, level = 19, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 10}
, 
[648] = {id = 648, ShopType = 39017, level = 20, CoinID = 35058, CoinNum = 40, ItemID = 74004, ItemNum = 5, PayItemID = 31389, PayItemNum = 10}
, 
[649] = {id = 649, ShopType = 39017, level = 21, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31381, PayItemNum = 5}
, 
[650] = {id = 650, ShopType = 39017, level = 22, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 15, PayItemID = 31387, PayItemNum = 5}
, 
[651] = {id = 651, ShopType = 39017, level = 23, CoinID = 35058, CoinNum = 40, ItemID = 35026, ItemNum = 10, PayItemID = 31384, PayItemNum = 5}
, 
[652] = {id = 652, ShopType = 39017, level = 24, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 15, PayItemID = 31390, PayItemNum = 5}
, 
[653] = {id = 653, ShopType = 39017, level = 25, CoinID = 35058, CoinNum = 40, ItemID = 74005, ItemNum = 5, PayItemID = 95006, PayItemNum = 1}
, 
[654] = {id = 654, ShopType = 39017, level = 26, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 15, PayItemID = 31381, PayItemNum = 10}
, 
[655] = {id = 655, ShopType = 39017, level = 27, CoinID = 35058, CoinNum = 40, ItemID = 70002, ItemNum = 1, PayItemID = 31387, PayItemNum = 10}
, 
[656] = {id = 656, ShopType = 39017, level = 28, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 15, PayItemID = 31384, PayItemNum = 10}
, 
[657] = {id = 657, ShopType = 39017, level = 29, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 300000, PayItemID = 31390, PayItemNum = 10}
, 
[658] = {id = 658, ShopType = 39017, level = 30, CoinID = 35058, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 30076, PayItemNum = 2}
, 
[659] = {id = 659, ShopType = 39017, level = -1, CoinID = 35058, CoinNum = 50, ItemID = 35002, ItemNum = 100000, PayItemID = 35002, PayItemNum = 200000}
, 
[660] = {id = 660, ShopType = 39017, level = -2, CoinID = 35058, CoinNum = 50, ItemID = 79001, ItemNum = 10, PayItemID = 79001, PayItemNum = 20}
, 
[661] = {id = 661, ShopType = 39017, level = -3, CoinID = 35058, CoinNum = 50, ItemID = 74002, ItemNum = 5, PayItemID = 35008, PayItemNum = 40}
, 
[662] = {id = 662, ShopType = 39018, level = 1, CoinID = 35058, CoinNum = 20, ItemID = 35002, ItemNum = 50000, PayItemID = 31380, PayItemNum = 5}
, 
[663] = {id = 663, ShopType = 39018, level = 2, CoinID = 35058, CoinNum = 20, ItemID = 31380, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[664] = {id = 664, ShopType = 39018, level = 3, CoinID = 35058, CoinNum = 20, ItemID = 74003, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[665] = {id = 665, ShopType = 39018, level = 4, CoinID = 35058, CoinNum = 20, ItemID = 31386, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[666] = {id = 666, ShopType = 39018, level = 5, CoinID = 35058, CoinNum = 20, ItemID = 79001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[667] = {id = 667, ShopType = 39018, level = 6, CoinID = 35058, CoinNum = 30, ItemID = 31383, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[668] = {id = 668, ShopType = 39018, level = 7, CoinID = 35058, CoinNum = 30, ItemID = 74000, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[669] = {id = 669, ShopType = 39018, level = 8, CoinID = 35058, CoinNum = 30, ItemID = 31389, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[670] = {id = 670, ShopType = 39018, level = 9, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 100000, PayItemID = 31380, PayItemNum = 5}
, 
[671] = {id = 671, ShopType = 39018, level = 10, CoinID = 35058, CoinNum = 30, ItemID = 70001, ItemNum = 1, PayItemID = 31386, PayItemNum = 5}
, 
[672] = {id = 672, ShopType = 39018, level = 11, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 5}
, 
[673] = {id = 673, ShopType = 39018, level = 12, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[674] = {id = 674, ShopType = 39018, level = 13, CoinID = 35058, CoinNum = 40, ItemID = 74001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[675] = {id = 675, ShopType = 39018, level = 14, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 10, PayItemID = 31386, PayItemNum = 5}
, 
[676] = {id = 676, ShopType = 39018, level = 15, CoinID = 35058, CoinNum = 40, ItemID = 74002, ItemNum = 10, PayItemID = 31383, PayItemNum = 5}
, 
[677] = {id = 677, ShopType = 39018, level = 16, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[678] = {id = 678, ShopType = 39018, level = 17, CoinID = 35058, CoinNum = 40, ItemID = 79002, ItemNum = 2, PayItemID = 31380, PayItemNum = 10}
, 
[679] = {id = 679, ShopType = 39018, level = 18, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 10, PayItemID = 31386, PayItemNum = 10}
, 
[680] = {id = 680, ShopType = 39018, level = 19, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 10}
, 
[681] = {id = 681, ShopType = 39018, level = 20, CoinID = 35058, CoinNum = 40, ItemID = 74004, ItemNum = 5, PayItemID = 31389, PayItemNum = 10}
, 
[682] = {id = 682, ShopType = 39018, level = 21, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31381, PayItemNum = 5}
, 
[683] = {id = 683, ShopType = 39018, level = 22, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 15, PayItemID = 31387, PayItemNum = 5}
, 
[684] = {id = 684, ShopType = 39018, level = 23, CoinID = 35058, CoinNum = 40, ItemID = 35026, ItemNum = 10, PayItemID = 31384, PayItemNum = 5}
, 
[685] = {id = 685, ShopType = 39018, level = 24, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 15, PayItemID = 31390, PayItemNum = 5}
, 
[686] = {id = 686, ShopType = 39018, level = 25, CoinID = 35058, CoinNum = 40, ItemID = 74005, ItemNum = 5, PayItemID = 95092, PayItemNum = 1}
, 
[687] = {id = 687, ShopType = 39018, level = 26, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 15, PayItemID = 31381, PayItemNum = 10}
, 
[688] = {id = 688, ShopType = 39018, level = 27, CoinID = 35058, CoinNum = 40, ItemID = 70002, ItemNum = 1, PayItemID = 31387, PayItemNum = 10}
, 
[689] = {id = 689, ShopType = 39018, level = 28, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 15, PayItemID = 31384, PayItemNum = 10}
, 
[690] = {id = 690, ShopType = 39018, level = 29, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 300000, PayItemID = 31390, PayItemNum = 10}
, 
[691] = {id = 691, ShopType = 39018, level = 30, CoinID = 35058, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 30076, PayItemNum = 2}
, 
[692] = {id = 692, ShopType = 39018, level = -1, CoinID = 35058, CoinNum = 50, ItemID = 35002, ItemNum = 100000, PayItemID = 35002, PayItemNum = 200000}
, 
[693] = {id = 693, ShopType = 39018, level = -2, CoinID = 35058, CoinNum = 50, ItemID = 79001, ItemNum = 10, PayItemID = 79001, PayItemNum = 20}
, 
[694] = {id = 694, ShopType = 39018, level = -3, CoinID = 35058, CoinNum = 50, ItemID = 74002, ItemNum = 5, PayItemID = 35008, PayItemNum = 40}
, 
[695] = {id = 695, ShopType = 39019, level = 1, CoinID = 35058, CoinNum = 20, ItemID = 35002, ItemNum = 50000, PayItemID = 31380, PayItemNum = 5}
, 
[696] = {id = 696, ShopType = 39019, level = 2, CoinID = 35058, CoinNum = 20, ItemID = 31380, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[697] = {id = 697, ShopType = 39019, level = 3, CoinID = 35058, CoinNum = 20, ItemID = 74003, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[698] = {id = 698, ShopType = 39019, level = 4, CoinID = 35058, CoinNum = 20, ItemID = 31386, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[699] = {id = 699, ShopType = 39019, level = 5, CoinID = 35058, CoinNum = 20, ItemID = 79001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[700] = {id = 700, ShopType = 39019, level = 6, CoinID = 35058, CoinNum = 30, ItemID = 31383, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[701] = {id = 701, ShopType = 39019, level = 7, CoinID = 35058, CoinNum = 30, ItemID = 74000, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[702] = {id = 702, ShopType = 39019, level = 8, CoinID = 35058, CoinNum = 30, ItemID = 31389, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[703] = {id = 703, ShopType = 39019, level = 9, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 100000, PayItemID = 31380, PayItemNum = 5}
, 
[704] = {id = 704, ShopType = 39019, level = 10, CoinID = 35058, CoinNum = 30, ItemID = 70001, ItemNum = 1, PayItemID = 31386, PayItemNum = 5}
, 
[705] = {id = 705, ShopType = 39019, level = 11, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 5}
, 
[706] = {id = 706, ShopType = 39019, level = 12, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[707] = {id = 707, ShopType = 39019, level = 13, CoinID = 35058, CoinNum = 40, ItemID = 74001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[708] = {id = 708, ShopType = 39019, level = 14, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 10, PayItemID = 31386, PayItemNum = 5}
, 
[709] = {id = 709, ShopType = 39019, level = 15, CoinID = 35058, CoinNum = 40, ItemID = 74002, ItemNum = 10, PayItemID = 31383, PayItemNum = 5}
, 
[710] = {id = 710, ShopType = 39019, level = 16, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[711] = {id = 711, ShopType = 39019, level = 17, CoinID = 35058, CoinNum = 40, ItemID = 79002, ItemNum = 2, PayItemID = 31380, PayItemNum = 10}
, 
[712] = {id = 712, ShopType = 39019, level = 18, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 10, PayItemID = 31386, PayItemNum = 10}
, 
[713] = {id = 713, ShopType = 39019, level = 19, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 10}
, 
[714] = {id = 714, ShopType = 39019, level = 20, CoinID = 35058, CoinNum = 40, ItemID = 74004, ItemNum = 5, PayItemID = 31389, PayItemNum = 10}
, 
[715] = {id = 715, ShopType = 39019, level = 21, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31381, PayItemNum = 5}
, 
[716] = {id = 716, ShopType = 39019, level = 22, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 15, PayItemID = 31387, PayItemNum = 5}
, 
[717] = {id = 717, ShopType = 39019, level = 23, CoinID = 35058, CoinNum = 40, ItemID = 35026, ItemNum = 10, PayItemID = 31384, PayItemNum = 5}
, 
[718] = {id = 718, ShopType = 39019, level = 24, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 15, PayItemID = 31390, PayItemNum = 5}
, 
[719] = {id = 719, ShopType = 39019, level = 25, CoinID = 35058, CoinNum = 40, ItemID = 74005, ItemNum = 5, PayItemID = 95070, PayItemNum = 1}
, 
[720] = {id = 720, ShopType = 39019, level = 26, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 15, PayItemID = 31381, PayItemNum = 10}
, 
[721] = {id = 721, ShopType = 39019, level = 27, CoinID = 35058, CoinNum = 40, ItemID = 70002, ItemNum = 1, PayItemID = 31387, PayItemNum = 10}
, 
[722] = {id = 722, ShopType = 39019, level = 28, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 15, PayItemID = 31384, PayItemNum = 10}
, 
[723] = {id = 723, ShopType = 39019, level = 29, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 300000, PayItemID = 31390, PayItemNum = 10}
, 
[724] = {id = 724, ShopType = 39019, level = 30, CoinID = 35058, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 30076, PayItemNum = 2}
, 
[725] = {id = 725, ShopType = 39019, level = -1, CoinID = 35058, CoinNum = 50, ItemID = 35002, ItemNum = 100000, PayItemID = 35002, PayItemNum = 200000}
, 
[726] = {id = 726, ShopType = 39019, level = -2, CoinID = 35058, CoinNum = 50, ItemID = 79001, ItemNum = 10, PayItemID = 79001, PayItemNum = 20}
, 
[727] = {id = 727, ShopType = 39019, level = -3, CoinID = 35058, CoinNum = 50, ItemID = 74002, ItemNum = 5, PayItemID = 35008, PayItemNum = 40}
, 
[728] = {id = 728, ShopType = 39020, level = 1, CoinID = 35058, CoinNum = 20, ItemID = 35002, ItemNum = 50000, PayItemID = 31380, PayItemNum = 5}
, 
[729] = {id = 729, ShopType = 39020, level = 2, CoinID = 35058, CoinNum = 20, ItemID = 31380, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[730] = {id = 730, ShopType = 39020, level = 3, CoinID = 35058, CoinNum = 20, ItemID = 74003, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[731] = {id = 731, ShopType = 39020, level = 4, CoinID = 35058, CoinNum = 20, ItemID = 31386, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[732] = {id = 732, ShopType = 39020, level = 5, CoinID = 35058, CoinNum = 20, ItemID = 79001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[733] = {id = 733, ShopType = 39020, level = 6, CoinID = 35058, CoinNum = 30, ItemID = 31383, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[734] = {id = 734, ShopType = 39020, level = 7, CoinID = 35058, CoinNum = 30, ItemID = 74000, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[735] = {id = 735, ShopType = 39020, level = 8, CoinID = 35058, CoinNum = 30, ItemID = 31389, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[736] = {id = 736, ShopType = 39020, level = 9, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 100000, PayItemID = 31380, PayItemNum = 5}
, 
[737] = {id = 737, ShopType = 39020, level = 10, CoinID = 35058, CoinNum = 30, ItemID = 70001, ItemNum = 1, PayItemID = 31386, PayItemNum = 5}
, 
[738] = {id = 738, ShopType = 39020, level = 11, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 5}
, 
[739] = {id = 739, ShopType = 39020, level = 12, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[740] = {id = 740, ShopType = 39020, level = 13, CoinID = 35058, CoinNum = 40, ItemID = 74001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[741] = {id = 741, ShopType = 39020, level = 14, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 10, PayItemID = 31386, PayItemNum = 5}
, 
[742] = {id = 742, ShopType = 39020, level = 15, CoinID = 35058, CoinNum = 40, ItemID = 74002, ItemNum = 10, PayItemID = 31383, PayItemNum = 5}
, 
[743] = {id = 743, ShopType = 39020, level = 16, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[744] = {id = 744, ShopType = 39020, level = 17, CoinID = 35058, CoinNum = 40, ItemID = 79002, ItemNum = 2, PayItemID = 31380, PayItemNum = 10}
, 
[745] = {id = 745, ShopType = 39020, level = 18, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 10, PayItemID = 31386, PayItemNum = 10}
, 
[746] = {id = 746, ShopType = 39020, level = 19, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 10}
, 
[747] = {id = 747, ShopType = 39020, level = 20, CoinID = 35058, CoinNum = 40, ItemID = 74004, ItemNum = 5, PayItemID = 31389, PayItemNum = 10}
, 
[748] = {id = 748, ShopType = 39020, level = 21, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31381, PayItemNum = 5}
, 
[749] = {id = 749, ShopType = 39020, level = 22, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 15, PayItemID = 31387, PayItemNum = 5}
, 
[750] = {id = 750, ShopType = 39020, level = 23, CoinID = 35058, CoinNum = 40, ItemID = 35026, ItemNum = 10, PayItemID = 31384, PayItemNum = 5}
, 
[751] = {id = 751, ShopType = 39020, level = 24, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 15, PayItemID = 31390, PayItemNum = 5}
, 
[752] = {id = 752, ShopType = 39020, level = 25, CoinID = 35058, CoinNum = 40, ItemID = 74005, ItemNum = 5, PayItemID = 95017, PayItemNum = 1}
, 
[753] = {id = 753, ShopType = 39020, level = 26, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 15, PayItemID = 31381, PayItemNum = 10}
, 
[754] = {id = 754, ShopType = 39020, level = 27, CoinID = 35058, CoinNum = 40, ItemID = 70002, ItemNum = 1, PayItemID = 31387, PayItemNum = 10}
, 
[755] = {id = 755, ShopType = 39020, level = 28, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 15, PayItemID = 31384, PayItemNum = 10}
, 
[756] = {id = 756, ShopType = 39020, level = 29, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 300000, PayItemID = 31390, PayItemNum = 10}
, 
[757] = {id = 757, ShopType = 39020, level = 30, CoinID = 35058, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 30076, PayItemNum = 2}
, 
[758] = {id = 758, ShopType = 39020, level = -1, CoinID = 35058, CoinNum = 50, ItemID = 35002, ItemNum = 100000, PayItemID = 35002, PayItemNum = 200000}
, 
[759] = {id = 759, ShopType = 39020, level = -2, CoinID = 35058, CoinNum = 50, ItemID = 79001, ItemNum = 10, PayItemID = 79001, PayItemNum = 20}
, 
[760] = {id = 760, ShopType = 39020, level = -3, CoinID = 35058, CoinNum = 50, ItemID = 74002, ItemNum = 5, PayItemID = 35008, PayItemNum = 40}
, 
[761] = {id = 761, ShopType = 39021, level = 1, CoinID = 35058, CoinNum = 20, ItemID = 35002, ItemNum = 50000, PayItemID = 31380, PayItemNum = 5}
, 
[762] = {id = 762, ShopType = 39021, level = 2, CoinID = 35058, CoinNum = 20, ItemID = 31380, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[763] = {id = 763, ShopType = 39021, level = 3, CoinID = 35058, CoinNum = 20, ItemID = 74003, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[764] = {id = 764, ShopType = 39021, level = 4, CoinID = 35058, CoinNum = 20, ItemID = 31386, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[765] = {id = 765, ShopType = 39021, level = 5, CoinID = 35058, CoinNum = 20, ItemID = 79001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[766] = {id = 766, ShopType = 39021, level = 6, CoinID = 35058, CoinNum = 30, ItemID = 31383, ItemNum = 5, PayItemID = 31386, PayItemNum = 5}
, 
[767] = {id = 767, ShopType = 39021, level = 7, CoinID = 35058, CoinNum = 30, ItemID = 74000, ItemNum = 5, PayItemID = 31383, PayItemNum = 5}
, 
[768] = {id = 768, ShopType = 39021, level = 8, CoinID = 35058, CoinNum = 30, ItemID = 31389, ItemNum = 5, PayItemID = 31389, PayItemNum = 5}
, 
[769] = {id = 769, ShopType = 39021, level = 9, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 100000, PayItemID = 31380, PayItemNum = 5}
, 
[770] = {id = 770, ShopType = 39021, level = 10, CoinID = 35058, CoinNum = 30, ItemID = 70001, ItemNum = 1, PayItemID = 31386, PayItemNum = 5}
, 
[771] = {id = 771, ShopType = 39021, level = 11, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 5}
, 
[772] = {id = 772, ShopType = 39021, level = 12, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[773] = {id = 773, ShopType = 39021, level = 13, CoinID = 35058, CoinNum = 40, ItemID = 74001, ItemNum = 10, PayItemID = 31380, PayItemNum = 5}
, 
[774] = {id = 774, ShopType = 39021, level = 14, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 10, PayItemID = 31386, PayItemNum = 5}
, 
[775] = {id = 775, ShopType = 39021, level = 15, CoinID = 35058, CoinNum = 40, ItemID = 74002, ItemNum = 10, PayItemID = 31383, PayItemNum = 5}
, 
[776] = {id = 776, ShopType = 39021, level = 16, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 10, PayItemID = 31389, PayItemNum = 5}
, 
[777] = {id = 777, ShopType = 39021, level = 17, CoinID = 35058, CoinNum = 40, ItemID = 79002, ItemNum = 2, PayItemID = 31380, PayItemNum = 10}
, 
[778] = {id = 778, ShopType = 39021, level = 18, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 10, PayItemID = 31386, PayItemNum = 10}
, 
[779] = {id = 779, ShopType = 39021, level = 19, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31383, PayItemNum = 10}
, 
[780] = {id = 780, ShopType = 39021, level = 20, CoinID = 35058, CoinNum = 40, ItemID = 74004, ItemNum = 5, PayItemID = 31389, PayItemNum = 10}
, 
[781] = {id = 781, ShopType = 39021, level = 21, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 200000, PayItemID = 31381, PayItemNum = 5}
, 
[782] = {id = 782, ShopType = 39021, level = 22, CoinID = 35058, CoinNum = 40, ItemID = 31380, ItemNum = 15, PayItemID = 31387, PayItemNum = 5}
, 
[783] = {id = 783, ShopType = 39021, level = 23, CoinID = 35058, CoinNum = 40, ItemID = 35026, ItemNum = 10, PayItemID = 31384, PayItemNum = 5}
, 
[784] = {id = 784, ShopType = 39021, level = 24, CoinID = 35058, CoinNum = 40, ItemID = 31386, ItemNum = 15, PayItemID = 31390, PayItemNum = 5}
, 
[785] = {id = 785, ShopType = 39021, level = 25, CoinID = 35058, CoinNum = 40, ItemID = 74005, ItemNum = 5, PayItemID = 95010, PayItemNum = 1}
, 
[786] = {id = 786, ShopType = 39021, level = 26, CoinID = 35058, CoinNum = 40, ItemID = 31383, ItemNum = 15, PayItemID = 31381, PayItemNum = 10}
, 
[787] = {id = 787, ShopType = 39021, level = 27, CoinID = 35058, CoinNum = 40, ItemID = 70002, ItemNum = 1, PayItemID = 31387, PayItemNum = 10}
, 
[788] = {id = 788, ShopType = 39021, level = 28, CoinID = 35058, CoinNum = 40, ItemID = 31389, ItemNum = 15, PayItemID = 31384, PayItemNum = 10}
, 
[789] = {id = 789, ShopType = 39021, level = 29, CoinID = 35058, CoinNum = 40, ItemID = 35002, ItemNum = 300000, PayItemID = 31390, PayItemNum = 10}
, 
[790] = {id = 790, ShopType = 39021, level = 30, CoinID = 35058, CoinNum = 50, ItemID = 79004, ItemNum = 1, PayItemID = 30076, PayItemNum = 2}
, 
[791] = {id = 791, ShopType = 39021, level = -1, CoinID = 35058, CoinNum = 50, ItemID = 35002, ItemNum = 100000, PayItemID = 35002, PayItemNum = 200000}
, 
[792] = {id = 792, ShopType = 39021, level = -2, CoinID = 35058, CoinNum = 50, ItemID = 79001, ItemNum = 10, PayItemID = 79001, PayItemNum = 20}
, 
[793] = {id = 793, ShopType = 39021, level = -3, CoinID = 35058, CoinNum = 50, ItemID = 74002, ItemNum = 5, PayItemID = 35008, PayItemNum = 40}
}
clittlebattlepassreward.AllIds = {101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 497, 498, 499, 500, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511, 512, 513, 514, 515, 516, 517, 518, 519, 520, 521, 522, 523, 524, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 549, 550, 551, 552, 553, 554, 555, 556, 557, 558, 559, 560, 561, 562, 563, 564, 565, 566, 567, 568, 569, 570, 571, 572, 573, 574, 575, 576, 577, 578, 579, 580, 581, 582, 583, 584, 585, 586, 587, 588, 589, 590, 591, 592, 593, 594, 595, 596, 597, 598, 599, 600, 601, 602, 603, 604, 605, 606, 607, 608, 609, 610, 611, 612, 613, 614, 615, 616, 617, 618, 619, 620, 621, 622, 623, 624, 625, 626, 627, 628, 629, 630, 631, 632, 633, 634, 635, 636, 637, 638, 639, 640, 641, 642, 643, 644, 645, 646, 647, 648, 649, 650, 651, 652, 653, 654, 655, 656, 657, 658, 659, 660, 661, 662, 663, 664, 665, 666, 667, 668, 669, 670, 671, 672, 673, 674, 675, 676, 677, 678, 679, 680, 681, 682, 683, 684, 685, 686, 687, 688, 689, 690, 691, 692, 693, 694, 695, 696, 697, 698, 699, 700, 701, 702, 703, 704, 705, 706, 707, 708, 709, 710, 711, 712, 713, 714, 715, 716, 717, 718, 719, 720, 721, 722, 723, 724, 725, 726, 727, 728, 729, 730, 731, 732, 733, 734, 735, 736, 737, 738, 739, 740, 741, 742, 743, 744, 745, 746, 747, 748, 749, 750, 751, 752, 753, 754, 755, 756, 757, 758, 759, 760, 761, 762, 763, 764, 765, 766, 767, 768, 769, 770, 771, 772, 773, 774, 775, 776, 777, 778, 779, 780, 781, 782, 783, 784, 785, 786, 787, 788, 789, 790, 791, 792, 793}
return clittlebattlepassreward

