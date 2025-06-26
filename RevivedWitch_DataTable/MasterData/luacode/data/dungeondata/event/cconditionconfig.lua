-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/dungeondata/event/cconditionconfig.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local triggers = {[1] = function(eventid)
  -- function num : 0_0 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 21, y = 1}
, 
{x = 22, y = 1}
}, true)
end
, [2] = function(eventid)
  -- function num : 0_1 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 24, y = 4}
, 
{x = 25, y = 4}
}, true)
end
, [3] = function(eventid)
  -- function num : 0_2 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 27, y = 4}
, 
{x = 28, y = 4}
}, true)
end
, [4] = function(eventid)
  -- function num : 0_3 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 9, y = 0}
, 
{x = 9, y = 1}
, 
{x = 9, y = 2}
, 
{x = 9, y = 3}
, 
{x = 10, y = 0}
, 
{x = 10, y = 1}
, 
{x = 10, y = 2}
, 
{x = 10, y = 3}
}, true)
end
, [5] = function(eventid)
  -- function num : 0_4 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 13, y = 0}
, 
{x = 13, y = 1}
, 
{x = 13, y = 2}
, 
{x = 13, y = 3}
, 
{x = 14, y = 0}
, 
{x = 14, y = 1}
, 
{x = 14, y = 2}
, 
{x = 14, y = 3}
}, true)
end
, [6] = function(eventid)
  -- function num : 0_5 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 45, y = 4}
, 
{x = 46, y = 4}
}, true)
end
, [7] = function(eventid)
  -- function num : 0_6 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 36, y = 18}
, 
{x = 37, y = 18}
, 
{x = 38, y = 18}
}, true)
end
, [8] = function(eventid)
  -- function num : 0_7 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 16, y = 2}
}, true)
end
, [9] = function(eventid)
  -- function num : 0_8 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 30, y = 14}
, 
{x = 31, y = 14}
}, true)
end
, [10] = function(eventid)
  -- function num : 0_9 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 13, y = 30}
, 
{x = 13, y = 31}
, 
{x = 13, y = 32}
, 
{x = 13, y = 33}
, 
{x = 14, y = 30}
, 
{x = 14, y = 31}
, 
{x = 14, y = 32}
, 
{x = 14, y = 33}
}, true)
end
, [11] = function(eventid)
  -- function num : 0_10 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 9, y = 22}
, 
{x = 9, y = 23}
, 
{x = 9, y = 24}
}, true)
end
, [12] = function(eventid)
  -- function num : 0_11 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("dialogueend", eventid, 0)
end
, [13] = function(eventid)
  -- function num : 0_12 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 10, y = 18}
, 
{x = 11, y = 18}
, 
{x = 12, y = 18}
}, true)
end
, [14] = function(eventid)
  -- function num : 0_13 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 5}
, 
{x = 8, y = 6}
, 
{x = 8, y = 7}
, 
{x = 8, y = 8}
}, true)
end
, [15] = function(eventid)
  -- function num : 0_14 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("dialogueend", eventid, 7)
end
, [16] = function(eventid)
  -- function num : 0_15 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 25, y = 22}
, 
{x = 26, y = 22}
, 
{x = 27, y = 22}
, 
{x = 28, y = 22}
, 
{x = 29, y = 22}
}, true)
end
, [17] = function(eventid)
  -- function num : 0_16 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 22, y = 23}
, 
{x = 23, y = 23}
, 
{x = 24, y = 23}
}, true)
end
, [18] = function(eventid)
  -- function num : 0_17 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 20, y = 21}
, 
{x = 21, y = 21}
, 
{x = 22, y = 21}
, 
{x = 23, y = 21}
, 
{x = 24, y = 21}
}, true)
end
, [19] = function(eventid)
  -- function num : 0_18 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 22, y = 19}
, 
{x = 23, y = 19}
, 
{x = 24, y = 19}
}, true)
end
, [20] = function(eventid)
  -- function num : 0_19 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 20, y = 17}
, 
{x = 21, y = 17}
, 
{x = 22, y = 17}
, 
{x = 23, y = 17}
, 
{x = 24, y = 17}
}, true)
end
, [21] = function(eventid)
  -- function num : 0_20 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 22, y = 15}
, 
{x = 23, y = 15}
, 
{x = 24, y = 15}
}, true)
end
, [22] = function(eventid)
  -- function num : 0_21 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 20, y = 13}
, 
{x = 21, y = 13}
, 
{x = 22, y = 13}
, 
{x = 23, y = 13}
, 
{x = 24, y = 13}
}, true)
end
, [23] = function(eventid)
  -- function num : 0_22 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 20, y = 45}
, 
{x = 21, y = 45}
, 
{x = 22, y = 45}
, 
{x = 23, y = 45}
}, true)
end
, [24] = function(eventid)
  -- function num : 0_23 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 22, y = 24}
, 
{x = 23, y = 24}
, 
{x = 24, y = 24}
}, true)
end
, [25] = function(eventid)
  -- function num : 0_24 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 20, y = 20}
, 
{x = 21, y = 20}
, 
{x = 22, y = 20}
, 
{x = 23, y = 20}
, 
{x = 24, y = 20}
}, true)
end
, [26] = function(eventid)
  -- function num : 0_25 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 5, y = 2}
, 
{x = 5, y = 3}
}, true)
end
, [27] = function(eventid)
  -- function num : 0_26 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("dialogueend", eventid, 11)
end
, [28] = function(eventid)
  -- function num : 0_27 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("dialogueend", eventid, 12)
end
, [29] = function(eventid)
  -- function num : 0_28 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("dialogueend", eventid, 13)
end
, [30] = function(eventid)
  -- function num : 0_29 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("dialogueend", eventid, 0)
end
, [31] = function(eventid)
  -- function num : 0_30 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 18, y = 23}
, 
{x = 18, y = 24}
, 
{x = 18, y = 25}
, 
{x = 18, y = 26}
, 
{x = 18, y = 27}
}, true)
  root:AddTask(trigger0)
  local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 20008)
  root:AddTask(trigger1)
  do
    local trigger2 = (TriggerManager.CreateTrigger)("pretask", eventid, 20001)
    root:AddTask(trigger2)
    upper:AddTask(root)
    return root
  end
end
, [32] = function(eventid)
  -- function num : 0_31 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 10, y = 6}
}, true)
end
, [33] = function(eventid)
  -- function num : 0_32 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 17, y = 56}
, 
{x = 17, y = 57}
, 
{x = 18, y = 56}
, 
{x = 18, y = 57}
, 
{x = 19, y = 56}
, 
{x = 19, y = 57}
, 
{x = 20, y = 56}
, 
{x = 20, y = 57}
, 
{x = 21, y = 56}
, 
{x = 21, y = 57}
, 
{x = 22, y = 56}
, 
{x = 22, y = 57}
}, true)
end
, [34] = function(eventid)
  -- function num : 0_33 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 25, y = 39}
}, true)
end
, [35] = function(eventid)
  -- function num : 0_34 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 23, y = 25}
, 
{x = 24, y = 25}
, 
{x = 25, y = 25}
, 
{x = 26, y = 25}
, 
{x = 27, y = 25}
, 
{x = 28, y = 25}
}, true)
end
, [36] = function(eventid)
  -- function num : 0_35 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 32, y = 7}
, 
{x = 32, y = 8}
, 
{x = 32, y = 9}
}, true)
end
, [37] = function(eventid)
  -- function num : 0_36 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("dialogueend", eventid, 8)
end
, [38] = function(eventid)
  -- function num : 0_37 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 19, y = 24}
, 
{x = 19, y = 25}
}, true)
end
, [39] = function(eventid)
  -- function num : 0_38 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 18, y = 24}
, 
{x = 18, y = 25}
}, true)
end
, [40] = function(eventid)
  -- function num : 0_39 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 26, y = 7}
, 
{x = 26, y = 8}
, 
{x = 26, y = 9}
, 
{x = 26, y = 10}
, 
{x = 26, y = 11}
}, true)
end
, [41] = function(eventid)
  -- function num : 0_40 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 20, y = 24}
, 
{x = 20, y = 25}
}, true)
end
, [42] = function(eventid)
  -- function num : 0_41 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 6, y = 52}
, 
{x = 6, y = 53}
, 
{x = 7, y = 52}
, 
{x = 7, y = 53}
}, true)
end
, [43] = function(eventid)
  -- function num : 0_42 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 2003, "Success", "AfterReturn")
end
, [44] = function(eventid)
  -- function num : 0_43 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 12, y = 25}
, 
{x = 13, y = 25}
, 
{x = 14, y = 25}
, 
{x = 15, y = 25}
}, true)
end
, [45] = function(eventid)
  -- function num : 0_44 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 27}
}, true)
end
, [46] = function(eventid)
  -- function num : 0_45 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 9, y = 11}
, 
{x = 9, y = 12}
, 
{x = 10, y = 11}
, 
{x = 10, y = 12}
, 
{x = 11, y = 11}
, 
{x = 11, y = 12}
}, true)
end
, [47] = function(eventid)
  -- function num : 0_46 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 25, y = 40}
}, true)
end
, [48] = function(eventid)
  -- function num : 0_47 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 29, y = 41}
}, true)
end
, [49] = function(eventid)
  -- function num : 0_48 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 2, y = 21}
, 
{x = 3, y = 21}
, 
{x = 4, y = 21}
, 
{x = 5, y = 21}
}, true)
end
, [50] = function(eventid)
  -- function num : 0_49 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 19, y = 10}
, 
{x = 20, y = 10}
, 
{x = 21, y = 10}
}, true)
end
, [51] = function(eventid)
  -- function num : 0_50 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 12, y = 1}
, 
{x = 13, y = 1}
, 
{x = 14, y = 1}
}, true)
end
, [52] = function(eventid)
  -- function num : 0_51 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 12, y = 2}
, 
{x = 13, y = 2}
, 
{x = 14, y = 2}
, 
{x = 15, y = 2}
, 
{x = 16, y = 2}
}, true)
end
, [53] = function(eventid)
  -- function num : 0_52 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 12, y = 2}
, 
{x = 13, y = 2}
, 
{x = 14, y = 2}
, 
{x = 15, y = 2}
, 
{x = 16, y = 2}
}, true)
end
, [54] = function(eventid)
  -- function num : 0_53 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 3, y = 17}
, 
{x = 4, y = 17}
, 
{x = 5, y = 17}
}, true)
end
, [55] = function(eventid)
  -- function num : 0_54 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 23, y = 25}
, 
{x = 24, y = 25}
, 
{x = 25, y = 25}
, 
{x = 26, y = 25}
, 
{x = 27, y = 25}
}, true)
end
, [56] = function(eventid)
  -- function num : 0_55 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 24, y = 38}
, 
{x = 25, y = 38}
, 
{x = 26, y = 38}
}, true)
end
, [57] = function(eventid)
  -- function num : 0_56 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 5, y = 17}
}, true)
end
, [58] = function(eventid)
  -- function num : 0_57 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 6, y = 17}
}, true)
end
, [59] = function(eventid)
  -- function num : 0_58 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 12, y = 13}
}, true)
end
, [60] = function(eventid)
  -- function num : 0_59 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 22, y = 22}
, 
{x = 23, y = 22}
, 
{x = 24, y = 22}
}, true)
end
, [61] = function(eventid)
  -- function num : 0_60 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 5, y = 2}
, 
{x = 5, y = 3}
}, true)
end
, [62] = function(eventid)
  -- function num : 0_61 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 10, y = 2}
, 
{x = 10, y = 3}
}, true)
end
, [63] = function(eventid)
  -- function num : 0_62 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 25, y = 9}
, 
{x = 25, y = 10}
, 
{x = 25, y = 11}
}, true)
end
, [64] = function(eventid)
  -- function num : 0_63 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 25, y = 8}
}, true)
end
, [65] = function(eventid)
  -- function num : 0_64 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 17, y = 64}
}, true)
end
, [66] = function(eventid)
  -- function num : 0_65 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("dialogueend", eventid, 23)
end
, [67] = function(eventid)
  -- function num : 0_66 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 18, y = 64}
}, true)
end
, [68] = function(eventid)
  -- function num : 0_67 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("dialogueend", eventid, 24)
end
, [69] = function(eventid)
  -- function num : 0_68 , upvalues : ComposedTrigger, Or, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (Or.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 14, y = 59}
}, true)
  root:AddTask(trigger0)
  local trigger1 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 56}
, 
{x = 15, y = 57}
, 
{x = 15, y = 58}
, 
{x = 15, y = 59}
}, true)
  root:AddTask(trigger1)
  local trigger2 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 16, y = 56}
, 
{x = 17, y = 56}
, 
{x = 18, y = 56}
, 
{x = 19, y = 56}
}, true)
  root:AddTask(trigger2)
  do
    local trigger3 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 19, y = 57}
}, true)
    root:AddTask(trigger3)
    upper:AddTask(root)
    return root
  end
end
, [70] = function(eventid)
  -- function num : 0_69 , upvalues : ComposedTrigger, Or, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (Or.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 18, y = 52}
, 
{x = 19, y = 52}
, 
{x = 20, y = 52}
, 
{x = 21, y = 52}
, 
{x = 22, y = 52}
, 
{x = 23, y = 52}
}, true)
  root:AddTask(trigger0)
  local trigger1 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 21, y = 42}
}, true)
  root:AddTask(trigger1)
  do
    local trigger2 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 25, y = 43}
}, true)
    root:AddTask(trigger2)
    upper:AddTask(root)
    return root
  end
end
, [71] = function(eventid)
  -- function num : 0_70 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("dialogueend", eventid, 8)
end
, [72] = function(eventid)
  -- function num : 0_71 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 21, y = 7}
, 
{x = 22, y = 7}
, 
{x = 23, y = 7}
, 
{x = 24, y = 7}
, 
{x = 25, y = 7}
, 
{x = 26, y = 7}
, 
{x = 27, y = 7}
}, true)
end
, [73] = function(eventid)
  -- function num : 0_72 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 24, y = 16}
, 
{x = 25, y = 16}
, 
{x = 26, y = 16}
}, true)
end
, [74] = function(eventid)
  -- function num : 0_73 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 24, y = 40}
, 
{x = 25, y = 40}
, 
{x = 26, y = 40}
}, true)
end
, [75] = function(eventid)
  -- function num : 0_74 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 2, y = 27}
}, true)
end
, [76] = function(eventid)
  -- function num : 0_75 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 21, y = 3}
, 
{x = 22, y = 3}
}, true)
end
, [77] = function(eventid)
  -- function num : 0_76 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 25, y = 0}
}, true)
end
, [78] = function(eventid)
  -- function num : 0_77 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 11, y = 14}
, 
{x = 12, y = 14}
, 
{x = 13, y = 14}
}, true)
end
, [79] = function(eventid)
  -- function num : 0_78 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 3, y = 10}
}, true)
end
, [80] = function(eventid)
  -- function num : 0_79 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 24, y = 6}
, 
{x = 25, y = 6}
}, true)
end
, [81] = function(eventid)
  -- function num : 0_80 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 27, y = 6}
, 
{x = 28, y = 6}
}, true)
end
, [82] = function(eventid)
  -- function num : 0_81 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 18, y = 34}
, 
{x = 19, y = 34}
, 
{x = 20, y = 34}
, 
{x = 21, y = 34}
, 
{x = 22, y = 34}
}, true)
end
, [83] = function(eventid)
  -- function num : 0_82 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 19, y = 18}
, 
{x = 20, y = 18}
, 
{x = 21, y = 18}
}, true)
end
, [84] = function(eventid)
  -- function num : 0_83 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 9, y = 29}
, 
{x = 10, y = 29}
, 
{x = 11, y = 29}
}, true)
end
, [85] = function(eventid)
  -- function num : 0_84 , upvalues : ComposedTrigger, Or, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (Or.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 12, y = 18}
, 
{x = 13, y = 18}
, 
{x = 14, y = 18}
, 
{x = 15, y = 18}
, 
{x = 16, y = 18}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [86] = function(eventid)
  -- function num : 0_85 , upvalues : ComposedTrigger, Or, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (Or.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 3, y = 6}
, 
{x = 4, y = 6}
, 
{x = 5, y = 6}
, 
{x = 6, y = 6}
, 
{x = 7, y = 6}
, 
{x = 8, y = 6}
}, true)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 5}
}, true)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [87] = function(eventid)
  -- function num : 0_86 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 3, y = 8}
}, true)
end
, [88] = function(eventid)
  -- function num : 0_87 , upvalues : ComposedTrigger, Or, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (Or.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 25}
}, true)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 25}
}, true)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [89] = function(eventid)
  -- function num : 0_88 , upvalues : ComposedTrigger, Or, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (Or.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 9, y = 0}
