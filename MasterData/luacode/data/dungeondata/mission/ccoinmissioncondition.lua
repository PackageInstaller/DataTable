-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/dungeondata/mission/ccoinmissioncondition.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local triggers = {[1001] = function(eventid)
  -- function num : 0_0 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "1", 2)
end
, [1002] = function(eventid)
  -- function num : 0_1 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "1", 3)
end
, [1003] = function(eventid)
  -- function num : 0_2 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "1", 4)
end
, [1004] = function(eventid)
  -- function num : 0_3 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "2", 2)
end
, [1005] = function(eventid)
  -- function num : 0_4 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "2", 3)
end
, [1006] = function(eventid)
  -- function num : 0_5 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "2", 4)
end
, [1007] = function(eventid)
  -- function num : 0_6 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "3", 2)
end
, [1008] = function(eventid)
  -- function num : 0_7 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "3", 3)
end
, [1009] = function(eventid)
  -- function num : 0_8 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "3", 4)
end
, [1010] = function(eventid)
  -- function num : 0_9 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "4", 2)
end
, [1011] = function(eventid)
  -- function num : 0_10 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "4", 3)
end
, [1012] = function(eventid)
  -- function num : 0_11 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "4", 4)
end
, [2001] = function(eventid)
  -- function num : 0_12 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "77028", 10)
end
, [2002] = function(eventid)
  -- function num : 0_13 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "77028", 15)
end
, [2003] = function(eventid)
  -- function num : 0_14 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "77028", 20)
end
, [2004] = function(eventid)
  -- function num : 0_15 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "77025", 5)
end
, [2005] = function(eventid)
  -- function num : 0_16 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "77025", 8)
end
, [2006] = function(eventid)
  -- function num : 0_17 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "77025", 10)
end
, [2007] = function(eventid)
  -- function num : 0_18 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "77007", 14)
end
, [2008] = function(eventid)
  -- function num : 0_19 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "77007", 20)
end
, [2009] = function(eventid)
  -- function num : 0_20 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "77007", 28)
end
, [2010] = function(eventid)
  -- function num : 0_21 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "77024", 8)
end
, [2011] = function(eventid)
  -- function num : 0_22 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "77024", 12)
end
, [2012] = function(eventid)
  -- function num : 0_23 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "77024", 16)
end
, [2013] = function(eventid)
  -- function num : 0_24 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "77026", 6)
end
, [2014] = function(eventid)
  -- function num : 0_25 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "77026", 9)
end
, [2015] = function(eventid)
  -- function num : 0_26 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "77026", 12)
end
, [2016] = function(eventid)
  -- function num : 0_27 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "77034", 8)
end
, [2017] = function(eventid)
  -- function num : 0_28 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "77034", 12)
end
, [2018] = function(eventid)
  -- function num : 0_29 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "77034", 16)
end
, [2019] = function(eventid)
  -- function num : 0_30 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "77038", 10)
end
, [2020] = function(eventid)
  -- function num : 0_31 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "77038", 15)
end
, [2021] = function(eventid)
  -- function num : 0_32 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "77038", 20)
end
, [2022] = function(eventid)
  -- function num : 0_33 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "77039", 8)
end
, [2023] = function(eventid)
  -- function num : 0_34 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "77039", 12)
end
, [2024] = function(eventid)
  -- function num : 0_35 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "77039", 16)
end
, [3001] = function(eventid)
  -- function num : 0_36 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "2", 5)
end
, [3002] = function(eventid)
  -- function num : 0_37 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "2", 10)
end
, [3003] = function(eventid)
  -- function num : 0_38 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "3", 5)
end
, [3004] = function(eventid)
  -- function num : 0_39 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "3", 10)
end
, [3005] = function(eventid)
  -- function num : 0_40 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "4", 5)
end
, [3006] = function(eventid)
  -- function num : 0_41 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "4", 10)
end
, [3007] = function(eventid)
  -- function num : 0_42 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "9", 5)
end
, [3008] = function(eventid)
  -- function num : 0_43 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "9", 10)
end
, [3009] = function(eventid)
  -- function num : 0_44 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "14", 5)
end
, [3010] = function(eventid)
  -- function num : 0_45 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "14", 10)
end
, [3011] = function(eventid)
  -- function num : 0_46 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "15", 5)
end
, [3012] = function(eventid)
  -- function num : 0_47 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "15", 10)
end
, [3013] = function(eventid)
  -- function num : 0_48 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "16", 5)
end
, [3014] = function(eventid)
  -- function num : 0_49 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "16", 10)
