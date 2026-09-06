local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local triggers = {
  [1] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "20001", 5)
  end,
  [2] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10001)
  end,
  [3] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1127, "Success", "AfterReturn")
  end,
  [4] = function(eventid)
    return
  end,
  [5] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "soulFix", "0", 1)
  end,
  [6] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 0, y = 0}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [7] = function(eventid)
    return
  end,
  [8] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10004)
  end,
  [9] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "roleconvertskill", "", 1)
  end,
  [10] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 3, y = 32},
      {x = 4, y = 32},
      {x = 5, y = 32},
      {x = 6, y = 32},
      {x = 7, y = 32}
    }, true)
  end,
  [11] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1189, "Success", "AfterReturn")
  end,
  [12] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10004)
  end,
  [13] = function(eventid)
    return
  end,
  [14] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("pretask", eventid, 10002)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 23, y = 5},
        {x = 23, y = 6},
        {x = 23, y = 7},
        {x = 23, y = 8},
        {x = 23, y = 9}
      }, true)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [15] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 23, y = 5},
      {x = 23, y = 6},
      {x = 23, y = 7}
    }, true)
  end,
  [16] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10007)
  end,
  [17] = function(eventid)
    return
  end,
  [18] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10009)
  end,
  [19] = function(eventid)
    return
  end,
  [20] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10008)
  end,
  [21] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "20005", 1)
  end,
  [22] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("pretask", eventid, 10011)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("counter", eventid, "item", "20007", 1)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [23] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "20006", 1)
  end,
  [24] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("pretask", eventid, 10011)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("counter", eventid, "item", "20007", 1)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [25] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "1", 1)
  end,
  [26] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10013)
  end,
  [27] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "equipstrengthen", "total", 1)
  end,
  [28] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10014)
  end,
  [29] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "friend", "", 1)
  end,
  [30] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10014)
  end,
  [31] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "buyitem", "", 1)
  end,
  [32] = function(eventid)
    return
  end,
  [33] = function(eventid)
    return
  end,
  [34] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "20012", 1)
  end,
  [35] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1183, "Success", "AfterReturn")
  end,
  [36] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10012)
  end,
  [37] = function(eventid)
    return
  end,
  [38] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 17, y = 9},
      {x = 18, y = 9},
      {x = 19, y = 9}
    }, true)
  end,
  [39] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 17, y = 26},
      {x = 17, y = 27},
      {x = 17, y = 28},
      {x = 18, y = 26},
      {x = 18, y = 27},
      {x = 18, y = 28},
      {x = 19, y = 26},
      {x = 19, y = 27},
      {x = 19, y = 28}
    }, true)
  end,
  [40] = function(eventid)
    return
  end,
  [41] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "20010", 1)
  end,
  [42] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 20003)
  end,
  [43] = function(eventid)
    return
  end,
  [44] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 20005)
  end,
  [45] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 12, y = 8},
      {x = 13, y = 8},
      {x = 14, y = 8}
    }, true)
  end,
  [46] = function(eventid)
    return
  end,
  [47] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 20006)
  end,
  [48] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 20001)
  end,
  [49] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = Or.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 19, y = 23},
        {x = 19, y = 24},
        {x = 19, y = 25},
        {x = 19, y = 26},
        {x = 19, y = 27}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [50] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10009)
  end,
  [51] = function(eventid)
    return
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
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 11, y = 14},
        {x = 12, y = 14},
        {x = 13, y = 14},
        {x = 14, y = 14}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [54] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [55] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "item", "20029", 1)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 20010)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [56] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "item", "20018", 1)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [57] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger1 = TriggerManager.CreateTrigger("counter", eventid, "item", "20014", 1)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [58] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "20020", 1)
  end,
  [59] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "20030", 1)
  end,
  [60] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10019)
  end,
  [61] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 15, y = 16},
      {x = 15, y = 17},
      {x = 15, y = 18},
      {x = 15, y = 19},
      {x = 16, y = 16},
      {x = 16, y = 17},
      {x = 16, y = 18},
      {x = 16, y = 19},
      {x = 17, y = 16},
      {x = 17, y = 17},
      {x = 17, y = 18},
      {x = 17, y = 19},
      {x = 18, y = 16},
      {x = 18, y = 17},
      {x = 18, y = 18},
      {x = 18, y = 19},
      {x = 19, y = 16},
      {x = 19, y = 17},
      {x = 19, y = 18},
      {x = 19, y = 19},
      {x = 20, y = 16},
      {x = 20, y = 17},
      {x = 20, y = 18},
      {x = 20, y = 19},
      {x = 21, y = 16},
      {x = 21, y = 17},
      {x = 21, y = 18},
      {x = 21, y = 19},
      {x = 22, y = 16},
      {x = 22, y = 17},
      {x = 22, y = 18},
      {x = 22, y = 19}
    }, true)
  end,
  [62] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10020)
  end,
  [63] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 5, y = 4},
      {x = 5, y = 5},
      {x = 5, y = 6},
      {x = 6, y = 4},
      {x = 6, y = 5},
      {x = 6, y = 6},
      {x = 7, y = 4},
      {x = 7, y = 5},
      {x = 7, y = 6},
      {x = 8, y = 4},
      {x = 8, y = 5},
      {x = 8, y = 6}
    }, true)
  end,
  [64] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10021)
  end,
  [65] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 14, y = 3},
      {x = 14, y = 4},
      {x = 14, y = 5},
      {x = 14, y = 6},
      {x = 14, y = 7},
      {x = 14, y = 8},
      {x = 14, y = 9}
    }, true)
  end,
  [66] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10022)
  end,
  [67] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1295, "Success", "AfterReturn")
  end,
  [68] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("pretask", eventid, 10024)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 19, y = 10},
        {x = 19, y = 11},
        {x = 19, y = 12},
        {x = 19, y = 13},
        {x = 20, y = 10},
        {x = 20, y = 11},
        {x = 20, y = 12},
        {x = 20, y = 13},
        {x = 21, y = 10},
        {x = 21, y = 11},
        {x = 21, y = 12},
        {x = 21, y = 13},
        {x = 22, y = 10},
        {x = 22, y = 11},
        {x = 22, y = 12},
        {x = 22, y = 13}
      }, true)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [69] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "20034", 1)
  end,
  [70] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "20021", 1)
  end,
  [71] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "20022", 1)
  end,
  [72] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "item", "20023", 1)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 10026)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [73] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "20024", 1)
  end,
  [74] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "20019", 1)
  end,
  [75] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "20025", 1)
  end,
  [76] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "20026", 1)
  end,
  [77] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "20027", 1)
  end,
  [78] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 20013)
  end,
  [79] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "20028", 1)
  end,
  [80] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "20031", 1)
  end,
  [81] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "20032", 1)
  end,
  [82] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [83] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "item", "20038", 1)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [84] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "item", "20036", 1)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [85] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "card", "3", 10)
  end,
  [86] = function(eventid)
    return
  end,
  [87] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1122, "Either", "Instant")
  end,
  [88] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10066)
  end,
  [89] = function(eventid)
    return
  end,
  [90] = function(eventid)
    return
  end,
  [92] = function(eventid)
    return
  end,
  [93] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10067)
  end,
  [95] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10068)
  end,
  [99] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10069)
  end,
  [101] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10071)
  end,
  [105] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10073)
  end,
  [107] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10072)
  end,
  [109] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10075)
  end,
  [113] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10076)
  end,
  [115] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10078)
  end
}
return triggers