, 
{x = 9, y = 1}
, 
{x = 9, y = 2}
, 
{x = 9, y = 3}
, 
{x = 10, y = 0}
, 
{x = 10, y = 1}
, 
{x = 10, y = 2}
, 
{x = 10, y = 3}
}, true)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 13, y = 0}
, 
{x = 13, y = 1}
, 
{x = 13, y = 2}
, 
{x = 13, y = 3}
, 
{x = 14, y = 0}
, 
{x = 14, y = 1}
, 
{x = 14, y = 2}
, 
{x = 14, y = 3}
}, true)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [90] = function(eventid)
  -- function num : 0_89 , upvalues : ComposedTrigger, Or, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (Or.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 23}
, 
{x = 9, y = 23}
}, true)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 14, y = 23}
, 
{x = 15, y = 23}
}, true)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [91] = function(eventid)
  -- function num : 0_90 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 20, y = 37}
}, true)
end
, [92] = function(eventid)
  -- function num : 0_91 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 9, y = 29}
, 
{x = 10, y = 29}
, 
{x = 11, y = 29}
}, true)
end
, [93] = function(eventid)
  -- function num : 0_92 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 16, y = 46}
}, true)
end
, [94] = function(eventid)
  -- function num : 0_93 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 45, y = 6}
, 
{x = 46, y = 6}
}, true)
end
, [95] = function(eventid)
  -- function num : 0_94 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 19, y = 20}
, 
{x = 20, y = 20}
, 
{x = 21, y = 20}
, 
{x = 22, y = 20}
, 
{x = 23, y = 20}
, 
{x = 24, y = 20}
}, true)
end
, [96] = function(eventid)
  -- function num : 0_95 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 22, y = 21}
, 
{x = 23, y = 21}
, 
{x = 24, y = 21}
}, true)
end
, [97] = function(eventid)
  -- function num : 0_96 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 22, y = 11}
, 
{x = 23, y = 11}
, 
{x = 24, y = 11}
}, true)
end
, [98] = function(eventid)
  -- function num : 0_97 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 22, y = 13}
, 
{x = 23, y = 13}
, 
{x = 24, y = 13}
}, true)
end
, [99] = function(eventid)
  -- function num : 0_98 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 32, y = 8}
, 
{x = 32, y = 9}
, 
{x = 32, y = 10}
, 
{x = 32, y = 11}
}, true)
end
, [100] = function(eventid)
  -- function num : 0_99 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 7, y = 7}
, 
{x = 7, y = 8}
}, true)
end
, [101] = function(eventid)
  -- function num : 0_100 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 20, y = 6}
, 
{x = 20, y = 7}
, 
{x = 20, y = 8}
}, true)
end
, [102] = function(eventid)
  -- function num : 0_101 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 23, y = 6}
}, true)
end
, [103] = function(eventid)
  -- function num : 0_102 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 3, y = 13}
}, true)
end
, [104] = function(eventid)
  -- function num : 0_103 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 30, y = 16}
, 
{x = 31, y = 16}
}, true)
end
, [105] = function(eventid)
  -- function num : 0_104 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 1, y = 1}
}, true)
end
, [106] = function(eventid)
  -- function num : 0_105 , upvalues : ComposedTrigger, Or, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (Or.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 5, y = 7}
, 
{x = 5, y = 8}
}, true)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 6, y = 8}
}, true)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [107] = function(eventid)
  -- function num : 0_106 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 4, y = 25}
}, true)
end
, [108] = function(eventid)
  -- function num : 0_107 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 28, y = 3}
, 
{x = 29, y = 3}
}, true)
end
, [109] = function(eventid)
  -- function num : 0_108 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 9, y = 39}
, 
{x = 10, y = 39}
, 
{x = 11, y = 39}
}, true)
end
, [110] = function(eventid)
  -- function num : 0_109 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 20, y = 37}
}, true)
end
, [111] = function(eventid)
  -- function num : 0_110 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 13, y = 19}
, 
{x = 13, y = 20}
, 
{x = 13, y = 21}
}, true)
end
, [112] = function(eventid)
  -- function num : 0_111 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 9, y = 27}
}, true)
end
, [113] = function(eventid)
  -- function num : 0_112 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1187, "Success", "AfterReturn")
end
, [114] = function(eventid)
  -- function num : 0_113 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 18, y = 12}
, 
{x = 19, y = 12}
, 
{x = 20, y = 12}
, 
{x = 21, y = 12}
, 
{x = 22, y = 12}
}, true)
end
, [115] = function(eventid)
  -- function num : 0_114 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("scenedestroy", eventid, 10005)
end
, [116] = function(eventid)
  -- function num : 0_115 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 32, y = 21}
, 
{x = 33, y = 21}
, 
{x = 34, y = 21}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [117] = function(eventid)
  -- function num : 0_116 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1186, "Success", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [118] = function(eventid)
  -- function num : 0_117 , upvalues : ComposedTrigger, And, _ENV
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
, [119] = function(eventid)
  -- function num : 0_118 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1123, "Success", "AfterReturn")
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("battleend", eventid, 1124, "Success", "AfterReturn")
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [120] = function(eventid)
  -- function num : 0_119 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 17, y = 7}
, 
{x = 17, y = 8}
, 
{x = 17, y = 9}
, 
{x = 17, y = 10}
, 
{x = 18, y = 7}
, 
{x = 18, y = 8}
, 
{x = 18, y = 9}
, 
{x = 18, y = 10}
, 
{x = 19, y = 7}
, 
{x = 19, y = 8}
, 
{x = 19, y = 9}
, 
{x = 19, y = 10}
, 
{x = 20, y = 7}
, 
{x = 20, y = 8}
, 
{x = 20, y = 9}
, 
{x = 20, y = 10}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [121] = function(eventid)
  -- function num : 0_120 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 7, y = 6}
, 
{x = 7, y = 7}
, 
{x = 7, y = 8}
, 
{x = 7, y = 9}
, 
{x = 7, y = 10}
, 
{x = 7, y = 11}
, 
{x = 7, y = 12}
, 
{x = 7, y = 13}
, 
{x = 7, y = 14}
, 
{x = 7, y = 15}
, 
{x = 8, y = 6}
, 
{x = 8, y = 7}
, 
{x = 8, y = 8}
, 
{x = 8, y = 9}
, 
{x = 8, y = 10}
, 
{x = 8, y = 11}
, 
{x = 8, y = 12}
, 
{x = 8, y = 13}
, 
{x = 8, y = 14}
, 
{x = 8, y = 15}
, 
{x = 9, y = 6}
, 
{x = 9, y = 7}
, 
{x = 9, y = 8}
, 
{x = 9, y = 9}
, 
{x = 9, y = 10}
, 
{x = 9, y = 11}
, 
{x = 9, y = 12}
, 
{x = 9, y = 13}
, 
{x = 9, y = 14}
, 
{x = 9, y = 15}
, 
{x = 10, y = 6}
, 
{x = 10, y = 7}
, 
{x = 10, y = 8}
, 
{x = 10, y = 9}
, 
{x = 10, y = 10}
, 
{x = 10, y = 11}
, 
{x = 10, y = 12}
, 
{x = 10, y = 13}
, 
{x = 10, y = 14}
, 
{x = 10, y = 15}
, 
{x = 11, y = 6}
, 
{x = 11, y = 7}
, 
{x = 11, y = 8}
, 
{x = 11, y = 9}
, 
{x = 11, y = 10}
, 
{x = 11, y = 11}
, 
{x = 11, y = 12}
, 
{x = 11, y = 13}
, 
{x = 11, y = 14}
, 
{x = 11, y = 15}
, 
{x = 12, y = 6}
, 
{x = 12, y = 7}
, 
{x = 12, y = 8}
, 
{x = 12, y = 9}
, 
{x = 12, y = 10}
, 
{x = 12, y = 11}
, 
{x = 12, y = 12}
, 
{x = 12, y = 13}
, 
{x = 12, y = 14}
, 
{x = 12, y = 15}
, 
{x = 13, y = 6}
, 
{x = 13, y = 7}
, 
{x = 13, y = 8}
, 
{x = 13, y = 9}
, 
{x = 13, y = 10}
, 
{x = 13, y = 11}
, 
{x = 13, y = 12}
, 
{x = 13, y = 13}
, 
{x = 13, y = 14}
, 
{x = 13, y = 15}
, 
{x = 14, y = 6}
, 
{x = 14, y = 7}
, 
{x = 14, y = 8}
, 
{x = 14, y = 9}
, 
{x = 14, y = 10}
, 
{x = 14, y = 11}
, 
{x = 14, y = 12}
, 
{x = 14, y = 13}
, 
{x = 14, y = 14}
, 
{x = 14, y = 15}
, 
{x = 15, y = 6}
, 
{x = 15, y = 7}
, 
{x = 15, y = 8}
, 
{x = 15, y = 9}
, 
{x = 15, y = 10}
, 
{x = 15, y = 11}
, 
{x = 15, y = 12}
, 
{x = 15, y = 13}
, 
{x = 15, y = 14}
, 
{x = 15, y = 15}
, 
{x = 16, y = 6}
, 
{x = 16, y = 7}
, 
{x = 16, y = 8}
, 
{x = 16, y = 9}
, 
{x = 16, y = 10}
, 
{x = 16, y = 11}
, 
{x = 16, y = 12}
, 
{x = 16, y = 13}
, 
{x = 16, y = 14}
, 
{x = 16, y = 15}
}, false)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [122] = function(eventid)
  -- function num : 0_121 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 6, y = 6}
, 
{x = 6, y = 7}
, 
{x = 6, y = 8}
, 
{x = 6, y = 9}
, 
{x = 6, y = 10}
, 
{x = 6, y = 11}
, 
{x = 6, y = 12}
, 
{x = 6, y = 13}
, 
{x = 6, y = 14}
, 
{x = 6, y = 15}
, 
{x = 7, y = 6}
, 
{x = 7, y = 7}
, 
{x = 7, y = 8}
, 
{x = 7, y = 9}
, 
{x = 7, y = 10}
, 
{x = 7, y = 11}
, 
{x = 7, y = 12}
, 
{x = 7, y = 13}
, 
{x = 7, y = 14}
, 
{x = 7, y = 15}
, 
{x = 8, y = 6}
, 
{x = 8, y = 7}
, 
{x = 8, y = 8}
, 
{x = 8, y = 9}
, 
{x = 8, y = 10}
, 
{x = 8, y = 11}
, 
{x = 8, y = 12}
, 
{x = 8, y = 13}
, 
{x = 8, y = 14}
, 
{x = 8, y = 15}
, 
{x = 9, y = 6}
, 
{x = 9, y = 7}
, 
{x = 9, y = 8}
, 
{x = 9, y = 9}
, 
{x = 9, y = 10}
, 
{x = 9, y = 11}
, 
{x = 9, y = 12}
, 
{x = 9, y = 13}
, 
{x = 9, y = 14}
, 
{x = 9, y = 15}
, 
{x = 10, y = 6}
, 
{x = 10, y = 7}
, 
{x = 10, y = 8}
, 
{x = 10, y = 9}
, 
{x = 10, y = 10}
, 
{x = 10, y = 11}
, 
{x = 10, y = 12}
, 
{x = 10, y = 13}
, 
{x = 10, y = 14}
, 
{x = 10, y = 15}
, 
{x = 11, y = 6}
, 
{x = 11, y = 7}
, 
{x = 11, y = 8}
, 
{x = 11, y = 9}
, 
{x = 11, y = 10}
, 
{x = 11, y = 11}
, 
{x = 11, y = 12}
, 
{x = 11, y = 13}
, 
{x = 11, y = 14}
, 
{x = 11, y = 15}
, 
{x = 12, y = 6}
, 
{x = 12, y = 7}
, 
{x = 12, y = 8}
, 
{x = 12, y = 9}
, 
{x = 12, y = 10}
, 
{x = 12, y = 11}
, 
{x = 12, y = 12}
, 
{x = 12, y = 13}
, 
{x = 12, y = 14}
, 
{x = 12, y = 15}
, 
{x = 13, y = 6}
, 
{x = 13, y = 7}
, 
{x = 13, y = 8}
, 
{x = 13, y = 9}
, 
{x = 13, y = 10}
, 
{x = 13, y = 11}
, 
{x = 13, y = 12}
, 
{x = 13, y = 13}
, 
{x = 13, y = 14}
, 
{x = 13, y = 15}
, 
{x = 14, y = 6}
, 
{x = 14, y = 7}
, 
{x = 14, y = 8}
, 
{x = 14, y = 9}
, 
{x = 14, y = 10}
, 
{x = 14, y = 11}
, 
{x = 14, y = 12}
, 
{x = 14, y = 13}
, 
{x = 14, y = 14}
, 
{x = 14, y = 15}
, 
{x = 15, y = 6}
, 
{x = 15, y = 7}
, 
{x = 15, y = 8}
, 
{x = 15, y = 9}
, 
{x = 15, y = 10}
, 
{x = 15, y = 11}
, 
{x = 15, y = 12}
, 
{x = 15, y = 13}
, 
{x = 15, y = 14}
, 
{x = 15, y = 15}
}, false)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [123] = function(eventid)
  -- function num : 0_122 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 4}
, 
{x = 15, y = 5}
, 
{x = 15, y = 6}
, 
{x = 15, y = 7}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [124] = function(eventid)
  -- function num : 0_123 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 18}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [125] = function(eventid)
  -- function num : 0_124 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 11, y = 32}
, 
{x = 12, y = 32}
, 
{x = 13, y = 32}
, 
{x = 14, y = 32}
, 
{x = 15, y = 32}
, 
{x = 16, y = 32}
, 
{x = 17, y = 32}
, 
{x = 18, y = 32}
}, false)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [126] = function(eventid)
  -- function num : 0_125 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 14, y = 4}
, 
{x = 14, y = 5}
, 
{x = 14, y = 6}
, 
{x = 14, y = 7}
, 
{x = 14, y = 8}
}, false)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [127] = function(eventid)
  -- function num : 0_126 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 14, y = 16}
, 
{x = 15, y = 16}
, 
{x = 16, y = 16}
, 
{x = 17, y = 16}
, 
{x = 18, y = 16}
}, false)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [128] = function(eventid)
  -- function num : 0_127 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 11, y = 31}
, 
{x = 12, y = 31}
, 
{x = 13, y = 31}
, 
{x = 14, y = 31}
, 
{x = 15, y = 31}
, 
{x = 16, y = 31}
, 
{x = 17, y = 31}
, 
{x = 18, y = 31}
}, false)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [129] = function(eventid)
  -- function num : 0_128 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 7, y = 11}
, 
{x = 7, y = 12}
, 
{x = 7, y = 13}
, 
{x = 7, y = 14}
, 
{x = 7, y = 15}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [130] = function(eventid)
  -- function num : 0_129 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 5, y = 25}
, 
{x = 6, y = 25}
, 
{x = 7, y = 25}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [131] = function(eventid)
  -- function num : 0_130 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 14, y = 18}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [132] = function(eventid)
  -- function num : 0_131 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 4, y = 13}
, 
{x = 5, y = 13}
, 
{x = 6, y = 13}
, 
{x = 7, y = 13}
, 
{x = 8, y = 13}
, 
{x = 9, y = 13}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [133] = function(eventid)
  -- function num : 0_132 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 4, y = 25}
, 
{x = 5, y = 25}
, 
{x = 6, y = 25}
, 
{x = 7, y = 25}
, 
{x = 8, y = 25}
, 
{x = 9, y = 25}
, 
{x = 10, y = 25}
, 
{x = 11, y = 25}
, 
{x = 12, y = 25}
, 
{x = 13, y = 25}
, 
{x = 14, y = 25}
, 
{x = 15, y = 25}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [134] = function(eventid)
  -- function num : 0_133 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 21}
, 
{x = 9, y = 21}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [135] = function(eventid)
  -- function num : 0_134 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 16, y = 13}
, 
{x = 17, y = 13}
, 
{x = 18, y = 13}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [136] = function(eventid)
  -- function num : 0_135 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 18, y = 18}
, 
{x = 18, y = 19}
, 
{x = 18, y = 20}
, 
{x = 18, y = 21}
, 
{x = 18, y = 22}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [137] = function(eventid)
  -- function num : 0_136 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 18, y = 18}