end
, [3015] = function(eventid)
  -- function num : 0_50 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "19", 5)
end
, [3016] = function(eventid)
  -- function num : 0_51 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "19", 10)
end
, [3017] = function(eventid)
  -- function num : 0_52 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "24", 5)
end
, [3018] = function(eventid)
  -- function num : 0_53 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "24", 10)
end
, [3019] = function(eventid)
  -- function num : 0_54 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "27", 5)
end
, [3020] = function(eventid)
  -- function num : 0_55 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "27", 10)
end
, [3021] = function(eventid)
  -- function num : 0_56 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "32", 5)
end
, [3022] = function(eventid)
  -- function num : 0_57 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "32", 10)
end
, [3023] = function(eventid)
  -- function num : 0_58 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "36", 5)
end
, [3024] = function(eventid)
  -- function num : 0_59 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "36", 10)
end
, [3025] = function(eventid)
  -- function num : 0_60 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "73", 5)
end
, [3026] = function(eventid)
  -- function num : 0_61 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "73", 10)
end
, [3027] = function(eventid)
  -- function num : 0_62 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "74", 5)
end
, [3028] = function(eventid)
  -- function num : 0_63 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "74", 10)
end
, [3029] = function(eventid)
  -- function num : 0_64 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "49", 5)
end
, [3030] = function(eventid)
  -- function num : 0_65 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "49", 10)
end
, [3031] = function(eventid)
  -- function num : 0_66 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "52", 5)
end
, [3032] = function(eventid)
  -- function num : 0_67 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "52", 10)
end
, [3033] = function(eventid)
  -- function num : 0_68 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "57", 5)
end
, [3034] = function(eventid)
  -- function num : 0_69 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "57", 10)
end
, [3035] = function(eventid)
  -- function num : 0_70 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "75", 5)
end
, [3036] = function(eventid)
  -- function num : 0_71 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "75", 10)
end
, [3037] = function(eventid)
  -- function num : 0_72 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "76", 5)
end
, [3038] = function(eventid)
  -- function num : 0_73 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "76", 10)
end
, [4001] = function(eventid)
  -- function num : 0_74 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "2", 2)
end
, [4002] = function(eventid)
  -- function num : 0_75 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "2", 3)
end
, [4003] = function(eventid)
  -- function num : 0_76 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "2", 4)
end
, [4004] = function(eventid)
  -- function num : 0_77 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "3", 2)
end
, [4005] = function(eventid)
  -- function num : 0_78 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "3", 3)
end
, [4006] = function(eventid)
  -- function num : 0_79 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "3", 4)
end
, [4007] = function(eventid)
  -- function num : 0_80 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "4", 2)
end
, [4008] = function(eventid)
  -- function num : 0_81 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "4", 3)
end
, [4009] = function(eventid)
  -- function num : 0_82 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "4", 4)
end
, [4010] = function(eventid)
  -- function num : 0_83 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "9", 2)
end
, [4011] = function(eventid)
  -- function num : 0_84 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "9", 3)
end
, [4012] = function(eventid)
  -- function num : 0_85 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "9", 4)
end
, [4013] = function(eventid)
  -- function num : 0_86 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "14", 2)
end
, [4014] = function(eventid)
  -- function num : 0_87 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "14", 3)
end
, [4015] = function(eventid)
  -- function num : 0_88 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "14", 4)
end
, [4016] = function(eventid)
  -- function num : 0_89 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "15", 2)
end
, [4017] = function(eventid)
  -- function num : 0_90 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "15", 3)
end
, [4018] = function(eventid)
  -- function num : 0_91 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "15", 4)
end
, [4019] = function(eventid)
  -- function num : 0_92 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "16", 2)
end
, [4020] = function(eventid)
  -- function num : 0_93 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "16", 3)
end
, [4021] = function(eventid)
  -- function num : 0_94 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "16", 4)
end
, [4022] = function(eventid)
  -- function num : 0_95 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "19", 2)
end
, [4023] = function(eventid)
  -- function num : 0_96 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "19", 3)
end
, [4024] = function(eventid)
  -- function num : 0_97 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "19", 4)
end
, [4025] = function(eventid)
  -- function num : 0_98 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "24", 2)
end
, [4026] = function(eventid)
  -- function num : 0_99 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "24", 3)
end
, [4027] = function(eventid)
  -- function num : 0_100 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "24", 4)
end
, [4028] = function(eventid)
  -- function num : 0_101 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "27", 2)
end
, [4029] = function(eventid)
  -- function num : 0_102 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "27", 3)
