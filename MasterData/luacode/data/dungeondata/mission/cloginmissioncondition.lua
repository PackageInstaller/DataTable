local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local triggers = {
  [1] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 120001)
  end,
  [2] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 120002)
  end,
  [3] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 120003)
  end,
  [4] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 120004)
  end,
  [5] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 120005)
  end
}
return triggers
