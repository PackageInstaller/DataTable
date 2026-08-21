-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/dungeondata/mission/cmissioncondition.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local triggers = {[1] = function(eventid)
  -- function num : 0_0 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "20001", 5)
end
, [2] = function(eventid)
  -- function num : 0_1 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10001)
end
, [3] = function(eventid)
  -- function num : 0_2 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1127, "Success", "AfterReturn")
end
, [4] = function(eventid)
  -- function num : 0_3
  return 
end
, [5] = function(eventid)
  -- function num : 0_4 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "soulFix", "0", 1)
end
, [6] = function(eventid)
  -- function num : 0_5 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 0, y = 0}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [7] = function(eventid)
  -- function num : 0_6
  return 
end
, [8] = function(eventid)
  -- function num : 0_7 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10004)
end
, [9] = function(eventid)
  -- function num : 0_8 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleconvertskill", "", 1)
end
, [10] = function(eventid)
  -- function num : 0_9 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 3, y = 32}
, 
{x = 4, y = 32}
, 
{x = 5, y = 32}
, 
{x = 6, y = 32}
, 
{x = 7, y = 32}
}, true)
end
, [11] = function(eventid)
  -- function num : 0_10 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1189, "Success", "AfterReturn")
end
, [12] = function(eventid)
  -- function num : 0_11 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10004)
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
  local trigger0 = (TriggerManager.CreateTrigger)("pretask", eventid, 10002)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 23, y = 5}
, 
{x = 23, y = 6}
, 
{x = 23, y = 7}
, 
{x = 23, y = 8}
, 
{x = 23, y = 9}
}, true)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [15] = function(eventid)
  -- function num : 0_14 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 23, y = 5}
, 
{x = 23, y = 6}
, 
{x = 23, y = 7}
}, true)
end
, [16] = function(eventid)
  -- function num : 0_15 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10007)
end
, [17] = function(eventid)
  -- function num : 0_16
  return 
end
, [18] = function(eventid)
  -- function num : 0_17 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10009)
end
, [19] = function(eventid)
  -- function num : 0_18
  return 
end
, [20] = function(eventid)
  -- function num : 0_19 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10008)
end
, [21] = function(eventid)
  -- function num : 0_20 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "20005", 1)
end
, [22] = function(eventid)
  -- function num : 0_21 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("pretask", eventid, 10011)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("counter", eventid, "item", "20007", 1)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [23] = function(eventid)
  -- function num : 0_22 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "20006", 1)
end
, [24] = function(eventid)
  -- function num : 0_23 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("pretask", eventid, 10011)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("counter", eventid, "item", "20007", 1)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [25] = function(eventid)
  -- function num : 0_24 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "1", 1)
end
, [26] = function(eventid)
  -- function num : 0_25 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10013)
end
, [27] = function(eventid)
  -- function num : 0_26 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "equipstrengthen", "total", 1)
end
, [28] = function(eventid)
  -- function num : 0_27 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10014)
end
, [29] = function(eventid)
  -- function num : 0_28 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "friend", "", 1)
end
, [30] = function(eventid)
  -- function num : 0_29 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10014)
end
, [31] = function(eventid)
  -- function num : 0_30 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "buyitem", "", 1)
end
, [32] = function(eventid)
  -- function num : 0_31
  return 
end
, [33] = function(eventid)
  -- function num : 0_32
  return 
end
, [34] = function(eventid)
  -- function num : 0_33 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "20012", 1)
end
, [35] = function(eventid)
  -- function num : 0_34 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1183, "Success", "AfterReturn")
end
, [36] = function(eventid)
  -- function num : 0_35 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10012)
end
, [37] = function(eventid)
  -- function num : 0_36
  return 
end
, [38] = function(eventid)
  -- function num : 0_37 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 17, y = 9}
, 
{x = 18, y = 9}
, 
{x = 19, y = 9}
}, true)
end
, [39] = function(eventid)
  -- function num : 0_38 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 17, y = 26}
