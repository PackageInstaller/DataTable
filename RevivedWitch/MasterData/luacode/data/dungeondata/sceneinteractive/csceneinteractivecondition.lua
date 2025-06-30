-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/dungeondata/sceneinteractive/csceneinteractivecondition.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local triggers = {[1] = function(eventid)
  -- function num : 0_0 , upvalues : ComposedTrigger, And, _ENV
  local root = (ComposedTrigger.Create)()
  local upper = root
  local root = (And.Create)()
  do
    local trigger0 = (TriggerManager.CreateTrigger)("rolestatus", eventid, {type = 1, value = 3})
    root:AddTask(trigger0)
    upper:AddTask(root)
    return root
  end
end
, [2] = function(eventid)
  -- function num : 0_1 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("rolestatus", eventid, {type = 1, value = 4})
end
, [3] = function(eventid)
  -- function num : 0_2 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("rolestatus", eventid, {type = 1, value = 5})
end
, [4] = function(eventid)
  -- function num : 0_3 , upvalues : ComposedTrigger, And, _ENV
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
, [5] = function(eventid)
  -- function num : 0_4 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 20017)
end
, [6] = function(eventid)
  -- function num : 0_5 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 120001)
end
, [7] = function(eventid)
  -- function num : 0_6 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 120001)
end
, [8] = function(eventid)
  -- function num : 0_7 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 120002)
end
, [9] = function(eventid)
  -- function num : 0_8 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 120002)
end
, [10] = function(eventid)
  -- function num : 0_9 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 120003)
end
, [11] = function(eventid)
  -- function num : 0_10 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 120003)
end
, [12] = function(eventid)
  -- function num : 0_11 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 120004)
end
, [13] = function(eventid)
  -- function num : 0_12 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 120004)
end
, [14] = function(eventid)
  -- function num : 0_13 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 120005)
end
, [15] = function(eventid)
  -- function num : 0_14 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("pretask", eventid, 120005)
end
}
return triggers

