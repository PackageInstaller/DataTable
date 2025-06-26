-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/recharge/cpackage.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cpackage = {}
cpackage.Data = {
[1] = {id = 1, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-05-26 04:00:00", CloseTime = "2022-05-27 03:59:59"}
, 
[2] = {id = 2, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-05-27 04:00:00", CloseTime = "2022-05-28 03:59:59"}
, 
[3] = {id = 3, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-05-28 04:00:00", CloseTime = "2022-05-29 03:59:59"}
, 
[4] = {id = 4, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-05-29 04:00:00", CloseTime = "2022-05-30 03:59:59"}
, 
[5] = {id = 5, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-05-30 04:00:00", CloseTime = "2022-05-31 03:59:59"}
, 
[6] = {id = 6, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-05-31 04:00:00", CloseTime = "2022-06-01 03:59:59"}
, 
[7] = {id = 7, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-01 04:00:00", CloseTime = "2022-06-02 03:59:59"}
, 
[8] = {id = 8, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-05-26 04:00:00", CloseTime = "2022-05-27 03:59:59"}
, 
[9] = {id = 9, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-05-27 04:00:00", CloseTime = "2022-05-28 03:59:59"}
, 
[10] = {id = 10, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-05-28 04:00:00", CloseTime = "2022-05-29 03:59:59"}
, 
[11] = {id = 11, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-05-29 04:00:00", CloseTime = "2022-05-30 03:59:59"}
, 
[12] = {id = 12, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-05-30 04:00:00", CloseTime = "2022-05-31 03:59:59"}
, 
[13] = {id = 13, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-05-31 04:00:00", CloseTime = "2022-06-01 03:59:59"}
, 
[14] = {id = 14, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-01 04:00:00", CloseTime = "2022-06-02 03:59:59"}
, 
[15] = {id = 15, orderID = 3, playTypeID = 1, propertyID = 31365, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-05-26 04:00:00", CloseTime = "2022-06-02 03:59:59"}
, 
[16] = {id = 16, orderID = 4, playTypeID = 1, propertyID = 31366, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-05-26 04:00:00", CloseTime = "2022-06-02 03:59:59"}
, 
[17] = {id = 17, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-02 14:00:00", CloseTime = "2022-06-03 03:59:59"}
, 
[18] = {id = 18, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-03 04:00:00", CloseTime = "2022-06-04 03:59:59"}
, 
[19] = {id = 19, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-04 04:00:00", CloseTime = "2022-06-05 03:59:59"}
, 
[20] = {id = 20, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-05 04:00:00", CloseTime = "2022-06-06 03:59:59"}
, 
[21] = {id = 21, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-06 04:00:00", CloseTime = "2022-06-07 03:59:59"}
, 
[22] = {id = 22, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-07 04:00:00", CloseTime = "2022-06-08 03:59:59"}
, 
[23] = {id = 23, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-08 04:00:00", CloseTime = "2022-06-09 03:59:59"}
, 
[24] = {id = 24, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-02 14:00:00", CloseTime = "2022-06-03 03:59:59"}
, 
[25] = {id = 25, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-03 04:00:00", CloseTime = "2022-06-04 03:59:59"}
, 
[26] = {id = 26, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-04 04:00:00", CloseTime = "2022-06-05 03:59:59"}
, 
[27] = {id = 27, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-05 04:00:00", CloseTime = "2022-06-06 03:59:59"}
, 
[28] = {id = 28, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-06 04:00:00", CloseTime = "2022-06-07 03:59:59"}
, 
[29] = {id = 29, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-07 04:00:00", CloseTime = "2022-06-08 03:59:59"}
, 
[30] = {id = 30, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-08 04:00:00", CloseTime = "2022-06-09 03:59:59"}
, 
[31] = {id = 31, orderID = 3, playTypeID = 2, propertyID = 31397, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-06-02 14:00:00", CloseTime = "2022-06-09 03:59:59"}
, 
[32] = {id = 32, orderID = 4, playTypeID = 2, propertyID = 31398, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-06-02 14:00:00", CloseTime = "2022-06-09 03:59:59"}
, 
[33] = {id = 33, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-09 14:00:00", CloseTime = "2022-06-10 03:59:59"}
, 
[34] = {id = 34, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-10 04:00:00", CloseTime = "2022-06-11 03:59:59"}
, 
[35] = {id = 35, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-11 04:00:00", CloseTime = "2022-06-12 03:59:59"}
, 
[36] = {id = 36, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-12 04:00:00", CloseTime = "2022-06-13 03:59:59"}
, 
[37] = {id = 37, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-13 04:00:00", CloseTime = "2022-06-14 03:59:59"}
, 
[38] = {id = 38, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-14 04:00:00", CloseTime = "2022-06-15 03:59:59"}
, 
[39] = {id = 39, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-15 04:00:00", CloseTime = "2022-06-16 03:59:59"}
, 
[40] = {id = 40, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-09 14:00:00", CloseTime = "2022-06-10 03:59:59"}
, 
[41] = {id = 41, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-10 04:00:00", CloseTime = "2022-06-11 03:59:59"}
, 
[42] = {id = 42, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-11 04:00:00", CloseTime = "2022-06-12 03:59:59"}
, 
[43] = {id = 43, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-12 04:00:00", CloseTime = "2022-06-13 03:59:59"}
, 
[44] = {id = 44, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-13 04:00:00", CloseTime = "2022-06-14 03:59:59"}
, 
[45] = {id = 45, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-14 04:00:00", CloseTime = "2022-06-15 03:59:59"}
, 
[46] = {id = 46, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-15 04:00:00", CloseTime = "2022-06-16 03:59:59"}
, 
[47] = {id = 47, orderID = 3, playTypeID = 3, propertyID = 31408, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-06-09 14:00:00", CloseTime = "2022-06-16 03:59:59"}
, 
[48] = {id = 48, orderID = 4, playTypeID = 3, propertyID = 31409, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-06-09 14:00:00", CloseTime = "2022-06-16 03:59:59"}
, 
[49] = {id = 49, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-16 04:00:00", CloseTime = "2022-06-17 03:59:59"}
, 
[50] = {id = 50, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-17 04:00:00", CloseTime = "2022-06-18 03:59:59"}
, 
[51] = {id = 51, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-18 04:00:00", CloseTime = "2022-06-19 03:59:59"}
, 
[52] = {id = 52, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-19 04:00:00", CloseTime = "2022-06-20 03:59:59"}
, 
[53] = {id = 53, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-20 04:00:00", CloseTime = "2022-06-21 03:59:59"}
, 
[54] = {id = 54, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-21 04:00:00", CloseTime = "2022-06-22 03:59:59"}
, 
[55] = {id = 55, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-22 04:00:00", CloseTime = "2022-06-23 03:59:59"}
, 
[56] = {id = 56, orderID = 2, playTypeID = 1, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-16 04:00:00", CloseTime = "2022-06-17 03:59:59"}
, 
[57] = {id = 57, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-17 04:00:00", CloseTime = "2022-06-18 03:59:59"}
, 
[58] = {id = 58, orderID = 2, playTypeID = 1, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-18 04:00:00", CloseTime = "2022-06-19 03:59:59"}
, 
[59] = {id = 59, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-19 04:00:00", CloseTime = "2022-06-20 03:59:59"}
, 
[60] = {id = 60, orderID = 2, playTypeID = 1, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-20 04:00:00", CloseTime = "2022-06-21 03:59:59"}
, 
[61] = {id = 61, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-21 04:00:00", CloseTime = "2022-06-22 03:59:59"}
, 
[62] = {id = 62, orderID = 2, playTypeID = 1, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-22 04:00:00", CloseTime = "2022-06-23 03:59:59"}
, 
[63] = {id = 63, orderID = 3, playTypeID = 1, propertyID = 31418, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-06-16 04:00:00", CloseTime = "2022-06-23 03:59:59"}
, 
[64] = {id = 64, orderID = 4, playTypeID = 1, propertyID = 31419, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-06-16 04:00:00", CloseTime = "2022-06-23 03:59:59"}
, 
[65] = {id = 65, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-23 04:00:00", CloseTime = "2022-06-24 03:59:59"}
, 
[66] = {id = 66, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-24 04:00:00", CloseTime = "2022-06-25 03:59:59"}
, 
[67] = {id = 67, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-25 04:00:00", CloseTime = "2022-06-26 03:59:59"}
, 
[68] = {id = 68, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-26 04:00:00", CloseTime = "2022-06-27 03:59:59"}
, 
[69] = {id = 69, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-27 04:00:00", CloseTime = "2022-06-28 03:59:59"}
, 
[70] = {id = 70, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-28 04:00:00", CloseTime = "2022-06-29 03:59:59"}
, 
[71] = {id = 71, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-29 04:00:00", CloseTime = "2022-06-30 03:59:59"}
, 
[72] = {id = 72, orderID = 2, playTypeID = 2, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-23 04:00:00", CloseTime = "2022-06-24 03:59:59"}
, 
[73] = {id = 73, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-24 04:00:00", CloseTime = "2022-06-25 03:59:59"}
, 
[74] = {id = 74, orderID = 2, playTypeID = 2, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-25 04:00:00", CloseTime = "2022-06-26 03:59:59"}
, 
[75] = {id = 75, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-26 04:00:00", CloseTime = "2022-06-27 03:59:59"}
, 
[76] = {id = 76, orderID = 2, playTypeID = 2, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-27 04:00:00", CloseTime = "2022-06-28 03:59:59"}
, 
[77] = {id = 77, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-28 04:00:00", CloseTime = "2022-06-29 03:59:59"}
, 
[78] = {id = 78, orderID = 2, playTypeID = 2, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-29 04:00:00", CloseTime = "2022-06-30 03:59:59"}
, 
[79] = {id = 79, orderID = 3, playTypeID = 2, propertyID = 31420, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-06-23 04:00:00", CloseTime = "2022-06-30 03:59:59"}
, 
[80] = {id = 80, orderID = 4, playTypeID = 2, propertyID = 31421, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-06-23 04:00:00", CloseTime = "2022-06-30 03:59:59"}
, 
[81] = {id = 81, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-06-30 04:00:00", CloseTime = "2022-07-01 03:59:59"}
, 
[82] = {id = 82, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-01 04:00:00", CloseTime = "2022-07-02 03:59:59"}
, 
[83] = {id = 83, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-02 04:00:00", CloseTime = "2022-07-03 03:59:59"}
, 
[84] = {id = 84, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-03 04:00:00", CloseTime = "2022-07-04 03:59:59"}
, 
[85] = {id = 85, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-04 04:00:00", CloseTime = "2022-07-05 03:59:59"}
, 
[86] = {id = 86, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-05 04:00:00", CloseTime = "2022-07-06 03:59:59"}
, 
[87] = {id = 87, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-06 04:00:00", CloseTime = "2022-07-07 03:59:59"}
, 
[88] = {id = 88, orderID = 2, playTypeID = 3, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-06-30 04:00:00", CloseTime = "2022-07-01 03:59:59"}
, 
[89] = {id = 89, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-01 04:00:00", CloseTime = "2022-07-02 03:59:59"}
, 
[90] = {id = 90, orderID = 2, playTypeID = 3, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-02 04:00:00", CloseTime = "2022-07-03 03:59:59"}
, 
[91] = {id = 91, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-03 04:00:00", CloseTime = "2022-07-04 03:59:59"}
, 
[92] = {id = 92, orderID = 2, playTypeID = 3, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-04 04:00:00", CloseTime = "2022-07-05 03:59:59"}
, 
[93] = {id = 93, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-05 04:00:00", CloseTime = "2022-07-06 03:59:59"}
, 
[94] = {id = 94, orderID = 2, playTypeID = 3, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-06 04:00:00", CloseTime = "2022-07-07 03:59:59"}
, 
[95] = {id = 95, orderID = 3, playTypeID = 3, propertyID = 31422, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-06-30 04:00:00", CloseTime = "2022-07-07 03:59:59"}
, 
[96] = {id = 96, orderID = 4, playTypeID = 3, propertyID = 31423, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-06-30 04:00:00", CloseTime = "2022-07-07 03:59:59"}
, 
[97] = {id = 97, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-08 04:00:00", CloseTime = "2022-07-09 03:59:59"}
, 
[98] = {id = 98, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-09 04:00:00", CloseTime = "2022-07-10 03:59:59"}
, 
[99] = {id = 99, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-10 04:00:00", CloseTime = "2022-07-11 03:59:59"}
, 
[100] = {id = 100, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-11 04:00:00", CloseTime = "2022-07-12 03:59:59"}
, 
[101] = {id = 101, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-12 04:00:00", CloseTime = "2022-07-13 03:59:59"}
, 
[102] = {id = 102, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-13 04:00:00", CloseTime = "2022-07-14 03:59:59"}
, 
[103] = {id = 103, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-14 04:00:00", CloseTime = "2022-07-15 03:59:59"}
, 
[104] = {id = 104, orderID = 2, playTypeID = 1, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-08 04:00:00", CloseTime = "2022-07-09 03:59:59"}
, 
[105] = {id = 105, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-09 04:00:00", CloseTime = "2022-07-10 03:59:59"}
, 
[106] = {id = 106, orderID = 2, playTypeID = 1, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-10 04:00:00", CloseTime = "2022-07-11 03:59:59"}
, 
[107] = {id = 107, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-11 04:00:00", CloseTime = "2022-07-12 03:59:59"}
, 
[108] = {id = 108, orderID = 2, playTypeID = 1, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-12 04:00:00", CloseTime = "2022-07-13 03:59:59"}
, 
[109] = {id = 109, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-13 04:00:00", CloseTime = "2022-07-14 03:59:59"}
, 
[110] = {id = 110, orderID = 2, playTypeID = 1, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-14 04:00:00", CloseTime = "2022-07-15 14:59:59"}
, 
[111] = {id = 111, orderID = 3, playTypeID = 1, propertyID = 31418, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-07-08 04:00:00", CloseTime = "2022-07-15 14:59:59"}
, 
[112] = {id = 112, orderID = 4, playTypeID = 1, propertyID = 31419, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-07-08 04:00:00", CloseTime = "2022-07-15 14:59:59"}
, 
[113] = {id = 113, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-15 15:00:00", CloseTime = "2022-07-16 03:59:59"}
, 
[114] = {id = 114, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-16 04:00:00", CloseTime = "2022-07-17 03:59:59"}
, 
[115] = {id = 115, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-17 04:00:00", CloseTime = "2022-07-18 03:59:59"}
, 
[116] = {id = 116, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-18 04:00:00", CloseTime = "2022-07-19 03:59:59"}
, 
[117] = {id = 117, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-19 04:00:00", CloseTime = "2022-07-20 03:59:59"}
, 
[118] = {id = 118, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-20 04:00:00", CloseTime = "2022-07-21 03:59:59"}
, 
[119] = {id = 119, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-21 04:00:00", CloseTime = "2022-07-22 03:59:59"}
, 
[120] = {id = 120, orderID = 2, playTypeID = 2, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-15 15:00:00", CloseTime = "2022-07-16 03:59:59"}
, 
[121] = {id = 121, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-16 04:00:00", CloseTime = "2022-07-17 03:59:59"}
, 
[122] = {id = 122, orderID = 2, playTypeID = 2, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-17 04:00:00", CloseTime = "2022-07-18 03:59:59"}
, 
[123] = {id = 123, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-18 04:00:00", CloseTime = "2022-07-19 03:59:59"}
, 
[124] = {id = 124, orderID = 2, playTypeID = 2, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-19 04:00:00", CloseTime = "2022-07-20 03:59:59"}
, 
[125] = {id = 125, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-20 04:00:00", CloseTime = "2022-07-21 03:59:59"}
, 
[126] = {id = 126, orderID = 2, playTypeID = 2, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-21 04:00:00", CloseTime = "2022-07-22 14:59:59"}
, 
[127] = {id = 127, orderID = 3, playTypeID = 2, propertyID = 31420, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-07-15 15:00:00", CloseTime = "2022-07-22 14:59:59"}
, 
[128] = {id = 128, orderID = 4, playTypeID = 2, propertyID = 31421, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-07-15 15:00:00", CloseTime = "2022-07-22 14:59:59"}
, 
[129] = {id = 129, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-22 15:00:00", CloseTime = "2022-07-23 03:59:59"}
, 
[130] = {id = 130, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-23 04:00:00", CloseTime = "2022-07-24 03:59:59"}
, 
[131] = {id = 131, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-24 04:00:00", CloseTime = "2022-07-25 03:59:59"}
, 
[132] = {id = 132, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-25 04:00:00", CloseTime = "2022-07-26 03:59:59"}
, 
[133] = {id = 133, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-26 04:00:00", CloseTime = "2022-07-27 03:59:59"}
, 
[134] = {id = 134, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-27 04:00:00", CloseTime = "2022-07-28 03:59:59"}
, 
[135] = {id = 135, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-28 04:00:00", CloseTime = "2022-07-29 03:59:59"}
, 
[136] = {id = 136, orderID = 2, playTypeID = 3, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-22 15:00:00", CloseTime = "2022-07-23 03:59:59"}
, 
[137] = {id = 137, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-23 04:00:00", CloseTime = "2022-07-24 03:59:59"}
, 
[138] = {id = 138, orderID = 2, playTypeID = 3, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-24 04:00:00", CloseTime = "2022-07-25 03:59:59"}
, 
[139] = {id = 139, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-25 04:00:00", CloseTime = "2022-07-26 03:59:59"}
, 
[140] = {id = 140, orderID = 2, playTypeID = 3, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-26 04:00:00", CloseTime = "2022-07-27 03:59:59"}
, 
[141] = {id = 141, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-27 04:00:00", CloseTime = "2022-07-28 03:59:59"}
, 
[142] = {id = 142, orderID = 2, playTypeID = 3, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-28 04:00:00", CloseTime = "2022-07-29 03:59:59"}
, 
[143] = {id = 143, orderID = 3, playTypeID = 3, propertyID = 31422, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-07-22 15:00:00", CloseTime = "2022-07-29 03:59:59"}
, 
[144] = {id = 144, orderID = 4, playTypeID = 3, propertyID = 31423, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-07-22 15:00:00", CloseTime = "2022-07-29 03:59:59"}
, 
[145] = {id = 145, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-29 04:00:00", CloseTime = "2022-07-30 03:59:59"}
, 
[146] = {id = 146, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-30 04:00:00", CloseTime = "2022-07-31 03:59:59"}
, 
[147] = {id = 147, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-07-31 04:00:00", CloseTime = "2022-08-01 03:59:59"}
, 
[148] = {id = 148, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-01 04:00:00", CloseTime = "2022-08-02 03:59:59"}
, 
[149] = {id = 149, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-02 04:00:00", CloseTime = "2022-08-03 03:59:59"}
, 
[150] = {id = 150, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-03 04:00:00", CloseTime = "2022-08-04 03:59:59"}
, 
[151] = {id = 151, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-04 04:00:00", CloseTime = "2022-08-05 03:59:59"}
, 
[152] = {id = 152, orderID = 2, playTypeID = 1, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-29 04:00:00", CloseTime = "2022-07-30 03:59:59"}
, 
[153] = {id = 153, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-30 04:00:00", CloseTime = "2022-07-31 03:59:59"}
, 
[154] = {id = 154, orderID = 2, playTypeID = 1, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-07-31 04:00:00", CloseTime = "2022-08-01 03:59:59"}
, 
[155] = {id = 155, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-01 04:00:00", CloseTime = "2022-08-02 03:59:59"}
, 
[156] = {id = 156, orderID = 2, playTypeID = 1, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-02 04:00:00", CloseTime = "2022-08-03 03:59:59"}
, 
[157] = {id = 157, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-03 04:00:00", CloseTime = "2022-08-04 03:59:59"}
, 
[158] = {id = 158, orderID = 2, playTypeID = 1, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-04 04:00:00", CloseTime = "2022-08-05 03:59:59"}
, 
[159] = {id = 159, orderID = 3, playTypeID = 1, propertyID = 31418, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-07-29 04:00:00", CloseTime = "2022-08-05 03:59:59"}
, 
[160] = {id = 160, orderID = 4, playTypeID = 1, propertyID = 31419, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-07-29 04:00:00", CloseTime = "2022-08-05 03:59:59"}
, 
[161] = {id = 161, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-05 04:00:00", CloseTime = "2022-08-06 03:59:59"}
, 
[162] = {id = 162, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-06 04:00:00", CloseTime = "2022-08-07 03:59:59"}
, 
[163] = {id = 163, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-07 04:00:00", CloseTime = "2022-08-08 03:59:59"}
, 
[164] = {id = 164, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-08 04:00:00", CloseTime = "2022-08-09 03:59:59"}
, 
[165] = {id = 165, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-09 04:00:00", CloseTime = "2022-08-10 03:59:59"}
, 
[166] = {id = 166, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-10 04:00:00", CloseTime = "2022-08-11 03:59:59"}
, 
[167] = {id = 167, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-11 04:00:00", CloseTime = "2022-08-12 03:59:59"}
, 
[168] = {id = 168, orderID = 2, playTypeID = 2, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-05 04:00:00", CloseTime = "2022-08-06 03:59:59"}
, 
[169] = {id = 169, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-06 04:00:00", CloseTime = "2022-08-07 03:59:59"}
, 
[170] = {id = 170, orderID = 2, playTypeID = 2, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-07 04:00:00", CloseTime = "2022-08-08 03:59:59"}
, 
[171] = {id = 171, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-08 04:00:00", CloseTime = "2022-08-09 03:59:59"}
, 
[172] = {id = 172, orderID = 2, playTypeID = 2, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-09 04:00:00", CloseTime = "2022-08-10 03:59:59"}
, 
[173] = {id = 173, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-10 04:00:00", CloseTime = "2022-08-11 03:59:59"}
, 
[174] = {id = 174, orderID = 2, playTypeID = 2, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-11 04:00:00", CloseTime = "2022-08-12 03:59:59"}
, 
[175] = {id = 175, orderID = 3, playTypeID = 2, propertyID = 31420, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-08-05 04:00:00", CloseTime = "2022-08-12 03:59:59"}
, 
[176] = {id = 176, orderID = 4, playTypeID = 2, propertyID = 31421, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-08-05 04:00:00", CloseTime = "2022-08-12 03:59:59"}
, 
[177] = {id = 177, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-12 04:00:00", CloseTime = "2022-08-13 03:59:59"}
, 
[178] = {id = 178, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-13 04:00:00", CloseTime = "2022-08-14 03:59:59"}
, 
[179] = {id = 179, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-14 04:00:00", CloseTime = "2022-08-15 03:59:59"}
, 
[180] = {id = 180, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-15 04:00:00", CloseTime = "2022-08-16 03:59:59"}
, 
[181] = {id = 181, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-16 04:00:00", CloseTime = "2022-08-17 03:59:59"}
, 
[182] = {id = 182, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-17 04:00:00", CloseTime = "2022-08-18 03:59:59"}
, 
[183] = {id = 183, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-18 04:00:00", CloseTime = "2022-08-19 03:59:59"}
, 
[184] = {id = 184, orderID = 2, playTypeID = 3, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-12 04:00:00", CloseTime = "2022-08-13 03:59:59"}
, 
[185] = {id = 185, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-13 04:00:00", CloseTime = "2022-08-14 03:59:59"}
, 
[186] = {id = 186, orderID = 2, playTypeID = 3, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-14 04:00:00", CloseTime = "2022-08-15 03:59:59"}
, 
[187] = {id = 187, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-15 04:00:00", CloseTime = "2022-08-16 03:59:59"}
, 
[188] = {id = 188, orderID = 2, playTypeID = 3, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-16 04:00:00", CloseTime = "2022-08-17 03:59:59"}
, 
[189] = {id = 189, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-17 04:00:00", CloseTime = "2022-08-18 03:59:59"}
, 
[190] = {id = 190, orderID = 2, playTypeID = 3, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-18 04:00:00", CloseTime = "2022-08-19 03:59:59"}
, 
[191] = {id = 191, orderID = 3, playTypeID = 3, propertyID = 31422, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-08-12 04:00:00", CloseTime = "2022-08-19 03:59:59"}
, 
[192] = {id = 192, orderID = 4, playTypeID = 3, propertyID = 31423, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-08-12 04:00:00", CloseTime = "2022-08-19 03:59:59"}
, 
[193] = {id = 193, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-19 04:00:00", CloseTime = "2022-08-20 03:59:59"}
, 
[194] = {id = 194, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-20 04:00:00", CloseTime = "2022-08-21 03:59:59"}
, 
[195] = {id = 195, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-21 04:00:00", CloseTime = "2022-08-22 03:59:59"}
, 
[196] = {id = 196, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-22 04:00:00", CloseTime = "2022-08-23 03:59:59"}
, 
[197] = {id = 197, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-23 04:00:00", CloseTime = "2022-08-24 03:59:59"}
, 
[198] = {id = 198, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-24 04:00:00", CloseTime = "2022-08-25 03:59:59"}
, 
[199] = {id = 199, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-25 04:00:00", CloseTime = "2022-08-26 03:59:59"}
, 
[200] = {id = 200, orderID = 2, playTypeID = 1, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-19 04:00:00", CloseTime = "2022-08-20 03:59:59"}
, 
[201] = {id = 201, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-20 04:00:00", CloseTime = "2022-08-21 03:59:59"}
, 
[202] = {id = 202, orderID = 2, playTypeID = 1, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-21 04:00:00", CloseTime = "2022-08-22 03:59:59"}
, 
[203] = {id = 203, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-22 04:00:00", CloseTime = "2022-08-23 03:59:59"}
, 
[204] = {id = 204, orderID = 2, playTypeID = 1, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-23 04:00:00", CloseTime = "2022-08-24 03:59:59"}
, 
[205] = {id = 205, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-24 04:00:00", CloseTime = "2022-08-25 03:59:59"}
, 
[206] = {id = 206, orderID = 2, playTypeID = 1, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-25 04:00:00", CloseTime = "2022-08-26 03:59:59"}
, 
[207] = {id = 207, orderID = 3, playTypeID = 1, propertyID = 31418, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-08-19 04:00:00", CloseTime = "2022-08-26 03:59:59"}
, 
[208] = {id = 208, orderID = 4, playTypeID = 1, propertyID = 31419, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-08-19 04:00:00", CloseTime = "2022-08-26 03:59:59"}
, 
[209] = {id = 209, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-26 04:00:00", CloseTime = "2022-08-27 03:59:59"}
, 
[210] = {id = 210, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-27 04:00:00", CloseTime = "2022-08-28 03:59:59"}
, 
[211] = {id = 211, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-28 04:00:00", CloseTime = "2022-08-29 03:59:59"}
, 
[212] = {id = 212, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-29 04:00:00", CloseTime = "2022-08-30 03:59:59"}
, 
[213] = {id = 213, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-30 04:00:00", CloseTime = "2022-08-31 03:59:59"}
, 
[214] = {id = 214, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-08-31 04:00:00", CloseTime = "2022-09-01 03:59:59"}
, 
[215] = {id = 215, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-01 04:00:00", CloseTime = "2022-09-02 03:59:59"}
, 
[216] = {id = 216, orderID = 2, playTypeID = 2, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-26 04:00:00", CloseTime = "2022-08-27 03:59:59"}
, 
[217] = {id = 217, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-27 04:00:00", CloseTime = "2022-08-28 03:59:59"}
, 
[218] = {id = 218, orderID = 2, playTypeID = 2, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-28 04:00:00", CloseTime = "2022-08-29 03:59:59"}
, 
[219] = {id = 219, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-29 04:00:00", CloseTime = "2022-08-30 03:59:59"}
, 
[220] = {id = 220, orderID = 2, playTypeID = 2, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-30 04:00:00", CloseTime = "2022-08-31 03:59:59"}
, 
[221] = {id = 221, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-08-31 04:00:00", CloseTime = "2022-09-01 03:59:59"}
, 
[222] = {id = 222, orderID = 2, playTypeID = 2, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-01 04:00:00", CloseTime = "2022-09-02 03:59:59"}
, 
[223] = {id = 223, orderID = 3, playTypeID = 2, propertyID = 31420, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-08-26 04:00:00", CloseTime = "2022-09-02 03:59:59"}
, 
[224] = {id = 224, orderID = 4, playTypeID = 2, propertyID = 31421, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-08-26 04:00:00", CloseTime = "2022-09-02 03:59:59"}
, 
[225] = {id = 225, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-02 04:00:00", CloseTime = "2022-09-03 03:59:59"}
, 
[226] = {id = 226, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-03 04:00:00", CloseTime = "2022-09-04 03:59:59"}
, 
[227] = {id = 227, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-04 04:00:00", CloseTime = "2022-09-05 03:59:59"}
, 
[228] = {id = 228, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-05 04:00:00", CloseTime = "2022-09-06 03:59:59"}
, 
[229] = {id = 229, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-06 04:00:00", CloseTime = "2022-09-07 03:59:59"}
, 
[230] = {id = 230, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-07 04:00:00", CloseTime = "2022-09-08 03:59:59"}
, 
[231] = {id = 231, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-08 04:00:00", CloseTime = "2022-09-09 03:59:59"}
, 
[232] = {id = 232, orderID = 2, playTypeID = 3, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-02 04:00:00", CloseTime = "2022-09-03 03:59:59"}
, 
[233] = {id = 233, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-03 04:00:00", CloseTime = "2022-09-04 03:59:59"}
, 
[234] = {id = 234, orderID = 2, playTypeID = 3, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-04 04:00:00", CloseTime = "2022-09-05 03:59:59"}
, 
[235] = {id = 235, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-05 04:00:00", CloseTime = "2022-09-06 03:59:59"}
, 
[236] = {id = 236, orderID = 2, playTypeID = 3, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-06 04:00:00", CloseTime = "2022-09-07 03:59:59"}
, 
[237] = {id = 237, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-07 04:00:00", CloseTime = "2022-09-08 03:59:59"}
, 
[238] = {id = 238, orderID = 2, playTypeID = 3, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-08 04:00:00", CloseTime = "2022-09-09 03:59:59"}
, 
[239] = {id = 239, orderID = 3, playTypeID = 3, propertyID = 31422, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-09-02 04:00:00", CloseTime = "2022-09-09 03:59:59"}
, 
[240] = {id = 240, orderID = 4, playTypeID = 3, propertyID = 31423, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-09-02 04:00:00", CloseTime = "2022-09-09 03:59:59"}
, 
[241] = {id = 241, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-09 04:00:00", CloseTime = "2022-09-10 03:59:59"}
, 
[242] = {id = 242, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-10 04:00:00", CloseTime = "2022-09-11 03:59:59"}
, 
[243] = {id = 243, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-11 04:00:00", CloseTime = "2022-09-12 03:59:59"}
, 
[244] = {id = 244, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-12 04:00:00", CloseTime = "2022-09-13 03:59:59"}
, 
[245] = {id = 245, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-13 04:00:00", CloseTime = "2022-09-14 03:59:59"}
, 
[246] = {id = 246, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-14 04:00:00", CloseTime = "2022-09-15 03:59:59"}
, 
[247] = {id = 247, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-15 04:00:00", CloseTime = "2022-09-16 03:59:59"}
, 
[248] = {id = 248, orderID = 2, playTypeID = 1, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-09 04:00:00", CloseTime = "2022-09-10 03:59:59"}
, 
[249] = {id = 249, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-10 04:00:00", CloseTime = "2022-09-11 03:59:59"}
, 
[250] = {id = 250, orderID = 2, playTypeID = 1, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-11 04:00:00", CloseTime = "2022-09-12 03:59:59"}
, 
[251] = {id = 251, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-12 04:00:00", CloseTime = "2022-09-13 03:59:59"}
, 
[252] = {id = 252, orderID = 2, playTypeID = 1, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-13 04:00:00", CloseTime = "2022-09-14 03:59:59"}
, 
[253] = {id = 253, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-14 04:00:00", CloseTime = "2022-09-15 03:59:59"}
, 
[254] = {id = 254, orderID = 2, playTypeID = 1, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-15 04:00:00", CloseTime = "2022-09-16 03:59:59"}
, 
[255] = {id = 255, orderID = 3, playTypeID = 1, propertyID = 31418, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-09-09 04:00:00", CloseTime = "2022-09-16 03:59:59"}
, 
[256] = {id = 256, orderID = 4, playTypeID = 1, propertyID = 31419, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-09-09 04:00:00", CloseTime = "2022-09-16 03:59:59"}
, 
[257] = {id = 257, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-16 04:00:00", CloseTime = "2022-09-17 03:59:59"}
, 
[258] = {id = 258, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-17 04:00:00", CloseTime = "2022-09-18 03:59:59"}
, 
[259] = {id = 259, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-18 04:00:00", CloseTime = "2022-09-19 03:59:59"}
, 
[260] = {id = 260, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-19 04:00:00", CloseTime = "2022-09-20 03:59:59"}
, 
[261] = {id = 261, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-20 04:00:00", CloseTime = "2022-09-21 03:59:59"}
, 
[262] = {id = 262, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-21 04:00:00", CloseTime = "2022-09-22 03:59:59"}
, 
[263] = {id = 263, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-22 04:00:00", CloseTime = "2022-09-23 03:59:59"}
, 
[264] = {id = 264, orderID = 2, playTypeID = 2, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-16 04:00:00", CloseTime = "2022-09-17 03:59:59"}
, 
[265] = {id = 265, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-17 04:00:00", CloseTime = "2022-09-18 03:59:59"}
, 
[266] = {id = 266, orderID = 2, playTypeID = 2, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-18 04:00:00", CloseTime = "2022-09-19 03:59:59"}
, 
[267] = {id = 267, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-19 04:00:00", CloseTime = "2022-09-20 03:59:59"}
, 
[268] = {id = 268, orderID = 2, playTypeID = 2, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-20 04:00:00", CloseTime = "2022-09-21 03:59:59"}
, 
[269] = {id = 269, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-21 04:00:00", CloseTime = "2022-09-22 03:59:59"}
, 
[270] = {id = 270, orderID = 2, playTypeID = 2, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-22 04:00:00", CloseTime = "2022-09-23 03:59:59"}
, 
[271] = {id = 271, orderID = 3, playTypeID = 2, propertyID = 31420, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-09-16 04:00:00", CloseTime = "2022-09-23 03:59:59"}
, 
[272] = {id = 272, orderID = 4, playTypeID = 2, propertyID = 31421, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-09-16 04:00:00", CloseTime = "2022-09-23 03:59:59"}
, 
[273] = {id = 273, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-23 04:00:00", CloseTime = "2022-09-24 03:59:59"}
, 
[274] = {id = 274, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-24 04:00:00", CloseTime = "2022-09-25 03:59:59"}
, 
[275] = {id = 275, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-25 04:00:00", CloseTime = "2022-09-26 03:59:59"}
, 
[276] = {id = 276, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-26 04:00:00", CloseTime = "2022-09-27 03:59:59"}
, 
[277] = {id = 277, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-27 04:00:00", CloseTime = "2022-09-28 03:59:59"}
, 
[278] = {id = 278, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-28 04:00:00", CloseTime = "2022-09-29 03:59:59"}
, 
[279] = {id = 279, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-29 04:00:00", CloseTime = "2022-09-30 03:59:59"}
, 
[280] = {id = 280, orderID = 2, playTypeID = 3, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-23 04:00:00", CloseTime = "2022-09-24 03:59:59"}
, 
[281] = {id = 281, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-24 04:00:00", CloseTime = "2022-09-25 03:59:59"}
, 
[282] = {id = 282, orderID = 2, playTypeID = 3, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-25 04:00:00", CloseTime = "2022-09-26 03:59:59"}
, 
[283] = {id = 283, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-26 04:00:00", CloseTime = "2022-09-27 03:59:59"}
, 
[284] = {id = 284, orderID = 2, playTypeID = 3, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-27 04:00:00", CloseTime = "2022-09-28 03:59:59"}
, 
[285] = {id = 285, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-28 04:00:00", CloseTime = "2022-09-29 03:59:59"}
, 
[286] = {id = 286, orderID = 2, playTypeID = 3, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-29 04:00:00", CloseTime = "2022-09-30 03:59:59"}
, 
[287] = {id = 287, orderID = 3, playTypeID = 3, propertyID = 31422, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-09-23 04:00:00", CloseTime = "2022-09-30 03:59:59"}
, 
[288] = {id = 288, orderID = 4, playTypeID = 3, propertyID = 31423, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-09-23 04:00:00", CloseTime = "2022-09-30 03:59:59"}
, 
[289] = {id = 289, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-09-30 04:00:00", CloseTime = "2022-10-01 03:59:59"}
, 
[290] = {id = 290, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-01 04:00:00", CloseTime = "2022-10-02 03:59:59"}
, 
[291] = {id = 291, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-02 04:00:00", CloseTime = "2022-10-03 03:59:59"}
, 
[292] = {id = 292, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-03 04:00:00", CloseTime = "2022-10-04 03:59:59"}
, 
[293] = {id = 293, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-04 04:00:00", CloseTime = "2022-10-05 03:59:59"}
, 
[294] = {id = 294, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-05 04:00:00", CloseTime = "2022-10-06 03:59:59"}
, 
[295] = {id = 295, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-06 04:00:00", CloseTime = "2022-10-07 03:59:59"}
, 
[296] = {id = 296, orderID = 2, playTypeID = 1, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-09-30 04:00:00", CloseTime = "2022-10-01 03:59:59"}
, 
[297] = {id = 297, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-01 04:00:00", CloseTime = "2022-10-02 03:59:59"}
, 
[298] = {id = 298, orderID = 2, playTypeID = 1, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-02 04:00:00", CloseTime = "2022-10-03 03:59:59"}
, 
[299] = {id = 299, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-03 04:00:00", CloseTime = "2022-10-04 03:59:59"}
, 
[300] = {id = 300, orderID = 2, playTypeID = 1, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-04 04:00:00", CloseTime = "2022-10-05 03:59:59"}
, 
[301] = {id = 301, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-05 04:00:00", CloseTime = "2022-10-06 03:59:59"}
, 
[302] = {id = 302, orderID = 2, playTypeID = 1, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-06 04:00:00", CloseTime = "2022-10-07 03:59:59"}
, 
[303] = {id = 303, orderID = 3, playTypeID = 1, propertyID = 31418, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-09-30 04:00:00", CloseTime = "2022-10-07 03:59:59"}
, 
[304] = {id = 304, orderID = 4, playTypeID = 1, propertyID = 31419, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-09-30 04:00:00", CloseTime = "2022-10-07 03:59:59"}
, 
[305] = {id = 305, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-07 04:00:00", CloseTime = "2022-10-08 03:59:59"}
, 
[306] = {id = 306, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-08 04:00:00", CloseTime = "2022-10-09 03:59:59"}
, 
[307] = {id = 307, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-09 04:00:00", CloseTime = "2022-10-10 03:59:59"}
, 
[308] = {id = 308, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-10 04:00:00", CloseTime = "2022-10-11 03:59:59"}
, 
[309] = {id = 309, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-11 04:00:00", CloseTime = "2022-10-12 03:59:59"}
, 
[310] = {id = 310, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-12 04:00:00", CloseTime = "2022-10-13 03:59:59"}
, 
[311] = {id = 311, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-13 04:00:00", CloseTime = "2022-10-14 03:59:59"}
, 
[312] = {id = 312, orderID = 2, playTypeID = 2, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-07 04:00:00", CloseTime = "2022-10-08 03:59:59"}
, 
[313] = {id = 313, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-08 04:00:00", CloseTime = "2022-10-09 03:59:59"}
, 
[314] = {id = 314, orderID = 2, playTypeID = 2, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-09 04:00:00", CloseTime = "2022-10-10 03:59:59"}
, 
[315] = {id = 315, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-10 04:00:00", CloseTime = "2022-10-11 03:59:59"}
, 
[316] = {id = 316, orderID = 2, playTypeID = 2, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-11 04:00:00", CloseTime = "2022-10-12 03:59:59"}
, 
[317] = {id = 317, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-12 04:00:00", CloseTime = "2022-10-13 03:59:59"}
, 
[318] = {id = 318, orderID = 2, playTypeID = 2, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-13 04:00:00", CloseTime = "2022-10-14 03:59:59"}
, 
[319] = {id = 319, orderID = 3, playTypeID = 2, propertyID = 31420, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-10-07 04:00:00", CloseTime = "2022-10-14 03:59:59"}
, 
[320] = {id = 320, orderID = 4, playTypeID = 2, propertyID = 31421, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-10-07 04:00:00", CloseTime = "2022-10-14 03:59:59"}
, 
[321] = {id = 321, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-14 04:00:00", CloseTime = "2022-10-15 03:59:59"}
, 
[322] = {id = 322, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-15 04:00:00", CloseTime = "2022-10-16 03:59:59"}
, 
[323] = {id = 323, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-16 04:00:00", CloseTime = "2022-10-17 03:59:59"}
, 
[324] = {id = 324, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-17 04:00:00", CloseTime = "2022-10-18 03:59:59"}
, 
[325] = {id = 325, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-18 04:00:00", CloseTime = "2022-10-19 03:59:59"}
, 
[326] = {id = 326, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-19 04:00:00", CloseTime = "2022-10-20 03:59:59"}
, 
[327] = {id = 327, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-20 04:00:00", CloseTime = "2022-10-21 03:59:59"}
, 
[328] = {id = 328, orderID = 2, playTypeID = 3, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-14 04:00:00", CloseTime = "2022-10-15 03:59:59"}
, 
[329] = {id = 329, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-15 04:00:00", CloseTime = "2022-10-16 03:59:59"}
, 
[330] = {id = 330, orderID = 2, playTypeID = 3, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-16 04:00:00", CloseTime = "2022-10-17 03:59:59"}
, 
[331] = {id = 331, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-17 04:00:00", CloseTime = "2022-10-18 03:59:59"}
, 
[332] = {id = 332, orderID = 2, playTypeID = 3, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-18 04:00:00", CloseTime = "2022-10-19 03:59:59"}
, 
[333] = {id = 333, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-19 04:00:00", CloseTime = "2022-10-20 03:59:59"}
, 
[334] = {id = 334, orderID = 2, playTypeID = 3, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-20 04:00:00", CloseTime = "2022-10-21 03:59:59"}
, 
[335] = {id = 335, orderID = 3, playTypeID = 3, propertyID = 31422, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-10-14 04:00:00", CloseTime = "2022-10-21 03:59:59"}
, 
[336] = {id = 336, orderID = 4, playTypeID = 3, propertyID = 31423, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-10-14 04:00:00", CloseTime = "2022-10-21 03:59:59"}
, 
[337] = {id = 337, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-21 04:00:00", CloseTime = "2022-10-22 03:59:59"}
, 
[338] = {id = 338, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-22 04:00:00", CloseTime = "2022-10-23 03:59:59"}
, 
[339] = {id = 339, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-23 04:00:00", CloseTime = "2022-10-24 03:59:59"}
, 
[340] = {id = 340, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-24 04:00:00", CloseTime = "2022-10-25 03:59:59"}
, 
[341] = {id = 341, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-25 04:00:00", CloseTime = "2022-10-26 03:59:59"}
, 
[342] = {id = 342, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-26 04:00:00", CloseTime = "2022-10-27 03:59:59"}
, 
[343] = {id = 343, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-27 04:00:00", CloseTime = "2022-10-28 03:59:59"}
, 
[344] = {id = 344, orderID = 2, playTypeID = 1, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-21 04:00:00", CloseTime = "2022-10-22 03:59:59"}
, 
[345] = {id = 345, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-22 04:00:00", CloseTime = "2022-10-23 03:59:59"}
, 
[346] = {id = 346, orderID = 2, playTypeID = 1, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-23 04:00:00", CloseTime = "2022-10-24 03:59:59"}
, 
[347] = {id = 347, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-24 04:00:00", CloseTime = "2022-10-25 03:59:59"}
, 
[348] = {id = 348, orderID = 2, playTypeID = 1, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-25 04:00:00", CloseTime = "2022-10-26 03:59:59"}
, 
[349] = {id = 349, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-26 04:00:00", CloseTime = "2022-10-27 03:59:59"}
, 
[350] = {id = 350, orderID = 2, playTypeID = 1, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-27 04:00:00", CloseTime = "2022-10-28 03:59:59"}
, 
[351] = {id = 351, orderID = 3, playTypeID = 1, propertyID = 31418, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-10-21 04:00:00", CloseTime = "2022-10-28 03:59:59"}
, 
[352] = {id = 352, orderID = 4, playTypeID = 1, propertyID = 31419, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-10-21 04:00:00", CloseTime = "2022-10-28 03:59:59"}
, 
[353] = {id = 353, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-28 04:00:00", CloseTime = "2022-10-29 03:59:59"}
, 
[354] = {id = 354, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-29 04:00:00", CloseTime = "2022-10-30 03:59:59"}
, 
[355] = {id = 355, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-30 04:00:00", CloseTime = "2022-10-31 03:59:59"}
, 
[356] = {id = 356, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-10-31 04:00:00", CloseTime = "2022-11-01 03:59:59"}
, 
[357] = {id = 357, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-01 04:00:00", CloseTime = "2022-11-02 03:59:59"}
, 
[358] = {id = 358, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-02 04:00:00", CloseTime = "2022-11-03 03:59:59"}
, 
[359] = {id = 359, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-03 04:00:00", CloseTime = "2022-11-04 03:59:59"}
, 
[360] = {id = 360, orderID = 2, playTypeID = 2, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-28 04:00:00", CloseTime = "2022-10-29 03:59:59"}
, 
[361] = {id = 361, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-29 04:00:00", CloseTime = "2022-10-30 03:59:59"}
, 
[362] = {id = 362, orderID = 2, playTypeID = 2, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-30 04:00:00", CloseTime = "2022-10-31 03:59:59"}
, 
[363] = {id = 363, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-10-31 04:00:00", CloseTime = "2022-11-01 03:59:59"}
, 
[364] = {id = 364, orderID = 2, playTypeID = 2, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-01 04:00:00", CloseTime = "2022-11-02 03:59:59"}
, 
[365] = {id = 365, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-02 04:00:00", CloseTime = "2022-11-03 03:59:59"}
, 
[366] = {id = 366, orderID = 2, playTypeID = 2, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-03 04:00:00", CloseTime = "2022-11-04 03:59:59"}
, 
[367] = {id = 367, orderID = 3, playTypeID = 2, propertyID = 31420, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-10-28 04:00:00", CloseTime = "2022-11-04 03:59:59"}
, 
[368] = {id = 368, orderID = 4, playTypeID = 2, propertyID = 31421, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-10-28 04:00:00", CloseTime = "2022-11-04 03:59:59"}
, 
[369] = {id = 369, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-04 04:00:00", CloseTime = "2022-11-05 03:59:59"}
, 
[370] = {id = 370, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-05 04:00:00", CloseTime = "2022-11-06 03:59:59"}
, 
[371] = {id = 371, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-06 04:00:00", CloseTime = "2022-11-07 03:59:59"}
, 
[372] = {id = 372, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-07 04:00:00", CloseTime = "2022-11-08 03:59:59"}
, 
[373] = {id = 373, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-08 04:00:00", CloseTime = "2022-11-09 03:59:59"}
, 
[374] = {id = 374, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-09 04:00:00", CloseTime = "2022-11-10 03:59:59"}
, 
[375] = {id = 375, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-10 04:00:00", CloseTime = "2022-11-11 03:59:59"}
, 
[376] = {id = 376, orderID = 2, playTypeID = 3, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-04 04:00:00", CloseTime = "2022-11-05 03:59:59"}
, 
[377] = {id = 377, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-05 04:00:00", CloseTime = "2022-11-06 03:59:59"}
, 
[378] = {id = 378, orderID = 2, playTypeID = 3, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-06 04:00:00", CloseTime = "2022-11-07 03:59:59"}
, 
[379] = {id = 379, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-07 04:00:00", CloseTime = "2022-11-08 03:59:59"}
, 
[380] = {id = 380, orderID = 2, playTypeID = 3, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-08 04:00:00", CloseTime = "2022-11-09 03:59:59"}
, 
[381] = {id = 381, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-09 04:00:00", CloseTime = "2022-11-10 03:59:59"}
, 
[382] = {id = 382, orderID = 2, playTypeID = 3, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-10 04:00:00", CloseTime = "2022-11-11 03:59:59"}
, 
[383] = {id = 383, orderID = 3, playTypeID = 3, propertyID = 31422, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-11-04 04:00:00", CloseTime = "2022-11-11 03:59:59"}
, 
[384] = {id = 384, orderID = 4, playTypeID = 3, propertyID = 31423, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-11-04 04:00:00", CloseTime = "2022-11-11 03:59:59"}
, 
[385] = {id = 385, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-11 04:00:00", CloseTime = "2022-11-12 03:59:59"}
, 
[386] = {id = 386, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-12 04:00:00", CloseTime = "2022-11-13 03:59:59"}
, 
[387] = {id = 387, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-13 04:00:00", CloseTime = "2022-11-14 03:59:59"}
, 
[388] = {id = 388, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-14 04:00:00", CloseTime = "2022-11-15 03:59:59"}
, 
[389] = {id = 389, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-15 04:00:00", CloseTime = "2022-11-16 03:59:59"}
, 
[390] = {id = 390, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-16 04:00:00", CloseTime = "2022-11-17 03:59:59"}
, 
[391] = {id = 391, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-17 04:00:00", CloseTime = "2022-11-18 03:59:59"}
, 
[392] = {id = 392, orderID = 2, playTypeID = 1, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-11 04:00:00", CloseTime = "2022-11-12 03:59:59"}
, 
[393] = {id = 393, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-12 04:00:00", CloseTime = "2022-11-13 03:59:59"}
, 
[394] = {id = 394, orderID = 2, playTypeID = 1, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-13 04:00:00", CloseTime = "2022-11-14 03:59:59"}
, 
[395] = {id = 395, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-14 04:00:00", CloseTime = "2022-11-15 03:59:59"}
, 
[396] = {id = 396, orderID = 2, playTypeID = 1, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-15 04:00:00", CloseTime = "2022-11-16 03:59:59"}
, 
[397] = {id = 397, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-16 04:00:00", CloseTime = "2022-11-17 03:59:59"}
, 
[398] = {id = 398, orderID = 2, playTypeID = 1, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-17 04:00:00", CloseTime = "2022-11-18 03:59:59"}
, 
[399] = {id = 399, orderID = 3, playTypeID = 1, propertyID = 31418, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-11-11 04:00:00", CloseTime = "2022-11-18 03:59:59"}
, 
[400] = {id = 400, orderID = 4, playTypeID = 1, propertyID = 31419, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-11-11 04:00:00", CloseTime = "2022-11-18 03:59:59"}
, 
[401] = {id = 401, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-18 04:00:00", CloseTime = "2022-11-19 03:59:59"}
, 
[402] = {id = 402, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-19 04:00:00", CloseTime = "2022-11-20 03:59:59"}
, 
[403] = {id = 403, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-20 04:00:00", CloseTime = "2022-11-21 03:59:59"}
, 
[404] = {id = 404, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-21 04:00:00", CloseTime = "2022-11-22 03:59:59"}
, 
[405] = {id = 405, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-22 04:00:00", CloseTime = "2022-11-23 03:59:59"}
, 
[406] = {id = 406, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-23 04:00:00", CloseTime = "2022-11-24 03:59:59"}
, 
[407] = {id = 407, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-24 04:00:00", CloseTime = "2022-11-25 03:59:59"}
, 
[408] = {id = 408, orderID = 2, playTypeID = 2, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-18 04:00:00", CloseTime = "2022-11-19 03:59:59"}
, 
[409] = {id = 409, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-19 04:00:00", CloseTime = "2022-11-20 03:59:59"}
, 
[410] = {id = 410, orderID = 2, playTypeID = 2, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-20 04:00:00", CloseTime = "2022-11-21 03:59:59"}
, 
[411] = {id = 411, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-21 04:00:00", CloseTime = "2022-11-22 03:59:59"}
, 
[412] = {id = 412, orderID = 2, playTypeID = 2, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-22 04:00:00", CloseTime = "2022-11-23 03:59:59"}
, 
[413] = {id = 413, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-23 04:00:00", CloseTime = "2022-11-24 03:59:59"}
, 
[414] = {id = 414, orderID = 2, playTypeID = 2, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-24 04:00:00", CloseTime = "2022-11-25 03:59:59"}
, 
[415] = {id = 415, orderID = 3, playTypeID = 2, propertyID = 31420, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-11-18 04:00:00", CloseTime = "2022-11-25 03:59:59"}
, 
[416] = {id = 416, orderID = 4, playTypeID = 2, propertyID = 31421, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-11-18 04:00:00", CloseTime = "2022-11-25 03:59:59"}
, 
[417] = {id = 417, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-25 04:00:00", CloseTime = "2022-11-26 03:59:59"}
, 
[418] = {id = 418, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-26 04:00:00", CloseTime = "2022-11-27 03:59:59"}
, 
[419] = {id = 419, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-27 04:00:00", CloseTime = "2022-11-28 03:59:59"}
, 
[420] = {id = 420, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-28 04:00:00", CloseTime = "2022-11-29 03:59:59"}
, 
[421] = {id = 421, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-29 04:00:00", CloseTime = "2022-11-30 03:59:59"}
, 
[422] = {id = 422, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-11-30 04:00:00", CloseTime = "2022-12-01 03:59:59"}
, 
[423] = {id = 423, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-01 04:00:00", CloseTime = "2022-12-02 03:59:59"}
, 
[424] = {id = 424, orderID = 2, playTypeID = 3, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-25 04:00:00", CloseTime = "2022-11-26 03:59:59"}
, 
[425] = {id = 425, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-26 04:00:00", CloseTime = "2022-11-27 03:59:59"}
, 
[426] = {id = 426, orderID = 2, playTypeID = 3, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-27 04:00:00", CloseTime = "2022-11-28 03:59:59"}
, 
[427] = {id = 427, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-28 04:00:00", CloseTime = "2022-11-29 03:59:59"}
, 
[428] = {id = 428, orderID = 2, playTypeID = 3, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-29 04:00:00", CloseTime = "2022-11-30 03:59:59"}
, 
[429] = {id = 429, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-11-30 04:00:00", CloseTime = "2022-12-01 03:59:59"}
, 
[430] = {id = 430, orderID = 2, playTypeID = 3, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-01 04:00:00", CloseTime = "2022-12-02 03:59:59"}
, 
[431] = {id = 431, orderID = 3, playTypeID = 3, propertyID = 31422, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-11-25 04:00:00", CloseTime = "2022-12-02 03:59:59"}
, 
[432] = {id = 432, orderID = 4, playTypeID = 3, propertyID = 31423, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-11-25 04:00:00", CloseTime = "2022-12-02 03:59:59"}
, 
[433] = {id = 433, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-02 04:00:00", CloseTime = "2022-12-03 03:59:59"}
, 
[434] = {id = 434, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-03 04:00:00", CloseTime = "2022-12-04 03:59:59"}
, 
[435] = {id = 435, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-04 04:00:00", CloseTime = "2022-12-05 03:59:59"}
, 
[436] = {id = 436, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-05 04:00:00", CloseTime = "2022-12-06 03:59:59"}
, 
[437] = {id = 437, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-06 04:00:00", CloseTime = "2022-12-07 03:59:59"}
, 
[438] = {id = 438, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-07 04:00:00", CloseTime = "2022-12-08 03:59:59"}
, 
[439] = {id = 439, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-08 04:00:00", CloseTime = "2022-12-09 03:59:59"}
, 
[440] = {id = 440, orderID = 2, playTypeID = 1, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-02 04:00:00", CloseTime = "2022-12-03 03:59:59"}
, 
[441] = {id = 441, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-03 04:00:00", CloseTime = "2022-12-04 03:59:59"}
, 
[442] = {id = 442, orderID = 2, playTypeID = 1, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-04 04:00:00", CloseTime = "2022-12-05 03:59:59"}
, 
[443] = {id = 443, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-05 04:00:00", CloseTime = "2022-12-06 03:59:59"}
, 
[444] = {id = 444, orderID = 2, playTypeID = 1, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-06 04:00:00", CloseTime = "2022-12-07 03:59:59"}
, 
[445] = {id = 445, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-07 04:00:00", CloseTime = "2022-12-08 03:59:59"}
, 
[446] = {id = 446, orderID = 2, playTypeID = 1, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-08 04:00:00", CloseTime = "2022-12-09 03:59:59"}
, 
[447] = {id = 447, orderID = 3, playTypeID = 1, propertyID = 31418, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-12-02 04:00:00", CloseTime = "2022-12-09 03:59:59"}
, 
[448] = {id = 448, orderID = 4, playTypeID = 1, propertyID = 31419, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-12-02 04:00:00", CloseTime = "2022-12-09 03:59:59"}
, 
[449] = {id = 449, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-09 04:00:00", CloseTime = "2022-12-10 03:59:59"}
, 
[450] = {id = 450, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-10 04:00:00", CloseTime = "2022-12-11 03:59:59"}
, 
[451] = {id = 451, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-11 04:00:00", CloseTime = "2022-12-12 03:59:59"}
, 
[452] = {id = 452, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-12 04:00:00", CloseTime = "2022-12-13 03:59:59"}
, 
[453] = {id = 453, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-13 04:00:00", CloseTime = "2022-12-14 03:59:59"}
, 
[454] = {id = 454, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-14 04:00:00", CloseTime = "2022-12-15 03:59:59"}
, 
[455] = {id = 455, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-15 04:00:00", CloseTime = "2022-12-16 03:59:59"}
, 
[456] = {id = 456, orderID = 2, playTypeID = 2, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-09 04:00:00", CloseTime = "2022-12-10 03:59:59"}
, 
[457] = {id = 457, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-10 04:00:00", CloseTime = "2022-12-11 03:59:59"}
, 
[458] = {id = 458, orderID = 2, playTypeID = 2, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-11 04:00:00", CloseTime = "2022-12-12 03:59:59"}
, 
[459] = {id = 459, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-12 04:00:00", CloseTime = "2022-12-13 03:59:59"}
, 
[460] = {id = 460, orderID = 2, playTypeID = 2, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-13 04:00:00", CloseTime = "2022-12-14 03:59:59"}
, 
[461] = {id = 461, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-14 04:00:00", CloseTime = "2022-12-15 03:59:59"}
, 
[462] = {id = 462, orderID = 2, playTypeID = 2, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-15 04:00:00", CloseTime = "2022-12-16 03:59:59"}
, 
[463] = {id = 463, orderID = 3, playTypeID = 2, propertyID = 31420, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-12-09 04:00:00", CloseTime = "2022-12-16 03:59:59"}
, 
[464] = {id = 464, orderID = 4, playTypeID = 2, propertyID = 31421, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-12-09 04:00:00", CloseTime = "2022-12-16 03:59:59"}
, 
[465] = {id = 465, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-16 04:00:00", CloseTime = "2022-12-17 03:59:59"}
, 
[466] = {id = 466, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-17 04:00:00", CloseTime = "2022-12-18 03:59:59"}
, 
[467] = {id = 467, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-18 04:00:00", CloseTime = "2022-12-19 03:59:59"}
, 
[468] = {id = 468, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-19 04:00:00", CloseTime = "2022-12-20 03:59:59"}
, 
[469] = {id = 469, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-20 04:00:00", CloseTime = "2022-12-21 03:59:59"}
, 
[470] = {id = 470, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-21 04:00:00", CloseTime = "2022-12-22 03:59:59"}
, 
[471] = {id = 471, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-22 04:00:00", CloseTime = "2022-12-23 03:59:59"}
, 
[472] = {id = 472, orderID = 2, playTypeID = 3, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-16 04:00:00", CloseTime = "2022-12-17 03:59:59"}
, 
[473] = {id = 473, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-17 04:00:00", CloseTime = "2022-12-18 03:59:59"}
, 
[474] = {id = 474, orderID = 2, playTypeID = 3, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-18 04:00:00", CloseTime = "2022-12-19 03:59:59"}
, 
[475] = {id = 475, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-19 04:00:00", CloseTime = "2022-12-20 03:59:59"}
, 
[476] = {id = 476, orderID = 2, playTypeID = 3, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-20 04:00:00", CloseTime = "2022-12-21 03:59:59"}
, 
[477] = {id = 477, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-21 04:00:00", CloseTime = "2022-12-22 03:59:59"}
, 
[478] = {id = 478, orderID = 2, playTypeID = 3, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-22 04:00:00", CloseTime = "2022-12-23 03:59:59"}
, 
[479] = {id = 479, orderID = 3, playTypeID = 3, propertyID = 31422, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-12-16 04:00:00", CloseTime = "2022-12-23 03:59:59"}
, 
[480] = {id = 480, orderID = 4, playTypeID = 3, propertyID = 31423, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-12-16 04:00:00", CloseTime = "2022-12-23 03:59:59"}
, 
[481] = {id = 481, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-23 04:00:00", CloseTime = "2022-12-24 03:59:59"}
, 
[482] = {id = 482, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-24 04:00:00", CloseTime = "2022-12-25 03:59:59"}
, 
[483] = {id = 483, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-25 04:00:00", CloseTime = "2022-12-26 03:59:59"}
, 
[484] = {id = 484, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-26 04:00:00", CloseTime = "2022-12-27 03:59:59"}
, 
[485] = {id = 485, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-27 04:00:00", CloseTime = "2022-12-28 03:59:59"}
, 
[486] = {id = 486, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-28 04:00:00", CloseTime = "2022-12-29 03:59:59"}
, 
[487] = {id = 487, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-29 04:00:00", CloseTime = "2022-12-30 03:59:59"}
, 
[488] = {id = 488, orderID = 2, playTypeID = 1, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-23 04:00:00", CloseTime = "2022-12-24 03:59:59"}
, 
[489] = {id = 489, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-24 04:00:00", CloseTime = "2022-12-25 03:59:59"}
, 
[490] = {id = 490, orderID = 2, playTypeID = 1, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-25 04:00:00", CloseTime = "2022-12-26 03:59:59"}
, 
[491] = {id = 491, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-26 04:00:00", CloseTime = "2022-12-27 03:59:59"}
, 
[492] = {id = 492, orderID = 2, playTypeID = 1, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-27 04:00:00", CloseTime = "2022-12-28 03:59:59"}
, 
[493] = {id = 493, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-28 04:00:00", CloseTime = "2022-12-29 03:59:59"}
, 
[494] = {id = 494, orderID = 2, playTypeID = 1, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-29 04:00:00", CloseTime = "2022-12-30 03:59:59"}
, 
[495] = {id = 495, orderID = 3, playTypeID = 1, propertyID = 31418, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-12-23 04:00:00", CloseTime = "2022-12-30 03:59:59"}
, 
[496] = {id = 496, orderID = 4, playTypeID = 1, propertyID = 31419, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-12-23 04:00:00", CloseTime = "2022-12-30 03:59:59"}
, 
[497] = {id = 497, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-30 04:00:00", CloseTime = "2022-12-31 03:59:59"}
, 
[498] = {id = 498, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2022-12-31 04:00:00", CloseTime = "2023-01-01 03:59:59"}
, 
[499] = {id = 499, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-01 04:00:00", CloseTime = "2023-01-02 03:59:59"}
, 
[500] = {id = 500, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-02 04:00:00", CloseTime = "2023-01-03 03:59:59"}
, 
[501] = {id = 501, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-03 04:00:00", CloseTime = "2023-01-04 03:59:59"}
, 
[502] = {id = 502, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-04 04:00:00", CloseTime = "2023-01-05 03:59:59"}
, 
[503] = {id = 503, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-05 04:00:00", CloseTime = "2023-01-06 03:59:59"}
, 
[504] = {id = 504, orderID = 2, playTypeID = 2, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-30 04:00:00", CloseTime = "2022-12-31 03:59:59"}
, 
[505] = {id = 505, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2022-12-31 04:00:00", CloseTime = "2023-01-01 03:59:59"}
, 
[506] = {id = 506, orderID = 2, playTypeID = 2, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-01 04:00:00", CloseTime = "2023-01-02 03:59:59"}
, 
[507] = {id = 507, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-02 04:00:00", CloseTime = "2023-01-03 03:59:59"}
, 
[508] = {id = 508, orderID = 2, playTypeID = 2, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-03 04:00:00", CloseTime = "2023-01-04 03:59:59"}
, 
[509] = {id = 509, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-04 04:00:00", CloseTime = "2023-01-05 03:59:59"}
, 
[510] = {id = 510, orderID = 2, playTypeID = 2, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-05 04:00:00", CloseTime = "2023-01-06 03:59:59"}
, 
[511] = {id = 511, orderID = 3, playTypeID = 2, propertyID = 31420, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2022-12-30 04:00:00", CloseTime = "2023-01-06 03:59:59"}
, 
[512] = {id = 512, orderID = 4, playTypeID = 2, propertyID = 31421, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2022-12-30 04:00:00", CloseTime = "2023-01-06 03:59:59"}
, 
[513] = {id = 513, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-06 04:00:00", CloseTime = "2023-01-07 03:59:59"}
, 
[514] = {id = 514, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-07 04:00:00", CloseTime = "2023-01-08 03:59:59"}
, 
[515] = {id = 515, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-08 04:00:00", CloseTime = "2023-01-09 03:59:59"}
, 
[516] = {id = 516, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-09 04:00:00", CloseTime = "2023-01-10 03:59:59"}
, 
[517] = {id = 517, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-10 04:00:00", CloseTime = "2023-01-11 03:59:59"}
, 
[518] = {id = 518, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-11 04:00:00", CloseTime = "2023-01-12 03:59:59"}
, 
[519] = {id = 519, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-12 04:00:00", CloseTime = "2023-01-13 03:59:59"}
, 
[520] = {id = 520, orderID = 2, playTypeID = 3, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-06 04:00:00", CloseTime = "2023-01-07 03:59:59"}
, 
[521] = {id = 521, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-07 04:00:00", CloseTime = "2023-01-08 03:59:59"}
, 
[522] = {id = 522, orderID = 2, playTypeID = 3, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-08 04:00:00", CloseTime = "2023-01-09 03:59:59"}
, 
[523] = {id = 523, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-09 04:00:00", CloseTime = "2023-01-10 03:59:59"}
, 
[524] = {id = 524, orderID = 2, playTypeID = 3, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-10 04:00:00", CloseTime = "2023-01-11 03:59:59"}
, 
[525] = {id = 525, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-11 04:00:00", CloseTime = "2023-01-12 03:59:59"}
, 
[526] = {id = 526, orderID = 2, playTypeID = 3, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-12 04:00:00", CloseTime = "2023-01-13 03:59:59"}
, 
[527] = {id = 527, orderID = 3, playTypeID = 3, propertyID = 31422, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-01-06 04:00:00", CloseTime = "2023-01-13 03:59:59"}
, 
[528] = {id = 528, orderID = 4, playTypeID = 3, propertyID = 31423, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-01-06 04:00:00", CloseTime = "2023-01-13 03:59:59"}
, 
[529] = {id = 529, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-13 04:00:00", CloseTime = "2023-01-14 03:59:59"}
, 
[530] = {id = 530, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-14 04:00:00", CloseTime = "2023-01-15 03:59:59"}
, 
[531] = {id = 531, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-15 04:00:00", CloseTime = "2023-01-16 03:59:59"}
, 
[532] = {id = 532, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-16 04:00:00", CloseTime = "2023-01-17 03:59:59"}
, 
[533] = {id = 533, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-17 04:00:00", CloseTime = "2023-01-18 03:59:59"}
, 
[534] = {id = 534, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-18 04:00:00", CloseTime = "2023-01-19 03:59:59"}
, 
[535] = {id = 535, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-19 04:00:00", CloseTime = "2023-01-20 03:59:59"}
, 
[536] = {id = 536, orderID = 2, playTypeID = 1, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-13 04:00:00", CloseTime = "2023-01-14 03:59:59"}
, 
[537] = {id = 537, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-14 04:00:00", CloseTime = "2023-01-15 03:59:59"}
, 
[538] = {id = 538, orderID = 2, playTypeID = 1, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-15 04:00:00", CloseTime = "2023-01-16 03:59:59"}
, 
[539] = {id = 539, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-16 04:00:00", CloseTime = "2023-01-17 03:59:59"}
, 
[540] = {id = 540, orderID = 2, playTypeID = 1, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-17 04:00:00", CloseTime = "2023-01-18 03:59:59"}
, 
[541] = {id = 541, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-18 04:00:00", CloseTime = "2023-01-19 03:59:59"}
, 
[542] = {id = 542, orderID = 2, playTypeID = 1, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-19 04:00:00", CloseTime = "2023-01-20 03:59:59"}
, 
[543] = {id = 543, orderID = 3, playTypeID = 1, propertyID = 31418, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-01-13 04:00:00", CloseTime = "2023-01-20 03:59:59"}
, 
[544] = {id = 544, orderID = 4, playTypeID = 1, propertyID = 31419, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-01-13 04:00:00", CloseTime = "2023-01-20 03:59:59"}
, 
[545] = {id = 545, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-20 04:00:00", CloseTime = "2023-01-21 03:59:59"}
, 
[546] = {id = 546, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-21 04:00:00", CloseTime = "2023-01-22 03:59:59"}
, 
[547] = {id = 547, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-22 04:00:00", CloseTime = "2023-01-23 03:59:59"}
, 
[548] = {id = 548, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-23 04:00:00", CloseTime = "2023-01-24 03:59:59"}
, 
[549] = {id = 549, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-24 04:00:00", CloseTime = "2023-01-25 03:59:59"}
, 
[550] = {id = 550, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-25 04:00:00", CloseTime = "2023-01-26 03:59:59"}
, 
[551] = {id = 551, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-26 04:00:00", CloseTime = "2023-01-27 03:59:59"}
, 
[552] = {id = 552, orderID = 2, playTypeID = 2, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-20 04:00:00", CloseTime = "2023-01-21 03:59:59"}
, 
[553] = {id = 553, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-21 04:00:00", CloseTime = "2023-01-22 03:59:59"}
, 
[554] = {id = 554, orderID = 2, playTypeID = 2, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-22 04:00:00", CloseTime = "2023-01-23 03:59:59"}
, 
[555] = {id = 555, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-23 04:00:00", CloseTime = "2023-01-24 03:59:59"}
, 
[556] = {id = 556, orderID = 2, playTypeID = 2, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-24 04:00:00", CloseTime = "2023-01-25 03:59:59"}
, 
[557] = {id = 557, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-25 04:00:00", CloseTime = "2023-01-26 03:59:59"}
, 
[558] = {id = 558, orderID = 2, playTypeID = 2, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-26 04:00:00", CloseTime = "2023-01-27 03:59:59"}
, 
[559] = {id = 559, orderID = 3, playTypeID = 2, propertyID = 31420, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-01-20 04:00:00", CloseTime = "2023-01-27 03:59:59"}
, 
[560] = {id = 560, orderID = 4, playTypeID = 2, propertyID = 31421, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-01-20 04:00:00", CloseTime = "2023-01-27 03:59:59"}
, 
[561] = {id = 561, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-27 04:00:00", CloseTime = "2023-01-28 03:59:59"}
, 
[562] = {id = 562, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-28 04:00:00", CloseTime = "2023-01-29 03:59:59"}
, 
[563] = {id = 563, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-29 04:00:00", CloseTime = "2023-01-30 03:59:59"}
, 
[564] = {id = 564, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-30 04:00:00", CloseTime = "2023-01-31 03:59:59"}
, 
[565] = {id = 565, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-01-31 04:00:00", CloseTime = "2023-02-01 03:59:59"}
, 
[566] = {id = 566, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-01 04:00:00", CloseTime = "2023-02-02 03:59:59"}
, 
[567] = {id = 567, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-02 04:00:00", CloseTime = "2023-02-03 03:59:59"}
, 
[568] = {id = 568, orderID = 2, playTypeID = 3, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-27 04:00:00", CloseTime = "2023-01-28 03:59:59"}
, 
[569] = {id = 569, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-28 04:00:00", CloseTime = "2023-01-29 03:59:59"}
, 
[570] = {id = 570, orderID = 2, playTypeID = 3, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-29 04:00:00", CloseTime = "2023-01-30 03:59:59"}
, 
[571] = {id = 571, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-30 04:00:00", CloseTime = "2023-01-31 03:59:59"}
, 
[572] = {id = 572, orderID = 2, playTypeID = 3, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-01-31 04:00:00", CloseTime = "2023-02-01 03:59:59"}
, 
[573] = {id = 573, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-01 04:00:00", CloseTime = "2023-02-02 03:59:59"}
, 
[574] = {id = 574, orderID = 2, playTypeID = 3, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-02 04:00:00", CloseTime = "2023-02-03 03:59:59"}
, 
[575] = {id = 575, orderID = 3, playTypeID = 3, propertyID = 31422, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-01-27 04:00:00", CloseTime = "2023-02-03 03:59:59"}
, 
[576] = {id = 576, orderID = 4, playTypeID = 3, propertyID = 31423, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-01-27 04:00:00", CloseTime = "2023-02-03 03:59:59"}
, 
[577] = {id = 577, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-03 04:00:00", CloseTime = "2023-02-04 03:59:59"}
, 
[578] = {id = 578, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-04 04:00:00", CloseTime = "2023-02-05 03:59:59"}
, 
[579] = {id = 579, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-05 04:00:00", CloseTime = "2023-02-06 03:59:59"}
, 
[580] = {id = 580, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-06 04:00:00", CloseTime = "2023-02-07 03:59:59"}
, 
[581] = {id = 581, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-07 04:00:00", CloseTime = "2023-02-08 03:59:59"}
, 
[582] = {id = 582, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-08 04:00:00", CloseTime = "2023-02-09 03:59:59"}
, 
[583] = {id = 583, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-09 04:00:00", CloseTime = "2023-02-10 03:59:59"}
, 
[584] = {id = 584, orderID = 2, playTypeID = 1, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-03 04:00:00", CloseTime = "2023-02-04 03:59:59"}
, 
[585] = {id = 585, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-04 04:00:00", CloseTime = "2023-02-05 03:59:59"}
, 
[586] = {id = 586, orderID = 2, playTypeID = 1, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-05 04:00:00", CloseTime = "2023-02-06 03:59:59"}
, 
[587] = {id = 587, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-06 04:00:00", CloseTime = "2023-02-07 03:59:59"}
, 
[588] = {id = 588, orderID = 2, playTypeID = 1, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-07 04:00:00", CloseTime = "2023-02-08 03:59:59"}
, 
[589] = {id = 589, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-08 04:00:00", CloseTime = "2023-02-09 03:59:59"}
, 
[590] = {id = 590, orderID = 2, playTypeID = 1, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-09 04:00:00", CloseTime = "2023-02-10 03:59:59"}
, 
[591] = {id = 591, orderID = 3, playTypeID = 1, propertyID = 31418, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-02-03 04:00:00", CloseTime = "2023-02-10 03:59:59"}
, 
[592] = {id = 592, orderID = 4, playTypeID = 1, propertyID = 31419, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-02-03 04:00:00", CloseTime = "2023-02-10 03:59:59"}
, 
[593] = {id = 593, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-10 04:00:00", CloseTime = "2023-02-11 03:59:59"}
, 
[594] = {id = 594, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-11 04:00:00", CloseTime = "2023-02-12 03:59:59"}
, 
[595] = {id = 595, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-12 04:00:00", CloseTime = "2023-02-13 03:59:59"}
, 
[596] = {id = 596, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-13 04:00:00", CloseTime = "2023-02-14 03:59:59"}
, 
[597] = {id = 597, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-14 04:00:00", CloseTime = "2023-02-15 03:59:59"}
, 
[598] = {id = 598, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-15 04:00:00", CloseTime = "2023-02-16 03:59:59"}
, 
[599] = {id = 599, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-16 04:00:00", CloseTime = "2023-02-17 03:59:59"}
, 
[600] = {id = 600, orderID = 2, playTypeID = 2, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-10 04:00:00", CloseTime = "2023-02-11 03:59:59"}
, 
[601] = {id = 601, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-11 04:00:00", CloseTime = "2023-02-12 03:59:59"}
, 
[602] = {id = 602, orderID = 2, playTypeID = 2, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-12 04:00:00", CloseTime = "2023-02-13 03:59:59"}
, 
[603] = {id = 603, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-13 04:00:00", CloseTime = "2023-02-14 03:59:59"}
, 
[604] = {id = 604, orderID = 2, playTypeID = 2, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-14 04:00:00", CloseTime = "2023-02-15 03:59:59"}
, 
[605] = {id = 605, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-15 04:00:00", CloseTime = "2023-02-16 03:59:59"}
, 
[606] = {id = 606, orderID = 2, playTypeID = 2, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-16 04:00:00", CloseTime = "2023-02-17 03:59:59"}
, 
[607] = {id = 607, orderID = 3, playTypeID = 2, propertyID = 31420, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-02-10 04:00:00", CloseTime = "2023-02-17 03:59:59"}
, 
[608] = {id = 608, orderID = 4, playTypeID = 2, propertyID = 31421, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-02-10 04:00:00", CloseTime = "2023-02-17 03:59:59"}
, 
[609] = {id = 609, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-17 04:00:00", CloseTime = "2023-02-18 03:59:59"}
, 
[610] = {id = 610, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-18 04:00:00", CloseTime = "2023-02-19 03:59:59"}
, 
[611] = {id = 611, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-19 04:00:00", CloseTime = "2023-02-20 03:59:59"}
, 
[612] = {id = 612, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-20 04:00:00", CloseTime = "2023-02-21 03:59:59"}
, 
[613] = {id = 613, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-21 04:00:00", CloseTime = "2023-02-22 03:59:59"}
, 
[614] = {id = 614, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-22 04:00:00", CloseTime = "2023-02-23 03:59:59"}
, 
[615] = {id = 615, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-23 04:00:00", CloseTime = "2023-02-24 03:59:59"}
, 
[616] = {id = 616, orderID = 2, playTypeID = 3, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-17 04:00:00", CloseTime = "2023-02-18 03:59:59"}
, 
[617] = {id = 617, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-18 04:00:00", CloseTime = "2023-02-19 03:59:59"}
, 
[618] = {id = 618, orderID = 2, playTypeID = 3, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-19 04:00:00", CloseTime = "2023-02-20 03:59:59"}
, 
[619] = {id = 619, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-20 04:00:00", CloseTime = "2023-02-21 03:59:59"}
, 
[620] = {id = 620, orderID = 2, playTypeID = 3, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-21 04:00:00", CloseTime = "2023-02-22 03:59:59"}
, 
[621] = {id = 621, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-22 04:00:00", CloseTime = "2023-02-23 03:59:59"}
, 
[622] = {id = 622, orderID = 2, playTypeID = 3, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-23 04:00:00", CloseTime = "2023-02-24 03:59:59"}
, 
[623] = {id = 623, orderID = 3, playTypeID = 3, propertyID = 31422, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-02-17 04:00:00", CloseTime = "2023-02-24 03:59:59"}
, 
[624] = {id = 624, orderID = 4, playTypeID = 3, propertyID = 31423, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-02-17 04:00:00", CloseTime = "2023-02-24 03:59:59"}
, 
[625] = {id = 625, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-24 04:00:00", CloseTime = "2023-02-25 03:59:59"}
, 
[626] = {id = 626, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-25 04:00:00", CloseTime = "2023-02-26 03:59:59"}
, 
[627] = {id = 627, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-26 04:00:00", CloseTime = "2023-02-27 03:59:59"}
, 
[628] = {id = 628, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-27 04:00:00", CloseTime = "2023-02-28 03:59:59"}
, 
[629] = {id = 629, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-02-28 04:00:00", CloseTime = "2023-03-01 03:59:59"}
, 
[630] = {id = 630, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-01 04:00:00", CloseTime = "2023-03-02 03:59:59"}
, 
[631] = {id = 631, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-02 04:00:00", CloseTime = "2023-03-03 03:59:59"}
, 
[632] = {id = 632, orderID = 2, playTypeID = 1, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-24 04:00:00", CloseTime = "2023-02-25 03:59:59"}
, 
[633] = {id = 633, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-25 04:00:00", CloseTime = "2023-02-26 03:59:59"}
, 
[634] = {id = 634, orderID = 2, playTypeID = 1, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-26 04:00:00", CloseTime = "2023-02-27 03:59:59"}
, 
[635] = {id = 635, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-27 04:00:00", CloseTime = "2023-02-28 03:59:59"}
, 
[636] = {id = 636, orderID = 2, playTypeID = 1, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-02-28 04:00:00", CloseTime = "2023-03-01 03:59:59"}
, 
[637] = {id = 637, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-01 04:00:00", CloseTime = "2023-03-02 03:59:59"}
, 
[638] = {id = 638, orderID = 2, playTypeID = 1, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-02 04:00:00", CloseTime = "2023-03-03 03:59:59"}
, 
[639] = {id = 639, orderID = 3, playTypeID = 1, propertyID = 31418, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-02-24 04:00:00", CloseTime = "2023-03-03 03:59:59"}
, 
[640] = {id = 640, orderID = 4, playTypeID = 1, propertyID = 31419, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-02-24 04:00:00", CloseTime = "2023-03-03 03:59:59"}
, 
[641] = {id = 641, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-03 04:00:00", CloseTime = "2023-03-04 03:59:59"}
, 
[642] = {id = 642, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-04 04:00:00", CloseTime = "2023-03-05 03:59:59"}
, 
[643] = {id = 643, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-05 04:00:00", CloseTime = "2023-03-06 03:59:59"}
, 
[644] = {id = 644, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-06 04:00:00", CloseTime = "2023-03-07 03:59:59"}
, 
[645] = {id = 645, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-07 04:00:00", CloseTime = "2023-03-08 03:59:59"}
, 
[646] = {id = 646, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-08 04:00:00", CloseTime = "2023-03-09 03:59:59"}
, 
[647] = {id = 647, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-09 04:00:00", CloseTime = "2023-03-10 03:59:59"}
, 
[648] = {id = 648, orderID = 2, playTypeID = 2, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-03 04:00:00", CloseTime = "2023-03-04 03:59:59"}
, 
[649] = {id = 649, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-04 04:00:00", CloseTime = "2023-03-05 03:59:59"}
, 
[650] = {id = 650, orderID = 2, playTypeID = 2, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-05 04:00:00", CloseTime = "2023-03-06 03:59:59"}
, 
[651] = {id = 651, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-06 04:00:00", CloseTime = "2023-03-07 03:59:59"}
, 
[652] = {id = 652, orderID = 2, playTypeID = 2, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-07 04:00:00", CloseTime = "2023-03-08 03:59:59"}
, 
[653] = {id = 653, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-08 04:00:00", CloseTime = "2023-03-09 03:59:59"}
, 
[654] = {id = 654, orderID = 2, playTypeID = 2, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-09 04:00:00", CloseTime = "2023-03-10 03:59:59"}
, 
[655] = {id = 655, orderID = 3, playTypeID = 2, propertyID = 31420, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-03-03 04:00:00", CloseTime = "2023-03-10 03:59:59"}
, 
[656] = {id = 656, orderID = 4, playTypeID = 2, propertyID = 31421, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-03-03 04:00:00", CloseTime = "2023-03-10 03:59:59"}
, 
[657] = {id = 657, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-10 04:00:00", CloseTime = "2023-03-11 03:59:59"}
, 
[658] = {id = 658, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-11 04:00:00", CloseTime = "2023-03-12 03:59:59"}
, 
[659] = {id = 659, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-12 04:00:00", CloseTime = "2023-03-13 03:59:59"}
, 
[660] = {id = 660, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-13 04:00:00", CloseTime = "2023-03-14 03:59:59"}
, 
[661] = {id = 661, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-14 04:00:00", CloseTime = "2023-03-15 03:59:59"}
, 
[662] = {id = 662, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-15 04:00:00", CloseTime = "2023-03-16 03:59:59"}
, 
[663] = {id = 663, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-16 04:00:00", CloseTime = "2023-03-17 03:59:59"}
, 
[664] = {id = 664, orderID = 2, playTypeID = 3, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-10 04:00:00", CloseTime = "2023-03-11 03:59:59"}
, 
[665] = {id = 665, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-11 04:00:00", CloseTime = "2023-03-12 03:59:59"}
, 
[666] = {id = 666, orderID = 2, playTypeID = 3, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-12 04:00:00", CloseTime = "2023-03-13 03:59:59"}
, 
[667] = {id = 667, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-13 04:00:00", CloseTime = "2023-03-14 03:59:59"}
, 
[668] = {id = 668, orderID = 2, playTypeID = 3, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-14 04:00:00", CloseTime = "2023-03-15 03:59:59"}
, 
[669] = {id = 669, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-15 04:00:00", CloseTime = "2023-03-16 03:59:59"}
, 
[670] = {id = 670, orderID = 2, playTypeID = 3, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-16 04:00:00", CloseTime = "2023-03-17 03:59:59"}
, 
[671] = {id = 671, orderID = 3, playTypeID = 3, propertyID = 31422, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-03-10 04:00:00", CloseTime = "2023-03-17 03:59:59"}
, 
[672] = {id = 672, orderID = 4, playTypeID = 3, propertyID = 31423, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-03-10 04:00:00", CloseTime = "2023-03-17 03:59:59"}
, 
[673] = {id = 673, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-17 04:00:00", CloseTime = "2023-03-18 03:59:59"}
, 
[674] = {id = 674, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-18 04:00:00", CloseTime = "2023-03-19 03:59:59"}
, 
[675] = {id = 675, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-19 04:00:00", CloseTime = "2023-03-20 03:59:59"}
, 
[676] = {id = 676, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-20 04:00:00", CloseTime = "2023-03-21 03:59:59"}
, 
[677] = {id = 677, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-21 04:00:00", CloseTime = "2023-03-22 03:59:59"}
, 
[678] = {id = 678, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-22 04:00:00", CloseTime = "2023-03-23 03:59:59"}
, 
[679] = {id = 679, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-23 04:00:00", CloseTime = "2023-03-24 03:59:59"}
, 
[680] = {id = 680, orderID = 2, playTypeID = 1, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-17 04:00:00", CloseTime = "2023-03-18 03:59:59"}
, 
[681] = {id = 681, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-18 04:00:00", CloseTime = "2023-03-19 03:59:59"}
, 
[682] = {id = 682, orderID = 2, playTypeID = 1, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-19 04:00:00", CloseTime = "2023-03-20 03:59:59"}
, 
[683] = {id = 683, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-20 04:00:00", CloseTime = "2023-03-21 03:59:59"}
, 
[684] = {id = 684, orderID = 2, playTypeID = 1, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-21 04:00:00", CloseTime = "2023-03-22 03:59:59"}
, 
[685] = {id = 685, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-22 04:00:00", CloseTime = "2023-03-23 03:59:59"}
, 
[686] = {id = 686, orderID = 2, playTypeID = 1, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-23 04:00:00", CloseTime = "2023-03-24 03:59:59"}
, 
[687] = {id = 687, orderID = 3, playTypeID = 1, propertyID = 31418, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-03-17 04:00:00", CloseTime = "2023-03-24 03:59:59"}
, 
[688] = {id = 688, orderID = 4, playTypeID = 1, propertyID = 31419, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-03-17 04:00:00", CloseTime = "2023-03-24 03:59:59"}
, 
[689] = {id = 689, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-24 04:00:00", CloseTime = "2023-03-25 03:59:59"}
, 
[690] = {id = 690, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-25 04:00:00", CloseTime = "2023-03-26 03:59:59"}
, 
[691] = {id = 691, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-26 04:00:00", CloseTime = "2023-03-27 03:59:59"}
, 
[692] = {id = 692, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-27 04:00:00", CloseTime = "2023-03-28 03:59:59"}
, 
[693] = {id = 693, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-28 04:00:00", CloseTime = "2023-03-29 03:59:59"}
, 
[694] = {id = 694, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-29 04:00:00", CloseTime = "2023-03-30 03:59:59"}
, 
[695] = {id = 695, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-30 04:00:00", CloseTime = "2023-03-31 03:59:59"}
, 
[696] = {id = 696, orderID = 2, playTypeID = 2, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-24 04:00:00", CloseTime = "2023-03-25 03:59:59"}
, 
[697] = {id = 697, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-25 04:00:00", CloseTime = "2023-03-26 03:59:59"}
, 
[698] = {id = 698, orderID = 2, playTypeID = 2, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-26 04:00:00", CloseTime = "2023-03-27 03:59:59"}
, 
[699] = {id = 699, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-27 04:00:00", CloseTime = "2023-03-28 03:59:59"}
, 
[700] = {id = 700, orderID = 2, playTypeID = 2, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-28 04:00:00", CloseTime = "2023-03-29 03:59:59"}
, 
[701] = {id = 701, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-29 04:00:00", CloseTime = "2023-03-30 03:59:59"}
, 
[702] = {id = 702, orderID = 2, playTypeID = 2, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-30 04:00:00", CloseTime = "2023-03-31 03:59:59"}
, 
[703] = {id = 703, orderID = 3, playTypeID = 2, propertyID = 31420, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-03-24 04:00:00", CloseTime = "2023-03-31 03:59:59"}
, 
[704] = {id = 704, orderID = 4, playTypeID = 2, propertyID = 31421, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-03-24 04:00:00", CloseTime = "2023-03-31 03:59:59"}
, 
[705] = {id = 705, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-03-31 04:00:00", CloseTime = "2023-04-01 03:59:59"}
, 
[706] = {id = 706, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-01 04:00:00", CloseTime = "2023-04-02 03:59:59"}
, 
[707] = {id = 707, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-02 04:00:00", CloseTime = "2023-04-03 03:59:59"}
, 
[708] = {id = 708, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-03 04:00:00", CloseTime = "2023-04-04 03:59:59"}
, 
[709] = {id = 709, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-04 04:00:00", CloseTime = "2023-04-05 03:59:59"}
, 
[710] = {id = 710, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-05 04:00:00", CloseTime = "2023-04-06 03:59:59"}
, 
[711] = {id = 711, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-06 04:00:00", CloseTime = "2023-04-07 03:59:59"}
, 
[712] = {id = 712, orderID = 2, playTypeID = 3, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-03-31 04:00:00", CloseTime = "2023-04-01 03:59:59"}
, 
[713] = {id = 713, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-01 04:00:00", CloseTime = "2023-04-02 03:59:59"}
, 
[714] = {id = 714, orderID = 2, playTypeID = 3, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-02 04:00:00", CloseTime = "2023-04-03 03:59:59"}
, 
[715] = {id = 715, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-03 04:00:00", CloseTime = "2023-04-04 03:59:59"}
, 
[716] = {id = 716, orderID = 2, playTypeID = 3, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-04 04:00:00", CloseTime = "2023-04-05 03:59:59"}
, 
[717] = {id = 717, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-05 04:00:00", CloseTime = "2023-04-06 03:59:59"}
, 
[718] = {id = 718, orderID = 2, playTypeID = 3, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-06 04:00:00", CloseTime = "2023-04-07 03:59:59"}
, 
[719] = {id = 719, orderID = 3, playTypeID = 3, propertyID = 31422, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-03-31 04:00:00", CloseTime = "2023-04-07 03:59:59"}
, 
[720] = {id = 720, orderID = 4, playTypeID = 3, propertyID = 31423, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-03-31 04:00:00", CloseTime = "2023-04-07 03:59:59"}
, 
[721] = {id = 721, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-07 04:00:00", CloseTime = "2023-04-08 03:59:59"}
, 
[722] = {id = 722, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-08 04:00:00", CloseTime = "2023-04-09 03:59:59"}
, 
[723] = {id = 723, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-09 04:00:00", CloseTime = "2023-04-10 03:59:59"}
, 
[724] = {id = 724, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-10 04:00:00", CloseTime = "2023-04-11 03:59:59"}
, 
[725] = {id = 725, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-11 04:00:00", CloseTime = "2023-04-12 03:59:59"}
, 
[726] = {id = 726, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-12 04:00:00", CloseTime = "2023-04-13 03:59:59"}
, 
[727] = {id = 727, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-13 04:00:00", CloseTime = "2023-04-14 03:59:59"}
, 
[728] = {id = 728, orderID = 2, playTypeID = 1, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-07 04:00:00", CloseTime = "2023-04-08 03:59:59"}
, 
[729] = {id = 729, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-08 04:00:00", CloseTime = "2023-04-09 03:59:59"}
, 
[730] = {id = 730, orderID = 2, playTypeID = 1, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-09 04:00:00", CloseTime = "2023-04-10 03:59:59"}
, 
[731] = {id = 731, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-10 04:00:00", CloseTime = "2023-04-11 03:59:59"}
, 
[732] = {id = 732, orderID = 2, playTypeID = 1, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-11 04:00:00", CloseTime = "2023-04-12 03:59:59"}
, 
[733] = {id = 733, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-12 04:00:00", CloseTime = "2023-04-13 03:59:59"}
, 
[734] = {id = 734, orderID = 2, playTypeID = 1, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-13 04:00:00", CloseTime = "2023-04-14 03:59:59"}
, 
[735] = {id = 735, orderID = 3, playTypeID = 1, propertyID = 31418, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-04-07 04:00:00", CloseTime = "2023-04-14 03:59:59"}
, 
[736] = {id = 736, orderID = 4, playTypeID = 1, propertyID = 31419, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-04-07 04:00:00", CloseTime = "2023-04-14 03:59:59"}
, 
[737] = {id = 737, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-14 04:00:00", CloseTime = "2023-04-15 03:59:59"}
, 
[738] = {id = 738, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-15 04:00:00", CloseTime = "2023-04-16 03:59:59"}
, 
[739] = {id = 739, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-16 04:00:00", CloseTime = "2023-04-17 03:59:59"}
, 
[740] = {id = 740, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-17 04:00:00", CloseTime = "2023-04-18 03:59:59"}
, 
[741] = {id = 741, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-18 04:00:00", CloseTime = "2023-04-19 03:59:59"}
, 
[742] = {id = 742, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-19 04:00:00", CloseTime = "2023-04-20 03:59:59"}
, 
[743] = {id = 743, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-20 04:00:00", CloseTime = "2023-04-21 03:59:59"}
, 
[744] = {id = 744, orderID = 2, playTypeID = 2, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-14 04:00:00", CloseTime = "2023-04-15 03:59:59"}
, 
[745] = {id = 745, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-15 04:00:00", CloseTime = "2023-04-16 03:59:59"}
, 
[746] = {id = 746, orderID = 2, playTypeID = 2, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-16 04:00:00", CloseTime = "2023-04-17 03:59:59"}
, 
[747] = {id = 747, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-17 04:00:00", CloseTime = "2023-04-18 03:59:59"}
, 
[748] = {id = 748, orderID = 2, playTypeID = 2, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-18 04:00:00", CloseTime = "2023-04-19 03:59:59"}
, 
[749] = {id = 749, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-19 04:00:00", CloseTime = "2023-04-20 03:59:59"}
, 
[750] = {id = 750, orderID = 2, playTypeID = 2, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-20 04:00:00", CloseTime = "2023-04-21 03:59:59"}
, 
[751] = {id = 751, orderID = 3, playTypeID = 2, propertyID = 31420, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-04-14 04:00:00", CloseTime = "2023-04-21 03:59:59"}
, 
[752] = {id = 752, orderID = 4, playTypeID = 2, propertyID = 31421, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-04-14 04:00:00", CloseTime = "2023-04-21 03:59:59"}
, 
[753] = {id = 753, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-21 04:00:00", CloseTime = "2023-04-22 03:59:59"}
, 
[754] = {id = 754, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-22 04:00:00", CloseTime = "2023-04-23 03:59:59"}
, 
[755] = {id = 755, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-23 04:00:00", CloseTime = "2023-04-24 03:59:59"}
, 
[756] = {id = 756, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-24 04:00:00", CloseTime = "2023-04-25 03:59:59"}
, 
[757] = {id = 757, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-25 04:00:00", CloseTime = "2023-04-26 03:59:59"}
, 
[758] = {id = 758, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-26 04:00:00", CloseTime = "2023-04-27 03:59:59"}
, 
[759] = {id = 759, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-27 04:00:00", CloseTime = "2023-04-28 03:59:59"}
, 
[760] = {id = 760, orderID = 2, playTypeID = 3, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-21 04:00:00", CloseTime = "2023-04-22 03:59:59"}
, 
[761] = {id = 761, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-22 04:00:00", CloseTime = "2023-04-23 03:59:59"}
, 
[762] = {id = 762, orderID = 2, playTypeID = 3, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-23 04:00:00", CloseTime = "2023-04-24 03:59:59"}
, 
[763] = {id = 763, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-24 04:00:00", CloseTime = "2023-04-25 03:59:59"}
, 
[764] = {id = 764, orderID = 2, playTypeID = 3, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-25 04:00:00", CloseTime = "2023-04-26 03:59:59"}
, 
[765] = {id = 765, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-26 04:00:00", CloseTime = "2023-04-27 03:59:59"}
, 
[766] = {id = 766, orderID = 2, playTypeID = 3, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-27 04:00:00", CloseTime = "2023-04-28 03:59:59"}
, 
[767] = {id = 767, orderID = 3, playTypeID = 3, propertyID = 31422, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-04-21 04:00:00", CloseTime = "2023-04-28 03:59:59"}
, 
[768] = {id = 768, orderID = 4, playTypeID = 3, propertyID = 31423, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-04-21 04:00:00", CloseTime = "2023-04-28 03:59:59"}
, 
[769] = {id = 769, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-28 04:00:00", CloseTime = "2023-04-29 03:59:59"}
, 
[770] = {id = 770, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-29 04:00:00", CloseTime = "2023-04-30 03:59:59"}
, 
[771] = {id = 771, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-04-30 04:00:00", CloseTime = "2023-05-01 03:59:59"}
, 
[772] = {id = 772, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-01 04:00:00", CloseTime = "2023-05-02 03:59:59"}
, 
[773] = {id = 773, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-02 04:00:00", CloseTime = "2023-05-03 03:59:59"}
, 
[774] = {id = 774, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-03 04:00:00", CloseTime = "2023-05-04 03:59:59"}
, 
[775] = {id = 775, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-04 04:00:00", CloseTime = "2023-05-05 03:59:59"}
, 
[776] = {id = 776, orderID = 2, playTypeID = 1, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-28 04:00:00", CloseTime = "2023-04-29 03:59:59"}
, 
[777] = {id = 777, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-29 04:00:00", CloseTime = "2023-04-30 03:59:59"}
, 
[778] = {id = 778, orderID = 2, playTypeID = 1, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-04-30 04:00:00", CloseTime = "2023-05-01 03:59:59"}
, 
[779] = {id = 779, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-01 04:00:00", CloseTime = "2023-05-02 03:59:59"}
, 
[780] = {id = 780, orderID = 2, playTypeID = 1, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-02 04:00:00", CloseTime = "2023-05-03 03:59:59"}
, 
[781] = {id = 781, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-03 04:00:00", CloseTime = "2023-05-04 03:59:59"}
, 
[782] = {id = 782, orderID = 2, playTypeID = 1, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-04 04:00:00", CloseTime = "2023-05-05 03:59:59"}
, 
[783] = {id = 783, orderID = 3, playTypeID = 1, propertyID = 31418, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-04-28 04:00:00", CloseTime = "2023-05-05 03:59:59"}
, 
[784] = {id = 784, orderID = 4, playTypeID = 1, propertyID = 31419, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-04-28 04:00:00", CloseTime = "2023-05-05 03:59:59"}
, 
[785] = {id = 785, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-05 04:00:00", CloseTime = "2023-05-06 03:59:59"}
, 
[786] = {id = 786, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-06 04:00:00", CloseTime = "2023-05-07 03:59:59"}
, 
[787] = {id = 787, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-07 04:00:00", CloseTime = "2023-05-08 03:59:59"}
, 
[788] = {id = 788, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-08 04:00:00", CloseTime = "2023-05-09 03:59:59"}
, 
[789] = {id = 789, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-09 04:00:00", CloseTime = "2023-05-10 03:59:59"}
, 
[790] = {id = 790, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-10 04:00:00", CloseTime = "2023-05-11 03:59:59"}
, 
[791] = {id = 791, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-11 04:00:00", CloseTime = "2023-05-12 03:59:59"}
, 
[792] = {id = 792, orderID = 2, playTypeID = 2, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-05 04:00:00", CloseTime = "2023-05-06 03:59:59"}
, 
[793] = {id = 793, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-06 04:00:00", CloseTime = "2023-05-07 03:59:59"}
, 
[794] = {id = 794, orderID = 2, playTypeID = 2, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-07 04:00:00", CloseTime = "2023-05-08 03:59:59"}
, 
[795] = {id = 795, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-08 04:00:00", CloseTime = "2023-05-09 03:59:59"}
, 
[796] = {id = 796, orderID = 2, playTypeID = 2, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-09 04:00:00", CloseTime = "2023-05-10 03:59:59"}
, 
[797] = {id = 797, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-10 04:00:00", CloseTime = "2023-05-11 03:59:59"}
, 
[798] = {id = 798, orderID = 2, playTypeID = 2, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-11 04:00:00", CloseTime = "2023-05-12 03:59:59"}
, 
[799] = {id = 799, orderID = 3, playTypeID = 2, propertyID = 31420, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-05-05 04:00:00", CloseTime = "2023-05-12 03:59:59"}
, 
[800] = {id = 800, orderID = 4, playTypeID = 2, propertyID = 31421, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-05-05 04:00:00", CloseTime = "2023-05-12 03:59:59"}
, 
[801] = {id = 801, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-12 04:00:00", CloseTime = "2023-05-13 03:59:59"}
, 
[802] = {id = 802, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-13 04:00:00", CloseTime = "2023-05-14 03:59:59"}
, 
[803] = {id = 803, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-14 04:00:00", CloseTime = "2023-05-15 03:59:59"}
, 
[804] = {id = 804, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-15 04:00:00", CloseTime = "2023-05-16 03:59:59"}
, 
[805] = {id = 805, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-16 04:00:00", CloseTime = "2023-05-17 03:59:59"}
, 
[806] = {id = 806, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-17 04:00:00", CloseTime = "2023-05-18 03:59:59"}
, 
[807] = {id = 807, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-18 04:00:00", CloseTime = "2023-05-19 03:59:59"}
, 
[808] = {id = 808, orderID = 2, playTypeID = 3, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-12 04:00:00", CloseTime = "2023-05-13 03:59:59"}
, 
[809] = {id = 809, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-13 04:00:00", CloseTime = "2023-05-14 03:59:59"}
, 
[810] = {id = 810, orderID = 2, playTypeID = 3, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-14 04:00:00", CloseTime = "2023-05-15 03:59:59"}
, 
[811] = {id = 811, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-15 04:00:00", CloseTime = "2023-05-16 03:59:59"}
, 
[812] = {id = 812, orderID = 2, playTypeID = 3, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-16 04:00:00", CloseTime = "2023-05-17 03:59:59"}
, 
[813] = {id = 813, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-17 04:00:00", CloseTime = "2023-05-18 03:59:59"}
, 
[814] = {id = 814, orderID = 2, playTypeID = 3, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-18 04:00:00", CloseTime = "2023-05-19 03:59:59"}
, 
[815] = {id = 815, orderID = 3, playTypeID = 3, propertyID = 31422, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-05-12 04:00:00", CloseTime = "2023-05-19 03:59:59"}
, 
[816] = {id = 816, orderID = 4, playTypeID = 3, propertyID = 31423, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-05-12 04:00:00", CloseTime = "2023-05-19 03:59:59"}
, 
[817] = {id = 817, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-19 04:00:00", CloseTime = "2023-05-20 03:59:59"}
, 
[818] = {id = 818, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-20 04:00:00", CloseTime = "2023-05-21 03:59:59"}
, 
[819] = {id = 819, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-21 04:00:00", CloseTime = "2023-05-22 03:59:59"}
, 
[820] = {id = 820, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-22 04:00:00", CloseTime = "2023-05-23 03:59:59"}
, 
[821] = {id = 821, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-23 04:00:00", CloseTime = "2023-05-24 03:59:59"}
, 
[822] = {id = 822, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-24 04:00:00", CloseTime = "2023-05-25 03:59:59"}
, 
[823] = {id = 823, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-25 04:00:00", CloseTime = "2023-05-26 03:59:59"}
, 
[824] = {id = 824, orderID = 2, playTypeID = 1, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-19 04:00:00", CloseTime = "2023-05-20 03:59:59"}
, 
[825] = {id = 825, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-20 04:00:00", CloseTime = "2023-05-21 03:59:59"}
, 
[826] = {id = 826, orderID = 2, playTypeID = 1, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-21 04:00:00", CloseTime = "2023-05-22 03:59:59"}
, 
[827] = {id = 827, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-22 04:00:00", CloseTime = "2023-05-23 03:59:59"}
, 
[828] = {id = 828, orderID = 2, playTypeID = 1, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-23 04:00:00", CloseTime = "2023-05-24 03:59:59"}
, 
[829] = {id = 829, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-24 04:00:00", CloseTime = "2023-05-25 03:59:59"}
, 
[830] = {id = 830, orderID = 2, playTypeID = 1, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-25 04:00:00", CloseTime = "2023-05-26 03:59:59"}
, 
[831] = {id = 831, orderID = 3, playTypeID = 1, propertyID = 31418, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-05-19 04:00:00", CloseTime = "2023-05-26 03:59:59"}
, 
[832] = {id = 832, orderID = 4, playTypeID = 1, propertyID = 31419, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-05-19 04:00:00", CloseTime = "2023-05-26 03:59:59"}
, 
[833] = {id = 833, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-26 04:00:00", CloseTime = "2023-05-27 03:59:59"}
, 
[834] = {id = 834, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-27 04:00:00", CloseTime = "2023-05-28 03:59:59"}
, 
[835] = {id = 835, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-28 04:00:00", CloseTime = "2023-05-29 03:59:59"}
, 
[836] = {id = 836, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-29 04:00:00", CloseTime = "2023-05-30 03:59:59"}
, 
[837] = {id = 837, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-30 04:00:00", CloseTime = "2023-05-31 03:59:59"}
, 
[838] = {id = 838, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-05-31 04:00:00", CloseTime = "2023-06-01 03:59:59"}
, 
[839] = {id = 839, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-01 04:00:00", CloseTime = "2023-06-02 03:59:59"}
, 
[840] = {id = 840, orderID = 2, playTypeID = 2, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-26 04:00:00", CloseTime = "2023-05-27 03:59:59"}
, 
[841] = {id = 841, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-27 04:00:00", CloseTime = "2023-05-28 03:59:59"}
, 
[842] = {id = 842, orderID = 2, playTypeID = 2, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-28 04:00:00", CloseTime = "2023-05-29 03:59:59"}
, 
[843] = {id = 843, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-29 04:00:00", CloseTime = "2023-05-30 03:59:59"}
, 
[844] = {id = 844, orderID = 2, playTypeID = 2, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-30 04:00:00", CloseTime = "2023-05-31 03:59:59"}
, 
[845] = {id = 845, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-05-31 04:00:00", CloseTime = "2023-06-01 03:59:59"}
, 
[846] = {id = 846, orderID = 2, playTypeID = 2, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-01 04:00:00", CloseTime = "2023-06-02 03:59:59"}
, 
[847] = {id = 847, orderID = 3, playTypeID = 2, propertyID = 31420, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-05-26 04:00:00", CloseTime = "2023-06-02 03:59:59"}
, 
[848] = {id = 848, orderID = 4, playTypeID = 2, propertyID = 31421, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-05-26 04:00:00", CloseTime = "2023-06-02 03:59:59"}
, 
[849] = {id = 849, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-02 04:00:00", CloseTime = "2023-06-03 03:59:59"}
, 
[850] = {id = 850, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-03 04:00:00", CloseTime = "2023-06-04 03:59:59"}
, 
[851] = {id = 851, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-04 04:00:00", CloseTime = "2023-06-05 03:59:59"}
, 
[852] = {id = 852, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-05 04:00:00", CloseTime = "2023-06-06 03:59:59"}
, 
[853] = {id = 853, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-06 04:00:00", CloseTime = "2023-06-07 03:59:59"}
, 
[854] = {id = 854, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-07 04:00:00", CloseTime = "2023-06-08 03:59:59"}
, 
[855] = {id = 855, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-08 04:00:00", CloseTime = "2023-06-09 03:59:59"}
, 
[856] = {id = 856, orderID = 2, playTypeID = 3, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-02 04:00:00", CloseTime = "2023-06-03 03:59:59"}
, 
[857] = {id = 857, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-03 04:00:00", CloseTime = "2023-06-04 03:59:59"}
, 
[858] = {id = 858, orderID = 2, playTypeID = 3, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-04 04:00:00", CloseTime = "2023-06-05 03:59:59"}
, 
[859] = {id = 859, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-05 04:00:00", CloseTime = "2023-06-06 03:59:59"}
, 
[860] = {id = 860, orderID = 2, playTypeID = 3, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-06 04:00:00", CloseTime = "2023-06-07 03:59:59"}
, 
[861] = {id = 861, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-07 04:00:00", CloseTime = "2023-06-08 03:59:59"}
, 
[862] = {id = 862, orderID = 2, playTypeID = 3, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-08 04:00:00", CloseTime = "2023-06-09 03:59:59"}
, 
[863] = {id = 863, orderID = 3, playTypeID = 3, propertyID = 31422, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-06-02 04:00:00", CloseTime = "2023-06-09 03:59:59"}
, 
[864] = {id = 864, orderID = 4, playTypeID = 3, propertyID = 31423, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-06-02 04:00:00", CloseTime = "2023-06-09 03:59:59"}
, 
[865] = {id = 865, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-09 04:00:00", CloseTime = "2023-06-10 03:59:59"}
, 
[866] = {id = 866, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-10 04:00:00", CloseTime = "2023-06-11 03:59:59"}
, 
[867] = {id = 867, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-11 04:00:00", CloseTime = "2023-06-12 03:59:59"}
, 
[868] = {id = 868, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-12 04:00:00", CloseTime = "2023-06-13 03:59:59"}
, 
[869] = {id = 869, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-13 04:00:00", CloseTime = "2023-06-14 03:59:59"}
, 
[870] = {id = 870, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-14 04:00:00", CloseTime = "2023-06-15 03:59:59"}
, 
[871] = {id = 871, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-15 04:00:00", CloseTime = "2023-06-16 03:59:59"}
, 
[872] = {id = 872, orderID = 2, playTypeID = 1, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-09 04:00:00", CloseTime = "2023-06-10 03:59:59"}
, 
[873] = {id = 873, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-10 04:00:00", CloseTime = "2023-06-11 03:59:59"}
, 
[874] = {id = 874, orderID = 2, playTypeID = 1, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-11 04:00:00", CloseTime = "2023-06-12 03:59:59"}
, 
[875] = {id = 875, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-12 04:00:00", CloseTime = "2023-06-13 03:59:59"}
, 
[876] = {id = 876, orderID = 2, playTypeID = 1, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-13 04:00:00", CloseTime = "2023-06-14 03:59:59"}
, 
[877] = {id = 877, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-14 04:00:00", CloseTime = "2023-06-15 03:59:59"}
, 
[878] = {id = 878, orderID = 2, playTypeID = 1, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-15 04:00:00", CloseTime = "2023-06-16 03:59:59"}
, 
[879] = {id = 879, orderID = 3, playTypeID = 1, propertyID = 31418, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-06-09 04:00:00", CloseTime = "2023-06-16 03:59:59"}
, 
[880] = {id = 880, orderID = 4, playTypeID = 1, propertyID = 31419, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-06-09 04:00:00", CloseTime = "2023-06-16 03:59:59"}
, 
[881] = {id = 881, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-16 04:00:00", CloseTime = "2023-06-17 03:59:59"}
, 
[882] = {id = 882, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-17 04:00:00", CloseTime = "2023-06-18 03:59:59"}
, 
[883] = {id = 883, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-18 04:00:00", CloseTime = "2023-06-19 03:59:59"}
, 
[884] = {id = 884, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-19 04:00:00", CloseTime = "2023-06-20 03:59:59"}
, 
[885] = {id = 885, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-20 04:00:00", CloseTime = "2023-06-21 03:59:59"}
, 
[886] = {id = 886, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-21 04:00:00", CloseTime = "2023-06-22 03:59:59"}
, 
[887] = {id = 887, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-22 04:00:00", CloseTime = "2023-06-23 03:59:59"}
, 
[888] = {id = 888, orderID = 2, playTypeID = 2, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-16 04:00:00", CloseTime = "2023-06-17 03:59:59"}
, 
[889] = {id = 889, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-17 04:00:00", CloseTime = "2023-06-18 03:59:59"}
, 
[890] = {id = 890, orderID = 2, playTypeID = 2, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-18 04:00:00", CloseTime = "2023-06-19 03:59:59"}
, 
[891] = {id = 891, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-19 04:00:00", CloseTime = "2023-06-20 03:59:59"}
, 
[892] = {id = 892, orderID = 2, playTypeID = 2, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-20 04:00:00", CloseTime = "2023-06-21 03:59:59"}
, 
[893] = {id = 893, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-21 04:00:00", CloseTime = "2023-06-22 03:59:59"}
, 
[894] = {id = 894, orderID = 2, playTypeID = 2, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-22 04:00:00", CloseTime = "2023-06-23 03:59:59"}
, 
[895] = {id = 895, orderID = 3, playTypeID = 2, propertyID = 31420, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-06-16 04:00:00", CloseTime = "2023-06-23 03:59:59"}
, 
[896] = {id = 896, orderID = 4, playTypeID = 2, propertyID = 31421, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-06-16 04:00:00", CloseTime = "2023-06-23 03:59:59"}
, 
[897] = {id = 897, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-23 04:00:00", CloseTime = "2023-06-24 03:59:59"}
, 
[898] = {id = 898, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-24 04:00:00", CloseTime = "2023-06-25 03:59:59"}
, 
[899] = {id = 899, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-25 04:00:00", CloseTime = "2023-06-26 03:59:59"}
, 
[900] = {id = 900, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-26 04:00:00", CloseTime = "2023-06-27 03:59:59"}
, 
[901] = {id = 901, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-27 04:00:00", CloseTime = "2023-06-28 03:59:59"}
, 
[902] = {id = 902, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-28 04:00:00", CloseTime = "2023-06-29 03:59:59"}
, 
[903] = {id = 903, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-29 04:00:00", CloseTime = "2023-06-30 03:59:59"}
, 
[904] = {id = 904, orderID = 2, playTypeID = 3, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-23 04:00:00", CloseTime = "2023-06-24 03:59:59"}
, 
[905] = {id = 905, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-24 04:00:00", CloseTime = "2023-06-25 03:59:59"}
, 
[906] = {id = 906, orderID = 2, playTypeID = 3, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-25 04:00:00", CloseTime = "2023-06-26 03:59:59"}
, 
[907] = {id = 907, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-26 04:00:00", CloseTime = "2023-06-27 03:59:59"}
, 
[908] = {id = 908, orderID = 2, playTypeID = 3, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-27 04:00:00", CloseTime = "2023-06-28 03:59:59"}
, 
[909] = {id = 909, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-28 04:00:00", CloseTime = "2023-06-29 03:59:59"}
, 
[910] = {id = 910, orderID = 2, playTypeID = 3, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-29 04:00:00", CloseTime = "2023-06-30 03:59:59"}
, 
[911] = {id = 911, orderID = 3, playTypeID = 3, propertyID = 31422, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-06-23 04:00:00", CloseTime = "2023-06-30 03:59:59"}
, 
[912] = {id = 912, orderID = 4, playTypeID = 3, propertyID = 31423, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-06-23 04:00:00", CloseTime = "2023-06-30 03:59:59"}
, 
[913] = {id = 913, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-06-30 04:00:00", CloseTime = "2023-07-01 03:59:59"}
, 
[914] = {id = 914, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-01 04:00:00", CloseTime = "2023-07-02 03:59:59"}
, 
[915] = {id = 915, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-02 04:00:00", CloseTime = "2023-07-03 03:59:59"}
, 
[916] = {id = 916, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-03 04:00:00", CloseTime = "2023-07-04 03:59:59"}
, 
[917] = {id = 917, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-04 04:00:00", CloseTime = "2023-07-05 03:59:59"}
, 
[918] = {id = 918, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-05 04:00:00", CloseTime = "2023-07-06 03:59:59"}
, 
[919] = {id = 919, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-06 04:00:00", CloseTime = "2023-07-07 03:59:59"}
, 
[920] = {id = 920, orderID = 2, playTypeID = 1, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-06-30 04:00:00", CloseTime = "2023-07-01 03:59:59"}
, 
[921] = {id = 921, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-01 04:00:00", CloseTime = "2023-07-02 03:59:59"}
, 
[922] = {id = 922, orderID = 2, playTypeID = 1, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-02 04:00:00", CloseTime = "2023-07-03 03:59:59"}
, 
[923] = {id = 923, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-03 04:00:00", CloseTime = "2023-07-04 03:59:59"}
, 
[924] = {id = 924, orderID = 2, playTypeID = 1, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-04 04:00:00", CloseTime = "2023-07-05 03:59:59"}
, 
[925] = {id = 925, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-05 04:00:00", CloseTime = "2023-07-06 03:59:59"}
, 
[926] = {id = 926, orderID = 2, playTypeID = 1, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-06 04:00:00", CloseTime = "2023-07-07 03:59:59"}
, 
[927] = {id = 927, orderID = 3, playTypeID = 1, propertyID = 31418, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-06-30 04:00:00", CloseTime = "2023-07-07 03:59:59"}
, 
[928] = {id = 928, orderID = 4, playTypeID = 1, propertyID = 31419, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-06-30 04:00:00", CloseTime = "2023-07-07 03:59:59"}
, 
[929] = {id = 929, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-07 04:00:00", CloseTime = "2023-07-08 03:59:59"}
, 
[930] = {id = 930, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-08 04:00:00", CloseTime = "2023-07-09 03:59:59"}
, 
[931] = {id = 931, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-09 04:00:00", CloseTime = "2023-07-10 03:59:59"}
, 
[932] = {id = 932, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-10 04:00:00", CloseTime = "2023-07-11 03:59:59"}
, 
[933] = {id = 933, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-11 04:00:00", CloseTime = "2023-07-12 03:59:59"}
, 
[934] = {id = 934, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-12 04:00:00", CloseTime = "2023-07-13 03:59:59"}
, 
[935] = {id = 935, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-13 04:00:00", CloseTime = "2023-07-14 03:59:59"}
, 
[936] = {id = 936, orderID = 2, playTypeID = 2, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-07 04:00:00", CloseTime = "2023-07-08 03:59:59"}
, 
[937] = {id = 937, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-08 04:00:00", CloseTime = "2023-07-09 03:59:59"}
, 
[938] = {id = 938, orderID = 2, playTypeID = 2, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-09 04:00:00", CloseTime = "2023-07-10 03:59:59"}
, 
[939] = {id = 939, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-10 04:00:00", CloseTime = "2023-07-11 03:59:59"}
, 
[940] = {id = 940, orderID = 2, playTypeID = 2, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-11 04:00:00", CloseTime = "2023-07-12 03:59:59"}
, 
[941] = {id = 941, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-12 04:00:00", CloseTime = "2023-07-13 03:59:59"}
, 
[942] = {id = 942, orderID = 2, playTypeID = 2, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-13 04:00:00", CloseTime = "2023-07-14 03:59:59"}
, 
[943] = {id = 943, orderID = 3, playTypeID = 2, propertyID = 31420, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-07-07 04:00:00", CloseTime = "2023-07-14 03:59:59"}
, 
[944] = {id = 944, orderID = 4, playTypeID = 2, propertyID = 31421, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-07-07 04:00:00", CloseTime = "2023-07-14 03:59:59"}
, 
[945] = {id = 945, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-14 04:00:00", CloseTime = "2023-07-15 03:59:59"}
, 
[946] = {id = 946, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-15 04:00:00", CloseTime = "2023-07-16 03:59:59"}
, 
[947] = {id = 947, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-16 04:00:00", CloseTime = "2023-07-17 03:59:59"}
, 
[948] = {id = 948, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-17 04:00:00", CloseTime = "2023-07-18 03:59:59"}
, 
[949] = {id = 949, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-18 04:00:00", CloseTime = "2023-07-19 03:59:59"}
, 
[950] = {id = 950, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-19 04:00:00", CloseTime = "2023-07-20 03:59:59"}
, 
[951] = {id = 951, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-20 04:00:00", CloseTime = "2023-07-21 03:59:59"}
, 
[952] = {id = 952, orderID = 2, playTypeID = 3, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-14 04:00:00", CloseTime = "2023-07-15 03:59:59"}
, 
[953] = {id = 953, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-15 04:00:00", CloseTime = "2023-07-16 03:59:59"}
, 
[954] = {id = 954, orderID = 2, playTypeID = 3, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-16 04:00:00", CloseTime = "2023-07-17 03:59:59"}
, 
[955] = {id = 955, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-17 04:00:00", CloseTime = "2023-07-18 03:59:59"}
, 
[956] = {id = 956, orderID = 2, playTypeID = 3, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-18 04:00:00", CloseTime = "2023-07-19 03:59:59"}
, 
[957] = {id = 957, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-19 04:00:00", CloseTime = "2023-07-20 03:59:59"}
, 
[958] = {id = 958, orderID = 2, playTypeID = 3, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-20 04:00:00", CloseTime = "2023-07-21 03:59:59"}
, 
[959] = {id = 959, orderID = 3, playTypeID = 3, propertyID = 31422, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-07-14 04:00:00", CloseTime = "2023-07-21 03:59:59"}
, 
[960] = {id = 960, orderID = 4, playTypeID = 3, propertyID = 31423, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-07-14 04:00:00", CloseTime = "2023-07-21 03:59:59"}
, 
[961] = {id = 961, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-21 04:00:00", CloseTime = "2023-07-22 03:59:59"}
, 
[962] = {id = 962, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-22 04:00:00", CloseTime = "2023-07-23 03:59:59"}
, 
[963] = {id = 963, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-23 04:00:00", CloseTime = "2023-07-24 03:59:59"}
, 
[964] = {id = 964, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-24 04:00:00", CloseTime = "2023-07-25 03:59:59"}
, 
[965] = {id = 965, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-25 04:00:00", CloseTime = "2023-07-26 03:59:59"}
, 
[966] = {id = 966, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-26 04:00:00", CloseTime = "2023-07-27 03:59:59"}
, 
[967] = {id = 967, orderID = 1, playTypeID = 1, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-27 04:00:00", CloseTime = "2023-07-28 03:59:59"}
, 
[968] = {id = 968, orderID = 2, playTypeID = 1, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-21 04:00:00", CloseTime = "2023-07-22 03:59:59"}
, 
[969] = {id = 969, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-22 04:00:00", CloseTime = "2023-07-23 03:59:59"}
, 
[970] = {id = 970, orderID = 2, playTypeID = 1, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-23 04:00:00", CloseTime = "2023-07-24 03:59:59"}
, 
[971] = {id = 971, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-24 04:00:00", CloseTime = "2023-07-25 03:59:59"}
, 
[972] = {id = 972, orderID = 2, playTypeID = 1, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-25 04:00:00", CloseTime = "2023-07-26 03:59:59"}
, 
[973] = {id = 973, orderID = 2, playTypeID = 1, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-26 04:00:00", CloseTime = "2023-07-27 03:59:59"}
, 
[974] = {id = 974, orderID = 2, playTypeID = 1, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-27 04:00:00", CloseTime = "2023-07-28 03:59:59"}
, 
[975] = {id = 975, orderID = 3, playTypeID = 1, propertyID = 31418, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-07-21 04:00:00", CloseTime = "2023-07-28 03:59:59"}
, 
[976] = {id = 976, orderID = 4, playTypeID = 1, propertyID = 31419, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-07-21 04:00:00", CloseTime = "2023-07-28 03:59:59"}
, 
[977] = {id = 977, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-28 04:00:00", CloseTime = "2023-07-29 03:59:59"}
, 
[978] = {id = 978, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-29 04:00:00", CloseTime = "2023-07-30 03:59:59"}
, 
[979] = {id = 979, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-30 04:00:00", CloseTime = "2023-07-31 03:59:59"}
, 
[980] = {id = 980, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-07-31 04:00:00", CloseTime = "2023-08-01 03:59:59"}
, 
[981] = {id = 981, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-08-01 04:00:00", CloseTime = "2023-08-02 03:59:59"}
, 
[982] = {id = 982, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-08-02 04:00:00", CloseTime = "2023-08-03 03:59:59"}
, 
[983] = {id = 983, orderID = 1, playTypeID = 2, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2023-08-03 04:00:00", CloseTime = "2023-08-04 03:59:59"}
, 
[984] = {id = 984, orderID = 2, playTypeID = 2, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-28 04:00:00", CloseTime = "2023-07-29 03:59:59"}
, 
[985] = {id = 985, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-29 04:00:00", CloseTime = "2023-07-30 03:59:59"}
, 
[986] = {id = 986, orderID = 2, playTypeID = 2, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-30 04:00:00", CloseTime = "2023-07-31 03:59:59"}
, 
[987] = {id = 987, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-07-31 04:00:00", CloseTime = "2023-08-01 03:59:59"}
, 
[988] = {id = 988, orderID = 2, playTypeID = 2, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-08-01 04:00:00", CloseTime = "2023-08-02 03:59:59"}
, 
[989] = {id = 989, orderID = 2, playTypeID = 2, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-08-02 04:00:00", CloseTime = "2023-08-03 03:59:59"}
, 
[990] = {id = 990, orderID = 2, playTypeID = 2, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2023-08-03 04:00:00", CloseTime = "2023-08-04 03:59:59"}
, 
[991] = {id = 991, orderID = 3, playTypeID = 2, propertyID = 31420, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2023-07-28 04:00:00", CloseTime = "2023-08-04 03:59:59"}
, 
[992] = {id = 992, orderID = 4, playTypeID = 2, propertyID = 31421, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2023-07-28 04:00:00", CloseTime = "2023-08-04 03:59:59"}
, 
[993] = {id = 993, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2024-03-21 04:00:00", CloseTime = "2024-03-22 03:59:59"}
, 
[994] = {id = 994, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2024-03-22 04:00:00", CloseTime = "2024-03-23 03:59:59"}
, 
[995] = {id = 995, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2024-03-23 04:00:00", CloseTime = "2024-03-24 03:59:59"}
, 
[996] = {id = 996, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2024-03-24 04:00:00", CloseTime = "2024-03-25 03:59:59"}
, 
[997] = {id = 997, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2024-03-25 04:00:00", CloseTime = "2024-03-26 03:59:59"}
, 
[998] = {id = 998, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2024-03-26 04:00:00", CloseTime = "2024-03-27 03:59:59"}
, 
[999] = {id = 999, orderID = 1, playTypeID = 3, propertyID = 31363, packageNum = 1, stock = 1, moneyType = 35001, price = 0, discount = -1, discountPrice = 0, OpenTime = "2024-03-27 04:00:00", CloseTime = "2024-03-28 03:59:59"}
, 
[1000] = {id = 1000, orderID = 2, playTypeID = 3, propertyID = 31414, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2024-03-21 04:00:00", CloseTime = "2024-03-22 03:59:59"}
, 
[1001] = {id = 1001, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2024-03-22 04:00:00", CloseTime = "2024-03-23 03:59:59"}
, 
[1002] = {id = 1002, orderID = 2, playTypeID = 3, propertyID = 31415, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2024-03-23 04:00:00", CloseTime = "2024-03-24 03:59:59"}
, 
[1003] = {id = 1003, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2024-03-24 04:00:00", CloseTime = "2024-03-25 03:59:59"}
, 
[1004] = {id = 1004, orderID = 2, playTypeID = 3, propertyID = 31416, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2024-03-25 04:00:00", CloseTime = "2024-03-26 03:59:59"}
, 
[1005] = {id = 1005, orderID = 2, playTypeID = 3, propertyID = 31364, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2024-03-26 04:00:00", CloseTime = "2024-03-27 03:59:59"}
, 
[1006] = {id = 1006, orderID = 2, playTypeID = 3, propertyID = 31417, packageNum = 1, stock = 1, moneyType = 35001, price = 30, discount = 2, discountPrice = 6, OpenTime = "2024-03-27 04:00:00", CloseTime = "2024-03-28 03:59:59"}
, 
[1007] = {id = 1007, orderID = 3, playTypeID = 3, propertyID = 31422, packageNum = 1, stock = 1, moneyType = 35001, price = 100, discount = 3, discountPrice = 30, OpenTime = "2024-03-21 04:00:00", CloseTime = "2024-08-31 03:59:59"}
, 
[1008] = {id = 1008, orderID = 4, playTypeID = 3, propertyID = 31423, packageNum = 1, stock = 1, moneyType = 35001, price = 250, discount = 4, discountPrice = 98, OpenTime = "2024-03-21 04:00:00", CloseTime = "2024-08-31 03:59:59"}
}
cpackage.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 497, 498, 499, 500, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511, 512, 513, 514, 515, 516, 517, 518, 519, 520, 521, 522, 523, 524, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 549, 550, 551, 552, 553, 554, 555, 556, 557, 558, 559, 560, 561, 562, 563, 564, 565, 566, 567, 568, 569, 570, 571, 572, 573, 574, 575, 576, 577, 578, 579, 580, 581, 582, 583, 584, 585, 586, 587, 588, 589, 590, 591, 592, 593, 594, 595, 596, 597, 598, 599, 600, 601, 602, 603, 604, 605, 606, 607, 608, 609, 610, 611, 612, 613, 614, 615, 616, 617, 618, 619, 620, 621, 622, 623, 624, 625, 626, 627, 628, 629, 630, 631, 632, 633, 634, 635, 636, 637, 638, 639, 640, 641, 642, 643, 644, 645, 646, 647, 648, 649, 650, 651, 652, 653, 654, 655, 656, 657, 658, 659, 660, 661, 662, 663, 664, 665, 666, 667, 668, 669, 670, 671, 672, 673, 674, 675, 676, 677, 678, 679, 680, 681, 682, 683, 684, 685, 686, 687, 688, 689, 690, 691, 692, 693, 694, 695, 696, 697, 698, 699, 700, 701, 702, 703, 704, 705, 706, 707, 708, 709, 710, 711, 712, 713, 714, 715, 716, 717, 718, 719, 720, 721, 722, 723, 724, 725, 726, 727, 728, 729, 730, 731, 732, 733, 734, 735, 736, 737, 738, 739, 740, 741, 742, 743, 744, 745, 746, 747, 748, 749, 750, 751, 752, 753, 754, 755, 756, 757, 758, 759, 760, 761, 762, 763, 764, 765, 766, 767, 768, 769, 770, 771, 772, 773, 774, 775, 776, 777, 778, 779, 780, 781, 782, 783, 784, 785, 786, 787, 788, 789, 790, 791, 792, 793, 794, 795, 796, 797, 798, 799, 800, 801, 802, 803, 804, 805, 806, 807, 808, 809, 810, 811, 812, 813, 814, 815, 816, 817, 818, 819, 820, 821, 822, 823, 824, 825, 826, 827, 828, 829, 830, 831, 832, 833, 834, 835, 836, 837, 838, 839, 840, 841, 842, 843, 844, 845, 846, 847, 848, 849, 850, 851, 852, 853, 854, 855, 856, 857, 858, 859, 860, 861, 862, 863, 864, 865, 866, 867, 868, 869, 870, 871, 872, 873, 874, 875, 876, 877, 878, 879, 880, 881, 882, 883, 884, 885, 886, 887, 888, 889, 890, 891, 892, 893, 894, 895, 896, 897, 898, 899, 900, 901, 902, 903, 904, 905, 906, 907, 908, 909, 910, 911, 912, 913, 914, 915, 916, 917, 918, 919, 920, 921, 922, 923, 924, 925, 926, 927, 928, 929, 930, 931, 932, 933, 934, 935, 936, 937, 938, 939, 940, 941, 942, 943, 944, 945, 946, 947, 948, 949, 950, 951, 952, 953, 954, 955, 956, 957, 958, 959, 960, 961, 962, 963, 964, 965, 966, 967, 968, 969, 970, 971, 972, 973, 974, 975, 976, 977, 978, 979, 980, 981, 982, 983, 984, 985, 986, 987, 988, 989, 990, 991, 992, 993, 994, 995, 996, 997, 998, 999, 1000, 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008}
return cpackage

