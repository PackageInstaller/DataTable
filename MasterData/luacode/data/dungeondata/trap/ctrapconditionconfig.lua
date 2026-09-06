local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local triggers = {
  [1] = function(eventid)
    return TriggerManager.CreateTrigger("trapopen", eventid, 1, {
      1,
      2,
      3,
      4
    }, {
      1,
      0,
      0,
      0
    })
  end,
  [2] = function(eventid)
    return TriggerManager.CreateTrigger("trapopen", eventid, 2, {1}, {1})
  end,
  [3] = function(eventid)
    return TriggerManager.CreateTrigger("trapopen", eventid, 3, {1}, {1})
  end,
  [4] = function(eventid)
    return TriggerManager.CreateTrigger("trapopen", eventid, 6, {1}, {1})
  end,
  [5] = function(eventid)
    return TriggerManager.CreateTrigger("trapopen", eventid, 7, {1}, {1})
  end,
  [6] = function(eventid)
    return TriggerManager.CreateTrigger("trapopen", eventid, 9, {3}, {1})
  end,
  [7] = function(eventid)
    return TriggerManager.CreateTrigger("trapopen", eventid, 10, {6}, {1})
  end
}
return triggers
