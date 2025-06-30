-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/dungeondata/mission/cactivemissioncondition.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local triggers = {[1] = function(eventid)
  -- function num : 0_0 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "skill2unlock", "", 3)
end
, [2] = function(eventid)
  -- function num : 0_1 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "skill2unlock", "", 6)
end
, [3] = function(eventid)
  -- function num : 0_2 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "0", 5)
end
, [4] = function(eventid)
  -- function num : 0_3
  return 
end
, [5] = function(eventid)
  -- function num : 0_4 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "guild", "", 1)
end
, [6] = function(eventid)
  -- function num : 0_5
  return 
end
, [7] = function(eventid)
  -- function num : 0_6 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "boshrush", "1", 4)
end
, [8] = function(eventid)
  -- function num : 0_7 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "friend", "", 3)
end
, [9] = function(eventid)
  -- function num : 0_8 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "cavernExploreAward", "0", 4)
end
, [10] = function(eventid)
  -- function num : 0_9 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "cavernExploreAward", "0", 8)
end
, [11] = function(eventid)
  -- function num : 0_10 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "EquipRare", "3", 1)
end
, [12] = function(eventid)
  -- function num : 0_11 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "EquipRare", "3", 3)
end
, [13] = function(eventid)
  -- function num : 0_12
  return 
end
, [14] = function(eventid)
  -- function num : 0_13 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "present", "", 3)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [15] = function(eventid)
  -- function num : 0_14 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "present", "", 6)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [16] = function(eventid)
  -- function num : 0_15 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "outerSpace", "", 2)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [17] = function(eventid)
  -- function num : 0_16 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "supportrole", "", 5)
end
, [18] = function(eventid)
  -- function num : 0_17
  return 
end
, [19] = function(eventid)
  -- function num : 0_18
  return 
end
, [20] = function(eventid)
  -- function num : 0_19
  return 
end
, [21] = function(eventid)
  -- function num : 0_20 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "finishTask", "90008;90009;90010;90011;90012;90013", 6)
end
, [22] = function(eventid)
  -- function num : 0_21 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "finishTask", "90014;90015;90016;90017;90018;90019", 6)
end
, [23] = function(eventid)
  -- function num : 0_22 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "equipBreak", "2", 3)
end
, [24] = function(eventid)
  -- function num : 0_23 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "equipBreak", "3", 3)
end
, [25] = function(eventid)
  -- function num : 0_24 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "alchemy", "", 1)
end
, [26] = function(eventid)
  -- function num : 0_25 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "alchemy", "", 50)
end
, [27] = function(eventid)
  -- function num : 0_26 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "alchemy", "", 100)
end
, [28] = function(eventid)
  -- function num : 0_27
  return 
end
, [29] = function(eventid)
  -- function num : 0_28
  return 
end
, [30] = function(eventid)
  -- function num : 0_29 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "pvpWin", "1", 5)
end
, [31] = function(eventid)
  -- function num : 0_30 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "10105", 3)
end
, [32] = function(eventid)
  -- function num : 0_31 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "10105", 5)
end
, [33] = function(eventid)
  -- function num : 0_32 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "pvpWin", "1", 20)
end
, [34] = function(eventid)
  -- function num : 0_33
  return 
end
, [35] = function(eventid)
  -- function num : 0_34
  return 
end
, [36] = function(eventid)
  -- function num : 0_35
  return 
end
, [37] = function(eventid)
  -- function num : 0_36
  return 
end
, [38] = function(eventid)
  -- function num : 0_37
  return 
end
, [39] = function(eventid)
  -- function num : 0_38
  return 
end
, [40] = function(eventid)
  -- function num : 0_39 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleSkill", "3", 2)
end
, [41] = function(eventid)
  -- function num : 0_40 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleSkill", "3", 4)
end
, [42] = function(eventid)
  -- function num : 0_41 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleSkill", "3", 6)
end
, [43] = function(eventid)
  -- function num : 0_42
  return 
end
, [44] = function(eventid)
  -- function num : 0_43
  return 
end
, [45] = function(eventid)
  -- function num : 0_44
  return 
end
, [46] = function(eventid)
  -- function num : 0_45 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleSkill", "4", 2)
end
, [47] = function(eventid)
  -- function num : 0_46 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleSkill", "4", 4)
end
, [48] = function(eventid)
  -- function num : 0_47 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleSkill", "4", 6)
end
, [49] = function(eventid)
  -- function num : 0_48
  return 
end
, [50] = function(eventid)
  -- function num : 0_49 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "finishTask", "90020;90021;90022;90023;90024;90025", 6)
end
, [51] = function(eventid)
  -- function num : 0_50 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "finishTask", "90026;90027;90028;90029;90030;90031", 6)
end
, [52] = function(eventid)
  -- function num : 0_51 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "finishTask", "90032;90033;90034;90035;90036;90037", 6)
