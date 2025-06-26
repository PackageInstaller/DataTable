-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/dungeondata/mission/cweekmissioncondition.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local triggers = {[1] = function(eventid)
  -- function num : 0_0 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "monster", "total", 50)
end
, [2] = function(eventid)
  -- function num : 0_1 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "monster", "total", 500)
end
, [3] = function(eventid)
  -- function num : 0_2 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "monster", "total", 2000)
end
, [4] = function(eventid)
  -- function num : 0_3 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "openBox", "", 1)
end
, [5] = function(eventid)
  -- function num : 0_4 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "openBox", "", 100)
end
, [6] = function(eventid)
  -- function num : 0_5 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "openBox", "", 500)
end
, [7] = function(eventid)
  -- function num : 0_6 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "openTree", "", 1)
end
, [8] = function(eventid)
  -- function num : 0_7 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "openTree", "", 50)
end
, [9] = function(eventid)
  -- function num : 0_8 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "openTree", "", 250)
end
, [10] = function(eventid)
  -- function num : 0_9 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "globalBattleWin", "", 100)
end
, [11] = function(eventid)
  -- function num : 0_10 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "globalBattleWin", "", 500)
end
, [12] = function(eventid)
  -- function num : 0_11 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "globalBattleWin", "", 1000)
end
, [13] = function(eventid)
  -- function num : 0_12 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "35002", 100000)
end
, [14] = function(eventid)
  -- function num : 0_13 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "35002", 5000000)
end
, [15] = function(eventid)
  -- function num : 0_14 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "35002", 50000000)
end
, [16] = function(eventid)
  -- function num : 0_15 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeon", "", 1)
end
, [17] = function(eventid)
  -- function num : 0_16 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeon", "", 50)
end
, [18] = function(eventid)
  -- function num : 0_17 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dungeon", "", 100)
end
, [19] = function(eventid)
  -- function num : 0_18 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1187, "Success", "AfterReturn")
end
, [20] = function(eventid)
  -- function num : 0_19 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1127, "Success", "AfterReturn")
end
, [21] = function(eventid)
  -- function num : 0_20 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1134, "Success", "AfterReturn")
end
, [22] = function(eventid)
  -- function num : 0_21 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1189, "Success", "AfterReturn")
end
, [23] = function(eventid)
  -- function num : 0_22 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1294, "Success", "AfterReturn")
end
, [24] = function(eventid)
  -- function num : 0_23 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1295, "Success", "AfterReturn")
end
, [25] = function(eventid)
  -- function num : 0_24 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1356, "Success", "AfterReturn")
end
, [26] = function(eventid)
  -- function num : 0_25
  return 
end
, [27] = function(eventid)
  -- function num : 0_26
  return 
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
  -- function num : 0_29
  return 
end
, [31] = function(eventid)
  -- function num : 0_30
  return 
end
, [32] = function(eventid)
  -- function num : 0_31 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "equipstrengthen", "total", 1)
end
, [33] = function(eventid)
  -- function num : 0_32 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "friend", "", 1)
end
, [34] = function(eventid)
  -- function num : 0_33 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "friend", "", 10)
end
, [35] = function(eventid)
  -- function num : 0_34 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "friend", "", 100)
end
, [36] = function(eventid)
  -- function num : 0_35 , upvalues : ComposedTrigger, Or, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (Or.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "card", "0", 1)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [37] = function(eventid)
  -- function num : 0_36 , upvalues : ComposedTrigger, Or, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (Or.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "realm", "1", 1)
  root:AddTask(trigger0)
  local trigger1 = (TriggerManager.CreateTrigger)("counter", eventid, "realm", "2", 1)
  root:AddTask(trigger1)
  local trigger2 = (TriggerManager.CreateTrigger)("counter", eventid, "realm", "3", 1)
  root:AddTask(trigger2)
  do
    local trigger3 = (TriggerManager.CreateTrigger)("counter", eventid, "realm", "4", 1)
    root:AddTask(trigger3)
    upper:AddTask(root)
    return root
  end
end
, [38] = function(eventid)
  -- function num : 0_37 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "buyitem", "0", 1)
