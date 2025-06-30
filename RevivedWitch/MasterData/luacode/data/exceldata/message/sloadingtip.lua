-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/message/sloadingtip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local sloadingtip = {}
sloadingtip.Data = {
[1] = {id = 1, tipMsg = "【战斗：位移技能】$B$战斗中可以使用位移技能躲避部分伤害", tipMsgTextID = 700521, weight = 1, effectCondition = 0, defectCondition = 0}
, 
[2] = {id = 2, tipMsg = "【战斗：队伍配置】$B$不同人偶技能消耗的能量通常不同$B$合理配置队伍成员以最大化利用战斗能量", tipMsgTextID = 700522, weight = 1, effectCondition = 2005, defectCondition = 0}
, 
[3] = {id = 3, tipMsg = "【探索：角色移动】$B$轻推摇杆可以由跑步切换为行走", tipMsgTextID = 700523, weight = 1, effectCondition = 0, defectCondition = 0}
, 
[4] = {id = 4, tipMsg = "【百科：玛那收集者】$B$会在体内储存玛那微粒的魔法植物", tipMsgTextID = 700524, weight = 1, effectCondition = 2005, defectCondition = 0}
, 
[5] = {id = 5, tipMsg = "【百科：圣坛】$B$在探索中可以使用圣坛恢复生命$B$通常情况只能使用一次", tipMsgTextID = 700525, weight = 1, effectCondition = 2001, defectCondition = 0}
, 
[6] = {id = 6, tipMsg = "【探索：折返】$B$在探索中可以随时点击地图右上角按钮返回塔底", tipMsgTextID = 700526, weight = 1, effectCondition = 2002, defectCondition = 0}
, 
[7] = {id = 7, tipMsg = "【战斗：阵容】$B$魔导型人偶更注重魔法伤害$B$而破坏型人偶更注重物理攻击", tipMsgTextID = 700649, weight = 1, effectCondition = 2012, defectCondition = 0}
, 
[8] = {id = 8, tipMsg = "【探索：传送点解锁】$B$某些关卡在完成后可解锁传送点$B$之后可从初始之间直接传送到该区域", tipMsgTextID = 700528, weight = 1, effectCondition = 0, defectCondition = 0}
, 
[9] = {id = 9, tipMsg = "【战斗：能量控制】$B$秩序能量自然增长$B$混沌能量消耗秩序获得 ", tipMsgTextID = 700642, weight = 1, effectCondition = 2005, defectCondition = 0}
, 
[10] = {id = 10, tipMsg = "【战斗：能量控制】$B$秩序能量自然增长$B$混沌能量消耗秩序获得 ", tipMsgTextID = 700642, weight = 1, effectCondition = 2005, defectCondition = 0}
, 
[11] = {id = 11, tipMsg = "【探索：时之塔】$B$时之塔内存在一些可以发射光线的古老方尖碑$B$利用镜子引导光线照射在门上，可以将门打开", tipMsgTextID = 700643, weight = 1, effectCondition = 2006, defectCondition = 0}
, 
[12] = {id = 12, tipMsg = "【探索：谢波契卡之山】$B$谢波契卡之山中魔法墙是依靠水晶塔的魔力构建的$B$点亮全部水晶塔便可以将魔法墙破坏", tipMsgTextID = 700644, weight = 1, effectCondition = 2007, defectCondition = 2014}
, 
[13] = {id = 13, tipMsg = "【百科：传送阵】$B$传送阵可以将人瞬间传送到另外一个地点$B$大部分传送阵都是双向的，但传说也存在单向的传送阵", tipMsgTextID = 700645, weight = 1, effectCondition = 2008, defectCondition = 0}
, 
[14] = {id = 14, tipMsg = "【百科：魔女庭院】$B$升级魔法树之后$B$其他建筑可建造的最大等级也会提升", tipMsgTextID = 700646, weight = 1, effectCondition = 2009, defectCondition = 0}
, 
[15] = {id = 15, tipMsg = "【战斗：阵容】$B$守护型人偶有着最高的生命和防御", tipMsgTextID = 700647, weight = 1, effectCondition = 2010, defectCondition = 0}
, 
[16] = {id = 16, tipMsg = "【战斗：阵容】$B$刺杀型人偶有着最高的攻击", tipMsgTextID = 700648, weight = 1, effectCondition = 2011, defectCondition = 0}
, 
[17] = {id = 17, tipMsg = "【战斗：阵容】$B$魔导型人偶更注重魔法伤害$B$而破坏型人偶更注重物理攻击", tipMsgTextID = 700649, weight = 1, effectCondition = 2012, defectCondition = 0}
, 
[18] = {id = 18, tipMsg = "【战斗：阵容】$B$刺杀型人偶有着最高的攻击", tipMsgTextID = 700648, weight = 1, effectCondition = 2011, defectCondition = 0}
, 
[19] = {id = 19, tipMsg = "【战斗：阵容】$B$嘉庇艾尔的魔物更容易受到魔法伤害", tipMsgTextID = 700915, weight = 3, effectCondition = 2015, defectCondition = 2018}
, 
[20] = {id = 20, tipMsg = "【战斗：阵容】$B$时之塔的机械守卫有着很强的物理抗性", tipMsgTextID = 700916, weight = 3, effectCondition = 2016, defectCondition = 2019}
, 
[21] = {id = 21, tipMsg = "【战斗：能量控制】$B$受到黑魔法影响的德亚丝$B$更容易感知到能量的变化", tipMsgTextID = 700917, weight = 5, effectCondition = 2017, defectCondition = 2020}
}
sloadingtip.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21}
return sloadingtip