, 
{x = 17, y = 27}
, 
{x = 17, y = 28}
, 
{x = 18, y = 26}
, 
{x = 18, y = 27}
, 
{x = 18, y = 28}
, 
{x = 19, y = 26}
, 
{x = 19, y = 27}
, 
{x = 19, y = 28}
}, true)
end
, [40] = function(eventid)
  -- function num : 0_39
  return 
end
, [41] = function(eventid)
  -- function num : 0_40 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "20010", 1)
end
, [42] = function(eventid)
  -- function num : 0_41 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 20003)
end
, [43] = function(eventid)
  -- function num : 0_42
  return 
end
, [44] = function(eventid)
  -- function num : 0_43 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 20005)
end
, [45] = function(eventid)
  -- function num : 0_44 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 12, y = 8}
, 
{x = 13, y = 8}
, 
{x = 14, y = 8}
}, true)
end
, [46] = function(eventid)
  -- function num : 0_45
  return 
end
, [47] = function(eventid)
  -- function num : 0_46 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 20006)
end
, [48] = function(eventid)
  -- function num : 0_47 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 20001)
end
, [49] = function(eventid)
  -- function num : 0_48 , upvalues : ComposedTrigger, Or, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (Or.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 19, y = 23}
, 
{x = 19, y = 24}
, 
{x = 19, y = 25}
, 
{x = 19, y = 26}
, 
{x = 19, y = 27}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [50] = function(eventid)
  -- function num : 0_49 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10009)
end
, [51] = function(eventid)
  -- function num : 0_50
  return 
end
, [52] = function(eventid)
  -- function num : 0_51 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
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
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 11, y = 14}
, 
{x = 12, y = 14}
, 
{x = 13, y = 14}
, 
{x = 14, y = 14}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [54] = function(eventid)
  -- function num : 0_53 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [55] = function(eventid)
  -- function num : 0_54 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "item", "20029", 1)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 20010)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [56] = function(eventid)
  -- function num : 0_55 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "item", "20018", 1)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [57] = function(eventid)
  -- function num : 0_56 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger1 = (TriggerManager.CreateTrigger)("counter", eventid, "item", "20014", 1)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [58] = function(eventid)
  -- function num : 0_57 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "20020", 1)
end
, [59] = function(eventid)
  -- function num : 0_58 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "20030", 1)
end
, [60] = function(eventid)
  -- function num : 0_59 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10019)
end
, [61] = function(eventid)
  -- function num : 0_60 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 16}
, 
{x = 15, y = 17}
, 
{x = 15, y = 18}
, 
{x = 15, y = 19}
, 
{x = 16, y = 16}
, 
{x = 16, y = 17}
, 
{x = 16, y = 18}
, 
{x = 16, y = 19}
, 
{x = 17, y = 16}
, 
{x = 17, y = 17}
, 
{x = 17, y = 18}
, 
{x = 17, y = 19}
, 
{x = 18, y = 16}
, 
{x = 18, y = 17}
, 
{x = 18, y = 18}
, 
{x = 18, y = 19}
, 
{x = 19, y = 16}
, 
{x = 19, y = 17}
, 
{x = 19, y = 18}
, 
{x = 19, y = 19}
, 
{x = 20, y = 16}
, 
{x = 20, y = 17}
, 
{x = 20, y = 18}
, 
{x = 20, y = 19}
, 
{x = 21, y = 16}
, 
{x = 21, y = 17}
, 
{x = 21, y = 18}
, 
{x = 21, y = 19}
, 
{x = 22, y = 16}
, 
{x = 22, y = 17}
, 
{x = 22, y = 18}
, 
{x = 22, y = 19}
}, true)
end
, [62] = function(eventid)
  -- function num : 0_61 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10020)
end
, [63] = function(eventid)
  -- function num : 0_62 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 5, y = 4}
, 
{x = 5, y = 5}
, 
{x = 5, y = 6}
, 
{x = 6, y = 4}
, 
{x = 6, y = 5}
, 
{x = 6, y = 6}
, 
{x = 7, y = 4}
, 
{x = 7, y = 5}
, 
{x = 7, y = 6}
, 
{x = 8, y = 4}
, 
{x = 8, y = 5}
, 
{x = 8, y = 6}
}, true)
end
, [64] = function(eventid)
  -- function num : 0_63 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10021)