end
, [39] = function(eventid)
  -- function num : 0_38
  return 
end
, [40] = function(eventid)
  -- function num : 0_39
  return 
end
, [41] = function(eventid)
  -- function num : 0_40
  return 
end
, [42] = function(eventid)
  -- function num : 0_41
  return 
end
, [43] = function(eventid)
  -- function num : 0_42 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "cavernExplore", "0", 1)
end
, [44] = function(eventid)
  -- function num : 0_43 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "buildLevel", "0", 1)
end
, [45] = function(eventid)
  -- function num : 0_44 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "autoExplore", "0", 1)
end
, [46] = function(eventid)
  -- function num : 0_45 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "rolequantity", "total", 10)
end
, [47] = function(eventid)
  -- function num : 0_46 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "rolequantity", "total", 30)
end
, [48] = function(eventid)
  -- function num : 0_47 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "rolequantity", "total", 50)
end
, [49] = function(eventid)
  -- function num : 0_48 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "equipNum", "total", 20)
end
, [50] = function(eventid)
  -- function num : 0_49 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "equipNum", "total", 200)
end
, [51] = function(eventid)
  -- function num : 0_50 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "equipNum", "total", 500)
end
, [52] = function(eventid)
  -- function num : 0_51 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "task", "0", 10)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [53] = function(eventid)
  -- function num : 0_52 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "task", "0", 100)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [54] = function(eventid)
  -- function num : 0_53 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "task", "0", 200)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [55] = function(eventid)
  -- function num : 0_54 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "cavernExplore", "0", 20)
end
, [56] = function(eventid)
  -- function num : 0_55 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "cavernExplore", "0", 100)
end
, [57] = function(eventid)
  -- function num : 0_56 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "autoExplore", "0", 100)
end
, [58] = function(eventid)
  -- function num : 0_57 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "autoExplore", "0", 500)
end
, [59] = function(eventid)
  -- function num : 0_58 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [60] = function(eventid)
  -- function num : 0_59 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [61] = function(eventid)
  -- function num : 0_60 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [62] = function(eventid)
  -- function num : 0_61 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "yardBuildLevel", "0", 2)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [63] = function(eventid)
  -- function num : 0_62 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "yardBuildLevel", "100", 3)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [64] = function(eventid)
  -- function num : 0_63 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "yardBuildLevel", "200", 4)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [65] = function(eventid)
  -- function num : 0_64 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "yardBuildLevel", "300", 1)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [66] = function(eventid)
  -- function num : 0_65 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "yardBuildLevel", "100", 3)
  root:AddTask(trigger0)
  local trigger1 = (TriggerManager.CreateTrigger)("counter", eventid, "yardBuildLevel", "200", 4)
  root:AddTask(trigger1)
  local trigger2 = (TriggerManager.CreateTrigger)("counter", eventid, "yardBuildLevel", "300", 1)
  root:AddTask(trigger2)
  local trigger3 = (TriggerManager.CreateTrigger)("counter", eventid, "yardBuildLevel", "400", 3)
  root:AddTask(trigger3)
  local trigger4 = (TriggerManager.CreateTrigger)("counter", eventid, "yardBuildLevel", "500", 3)
  root:AddTask(trigger4)
  local trigger5 = (TriggerManager.CreateTrigger)("counter", eventid, "yardBuildLevel", "600", 3)
  root:AddTask(trigger5)
  do
    local trigger6 = (TriggerManager.CreateTrigger)("counter", eventid, "yardBuildLevel", "700", 1)
    root:AddTask(trigger6)
    upper:AddTask(root)
    return root
  end
end
, [67] = function(eventid)
  -- function num : 0_66 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "unlockroom", "total", 3)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [68] = function(eventid)
  -- function num : 0_67 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "unlockroom", "total", 2)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [69] = function(eventid)
  -- function num : 0_68 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "buyitem", "9", 1)
end
, [70] = function(eventid)
  -- function num : 0_69 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "buyitem", "13", 1)
end
, [71] = function(eventid)
  -- function num : 0_70 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "equipfumo", "total", 1)
end
, [72] = function(eventid)
  -- function num : 0_71 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "equipfumo", "total", 100)
