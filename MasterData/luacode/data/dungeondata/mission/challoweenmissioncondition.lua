local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local triggers = {
  [1] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "1", 10)
  end,
  [2] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "1", 20)
  end,
  [3] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "1", 30)
  end,
  [4] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "2", 10)
  end,
  [5] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "2", 20)
  end,
  [6] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "2", 30)
  end,
  [7] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "4", 10)
  end,
  [8] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "4", 20)
  end,
  [9] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "4", 30)
  end,
  [10] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "3", 10)
  end,
  [11] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "3", 20)
  end,
  [12] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "3", 30)
  end,
  [16] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "consumeap", "35003", 200)
  end,
  [17] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "consumeap", "35003", 500)
  end,
  [18] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "consumeap", "35003", 1200)
  end,
  [19] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "consumeap", "35003", 2600)
  end,
  [20] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "consumeap", "35003", 3600)
  end,
  [24] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "card", "3", 1)
  end,
  [25] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "card", "3", 5)
  end,
  [26] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "card", "3", 10)
  end,
  [27] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "cavernExploreAward", "0", 5)
  end,
  [28] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "cavernExploreAward", "0", 15)
  end,
  [29] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "cavernExploreAward", "0", 30)
  end,
  [30] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "2", 5)
  end,
  [31] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "2", 15)
  end,
  [32] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "2", 30)
  end,
  [33] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "1", 3)
  end,
  [34] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "1", 8)
  end,
  [35] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "1", 15)
  end
}
return triggers