, 
{x = 18, y = 19}
, 
{x = 18, y = 20}
, 
{x = 18, y = 21}
, 
{x = 18, y = 22}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [138] = function(eventid)
  -- function num : 0_137 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 11, y = 10}
, 
{x = 12, y = 10}
, 
{x = 13, y = 10}
, 
{x = 14, y = 10}
, 
{x = 15, y = 10}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [139] = function(eventid)
  -- function num : 0_138 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 9, y = 9}
, 
{x = 10, y = 9}
, 
{x = 11, y = 9}
, 
{x = 12, y = 9}
, 
{x = 13, y = 9}
, 
{x = 14, y = 9}
, 
{x = 15, y = 9}
, 
{x = 16, y = 9}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [140] = function(eventid)
  -- function num : 0_139 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 7, y = 36}
, 
{x = 8, y = 36}
, 
{x = 9, y = 36}
, 
{x = 10, y = 36}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [141] = function(eventid)
  -- function num : 0_140 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 36}
, 
{x = 15, y = 37}
, 
{x = 15, y = 38}
, 
{x = 15, y = 39}
, 
{x = 15, y = 40}
, 
{x = 16, y = 36}
, 
{x = 16, y = 37}
, 
{x = 16, y = 38}
, 
{x = 16, y = 39}
, 
{x = 16, y = 40}
, 
{x = 17, y = 36}
, 
{x = 17, y = 37}
, 
{x = 17, y = 38}
, 
{x = 17, y = 39}
, 
{x = 17, y = 40}
, 
{x = 18, y = 36}
, 
{x = 18, y = 37}
, 
{x = 18, y = 38}
, 
{x = 18, y = 39}
, 
{x = 18, y = 40}
, 
{x = 19, y = 36}
, 
{x = 19, y = 37}
, 
{x = 19, y = 38}
, 
{x = 19, y = 39}
, 
{x = 19, y = 40}
}, true)
end
, [142] = function(eventid)
  -- function num : 0_141 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 2, y = 21}
, 
{x = 2, y = 22}
, 
{x = 2, y = 23}
, 
{x = 2, y = 24}
, 
{x = 2, y = 25}
, 
{x = 3, y = 21}
, 
{x = 3, y = 22}
, 
{x = 3, y = 23}
, 
{x = 3, y = 24}
, 
{x = 3, y = 25}
, 
{x = 4, y = 21}
, 
{x = 4, y = 22}
, 
{x = 4, y = 23}
, 
{x = 4, y = 24}
, 
{x = 4, y = 25}
, 
{x = 5, y = 21}
, 
{x = 5, y = 22}
, 
{x = 5, y = 23}
, 
{x = 5, y = 24}
, 
{x = 5, y = 25}
, 
{x = 6, y = 21}
, 
{x = 6, y = 22}
, 
{x = 6, y = 23}
, 
{x = 6, y = 24}
, 
{x = 6, y = 25}
, 
{x = 7, y = 21}
, 
{x = 7, y = 22}
, 
{x = 7, y = 23}
, 
{x = 7, y = 24}
, 
{x = 7, y = 25}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [143] = function(eventid)
  -- function num : 0_142 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 11, y = 17}
, 
{x = 12, y = 17}
, 
{x = 13, y = 17}
, 
{x = 14, y = 17}
, 
{x = 15, y = 17}
, 
{x = 16, y = 17}
, 
{x = 17, y = 17}
, 
{x = 18, y = 17}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [144] = function(eventid)
  -- function num : 0_143 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 11, y = 17}
, 
{x = 12, y = 17}
, 
{x = 13, y = 17}
, 
{x = 14, y = 17}
, 
{x = 15, y = 17}
, 
{x = 16, y = 17}
, 
{x = 17, y = 17}
, 
{x = 18, y = 17}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [145] = function(eventid)
  -- function num : 0_144 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 7}
, 
{x = 8, y = 8}
, 
{x = 8, y = 9}
, 
{x = 8, y = 10}
, 
{x = 8, y = 11}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [146] = function(eventid)
  -- function num : 0_145 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 6, y = 12}
, 
{x = 6, y = 13}
, 
{x = 6, y = 14}
, 
{x = 6, y = 15}
, 
{x = 7, y = 12}
, 
{x = 7, y = 13}
, 
{x = 7, y = 14}
, 
{x = 7, y = 15}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [147] = function(eventid)
  -- function num : 0_146 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
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
, 
{x = 9, y = 4}
, 
{x = 9, y = 5}
, 
{x = 9, y = 6}
, 
{x = 10, y = 4}
, 
{x = 10, y = 5}
, 
{x = 10, y = 6}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [148] = function(eventid)
  -- function num : 0_147 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 22, y = 10}
, 
{x = 23, y = 10}
, 
{x = 24, y = 10}
, 
{x = 25, y = 10}
, 
{x = 26, y = 10}
, 
{x = 27, y = 10}
, 
{x = 28, y = 10}
, 
{x = 29, y = 10}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [149] = function(eventid)
  -- function num : 0_148 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 22, y = 8}
, 
{x = 23, y = 8}
, 
{x = 24, y = 8}
, 
{x = 25, y = 8}
, 
{x = 26, y = 8}
, 
{x = 27, y = 8}
, 
{x = 28, y = 8}
, 
{x = 29, y = 8}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [150] = function(eventid)
  -- function num : 0_149 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 19, y = 20}
, 
{x = 20, y = 20}
, 
{x = 21, y = 20}
, 
{x = 22, y = 20}
, 
{x = 23, y = 20}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [151] = function(eventid)
  -- function num : 0_150 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 9, y = 18}
, 
{x = 9, y = 19}
, 
{x = 9, y = 20}
, 
{x = 9, y = 21}
, 
{x = 9, y = 22}
, 
{x = 9, y = 23}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [152] = function(eventid)
  -- function num : 0_151 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 18}
, 
{x = 8, y = 19}
, 
{x = 8, y = 20}
, 
{x = 8, y = 21}
, 
{x = 8, y = 22}
, 
{x = 8, y = 23}
, 
{x = 8, y = 24}
, 
{x = 8, y = 25}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [153] = function(eventid)
  -- function num : 0_152 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 10, y = 17}
, 
{x = 11, y = 17}
, 
{x = 12, y = 17}
, 
{x = 13, y = 17}
, 
{x = 14, y = 17}
, 
{x = 15, y = 17}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [154] = function(eventid)
  -- function num : 0_153 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 10, y = 17}
, 
{x = 11, y = 17}
, 
{x = 12, y = 17}
, 
{x = 13, y = 17}
, 
{x = 14, y = 17}
, 
{x = 15, y = 17}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [155] = function(eventid)
  -- function num : 0_154 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 7, y = 17}
, 
{x = 8, y = 17}
, 
{x = 9, y = 17}
, 
{x = 10, y = 17}
, 
{x = 11, y = 17}
, 
{x = 12, y = 17}
, 
{x = 13, y = 17}
, 
{x = 14, y = 17}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [156] = function(eventid)
  -- function num : 0_155 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 11, y = 50}
, 
{x = 12, y = 50}
, 
{x = 13, y = 50}
, 
{x = 14, y = 50}
, 
{x = 15, y = 50}
, 
{x = 16, y = 50}
, 
{x = 17, y = 50}
, 
{x = 18, y = 50}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [157] = function(eventid)
  -- function num : 0_156 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 11, y = 50}
, 
{x = 12, y = 50}
, 
{x = 13, y = 50}
, 
{x = 14, y = 50}
, 
{x = 15, y = 50}
, 
{x = 16, y = 50}
, 
{x = 17, y = 50}
, 
{x = 18, y = 50}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [158] = function(eventid)
  -- function num : 0_157 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 21, y = 22}
, 
{x = 22, y = 22}
, 
{x = 23, y = 22}
, 
{x = 24, y = 22}
, 
{x = 25, y = 22}
, 
{x = 26, y = 22}
, 
{x = 27, y = 22}
, 
{x = 28, y = 22}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [159] = function(eventid)
  -- function num : 0_158 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 2, y = 11}
, 
{x = 3, y = 11}
, 
{x = 4, y = 11}
, 
{x = 5, y = 11}
, 
{x = 6, y = 11}
, 
{x = 7, y = 11}
, 
{x = 8, y = 11}
, 
{x = 9, y = 11}
, 
{x = 10, y = 11}
, 
{x = 11, y = 11}
, 
{x = 12, y = 11}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [160] = function(eventid)
  -- function num : 0_159 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 17, y = 26}
, 
{x = 17, y = 27}
, 
{x = 18, y = 26}
, 
{x = 18, y = 27}
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
, [161] = function(eventid)
  -- function num : 0_160 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 17, y = 26}
, 
{x = 17, y = 27}
, 
{x = 18, y = 26}
, 
{x = 18, y = 27}
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
, [162] = function(eventid)
  -- function num : 0_161 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 17, y = 26}
, 
{x = 17, y = 27}
, 
{x = 18, y = 26}
, 
{x = 18, y = 27}
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
, [163] = function(eventid)
  -- function num : 0_162 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 17, y = 26}
, 
{x = 17, y = 27}
, 
{x = 18, y = 26}
, 
{x = 18, y = 27}
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
, [164] = function(eventid)
  -- function num : 0_163 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1355, "Success", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [165] = function(eventid)
  -- function num : 0_164 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 7, y = 15}
, 
{x = 8, y = 15}
, 
{x = 9, y = 15}
, 
{x = 10, y = 15}
, 
{x = 11, y = 15}
, 
{x = 12, y = 15}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [166] = function(eventid)
  -- function num : 0_165 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("pretask", eventid, 10040)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [167] = function(eventid)
  -- function num : 0_166 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 3, y = 30}
, 
{x = 4, y = 30}
, 
{x = 5, y = 30}
, 
{x = 6, y = 30}
, 
{x = 7, y = 30}
}, true)
end
, [168] = function(eventid)
  -- function num : 0_167 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
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
end
, [169] = function(eventid)
  -- function num : 0_168 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 32, y = 12}
, 
{x = 33, y = 12}
, 
{x = 34, y = 12}
, 
{x = 35, y = 12}
, 
{x = 36, y = 12}
}, true)
end
, [170] = function(eventid)
  -- function num : 0_169 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 31, y = 23}
, 
{x = 32, y = 23}
, 
{x = 33, y = 23}
, 
{x = 34, y = 23}
}, true)
end
, [171] = function(eventid)
  -- function num : 0_170 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 39}
, 
{x = 9, y = 39}
, 
{x = 10, y = 39}
}, true)
end
, [172] = function(eventid)
  -- function num : 0_171 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 18, y = 19}
, 
{x = 18, y = 20}
, 
{x = 18, y = 21}
, 
{x = 18, y = 22}
, 
{x = 18, y = 23}
}, true)
end
, [173] = function(eventid)
  -- function num : 0_172 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1135, "Success", "AfterReturn")
end
, [174] = function(eventid)
  -- function num : 0_173 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 14}
, 
{x = 16, y = 14}
, 
{x = 17, y = 14}
}, true)
end
, [175] = function(eventid)
  -- function num : 0_174 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1135, "Fail", "AfterReturn")
end
, [176] = function(eventid)
  -- function num : 0_175 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 17, y = 20}
, 
{x = 17, y = 21}
, 
{x = 17, y = 22}
, 
{x = 17, y = 23}
}, true)
end
, [177] = function(eventid)
  -- function num : 0_176 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 7, y = 7}
, 
{x = 7, y = 8}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [178] = function(eventid)
  -- function num : 0_177 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1187, "Fail", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [179] = function(eventid)
  -- function num : 0_178 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 17, y = 27}
, 
{x = 18, y = 27}
, 
{x = 19, y = 27}
, 
{x = 20, y = 27}
, 
{x = 21, y = 27}
, 
{x = 22, y = 27}
, 
{x = 23, y = 27}
}, true)
end
, [180] = function(eventid)
  -- function num : 0_179 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1189, "Success", "AfterReturn")
end
, [181] = function(eventid)
  -- function num : 0_180 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 17, y = 16}
, 
{x = 18, y = 16}
, 
{x = 19, y = 16}
}, true)
end
, [182] = function(eventid)
  -- function num : 0_181 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 2, y = 17}
, 
{x = 3, y = 17}
, 
{x = 4, y = 17}
, 
{x = 5, y = 17}
, 
{x = 6, y = 17}
, 
{x = 7, y = 17}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [183] = function(eventid)
  -- function num : 0_182 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 21, y = 4}
, 
{x = 21, y = 5}
, 
{x = 21, y = 6}
}, true)
end
, [184] = function(eventid)
  -- function num : 0_183 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1183, "Success", "AfterReturn")
end
, [185] = function(eventid)
  -- function num : 0_184 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 7, y = 10}
, 
{x = 8, y = 10}
, 
{x = 9, y = 10}
, 
{x = 10, y = 10}
, 
{x = 11, y = 10}
}, true)
end
, [186] = function(eventid)
  -- function num : 0_185 , upvalues : ComposedTrigger, Or, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (Or.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 7, y = 11}
, 
{x = 8, y = 11}
, 
{x = 9, y = 11}
, 
{x = 10, y = 11}
, 
{x = 11, y = 11}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [187] = function(eventid)
  -- function num : 0_186 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1134, "Success", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [188] = function(eventid)
  -- function num : 0_187 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1134, "Fail", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [189] = function(eventid)
  -- function num : 0_188 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1191, "Success", "AfterReturn")
end
, [190] = function(eventid)
  -- function num : 0_189 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1127, "Fail", "AfterReturn")
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 20, y = 8}
}, true)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [191] = function(eventid)
  -- function num : 0_190 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1127, "Success", "AfterReturn")
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 17, y = 35}
, 
{x = 17, y = 36}
, 
{x = 18, y = 35}
, 
{x = 18, y = 36}
, 
{x = 19, y = 35}
, 
{x = 19, y = 36}
, 
{x = 20, y = 35}
, 
{x = 20, y = 36}
, 
{x = 21, y = 35}
, 
{x = 21, y = 36}
, 
{x = 22, y = 35}
, 
{x = 22, y = 36}
, 
{x = 23, y = 35}
, 
{x = 23, y = 36}
, 
{x = 24, y = 35}
, 
{x = 24, y = 36}
, 
{x = 25, y = 35}
, 
{x = 25, y = 36}
, 
{x = 26, y = 35}
, 
{x = 26, y = 36}
}, true)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [192] = function(eventid)
  -- function num : 0_191 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1127, "Fail", "AfterReturn")
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 17, y = 35}
, 
{x = 17, y = 36}
, 
{x = 18, y = 35}
, 
{x = 18, y = 36}
, 
{x = 19, y = 35}
, 
{x = 19, y = 36}
, 
{x = 20, y = 35}
, 
{x = 20, y = 36}
, 
{x = 21, y = 35}
, 
{x = 21, y = 36}
, 
{x = 22, y = 35}
, 
{x = 22, y = 36}
, 
{x = 23, y = 35}
, 
{x = 23, y = 36}
, 
{x = 24, y = 35}
, 
{x = 24, y = 36}
, 
{x = 25, y = 35}
, 
{x = 25, y = 36}
, 
{x = 26, y = 35}
, 
{x = 26, y = 36}
}, true)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [193] = function(eventid)
  -- function num : 0_192 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 40, y = 5}
, 
{x = 40, y = 6}
, 
{x = 40, y = 7}
, 
{x = 41, y = 5}
, 
{x = 41, y = 6}
, 
{x = 41, y = 7}
, 
{x = 42, y = 5}
, 
{x = 42, y = 6}
, 
{x = 42, y = 7}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [194] = function(eventid)
  -- function num : 0_193 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 16, y = 40}
, 
{x = 17, y = 40}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [195] = function(eventid)
  -- function num : 0_194 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1186, "Either", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [196] = function(eventid)
  -- function num : 0_195 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 11, y = 8}
, 
{x = 12, y = 8}
, 
{x = 13, y = 8}
, 
{x = 14, y = 8}
}, true)
end
, [197] = function(eventid)
  -- function num : 0_196 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1186, "Either", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [198] = function(eventid)
  -- function num : 0_197 , upvalues : ComposedTrigger, Or, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (Or.Create)()
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 20001)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [199] = function(eventid)
  -- function num : 0_198 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 2, y = 27}
}, true)
end
, [200] = function(eventid)
  -- function num : 0_199 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1189, "Fail", "Instant")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [201] = function(eventid)
  -- function num : 0_200 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1127, "Success", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [202] = function(eventid)
  -- function num : 0_201 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [203] = function(eventid)
  -- function num : 0_202 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 3, y = 20}