end
, [4030] = function(eventid)
  -- function num : 0_103 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "27", 4)
end
, [4031] = function(eventid)
  -- function num : 0_104 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "32", 2)
end
, [4032] = function(eventid)
  -- function num : 0_105 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "32", 3)
end
, [4033] = function(eventid)
  -- function num : 0_106 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "32", 4)
end
, [4034] = function(eventid)
  -- function num : 0_107 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "36", 2)
end
, [4035] = function(eventid)
  -- function num : 0_108 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "36", 3)
end
, [4036] = function(eventid)
  -- function num : 0_109 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "36", 4)
end
, [4037] = function(eventid)
  -- function num : 0_110 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "73", 2)
end
, [4038] = function(eventid)
  -- function num : 0_111 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "73", 3)
end
, [4039] = function(eventid)
  -- function num : 0_112 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "73", 4)
end
, [4040] = function(eventid)
  -- function num : 0_113 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "74", 2)
end
, [4041] = function(eventid)
  -- function num : 0_114 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "74", 3)
end
, [4042] = function(eventid)
  -- function num : 0_115 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "74", 4)
end
, [4043] = function(eventid)
  -- function num : 0_116 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "49", 2)
end
, [4044] = function(eventid)
  -- function num : 0_117 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "49", 3)
end
, [4045] = function(eventid)
  -- function num : 0_118 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "49", 4)
end
, [4046] = function(eventid)
  -- function num : 0_119 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "52", 2)
end
, [4047] = function(eventid)
  -- function num : 0_120 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "52", 3)
end
, [4048] = function(eventid)
  -- function num : 0_121 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "52", 4)
end
, [4049] = function(eventid)
  -- function num : 0_122 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "57", 2)
end
, [4050] = function(eventid)
  -- function num : 0_123 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "57", 3)
end
, [4051] = function(eventid)
  -- function num : 0_124 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "57", 4)
end
, [4052] = function(eventid)
  -- function num : 0_125 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "75", 2)
end
, [4053] = function(eventid)
  -- function num : 0_126 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "75", 3)
end
, [4054] = function(eventid)
  -- function num : 0_127 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "75", 4)
end
, [4055] = function(eventid)
  -- function num : 0_128 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "76", 2)
end
, [4056] = function(eventid)
  -- function num : 0_129 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "76", 3)
end
, [4057] = function(eventid)
  -- function num : 0_130 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "76", 4)
end
, [1013] = function(eventid)
  -- function num : 0_131 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "1", 2)
end
, [1014] = function(eventid)
  -- function num : 0_132 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "1", 3)
end
, [1015] = function(eventid)
  -- function num : 0_133 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "1", 4)
end
, [1016] = function(eventid)
  -- function num : 0_134 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "2", 2)
end
, [1017] = function(eventid)
  -- function num : 0_135 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "2", 3)
end
, [1018] = function(eventid)
  -- function num : 0_136 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "2", 4)
end
, [1019] = function(eventid)
  -- function num : 0_137 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "3", 2)
end
, [1020] = function(eventid)
  -- function num : 0_138 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "3", 3)
end
, [1021] = function(eventid)
  -- function num : 0_139 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "3", 4)
end
, [1022] = function(eventid)
  -- function num : 0_140 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "4", 2)
end
, [1023] = function(eventid)
  -- function num : 0_141 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "4", 3)
end
, [1024] = function(eventid)
  -- function num : 0_142 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "4", 4)
end
, [3039] = function(eventid)
  -- function num : 0_143 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "2", 5)
end
, [3040] = function(eventid)
  -- function num : 0_144 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "3", 5)
end
, [3041] = function(eventid)
  -- function num : 0_145 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "4", 5)
end
, [3042] = function(eventid)
  -- function num : 0_146 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "9", 5)
end
, [3043] = function(eventid)
  -- function num : 0_147 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "14", 5)
end
, [3044] = function(eventid)
  -- function num : 0_148 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "15", 5)
end
, [3045] = function(eventid)
  -- function num : 0_149 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "16", 5)
end
, [3046] = function(eventid)
  -- function num : 0_150 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "19", 5)
end
, [3047] = function(eventid)
  -- function num : 0_151 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "24", 5)
end
, [3048] = function(eventid)
  -- function num : 0_152 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "27", 5)
end
, [3049] = function(eventid)
  -- function num : 0_153 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "32", 5)
end
, [3050] = function(eventid)
  -- function num : 0_154 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "36", 5)
end
, [3051] = function(eventid)
  -- function num : 0_155 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "73", 5)
