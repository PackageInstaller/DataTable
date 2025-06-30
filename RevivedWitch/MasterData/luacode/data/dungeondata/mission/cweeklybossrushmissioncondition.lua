-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/dungeondata/mission/cweeklybossrushmissioncondition.lua 

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
  -- function num : 0_2
  return 
end
, [4] = function(eventid)
  -- function num : 0_3
  return 
end
, [5] = function(eventid)
  -- function num : 0_4
  return 
end
, [6] = function(eventid)
  -- function num : 0_5
  return 
end
, [7] = function(eventid)
  -- function num : 0_6
  return 
end
, [8] = function(eventid)
  -- function num : 0_7
  return 
end
, [9] = function(eventid)
  -- function num : 0_8 , upvalues : ComposedTrigger, Or
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (Or.Create)()
    upper:AddTask(root)
    return root
  end
end
, [10] = function(eventid)
  -- function num : 0_9 , upvalues : ComposedTrigger, Or
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (Or.Create)()
    upper:AddTask(root)
    return root
  end
end
, [11] = function(eventid)
  -- function num : 0_10 , upvalues : ComposedTrigger, Or
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (Or.Create)()
    upper:AddTask(root)
    return root
  end
end
, [12] = function(eventid)
  -- function num : 0_11 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "weeklyBossRank", "", 1)
end
, [13] = function(eventid)
  -- function num : 0_12 , upvalues : ComposedTrigger, Or
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (Or.Create)()
    upper:AddTask(root)
    return root
  end
end
, [14] = function(eventid)
  -- function num : 0_13 , upvalues : ComposedTrigger, Or
  local root = (ComposedTrigger.Create)()
  local upper = root
  do
    local root = (Or.Create)()
    upper:AddTask(root)
    return root
  end
end
, [15] = function(eventid)
  -- function num : 0_14
  return 
end
, [16] = function(eventid)
  -- function num : 0_15 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "weeklyBossBuff", "", 5)
end
, [17] = function(eventid)
  -- function num : 0_16 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "weeklyBossBuff", "", 25)
end
, [18] = function(eventid)
  -- function num : 0_17 , upvalues : _ENV
  return (TriggerManager.CreateTrigger)("counter", eventid, "weeklyBossBuff", "", 50)
end
, [19] = function(eventid)
  -- function num : 0_18
  return 
end
, [20] = function(eventid)
  -- function num : 0_19
  return 
end
}
return triggers

