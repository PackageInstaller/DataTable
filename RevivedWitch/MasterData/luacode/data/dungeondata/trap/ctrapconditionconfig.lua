-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/dungeondata/trap/ctrapconditionconfig.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local triggers = {[1] = function(eventid)
  -- function num : 0_0 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("trapopen", eventid, 1, {1, 2, 3, 4}, {1, 0, 0, 0})
end
, [2] = function(eventid)
  -- function num : 0_1 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("trapopen", eventid, 2, {1}, {1})
end
, [3] = function(eventid)
  -- function num : 0_2 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("trapopen", eventid, 3, {1}, {1})
end
, [4] = function(eventid)
  -- function num : 0_3 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("trapopen", eventid, 6, {1}, {1})
end
, [5] = function(eventid)
  -- function num : 0_4 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("trapopen", eventid, 7, {1}, {1})
end
, [6] = function(eventid)
  -- function num : 0_5 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("trapopen", eventid, 9, {3}, {1})
end
, [7] = function(eventid)
  -- function num : 0_6 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("trapopen", eventid, 10, {6}, {1})
end
}
return triggers

