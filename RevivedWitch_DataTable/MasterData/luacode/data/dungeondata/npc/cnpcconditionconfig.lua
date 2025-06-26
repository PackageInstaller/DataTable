-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/dungeondata/npc/cnpcconditionconfig.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local triggers = {[1] = function(eventid)
  -- function num : 0_0
  return 
end
, [2] = function(eventid)
  -- function num : 0_1
  return 
end
, [3] = function(eventid)
  -- function num : 0_2 , upvalues : ComposedTrigger, And, Not, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local upper = root
  local root = (Not.Create)()
  do
    do
      local trigger0 = (TriggerManager.CreateTrigger)("pretask", eventid, 20002)
      root:SetTask(trigger0)
      upper:AddTask(root)
      upper:AddTask(root)
      return root
    end
  end
end
, [4] = function(eventid)
  -- function num : 0_3 , upvalues : ComposedTrigger, Or, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (Or.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 20002)
    root:AddTask(trigger1)
    upper:AddTask(root)
    do
      local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 20004)
      root:AddTask(trigger1)
      upper:AddTask(root)
      return root
    end
  end
end
, [5] = function(eventid)
  -- function num : 0_4
  return 
end
, [6] = function(eventid)
  -- function num : 0_5 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 20003)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [7] = function(eventid)
  -- function num : 0_6
  return 
end
, [8] = function(eventid)
  -- function num : 0_7 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 10011)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [9] = function(eventid)
  -- function num : 0_8
  return 
end
, [10] = function(eventid)
  -- function num : 0_9
  return 
end
, [11] = function(eventid)
  -- function num : 0_10
  return 
end
, [12] = function(eventid)
  -- function num : 0_11 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1135, "Success", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [13] = function(eventid)
  -- function num : 0_12
  return 
end
, [14] = function(eventid)
  -- function num : 0_13
  return 
end
, [15] = function(eventid)
  -- function num : 0_14 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [16] = function(eventid)
  -- function num : 0_15 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 3, y = 10}
, 
{x = 4, y = 10}
, 
{x = 5, y = 10}
, 
{x = 6, y = 10}
}, true)
end
, [17] = function(eventid)
  -- function num : 0_16 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("rolestatus", eventid, {type = 1, value = 5})
end
, [18] = function(eventid)
  -- function num : 0_17 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 20001)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [19] = function(eventid)
  -- function num : 0_18 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [20] = function(eventid)
  -- function num : 0_19 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [21] = function(eventid)
  -- function num : 0_20 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [22] = function(eventid)
  -- function num : 0_21 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [23] = function(eventid)
  -- function num : 0_22 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 20002)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [24] = function(eventid)
  -- function num : 0_23 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 20004)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [25] = function(eventid)
  -- function num : 0_24 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 20003)
end
, [26] = function(eventid)
  -- function num : 0_25 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 20005)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [27] = function(eventid)
  -- function num : 0_26 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 20005)
end
, [28] = function(eventid)
  -- function num : 0_27 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 20006)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [29] = function(eventid)
  -- function num : 0_28 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 20006)
end
, [30] = function(eventid)
  -- function num : 0_29 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 20006)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [31] = function(eventid)
  -- function num : 0_30 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 20004)
end
, [32] = function(eventid)
  -- function num : 0_31 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1183, "Success", "Instant")
end
, [33] = function(eventid)
  -- function num : 0_32 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1187, "Success", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [34] = function(eventid)
  -- function num : 0_33 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1187, "Either", "BeforeReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [35] = function(eventid)
  -- function num : 0_34 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 13, y = 9}
, 
{x = 13, y = 10}
, 
{x = 13, y = 11}
, 
{x = 14, y = 9}
, 
{x = 14, y = 10}
, 
{x = 14, y = 11}
, 
{x = 15, y = 9}
, 
{x = 15, y = 10}
, 
{x = 15, y = 11}
, 
{x = 16, y = 9}
, 
{x = 16, y = 10}
, 
{x = 16, y = 11}
}, true)
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
  -- function num : 0_38 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1187, "Success", "Instant")