, 
{x = 3, y = 21}
, 
{x = 4, y = 20}
, 
{x = 4, y = 21}
, 
{x = 5, y = 20}
, 
{x = 5, y = 21}
, 
{x = 6, y = 20}
, 
{x = 6, y = 21}
, 
{x = 7, y = 20}
, 
{x = 7, y = 21}
, 
{x = 8, y = 20}
, 
{x = 8, y = 21}
}, true)
end
, [204] = function(eventid)
  -- function num : 0_203 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 3, y = 13}
, 
{x = 4, y = 13}
, 
{x = 5, y = 13}
, 
{x = 6, y = 13}
, 
{x = 7, y = 13}
, 
{x = 8, y = 13}
}, true)
end
, [205] = function(eventid)
  -- function num : 0_204 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 6, y = 12}
, 
{x = 7, y = 12}
, 
{x = 8, y = 12}
}, true)
end
, [206] = function(eventid)
  -- function num : 0_205 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 0, y = 0}
}, true)
end
, [207] = function(eventid)
  -- function num : 0_206 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 9, y = 9}
, 
{x = 9, y = 10}
, 
{x = 9, y = 11}
}, true)
end
, [208] = function(eventid)
  -- function num : 0_207 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 19, y = 15}
, 
{x = 19, y = 16}
, 
{x = 19, y = 17}
, 
{x = 19, y = 18}
, 
{x = 19, y = 19}
}, true)
end
, [209] = function(eventid)
  -- function num : 0_208 , upvalues : ComposedTrigger, Or, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (Or.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 21, y = 14}
, 
{x = 22, y = 14}
, 
{x = 23, y = 14}
, 
{x = 24, y = 14}
, 
{x = 25, y = 14}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [210] = function(eventid)
  -- function num : 0_209 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 20, y = 9}
, 
{x = 21, y = 9}
, 
{x = 22, y = 9}
}, true)
end
, [211] = function(eventid)
  -- function num : 0_210 , upvalues : ComposedTrigger, And, _ENV
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
, [212] = function(eventid)
  -- function num : 0_211 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 6, y = 17}
, 
{x = 7, y = 17}
, 
{x = 8, y = 17}
, 
{x = 9, y = 17}
, 
{x = 10, y = 17}
, 
{x = 11, y = 17}
, 
{x = 12, y = 17}
, 
{x = 13, y = 17}
, 
{x = 14, y = 17}
, 
{x = 15, y = 17}
, 
{x = 16, y = 17}
, 
{x = 17, y = 17}
, 
{x = 18, y = 17}
, 
{x = 19, y = 17}
, 
{x = 20, y = 17}
, 
{x = 21, y = 17}
}, true)
end
, [213] = function(eventid)
  -- function num : 0_212 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 17, y = 18}
, 
{x = 18, y = 18}
, 
{x = 19, y = 18}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [214] = function(eventid)
  -- function num : 0_213 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 7, y = 10}
, 
{x = 7, y = 11}
, 
{x = 7, y = 12}
, 
{x = 7, y = 13}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [215] = function(eventid)
  -- function num : 0_214 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 1, y = 20}
, 
{x = 1, y = 21}
, 
{x = 2, y = 20}
, 
{x = 2, y = 21}
, 
{x = 3, y = 20}
, 
{x = 3, y = 21}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [216] = function(eventid)
  -- function num : 0_215 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 17, y = 25}
, 
{x = 17, y = 26}
, 
{x = 18, y = 25}
, 
{x = 18, y = 26}
, 
{x = 19, y = 25}
, 
{x = 19, y = 26}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [217] = function(eventid)
  -- function num : 0_216 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 21, y = 4}
, 
{x = 21, y = 5}
, 
{x = 21, y = 6}
}, true)
end
, [218] = function(eventid)
  -- function num : 0_217 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 13}
, 
{x = 15, y = 14}
, 
{x = 15, y = 15}
, 
{x = 16, y = 13}
, 
{x = 16, y = 14}
, 
{x = 16, y = 15}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [219] = function(eventid)
  -- function num : 0_218 , upvalues : ComposedTrigger, And, _ENV
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
, [220] = function(eventid)
  -- function num : 0_219 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 19, y = 12}
, 
{x = 19, y = 13}
, 
{x = 20, y = 12}
, 
{x = 20, y = 13}
, 
{x = 21, y = 12}
, 
{x = 21, y = 13}
, 
{x = 22, y = 12}
, 
{x = 22, y = 13}
, 
{x = 23, y = 12}
, 
{x = 23, y = 13}
, 
{x = 24, y = 12}
, 
{x = 24, y = 13}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [221] = function(eventid)
  -- function num : 0_220 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 11, y = 22}
, 
{x = 11, y = 23}
, 
{x = 11, y = 24}
, 
{x = 11, y = 25}
, 
{x = 11, y = 26}
}, true)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 20010)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [222] = function(eventid)
  -- function num : 0_221 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 23}
, 
{x = 15, y = 24}
, 
{x = 15, y = 25}
, 
{x = 15, y = 26}
, 
{x = 15, y = 27}
, 
{x = 15, y = 28}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [223] = function(eventid)
  -- function num : 0_222 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 3, y = 27}
, 
{x = 4, y = 27}
, 
{x = 5, y = 27}
, 
{x = 6, y = 27}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [224] = function(eventid)
  -- function num : 0_223 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 4, y = 5}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [225] = function(eventid)
  -- function num : 0_224 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1295, "Success", "AfterReturn")
end
, [226] = function(eventid)
  -- function num : 0_225 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1295, "Success", "AfterReturn")
end
, [227] = function(eventid)
  -- function num : 0_226 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 16, y = 17}
}, true)
end
, [228] = function(eventid)
  -- function num : 0_227 , upvalues : ComposedTrigger, And, _ENV
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
, [229] = function(eventid)
  -- function num : 0_228 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 3, y = 26}
, 
{x = 4, y = 26}
, 
{x = 5, y = 26}
, 
{x = 6, y = 26}
, 
{x = 7, y = 26}
, 
{x = 8, y = 26}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [230] = function(eventid)
  -- function num : 0_229 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 5, y = 5}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [231] = function(eventid)
  -- function num : 0_230 , upvalues : ComposedTrigger, And, _ENV
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
, [232] = function(eventid)
  -- function num : 0_231 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 14}
, 
{x = 9, y = 14}
, 
{x = 10, y = 14}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [233] = function(eventid)
  -- function num : 0_232 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 20, y = 26}
, 
{x = 21, y = 26}
, 
{x = 22, y = 26}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [234] = function(eventid)
  -- function num : 0_233 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 16, y = 17}
, 
{x = 16, y = 18}
, 
{x = 16, y = 19}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [235] = function(eventid)
  -- function num : 0_234 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 16, y = 17}
, 
{x = 16, y = 18}
, 
{x = 16, y = 19}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [236] = function(eventid)
  -- function num : 0_235 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 16, y = 15}
, 
{x = 16, y = 16}
, 
{x = 16, y = 17}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [237] = function(eventid)
  -- function num : 0_236 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 22}
, 
{x = 9, y = 22}
, 
{x = 10, y = 22}
, 
{x = 11, y = 22}
, 
{x = 12, y = 22}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [238] = function(eventid)
  -- function num : 0_237 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 22}
, 
{x = 9, y = 22}
, 
{x = 10, y = 22}
, 
{x = 11, y = 22}
, 
{x = 12, y = 22}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [239] = function(eventid)
  -- function num : 0_238 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 19, y = 3}
, 
{x = 19, y = 4}
, 
{x = 19, y = 5}
, 
{x = 19, y = 6}
, 
{x = 19, y = 7}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [240] = function(eventid)
  -- function num : 0_239 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 16, y = 8}
, 
{x = 16, y = 9}
, 
{x = 16, y = 10}
, 
{x = 16, y = 11}
, 
{x = 16, y = 12}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [241] = function(eventid)
  -- function num : 0_240 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 8}
, 
{x = 8, y = 9}
, 
{x = 8, y = 10}
, 
{x = 9, y = 8}
, 
{x = 9, y = 9}
, 
{x = 9, y = 10}
, 
{x = 10, y = 8}
, 
{x = 10, y = 9}
, 
{x = 10, y = 10}
, 
{x = 11, y = 8}
, 
{x = 11, y = 9}
, 
{x = 11, y = 10}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [242] = function(eventid)
  -- function num : 0_241 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 4, y = 5}
, 
{x = 5, y = 5}
, 
{x = 6, y = 5}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [243] = function(eventid)
  -- function num : 0_242 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 4, y = 7}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [244] = function(eventid)
  -- function num : 0_243 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 4, y = 8}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [245] = function(eventid)
  -- function num : 0_244 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 9, y = 21}
, 
{x = 10, y = 21}
, 
{x = 11, y = 21}
, 
{x = 12, y = 21}
, 
{x = 13, y = 21}
, 
{x = 14, y = 21}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [246] = function(eventid)
  -- function num : 0_245 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 9, y = 20}
, 
{x = 10, y = 20}
, 
{x = 11, y = 20}
, 
{x = 12, y = 20}
, 
{x = 13, y = 20}
, 
{x = 14, y = 20}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [247] = function(eventid)
  -- function num : 0_246 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 2, y = 24}
, 
{x = 2, y = 25}
, 
{x = 2, y = 26}
, 
{x = 3, y = 24}
, 
{x = 3, y = 25}
, 
{x = 3, y = 26}
, 
{x = 4, y = 24}
, 
{x = 4, y = 25}
, 
{x = 4, y = 26}
, 
{x = 5, y = 24}
, 
{x = 5, y = 25}
, 
{x = 5, y = 26}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [248] = function(eventid)
  -- function num : 0_247 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 26}
, 
{x = 15, y = 27}
, 
{x = 15, y = 28}
, 
{x = 15, y = 29}
, 
{x = 16, y = 26}
, 
{x = 16, y = 27}
, 
{x = 16, y = 28}
, 
{x = 16, y = 29}
, 
{x = 17, y = 26}
, 
{x = 17, y = 27}
, 
{x = 17, y = 28}
, 
{x = 17, y = 29}
, 
{x = 18, y = 26}
, 
{x = 18, y = 27}
, 
{x = 18, y = 28}
, 
{x = 18, y = 29}
, 
{x = 19, y = 26}
, 
{x = 19, y = 27}
, 
{x = 19, y = 28}
, 
{x = 19, y = 29}
, 
{x = 20, y = 26}
, 
{x = 20, y = 27}
, 
{x = 20, y = 28}
, 
{x = 20, y = 29}
, 
{x = 21, y = 26}
, 
{x = 21, y = 27}
, 
{x = 21, y = 28}
, 
{x = 21, y = 29}
, 
{x = 22, y = 26}
, 
{x = 22, y = 27}
, 
{x = 22, y = 28}
, 
{x = 22, y = 29}
, 
{x = 23, y = 26}
, 
{x = 23, y = 27}
, 
{x = 23, y = 28}
, 
{x = 23, y = 29}
}, true)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 10025)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [249] = function(eventid)
  -- function num : 0_248 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 7}
, 
{x = 8, y = 8}
, 
{x = 8, y = 9}
, 
{x = 8, y = 10}
, 
{x = 8, y = 11}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [250] = function(eventid)
  -- function num : 0_249 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 7}
, 
{x = 8, y = 8}
, 
{x = 8, y = 9}
, 
{x = 8, y = 10}
, 
{x = 8, y = 11}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [251] = function(eventid)
  -- function num : 0_250 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 11, y = 5}
, 
{x = 11, y = 6}
, 
{x = 11, y = 7}
, 
{x = 11, y = 8}
, 
{x = 11, y = 9}
, 
{x = 11, y = 10}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [252] = function(eventid)
  -- function num : 0_251 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 25, y = 9}
, 
{x = 25, y = 10}
, 
{x = 25, y = 11}
, 
{x = 25, y = 12}
}, true)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 20012)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [253] = function(eventid)
  -- function num : 0_252 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1127, "Success", "Instant")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [254] = function(eventid)
  -- function num : 0_253 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 20, y = 17}
, 
{x = 20, y = 18}
, 
{x = 20, y = 19}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [255] = function(eventid)
  -- function num : 0_254 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 11}
, 
{x = 9, y = 11}
, 
{x = 10, y = 11}
, 
{x = 11, y = 11}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [256] = function(eventid)
  -- function num : 0_255 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 34}
, 
{x = 16, y = 34}
, 
{x = 17, y = 34}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [257] = function(eventid)
  -- function num : 0_256 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 26}
, 
{x = 16, y = 26}
, 
{x = 17, y = 26}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [258] = function(eventid)
  -- function num : 0_257 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 19, y = 35}
, 
{x = 20, y = 35}
, 
{x = 21, y = 35}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [259] = function(eventid)
  -- function num : 0_258 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 19, y = 34}
, 
{x = 20, y = 34}
, 
{x = 21, y = 34}
}, true)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("battleend", eventid, 1189, "Success", "AfterReturn")
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [260] = function(eventid)
  -- function num : 0_259 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 20, y = 37}
}, true)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("battleend", eventid, 1189, "Success", "AfterReturn")
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [261] = function(eventid)
  -- function num : 0_260 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 13, y = 19}
, 
{x = 13, y = 20}
, 
{x = 13, y = 21}
, 
{x = 13, y = 22}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [262] = function(eventid)
  -- function num : 0_261 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 12, y = 19}
, 
{x = 12, y = 20}
, 
{x = 12, y = 21}
, 
{x = 12, y = 22}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [263] = function(eventid)
  -- function num : 0_262 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 13}
, 
{x = 9, y = 13}
, 
{x = 10, y = 13}
, 
{x = 11, y = 13}
}, true)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 10026)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [264] = function(eventid)
  -- function num : 0_263 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 20, y = 25}
, 
{x = 21, y = 25}
, 
{x = 22, y = 25}
, 
{x = 23, y = 25}
, 
{x = 24, y = 25}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [265] = function(eventid)
  -- function num : 0_264 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 18, y = 17}
, 
{x = 18, y = 18}
, 
{x = 18, y = 19}
, 
{x = 18, y = 20}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [266] = function(eventid)
  -- function num : 0_265 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 17}
, 
{x = 15, y = 18}
, 
{x = 15, y = 19}
, 
{x = 15, y = 20}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [267] = function(eventid)
  -- function num : 0_266 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 17, y = 15}
, 
{x = 17, y = 16}
, 
{x = 17, y = 17}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [268] = function(eventid)
  -- function num : 0_267 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 17}
, 
{x = 9, y = 17}
, 
{x = 10, y = 17}
, 
{x = 11, y = 17}
, 
{x = 12, y = 17}
, 
{x = 13, y = 17}
, 
{x = 14, y = 17}
, 
{x = 15, y = 17}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [269] = function(eventid)
  -- function num : 0_268 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 5, y = 16}
, 
{x = 6, y = 16}
, 
{x = 7, y = 16}
, 
{x = 8, y = 16}
, 
{x = 9, y = 16}
, 
{x = 10, y = 16}
, 
{x = 11, y = 16}
, 
{x = 12, y = 16}
, 
{x = 13, y = 16}
, 
{x = 14, y = 16}
, 
{x = 15, y = 16}
, 
{x = 16, y = 16}
, 
{x = 17, y = 16}
, 
{x = 18, y = 16}
, 
{x = 19, y = 16}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [270] = function(eventid)
  -- function num : 0_269 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 3}
, 
{x = 15, y = 4}
, 
{x = 15, y = 5}
, 
{x = 15, y = 6}
, 
{x = 15, y = 7}
, 
{x = 15, y = 8}
, 
{x = 15, y = 9}
, 
{x = 15, y = 10}
, 
{x = 15, y = 11}
, 
{x = 15, y = 12}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [271] = function(eventid)
  -- function num : 0_270 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 10, y = 18}
, 
{x = 10, y = 19}
, 
{x = 10, y = 20}
, 
{x = 10, y = 21}
, 
{x = 10, y = 22}
, 
{x = 10, y = 23}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [272] = function(eventid)
  -- function num : 0_271 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 9, y = 18}
, 
{x = 9, y = 19}
, 
{x = 9, y = 20}
, 
{x = 9, y = 21}
, 
{x = 9, y = 22}
, 
{x = 9, y = 23}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [273] = function(eventid)
  -- function num : 0_272 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 21}
