-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/recharge/cshoptypeconfig.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cshoptypeconfig = {}
cshoptypeconfig.Data = {
[1] = {id = 1, ShopType = 1, Name = "月卡", NameTextID = 1100022, Image = 12206, ImageSelect = 12207, OpenTime = "0", CloseTime = "0", Giftdollid = 0}
, 
[2] = {id = 2, ShopType = 1, Name = "首充赠礼", NameTextID = 1100023, Image = 12202, ImageSelect = 12203, OpenTime = "0", CloseTime = "0", Giftdollid = 0}
, 
[3] = {id = 3, ShopType = 5, Name = "灵魂商店", NameTextID = 1100066, Image = 12434, ImageSelect = 12435, OpenTime = "2000-03-16 12:00:00", CloseTime = "2000-04-22 12:00:00", Giftdollid = 0}
, 
[4] = {id = 4, ShopType = 2, Name = "钻石", NameTextID = 1100004, Image = 12430, ImageSelect = 12431, OpenTime = "0", CloseTime = "0", Giftdollid = 0}
, 
[5] = {id = 5, ShopType = 3, Name = "限时礼包", NameTextID = 1100005, Image = 12202, ImageSelect = 12203, OpenTime = "0", CloseTime = "0", Giftdollid = 0}
, 
[6] = {id = 6, ShopType = 4, Name = "新品", NameTextID = 1100006, Image = 12214, ImageSelect = 12215, OpenTime = "0", CloseTime = "0", Giftdollid = 0}
, 
[7] = {id = 7, ShopType = 5, Name = "白花瓣", NameTextID = 1100007, Image = 12208, ImageSelect = 12209, OpenTime = "0", CloseTime = "0", Giftdollid = 0}
, 
[8] = {id = 8, ShopType = 5, Name = "金花瓣", NameTextID = 1100008, Image = 12208, ImageSelect = 12209, OpenTime = "0", CloseTime = "0", Giftdollid = 0}
, 
[9] = {id = 9, ShopType = 5, Name = "友情点", NameTextID = 1100009, Image = 12212, ImageSelect = 12213, OpenTime = "0", CloseTime = "0", Giftdollid = 0}
, 
[10] = {id = 10, ShopType = 100, Name = "春节限时", NameTextID = 1100010, Image = 0, ImageSelect = 0, OpenTime = "2020-03-16 12:00:00", CloseTime = "2020-04-22 12:00:00", Giftdollid = 0}
, 
[11] = {id = 11, ShopType = 2001, Name = "铸币馆", NameTextID = 1100011, Image = 0, ImageSelect = 0, OpenTime = "2020-02-20 12:00:00", CloseTime = "2020-04-20 12:00:00", Giftdollid = 0}
, 
[12] = {id = 12, ShopType = 2002, Name = "铸币馆", NameTextID = 1100012, Image = 0, ImageSelect = 0, OpenTime = "2020-04-21 12:00:00", CloseTime = "2020-05-20 12:00:00", Giftdollid = 0}
, 
[13] = {id = 13, ShopType = 5, Name = "家具", NameTextID = 1100013, Image = 12210, ImageSelect = 12211, OpenTime = "0", CloseTime = "0", Giftdollid = 0}
, 
[15] = {id = 15, ShopType = 4, Name = "已购外观", NameTextID = 1100026, Image = 12218, ImageSelect = 12219, OpenTime = "0", CloseTime = "0", Giftdollid = 0}
, 
[16] = {id = 16, ShopType = 7, Name = "人偶装备", NameTextID = 1100029, Image = 12202, ImageSelect = 12203, OpenTime = "0", CloseTime = "0", Giftdollid = 0}
, 
[17] = {id = 17, ShopType = 7, Name = "时空裂隙", NameTextID = 1100039, Image = 12204, ImageSelect = 12205, OpenTime = "2021-06-24 04:00:00", CloseTime = "2021-08-12 04:00:00", Giftdollid = 0}
, 
[18] = {id = 18, ShopType = 1, Name = "成长基金", NameTextID = 1100050, Image = 12204, ImageSelect = 12205, OpenTime = "0", CloseTime = "0", Giftdollid = 0}
, 
[19] = {id = 19, ShopType = 2, Name = "灵魂", NameTextID = 1100064, Image = 12434, ImageSelect = 12435, OpenTime = "0", CloseTime = "0", Giftdollid = 0}
, 
[20] = {id = 20, ShopType = 3, Name = "月度礼包", NameTextID = 1100065, Image = 12204, ImageSelect = 12205, OpenTime = "0", CloseTime = "0", Giftdollid = 0}
, 
[21] = {id = 21, ShopType = 8, Name = "星辰幻镜简单商店", NameTextID = 1100067, Image = 0, ImageSelect = 0, OpenTime = "2021-06-24 04:00:00", CloseTime = "2021-08-12 04:00:00", Giftdollid = 42}
, 
[22] = {id = 22, ShopType = 8, Name = "星辰幻镜强化商店", NameTextID = 1100068, Image = 0, ImageSelect = 0, OpenTime = "2021-06-24 04:00:00", CloseTime = "2021-08-12 04:00:00", Giftdollid = 42}
, 
[23] = {id = 23, ShopType = 1, Name = "梦境螺旋", NameTextID = 1100069, Image = 12206, ImageSelect = 12207, OpenTime = "0", CloseTime = "0", Giftdollid = 0}
, 
[24] = {id = 24, ShopType = 5, Name = "公会商城", NameTextID = 1100076, Image = 12208, ImageSelect = 12215, OpenTime = "0", CloseTime = "0", Giftdollid = 0}
, 
[25] = {id = 25, ShopType = 7, Name = "专属装备", NameTextID = 1100077, Image = 12202, ImageSelect = 12203, OpenTime = "0", CloseTime = "0", Giftdollid = 0}
, 
[26] = {id = 26, ShopType = 8, Name = "泳装活动小卖部", NameTextID = 1100078, Image = 0, ImageSelect = 0, OpenTime = "2022-09-29 04:00:00", CloseTime = "2022-10-13 04:00:00", Giftdollid = 0}
, 
[27] = {id = 27, ShopType = 8, Name = "万圣活动商城", NameTextID = 1100079, Image = 0, ImageSelect = 0, OpenTime = "2021-10-28 04:00:00", CloseTime = "2021-11-11 04:00:00", Giftdollid = 0}
, 
[28] = {id = 28, ShopType = 8, Name = "圣诞活动表现力", NameTextID = 1100079, Image = 0, ImageSelect = 0, OpenTime = "2021-11-02 04:00:00", CloseTime = "2021-12-23 04:00:00", Giftdollid = 0}
, 
[29] = {id = 29, ShopType = 8, Name = "圣诞活动歌唱力", NameTextID = 1100080, Image = 0, ImageSelect = 0, OpenTime = "2021-11-02 04:00:00", CloseTime = "2021-12-23 04:00:00", Giftdollid = 0}
, 
[30] = {id = 30, ShopType = 8, Name = "圣诞活动跃动感", NameTextID = 1100081, Image = 0, ImageSelect = 0, OpenTime = "2021-11-02 04:00:00", CloseTime = "2021-12-23 04:00:00", Giftdollid = 0}
, 
[31] = {id = 31, ShopType = 8, Name = "登录互动活动-诞生日快乐商城", NameTextID = 1100082, Image = 0, ImageSelect = 0, OpenTime = "2021-11-25 15:00:00", CloseTime = "2021-12-09 15:00:00", Giftdollid = 0}
, 
[32] = {id = 32, ShopType = 8, Name = "回归礼包商城", NameTextID = 1100082, Image = 0, ImageSelect = 0, OpenTime = "2021-11-25 15:00:00", CloseTime = "2021-12-23 04:00:00", Giftdollid = 0}
, 
[33] = {id = 33, ShopType = 8, Name = "圣诞应援商城", NameTextID = 1100083, Image = 0, ImageSelect = 0, OpenTime = "2021-10-23 15:00:00", CloseTime = "2022-01-06 04:00:00", Giftdollid = 0}
, 
[34] = {id = 34, ShopType = 8, Name = "春节活动商城", NameTextID = 1100083, Image = 0, ImageSelect = 0, OpenTime = "2022-01-27 04:00:00", CloseTime = "2022-02-10 03:59:59", Giftdollid = 0}
, 
[35] = {id = 35, ShopType = 8, Name = "情人节活动商城-小镇通币", NameTextID = 1100084, Image = 0, ImageSelect = 0, OpenTime = "2022-02-10 16:00:00", CloseTime = "2022-03-03 03:59:59", Giftdollid = 0}
, 
[36] = {id = 36, ShopType = 8, Name = "情人节活动商城-巧克力", NameTextID = 1100085, Image = 0, ImageSelect = 0, OpenTime = "2022-02-10 16:00:00", CloseTime = "2022-03-03 03:59:59", Giftdollid = 0}
, 
[38] = {id = 38, ShopType = 8, Name = "愚人节活动——精品商城", NameTextID = 1100079, Image = 0, ImageSelect = 0, OpenTime = "2022-01-18 04:00:00", CloseTime = "2022-02-01 03:59:59", Giftdollid = 0}
, 
[39] = {id = 39, ShopType = 8, Name = "愚人节活动——红小丑币", NameTextID = 1100079, Image = 0, ImageSelect = 0, OpenTime = "2022-01-18 04:00:00", CloseTime = "2022-04-14 03:59:59", Giftdollid = 0}
, 
[40] = {id = 40, ShopType = 8, Name = "愚人节活动——蓝小丑币", NameTextID = 1100079, Image = 0, ImageSelect = 0, OpenTime = "2022-01-18 04:00:00", CloseTime = "2022-04-14 03:59:59", Giftdollid = 0}
, 
[41] = {id = 41, ShopType = 8, Name = "儿童节活动商城", NameTextID = 1100079, Image = 0, ImageSelect = 0, OpenTime = "2022-01-28 04:00:00", CloseTime = "2022-05-26 03:59:59", Giftdollid = 0}
, 
[42] = {id = 42, ShopType = 8, Name = "端午节商城", NameTextID = 1100080, Image = 0, ImageSelect = 0, OpenTime = "2022-01-28 04:00:00", CloseTime = "2022-06-02 03:59:59", Giftdollid = 0}
, 
[43] = {id = 43, ShopType = 8, Name = "时之赠礼第一期——精品礼包", NameTextID = 1100087, Image = 0, ImageSelect = 0, OpenTime = "2022-05-26 04:00:00", CloseTime = "2022-06-16 03:59:59", Giftdollid = 0}
, 
[44] = {id = 44, ShopType = 8, Name = "周年庆活动简单商店", NameTextID = 1100067, Image = 0, ImageSelect = 0, OpenTime = "2021-06-24 04:00:00", CloseTime = "2022-07-21 04:00:00", Giftdollid = 42}
, 
[45] = {id = 45, ShopType = 8, Name = "周年庆活动强化商店", NameTextID = 1100068, Image = 0, ImageSelect = 0, OpenTime = "2021-06-24 04:00:00", CloseTime = "2022-07-21 04:00:00", Giftdollid = 42}
, 
[46] = {id = 46, ShopType = 3, Name = "每周礼包", NameTextID = 1100090, Image = 12204, ImageSelect = 12205, OpenTime = "0", CloseTime = "0", Giftdollid = 0}
, 
[47] = {id = 47, ShopType = 8, Name = "周年庆抽卡商城", NameTextID = 1100079, Image = 0, ImageSelect = 0, OpenTime = "2021-06-24 04:00:00", CloseTime = "2021-06-08 04:00:00", Giftdollid = 0}
, 
[48] = {id = 48, ShopType = 8, Name = "通用人民币付费商城", NameTextID = 1100079, Image = 0, ImageSelect = 0, OpenTime = "2021-06-24 04:00:00", CloseTime = "2021-06-08 04:00:00", Giftdollid = 0}
, 
[49] = {id = 49, ShopType = 1, Name = "精神之证", NameTextID = 1100092, Image = 12206, ImageSelect = 12207, OpenTime = "0", CloseTime = "0", Giftdollid = 0}
, 
[50] = {id = 50, ShopType = 2, Name = "权益服务", NameTextID = 1100093, Image = 12430, ImageSelect = 12431, OpenTime = "0", CloseTime = "0", Giftdollid = 0}
, 
[51] = {id = 51, ShopType = 8, Name = "夏日回响-礼包商城", NameTextID = 1100094, Image = 0, ImageSelect = 0, OpenTime = "2022-09-08 04:00:00", CloseTime = "2022-09-22 03:59:59", Giftdollid = 0}
, 
[52] = {id = 52, ShopType = 8, Name = "夏日回响-初级商店", NameTextID = 1100094, Image = 0, ImageSelect = 0, OpenTime = "2022-09-08 04:00:00", CloseTime = "2022-09-29 03:59:59", Giftdollid = 0}
, 
[53] = {id = 53, ShopType = 8, Name = "夏日回响-高级商店", NameTextID = 1100094, Image = 0, ImageSelect = 0, OpenTime = "2022-09-15 04:00:00", CloseTime = "2022-09-29 03:59:59", Giftdollid = 0}
, 
[54] = {id = 54, ShopType = 8, Name = "星辰幻镜复刻简单商店", NameTextID = 1100067, Image = 0, ImageSelect = 0, OpenTime = "2022-06-24 04:00:00", CloseTime = "2022-09-29 04:00:00", Giftdollid = 42}
, 
[55] = {id = 55, ShopType = 8, Name = "星辰幻镜复刻强化商店", NameTextID = 1100068, Image = 0, ImageSelect = 0, OpenTime = "2022-06-24 04:00:00", CloseTime = "2022-09-29 04:00:00", Giftdollid = 42}
, 
[56] = {id = 56, ShopType = 8, Name = "星辰幻镜复刻礼包商城", NameTextID = 1100079, Image = 0, ImageSelect = 0, OpenTime = "2022-06-24 04:00:00", CloseTime = "2022-09-29 04:00:00", Giftdollid = 0}
, 
[57] = {id = 57, ShopType = 8, Name = "海岛冒险复刻-海岛宝藏", NameTextID = 1100095, Image = 0, ImageSelect = 0, OpenTime = "2021-06-24 04:00:00", CloseTime = "2022-10-13 04:00:00", Giftdollid = 0}
, 
[58] = {id = 58, ShopType = 8, Name = "感恩节活动商城-丰满谷仓", NameTextID = 1100096, Image = 0, ImageSelect = 0, OpenTime = "2022-11-24 04:00:00", CloseTime = "2022-12-08 04:00:00", Giftdollid = 0}
, 
[59] = {id = 59, ShopType = 8, Name = "双十一活动商城", NameTextID = 1100097, Image = 0, ImageSelect = 0, OpenTime = "2021-10-11 04:00:00", CloseTime = "2022-11-24 03:59:59", Giftdollid = 0}
}
cshoptypeconfig.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59}
return cshoptypeconfig

