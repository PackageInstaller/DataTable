-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/mission/cweekmissionconfig.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cweekmissionconfig = {}
cweekmissionconfig.Data = {
[80001] = {id = 80001, missionname = "胜利女神·二", missionnameTextID = 1000280, missiontype = 8, targettype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "累计战斗胜利100次", descriptionTextID = 1000294, endevent = 1, 
toptip = {200007}
, 
progressname = {"战斗胜利"}
, 
progressnameTextID = {1000308}
, instruction = "探索途中会遇到各种各样的怪物，尝试在战斗中消灭它们，获得100场战斗胜利。", instructionTextID = 1000322, rewardid = 1835, 
rewarditem = {35002}
, 
rewardquantity = {10000}
, unlockcondition = "1,1;4,35", activevalue = 5}
, 
[80002] = {id = 80002, missionname = "传达心意", missionnameTextID = 1000281, missiontype = 8, targettype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 9, description = "向人偶赠送礼物5次", descriptionTextID = 1000295, endevent = 2, 
toptip = {200008}
, 
progressname = {"赠送礼物"}
, 
progressnameTextID = {1000309}
, instruction = "向人偶赠送心仪的礼物可以提升羁绊等级。", instructionTextID = 1000323, rewardid = 1836, 
rewarditem = {74000}
, 
rewardquantity = {2}
, unlockcondition = "1,1;4,35", activevalue = 10}
, 
[80003] = {id = 80003, missionname = "人偶强化", missionnameTextID = 1000282, missiontype = 8, targettype = 5, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 2, description = "提升任意人偶的强化等级5次", descriptionTextID = 1000296, endevent = 3, 
toptip = {200009}
, 
progressname = {"强化人偶"}
, 
progressnameTextID = {1000310}
, instruction = "在梦境世界中可以获得大量玛那或材料。", instructionTextID = 1000324, rewardid = 1837, 
rewarditem = {35002}
, 
rewardquantity = {10000}
, unlockcondition = "1,1;4,35", activevalue = 10}
, 
[80004] = {id = 80004, missionname = "日常探索", missionnameTextID = 1000283, missiontype = 8, targettype = 5, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "通关10次主线关卡", descriptionTextID = 1000297, endevent = 4, 
toptip = {200010}
, 
progressname = {"通关主线关卡"}
, 
progressnameTextID = {1000311}
, instruction = "继续向前探索，通关主线关卡。", instructionTextID = 1000325, rewardid = 1838, 
rewarditem = {35002}
, 
rewardquantity = {10000}
, unlockcondition = "1,1;4,35", activevalue = 10}
, 
[80006] = {id = 80006, missionname = "玛那梦境", missionnameTextID = 1000285, missiontype = 8, targettype = 6, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 17, description = "通关3次玛那梦境副本", descriptionTextID = 1000299, endevent = 6, 
toptip = {200011}
, 
progressname = {"通关玛那梦境"}
, 
progressnameTextID = {1000313}
, instruction = "在玛那梦境中可获得大量玛那。", instructionTextID = 1000327, rewardid = 1840, 
rewarditem = {35002}
, 
rewardquantity = {10000}
, unlockcondition = "1,1;4,35", activevalue = 5}
, 
[80007] = {id = 80007, missionname = "突破材料", missionnameTextID = 1000286, missiontype = 8, targettype = 6, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 17, description = "通关3次突破材料副本", descriptionTextID = 1000300, endevent = 7, 
toptip = {200012}
, 
progressname = {"通关突破材料副本"}
, 
progressnameTextID = {1000314}
, instruction = "突破材料副本是获得人偶突破材料的重要途径。", instructionTextID = 1000328, rewardid = 1841, 
rewarditem = {31037}
, 
rewardquantity = {1}
, unlockcondition = "1,1;4,35", activevalue = 10}
, 
[80008] = {id = 80008, missionname = "技能材料", missionnameTextID = 1000287, missiontype = 8, targettype = 3, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 17, description = "通关3次技能材料副本", descriptionTextID = 1000301, endevent = 8, 
toptip = {200013}
, 
progressname = {"通关技能材料副本"}
, 
progressnameTextID = {1000315}
, instruction = "技能材料副本是提升人偶技能等级的重要途径。", instructionTextID = 1000329, rewardid = 1842, 
rewarditem = {74000}
, 
rewardquantity = {3}
, unlockcondition = "1,1;4,35", activevalue = 5}
, 
[80009] = {id = 80009, missionname = "装备收集", missionnameTextID = 1000288, missiontype = 8, targettype = 3, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 17, description = "通关3次人偶装备副本", descriptionTextID = 1000302, endevent = 9, 
toptip = {200014}
, 
progressname = {"通关人偶装备副本"}
, 
progressnameTextID = {1000316}
, instruction = "在装备副本中会掉落各类优质装备。", instructionTextID = 1000330, rewardid = 1843, 
rewarditem = {76000}
, 
rewardquantity = {5}
, unlockcondition = "1,1;4,35", activevalue = 10}
, 
[80010] = {id = 80010, missionname = "萤火收集", missionnameTextID = 1000289, missiontype = 8, targettype = 13, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 20, description = "在庭院收取1000单位的白光", descriptionTextID = 1000303, endevent = 10, 
toptip = {200015}
, 
progressname = {"收集白光"}
, 
progressnameTextID = {1000317}
, instruction = "在庭院中点击游荡的白色萤火，或使用萤火灯台可以获得白光。", instructionTextID = 1000331, rewardid = 1844, 
rewarditem = {35018}
, 
rewardquantity = {15}
, unlockcondition = "1,1;4,35", activevalue = 10}
, 
[80011] = {id = 80011, missionname = "委派探索", missionnameTextID = 1000290, missiontype = 8, targettype = 16, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 20, description = "魔女庭院探索异界之镜10次", descriptionTextID = 1000304, endevent = 11, 
toptip = {200016}
, 
progressname = {"装备强化"}
, 
progressnameTextID = {1000318}
, instruction = "在庭院中可以派遣人偶探索异界之镜，带回丰富的素材。", instructionTextID = 1000332, rewardid = 1845, 
rewarditem = {35018}
, 
rewardquantity = {15}
, unlockcondition = "1,1;4,35", activevalue = 5}
, 
[80012] = {id = 80012, missionname = "强化装备", missionnameTextID = 1000291, missiontype = 8, targettype = 17, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 1, description = "装备强化10次", descriptionTextID = 1000305, endevent = 12, 
toptip = {200017}
, 
progressname = {"装备收集"}
, 
progressnameTextID = {1000319}
, instruction = "战斗胜利以及打开宝箱都有一定概率获得装备。", instructionTextID = 1000333, rewardid = 1846, 
rewarditem = {76000}
, 
rewardquantity = {5}
, unlockcondition = "1,1;4,35", activevalue = 5}
, 
[80013] = {id = 80013, missionname = "召唤练习", missionnameTextID = 1000293, missiontype = 8, targettype = 11, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 5, description = "进行5次召唤", descriptionTextID = 1000307, endevent = 14, 
toptip = {200017}
, 
progressname = {"进行召唤"}
, 
progressnameTextID = {1000321}
, instruction = "复制异界的灵魂，增添新的人偶来为你战斗吧。", instructionTextID = 1000335, rewardid = 1847, 
rewarditem = {35008}
, 
rewardquantity = {50}
, unlockcondition = "1,1;4,35", activevalue = 5}
, 
[80014] = {id = 80014, missionname = "胜利女神·一", missionnameTextID = 1000682, missiontype = 8, targettype = 2, jumptype = 2, 
jumpvalue = {0}
, UIjumpvalue = 16, description = "累计战斗胜利50次", descriptionTextID = 1000684, endevent = 15, 
toptip = {200007}
, 
progressname = {"战斗胜利"}
, 
progressnameTextID = {1000308}
, instruction = "探索途中会遇到各种各样的怪物，尝试在战斗中消灭它们，获得50场战斗胜利。", instructionTextID = 1000683, rewardid = 1835, 
rewarditem = {35002}
, 
rewardquantity = {10000}
, unlockcondition = "1,1;4,35", activevalue = 10}
}
cweekmissionconfig.AllIds = {80001, 80002, 80003, 80004, 80006, 80007, 80008, 80009, 80010, 80011, 80012, 80013, 80014}
return cweekmissionconfig

