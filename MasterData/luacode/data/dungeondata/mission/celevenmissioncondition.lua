local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local triggers = {
  [1] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "eleven", "", 500)
  end,
  [2] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "eleven", "", 40)
  end,
  [3] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "eleven", "", 60)
  end,
  [4] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "eleven", "", 20)
  end,
  [5] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "eleven", "", 20)
  end,
  [6] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "eleven", "", 60)
  end,
  [7] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "eleven", "", 80)
  end,
  [8] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "eleven", "", 100)
  end
}
return triggers