end
, [73] = function(eventid)
  -- function num : 0_72 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "equipfumo", "total", 500)
end
, [74] = function(eventid)
  -- function num : 0_73 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "equipstrengthen", "total", 1)
end
, [75] = function(eventid)
  -- function num : 0_74 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "equipstrengthen", "total", 100)
end
, [76] = function(eventid)
  -- function num : 0_75 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "equipstrengthen", "total", 500)
end
, [77] = function(eventid)
  -- function num : 0_76 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "stairLevel", "total", 136)
end
, [78] = function(eventid)
  -- function num : 0_77 , upvalues : ComposedTrigger, Or, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (Or.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "card", "3", 100)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [79] = function(eventid)
  -- function num : 0_78 , upvalues : ComposedTrigger, Or, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (Or.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "card", "3", 1000)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [80] = function(eventid)
  -- function num : 0_79 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "friendpoint", "", 100)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [81] = function(eventid)
  -- function num : 0_80 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "totalsign", "", 3)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [82] = function(eventid)
  -- function num : 0_81 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "totaltime", "", 2)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [83] = function(eventid)
  -- function num : 0_82 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [84] = function(eventid)
  -- function num : 0_83 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "bossrush", "", 1)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [85] = function(eventid)
  -- function num : 0_84 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "supportrole", "", 5)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [86] = function(eventid)
  -- function num : 0_85 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "runenum", "", 3)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [87] = function(eventid)
  -- function num : 0_86 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "retreatnum", "", 3)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [88] = function(eventid)
  -- function num : 0_87 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "rarityrole", "4", 2)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [89] = function(eventid)
  -- function num : 0_88 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "alchemy", "", 2)
end
, [90] = function(eventid)
  -- function num : 0_89 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "evolution", "2", 2)
end
, [91] = function(eventid)
  -- function num : 0_90 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleSkill", "3", 2)
end
, [92] = function(eventid)
  -- function num : 0_91 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "friendpoint", "", 1000)
end
, [93] = function(eventid)
  -- function num : 0_92 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "friendpoint", "", 5000)
end
, [94] = function(eventid)
  -- function num : 0_93 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "card", "3", 30)
end
, [95] = function(eventid)
  -- function num : 0_94 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "card", "3", 100)
end
, [96] = function(eventid)
  -- function num : 0_95 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "card", "3", 500)
end
, [97] = function(eventid)
  -- function num : 0_96 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "card", "3", 1000)
end
, [98] = function(eventid)
  -- function num : 0_97 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "buyitem", "9", 50)
end
, [99] = function(eventid)
  -- function num : 0_98 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "buyitem", "9", 100)
end
, [100] = function(eventid)
  -- function num : 0_99 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "35018", 100)
end
, [101] = function(eventid)
  -- function num : 0_100 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "35018", 1000)
end
, [102] = function(eventid)
  -- function num : 0_101 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "35018", 5000)
end
, [103] = function(eventid)
  -- function num : 0_102 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "yardBuildLevel", "100", 3)
  root:AddTask(trigger0)
  local trigger1 = (TriggerManager.CreateTrigger)("counter", eventid, "yardBuildLevel", "200", 4)
  root:AddTask(trigger1)
  local trigger2 = (TriggerManager.CreateTrigger)("counter", eventid, "yardBuildLevel", "300", 2)
  root:AddTask(trigger2)
  do
    local trigger3 = (TriggerManager.CreateTrigger)("counter", eventid, "yardBuildLevel", "400", 3)
    root:AddTask(trigger3)
    upper:AddTask(root)
    return root
  end
end
, [104] = function(eventid)
  -- function num : 0_103 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "stairLevel", "total", 236)
end
, [105] = function(eventid)
  -- function num : 0_104 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "stairLevel", "total", 436)
end
, [106] = function(eventid)
  -- function num : 0_105 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "friendpoint", "", 200)
end
, [107] = function(eventid)
  -- function num : 0_106 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "comment", "", 1)
end
, [108] = function(eventid)
  -- function num : 0_107 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "alchemy", "", 2)
end
, [109] = function(eventid)
  -- function num : 0_108 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "alchemy", "", 2)