, 
{x = 9, y = 21}
, 
{x = 10, y = 21}
, 
{x = 11, y = 21}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [274] = function(eventid)
  -- function num : 0_273 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 26, y = 29}
, 
{x = 26, y = 30}
, 
{x = 26, y = 31}
, 
{x = 27, y = 29}
, 
{x = 27, y = 30}
, 
{x = 27, y = 31}
, 
{x = 28, y = 29}
, 
{x = 28, y = 30}
, 
{x = 28, y = 31}
, 
{x = 29, y = 29}
, 
{x = 29, y = 30}
, 
{x = 29, y = 31}
, 
{x = 30, y = 29}
, 
{x = 30, y = 30}
, 
{x = 30, y = 31}
, 
{x = 31, y = 29}
, 
{x = 31, y = 30}
, 
{x = 31, y = 31}
, 
{x = 32, y = 29}
, 
{x = 32, y = 30}
, 
{x = 32, y = 31}
, 
{x = 33, y = 29}
, 
{x = 33, y = 30}
, 
{x = 33, y = 31}
, 
{x = 34, y = 29}
, 
{x = 34, y = 30}
, 
{x = 34, y = 31}
, 
{x = 35, y = 29}
, 
{x = 35, y = 30}
, 
{x = 35, y = 31}
, 
{x = 36, y = 29}
, 
{x = 36, y = 30}
, 
{x = 36, y = 31}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [275] = function(eventid)
  -- function num : 0_274 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 10}
, 
{x = 16, y = 10}
, 
{x = 17, y = 10}
, 
{x = 18, y = 10}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [276] = function(eventid)
  -- function num : 0_275 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 9}
, 
{x = 16, y = 9}
, 
{x = 17, y = 9}
, 
{x = 18, y = 9}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [277] = function(eventid)
  -- function num : 0_276 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 14, y = 6}
, 
{x = 14, y = 7}
, 
{x = 14, y = 8}
, 
{x = 14, y = 9}
, 
{x = 14, y = 10}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [278] = function(eventid)
  -- function num : 0_277 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 17, y = 7}
, 
{x = 17, y = 8}
, 
{x = 18, y = 7}
, 
{x = 18, y = 8}
, 
{x = 19, y = 7}
, 
{x = 19, y = 8}
, 
{x = 20, y = 7}
, 
{x = 20, y = 8}
, 
{x = 21, y = 7}
, 
{x = 21, y = 8}
, 
{x = 22, y = 7}
, 
{x = 22, y = 8}
, 
{x = 23, y = 7}
, 
{x = 23, y = 8}
}, false)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [279] = function(eventid)
  -- function num : 0_278 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 20, y = 6}
, 
{x = 20, y = 7}
, 
{x = 20, y = 8}
, 
{x = 20, y = 9}
, 
{x = 20, y = 10}
, 
{x = 20, y = 11}
, 
{x = 20, y = 12}
, 
{x = 20, y = 13}
, 
{x = 20, y = 14}
, 
{x = 20, y = 15}
, 
{x = 21, y = 6}
, 
{x = 21, y = 7}
, 
{x = 21, y = 8}
, 
{x = 21, y = 9}
, 
{x = 21, y = 10}
, 
{x = 21, y = 11}
, 
{x = 21, y = 12}
, 
{x = 21, y = 13}
, 
{x = 21, y = 14}
, 
{x = 21, y = 15}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [280] = function(eventid)
  -- function num : 0_279 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1123, "Success", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [281] = function(eventid)
  -- function num : 0_280 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 17, y = 6}
, 
{x = 17, y = 7}
, 
{x = 17, y = 8}
, 
{x = 17, y = 9}
, 
{x = 17, y = 10}
, 
{x = 17, y = 11}
, 
{x = 17, y = 12}
, 
{x = 17, y = 13}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [282] = function(eventid)
  -- function num : 0_281 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 19, y = 10}
, 
{x = 19, y = 11}
, 
{x = 19, y = 12}
}, true)
end
, [283] = function(eventid)
  -- function num : 0_282 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "item", "49500", 1)
end
, [284] = function(eventid)
  -- function num : 0_283 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1295, "Success", "Instant")
end
, [285] = function(eventid)
  -- function num : 0_284 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1295, "Success", "AfterReturn")
end
, [286] = function(eventid)
  -- function num : 0_285 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 20, y = 38}
, 
{x = 20, y = 39}
, 
{x = 21, y = 38}
, 
{x = 21, y = 39}
, 
{x = 22, y = 38}
, 
{x = 22, y = 39}
, 
{x = 23, y = 38}
, 
{x = 23, y = 39}
, 
{x = 24, y = 38}
, 
{x = 24, y = 39}
}, false)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [287] = function(eventid)
  -- function num : 0_286 , upvalues : ComposedTrigger, Not
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (Not.Create)()
    upper:AddTask(root)
    return root
  end
end
, [288] = function(eventid)
  -- function num : 0_287 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 1, y = 21}
, 
{x = 1, y = 22}
, 
{x = 1, y = 23}
, 
{x = 1, y = 24}
, 
{x = 1, y = 25}
, 
{x = 1, y = 26}
, 
{x = 2, y = 21}
, 
{x = 2, y = 22}
, 
{x = 2, y = 23}
, 
{x = 2, y = 24}
, 
{x = 2, y = 25}
, 
{x = 2, y = 26}
, 
{x = 3, y = 21}
, 
{x = 3, y = 22}
, 
{x = 3, y = 23}
, 
{x = 3, y = 24}
, 
{x = 3, y = 25}
, 
{x = 3, y = 26}
, 
{x = 4, y = 21}
, 
{x = 4, y = 22}
, 
{x = 4, y = 23}
, 
{x = 4, y = 24}
, 
{x = 4, y = 25}
, 
{x = 4, y = 26}
, 
{x = 5, y = 21}
, 
{x = 5, y = 22}
, 
{x = 5, y = 23}
, 
{x = 5, y = 24}
, 
{x = 5, y = 25}
, 
{x = 5, y = 26}
, 
{x = 6, y = 21}
, 
{x = 6, y = 22}
, 
{x = 6, y = 23}
, 
{x = 6, y = 24}
, 
{x = 6, y = 25}
, 
{x = 6, y = 26}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [289] = function(eventid)
  -- function num : 0_288 , upvalues : ComposedTrigger, And, _ENV
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
, [290] = function(eventid)
  -- function num : 0_289 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 12, y = 48}
, 
{x = 13, y = 48}
, 
{x = 14, y = 48}
, 
{x = 15, y = 48}
, 
{x = 16, y = 48}
}, true)
end
, [291] = function(eventid)
  -- function num : 0_290 , upvalues : ComposedTrigger, And, _ENV
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
, [292] = function(eventid)
  -- function num : 0_291 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 12, y = 53}
, 
{x = 12, y = 54}
, 
{x = 12, y = 55}
, 
{x = 12, y = 56}
, 
{x = 12, y = 57}
, 
{x = 13, y = 53}
, 
{x = 13, y = 54}
, 
{x = 13, y = 55}
, 
{x = 13, y = 56}
, 
{x = 13, y = 57}
, 
{x = 14, y = 53}
, 
{x = 14, y = 54}
, 
{x = 14, y = 55}
, 
{x = 14, y = 56}
, 
{x = 14, y = 57}
, 
{x = 15, y = 53}
, 
{x = 15, y = 54}
, 
{x = 15, y = 55}
, 
{x = 15, y = 56}
, 
{x = 15, y = 57}
, 
{x = 16, y = 53}
, 
{x = 16, y = 54}
, 
{x = 16, y = 55}
, 
{x = 16, y = 56}
, 
{x = 16, y = 57}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [293] = function(eventid)
  -- function num : 0_292 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 12, y = 24}
, 
{x = 13, y = 24}
, 
{x = 14, y = 24}
, 
{x = 15, y = 24}
, 
{x = 16, y = 24}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [294] = function(eventid)
  -- function num : 0_293 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1295, "Success", "AfterReturn")
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 12, y = 48}
, 
{x = 13, y = 48}
, 
{x = 14, y = 48}
, 
{x = 15, y = 48}
, 
{x = 16, y = 48}
}, true)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [295] = function(eventid)
  -- function num : 0_294 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 6, y = 16}
, 
{x = 7, y = 16}
, 
{x = 8, y = 16}
, 
{x = 9, y = 16}
, 
{x = 10, y = 16}
, 
{x = 11, y = 16}
, 
{x = 12, y = 16}
, 
{x = 13, y = 16}
, 
{x = 14, y = 16}
, 
{x = 15, y = 16}
, 
{x = 16, y = 16}
, 
{x = 17, y = 16}
, 
{x = 18, y = 16}
, 
{x = 19, y = 16}
, 
{x = 20, y = 16}
, 
{x = 21, y = 16}
}, true)
end
, [296] = function(eventid)
  -- function num : 0_295 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1134, "Success", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [297] = function(eventid)
  -- function num : 0_296 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 31, y = 7}
, 
{x = 32, y = 7}
, 
{x = 33, y = 7}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [298] = function(eventid)
  -- function num : 0_297 , upvalues : ComposedTrigger, And, _ENV
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
, [299] = function(eventid)
  -- function num : 0_298 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 37, y = 23}
}, true)
end
, [300] = function(eventid)
  -- function num : 0_299 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 10024)
end
, [301] = function(eventid)
  -- function num : 0_300 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 33, y = 21}
, 
{x = 33, y = 22}
, 
{x = 33, y = 23}
, 
{x = 33, y = 24}
, 
{x = 33, y = 25}
, 
{x = 34, y = 21}
, 
{x = 34, y = 22}
, 
{x = 34, y = 23}
, 
{x = 34, y = 24}
, 
{x = 34, y = 25}
, 
{x = 35, y = 21}
, 
{x = 35, y = 22}
, 
{x = 35, y = 23}
, 
{x = 35, y = 24}
, 
{x = 35, y = 25}
, 
{x = 36, y = 21}
, 
{x = 36, y = 22}
, 
{x = 36, y = 23}
, 
{x = 36, y = 24}
, 
{x = 36, y = 25}
, 
{x = 37, y = 21}
, 
{x = 37, y = 22}
, 
{x = 37, y = 23}
, 
{x = 37, y = 24}
, 
{x = 37, y = 25}
, 
{x = 38, y = 21}
, 
{x = 38, y = 22}
, 
{x = 38, y = 23}
, 
{x = 38, y = 24}
, 
{x = 38, y = 25}
, 
{x = 39, y = 21}
, 
{x = 39, y = 22}
, 
{x = 39, y = 23}
, 
{x = 39, y = 24}
, 
{x = 39, y = 25}
}, true)
end
, [302] = function(eventid)
  -- function num : 0_301 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 24, y = 15}
}, true)
end
, [303] = function(eventid)
  -- function num : 0_302 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 10, y = 11}
, 
{x = 11, y = 11}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [304] = function(eventid)
  -- function num : 0_303 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 10, y = 10}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [305] = function(eventid)
  -- function num : 0_304 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 9, y = 10}
, 
{x = 10, y = 10}
, 
{x = 11, y = 10}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [306] = function(eventid)
  -- function num : 0_305 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 9, y = 10}
, 
{x = 10, y = 10}
, 
{x = 11, y = 10}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [307] = function(eventid)
  -- function num : 0_306 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 14, y = 22}
, 
{x = 15, y = 22}
, 
{x = 16, y = 22}
, 
{x = 17, y = 22}
, 
{x = 18, y = 22}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [308] = function(eventid)
  -- function num : 0_307 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 32, y = 22}
, 
{x = 33, y = 22}
, 
{x = 34, y = 22}
}, false)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 10022)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [309] = function(eventid)
  -- function num : 0_308 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 14, y = 21}
, 
{x = 14, y = 22}
, 
{x = 14, y = 23}
, 
{x = 14, y = 24}
, 
{x = 14, y = 25}
, 
{x = 14, y = 26}
, 
{x = 15, y = 21}
, 
{x = 15, y = 22}
, 
{x = 15, y = 23}
, 
{x = 15, y = 24}
, 
{x = 15, y = 25}
, 
{x = 15, y = 26}
, 
{x = 16, y = 21}
, 
{x = 16, y = 22}
, 
{x = 16, y = 23}
, 
{x = 16, y = 24}
, 
{x = 16, y = 25}
, 
{x = 16, y = 26}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [310] = function(eventid)
  -- function num : 0_309 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 18, y = 5}
, 
{x = 18, y = 6}
, 
{x = 18, y = 7}
, 
{x = 19, y = 5}
, 
{x = 19, y = 6}
, 
{x = 19, y = 7}
, 
{x = 20, y = 5}
, 
{x = 20, y = 6}
, 
{x = 20, y = 7}
, 
{x = 21, y = 5}
, 
{x = 21, y = 6}
, 
{x = 21, y = 7}
, 
{x = 22, y = 5}
, 
{x = 22, y = 6}
, 
{x = 22, y = 7}
, 
{x = 23, y = 5}
, 
{x = 23, y = 6}
, 
{x = 23, y = 7}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [311] = function(eventid)
  -- function num : 0_310 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("pretask", eventid, 10029)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 14, y = 24}
, 
{x = 14, y = 25}
, 
{x = 14, y = 26}
, 
{x = 14, y = 27}
, 
{x = 15, y = 24}
, 
{x = 15, y = 25}
, 
{x = 15, y = 26}
, 
{x = 15, y = 27}
, 
{x = 16, y = 24}
, 
{x = 16, y = 25}
, 
{x = 16, y = 26}
, 
{x = 16, y = 27}
, 
{x = 17, y = 24}
, 
{x = 17, y = 25}
, 
{x = 17, y = 26}
, 
{x = 17, y = 27}
}, true)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [312] = function(eventid)
  -- function num : 0_311 , upvalues : ComposedTrigger, And, _ENV
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
, [313] = function(eventid)
  -- function num : 0_312 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 21, y = 35}
}, true)
end
, [314] = function(eventid)
  -- function num : 0_313 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("pretask", eventid, 10040)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 24}
, 
{x = 8, y = 25}
, 
{x = 9, y = 24}
, 
{x = 9, y = 25}
, 
{x = 10, y = 24}
, 
{x = 10, y = 25}
, 
{x = 11, y = 24}
, 
{x = 11, y = 25}
, 
{x = 12, y = 24}
, 
{x = 12, y = 25}
}, true)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [315] = function(eventid)
  -- function num : 0_314 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1123, "Success", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [316] = function(eventid)
  -- function num : 0_315 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1124, "Success", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [317] = function(eventid)
  -- function num : 0_316 , upvalues : ComposedTrigger, And
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (And.Create)()
    upper:AddTask(root)
    return root
  end
end
, [318] = function(eventid)
  -- function num : 0_317 , upvalues : ComposedTrigger, And, _ENV
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
, [319] = function(eventid)
  -- function num : 0_318 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("pretask", eventid, 10022)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 16, y = 17}
}, true)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [320] = function(eventid)
  -- function num : 0_319 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 12, y = 29}
, 
{x = 12, y = 30}
, 
{x = 13, y = 29}
, 
{x = 13, y = 30}
, 
{x = 14, y = 29}
, 
{x = 14, y = 30}
, 
{x = 15, y = 29}
, 
{x = 15, y = 30}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [321] = function(eventid)
  -- function num : 0_320 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 12, y = 8}
, 
{x = 13, y = 8}
, 
{x = 14, y = 8}
}, true)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 20003)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [322] = function(eventid)
  -- function num : 0_321 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 5}
, 
{x = 15, y = 6}
, 
{x = 15, y = 7}
, 
{x = 16, y = 5}
, 
{x = 16, y = 6}
, 
{x = 16, y = 7}
, 
{x = 17, y = 5}
, 
{x = 17, y = 6}
, 
{x = 17, y = 7}
}, true)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 20005)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [323] = function(eventid)
  -- function num : 0_322 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 23, y = 28}
, 
{x = 23, y = 29}
, 
{x = 24, y = 28}
, 
{x = 24, y = 29}
, 
{x = 25, y = 28}
, 
{x = 25, y = 29}
, 
{x = 26, y = 28}
, 
{x = 26, y = 29}
, 
{x = 27, y = 28}
, 
{x = 27, y = 29}
}, true)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 20006)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [324] = function(eventid)
  -- function num : 0_323 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 13, y = 9}
