-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/recharge/ccommoditstarrymirrorboost.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ccommoditstarrymirrorboost = {}
ccommoditstarrymirrorboost.Data = {
[1] = {id = 1, Sort = 1, Items = 78140, Nums = 1, Stock = 3, MoneyType = 35025, Price = 200, Discount = -1, DiscountPrice = 200, LimitType = 1, OpenTime = "2021-06-24 04:00:00", CloseTime = "2021-08-12 04:00:00"}
, 
[2] = {id = 2, Sort = 2, Items = 30076, Nums = 1, Stock = 3, MoneyType = 35025, Price = 50, Discount = -1, DiscountPrice = 50, LimitType = 1, OpenTime = "2021-06-24 04:00:00", CloseTime = "2021-08-12 04:00:00"}
, 
[3] = {id = 3, Sort = 3, Items = 75005, Nums = 1, Stock = 30, MoneyType = 35025, Price = 10, Discount = -1, DiscountPrice = 10, LimitType = 1, OpenTime = "2021-06-24 04:00:00", CloseTime = "2021-08-12 04:00:00"}
, 
[5] = {id = 5, Sort = 5, Items = 75014, Nums = 1, Stock = 30, MoneyType = 35025, Price = 10, Discount = -1, DiscountPrice = 10, LimitType = 1, OpenTime = "2021-06-24 04:00:00", CloseTime = "2021-08-12 04:00:00"}
, 
[6] = {id = 6, Sort = 6, Items = 75018, Nums = 1, Stock = 20, MoneyType = 35025, Price = 25, Discount = -1, DiscountPrice = 25, LimitType = 1, OpenTime = "2021-06-24 04:00:00", CloseTime = "2021-08-12 04:00:00"}
, 
[7] = {id = 7, Sort = 7, Items = 75019, Nums = 1, Stock = 20, MoneyType = 35025, Price = 25, Discount = -1, DiscountPrice = 25, LimitType = 1, OpenTime = "2021-06-24 04:00:00", CloseTime = "2021-08-12 04:00:00"}
, 
[8] = {id = 8, Sort = 10, Items = 74002, Nums = 1, Stock = 30, MoneyType = 35025, Price = 10, Discount = -1, DiscountPrice = 10, LimitType = 1, OpenTime = "2021-06-24 04:00:00", CloseTime = "2021-08-12 04:00:00"}
, 
[9] = {id = 9, Sort = 11, Items = 70003, Nums = 1, Stock = 10, MoneyType = 35025, Price = 30, Discount = -1, DiscountPrice = 30, LimitType = 1, OpenTime = "2021-06-24 04:00:00", CloseTime = "2021-08-12 04:00:00"}
, 
[10] = {id = 10, Sort = 12, Items = 35021, Nums = 50, Stock = 40, MoneyType = 35025, Price = 10, Discount = -1, DiscountPrice = 10, LimitType = 1, OpenTime = "2021-06-24 04:00:00", CloseTime = "2021-08-12 04:00:00"}
, 
[11] = {id = 11, Sort = 14, Items = 80135, Nums = 1, Stock = 2, MoneyType = 35025, Price = 15, Discount = -1, DiscountPrice = 15, LimitType = 1, OpenTime = "2021-06-24 04:00:00", CloseTime = "2021-08-12 04:00:00"}
, 
[12] = {id = 12, Sort = 15, Items = 80137, Nums = 1, Stock = 1, MoneyType = 35025, Price = 15, Discount = -1, DiscountPrice = 15, LimitType = 1, OpenTime = "2021-06-24 04:00:00", CloseTime = "2021-08-12 04:00:00"}
, 
[13] = {id = 13, Sort = 16, Items = 80139, Nums = 1, Stock = 2, MoneyType = 35025, Price = 10, Discount = -1, DiscountPrice = 10, LimitType = 1, OpenTime = "2021-06-24 04:00:00", CloseTime = "2021-08-12 04:00:00"}
, 
[14] = {id = 14, Sort = 17, Items = 80140, Nums = 1, Stock = 2, MoneyType = 35025, Price = 10, Discount = -1, DiscountPrice = 10, LimitType = 1, OpenTime = "2021-06-24 04:00:00", CloseTime = "2021-08-12 04:00:00"}
, 
[15] = {id = 15, Sort = 18, Items = 80141, Nums = 1, Stock = 2, MoneyType = 35025, Price = 10, Discount = -1, DiscountPrice = 10, LimitType = 1, OpenTime = "2021-06-24 04:00:00", CloseTime = "2021-08-12 04:00:00"}
, 
[16] = {id = 16, Sort = 19, Items = 35002, Nums = 8000, Stock = -1, MoneyType = 35025, Price = 1, Discount = -1, DiscountPrice = 1, LimitType = 1, OpenTime = "2021-06-24 04:00:00", CloseTime = "2021-08-12 04:00:00"}
, 
[17] = {id = 17, Sort = 8, Items = 74004, Nums = 1, Stock = 20, MoneyType = 35025, Price = 25, Discount = -1, DiscountPrice = 25, LimitType = 1, OpenTime = "2021-06-24 04:00:00", CloseTime = "2021-08-12 04:00:00"}
, 
[18] = {id = 18, Sort = 9, Items = 74005, Nums = 1, Stock = 20, MoneyType = 35025, Price = 25, Discount = -1, DiscountPrice = 25, LimitType = 1, OpenTime = "2021-06-24 04:00:00", CloseTime = "2021-08-12 04:00:00"}
, 
[19] = {id = 19, Sort = 13, Items = 35002, Nums = 200000, Stock = 40, MoneyType = 35025, Price = 20, Discount = -1, DiscountPrice = 20, LimitType = 1, OpenTime = "2021-06-24 04:00:00", CloseTime = "2021-08-12 04:00:00"}
}
ccommoditstarrymirrorboost.AllIds = {1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19}
return ccommoditstarrymirrorboost

