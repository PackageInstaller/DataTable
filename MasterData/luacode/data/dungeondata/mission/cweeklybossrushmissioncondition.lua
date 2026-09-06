local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local triggers = {
  [1] = function(eventid)
    return
  end,
  [2] = function(eventid)
    return
  end,
  [3] = function(eventid)
    return
  end,
  [4] = function(eventid)
    return
  end,
  [5] = function(eventid)
    return
  end,
  [6] = function(eventid)
    return
  end,
  [7] = function(eventid)
    return
  end,
  [8] = function(eventid)
    return
  end,
  [9] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = Or.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [10] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = Or.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [11] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = Or.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [12] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "weeklyBossRank", "", 1)
  end,
  [13] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = Or.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [14] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = Or.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [15] = function(eventid)
    return
  end,
  [16] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "weeklyBossBuff", "", 5)
  end,
  [17] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "weeklyBossBuff", "", 25)
  end,
  [18] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "weeklyBossBuff", "", 50)
  end,
  [19] = function(eventid)
    return
  end,
  [20] = function(eventid)
    return
  end
}
return triggers
