-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/dungeondata/mission/celevenmissioncondition.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local triggers = {[1] = function(eventid)
  -- function num : 0_0 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "eleven", "", 500)
end
, [2] = function(eventid)
  -- function num : 0_1 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "eleven", "", 40)
end
, [3] = function(eventid)
  -- function num : 0_2 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "eleven", "", 60)
end
, [4] = function(eventid)
  -- function num : 0_3 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "eleven", "", 20)
end
, [5] = function(eventid)
  -- function num : 0_4 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "eleven", "", 20)
end
, [6] = function(eventid)
  -- function num : 0_5 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "eleven", "", 60)
end
, [7] = function(eventid)
  -- function num : 0_6 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "eleven", "", 80)
end
, [8] = function(eventid)
  -- function num : 0_7 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "eleven", "", 100)
end
}
return triggers