end
, [53] = function(eventid)
  -- function num : 0_52 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "finishTask", "90038;90039;90040;90041;90042;90043", 6)
end
, [54] = function(eventid)
  -- function num : 0_53 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "finishTask", "90044;90045;90046;90047;90048;90049", 6)
end
, [55] = function(eventid)
  -- function num : 0_54
  return 
end
, [56] = function(eventid)
  -- function num : 0_55
  return 
end
, [106] = function(eventid)
  -- function num : 0_56 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "finishTask", "90057;90058;90059;90060;90061;90062", 6)
end
, [107] = function(eventid)
  -- function num : 0_57 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "finishTask", "90063;90064;90065;90066;90067;90068", 6)
end
, [108] = function(eventid)
  -- function num : 0_58 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "finishTask", "90069;90070;90071;90072;90073;90074", 6)
end
, [109] = function(eventid)
  -- function num : 0_59 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "finishTask", "90075;90076;90077;90078;90079;90080", 6)
end
, [110] = function(eventid)
  -- function num : 0_60 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "finishTask", "90081;90082;90083;90084;90085;90086", 6)
end
, [111] = function(eventid)
  -- function num : 0_61 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "finishTask", "90087;90088;90089;90090;90091;90092", 6)
end
, [112] = function(eventid)
  -- function num : 0_62 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "finishTask", "90093;90094;90095;90096;90097;90098", 6)
end
, [113] = function(eventid)
  -- function num : 0_63
  return 
end
, [114] = function(eventid)
  -- function num : 0_64 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "monster", "total", 5)
end
, [115] = function(eventid)
  -- function num : 0_65 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "monster", "total", 10)
end
, [116] = function(eventid)
  -- function num : 0_66
  return 
end
, [117] = function(eventid)
  -- function num : 0_67
  return 
end
, [118] = function(eventid)
  -- function num : 0_68 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "skill2unlock", "", 3)
end
, [119] = function(eventid)
  -- function num : 0_69
  return 
end
, [120] = function(eventid)
  -- function num : 0_70 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "0", 5)
end
, [121] = function(eventid)
  -- function num : 0_71 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "0", 10)
end
, [122] = function(eventid)
  -- function num : 0_72
  return 
end
, [123] = function(eventid)
  -- function num : 0_73
  return 
end
, [124] = function(eventid)
  -- function num : 0_74 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "friend", "", 3)
end
, [125] = function(eventid)
  -- function num : 0_75
  return 
end
, [126] = function(eventid)
  -- function num : 0_76
  return 
end
, [127] = function(eventid)
  -- function num : 0_77
  return 
end
, [128] = function(eventid)
  -- function num : 0_78
  return 
end
, [129] = function(eventid)
  -- function num : 0_79 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "guild", "", 1)
end
, [130] = function(eventid)
  -- function num : 0_80 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "pvpWin", "2", 5)
end
, [131] = function(eventid)
  -- function num : 0_81
  return 
end
, [132] = function(eventid)
  -- function num : 0_82 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "skill2unlock", "", 6)
end
, [133] = function(eventid)
  -- function num : 0_83
  return 
end
, [134] = function(eventid)
  -- function num : 0_84
  return 
end
, [135] = function(eventid)
  -- function num : 0_85 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "0", 15)
end
, [136] = function(eventid)
  -- function num : 0_86 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "cavernExploreAward", "0", 6)
end
, [137] = function(eventid)
  -- function num : 0_87
  return 
end
, [138] = function(eventid)
  -- function num : 0_88
  return 
end
, [139] = function(eventid)
  -- function num : 0_89
  return 
end
, [140] = function(eventid)
  -- function num : 0_90
  return 
end
, [141] = function(eventid)
  -- function num : 0_91 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "0", 15)
end
, [142] = function(eventid)
  -- function num : 0_92 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "supportrole", "", 3)
end
, [143] = function(eventid)
  -- function num : 0_93
  return 
end
, [144] = function(eventid)
  -- function num : 0_94
  return 
end
, [145] = function(eventid)
  -- function num : 0_95
  return 
end
, [146] = function(eventid)
  -- function num : 0_96 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "boshrush", "1", 4)
end
, [147] = function(eventid)
  -- function num : 0_97 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "outerSpace", "", 1)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [148] = function(eventid)
  -- function num : 0_98 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "pvpWin", "2", 10)
end
, [149] = function(eventid)
  -- function num : 0_99
  return 
end
, [150] = function(eventid)
  -- function num : 0_100
  return 
end
, [151] = function(eventid)
  -- function num : 0_101 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "EquipRare", "3", 1)
end
, [152] = function(eventid)
  -- function num : 0_102 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "boshrush", "1", 7)
end
, [153] = function(eventid)
  -- function num : 0_103 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "outerSpace", "", 2)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [154] = function(eventid)
  -- function num : 0_104 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "pvpWin", "2", 15)
end
}
return triggers