end
, [40] = function(eventid)
  -- function num : 0_39 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1187, "Success", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [41] = function(eventid)
  -- function num : 0_40 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [42] = function(eventid)
  -- function num : 0_41 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [43] = function(eventid)
  -- function num : 0_42 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [44] = function(eventid)
  -- function num : 0_43 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [45] = function(eventid)
  -- function num : 0_44 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [46] = function(eventid)
  -- function num : 0_45 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [47] = function(eventid)
  -- function num : 0_46 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [48] = function(eventid)
  -- function num : 0_47 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("pretask", eventid, 10022)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [49] = function(eventid)
  -- function num : 0_48 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [50] = function(eventid)
  -- function num : 0_49 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 10025)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [51] = function(eventid)
  -- function num : 0_50 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
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
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 10025)
    root:AddTask(trigger1)
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
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 10025)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [55] = function(eventid)
  -- function num : 0_54 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [56] = function(eventid)
  -- function num : 0_55 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
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
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 20013)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [58] = function(eventid)
  -- function num : 0_57 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 20013)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
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
  -- function num : 0_60 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1307, "Success", "BeforeReturn")
    root:AddTask(trigger0)
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
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1295, "Success", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [63] = function(eventid)
  -- function num : 0_62 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [64] = function(eventid)
  -- function num : 0_63 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [65] = function(eventid)
  -- function num : 0_64 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [66] = function(eventid)
  -- function num : 0_65 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("pretask", eventid, 20009)
    root:AddTask(trigger0)
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
    local trigger0 = (TriggerManager.CreateTrigger)("pretask", eventid, 20009)
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
    local trigger0 = (TriggerManager.CreateTrigger)("pretask", eventid, 20009)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [69] = function(eventid)
  -- function num : 0_68 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [70] = function(eventid)
  -- function num : 0_69 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("pretask", eventid, 20012)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [71] = function(eventid)
  -- function num : 0_70 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [72] = function(eventid)
  -- function num : 0_71 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("pretask", eventid, 20010)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [73] = function(eventid)
  -- function num : 0_72 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("pretask", eventid, 20010)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [74] = function(eventid)
  -- function num : 0_73 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("pretask", eventid, 20010)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [75] = function(eventid)
  -- function num : 0_74 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1294, "Success", "BeforeReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [76] = function(eventid)
  -- function num : 0_75 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [77] = function(eventid)
  -- function num : 0_76 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 20001)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [78] = function(eventid)
  -- function num : 0_77 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 20001)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [79] = function(eventid)
  -- function num : 0_78 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger1 = (TriggerManager.CreateTrigger)("counter", eventid, "item", "20010", 0)
  root:AddTask(trigger1)
  do
    local trigger2 = (TriggerManager.CreateTrigger)("pretask", eventid, 20002)
    root:AddTask(trigger2)
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
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 20002)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [81] = function(eventid)
  -- function num : 0_80
  return 
end
, [82] = function(eventid)
  -- function num : 0_81
  return 
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
  -- function num : 0_83 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
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
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1345, "Success", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [86] = function(eventid)
  -- function num : 0_85 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [87] = function(eventid)
  -- function num : 0_86 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [88] = function(eventid)
  -- function num : 0_87 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [89] = function(eventid)
  -- function num : 0_88 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [90] = function(eventid)
  -- function num : 0_89 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("pretask", eventid, 20015)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [91] = function(eventid)
  -- function num : 0_90 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 20015)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [92] = function(eventid)
  -- function num : 0_91 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("pretask", eventid, 20015)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [93] = function(eventid)
  -- function num : 0_92 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [94] = function(eventid)
  -- function num : 0_93 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [95] = function(eventid)
  -- function num : 0_94 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [96] = function(eventid)
  -- function num : 0_95 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("pretask", eventid, 20017)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [97] = function(eventid)
  -- function num : 0_96
  return 
end
, [98] = function(eventid)
  -- function num : 0_97
  return 
end
, [99] = function(eventid)
  -- function num : 0_98 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("pretask", eventid, 10044)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [100] = function(eventid)
  -- function num : 0_99 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [101] = function(eventid)
  -- function num : 0_100 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [102] = function(eventid)
  -- function num : 0_101 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1367, "Success", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [103] = function(eventid)
  -- function num : 0_102 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1367, "Success", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [104] = function(eventid)
  -- function num : 0_103 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [105] = function(eventid)
  -- function num : 0_104 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [106] = function(eventid)
  -- function num : 0_105 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [107] = function(eventid)
  -- function num : 0_106 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [108] = function(eventid)
  -- function num : 0_107 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [109] = function(eventid)
  -- function num : 0_108 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [110] = function(eventid)
  -- function num : 0_109 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
}
return triggers