end
, [3052] = function(eventid)
  -- function num : 0_156 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "74", 5)
end
, [3053] = function(eventid)
  -- function num : 0_157 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "49", 5)
end
, [3054] = function(eventid)
  -- function num : 0_158 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "52", 5)
end
, [3055] = function(eventid)
  -- function num : 0_159 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "57", 5)
end
, [3056] = function(eventid)
  -- function num : 0_160 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "75", 5)
end
, [3057] = function(eventid)
  -- function num : 0_161 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleLv", "76", 5)
end
, [4058] = function(eventid)
  -- function num : 0_162 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "2", 2)
end
, [4059] = function(eventid)
  -- function num : 0_163 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "2", 3)
end
, [4060] = function(eventid)
  -- function num : 0_164 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "2", 4)
end
, [4061] = function(eventid)
  -- function num : 0_165 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "3", 2)
end
, [4062] = function(eventid)
  -- function num : 0_166 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "3", 3)
end
, [4063] = function(eventid)
  -- function num : 0_167 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "4", 2)
end
, [4064] = function(eventid)
  -- function num : 0_168 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "4", 3)
end
, [4065] = function(eventid)
  -- function num : 0_169 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "9", 2)
end
, [4066] = function(eventid)
  -- function num : 0_170 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "9", 3)
end
, [4067] = function(eventid)
  -- function num : 0_171 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "14", 2)
end
, [4068] = function(eventid)
  -- function num : 0_172 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "14", 3)
end
, [4069] = function(eventid)
  -- function num : 0_173 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "15", 2)
end
, [4070] = function(eventid)
  -- function num : 0_174 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "15", 3)
end
, [4071] = function(eventid)
  -- function num : 0_175 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "16", 2)
end
, [4072] = function(eventid)
  -- function num : 0_176 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "16", 3)
end
, [4073] = function(eventid)
  -- function num : 0_177 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "19", 2)
end
, [4074] = function(eventid)
  -- function num : 0_178 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "19", 3)
end
, [4075] = function(eventid)
  -- function num : 0_179 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "24", 2)
end
, [4076] = function(eventid)
  -- function num : 0_180 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "24", 3)
end
, [4077] = function(eventid)
  -- function num : 0_181 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "27", 2)
end
, [4078] = function(eventid)
  -- function num : 0_182 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "27", 3)
end
, [4079] = function(eventid)
  -- function num : 0_183 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "32", 2)
end
, [4080] = function(eventid)
  -- function num : 0_184 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "32", 3)
end
, [4081] = function(eventid)
  -- function num : 0_185 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "36", 2)
end
, [4082] = function(eventid)
  -- function num : 0_186 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "36", 3)
end
, [4083] = function(eventid)
  -- function num : 0_187 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "73", 2)
end
, [4084] = function(eventid)
  -- function num : 0_188 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "73", 3)
end
, [4085] = function(eventid)
  -- function num : 0_189 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "74", 2)
end
, [4086] = function(eventid)
  -- function num : 0_190 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "74", 3)
end
, [4087] = function(eventid)
  -- function num : 0_191 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "49", 2)
end
, [4088] = function(eventid)
  -- function num : 0_192 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "49", 3)
end
, [4089] = function(eventid)
  -- function num : 0_193 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "52", 2)
end
, [4090] = function(eventid)
  -- function num : 0_194 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "52", 3)
end
, [4091] = function(eventid)
  -- function num : 0_195 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "57", 2)
end
, [4092] = function(eventid)
  -- function num : 0_196 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "57", 3)
end
, [4093] = function(eventid)
  -- function num : 0_197 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "75", 2)
end
, [4094] = function(eventid)
  -- function num : 0_198 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "75", 3)
end
, [4095] = function(eventid)
  -- function num : 0_199 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "76", 2)
end
, [4096] = function(eventid)
  -- function num : 0_200 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeonrole", "76", 3)
end
, [5013] = function(eventid)
  -- function num : 0_201 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "pvpWin", "1", 2)
end
, [5014] = function(eventid)
  -- function num : 0_202 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "pvpWin", "1", 4)
end
, [5015] = function(eventid)
  -- function num : 0_203 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "pvpWin", "1", 6)
end
, [5016] = function(eventid)
  -- function num : 0_204 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "cavernExploreAward", "0", 2)
end
, [5017] = function(eventid)
  -- function num : 0_205 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "cavernExploreAward", "0", 4)
end
, [5018] = function(eventid)
  -- function num : 0_206 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "cavernExploreAward", "0", 6)
end
}
return triggers

