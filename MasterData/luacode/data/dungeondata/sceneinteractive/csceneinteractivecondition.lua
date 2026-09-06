local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local triggers = {
  [1] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("rolestatus", eventid, {type = 1, value = 3})
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [2] = function(eventid)
    return TriggerManager.CreateTrigger("rolestatus", eventid, {type = 1, value = 4})
  end,
  [3] = function(eventid)
    return TriggerManager.CreateTrigger("rolestatus", eventid, {type = 1, value = 5})
  end,
  [4] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1127, "Success", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [5] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 20017)
  end,
  [6] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 120001)
  end,
  [7] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 120001)
  end,
  [8] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 120002)
  end,
  [9] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 120002)
  end,
  [10] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 120003)
  end,
  [11] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 120003)
  end,
  [12] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 120004)
  end,
  [13] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 120004)
  end,
  [14] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 120005)
  end,
  [15] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 120005)
  end
}
return triggers
