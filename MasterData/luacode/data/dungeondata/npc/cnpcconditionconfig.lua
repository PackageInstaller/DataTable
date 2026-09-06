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
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      do
        local upper = root
        local root = Not.Create()
        local trigger0 = TriggerManager.CreateTrigger("pretask", eventid, 20002)
        root:SetTask(trigger0)
        upper:AddTask(root)
      end
      upper:AddTask(root)
    end
    return root
  end,
  [4] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = Or.Create()
      do
        local upper = root
        local root = And.Create()
        local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 20002)
        root:AddTask(trigger1)
        upper:AddTask(root)
      end
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 20004)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [5] = function(eventid)
    return
  end,
  [6] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 20003)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [7] = function(eventid)
    return
  end,
  [8] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 10011)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [9] = function(eventid)
    return
  end,
  [10] = function(eventid)
    return
  end,
  [11] = function(eventid)
    return
  end,
  [12] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1135, "Success", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [13] = function(eventid)
    return
  end,
  [14] = function(eventid)
    return
  end,
  [15] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [16] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 3, y = 10},
      {x = 4, y = 10},
      {x = 5, y = 10},
      {x = 6, y = 10}
    }, true)
  end,
  [17] = function(eventid)
    return TriggerManager.CreateTrigger("rolestatus", eventid, {type = 1, value = 5})
  end,
  [18] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 20001)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [19] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [20] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [21] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [22] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [23] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 20002)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [24] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 20004)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [25] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 20003)
  end,
  [26] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 20005)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [27] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 20005)
  end,
  [28] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 20006)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [29] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 20006)
  end,
  [30] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 20006)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [31] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 20004)
  end,
  [32] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1183, "Success", "Instant")
  end,
  [33] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1187, "Success", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [34] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1187, "Either", "BeforeReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [35] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 13, y = 9},
      {x = 13, y = 10},
      {x = 13, y = 11},
      {x = 14, y = 9},
      {x = 14, y = 10},
      {x = 14, y = 11},
      {x = 15, y = 9},
      {x = 15, y = 10},
      {x = 15, y = 11},
      {x = 16, y = 9},
      {x = 16, y = 10},
      {x = 16, y = 11}
    }, true)
  end,
  [36] = function(eventid)
    return
  end,
  [37] = function(eventid)
    return
  end,
  [38] = function(eventid)
    return
  end,
  [39] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1187, "Success", "Instant")
  end,
  [40] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1187, "Success", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [41] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [42] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [43] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [44] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [45] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [46] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [47] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [48] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("pretask", eventid, 10022)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [49] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [50] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 10025)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [51] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [52] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [53] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 10025)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [54] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 10025)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [55] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [56] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [57] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 20013)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [58] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 20013)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [59] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [60] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [61] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1307, "Success", "BeforeReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [62] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1295, "Success", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [63] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [64] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [65] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [66] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("pretask", eventid, 20009)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [67] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("pretask", eventid, 20009)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [68] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("pretask", eventid, 20009)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [69] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [70] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("pretask", eventid, 20012)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [71] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [72] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("pretask", eventid, 20010)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [73] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("pretask", eventid, 20010)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [74] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("pretask", eventid, 20010)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [75] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1294, "Success", "BeforeReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [76] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [77] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 20001)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [78] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 20001)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [79] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger1 = TriggerManager.CreateTrigger("counter", eventid, "item", "20010", 0)
      root:AddTask(trigger1)
      local trigger2 = TriggerManager.CreateTrigger("pretask", eventid, 20002)
      root:AddTask(trigger2)
      upper:AddTask(root)
    end
    return root
  end,
  [80] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 20002)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [81] = function(eventid)
    return
  end,
  [82] = function(eventid)
    return
  end,
  [83] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [84] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [85] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1345, "Success", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [86] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [87] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [88] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [89] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [90] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("pretask", eventid, 20015)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [91] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 20015)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [92] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("pretask", eventid, 20015)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [93] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [94] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [95] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [96] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("pretask", eventid, 20017)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [97] = function(eventid)
    return
  end,
  [98] = function(eventid)
    return
  end,
  [99] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("pretask", eventid, 10044)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [100] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [101] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [102] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1367, "Success", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [103] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1367, "Success", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [104] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [105] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [106] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [107] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [108] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [109] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [110] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end
}
return triggers