end
, [65] = function(eventid)
  -- function num : 0_64 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 14, y = 3}
, 
{x = 14, y = 4}
, 
{x = 14, y = 5}
, 
{x = 14, y = 6}
, 
{x = 14, y = 7}
, 
{x = 14, y = 8}
, 
{x = 14, y = 9}
}, true)
end
, [66] = function(eventid)
  -- function num : 0_65 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10022)
end
, [67] = function(eventid)
  -- function num : 0_66 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1295, "Success", "AfterReturn")
end
, [68] = function(eventid)
  -- function num : 0_67 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("pretask", eventid, 10024)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 19, y = 10}
, 
{x = 19, y = 11}
, 
{x = 19, y = 12}
, 
{x = 19, y = 13}
, 
{x = 20, y = 10}
, 
{x = 20, y = 11}
, 
{x = 20, y = 12}
, 
{x = 20, y = 13}
, 
{x = 21, y = 10}
, 
{x = 21, y = 11}
, 
{x = 21, y = 12}
, 
{x = 21, y = 13}
, 
{x = 22, y = 10}
, 
{x = 22, y = 11}
, 
{x = 22, y = 12}
, 
{x = 22, y = 13}
}, true)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [69] = function(eventid)
  -- function num : 0_68 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "20034", 1)
end
, [70] = function(eventid)
  -- function num : 0_69 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "20021", 1)
end
, [71] = function(eventid)
  -- function num : 0_70 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "20022", 1)
end
, [72] = function(eventid)
  -- function num : 0_71 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "item", "20023", 1)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 10026)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [73] = function(eventid)
  -- function num : 0_72 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "20024", 1)
end
, [74] = function(eventid)
  -- function num : 0_73 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "20019", 1)
end
, [75] = function(eventid)
  -- function num : 0_74 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "20025", 1)
end
, [76] = function(eventid)
  -- function num : 0_75 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "20026", 1)
end
, [77] = function(eventid)
  -- function num : 0_76 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "20027", 1)
end
, [78] = function(eventid)
  -- function num : 0_77 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 20013)
end
, [79] = function(eventid)
  -- function num : 0_78 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "20028", 1)
end
, [80] = function(eventid)
  -- function num : 0_79 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "20031", 1)
end
, [81] = function(eventid)
  -- function num : 0_80 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "20032", 1)
end
, [82] = function(eventid)
  -- function num : 0_81 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [83] = function(eventid)
  -- function num : 0_82 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "item", "20038", 1)
    root:AddTask(trigger0)
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
    local trigger0 = (TriggerManager.CreateTrigger)("counter", eventid, "item", "20036", 1)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [85] = function(eventid)
  -- function num : 0_84 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "card", "3", 10)
end
, [86] = function(eventid)
  -- function num : 0_85
  return 
end
, [87] = function(eventid)
  -- function num : 0_86 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1122, "Either", "Instant")
end
, [88] = function(eventid)
  -- function num : 0_87 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10066)
end
, [89] = function(eventid)
  -- function num : 0_88
  return 
end
, [90] = function(eventid)
  -- function num : 0_89
  return 
end
, [92] = function(eventid)
  -- function num : 0_90
  return 
end
, [93] = function(eventid)
  -- function num : 0_91 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10067)
end
, [95] = function(eventid)
  -- function num : 0_92 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10068)
end
, [99] = function(eventid)
  -- function num : 0_93 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10069)
end
, [101] = function(eventid)
  -- function num : 0_94 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10071)
end
, [105] = function(eventid)
  -- function num : 0_95 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10073)
end
, [107] = function(eventid)
  -- function num : 0_96 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10072)
end
, [109] = function(eventid)
  -- function num : 0_97 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10075)
end
, [113] = function(eventid)
  -- function num : 0_98 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10076)
end
, [115] = function(eventid)
  -- function num : 0_99 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10078)
end
}
return triggers

