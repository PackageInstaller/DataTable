local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local triggers = {
  [1] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "eleven", "", 300)
  end,
  [2] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "activityLogin", "", 2)
  end,
  [8] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "friend", "", 3)
  end,
  [9] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "cavernExploreAward", "0", 4)
  end,
  [11] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "EquipRare", "3", 1)
  end,
  [26] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "roleStrengthen", "", 1)
  end,
  [43] = function(eventid)
    return
  end,
  [44] = function(eventid)
    return
  end,
  [49] = function(eventid)
    return
  end
}
return triggers
