-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/welfare/creturnbattlepassreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local creturnbattlepassreward = {}
creturnbattlepassreward.Data = {
[101] = {id = 101, ShopType = 805001, level = 1, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 50000, PayItemID = 74003, PayItemNum = 10, IsRole = 0}
, 
[102] = {id = 102, ShopType = 805001, level = 2, CoinID = 35058, CoinNum = 30, ItemID = 74003, ItemNum = 5, PayItemID = 70001, PayItemNum = 2, IsRole = 0}
, 
[103] = {id = 103, ShopType = 805001, level = 3, CoinID = 35058, CoinNum = 30, ItemID = 31380, ItemNum = 5, PayItemID = 35002, PayItemNum = 100000, IsRole = 0}
, 
[104] = {id = 104, ShopType = 805001, level = 4, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 100000, PayItemID = 31380, PayItemNum = 10, IsRole = 0}
, 
[105] = {id = 105, ShopType = 805001, level = 5, CoinID = 35058, CoinNum = 30, ItemID = 79001, ItemNum = 40, PayItemID = 31038, PayItemNum = 1, IsRole = 0}
, 
[106] = {id = 106, ShopType = 805001, level = 6, CoinID = 35058, CoinNum = 30, ItemID = 74000, ItemNum = 20, PayItemID = 79001, PayItemNum = 80, IsRole = 0}
, 
[107] = {id = 107, ShopType = 805001, level = 7, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 100000, PayItemID = 74001, PayItemNum = 10, IsRole = 0}
, 
[108] = {id = 108, ShopType = 805001, level = 8, CoinID = 35058, CoinNum = 30, ItemID = 31383, ItemNum = 5, PayItemID = 35002, PayItemNum = 200000, IsRole = 0}
, 
[109] = {id = 109, ShopType = 805001, level = 9, CoinID = 35058, CoinNum = 30, ItemID = 79002, ItemNum = 10, PayItemID = 31383, PayItemNum = 10, IsRole = 0}
, 
[110] = {id = 110, ShopType = 805001, level = 10, CoinID = 35058, CoinNum = 30, ItemID = 35008, ItemNum = 40, PayItemID = 31720, PayItemNum = 1, IsRole = 1}
, 
[111] = {id = 111, ShopType = 805001, level = 11, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 200000, PayItemID = 79002, PayItemNum = 20, IsRole = 0}
, 
[112] = {id = 112, ShopType = 805001, level = 12, CoinID = 35058, CoinNum = 30, ItemID = 74000, ItemNum = 10, PayItemID = 74001, PayItemNum = 10, IsRole = 0}
, 
[113] = {id = 113, ShopType = 805001, level = 13, CoinID = 35058, CoinNum = 30, ItemID = 31386, ItemNum = 5, PayItemID = 35002, PayItemNum = 500000, IsRole = 0}
, 
[114] = {id = 114, ShopType = 805001, level = 14, CoinID = 35058, CoinNum = 30, ItemID = 79001, ItemNum = 40, PayItemID = 31386, PayItemNum = 10, IsRole = 0}
, 
[115] = {id = 115, ShopType = 805001, level = 15, CoinID = 35058, CoinNum = 30, ItemID = 70002, ItemNum = 1, PayItemID = 31038, PayItemNum = 2, IsRole = 0}
, 
[116] = {id = 116, ShopType = 805001, level = 16, CoinID = 35058, CoinNum = 30, ItemID = 74001, ItemNum = 10, PayItemID = 79002, PayItemNum = 20, IsRole = 0}
, 
[117] = {id = 117, ShopType = 805001, level = 17, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 200000, PayItemID = 70002, PayItemNum = 2, IsRole = 0}
, 
[118] = {id = 118, ShopType = 805001, level = 18, CoinID = 35058, CoinNum = 30, ItemID = 31389, ItemNum = 5, PayItemID = 74002, PayItemNum = 20, IsRole = 0}
, 
[119] = {id = 119, ShopType = 805001, level = 19, CoinID = 35058, CoinNum = 30, ItemID = 79002, ItemNum = 10, PayItemID = 31389, PayItemNum = 10, IsRole = 0}
, 
[120] = {id = 120, ShopType = 805001, level = 20, CoinID = 35058, CoinNum = 30, ItemID = 35008, ItemNum = 100, PayItemID = 35008, PayItemNum = 200, IsRole = 0}
, 
[121] = {id = 121, ShopType = 805001, level = 21, CoinID = 35058, CoinNum = 30, ItemID = 74002, ItemNum = 10, PayItemID = 35002, PayItemNum = 500000, IsRole = 0}
, 
[122] = {id = 122, ShopType = 805001, level = 22, CoinID = 35058, CoinNum = 30, ItemID = 31381, ItemNum = 5, PayItemID = 31387, PayItemNum = 10, IsRole = 0}
, 
[123] = {id = 123, ShopType = 805001, level = 23, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 500000, PayItemID = 79002, PayItemNum = 20, IsRole = 0}
, 
[124] = {id = 124, ShopType = 805001, level = 24, CoinID = 35058, CoinNum = 30, ItemID = 31384, ItemNum = 5, PayItemID = 31390, PayItemNum = 10, IsRole = 0}
, 
[125] = {id = 125, ShopType = 805001, level = 25, CoinID = 35058, CoinNum = 30, ItemID = 70003, ItemNum = 1, PayItemID = 79004, PayItemNum = 1, IsRole = 0}
, 
[126] = {id = 126, ShopType = 805001, level = 26, CoinID = 35058, CoinNum = 30, ItemID = 31387, ItemNum = 5, PayItemID = 31381, PayItemNum = 10, IsRole = 0}
, 
[127] = {id = 127, ShopType = 805001, level = 27, CoinID = 35058, CoinNum = 30, ItemID = 30076, ItemNum = 1, PayItemID = 74002, PayItemNum = 20, IsRole = 0}
, 
[128] = {id = 128, ShopType = 805001, level = 28, CoinID = 35058, CoinNum = 30, ItemID = 31390, ItemNum = 5, PayItemID = 31384, PayItemNum = 10, IsRole = 0}
, 
[129] = {id = 129, ShopType = 805001, level = 29, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 500000, PayItemID = 70003, PayItemNum = 1, IsRole = 0}
, 
[130] = {id = 130, ShopType = 805001, level = 30, CoinID = 35058, CoinNum = 30, ItemID = 30076, ItemNum = 1, PayItemID = 30076, PayItemNum = 5, IsRole = 0}
, 
[131] = {id = 131, ShopType = 805001, level = 31, CoinID = 35058, CoinNum = 30, ItemID = 35002, ItemNum = 100000, PayItemID = 35002, PayItemNum = 200000, IsRole = 0}
}
creturnbattlepassreward.AllIds = {101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131}
return creturnbattlepassreward

