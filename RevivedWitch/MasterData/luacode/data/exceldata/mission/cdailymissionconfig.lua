-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/mission/cdailymissionconfig.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cdailymissionconfig = {}
cdailymissionconfig.Data = {
[30010] = {id = 30010, sortid = 1, missionname = "每日登录", missionnameTextID = 1001138, missiontype = 3, targettype = 1, jumptype = 0, 
jumpvalue = {0}
, UIjumpvalue = 1, description = "每日登录游戏", descriptionTextID = 1001142, endevent = 22, 
toptip = {200006}
, 
progressname = {"登录游戏"}
, 
progressnameTextID = {1001147}
, instruction = "登录游戏。", instructionTextID = 1001150, rewardid = 1288, 
rewarditem = {}
, 
rewardquantity = {}
, unlockcondition = "-1,-1", activevalue = 10, unlockid = 1001198}
, 
[30011] = {id = 30011, sortid = 2, missionname = "时之塔", missionnameTextID = 1000232, missiontype = 3, targettype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "通关3次主线关卡", descriptionTextID = 1000244, endevent = 1, 
toptip = {200007}
, 
progressname = {"通关主线关卡"}
, 
progressnameTextID = {1000256}
, instruction = "继续向前探索，通关主线关卡。", instructionTextID = 1000268, rewardid = 1288, 
rewarditem = {}
, 
rewardquantity = {}
, unlockcondition = "2,4", activevalue = 10, unlockid = 1001199}
, 
[30012] = {id = 30012, sortid = 3, missionname = "精力充沛·一", missionnameTextID = 1001139, missiontype = 3, targettype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "消耗60点精神", descriptionTextID = 1001143, endevent = 25, 
toptip = {200008}
, 
progressname = {"消耗精神"}
, 
progressnameTextID = {1000265}
, instruction = "精神是支撑魔女前进的动力，探索地宫需要消耗精神。", instructionTextID = 1000277, rewardid = 1288, 
rewarditem = {}
, 
rewardquantity = {}
, unlockcondition = "2,4", activevalue = 10, unlockid = 1001200}
, 
[30013] = {id = 30013, sortid = 4, missionname = "精力充沛·二", missionnameTextID = 1000241, missiontype = 3, targettype = 13, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "消耗100点精神", descriptionTextID = 1000253, endevent = 10, 
toptip = {200009}
, 
progressname = {"消耗精神"}
, 
progressnameTextID = {1000265}
, instruction = "精神是支撑魔女前进的动力，探索地宫需要消耗精神。", instructionTextID = 1000277, rewardid = 1288, 
rewarditem = {}
, 
rewardquantity = {}
, unlockcondition = "2,4", activevalue = 20, unlockid = 1001201}
, 
[30014] = {id = 30014, sortid = 5, missionname = "人偶强化", missionnameTextID = 1000236, missiontype = 3, targettype = 5, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 2, description = "消耗玛那提升任意人偶的强化等级1次", descriptionTextID = 1000248, endevent = 26, 
toptip = {200010}
, 
progressname = {"人偶强化"}
, 
progressnameTextID = {1000260}
, instruction = "消耗玛那可以快速提升人偶的强化等级。", instructionTextID = 1000272, rewardid = 1288, 
rewarditem = {}
, 
rewardquantity = {}
, unlockcondition = "2,4", activevalue = 10, unlockid = 1001202}
, 
[30015] = {id = 30015, sortid = 6, missionname = "传达心意", missionnameTextID = 1000237, missiontype = 3, targettype = 6, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 26, description = "向任意人偶赠送1次礼物", descriptionTextID = 1000249, endevent = 6, 
toptip = {200011}
, 
progressname = {"赠送礼物"}
, 
progressnameTextID = {1000261}
, instruction = "向人偶赠送心仪的礼物可以提升羁绊等级。", instructionTextID = 1000273, rewardid = 1288, 
rewarditem = {}
, 
rewardquantity = {}
, unlockcondition = "2,4", activevalue = 10, unlockid = 1001203}
, 
[30016] = {id = 30016, sortid = 7, missionname = "装备强化", missionnameTextID = 1000238, missiontype = 3, targettype = 6, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 1, description = "装备强化1次", descriptionTextID = 1000250, endevent = 7, 
toptip = {200012}
, 
progressname = {"装备强化"}
, 
progressnameTextID = {1000262}
, instruction = "消耗某些素材可以对装备进行强化。", instructionTextID = 1000274, rewardid = 1288, 
rewarditem = {}
, 
rewardquantity = {}
, unlockcondition = "2,4", activevalue = 10, unlockid = 1001204}
, 
[30017] = {id = 30017, sortid = 8, missionname = "委派探索", missionnameTextID = 1000240, missiontype = 3, targettype = 3, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 24, description = "在魔女庭院探索1次异界之镜", descriptionTextID = 1000252, endevent = 9, 
toptip = {200013}
, 
progressname = {"派遣探索"}
, 
progressnameTextID = {1000264}
, instruction = "在庭院中可以派遣人偶探索异界之镜，带回丰富的素材。", instructionTextID = 1000276, rewardid = 1288, 
rewarditem = {}
, 
rewardquantity = {}
, unlockcondition = "2,8", activevalue = 10, unlockid = 1001205}
, 
[30018] = {id = 30018, sortid = 9, missionname = "休息时间", missionnameTextID = 1000974, missiontype = 3, targettype = 7, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 23, description = "魔女小屋中入驻1次人偶", descriptionTextID = 1000976, endevent = 21, 
toptip = {200014}
, 
progressname = {"派遣人偶"}
, 
progressnameTextID = {1000978}
, instruction = "魔女小屋是魔女庭院中核心建筑之一，人偶恢复精力的场所。", instructionTextID = 1000980, rewardid = 1288, 
rewarditem = {}
, 
rewardquantity = {}
, unlockcondition = "2,8", activevalue = 10, unlockid = 1001206}
, 
[30019] = {id = 30019, sortid = 10, missionname = "友情交换", missionnameTextID = 1000243, missiontype = 3, targettype = 17, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 25, description = "使用友情点购买1次商品", descriptionTextID = 1000255, endevent = 12, 
toptip = {200015}
, 
progressname = {"购买物品"}
, 
progressnameTextID = {1000267}
, instruction = "使用好友助战可获得友情点，用来在商店中交换物品。", instructionTextID = 1000279, rewardid = 1288, 
rewarditem = {}
, 
rewardquantity = {}
, unlockcondition = "2,16", activevalue = 20, unlockid = 1001207}
, 
[30020] = {id = 30020, sortid = 11, missionname = "好友助战", missionnameTextID = 1001140, missiontype = 3, targettype = 1, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "使用好友助战通关关卡一次", descriptionTextID = 1001144, endevent = 23, 
toptip = {200016}
, 
progressname = {"好友助战"}
, 
progressnameTextID = {1001148}
, instruction = "使用好友助战打败敌人。", instructionTextID = 1001151, rewardid = 1288, 
rewarditem = {}
, 
rewardquantity = {}
, unlockcondition = "2,16", activevalue = 10, unlockid = 1001208}
}
cdailymissionconfig.AllIds = {30010, 30011, 30012, 30013, 30014, 30015, 30016, 30017, 30018, 30019, 30020}
return cdailymissionconfig

