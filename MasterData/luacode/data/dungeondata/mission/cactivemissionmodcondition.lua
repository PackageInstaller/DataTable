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
  [4] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "2", 10)
  end,
  [5] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "2", 20)
  end,
  [7] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "4", 10)
  end,
  [8] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "4", 20)
  end,
  [10] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "3", 10)
  end,
  [11] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "3", 20)
  end,
  [27] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "cavernExplore", "0", 5)
  end,
  [28] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "cavernExplore", "0", 15)
  end,
  [29] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "cavernExplore", "0", 30)
  end,
  [30] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "2", 5)
  end,
  [31] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "2", 15)
  end,
  [32] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "2", 20)
  end,
  [33] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "1", 3)
  end,
  [34] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "1", 8)
  end,
  [35] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "1", 15)
  end,
  [36] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "1", 10)
  end,
  [37] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "1", 20)
  end,
  [38] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "2", 10)
  end,
  [39] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "2", 20)
  end,
  [40] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "4", 10)
  end,
  [41] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "4", 20)
  end,
  [42] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "3", 10)
  end,
  [43] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "3", 20)
  end,
  [44] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "cavernExplore", "0", 5)
  end,
  [45] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "cavernExplore", "0", 15)
  end,
  [46] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "cavernExplore", "0", 30)
  end,
  [47] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "2", 5)
  end,
  [48] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "2", 15)
  end,
  [49] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "2", 20)
  end,
  [50] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "1", 3)
  end,
  [51] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "1", 8)
  end,
  [52] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "1", 15)
  end
}
return triggers