, 
{x = 13, y = 10}
, 
{x = 13, y = 11}
, 
{x = 13, y = 12}
}, true)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("pretask", eventid, 20002)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [325] = function(eventid)
  -- function num : 0_324 , upvalues : ComposedTrigger, And, _ENV
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
, [326] = function(eventid)
  -- function num : 0_325 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("pretask", eventid, 10042)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [327] = function(eventid)
  -- function num : 0_326 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 5, y = 16}
}, true)
end
, [328] = function(eventid)
  -- function num : 0_327 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 2, y = 29}
, 
{x = 2, y = 30}
, 
{x = 3, y = 29}
, 
{x = 3, y = 30}
, 
{x = 4, y = 29}
, 
{x = 4, y = 30}
, 
{x = 5, y = 29}
, 
{x = 5, y = 30}
, 
{x = 6, y = 29}
, 
{x = 6, y = 30}
, 
{x = 7, y = 29}
, 
{x = 7, y = 30}
, 
{x = 8, y = 29}
, 
{x = 8, y = 30}
, 
{x = 9, y = 29}
, 
{x = 9, y = 30}
, 
{x = 10, y = 29}
, 
{x = 10, y = 30}
}, true)
end
, [329] = function(eventid)
  -- function num : 0_328 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1124, "Fail", "AfterReturn")
end
, [330] = function(eventid)
  -- function num : 0_329 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 19, y = 6}
, 
{x = 19, y = 7}
, 
{x = 19, y = 8}
, 
{x = 19, y = 9}
, 
{x = 19, y = 10}
, 
{x = 20, y = 6}
, 
{x = 20, y = 7}
, 
{x = 20, y = 8}
, 
{x = 20, y = 9}
, 
{x = 20, y = 10}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [331] = function(eventid)
  -- function num : 0_330 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger1 = (TriggerManager.CreateTrigger)("battleend", eventid, 1183, "Fail", "AfterReturn")
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [332] = function(eventid)
  -- function num : 0_331 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 10, y = 8}
, 
{x = 10, y = 9}
, 
{x = 10, y = 10}
, 
{x = 10, y = 11}
, 
{x = 11, y = 8}
, 
{x = 11, y = 9}
, 
{x = 11, y = 10}
, 
{x = 11, y = 11}
, 
{x = 12, y = 8}
, 
{x = 12, y = 9}
, 
{x = 12, y = 10}
, 
{x = 12, y = 11}
, 
{x = 13, y = 8}
, 
{x = 13, y = 9}
, 
{x = 13, y = 10}
, 
{x = 13, y = 11}
, 
{x = 14, y = 8}
, 
{x = 14, y = 9}
, 
{x = 14, y = 10}
, 
{x = 14, y = 11}
, 
{x = 15, y = 8}
, 
{x = 15, y = 9}
, 
{x = 15, y = 10}
, 
{x = 15, y = 11}
, 
{x = 16, y = 8}
, 
{x = 16, y = 9}
, 
{x = 16, y = 10}
, 
{x = 16, y = 11}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [333] = function(eventid)
  -- function num : 0_332 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 2, y = 21}
, 
{x = 3, y = 21}
, 
{x = 4, y = 21}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [334] = function(eventid)
  -- function num : 0_333 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 2, y = 14}
, 
{x = 3, y = 14}
, 
{x = 4, y = 14}
, 
{x = 5, y = 14}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [335] = function(eventid)
  -- function num : 0_334 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 27, y = 18}
, 
{x = 27, y = 19}
, 
{x = 28, y = 18}
, 
{x = 28, y = 19}
, 
{x = 29, y = 18}
, 
{x = 29, y = 19}
, 
{x = 30, y = 18}
, 
{x = 30, y = 19}
, 
{x = 31, y = 18}
, 
{x = 31, y = 19}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [336] = function(eventid)
  -- function num : 0_335 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 1123, "Fail", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [337] = function(eventid)
  -- function num : 0_336 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 9, y = 6}
, 
{x = 9, y = 7}
, 
{x = 10, y = 6}
, 
{x = 10, y = 7}
, 
{x = 11, y = 6}
, 
{x = 11, y = 7}
, 
{x = 12, y = 6}
, 
{x = 12, y = 7}
, 
{x = 13, y = 6}
, 
{x = 13, y = 7}
, 
{x = 14, y = 6}
, 
{x = 14, y = 7}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [338] = function(eventid)
  -- function num : 0_337 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 14, y = 10}
, 
{x = 14, y = 11}
, 
{x = 14, y = 12}
, 
{x = 15, y = 10}
, 
{x = 15, y = 11}
, 
{x = 15, y = 12}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [339] = function(eventid)
  -- function num : 0_338 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 16, y = 9}
, 
{x = 16, y = 10}
, 
{x = 17, y = 9}
, 
{x = 17, y = 10}
, 
{x = 18, y = 9}
, 
{x = 18, y = 10}
, 
{x = 19, y = 9}
, 
{x = 19, y = 10}
, 
{x = 20, y = 9}
, 
{x = 20, y = 10}
, 
{x = 21, y = 9}
, 
{x = 21, y = 10}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [340] = function(eventid)
  -- function num : 0_339 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 4}
, 
{x = 8, y = 5}
, 
{x = 8, y = 6}
, 
{x = 8, y = 7}
, 
{x = 8, y = 8}
, 
{x = 9, y = 4}
, 
{x = 9, y = 5}
, 
{x = 9, y = 6}
, 
{x = 9, y = 7}
, 
{x = 9, y = 8}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [341] = function(eventid)
  -- function num : 0_340 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 12, y = 19}
, 
{x = 12, y = 20}
, 
{x = 13, y = 19}
, 
{x = 13, y = 20}
, 
{x = 14, y = 19}
, 
{x = 14, y = 20}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [342] = function(eventid)
  -- function num : 0_341 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 10, y = 18}
, 
{x = 10, y = 19}
, 
{x = 11, y = 18}
, 
{x = 11, y = 19}
, 
{x = 12, y = 18}
, 
{x = 12, y = 19}
, 
{x = 13, y = 18}
, 
{x = 13, y = 19}
, 
{x = 14, y = 18}
, 
{x = 14, y = 19}
, 
{x = 15, y = 18}
, 
{x = 15, y = 19}
, 
{x = 16, y = 18}
, 
{x = 16, y = 19}
, 
{x = 17, y = 18}
, 
{x = 17, y = 19}
, 
{x = 18, y = 18}
, 
{x = 18, y = 19}
, 
{x = 19, y = 18}
, 
{x = 19, y = 19}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [343] = function(eventid)
  -- function num : 0_342 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 4, y = 28}
, 
{x = 5, y = 28}
, 
{x = 6, y = 28}
, 
{x = 7, y = 28}
, 
{x = 8, y = 28}
, 
{x = 9, y = 28}
, 
{x = 10, y = 28}
, 
{x = 11, y = 28}
, 
{x = 12, y = 28}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [344] = function(eventid)
  -- function num : 0_343 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 4, y = 28}
, 
{x = 5, y = 28}
, 
{x = 6, y = 28}
, 
{x = 7, y = 28}
, 
{x = 8, y = 28}
, 
{x = 9, y = 28}
, 
{x = 10, y = 28}
, 
{x = 11, y = 28}
, 
{x = 12, y = 28}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [345] = function(eventid)
  -- function num : 0_344 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 16, y = 13}
, 
{x = 17, y = 13}
, 
{x = 18, y = 13}
, 
{x = 19, y = 13}
, 
{x = 20, y = 13}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [346] = function(eventid)
  -- function num : 0_345 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [347] = function(eventid)
  -- function num : 0_346 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 14, y = 11}
, 
{x = 15, y = 11}
, 
{x = 16, y = 11}
, 
{x = 17, y = 11}
, 
{x = 18, y = 11}
, 
{x = 19, y = 11}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [348] = function(eventid)
  -- function num : 0_347 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 14, y = 10}
, 
{x = 15, y = 10}
, 
{x = 16, y = 10}
, 
{x = 17, y = 10}
, 
{x = 18, y = 10}
, 
{x = 19, y = 10}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [349] = function(eventid)
  -- function num : 0_348 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 7, y = 19}
, 
{x = 7, y = 20}
, 
{x = 8, y = 19}
, 
{x = 8, y = 20}
, 
{x = 9, y = 19}
, 
{x = 9, y = 20}
, 
{x = 10, y = 19}
, 
{x = 10, y = 20}
, 
{x = 11, y = 19}
, 
{x = 11, y = 20}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [350] = function(eventid)
  -- function num : 0_349 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 26}
, 
{x = 16, y = 26}
, 
{x = 17, y = 26}
, 
{x = 18, y = 26}
, 
{x = 19, y = 26}
, 
{x = 20, y = 26}
, 
{x = 21, y = 26}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [351] = function(eventid)
  -- function num : 0_350 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 14, y = 14}
, 
{x = 15, y = 14}
, 
{x = 16, y = 14}
, 
{x = 17, y = 14}
, 
{x = 18, y = 14}
, 
{x = 19, y = 14}
, 
{x = 20, y = 14}
, 
{x = 21, y = 14}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [352] = function(eventid)
  -- function num : 0_351 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 14, y = 13}
, 
{x = 14, y = 14}
, 
{x = 15, y = 13}
, 
{x = 15, y = 14}
, 
{x = 16, y = 13}
, 
{x = 16, y = 14}
, 
{x = 17, y = 13}
, 
{x = 17, y = 14}
, 
{x = 18, y = 13}
, 
{x = 18, y = 14}
, 
{x = 19, y = 13}
, 
{x = 19, y = 14}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [353] = function(eventid)
  -- function num : 0_352 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 9, y = 29}
, 
{x = 10, y = 29}
, 
{x = 11, y = 29}
, 
{x = 12, y = 29}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [354] = function(eventid)
  -- function num : 0_353 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 17, y = 11}
, 
{x = 18, y = 11}
, 
{x = 19, y = 11}
, 
{x = 20, y = 11}
, 
{x = 21, y = 11}
, 
{x = 22, y = 11}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [355] = function(eventid)
  -- function num : 0_354 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 11, y = 11}
, 
{x = 12, y = 11}
, 
{x = 13, y = 11}
, 
{x = 14, y = 11}
, 
{x = 15, y = 11}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [356] = function(eventid)
  -- function num : 0_355 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 21, y = 42}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [357] = function(eventid)
  -- function num : 0_356 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [358] = function(eventid)
  -- function num : 0_357 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 18, y = 16}
, 
{x = 18, y = 17}
, 
{x = 19, y = 16}
, 
{x = 19, y = 17}
, 
{x = 20, y = 16}
, 
{x = 20, y = 17}
, 
{x = 21, y = 16}
, 
{x = 21, y = 17}
, 
{x = 22, y = 16}
, 
{x = 22, y = 17}
, 
{x = 23, y = 16}
, 
{x = 23, y = 17}
, 
{x = 24, y = 16}
, 
{x = 24, y = 17}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [359] = function(eventid)
  -- function num : 0_358 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 13, y = 14}
, 
{x = 14, y = 14}
, 
{x = 15, y = 14}
, 
{x = 16, y = 14}
, 
{x = 17, y = 14}
, 
{x = 18, y = 14}
, 
{x = 19, y = 14}
, 
{x = 20, y = 14}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [360] = function(eventid)
  -- function num : 0_359 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 19, y = 8}
, 
{x = 20, y = 8}
, 
{x = 21, y = 8}
, 
{x = 22, y = 8}
, 
{x = 23, y = 8}
, 
{x = 24, y = 8}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [361] = function(eventid)
  -- function num : 0_360 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [362] = function(eventid)
  -- function num : 0_361 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 13, y = 27}
, 
{x = 14, y = 27}
, 
{x = 15, y = 27}
, 
{x = 16, y = 27}
, 
{x = 17, y = 27}
, 
{x = 18, y = 27}
, 
{x = 19, y = 27}
, 
{x = 20, y = 27}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [363] = function(eventid)
  -- function num : 0_362 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [364] = function(eventid)
  -- function num : 0_363 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 32, y = 6}
, 
{x = 32, y = 7}
, 
{x = 32, y = 8}
, 
{x = 32, y = 9}
, 
{x = 32, y = 10}
, 
{x = 32, y = 11}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [365] = function(eventid)
  -- function num : 0_364 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 25, y = 6}
, 
{x = 25, y = 7}
, 
{x = 25, y = 8}
, 
{x = 25, y = 9}
, 
{x = 25, y = 10}
, 
{x = 25, y = 11}
, 
{x = 26, y = 6}
, 
{x = 26, y = 7}
, 
{x = 26, y = 8}
, 
{x = 26, y = 9}
, 
{x = 26, y = 10}
, 
{x = 26, y = 11}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [366] = function(eventid)
  -- function num : 0_365 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 13, y = 8}
, 
{x = 13, y = 9}
, 
{x = 13, y = 10}
, 
{x = 13, y = 11}
, 
{x = 13, y = 12}
, 
{x = 13, y = 13}
, 
{x = 13, y = 14}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [367] = function(eventid)
  -- function num : 0_366 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 6}
, 
{x = 15, y = 7}
, 
{x = 15, y = 8}
, 
{x = 15, y = 9}
, 
{x = 15, y = 10}
, 
{x = 15, y = 11}
, 
{x = 15, y = 12}
, 
{x = 15, y = 13}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [368] = function(eventid)
  -- function num : 0_367 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 12, y = 26}
, 
{x = 13, y = 26}
, 
{x = 14, y = 26}
, 
{x = 15, y = 26}
, 
{x = 16, y = 26}
, 
{x = 17, y = 26}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [369] = function(eventid)
  -- function num : 0_368 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 11, y = 17}
, 
{x = 11, y = 18}
, 
{x = 12, y = 17}
, 
{x = 12, y = 18}
, 
{x = 13, y = 17}
, 
{x = 13, y = 18}
, 
{x = 14, y = 17}
, 
{x = 14, y = 18}
, 
{x = 15, y = 17}
, 
{x = 15, y = 18}
, 
{x = 16, y = 17}
, 
{x = 16, y = 18}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [370] = function(eventid)
  -- function num : 0_369 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 13, y = 18}
, 
{x = 14, y = 18}
, 
{x = 15, y = 18}
, 
{x = 16, y = 18}
, 
{x = 17, y = 18}
, 
{x = 18, y = 18}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [371] = function(eventid)
  -- function num : 0_370 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 4, y = 23}
, 
{x = 5, y = 23}
, 
{x = 6, y = 23}
, 
{x = 7, y = 23}
, 
{x = 8, y = 23}
, 
{x = 9, y = 23}
, 
{x = 10, y = 23}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [372] = function(eventid)
  -- function num : 0_371 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 18, y = 11}
, 
{x = 18, y = 12}
, 
{x = 18, y = 13}
, 
{x = 18, y = 14}
, 
{x = 18, y = 15}
, 
{x = 18, y = 16}
, 
{x = 18, y = 17}
, 
{x = 19, y = 11}
, 
{x = 19, y = 12}
, 
{x = 19, y = 13}
, 
{x = 19, y = 14}
, 
{x = 19, y = 15}
, 
{x = 19, y = 16}
, 
{x = 19, y = 17}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [373] = function(eventid)
  -- function num : 0_372 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 12, y = 28}
, 
{x = 12, y = 29}
, 
{x = 12, y = 30}
, 
{x = 12, y = 31}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [374] = function(eventid)
  -- function num : 0_373 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 22, y = 12}
, 
{x = 23, y = 12}
, 
{x = 24, y = 12}
, 
{x = 25, y = 12}
, 
{x = 26, y = 12}
, 
{x = 27, y = 12}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [375] = function(eventid)
  -- function num : 0_374 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 21, y = 11}
, 
{x = 22, y = 11}
, 
{x = 23, y = 11}
, 
{x = 24, y = 11}
, 
{x = 25, y = 11}
, 
{x = 26, y = 11}
, 
{x = 27, y = 11}
, 
{x = 28, y = 11}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [376] = function(eventid)
  -- function num : 0_375 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 11, y = 32}
, 
{x = 11, y = 33}
, 
{x = 12, y = 32}
, 
{x = 12, y = 33}
, 
{x = 13, y = 32}
, 
{x = 13, y = 33}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [377] = function(eventid)
  -- function num : 0_376 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 21, y = 16}
, 
{x = 21, y = 17}
, 
{x = 21, y = 18}
, 
{x = 21, y = 19}
, 
{x = 21, y = 20}
, 
{x = 21, y = 21}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [378] = function(eventid)
  -- function num : 0_377 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 12, y = 10}
