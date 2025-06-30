-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/mission/cchildrensdaymission.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cchildrensdaymission = {}
cchildrensdaymission.Data = {
[150001] = {id = 150001, sortid = 1, missionname = "每日登录", missionnameTextID = 1001627, missiontype = 15, jumptype = 0, 
jumpvalue = {0}
, UIjumpvalue = 0, description = "每日登录游戏", descriptionTextID = 1001642, endevent = 1, 
progresspath = {"1,1"}
, rewardid = 3749, 
rewarditem = {35055}
, 
rewardquantity = {10}
}
, 
[150002] = {id = 150002, sortid = 2, missionname = "异界之镜", missionnameTextID = 1001628, missiontype = 15, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 24, description = "异界之镜收取1次奖励", descriptionTextID = 1001643, endevent = 14, 
progresspath = {"14,1"}
, rewardid = 3750, 
rewarditem = {35055}
, 
rewardquantity = {20}
}
, 
[150003] = {id = 150003, sortid = 2, missionname = "魔女小屋", missionnameTextID = 1001629, missiontype = 15, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 23, description = "魔女小屋中入驻1次人偶", descriptionTextID = 1001644, endevent = 5, 
progresspath = {"5,1"}
, rewardid = 3750, 
rewarditem = {35055}
, 
rewardquantity = {20}
}
, 
[150004] = {id = 150004, sortid = 2, missionname = "友谊万岁", missionnameTextID = 1001630, missiontype = 15, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 25, description = "使用友情点购买1次商品", descriptionTextID = 1001645, endevent = 6, 
progresspath = {"6,1"}
, rewardid = 3750, 
rewarditem = {35055}
, 
rewardquantity = {20}
}
, 
[150005] = {id = 150005, sortid = 2, missionname = "予人玫瑰", missionnameTextID = 1001631, missiontype = 15, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 26, description = "向任意人偶赠送1次礼物", descriptionTextID = 1001646, endevent = 8, 
progresspath = {"8,1"}
, rewardid = 3750, 
rewarditem = {35055}
, 
rewardquantity = {20}
}
, 
[150006] = {id = 150006, sortid = 2, missionname = "装备强化", missionnameTextID = 1001632, missiontype = 15, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 1, description = "装备强化1次", descriptionTextID = 1001647, endevent = 9, 
progresspath = {"9,1"}
, rewardid = 3750, 
rewarditem = {35055}
, 
rewardquantity = {20}
}
, 
[150007] = {id = 150007, sortid = 2, missionname = "精神抖擞", missionnameTextID = 1001633, missiontype = 15, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "消耗30点精神", descriptionTextID = 1001648, endevent = 12, 
progresspath = {"12,1"}
, rewardid = 3750, 
rewarditem = {35055}
, 
rewardquantity = {20}
}
, 
[150008] = {id = 150008, sortid = 2, missionname = "属性增强", missionnameTextID = 1001634, missiontype = 15, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 2, description = "任意强化1次人偶", descriptionTextID = 1001649, endevent = 11, 
progresspath = {"11,1"}
, rewardid = 3750, 
rewarditem = {35055}
, 
rewardquantity = {20}
}
, 
[150009] = {id = 150009, sortid = 3, missionname = "人偶召唤", missionnameTextID = 1001635, missiontype = 15, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 5, description = "进行1次人偶召唤", descriptionTextID = 1001650, endevent = 13, 
progresspath = {"13,1"}
, rewardid = 3751, 
rewarditem = {35055}
, 
rewardquantity = {20}
}
, 
[150010] = {id = 150010, sortid = 3, missionname = "时空裂隙", missionnameTextID = 1001636, missiontype = 15, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 22, description = "完成1次时空裂隙", descriptionTextID = 1001651, endevent = 15, 
progresspath = {"15,1"}
, rewardid = 3751, 
rewarditem = {35055}
, 
rewardquantity = {20}
}
, 
[150011] = {id = 150011, sortid = 3, missionname = "玛那副本", missionnameTextID = 1001637, missiontype = 15, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 17, description = "完成3次玛那副本", descriptionTextID = 1001652, endevent = 2, 
progresspath = {"2,1"}
, rewardid = 3751, 
rewarditem = {35055}
, 
rewardquantity = {20}
}
, 
[150012] = {id = 150012, sortid = 3, missionname = "突破副本", missionnameTextID = 1001638, missiontype = 15, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 17, description = "完成3次突破副本", descriptionTextID = 1001653, endevent = 4, 
progresspath = {"4,1"}
, rewardid = 3751, 
rewarditem = {35055}
, 
rewardquantity = {20}
}
, 
[150013] = {id = 150013, sortid = 3, missionname = "技能副本", missionnameTextID = 1001639, missiontype = 15, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 17, description = "完成3次技能副本", descriptionTextID = 1001655, endevent = 10, 
progresspath = {"10,1"}
, rewardid = 3751, 
rewarditem = {35055}
, 
rewardquantity = {20}
}
, 
[150014] = {id = 150014, sortid = 3, missionname = "装备副本", missionnameTextID = 1001640, missiontype = 15, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 17, description = "完成3次装备副本", descriptionTextID = 1001654, endevent = 7, 
progresspath = {"7,1"}
, rewardid = 3751, 
rewarditem = {35055}
, 
rewardquantity = {20}
}
, 
[150015] = {id = 150015, sortid = 3, missionname = "主线关卡", missionnameTextID = 1001641, missiontype = 15, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "通过1次主线关卡", descriptionTextID = 1001656, endevent = 3, 
progresspath = {"3,1"}
, rewardid = 3751, 
rewarditem = {35055}
, 
rewardquantity = {20}
}
}
cchildrensdaymission.AllIds = {150001, 150002, 150003, 150004, 150005, 150006, 150007, 150008, 150009, 150010, 150011, 150012, 150013, 150014, 150015}
return cchildrensdaymission

