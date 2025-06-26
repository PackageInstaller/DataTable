-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/recharge/cchrisdance.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cchrisdance = {}
cchrisdance.Data = {
[1] = {id = 1, Sort = 1, Items = 78166, Nums = 1, Stock = 2, MoneyType = 35039, Price = 200, Discount = -1, DiscountPrice = 200, LimitType = 1, OpenTime = "2021-11-05 04:00:00", CloseTime = "2022-01-13 04:00:00", PointType = 35039, PointNum = 0}
, 
[2] = {id = 2, Sort = 2, Items = 35008, Nums = 200, Stock = 3, MoneyType = 35039, Price = 50, Discount = -1, DiscountPrice = 50, LimitType = 1, OpenTime = "2021-11-05 04:00:00", CloseTime = "2022-01-13 04:00:00", PointType = 35039, PointNum = 0}
, 
[3] = {id = 3, Sort = 3, Items = 75008, Nums = 2, Stock = 15, MoneyType = 35039, Price = 6, Discount = -1, DiscountPrice = 6, LimitType = 1, OpenTime = "2021-11-05 04:00:00", CloseTime = "2022-01-13 04:00:00", PointType = 35039, PointNum = 0}
, 
[4] = {id = 4, Sort = 4, Items = 75014, Nums = 2, Stock = 15, MoneyType = 35039, Price = 6, Discount = -1, DiscountPrice = 6, LimitType = 1, OpenTime = "2021-11-05 04:00:00", CloseTime = "2022-01-13 04:00:00", PointType = 35039, PointNum = 0}
, 
[5] = {id = 5, Sort = 5, Items = 70003, Nums = 1, Stock = 5, MoneyType = 35039, Price = 150, Discount = -1, DiscountPrice = 150, LimitType = 1, OpenTime = "2021-11-05 04:00:00", CloseTime = "2022-01-13 04:00:00", PointType = 35039, PointNum = 0}
, 
[6] = {id = 6, Sort = 6, Items = 49901, Nums = 1, Stock = 3, MoneyType = 35039, Price = 150, Discount = -1, DiscountPrice = 150, LimitType = 1, OpenTime = "2021-11-05 04:00:00", CloseTime = "2022-01-13 04:00:00", PointType = 35039, PointNum = 800}
, 
[7] = {id = 7, Sort = 7, Items = 49902, Nums = 1, Stock = 3, MoneyType = 35039, Price = 50, Discount = -1, DiscountPrice = 50, LimitType = 1, OpenTime = "2021-11-05 04:00:00", CloseTime = "2022-01-13 04:00:00", PointType = 35039, PointNum = 800}
, 
[8] = {id = 8, Sort = 8, Items = 79001, Nums = 20, Stock = 5, MoneyType = 35039, Price = 20, Discount = -1, DiscountPrice = 20, LimitType = 1, OpenTime = "2021-11-05 04:00:00", CloseTime = "2022-01-13 04:00:00", PointType = 35039, PointNum = 800}
, 
[9] = {id = 9, Sort = 9, Items = 79002, Nums = 5, Stock = 5, MoneyType = 35039, Price = 50, Discount = -1, DiscountPrice = 50, LimitType = 1, OpenTime = "2021-11-05 04:00:00", CloseTime = "2022-01-13 04:00:00", PointType = 35039, PointNum = 800}
, 
[10] = {id = 10, Sort = 10, Items = 35002, Nums = 200000, Stock = 30, MoneyType = 35039, Price = 10, Discount = -1, DiscountPrice = 10, LimitType = 1, OpenTime = "2021-11-05 04:00:00", CloseTime = "2023-01-12 04:00:00", PointType = 35039, PointNum = 800}
, 
[11] = {id = 11, Sort = 11, Items = 80199, Nums = 1, Stock = 1, MoneyType = 35039, Price = 15, Discount = -1, DiscountPrice = 15, LimitType = 1, OpenTime = "2021-11-05 04:00:00", CloseTime = "2023-01-12 04:00:00", PointType = 35039, PointNum = 1600}
, 
[12] = {id = 12, Sort = 12, Items = 80195, Nums = 1, Stock = 1, MoneyType = 35039, Price = 15, Discount = -1, DiscountPrice = 15, LimitType = 1, OpenTime = "2021-11-05 04:00:00", CloseTime = "2023-01-12 04:00:00", PointType = 35039, PointNum = 1600}
, 
[13] = {id = 13, Sort = 13, Items = 80201, Nums = 1, Stock = 1, MoneyType = 35039, Price = 20, Discount = -1, DiscountPrice = 20, LimitType = 1, OpenTime = "2021-11-05 04:00:00", CloseTime = "2023-01-12 04:00:00", PointType = 35039, PointNum = 1600}
, 
[14] = {id = 14, Sort = 14, Items = 80202, Nums = 1, Stock = 1, MoneyType = 35039, Price = 20, Discount = -1, DiscountPrice = 20, LimitType = 1, OpenTime = "2021-11-05 04:00:00", CloseTime = "2023-01-12 04:00:00", PointType = 35039, PointNum = 1600}
, 
[15] = {id = 15, Sort = 15, Items = 80197, Nums = 1, Stock = 1, MoneyType = 35039, Price = 20, Discount = -1, DiscountPrice = 20, LimitType = 1, OpenTime = "2021-11-05 04:00:00", CloseTime = "2023-01-12 04:00:00", PointType = 35039, PointNum = 1600}
, 
[16] = {id = 16, Sort = 16, Items = 80198, Nums = 1, Stock = 1, MoneyType = 35039, Price = 20, Discount = -1, DiscountPrice = 20, LimitType = 1, OpenTime = "2021-11-05 04:00:00", CloseTime = "2023-01-12 04:00:00", PointType = 35039, PointNum = 1600}
, 
[17] = {id = 17, Sort = 17, Items = 80191, Nums = 1, Stock = 2, MoneyType = 35039, Price = 15, Discount = -1, DiscountPrice = 15, LimitType = 1, OpenTime = "2021-11-05 04:00:00", CloseTime = "2023-01-12 04:00:00", PointType = 35039, PointNum = 1600}
, 
[18] = {id = 18, Sort = 18, Items = 35002, Nums = 4000, Stock = -1, MoneyType = 35039, Price = 1, Discount = -1, DiscountPrice = 1, LimitType = 1, OpenTime = "2021-11-05 04:00:00", CloseTime = "2023-01-12 04:00:00", PointType = 35039, PointNum = 1600}
}
cchrisdance.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18}
return cchrisdance