, 
{x = 13, y = 10}
, 
{x = 14, y = 10}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [379] = function(eventid)
  -- function num : 0_378 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 23, y = 13}
, 
{x = 23, y = 14}
, 
{x = 23, y = 15}
, 
{x = 23, y = 16}
, 
{x = 23, y = 17}
, 
{x = 23, y = 18}
, 
{x = 23, y = 19}
, 
{x = 24, y = 13}
, 
{x = 24, y = 14}
, 
{x = 24, y = 15}
, 
{x = 24, y = 16}
, 
{x = 24, y = 17}
, 
{x = 24, y = 18}
, 
{x = 24, y = 19}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [380] = function(eventid)
  -- function num : 0_379 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 13, y = 34}
, 
{x = 14, y = 34}
, 
{x = 15, y = 34}
, 
{x = 16, y = 34}
, 
{x = 17, y = 34}
, 
{x = 18, y = 34}
, 
{x = 19, y = 34}
, 
{x = 20, y = 34}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [381] = function(eventid)
  -- function num : 0_380 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 13, y = 33}
, 
{x = 14, y = 33}
, 
{x = 15, y = 33}
, 
{x = 16, y = 33}
, 
{x = 17, y = 33}
, 
{x = 18, y = 33}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [382] = function(eventid)
  -- function num : 0_381 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 22, y = 14}
, 
{x = 22, y = 15}
, 
{x = 22, y = 16}
, 
{x = 22, y = 17}
, 
{x = 22, y = 18}
, 
{x = 22, y = 19}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [383] = function(eventid)
  -- function num : 0_382 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 18, y = 22}
, 
{x = 18, y = 23}
, 
{x = 18, y = 24}
, 
{x = 18, y = 25}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [384] = function(eventid)
  -- function num : 0_383 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 17, y = 13}
, 
{x = 18, y = 13}
, 
{x = 19, y = 13}
, 
{x = 20, y = 13}
, 
{x = 21, y = 13}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [385] = function(eventid)
  -- function num : 0_384 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 3, y = 15}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [386] = function(eventid)
  -- function num : 0_385 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 7, y = 10}
, 
{x = 7, y = 11}
, 
{x = 7, y = 12}
, 
{x = 8, y = 10}
, 
{x = 8, y = 11}
, 
{x = 8, y = 12}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [387] = function(eventid)
  -- function num : 0_386 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 12, y = 6}
, 
{x = 13, y = 6}
, 
{x = 14, y = 6}
, 
{x = 15, y = 6}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [388] = function(eventid)
  -- function num : 0_387 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 13, y = 13}
, 
{x = 14, y = 13}
, 
{x = 15, y = 13}
, 
{x = 16, y = 13}
, 
{x = 17, y = 13}
, 
{x = 18, y = 13}
, 
{x = 19, y = 13}
, 
{x = 20, y = 13}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [389] = function(eventid)
  -- function num : 0_388 , upvalues : ComposedTrigger, And, _ENV
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
, [390] = function(eventid)
  -- function num : 0_389 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 7, y = 13}
, 
{x = 7, y = 14}
, 
{x = 8, y = 13}
, 
{x = 8, y = 14}
, 
{x = 9, y = 13}
, 
{x = 9, y = 14}
, 
{x = 10, y = 13}
, 
{x = 10, y = 14}
, 
{x = 11, y = 13}
, 
{x = 11, y = 14}
, 
{x = 12, y = 13}
, 
{x = 12, y = 14}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [391] = function(eventid)
  -- function num : 0_390 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 7, y = 13}
, 
{x = 7, y = 14}
, 
{x = 8, y = 13}
, 
{x = 8, y = 14}
, 
{x = 9, y = 13}
, 
{x = 9, y = 14}
, 
{x = 10, y = 13}
, 
{x = 10, y = 14}
, 
{x = 11, y = 13}
, 
{x = 11, y = 14}
, 
{x = 12, y = 13}
, 
{x = 12, y = 14}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [392] = function(eventid)
  -- function num : 0_391 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 7, y = 34}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [393] = function(eventid)
  -- function num : 0_392 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 4, y = 6}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [394] = function(eventid)
  -- function num : 0_393 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 7002, "Success", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [395] = function(eventid)
  -- function num : 0_394 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 7003, "Success", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [396] = function(eventid)
  -- function num : 0_395 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 3, y = 7}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [397] = function(eventid)
  -- function num : 0_396 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 7004, "Success", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [398] = function(eventid)
  -- function num : 0_397 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 12, y = 2}
, 
{x = 12, y = 3}
, 
{x = 12, y = 4}
, 
{x = 12, y = 5}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [399] = function(eventid)
  -- function num : 0_398 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 14}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [400] = function(eventid)
  -- function num : 0_399 , upvalues : ComposedTrigger, And, _ENV
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
, [401] = function(eventid)
  -- function num : 0_400 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 4, y = 6}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [402] = function(eventid)
  -- function num : 0_401 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 7007, "Success", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [403] = function(eventid)
  -- function num : 0_402 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 7008, "Success", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [404] = function(eventid)
  -- function num : 0_403 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 3, y = 19}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [405] = function(eventid)
  -- function num : 0_404 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 5, y = 17}
, 
{x = 6, y = 17}
, 
{x = 7, y = 17}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [406] = function(eventid)
  -- function num : 0_405 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("battleend", eventid, 7012, "Success", "AfterReturn")
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [407] = function(eventid)
  -- function num : 0_406 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 12, y = 1}
, 
{x = 12, y = 2}
, 
{x = 12, y = 3}
, 
{x = 12, y = 4}
, 
{x = 12, y = 5}
, 
{x = 12, y = 6}
, 
{x = 13, y = 1}
, 
{x = 13, y = 2}
, 
{x = 13, y = 3}
, 
{x = 13, y = 4}
, 
{x = 13, y = 5}
, 
{x = 13, y = 6}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [408] = function(eventid)
  -- function num : 0_407 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 12, y = 5}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [409] = function(eventid)
  -- function num : 0_408 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 12, y = 2}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [410] = function(eventid)
  -- function num : 0_409 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 9, y = 9}
, 
{x = 10, y = 9}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [411] = function(eventid)
  -- function num : 0_410 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 13, y = 3}
, 
{x = 13, y = 4}
, 
{x = 13, y = 5}
, 
{x = 13, y = 6}
, 
{x = 13, y = 7}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [412] = function(eventid)
  -- function num : 0_411 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 7, y = 3}
, 
{x = 7, y = 4}
, 
{x = 7, y = 5}
, 
{x = 7, y = 6}
, 
{x = 7, y = 7}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [413] = function(eventid)
  -- function num : 0_412 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 13, y = 10}
, 
{x = 14, y = 10}
, 
{x = 15, y = 10}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [414] = function(eventid)
  -- function num : 0_413 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 9, y = 2}
, 
{x = 9, y = 3}
, 
{x = 9, y = 4}
, 
{x = 9, y = 5}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [415] = function(eventid)
  -- function num : 0_414 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 13, y = 10}
, 
{x = 14, y = 10}
, 
{x = 15, y = 10}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [416] = function(eventid)
  -- function num : 0_415 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 13, y = 9}
, 
{x = 14, y = 9}
, 
{x = 15, y = 9}
, 
{x = 16, y = 9}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [417] = function(eventid)
  -- function num : 0_416 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 13, y = 9}
, 
{x = 14, y = 9}
, 
{x = 15, y = 9}
, 
{x = 16, y = 9}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [418] = function(eventid)
  -- function num : 0_417 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 17, y = 14}
, 
{x = 17, y = 15}
, 
{x = 17, y = 16}
, 
{x = 17, y = 17}
, 
{x = 18, y = 14}
, 
{x = 18, y = 15}
, 
{x = 18, y = 16}
, 
{x = 18, y = 17}
, 
{x = 19, y = 14}
, 
{x = 19, y = 15}
, 
{x = 19, y = 16}
, 
{x = 19, y = 17}
, 
{x = 20, y = 14}
, 
{x = 20, y = 15}
, 
{x = 20, y = 16}
, 
{x = 20, y = 17}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [419] = function(eventid)
  -- function num : 0_418 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 4, y = 19}
, 
{x = 4, y = 20}
, 
{x = 4, y = 21}
, 
{x = 4, y = 22}
, 
{x = 5, y = 19}
, 
{x = 5, y = 20}
, 
{x = 5, y = 21}
, 
{x = 5, y = 22}
, 
{x = 6, y = 19}
, 
{x = 6, y = 20}
, 
{x = 6, y = 21}
, 
{x = 6, y = 22}
, 
{x = 7, y = 19}
, 
{x = 7, y = 20}
, 
{x = 7, y = 21}
, 
{x = 7, y = 22}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [420] = function(eventid)
  -- function num : 0_419 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 4, y = 17}
, 
{x = 4, y = 18}
, 
{x = 4, y = 19}
, 
{x = 4, y = 20}
, 
{x = 5, y = 17}
, 
{x = 5, y = 18}
, 
{x = 5, y = 19}
, 
{x = 5, y = 20}
, 
{x = 6, y = 17}
, 
{x = 6, y = 18}
, 
{x = 6, y = 19}
, 
{x = 6, y = 20}
, 
{x = 7, y = 17}
, 
{x = 7, y = 18}
, 
{x = 7, y = 19}
, 
{x = 7, y = 20}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [421] = function(eventid)
  -- function num : 0_420 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 6}
, 
{x = 15, y = 7}
, 
{x = 15, y = 8}
, 
{x = 15, y = 9}
, 
{x = 16, y = 6}
, 
{x = 16, y = 7}
, 
{x = 16, y = 8}
, 
{x = 16, y = 9}
, 
{x = 17, y = 6}
, 
{x = 17, y = 7}
, 
{x = 17, y = 8}
, 
{x = 17, y = 9}
, 
{x = 18, y = 6}
, 
{x = 18, y = 7}
, 
{x = 18, y = 8}
, 
{x = 18, y = 9}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [422] = function(eventid)
  -- function num : 0_421 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 7}
, 
{x = 8, y = 8}
, 
{x = 8, y = 9}
, 
{x = 8, y = 10}
, 
{x = 9, y = 7}
, 
{x = 9, y = 8}
, 
{x = 9, y = 9}
, 
{x = 9, y = 10}
, 
{x = 10, y = 7}
, 
{x = 10, y = 8}
, 
{x = 10, y = 9}
, 
{x = 10, y = 10}
, 
{x = 11, y = 7}
, 
{x = 11, y = 8}
, 
{x = 11, y = 9}
, 
{x = 11, y = 10}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [423] = function(eventid)
  -- function num : 0_422 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 19, y = 15}
, 
{x = 19, y = 16}
, 
{x = 19, y = 17}
, 
{x = 19, y = 18}
, 
{x = 20, y = 15}
, 
{x = 20, y = 16}
, 
{x = 20, y = 17}
, 
{x = 20, y = 18}
, 
{x = 21, y = 15}
, 
{x = 21, y = 16}
, 
{x = 21, y = 17}
, 
{x = 21, y = 18}
, 
{x = 22, y = 15}
, 
{x = 22, y = 16}
, 
{x = 22, y = 17}
, 
{x = 22, y = 18}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [424] = function(eventid)
  -- function num : 0_423 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 10, y = 8}
, 
{x = 11, y = 8}
, 
{x = 12, y = 8}
, 
{x = 13, y = 8}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [425] = function(eventid)
  -- function num : 0_424 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 6}
, 
{x = 16, y = 6}
, 
{x = 17, y = 6}
, 
{x = 18, y = 6}
, 
{x = 19, y = 6}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [426] = function(eventid)
  -- function num : 0_425 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 3, y = 16}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [427] = function(eventid)
  -- function num : 0_426 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 22}
, 
{x = 16, y = 22}
, 
{x = 17, y = 22}
, 
{x = 18, y = 22}
, 
{x = 19, y = 22}
, 
{x = 20, y = 22}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [428] = function(eventid)
  -- function num : 0_427 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 16, y = 20}
, 
{x = 16, y = 21}
, 
{x = 16, y = 22}
, 
{x = 16, y = 23}
}, true)
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [429] = function(eventid)
  -- function num : 0_428 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 16, y = 46}
, 
{x = 17, y = 46}
, 
{x = 18, y = 46}
, 
{x = 19, y = 46}
}, true)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("battleend", eventid, 1186, "Either", "AfterReturn")
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [430] = function(eventid)
  -- function num : 0_429 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 7, y = 14}
, 
{x = 8, y = 14}
, 
{x = 9, y = 14}
, 
{x = 10, y = 14}
, 
{x = 11, y = 14}
}, true)
end
, [431] = function(eventid)
  -- function num : 0_430 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 3, y = 12}
, 
{x = 4, y = 12}
}, true)
end
, [432] = function(eventid)
  -- function num : 0_431 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 2, y = 22}
, 
{x = 3, y = 22}
, 
{x = 4, y = 22}
, 
{x = 5, y = 22}
}, true)
end
, [433] = function(eventid)
  -- function num : 0_432 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 16, y = 8}
, 
{x = 16, y = 9}
, 
{x = 16, y = 10}
, 
{x = 16, y = 11}
}, true)
end
, [434] = function(eventid)
  -- function num : 0_433 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 2, y = 22}
, 
{x = 3, y = 22}
, 
{x = 4, y = 22}
, 
{x = 5, y = 22}
}, true)
end
, [435] = function(eventid)
  -- function num : 0_434 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 6}
, 
{x = 8, y = 7}
, 
{x = 8, y = 8}
}, true)
end
, [436] = function(eventid)
  -- function num : 0_435 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 19, y = 11}
, 
{x = 20, y = 11}
, 
{x = 21, y = 11}
}, true)
end
, [437] = function(eventid)
  -- function num : 0_436 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 13, y = 19}
, 
{x = 13, y = 20}
, 
{x = 13, y = 21}
, 
{x = 13, y = 22}
, 
{x = 13, y = 23}
, 
{x = 13, y = 24}
}, true)
end
, [438] = function(eventid)
  -- function num : 0_437 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 10, y = 30}
, 
{x = 10, y = 31}
, 
{x = 10, y = 32}
, 
{x = 10, y = 33}
}, true)
end
, [439] = function(eventid)
  -- function num : 0_438 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 9, y = 18}
, 
{x = 9, y = 19}
, 
{x = 10, y = 18}
, 
{x = 10, y = 19}
, 
{x = 11, y = 18}
, 
{x = 11, y = 19}
}, true)
end
, [440] = function(eventid)
  -- function num : 0_439 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 4, y = 21}
, 
{x = 4, y = 22}
, 
{x = 5, y = 21}
, 
{x = 5, y = 22}
, 
{x = 6, y = 21}
, 
{x = 6, y = 22}
}, true)
end
, [441] = function(eventid)
  -- function num : 0_440 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 23, y = 5}
, 
{x = 23, y = 6}
, 
{x = 23, y = 7}
, 
{x = 23, y = 8}
, 
{x = 24, y = 5}
, 
{x = 24, y = 6}
, 
{x = 24, y = 7}
, 
{x = 24, y = 8}
}, true)
end
, [442] = function(eventid)
  -- function num : 0_441 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 2, y = 21}
, 
{x = 3, y = 21}
, 
{x = 4, y = 21}
, 
{x = 5, y = 21}
, 
{x = 6, y = 21}
}, true)
end
, [443] = function(eventid)
  -- function num : 0_442 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 11, y = 23}
, 
{x = 11, y = 24}
, 
{x = 11, y = 25}
, 
{x = 11, y = 26}
, 
{x = 12, y = 23}
, 
{x = 12, y = 24}
, 
{x = 12, y = 25}
, 
{x = 12, y = 26}
}, true)
end
, [444] = function(eventid)
  -- function num : 0_443 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 24, y = 19}
, 
{x = 24, y = 20}
, 
{x = 24, y = 21}
, 
{x = 24, y = 22}
, 
{x = 24, y = 23}
, 
{x = 24, y = 24}
}, true)
end
, [445] = function(eventid)
  -- function num : 0_444 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 14, y = 21}
, 
{x = 14, y = 22}
, 
{x = 15, y = 21}
, 
{x = 15, y = 22}
, 
{x = 16, y = 21}
, 
{x = 16, y = 22}
, 
{x = 17, y = 21}
, 
{x = 17, y = 22}
, 
{x = 18, y = 21}
, 
{x = 18, y = 22}
, 
{x = 19, y = 21}
, 
{x = 19, y = 22}
, 
{x = 20, y = 21}
, 
{x = 20, y = 22}
, 
{x = 21, y = 21}
, 
{x = 21, y = 22}
}, true)
end
, [446] = function(eventid)
  -- function num : 0_445 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 13, y = 23}