end
, [110] = function(eventid)
  -- function num : 0_109 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "equipBreak", "2", 2)
end
, [111] = function(eventid)
  -- function num : 0_110
  return 
end
, [112] = function(eventid)
  -- function num : 0_111 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleClothes", "6", 2)
end
, [113] = function(eventid)
  -- function num : 0_112 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "battleAchievement", "1", 10)
end
, [114] = function(eventid)
  -- function num : 0_113 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "giftBag", "1", 5)
end
, [115] = function(eventid)
  -- function num : 0_114 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dreamSpiral", "", 1)
end
, [116] = function(eventid)
  -- function num : 0_115 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "giftBag", "2", 5)
end
, [117] = function(eventid)
  -- function num : 0_116 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dreamDungeon", "", 1)
end
, [118] = function(eventid)
  -- function num : 0_117 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "battleAchievement", "1", 1)
end
, [119] = function(eventid)
  -- function num : 0_118 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "evolution", "1", 1)
end
, [120] = function(eventid)
  -- function num : 0_119 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "evolution", "2", 3)
end
, [121] = function(eventid)
  -- function num : 0_120 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleSkill", "5", 1)
end
, [122] = function(eventid)
  -- function num : 0_121 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleSkill", "5", 3)
end
, [123] = function(eventid)
  -- function num : 0_122 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleClothes", "6", 1)
end
, [124] = function(eventid)
  -- function num : 0_123 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleClothes", "6", 10)
end
, [125] = function(eventid)
  -- function num : 0_124
  return 
end
, [126] = function(eventid)
  -- function num : 0_125
  return 
end
, [127] = function(eventid)
  -- function num : 0_126 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "equipBreak", "1", 3)
end
, [128] = function(eventid)
  -- function num : 0_127 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "equipBreak", "2", 3)
end
, [129] = function(eventid)
  -- function num : 0_128 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "giftBag", "2", 10)
end
, [130] = function(eventid)
  -- function num : 0_129 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dreamSpiral", "", 1)
end
, [131] = function(eventid)
  -- function num : 0_130 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "dreamSpiral", "", 2)
end
, [132] = function(eventid)
  -- function num : 0_131 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "alchemy", "", 1)
end
, [133] = function(eventid)
  -- function num : 0_132 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "alchemy", "", 50)
end
, [134] = function(eventid)
  -- function num : 0_133 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "alchemy", "", 100)
end
, [135] = function(eventid)
  -- function num : 0_134
  return 
end
, [136] = function(eventid)
  -- function num : 0_135
  return 
end
, [137] = function(eventid)
  -- function num : 0_136
  return 
end
, [138] = function(eventid)
  -- function num : 0_137 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "outerSpace", "", 2)
end
, [139] = function(eventid)
  -- function num : 0_138 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "pvpWin", "1", 3)
end
, [140] = function(eventid)
  -- function num : 0_139 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "lockFurnitrue", "", 1)
end
, [141] = function(eventid)
  -- function num : 0_140 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "lockFurnitrue", "", 5)
end
, [142] = function(eventid)
  -- function num : 0_141 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "lockFurnitrue", "", 10)
end
, [143] = function(eventid)
  -- function num : 0_142 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "outerSpace", "", 1)
end
, [144] = function(eventid)
  -- function num : 0_143 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "outerSpace", "", 5)
end
, [145] = function(eventid)
  -- function num : 0_144 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "outerSpace", "", 20)
end
, [146] = function(eventid)
  -- function num : 0_145 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "pvpWin", "1", 10)
end
, [147] = function(eventid)
  -- function num : 0_146 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "pvpWin", "1", 100)
end
, [148] = function(eventid)
  -- function num : 0_147 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "pvpWin", "1", 500)
end
, [149] = function(eventid)
  -- function num : 0_148
  return 
end
, [150] = function(eventid)
  -- function num : 0_149 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "evolution", "3", 6)
end
, [151] = function(eventid)
  -- function num : 0_150
  return 
end
, [152] = function(eventid)
  -- function num : 0_151 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "equipBreak", "1", 1)
end
}
return triggers

