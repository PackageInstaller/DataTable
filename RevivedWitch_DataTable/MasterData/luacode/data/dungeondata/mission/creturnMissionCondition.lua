-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/dungeondata/mission/creturnMissionCondition.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local triggers = {[1] = function(eventid)
  -- function num : 0_0 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "eleven", "", 300)
end
, [2] = function(eventid)
  -- function num : 0_1 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "activityLogin", "", 2)
end
, [8] = function(eventid)
  -- function num : 0_2 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "friend", "", 3)
end
, [9] = function(eventid)
  -- function num : 0_3 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "cavernExploreAward", "0", 4)
end
, [11] = function(eventid)
  -- function num : 0_4 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "EquipRare", "3", 1)
end
, [26] = function(eventid)
  -- function num : 0_5 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "roleStrengthen", "", 1)
end
, [43] = function(eventid)
  -- function num : 0_6
  return 
end
, [44] = function(eventid)
  -- function num : 0_7
  return 
end
, [49] = function(eventid)
  -- function num : 0_8
  return 
end
}
return triggers

