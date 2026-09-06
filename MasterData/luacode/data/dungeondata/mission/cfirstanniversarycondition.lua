local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local triggers = {
  [1] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "card", "3", 10)
  end,
  [2] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "card", "3", 20)
  end,
  [3] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "card", "3", 30)
  end,
  [4] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "card", "3", 50)
  end,
  [5] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "card", "3", 70)
  end,
  [6] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "card", "3", 100)
  end,
  [7] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "card", "3", 150)
  end,
  [8] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "consumeap", "35003", 500)
  end,
  [9] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "consumeap", "35003", 1000)
  end,
  [10] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "consumeap", "35003", 2000)
  end,
  [11] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "consumeap", "35003", 3000)
  end,
  [12] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "consumeap", "35003", 5000)
  end,
  [13] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "consumeap", "35003", 8000)
  end,
  [14] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "spiritsupply", "0", 2)
  end,
  [15] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "35071", 500)
  end,
  [16] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "35072", 500)
  end,
  [17] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "spiritsupply", "0", 5)
  end,
  [18] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "spiritsupply", "0", 10)
  end,
  [19] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "35071", 1000)
  end,
  [20] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "35071", 2000)
  end,
  [21] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "35072", 1000)
  end,
  [22] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "35072", 2000)
  end
}
return triggers