, 
{x = 13, y = 24}
, 
{x = 13, y = 25}
, 
{x = 14, y = 23}
, 
{x = 14, y = 24}
, 
{x = 14, y = 25}
, 
{x = 15, y = 23}
, 
{x = 15, y = 24}
, 
{x = 15, y = 25}
, 
{x = 16, y = 23}
, 
{x = 16, y = 24}
, 
{x = 16, y = 25}
, 
{x = 17, y = 23}
, 
{x = 17, y = 24}
, 
{x = 17, y = 25}
}, true)
end
, [447] = function(eventid)
  -- function num : 0_446 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 19, y = 26}
, 
{x = 20, y = 26}
, 
{x = 21, y = 26}
, 
{x = 22, y = 26}
}, true)
end
, [448] = function(eventid)
  -- function num : 0_447 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 10, y = 16}
, 
{x = 11, y = 16}
, 
{x = 12, y = 16}
, 
{x = 13, y = 16}
, 
{x = 14, y = 16}
}, true)
end
, [449] = function(eventid)
  -- function num : 0_448 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 13, y = 11}
, 
{x = 13, y = 12}
, 
{x = 14, y = 11}
, 
{x = 14, y = 12}
, 
{x = 15, y = 11}
, 
{x = 15, y = 12}
, 
{x = 16, y = 11}
, 
{x = 16, y = 12}
, 
{x = 17, y = 11}
, 
{x = 17, y = 12}
, 
{x = 18, y = 11}
, 
{x = 18, y = 12}
}, true)
end
, [450] = function(eventid)
  -- function num : 0_449 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 39}
, 
{x = 8, y = 40}
, 
{x = 8, y = 41}
, 
{x = 8, y = 42}
, 
{x = 9, y = 39}
, 
{x = 9, y = 40}
, 
{x = 9, y = 41}
, 
{x = 9, y = 42}
}, true)
end
, [451] = function(eventid)
  -- function num : 0_450 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 20, y = 46}
, 
{x = 21, y = 46}
, 
{x = 22, y = 46}
, 
{x = 23, y = 46}
, 
{x = 24, y = 46}
}, true)
end
, [452] = function(eventid)
  -- function num : 0_451 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1120, "Success", "Instant")
end
, [453] = function(eventid)
  -- function num : 0_452 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 1126, "Success", "AfterReturn")
end
, [454] = function(eventid)
  -- function num : 0_453 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 13, y = 11}
, 
{x = 13, y = 12}
, 
{x = 14, y = 11}
, 
{x = 14, y = 12}
}, true)
end
, [455] = function(eventid)
  -- function num : 0_454 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 27, y = 6}
, 
{x = 28, y = 6}
}, true)
end
, [456] = function(eventid)
  -- function num : 0_455 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 11, y = 23}
, 
{x = 12, y = 23}
, 
{x = 13, y = 23}
, 
{x = 14, y = 23}
}, true)
end
, [457] = function(eventid)
  -- function num : 0_456 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 7}
, 
{x = 15, y = 8}
, 
{x = 16, y = 7}
, 
{x = 16, y = 8}
, 
{x = 17, y = 7}
, 
{x = 17, y = 8}
}, true)
end
, [458] = function(eventid)
  -- function num : 0_457 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 5, y = 4}
, 
{x = 6, y = 4}
, 
{x = 7, y = 4}
, 
{x = 8, y = 4}
}, true)
end
, [459] = function(eventid)
  -- function num : 0_458 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 14, y = 4}
, 
{x = 15, y = 4}
, 
{x = 16, y = 4}
}, true)
end
, [460] = function(eventid)
  -- function num : 0_459 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 2, y = 8}
, 
{x = 2, y = 9}
, 
{x = 3, y = 8}
, 
{x = 3, y = 9}
, 
{x = 4, y = 8}
, 
{x = 4, y = 9}
, 
{x = 5, y = 8}
, 
{x = 5, y = 9}
, 
{x = 6, y = 8}
, 
{x = 6, y = 9}
}, true)
end
, [461] = function(eventid)
  -- function num : 0_460 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 7018, "Success", "AfterReturn")
end
, [462] = function(eventid)
  -- function num : 0_461 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 11, y = 5}
, 
{x = 11, y = 6}
, 
{x = 12, y = 5}
, 
{x = 12, y = 6}
, 
{x = 13, y = 5}
, 
{x = 13, y = 6}
, 
{x = 14, y = 5}
, 
{x = 14, y = 6}
, 
{x = 15, y = 5}
, 
{x = 15, y = 6}
}, true)
end
, [463] = function(eventid)
  -- function num : 0_462 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 7023, "Success", "AfterReturn")
end
, [464] = function(eventid)
  -- function num : 0_463 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 4, y = 10}
, 
{x = 4, y = 11}
, 
{x = 5, y = 10}
, 
{x = 5, y = 11}
, 
{x = 6, y = 10}
, 
{x = 6, y = 11}
, 
{x = 7, y = 10}
, 
{x = 7, y = 11}
, 
{x = 8, y = 10}
, 
{x = 8, y = 11}
, 
{x = 9, y = 10}
, 
{x = 9, y = 11}
, 
{x = 10, y = 10}
, 
{x = 10, y = 11}
, 
{x = 11, y = 10}
, 
{x = 11, y = 11}
, 
{x = 12, y = 10}
, 
{x = 12, y = 11}
, 
{x = 13, y = 10}
, 
{x = 13, y = 11}
}, true)
end
, [465] = function(eventid)
  -- function num : 0_464 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("battleend", eventid, 7026, "Success", "AfterReturn")
end
, [466] = function(eventid)
  -- function num : 0_465 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 6, y = 22}
, 
{x = 6, y = 23}
, 
{x = 7, y = 22}
, 
{x = 7, y = 23}
, 
{x = 8, y = 22}
, 
{x = 8, y = 23}
, 
{x = 9, y = 22}
, 
{x = 9, y = 23}
}, true)
end
, [467] = function(eventid)
  -- function num : 0_466 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 4, y = 16}
, 
{x = 4, y = 17}
, 
{x = 5, y = 16}
, 
{x = 5, y = 17}
, 
{x = 6, y = 16}
, 
{x = 6, y = 17}
}, true)
end
, [468] = function(eventid)
  -- function num : 0_467 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 9, y = 20}
, 
{x = 9, y = 21}
, 
{x = 10, y = 20}
, 
{x = 10, y = 21}
, 
{x = 11, y = 20}
, 
{x = 11, y = 21}
, 
{x = 12, y = 20}
, 
{x = 12, y = 21}
}, true)
end
, [469] = function(eventid)
  -- function num : 0_468 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 12, y = 21}
, 
{x = 12, y = 22}
, 
{x = 13, y = 21}
, 
{x = 13, y = 22}
, 
{x = 14, y = 21}
, 
{x = 14, y = 22}
}, true)
end
, [470] = function(eventid)
  -- function num : 0_469 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 23, y = 24}
, 
{x = 23, y = 25}
, 
{x = 24, y = 24}
, 
{x = 24, y = 25}
, 
{x = 25, y = 24}
, 
{x = 25, y = 25}
, 
{x = 26, y = 24}
, 
{x = 26, y = 25}
}, true)
end
, [471] = function(eventid)
  -- function num : 0_470 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 11, y = 27}
, 
{x = 11, y = 28}
, 
{x = 12, y = 27}
, 
{x = 12, y = 28}
, 
{x = 13, y = 27}
, 
{x = 13, y = 28}
, 
{x = 14, y = 27}
, 
{x = 14, y = 28}
, 
{x = 15, y = 27}
, 
{x = 15, y = 28}
}, true)
end
, [472] = function(eventid)
  -- function num : 0_471 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 7, y = 11}
, 
{x = 7, y = 12}
, 
{x = 8, y = 11}
, 
{x = 8, y = 12}
, 
{x = 9, y = 11}
, 
{x = 9, y = 12}
, 
{x = 10, y = 11}
, 
{x = 10, y = 12}
}, true)
end
, [473] = function(eventid)
  -- function num : 0_472 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 7, y = 19}
, 
{x = 7, y = 20}
, 
{x = 8, y = 19}
, 
{x = 8, y = 20}
, 
{x = 9, y = 19}
, 
{x = 9, y = 20}
, 
{x = 10, y = 19}
, 
{x = 10, y = 20}
, 
{x = 11, y = 19}
, 
{x = 11, y = 20}
, 
{x = 12, y = 19}
, 
{x = 12, y = 20}
}, true)
end
, [474] = function(eventid)
  -- function num : 0_473 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 17}
, 
{x = 15, y = 18}
, 
{x = 16, y = 17}
, 
{x = 16, y = 18}
, 
{x = 17, y = 17}
, 
{x = 17, y = 18}
, 
{x = 18, y = 17}
, 
{x = 18, y = 18}
}, true)
end
, [476] = function(eventid)
  -- function num : 0_474 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 36}
, 
{x = 8, y = 37}
, 
{x = 9, y = 36}
, 
{x = 9, y = 37}
, 
{x = 10, y = 36}
, 
{x = 10, y = 37}
}, true)
end
, [477] = function(eventid)
  -- function num : 0_475 , upvalues : ComposedTrigger, Or, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (Or.Create)()
  local trigger0 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 7, y = 28}
, 
{x = 8, y = 28}
, 
{x = 9, y = 28}
, 
{x = 10, y = 28}
, 
{x = 11, y = 28}
}, true)
  root:AddTask(trigger0)
  do
    local trigger1 = (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 11, y = 24}
, 
{x = 11, y = 25}
, 
{x = 11, y = 26}
, 
{x = 11, y = 27}
, 
{x = 11, y = 28}
}, true)
    root:AddTask(trigger1)
    upper:AddTask(root)
    return root
  end
end
, [478] = function(eventid)
  -- function num : 0_476 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 17}
, 
{x = 8, y = 18}
, 
{x = 8, y = 19}
, 
{x = 9, y = 17}
, 
{x = 9, y = 18}
, 
{x = 9, y = 19}
, 
{x = 10, y = 17}
, 
{x = 10, y = 18}
, 
{x = 10, y = 19}
}, true)
end
, [479] = function(eventid)
  -- function num : 0_477 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 9}
, 
{x = 15, y = 10}
, 
{x = 15, y = 11}
, 
{x = 15, y = 12}
, 
{x = 15, y = 13}
}, true)
end
, [481] = function(eventid)
  -- function num : 0_478 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 3, y = 9}
, 
{x = 3, y = 10}
, 
{x = 4, y = 9}
, 
{x = 4, y = 10}
, 
{x = 5, y = 9}
, 
{x = 5, y = 10}
, 
{x = 6, y = 9}
, 
{x = 6, y = 10}
}, true)
end
, [482] = function(eventid)
  -- function num : 0_479 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 17, y = 4}
, 
{x = 17, y = 5}
, 
{x = 17, y = 6}
, 
{x = 17, y = 7}
, 
{x = 17, y = 8}
, 
{x = 18, y = 4}
, 
{x = 18, y = 5}
, 
{x = 18, y = 6}
, 
{x = 18, y = 7}
, 
{x = 18, y = 8}
}, true)
end
, [483] = function(eventid)
  -- function num : 0_480 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 10, y = 14}
, 
{x = 10, y = 15}
, 
{x = 10, y = 16}
, 
{x = 10, y = 17}
, 
{x = 11, y = 14}
, 
{x = 11, y = 15}
, 
{x = 11, y = 16}
, 
{x = 11, y = 17}
}, true)
end
, [484] = function(eventid)
  -- function num : 0_481 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 15, y = 8}
, 
{x = 15, y = 9}
, 
{x = 16, y = 8}
, 
{x = 16, y = 9}
, 
{x = 17, y = 8}
, 
{x = 17, y = 9}
}, true)
end
, [485] = function(eventid)
  -- function num : 0_482 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 4, y = 24}
, 
{x = 4, y = 25}
, 
{x = 5, y = 24}
, 
{x = 5, y = 25}
, 
{x = 6, y = 24}
, 
{x = 6, y = 25}
, 
{x = 7, y = 24}
, 
{x = 7, y = 25}
, 
{x = 8, y = 24}
, 
{x = 8, y = 25}
}, true)
end
, [486] = function(eventid)
  -- function num : 0_483 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 11, y = 11}
, 
{x = 11, y = 12}
, 
{x = 12, y = 11}
, 
{x = 12, y = 12}
, 
{x = 13, y = 11}
, 
{x = 13, y = 12}
, 
{x = 14, y = 11}
, 
{x = 14, y = 12}
, 
{x = 15, y = 11}
, 
{x = 15, y = 12}
}, true)
end
, [487] = function(eventid)
  -- function num : 0_484 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 10, y = 19}
, 
{x = 10, y = 20}
, 
{x = 11, y = 19}
, 
{x = 11, y = 20}
, 
{x = 12, y = 19}
, 
{x = 12, y = 20}
, 
{x = 13, y = 19}
, 
{x = 13, y = 20}
, 
{x = 14, y = 19}
, 
{x = 14, y = 20}
}, true)
end
, [488] = function(eventid)
  -- function num : 0_485 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 19, y = 18}
, 
{x = 19, y = 19}
, 
{x = 20, y = 18}
, 
{x = 20, y = 19}
, 
{x = 21, y = 18}
, 
{x = 21, y = 19}
, 
{x = 22, y = 18}
, 
{x = 22, y = 19}
, 
{x = 23, y = 18}
, 
{x = 23, y = 19}
}, true)
end
, [489] = function(eventid)
  -- function num : 0_486 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 14, y = 9}
, 
{x = 14, y = 10}
, 
{x = 15, y = 9}
, 
{x = 15, y = 10}
}, true)
end
, [490] = function(eventid)
  -- function num : 0_487 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 8, y = 10}
, 
{x = 8, y = 11}
, 
{x = 8, y = 12}
, 
{x = 8, y = 13}
, 
{x = 8, y = 14}
, 
{x = 9, y = 10}
, 
{x = 9, y = 11}
, 
{x = 9, y = 12}
, 
{x = 9, y = 13}
, 
{x = 9, y = 14}
}, true)
end
, [491] = function(eventid)
  -- function num : 0_488 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 6, y = 15}
, 
{x = 6, y = 16}
, 
{x = 6, y = 17}
, 
{x = 7, y = 15}
, 
{x = 7, y = 16}
, 
{x = 7, y = 17}
, 
{x = 8, y = 15}
, 
{x = 8, y = 16}
, 
{x = 8, y = 17}
}, true)
end
, [492] = function(eventid)
  -- function num : 0_489 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 14, y = 27}
, 
{x = 14, y = 28}
, 
{x = 15, y = 27}
, 
{x = 15, y = 28}
, 
{x = 16, y = 27}
, 
{x = 16, y = 28}
}, true)
end
, [493] = function(eventid)
  -- function num : 0_490 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 13, y = 11}
, 
{x = 13, y = 12}
, 
{x = 14, y = 11}
, 
{x = 14, y = 12}
, 
{x = 15, y = 11}
, 
{x = 15, y = 12}
, 
{x = 16, y = 11}
, 
{x = 16, y = 12}
, 
{x = 17, y = 11}
, 
{x = 17, y = 12}
}, true)
end
, [494] = function(eventid)
  -- function num : 0_491 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 3, y = 24}
, 
{x = 3, y = 25}
, 
{x = 4, y = 24}
, 
{x = 4, y = 25}
, 
{x = 5, y = 24}
, 
{x = 5, y = 25}
, 
{x = 6, y = 24}
, 
{x = 6, y = 25}
, 
{x = 7, y = 24}
, 
{x = 7, y = 25}
}, true)
end
, [495] = function(eventid)
  -- function num : 0_492 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 19, y = 11}
, 
{x = 19, y = 12}
, 
{x = 20, y = 11}
, 
{x = 20, y = 12}
, 
{x = 21, y = 11}
, 
{x = 21, y = 12}
}, true)
end
, [496] = function(eventid)
  -- function num : 0_493 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 11, y = 19}
, 
{x = 12, y = 19}
, 
{x = 13, y = 19}
, 
{x = 14, y = 19}
, 
{x = 15, y = 19}
}, true)
end
, [497] = function(eventid)
  -- function num : 0_494 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("gridpos", eventid, {
{x = 18, y = 14}
, 
{x = 19, y = 14}
}, true)
end
}
return triggers

