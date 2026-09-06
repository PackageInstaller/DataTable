local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local triggers = {
  [1] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "mainline", "", 3)
  end,
  [2] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "autoExplore", "0", 3)
  end,
  [3] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "0", 1)
  end,
  [4] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "0", 2)
  end,
  [5] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "roleLv", "total", 1)
  end,
  [6] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "present", "", 1)
  end,
  [7] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "equipstrengthen", "total", 1)
  end,
  [8] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "equipfumo", "total", 1)
  end,
  [9] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "cavernExplore", "", 1)
  end,
  [10] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "consumeap", "35003", 100)
  end,
  [11] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "35002", 30000)
  end,
  [12] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "buyitem", "9", 1)
  end,
  [13] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "equipstrengthen", "total", 10)
  end,
  [14] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "0", 5)
  end,
  [15] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "monster", "total", 50)
  end,
  [16] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "battle", "1", 30)
  end,
  [17] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "roleBreakDaily", "", 1)
  end,
  [18] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "card", "0", 1)
  end,
  [19] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "roleLv", "total", 5)
  end,
  [20] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "alchemy", "", 1)
  end,
  [21] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "roleRelaxation", "", 1)
  end,
  [22] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "loginDaily", "", 1)
  end,
  [23] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "friendAssistDungeon", "", 1)
  end,
  [24] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "2", 1)
  end,
  [25] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "consumeap", "35003", 60)
  end,
  [26] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "roleStrengthen", "", 1)
  end
}
return triggers
