-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/recharge/cguildstore.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cguildstore = {}
cguildstore.Data = {
[1] = {id = 1, Sort = 1, storelevel = 1, Itemid = 30076, Nums = 1, Stoc = 5, kMoneyType = 35004, Price = 500, Discount = -1, DiscountPrice = 500, LimitType = 2, OpenTime = "", CloseTime = ""}
, 
[2] = {id = 2, Sort = 14, storelevel = 1, Itemid = 75000, Nums = 1, Stoc = 10, kMoneyType = 35004, Price = 10, Discount = -1, DiscountPrice = 10, LimitType = 0, OpenTime = "", CloseTime = ""}
, 
[3] = {id = 3, Sort = 15, storelevel = 1, Itemid = 75003, Nums = 1, Stoc = 10, kMoneyType = 35004, Price = 10, Discount = -1, DiscountPrice = 10, LimitType = 0, OpenTime = "", CloseTime = ""}
, 
[4] = {id = 4, Sort = 16, storelevel = 1, Itemid = 75006, Nums = 1, Stoc = 10, kMoneyType = 35004, Price = 10, Discount = -1, DiscountPrice = 10, LimitType = 0, OpenTime = "", CloseTime = ""}
, 
[5] = {id = 5, Sort = 17, storelevel = 1, Itemid = 75009, Nums = 1, Stoc = 10, kMoneyType = 35004, Price = 10, Discount = -1, DiscountPrice = 10, LimitType = 0, OpenTime = "", CloseTime = ""}
, 
[6] = {id = 6, Sort = 18, storelevel = 1, Itemid = 75012, Nums = 1, Stoc = 10, kMoneyType = 35004, Price = 10, Discount = -1, DiscountPrice = 10, LimitType = 0, OpenTime = "", CloseTime = ""}
, 
[7] = {id = 7, Sort = 19, storelevel = 1, Itemid = 75015, Nums = 1, Stoc = 10, kMoneyType = 35004, Price = 10, Discount = -1, DiscountPrice = 10, LimitType = 0, OpenTime = "", CloseTime = ""}
, 
[8] = {id = 8, Sort = 8, storelevel = 1, Itemid = 75001, Nums = 1, Stoc = 10, kMoneyType = 35004, Price = 20, Discount = -1, DiscountPrice = 20, LimitType = 0, OpenTime = "", CloseTime = ""}
, 
[9] = {id = 9, Sort = 9, storelevel = 1, Itemid = 75004, Nums = 1, Stoc = 10, kMoneyType = 35004, Price = 20, Discount = -1, DiscountPrice = 20, LimitType = 0, OpenTime = "", CloseTime = ""}
, 
[10] = {id = 10, Sort = 10, storelevel = 1, Itemid = 75007, Nums = 1, Stoc = 10, kMoneyType = 35004, Price = 20, Discount = -1, DiscountPrice = 20, LimitType = 0, OpenTime = "", CloseTime = ""}
, 
[11] = {id = 11, Sort = 11, storelevel = 1, Itemid = 75010, Nums = 1, Stoc = 10, kMoneyType = 35004, Price = 20, Discount = -1, DiscountPrice = 20, LimitType = 0, OpenTime = "", CloseTime = ""}
, 
[12] = {id = 12, Sort = 12, storelevel = 1, Itemid = 75013, Nums = 1, Stoc = 10, kMoneyType = 35004, Price = 20, Discount = -1, DiscountPrice = 20, LimitType = 0, OpenTime = "", CloseTime = ""}
, 
[13] = {id = 13, Sort = 13, storelevel = 1, Itemid = 75016, Nums = 1, Stoc = 10, kMoneyType = 35004, Price = 20, Discount = -1, DiscountPrice = 20, LimitType = 0, OpenTime = "", CloseTime = ""}
, 
[14] = {id = 14, Sort = 3, storelevel = 2, Itemid = 70001, Nums = 1, Stoc = 5, kMoneyType = 35004, Price = 30, Discount = -1, DiscountPrice = 30, LimitType = 0, OpenTime = "", CloseTime = ""}
, 
[15] = {id = 15, Sort = 4, storelevel = 2, Itemid = 70002, Nums = 1, Stoc = 5, kMoneyType = 35004, Price = 80, Discount = -1, DiscountPrice = 80, LimitType = 0, OpenTime = "", CloseTime = ""}
, 
[16] = {id = 16, Sort = 7, storelevel = 2, Itemid = 74000, Nums = 1, Stoc = 40, kMoneyType = 35004, Price = 10, Discount = -1, DiscountPrice = 10, LimitType = 0, OpenTime = "", CloseTime = ""}
, 
[17] = {id = 17, Sort = 6, storelevel = 2, Itemid = 74001, Nums = 1, Stoc = 40, kMoneyType = 35004, Price = 20, Discount = -1, DiscountPrice = 20, LimitType = 0, OpenTime = "", CloseTime = ""}
, 
[18] = {id = 18, Sort = 2, storelevel = 3, Itemid = 70003, Nums = 1, Stoc = 2, kMoneyType = 35004, Price = 1000, Discount = -1, DiscountPrice = 1000, LimitType = 2, OpenTime = "", CloseTime = ""}
, 
[19] = {id = 19, Sort = 5, storelevel = 3, Itemid = 74002, Nums = 1, Stoc = 30, kMoneyType = 35004, Price = 30, Discount = -1, DiscountPrice = 30, LimitType = 0, OpenTime = "", CloseTime = ""}
, 
[20] = {id = 20, Sort = 20, storelevel = 1, Itemid = 31193, Nums = 1, Stoc = 1, kMoneyType = 35004, Price = 400, Discount = -1, DiscountPrice = 400, LimitType = 3, OpenTime = "", CloseTime = ""}
, 
[21] = {id = 21, Sort = 21, storelevel = 1, Itemid = 31294, Nums = 1, Stoc = 1, kMoneyType = 35004, Price = 400, Discount = -1, DiscountPrice = 400, LimitType = 3, OpenTime = "", CloseTime = ""}
}
cguildstore.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21}
return cguildstore

