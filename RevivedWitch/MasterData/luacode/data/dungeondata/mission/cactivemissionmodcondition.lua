-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/dungeondata/mission/cactivemissionmodcondition.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local triggers = {[1] = function(eventid)
  -- function num : 0_0 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "1", 10)
end
, [2] = function(eventid)
  -- function num : 0_1 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "1", 20)
end
, [4] = function(eventid)
  -- function num : 0_2 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "2", 10)
end
, [5] = function(eventid)
  -- function num : 0_3 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "2", 20)
end
, [7] = function(eventid)
  -- function num : 0_4 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "4", 10)
end
, [8] = function(eventid)
  -- function num : 0_5 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "4", 20)
end
, [10] = function(eventid)
  -- function num : 0_6 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "3", 10)
end
, [11] = function(eventid)
  -- function num : 0_7 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "3", 20)
end
, [27] = function(eventid)
  -- function num : 0_8 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "cavernExplore", "0", 5)
end
, [28] = function(eventid)
  -- function num : 0_9 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "cavernExplore", "0", 15)
end
, [29] = function(eventid)
  -- function num : 0_10 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "cavernExplore", "0", 30)
end
, [30] = function(eventid)
  -- function num : 0_11 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "pvpWin", "2", 5)
end
, [31] = function(eventid)
  -- function num : 0_12 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "pvpWin", "2", 15)
end
, [32] = function(eventid)
  -- function num : 0_13 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "pvpWin", "2", 20)
end
, [33] = function(eventid)
  -- function num : 0_14 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "pvpWin", "1", 3)
end
, [34] = function(eventid)
  -- function num : 0_15 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "pvpWin", "1", 8)
end
, [35] = function(eventid)
  -- function num : 0_16 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "pvpWin", "1", 15)
end
, [36] = function(eventid)
  -- function num : 0_17 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "1", 10)
end
, [37] = function(eventid)
  -- function num : 0_18 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "1", 20)
end
, [38] = function(eventid)
  -- function num : 0_19 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "2", 10)
end
, [39] = function(eventid)
  -- function num : 0_20 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "2", 20)
end
, [40] = function(eventid)
  -- function num : 0_21 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "4", 10)
end
, [41] = function(eventid)
  -- function num : 0_22 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "4", 20)
end
, [42] = function(eventid)
  -- function num : 0_23 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "3", 10)
end
, [43] = function(eventid)
  -- function num : 0_24 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "realm", "3", 20)
end
, [44] = function(eventid)
  -- function num : 0_25 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "cavernExplore", "0", 5)
end
, [45] = function(eventid)
  -- function num : 0_26 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "cavernExplore", "0", 15)
end
, [46] = function(eventid)
  -- function num : 0_27 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "cavernExplore", "0", 30)
end
, [47] = function(eventid)
  -- function num : 0_28 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "pvpWin", "2", 5)
end
, [48] = function(eventid)
  -- function num : 0_29 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "pvpWin", "2", 15)
end
, [49] = function(eventid)
  -- function num : 0_30 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "pvpWin", "2", 20)
end
, [50] = function(eventid)
  -- function num : 0_31 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "pvpWin", "1", 3)
end
, [51] = function(eventid)
  -- function num : 0_32 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "pvpWin", "1", 8)
end
, [52] = function(eventid)
  -- function num : 0_33 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "pvpWin", "1", 15)
end
}
return triggers

