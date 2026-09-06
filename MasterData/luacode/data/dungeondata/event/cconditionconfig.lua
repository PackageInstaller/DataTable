local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local triggers = {
  [1] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 21, y = 1},
      {x = 22, y = 1}
    }, true)
  end,
  [2] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 24, y = 4},
      {x = 25, y = 4}
    }, true)
  end,
  [3] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 27, y = 4},
      {x = 28, y = 4}
    }, true)
  end,
  [4] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 9, y = 0},
      {x = 9, y = 1},
      {x = 9, y = 2},
      {x = 9, y = 3},
      {x = 10, y = 0},
      {x = 10, y = 1},
      {x = 10, y = 2},
      {x = 10, y = 3}
    }, true)
  end,
  [5] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 13, y = 0},
      {x = 13, y = 1},
      {x = 13, y = 2},
      {x = 13, y = 3},
      {x = 14, y = 0},
      {x = 14, y = 1},
      {x = 14, y = 2},
      {x = 14, y = 3}
    }, true)
  end,
  [6] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 45, y = 4},
      {x = 46, y = 4}
    }, true)
  end,
  [7] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 36, y = 18},
      {x = 37, y = 18},
      {x = 38, y = 18}
    }, true)
  end,
  [8] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 16, y = 2}
    }, true)
  end,
  [9] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 30, y = 14},
      {x = 31, y = 14}
    }, true)
  end,
  [10] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 13, y = 30},
      {x = 13, y = 31},
      {x = 13, y = 32},
      {x = 13, y = 33},
      {x = 14, y = 30},
      {x = 14, y = 31},
      {x = 14, y = 32},
      {x = 14, y = 33}
    }, true)
  end,
  [11] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 9, y = 22},
      {x = 9, y = 23},
      {x = 9, y = 24}
    }, true)
  end,
  [12] = function(eventid)
    return TriggerManager.CreateTrigger("dialogueend", eventid, 0)
  end,
  [13] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 10, y = 18},
      {x = 11, y = 18},
      {x = 12, y = 18}
    }, true)
  end,
  [14] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 8, y = 5},
      {x = 8, y = 6},
      {x = 8, y = 7},
      {x = 8, y = 8}
    }, true)
  end,
  [15] = function(eventid)
    return TriggerManager.CreateTrigger("dialogueend", eventid, 7)
  end,
  [16] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 25, y = 22},
      {x = 26, y = 22},
      {x = 27, y = 22},
      {x = 28, y = 22},
      {x = 29, y = 22}
    }, true)
  end,
  [17] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 22, y = 23},
      {x = 23, y = 23},
      {x = 24, y = 23}
    }, true)
  end,
  [18] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 20, y = 21},
      {x = 21, y = 21},
      {x = 22, y = 21},
      {x = 23, y = 21},
      {x = 24, y = 21}
    }, true)
  end,
  [19] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 22, y = 19},
      {x = 23, y = 19},
      {x = 24, y = 19}
    }, true)
  end,
  [20] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 20, y = 17},
      {x = 21, y = 17},
      {x = 22, y = 17},
      {x = 23, y = 17},
      {x = 24, y = 17}
    }, true)
  end,
  [21] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 22, y = 15},
      {x = 23, y = 15},
      {x = 24, y = 15}
    }, true)
  end,
  [22] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 20, y = 13},
      {x = 21, y = 13},
      {x = 22, y = 13},
      {x = 23, y = 13},
      {x = 24, y = 13}
    }, true)
  end,
  [23] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 20, y = 45},
      {x = 21, y = 45},
      {x = 22, y = 45},
      {x = 23, y = 45}
    }, true)
  end,
  [24] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 22, y = 24},
      {x = 23, y = 24},
      {x = 24, y = 24}
    }, true)
  end,
  [25] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 20, y = 20},
      {x = 21, y = 20},
      {x = 22, y = 20},
      {x = 23, y = 20},
      {x = 24, y = 20}
    }, true)
  end,
  [26] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 5, y = 2},
      {x = 5, y = 3}
    }, true)
  end,
  [27] = function(eventid)
    return TriggerManager.CreateTrigger("dialogueend", eventid, 11)
  end,
  [28] = function(eventid)
    return TriggerManager.CreateTrigger("dialogueend", eventid, 12)
  end,
  [29] = function(eventid)
    return TriggerManager.CreateTrigger("dialogueend", eventid, 13)
  end,
  [30] = function(eventid)
    return TriggerManager.CreateTrigger("dialogueend", eventid, 0)
  end,
  [31] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 18, y = 23},
        {x = 18, y = 24},
        {x = 18, y = 25},
        {x = 18, y = 26},
        {x = 18, y = 27}
      }, true)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 20008)
      root:AddTask(trigger1)
      local trigger2 = TriggerManager.CreateTrigger("pretask", eventid, 20001)
      root:AddTask(trigger2)
      upper:AddTask(root)
    end
    return root
  end,
  [32] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 10, y = 6}
    }, true)
  end,
  [33] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 17, y = 56},
      {x = 17, y = 57},
      {x = 18, y = 56},
      {x = 18, y = 57},
      {x = 19, y = 56},
      {x = 19, y = 57},
      {x = 20, y = 56},
      {x = 20, y = 57},
      {x = 21, y = 56},
      {x = 21, y = 57},
      {x = 22, y = 56},
      {x = 22, y = 57}
    }, true)
  end,
  [34] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 25, y = 39}
    }, true)
  end,
  [35] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 23, y = 25},
      {x = 24, y = 25},
      {x = 25, y = 25},
      {x = 26, y = 25},
      {x = 27, y = 25},
      {x = 28, y = 25}
    }, true)
  end,
  [36] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 32, y = 7},
      {x = 32, y = 8},
      {x = 32, y = 9}
    }, true)
  end,
  [37] = function(eventid)
    return TriggerManager.CreateTrigger("dialogueend", eventid, 8)
  end,
  [38] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 19, y = 24},
      {x = 19, y = 25}
    }, true)
  end,
  [39] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 18, y = 24},
      {x = 18, y = 25}
    }, true)
  end,
  [40] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 26, y = 7},
      {x = 26, y = 8},
      {x = 26, y = 9},
      {x = 26, y = 10},
      {x = 26, y = 11}
    }, true)
  end,
  [41] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 20, y = 24},
      {x = 20, y = 25}
    }, true)
  end,
  [42] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 6, y = 52},
      {x = 6, y = 53},
      {x = 7, y = 52},
      {x = 7, y = 53}
    }, true)
  end,
  [43] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 2003, "Success", "AfterReturn")
  end,
  [44] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 12, y = 25},
      {x = 13, y = 25},
      {x = 14, y = 25},
      {x = 15, y = 25}
    }, true)
  end,
  [45] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 15, y = 27}
    }, true)
  end,
  [46] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 9, y = 11},
      {x = 9, y = 12},
      {x = 10, y = 11},
      {x = 10, y = 12},
      {x = 11, y = 11},
      {x = 11, y = 12}
    }, true)
  end,
  [47] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 25, y = 40}
    }, true)
  end,
  [48] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 29, y = 41}
    }, true)
  end,
  [49] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 2, y = 21},
      {x = 3, y = 21},
      {x = 4, y = 21},
      {x = 5, y = 21}
    }, true)
  end,
  [50] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 19, y = 10},
      {x = 20, y = 10},
      {x = 21, y = 10}
    }, true)
  end,
  [51] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 12, y = 1},
      {x = 13, y = 1},
      {x = 14, y = 1}
    }, true)
  end,
  [52] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 12, y = 2},
      {x = 13, y = 2},
      {x = 14, y = 2},
      {x = 15, y = 2},
      {x = 16, y = 2}
    }, true)
  end,
  [53] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 12, y = 2},
      {x = 13, y = 2},
      {x = 14, y = 2},
      {x = 15, y = 2},
      {x = 16, y = 2}
    }, true)
  end,
  [54] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 3, y = 17},
      {x = 4, y = 17},
      {x = 5, y = 17}
    }, true)
  end,
  [55] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 23, y = 25},
      {x = 24, y = 25},
      {x = 25, y = 25},
      {x = 26, y = 25},
      {x = 27, y = 25}
    }, true)
  end,
  [56] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 24, y = 38},
      {x = 25, y = 38},
      {x = 26, y = 38}
    }, true)
  end,
  [57] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 5, y = 17}
    }, true)
  end,
  [58] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 6, y = 17}
    }, true)
  end,
  [59] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 12, y = 13}
    }, true)
  end,
  [60] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 22, y = 22},
      {x = 23, y = 22},
      {x = 24, y = 22}
    }, true)
  end,
  [61] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 5, y = 2},
      {x = 5, y = 3}
    }, true)
  end,
  [62] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 10, y = 2},
      {x = 10, y = 3}
    }, true)
  end,
  [63] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 25, y = 9},
      {x = 25, y = 10},
      {x = 25, y = 11}
    }, true)
  end,
  [64] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 25, y = 8}
    }, true)
  end,
  [65] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 17, y = 64}
    }, true)
  end,
  [66] = function(eventid)
    return TriggerManager.CreateTrigger("dialogueend", eventid, 23)
  end,
  [67] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 18, y = 64}
    }, true)
  end,
  [68] = function(eventid)
    return TriggerManager.CreateTrigger("dialogueend", eventid, 24)
  end,
  [69] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = Or.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 14, y = 59}
      }, true)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 15, y = 56},
        {x = 15, y = 57},
        {x = 15, y = 58},
        {x = 15, y = 59}
      }, true)
      root:AddTask(trigger1)
      local trigger2 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 16, y = 56},
        {x = 17, y = 56},
        {x = 18, y = 56},
        {x = 19, y = 56}
      }, true)
      root:AddTask(trigger2)
      local trigger3 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 19, y = 57}
      }, true)
      root:AddTask(trigger3)
      upper:AddTask(root)
    end
    return root
  end,
  [70] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = Or.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 18, y = 52},
        {x = 19, y = 52},
        {x = 20, y = 52},
        {x = 21, y = 52},
        {x = 22, y = 52},
        {x = 23, y = 52}
      }, true)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 21, y = 42}
      }, true)
      root:AddTask(trigger1)
      local trigger2 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 25, y = 43}
      }, true)
      root:AddTask(trigger2)
      upper:AddTask(root)
    end
    return root
  end,
  [71] = function(eventid)
    return TriggerManager.CreateTrigger("dialogueend", eventid, 8)
  end,
  [72] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 21, y = 7},
      {x = 22, y = 7},
      {x = 23, y = 7},
      {x = 24, y = 7},
      {x = 25, y = 7},
      {x = 26, y = 7},
      {x = 27, y = 7}
    }, true)
  end,
  [73] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 24, y = 16},
      {x = 25, y = 16},
      {x = 26, y = 16}
    }, true)
  end,
  [74] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 24, y = 40},
      {x = 25, y = 40},
      {x = 26, y = 40}
    }, true)
  end,
  [75] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 2, y = 27}
    }, true)
  end,
  [76] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 21, y = 3},
      {x = 22, y = 3}
    }, true)
  end,
  [77] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 25, y = 0}
    }, true)
  end,
  [78] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 11, y = 14},
      {x = 12, y = 14},
      {x = 13, y = 14}
    }, true)
  end,
  [79] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 3, y = 10}
    }, true)
  end,
  [80] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 24, y = 6},
      {x = 25, y = 6}
    }, true)
  end,
  [81] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 27, y = 6},
      {x = 28, y = 6}
    }, true)
  end,
  [82] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 18, y = 34},
      {x = 19, y = 34},
      {x = 20, y = 34},
      {x = 21, y = 34},
      {x = 22, y = 34}
    }, true)
  end,
  [83] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 19, y = 18},
      {x = 20, y = 18},
      {x = 21, y = 18}
    }, true)
  end,
  [84] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 9, y = 29},
      {x = 10, y = 29},
      {x = 11, y = 29}
    }, true)
  end,
  [85] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = Or.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 12, y = 18},
        {x = 13, y = 18},
        {x = 14, y = 18},
        {x = 15, y = 18},
        {x = 16, y = 18}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [86] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = Or.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 3, y = 6},
        {x = 4, y = 6},
        {x = 5, y = 6},
        {x = 6, y = 6},
        {x = 7, y = 6},
        {x = 8, y = 6}
      }, true)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 8, y = 5}
      }, true)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [87] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 3, y = 8}
    }, true)
  end,
  [88] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = Or.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 8, y = 25}
      }, true)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 15, y = 25}
      }, true)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [89] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = Or.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 9, y = 0},
        {x = 9, y = 1},
        {x = 9, y = 2},
        {x = 9, y = 3},
        {x = 10, y = 0},
        {x = 10, y = 1},
        {x = 10, y = 2},
        {x = 10, y = 3}
      }, true)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 13, y = 0},
        {x = 13, y = 1},
        {x = 13, y = 2},
        {x = 13, y = 3},
        {x = 14, y = 0},
        {x = 14, y = 1},
        {x = 14, y = 2},
        {x = 14, y = 3}
      }, true)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [90] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = Or.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 8, y = 23},
        {x = 9, y = 23}
      }, true)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 14, y = 23},
        {x = 15, y = 23}
      }, true)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [91] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 20, y = 37}
    }, true)
  end,
  [92] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 9, y = 29},
      {x = 10, y = 29},
      {x = 11, y = 29}
    }, true)
  end,
  [93] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 16, y = 46}
    }, true)
  end,
  [94] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 45, y = 6},
      {x = 46, y = 6}
    }, true)
  end,
  [95] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 19, y = 20},
      {x = 20, y = 20},
      {x = 21, y = 20},
      {x = 22, y = 20},
      {x = 23, y = 20},
      {x = 24, y = 20}
    }, true)
  end,
  [96] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 22, y = 21},
      {x = 23, y = 21},
      {x = 24, y = 21}
    }, true)
  end,
  [97] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 22, y = 11},
      {x = 23, y = 11},
      {x = 24, y = 11}
    }, true)
  end,
  [98] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 22, y = 13},
      {x = 23, y = 13},
      {x = 24, y = 13}
    }, true)
  end,
  [99] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 32, y = 8},
      {x = 32, y = 9},
      {x = 32, y = 10},
      {x = 32, y = 11}
    }, true)
  end,
  [100] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 7, y = 7},
      {x = 7, y = 8}
    }, true)
  end,
  [101] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 20, y = 6},
      {x = 20, y = 7},
      {x = 20, y = 8}
    }, true)
  end,
  [102] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 23, y = 6}
    }, true)
  end,
  [103] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 3, y = 13}
    }, true)
  end,
  [104] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 30, y = 16},
      {x = 31, y = 16}
    }, true)
  end,
  [105] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 1, y = 1}
    }, true)
  end,
  [106] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = Or.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 5, y = 7},
        {x = 5, y = 8}
      }, true)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 6, y = 8}
      }, true)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [107] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 4, y = 25}
    }, true)
  end,
  [108] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 28, y = 3},
      {x = 29, y = 3}
    }, true)
  end,
  [109] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 9, y = 39},
      {x = 10, y = 39},
      {x = 11, y = 39}
    }, true)
  end,
  [110] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 20, y = 37}
    }, true)
  end,
  [111] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 13, y = 19},
      {x = 13, y = 20},
      {x = 13, y = 21}
    }, true)
  end,
  [112] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 9, y = 27}
    }, true)
  end,
  [113] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1187, "Success", "AfterReturn")
  end,
  [114] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 18, y = 12},
      {x = 19, y = 12},
      {x = 20, y = 12},
      {x = 21, y = 12},
      {x = 22, y = 12}
    }, true)
  end,
  [115] = function(eventid)
    return TriggerManager.CreateTrigger("scenedestroy", eventid, 10005)
  end,
  [116] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 32, y = 21},
        {x = 33, y = 21},
        {x = 34, y = 21}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [117] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1186, "Success", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [118] = function(eventid)
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
  [119] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1123, "Success", "AfterReturn")
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("battleend", eventid, 1124, "Success", "AfterReturn")
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [120] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 17, y = 7},
        {x = 17, y = 8},
        {x = 17, y = 9},
        {x = 17, y = 10},
        {x = 18, y = 7},
        {x = 18, y = 8},
        {x = 18, y = 9},
        {x = 18, y = 10},
        {x = 19, y = 7},
        {x = 19, y = 8},
        {x = 19, y = 9},
        {x = 19, y = 10},
        {x = 20, y = 7},
        {x = 20, y = 8},
        {x = 20, y = 9},
        {x = 20, y = 10}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [121] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 7, y = 6},
        {x = 7, y = 7},
        {x = 7, y = 8},
        {x = 7, y = 9},
        {x = 7, y = 10},
        {x = 7, y = 11},
        {x = 7, y = 12},
        {x = 7, y = 13},
        {x = 7, y = 14},
        {x = 7, y = 15},
        {x = 8, y = 6},
        {x = 8, y = 7},
        {x = 8, y = 8},
        {x = 8, y = 9},
        {x = 8, y = 10},
        {x = 8, y = 11},
        {x = 8, y = 12},
        {x = 8, y = 13},
        {x = 8, y = 14},
        {x = 8, y = 15},
        {x = 9, y = 6},
        {x = 9, y = 7},
        {x = 9, y = 8},
        {x = 9, y = 9},
        {x = 9, y = 10},
        {x = 9, y = 11},
        {x = 9, y = 12},
        {x = 9, y = 13},
        {x = 9, y = 14},
        {x = 9, y = 15},
        {x = 10, y = 6},
        {x = 10, y = 7},
        {x = 10, y = 8},
        {x = 10, y = 9},
        {x = 10, y = 10},
        {x = 10, y = 11},
        {x = 10, y = 12},
        {x = 10, y = 13},
        {x = 10, y = 14},
        {x = 10, y = 15},
        {x = 11, y = 6},
        {x = 11, y = 7},
        {x = 11, y = 8},
        {x = 11, y = 9},
        {x = 11, y = 10},
        {x = 11, y = 11},
        {x = 11, y = 12},
        {x = 11, y = 13},
        {x = 11, y = 14},
        {x = 11, y = 15},
        {x = 12, y = 6},
        {x = 12, y = 7},
        {x = 12, y = 8},
        {x = 12, y = 9},
        {x = 12, y = 10},
        {x = 12, y = 11},
        {x = 12, y = 12},
        {x = 12, y = 13},
        {x = 12, y = 14},
        {x = 12, y = 15},
        {x = 13, y = 6},
        {x = 13, y = 7},
        {x = 13, y = 8},
        {x = 13, y = 9},
        {x = 13, y = 10},
        {x = 13, y = 11},
        {x = 13, y = 12},
        {x = 13, y = 13},
        {x = 13, y = 14},
        {x = 13, y = 15},
        {x = 14, y = 6},
        {x = 14, y = 7},
        {x = 14, y = 8},
        {x = 14, y = 9},
        {x = 14, y = 10},
        {x = 14, y = 11},
        {x = 14, y = 12},
        {x = 14, y = 13},
        {x = 14, y = 14},
        {x = 14, y = 15},
        {x = 15, y = 6},
        {x = 15, y = 7},
        {x = 15, y = 8},
        {x = 15, y = 9},
        {x = 15, y = 10},
        {x = 15, y = 11},
        {x = 15, y = 12},
        {x = 15, y = 13},
        {x = 15, y = 14},
        {x = 15, y = 15},
        {x = 16, y = 6},
        {x = 16, y = 7},
        {x = 16, y = 8},
        {x = 16, y = 9},
        {x = 16, y = 10},
        {x = 16, y = 11},
        {x = 16, y = 12},
        {x = 16, y = 13},
        {x = 16, y = 14},
        {x = 16, y = 15}
      }, false)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [122] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 6, y = 6},
        {x = 6, y = 7},
        {x = 6, y = 8},
        {x = 6, y = 9},
        {x = 6, y = 10},
        {x = 6, y = 11},
        {x = 6, y = 12},
        {x = 6, y = 13},
        {x = 6, y = 14},
        {x = 6, y = 15},
        {x = 7, y = 6},
        {x = 7, y = 7},
        {x = 7, y = 8},
        {x = 7, y = 9},
        {x = 7, y = 10},
        {x = 7, y = 11},
        {x = 7, y = 12},
        {x = 7, y = 13},
        {x = 7, y = 14},
        {x = 7, y = 15},
        {x = 8, y = 6},
        {x = 8, y = 7},
        {x = 8, y = 8},
        {x = 8, y = 9},
        {x = 8, y = 10},
        {x = 8, y = 11},
        {x = 8, y = 12},
        {x = 8, y = 13},
        {x = 8, y = 14},
        {x = 8, y = 15},
        {x = 9, y = 6},
        {x = 9, y = 7},
        {x = 9, y = 8},
        {x = 9, y = 9},
        {x = 9, y = 10},
        {x = 9, y = 11},
        {x = 9, y = 12},
        {x = 9, y = 13},
        {x = 9, y = 14},
        {x = 9, y = 15},
        {x = 10, y = 6},
        {x = 10, y = 7},
        {x = 10, y = 8},
        {x = 10, y = 9},
        {x = 10, y = 10},
        {x = 10, y = 11},
        {x = 10, y = 12},
        {x = 10, y = 13},
        {x = 10, y = 14},
        {x = 10, y = 15},
        {x = 11, y = 6},
        {x = 11, y = 7},
        {x = 11, y = 8},
        {x = 11, y = 9},
        {x = 11, y = 10},
        {x = 11, y = 11},
        {x = 11, y = 12},
        {x = 11, y = 13},
        {x = 11, y = 14},
        {x = 11, y = 15},
        {x = 12, y = 6},
        {x = 12, y = 7},
        {x = 12, y = 8},
        {x = 12, y = 9},
        {x = 12, y = 10},
        {x = 12, y = 11},
        {x = 12, y = 12},
        {x = 12, y = 13},
        {x = 12, y = 14},
        {x = 12, y = 15},
        {x = 13, y = 6},
        {x = 13, y = 7},
        {x = 13, y = 8},
        {x = 13, y = 9},
        {x = 13, y = 10},
        {x = 13, y = 11},
        {x = 13, y = 12},
        {x = 13, y = 13},
        {x = 13, y = 14},
        {x = 13, y = 15},
        {x = 14, y = 6},
        {x = 14, y = 7},
        {x = 14, y = 8},
        {x = 14, y = 9},
        {x = 14, y = 10},
        {x = 14, y = 11},
        {x = 14, y = 12},
        {x = 14, y = 13},
        {x = 14, y = 14},
        {x = 14, y = 15},
        {x = 15, y = 6},
        {x = 15, y = 7},
        {x = 15, y = 8},
        {x = 15, y = 9},
        {x = 15, y = 10},
        {x = 15, y = 11},
        {x = 15, y = 12},
        {x = 15, y = 13},
        {x = 15, y = 14},
        {x = 15, y = 15}
      }, false)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [123] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 15, y = 4},
        {x = 15, y = 5},
        {x = 15, y = 6},
        {x = 15, y = 7}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [124] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 15, y = 18}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [125] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 11, y = 32},
        {x = 12, y = 32},
        {x = 13, y = 32},
        {x = 14, y = 32},
        {x = 15, y = 32},
        {x = 16, y = 32},
        {x = 17, y = 32},
        {x = 18, y = 32}
      }, false)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [126] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 14, y = 4},
        {x = 14, y = 5},
        {x = 14, y = 6},
        {x = 14, y = 7},
        {x = 14, y = 8}
      }, false)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [127] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 14, y = 16},
        {x = 15, y = 16},
        {x = 16, y = 16},
        {x = 17, y = 16},
        {x = 18, y = 16}
      }, false)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [128] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 11, y = 31},
        {x = 12, y = 31},
        {x = 13, y = 31},
        {x = 14, y = 31},
        {x = 15, y = 31},
        {x = 16, y = 31},
        {x = 17, y = 31},
        {x = 18, y = 31}
      }, false)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [129] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 7, y = 11},
        {x = 7, y = 12},
        {x = 7, y = 13},
        {x = 7, y = 14},
        {x = 7, y = 15}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [130] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 5, y = 25},
        {x = 6, y = 25},
        {x = 7, y = 25}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [131] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 14, y = 18}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [132] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 4, y = 13},
        {x = 5, y = 13},
        {x = 6, y = 13},
        {x = 7, y = 13},
        {x = 8, y = 13},
        {x = 9, y = 13}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [133] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 4, y = 25},
        {x = 5, y = 25},
        {x = 6, y = 25},
        {x = 7, y = 25},
        {x = 8, y = 25},
        {x = 9, y = 25},
        {x = 10, y = 25},
        {x = 11, y = 25},
        {x = 12, y = 25},
        {x = 13, y = 25},
        {x = 14, y = 25},
        {x = 15, y = 25}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [134] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 8, y = 21},
        {x = 9, y = 21}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [135] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 16, y = 13},
        {x = 17, y = 13},
        {x = 18, y = 13}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [136] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 18, y = 18},
        {x = 18, y = 19},
        {x = 18, y = 20},
        {x = 18, y = 21},
        {x = 18, y = 22}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [137] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 18, y = 18},
        {x = 18, y = 19},
        {x = 18, y = 20},
        {x = 18, y = 21},
        {x = 18, y = 22}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [138] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 11, y = 10},
        {x = 12, y = 10},
        {x = 13, y = 10},
        {x = 14, y = 10},
        {x = 15, y = 10}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [139] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 9, y = 9},
        {x = 10, y = 9},
        {x = 11, y = 9},
        {x = 12, y = 9},
        {x = 13, y = 9},
        {x = 14, y = 9},
        {x = 15, y = 9},
        {x = 16, y = 9}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [140] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 7, y = 36},
        {x = 8, y = 36},
        {x = 9, y = 36},
        {x = 10, y = 36}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [141] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 15, y = 36},
      {x = 15, y = 37},
      {x = 15, y = 38},
      {x = 15, y = 39},
      {x = 15, y = 40},
      {x = 16, y = 36},
      {x = 16, y = 37},
      {x = 16, y = 38},
      {x = 16, y = 39},
      {x = 16, y = 40},
      {x = 17, y = 36},
      {x = 17, y = 37},
      {x = 17, y = 38},
      {x = 17, y = 39},
      {x = 17, y = 40},
      {x = 18, y = 36},
      {x = 18, y = 37},
      {x = 18, y = 38},
      {x = 18, y = 39},
      {x = 18, y = 40},
      {x = 19, y = 36},
      {x = 19, y = 37},
      {x = 19, y = 38},
      {x = 19, y = 39},
      {x = 19, y = 40}
    }, true)
  end,
  [142] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 2, y = 21},
        {x = 2, y = 22},
        {x = 2, y = 23},
        {x = 2, y = 24},
        {x = 2, y = 25},
        {x = 3, y = 21},
        {x = 3, y = 22},
        {x = 3, y = 23},
        {x = 3, y = 24},
        {x = 3, y = 25},
        {x = 4, y = 21},
        {x = 4, y = 22},
        {x = 4, y = 23},
        {x = 4, y = 24},
        {x = 4, y = 25},
        {x = 5, y = 21},
        {x = 5, y = 22},
        {x = 5, y = 23},
        {x = 5, y = 24},
        {x = 5, y = 25},
        {x = 6, y = 21},
        {x = 6, y = 22},
        {x = 6, y = 23},
        {x = 6, y = 24},
        {x = 6, y = 25},
        {x = 7, y = 21},
        {x = 7, y = 22},
        {x = 7, y = 23},
        {x = 7, y = 24},
        {x = 7, y = 25}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [143] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 11, y = 17},
        {x = 12, y = 17},
        {x = 13, y = 17},
        {x = 14, y = 17},
        {x = 15, y = 17},
        {x = 16, y = 17},
        {x = 17, y = 17},
        {x = 18, y = 17}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [144] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 11, y = 17},
        {x = 12, y = 17},
        {x = 13, y = 17},
        {x = 14, y = 17},
        {x = 15, y = 17},
        {x = 16, y = 17},
        {x = 17, y = 17},
        {x = 18, y = 17}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [145] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 8, y = 7},
        {x = 8, y = 8},
        {x = 8, y = 9},
        {x = 8, y = 10},
        {x = 8, y = 11}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [146] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 6, y = 12},
        {x = 6, y = 13},
        {x = 6, y = 14},
        {x = 6, y = 15},
        {x = 7, y = 12},
        {x = 7, y = 13},
        {x = 7, y = 14},
        {x = 7, y = 15}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [147] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 7, y = 4},
        {x = 7, y = 5},
        {x = 7, y = 6},
        {x = 8, y = 4},
        {x = 8, y = 5},
        {x = 8, y = 6},
        {x = 9, y = 4},
        {x = 9, y = 5},
        {x = 9, y = 6},
        {x = 10, y = 4},
        {x = 10, y = 5},
        {x = 10, y = 6}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [148] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 22, y = 10},
        {x = 23, y = 10},
        {x = 24, y = 10},
        {x = 25, y = 10},
        {x = 26, y = 10},
        {x = 27, y = 10},
        {x = 28, y = 10},
        {x = 29, y = 10}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [149] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 22, y = 8},
        {x = 23, y = 8},
        {x = 24, y = 8},
        {x = 25, y = 8},
        {x = 26, y = 8},
        {x = 27, y = 8},
        {x = 28, y = 8},
        {x = 29, y = 8}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [150] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 19, y = 20},
        {x = 20, y = 20},
        {x = 21, y = 20},
        {x = 22, y = 20},
        {x = 23, y = 20}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [151] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 9, y = 18},
        {x = 9, y = 19},
        {x = 9, y = 20},
        {x = 9, y = 21},
        {x = 9, y = 22},
        {x = 9, y = 23}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [152] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 8, y = 18},
        {x = 8, y = 19},
        {x = 8, y = 20},
        {x = 8, y = 21},
        {x = 8, y = 22},
        {x = 8, y = 23},
        {x = 8, y = 24},
        {x = 8, y = 25}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [153] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 10, y = 17},
        {x = 11, y = 17},
        {x = 12, y = 17},
        {x = 13, y = 17},
        {x = 14, y = 17},
        {x = 15, y = 17}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [154] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 10, y = 17},
        {x = 11, y = 17},
        {x = 12, y = 17},
        {x = 13, y = 17},
        {x = 14, y = 17},
        {x = 15, y = 17}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [155] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 7, y = 17},
        {x = 8, y = 17},
        {x = 9, y = 17},
        {x = 10, y = 17},
        {x = 11, y = 17},
        {x = 12, y = 17},
        {x = 13, y = 17},
        {x = 14, y = 17}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [156] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 11, y = 50},
        {x = 12, y = 50},
        {x = 13, y = 50},
        {x = 14, y = 50},
        {x = 15, y = 50},
        {x = 16, y = 50},
        {x = 17, y = 50},
        {x = 18, y = 50}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [157] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 11, y = 50},
        {x = 12, y = 50},
        {x = 13, y = 50},
        {x = 14, y = 50},
        {x = 15, y = 50},
        {x = 16, y = 50},
        {x = 17, y = 50},
        {x = 18, y = 50}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [158] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 21, y = 22},
        {x = 22, y = 22},
        {x = 23, y = 22},
        {x = 24, y = 22},
        {x = 25, y = 22},
        {x = 26, y = 22},
        {x = 27, y = 22},
        {x = 28, y = 22}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [159] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 2, y = 11},
        {x = 3, y = 11},
        {x = 4, y = 11},
        {x = 5, y = 11},
        {x = 6, y = 11},
        {x = 7, y = 11},
        {x = 8, y = 11},
        {x = 9, y = 11},
        {x = 10, y = 11},
        {x = 11, y = 11},
        {x = 12, y = 11}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [160] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 17, y = 26},
        {x = 17, y = 27},
        {x = 18, y = 26},
        {x = 18, y = 27},
        {x = 19, y = 26},
        {x = 19, y = 27}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [161] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 17, y = 26},
        {x = 17, y = 27},
        {x = 18, y = 26},
        {x = 18, y = 27},
        {x = 19, y = 26},
        {x = 19, y = 27}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [162] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 17, y = 26},
        {x = 17, y = 27},
        {x = 18, y = 26},
        {x = 18, y = 27},
        {x = 19, y = 26},
        {x = 19, y = 27}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [163] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 17, y = 26},
        {x = 17, y = 27},
        {x = 18, y = 26},
        {x = 18, y = 27},
        {x = 19, y = 26},
        {x = 19, y = 27}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [164] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1355, "Success", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [165] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 7, y = 15},
        {x = 8, y = 15},
        {x = 9, y = 15},
        {x = 10, y = 15},
        {x = 11, y = 15},
        {x = 12, y = 15}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [166] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("pretask", eventid, 10040)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [167] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 3, y = 30},
      {x = 4, y = 30},
      {x = 5, y = 30},
      {x = 6, y = 30},
      {x = 7, y = 30}
    }, true)
  end,
  [168] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 23, y = 5},
      {x = 23, y = 6},
      {x = 23, y = 7},
      {x = 23, y = 8},
      {x = 23, y = 9}
    }, true)
  end,
  [169] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 32, y = 12},
      {x = 33, y = 12},
      {x = 34, y = 12},
      {x = 35, y = 12},
      {x = 36, y = 12}
    }, true)
  end,
  [170] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 31, y = 23},
      {x = 32, y = 23},
      {x = 33, y = 23},
      {x = 34, y = 23}
    }, true)
  end,
  [171] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 8, y = 39},
      {x = 9, y = 39},
      {x = 10, y = 39}
    }, true)
  end,
  [172] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 18, y = 19},
      {x = 18, y = 20},
      {x = 18, y = 21},
      {x = 18, y = 22},
      {x = 18, y = 23}
    }, true)
  end,
  [173] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1135, "Success", "AfterReturn")
  end,
  [174] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 15, y = 14},
      {x = 16, y = 14},
      {x = 17, y = 14}
    }, true)
  end,
  [175] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1135, "Fail", "AfterReturn")
  end,
  [176] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 17, y = 20},
      {x = 17, y = 21},
      {x = 17, y = 22},
      {x = 17, y = 23}
    }, true)
  end,
  [177] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 7, y = 7},
        {x = 7, y = 8}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [178] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1187, "Fail", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [179] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 17, y = 27},
      {x = 18, y = 27},
      {x = 19, y = 27},
      {x = 20, y = 27},
      {x = 21, y = 27},
      {x = 22, y = 27},
      {x = 23, y = 27}
    }, true)
  end,
  [180] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1189, "Success", "AfterReturn")
  end,
  [181] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 17, y = 16},
      {x = 18, y = 16},
      {x = 19, y = 16}
    }, true)
  end,
  [182] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 2, y = 17},
        {x = 3, y = 17},
        {x = 4, y = 17},
        {x = 5, y = 17},
        {x = 6, y = 17},
        {x = 7, y = 17}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [183] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 21, y = 4},
      {x = 21, y = 5},
      {x = 21, y = 6}
    }, true)
  end,
  [184] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1183, "Success", "AfterReturn")
  end,
  [185] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 7, y = 10},
      {x = 8, y = 10},
      {x = 9, y = 10},
      {x = 10, y = 10},
      {x = 11, y = 10}
    }, true)
  end,
  [186] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = Or.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 7, y = 11},
        {x = 8, y = 11},
        {x = 9, y = 11},
        {x = 10, y = 11},
        {x = 11, y = 11}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [187] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1134, "Success", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [188] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1134, "Fail", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [189] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1191, "Success", "AfterReturn")
  end,
  [190] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1127, "Fail", "AfterReturn")
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 20, y = 8}
      }, true)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [191] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1127, "Success", "AfterReturn")
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 17, y = 35},
        {x = 17, y = 36},
        {x = 18, y = 35},
        {x = 18, y = 36},
        {x = 19, y = 35},
        {x = 19, y = 36},
        {x = 20, y = 35},
        {x = 20, y = 36},
        {x = 21, y = 35},
        {x = 21, y = 36},
        {x = 22, y = 35},
        {x = 22, y = 36},
        {x = 23, y = 35},
        {x = 23, y = 36},
        {x = 24, y = 35},
        {x = 24, y = 36},
        {x = 25, y = 35},
        {x = 25, y = 36},
        {x = 26, y = 35},
        {x = 26, y = 36}
      }, true)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [192] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1127, "Fail", "AfterReturn")
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 17, y = 35},
        {x = 17, y = 36},
        {x = 18, y = 35},
        {x = 18, y = 36},
        {x = 19, y = 35},
        {x = 19, y = 36},
        {x = 20, y = 35},
        {x = 20, y = 36},
        {x = 21, y = 35},
        {x = 21, y = 36},
        {x = 22, y = 35},
        {x = 22, y = 36},
        {x = 23, y = 35},
        {x = 23, y = 36},
        {x = 24, y = 35},
        {x = 24, y = 36},
        {x = 25, y = 35},
        {x = 25, y = 36},
        {x = 26, y = 35},
        {x = 26, y = 36}
      }, true)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [193] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 40, y = 5},
        {x = 40, y = 6},
        {x = 40, y = 7},
        {x = 41, y = 5},
        {x = 41, y = 6},
        {x = 41, y = 7},
        {x = 42, y = 5},
        {x = 42, y = 6},
        {x = 42, y = 7}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [194] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 16, y = 40},
        {x = 17, y = 40}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [195] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1186, "Either", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [196] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 11, y = 8},
      {x = 12, y = 8},
      {x = 13, y = 8},
      {x = 14, y = 8}
    }, true)
  end,
  [197] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1186, "Either", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [198] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = Or.Create()
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 20001)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [199] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 2, y = 27}
    }, true)
  end,
  [200] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1189, "Fail", "Instant")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [201] = function(eventid)
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
  [202] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [203] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 3, y = 20},
      {x = 3, y = 21},
      {x = 4, y = 20},
      {x = 4, y = 21},
      {x = 5, y = 20},
      {x = 5, y = 21},
      {x = 6, y = 20},
      {x = 6, y = 21},
      {x = 7, y = 20},
      {x = 7, y = 21},
      {x = 8, y = 20},
      {x = 8, y = 21}
    }, true)
  end,
  [204] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 3, y = 13},
      {x = 4, y = 13},
      {x = 5, y = 13},
      {x = 6, y = 13},
      {x = 7, y = 13},
      {x = 8, y = 13}
    }, true)
  end,
  [205] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 6, y = 12},
      {x = 7, y = 12},
      {x = 8, y = 12}
    }, true)
  end,
  [206] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 0, y = 0}
    }, true)
  end,
  [207] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 9, y = 9},
      {x = 9, y = 10},
      {x = 9, y = 11}
    }, true)
  end,
  [208] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 19, y = 15},
      {x = 19, y = 16},
      {x = 19, y = 17},
      {x = 19, y = 18},
      {x = 19, y = 19}
    }, true)
  end,
  [209] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = Or.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 21, y = 14},
        {x = 22, y = 14},
        {x = 23, y = 14},
        {x = 24, y = 14},
        {x = 25, y = 14}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [210] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 20, y = 9},
      {x = 21, y = 9},
      {x = 22, y = 9}
    }, true)
  end,
  [211] = function(eventid)
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
  [212] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 6, y = 17},
      {x = 7, y = 17},
      {x = 8, y = 17},
      {x = 9, y = 17},
      {x = 10, y = 17},
      {x = 11, y = 17},
      {x = 12, y = 17},
      {x = 13, y = 17},
      {x = 14, y = 17},
      {x = 15, y = 17},
      {x = 16, y = 17},
      {x = 17, y = 17},
      {x = 18, y = 17},
      {x = 19, y = 17},
      {x = 20, y = 17},
      {x = 21, y = 17}
    }, true)
  end,
  [213] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 17, y = 18},
        {x = 18, y = 18},
        {x = 19, y = 18}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [214] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 7, y = 10},
        {x = 7, y = 11},
        {x = 7, y = 12},
        {x = 7, y = 13}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [215] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 1, y = 20},
        {x = 1, y = 21},
        {x = 2, y = 20},
        {x = 2, y = 21},
        {x = 3, y = 20},
        {x = 3, y = 21}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [216] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 17, y = 25},
        {x = 17, y = 26},
        {x = 18, y = 25},
        {x = 18, y = 26},
        {x = 19, y = 25},
        {x = 19, y = 26}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [217] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 21, y = 4},
      {x = 21, y = 5},
      {x = 21, y = 6}
    }, true)
  end,
  [218] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 15, y = 13},
        {x = 15, y = 14},
        {x = 15, y = 15},
        {x = 16, y = 13},
        {x = 16, y = 14},
        {x = 16, y = 15}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [219] = function(eventid)
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
  [220] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 19, y = 12},
        {x = 19, y = 13},
        {x = 20, y = 12},
        {x = 20, y = 13},
        {x = 21, y = 12},
        {x = 21, y = 13},
        {x = 22, y = 12},
        {x = 22, y = 13},
        {x = 23, y = 12},
        {x = 23, y = 13},
        {x = 24, y = 12},
        {x = 24, y = 13}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [221] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 11, y = 22},
        {x = 11, y = 23},
        {x = 11, y = 24},
        {x = 11, y = 25},
        {x = 11, y = 26}
      }, true)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 20010)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [222] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 15, y = 23},
        {x = 15, y = 24},
        {x = 15, y = 25},
        {x = 15, y = 26},
        {x = 15, y = 27},
        {x = 15, y = 28}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [223] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 3, y = 27},
        {x = 4, y = 27},
        {x = 5, y = 27},
        {x = 6, y = 27}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [224] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 4, y = 5}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [225] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1295, "Success", "AfterReturn")
  end,
  [226] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1295, "Success", "AfterReturn")
  end,
  [227] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 16, y = 17}
    }, true)
  end,
  [228] = function(eventid)
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
  [229] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 3, y = 26},
        {x = 4, y = 26},
        {x = 5, y = 26},
        {x = 6, y = 26},
        {x = 7, y = 26},
        {x = 8, y = 26}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [230] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 5, y = 5}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [231] = function(eventid)
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
  [232] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 8, y = 14},
        {x = 9, y = 14},
        {x = 10, y = 14}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [233] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 20, y = 26},
        {x = 21, y = 26},
        {x = 22, y = 26}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [234] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 16, y = 17},
        {x = 16, y = 18},
        {x = 16, y = 19}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [235] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 16, y = 17},
        {x = 16, y = 18},
        {x = 16, y = 19}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [236] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 16, y = 15},
        {x = 16, y = 16},
        {x = 16, y = 17}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [237] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 8, y = 22},
        {x = 9, y = 22},
        {x = 10, y = 22},
        {x = 11, y = 22},
        {x = 12, y = 22}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [238] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 8, y = 22},
        {x = 9, y = 22},
        {x = 10, y = 22},
        {x = 11, y = 22},
        {x = 12, y = 22}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [239] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 19, y = 3},
        {x = 19, y = 4},
        {x = 19, y = 5},
        {x = 19, y = 6},
        {x = 19, y = 7}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [240] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 16, y = 8},
        {x = 16, y = 9},
        {x = 16, y = 10},
        {x = 16, y = 11},
        {x = 16, y = 12}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [241] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 8, y = 8},
        {x = 8, y = 9},
        {x = 8, y = 10},
        {x = 9, y = 8},
        {x = 9, y = 9},
        {x = 9, y = 10},
        {x = 10, y = 8},
        {x = 10, y = 9},
        {x = 10, y = 10},
        {x = 11, y = 8},
        {x = 11, y = 9},
        {x = 11, y = 10}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [242] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 4, y = 5},
        {x = 5, y = 5},
        {x = 6, y = 5}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [243] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 4, y = 7}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [244] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 4, y = 8}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [245] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 9, y = 21},
        {x = 10, y = 21},
        {x = 11, y = 21},
        {x = 12, y = 21},
        {x = 13, y = 21},
        {x = 14, y = 21}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [246] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 9, y = 20},
        {x = 10, y = 20},
        {x = 11, y = 20},
        {x = 12, y = 20},
        {x = 13, y = 20},
        {x = 14, y = 20}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [247] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 2, y = 24},
        {x = 2, y = 25},
        {x = 2, y = 26},
        {x = 3, y = 24},
        {x = 3, y = 25},
        {x = 3, y = 26},
        {x = 4, y = 24},
        {x = 4, y = 25},
        {x = 4, y = 26},
        {x = 5, y = 24},
        {x = 5, y = 25},
        {x = 5, y = 26}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [248] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 15, y = 26},
        {x = 15, y = 27},
        {x = 15, y = 28},
        {x = 15, y = 29},
        {x = 16, y = 26},
        {x = 16, y = 27},
        {x = 16, y = 28},
        {x = 16, y = 29},
        {x = 17, y = 26},
        {x = 17, y = 27},
        {x = 17, y = 28},
        {x = 17, y = 29},
        {x = 18, y = 26},
        {x = 18, y = 27},
        {x = 18, y = 28},
        {x = 18, y = 29},
        {x = 19, y = 26},
        {x = 19, y = 27},
        {x = 19, y = 28},
        {x = 19, y = 29},
        {x = 20, y = 26},
        {x = 20, y = 27},
        {x = 20, y = 28},
        {x = 20, y = 29},
        {x = 21, y = 26},
        {x = 21, y = 27},
        {x = 21, y = 28},
        {x = 21, y = 29},
        {x = 22, y = 26},
        {x = 22, y = 27},
        {x = 22, y = 28},
        {x = 22, y = 29},
        {x = 23, y = 26},
        {x = 23, y = 27},
        {x = 23, y = 28},
        {x = 23, y = 29}
      }, true)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 10025)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [249] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 8, y = 7},
        {x = 8, y = 8},
        {x = 8, y = 9},
        {x = 8, y = 10},
        {x = 8, y = 11}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [250] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 8, y = 7},
        {x = 8, y = 8},
        {x = 8, y = 9},
        {x = 8, y = 10},
        {x = 8, y = 11}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [251] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 11, y = 5},
        {x = 11, y = 6},
        {x = 11, y = 7},
        {x = 11, y = 8},
        {x = 11, y = 9},
        {x = 11, y = 10}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [252] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 25, y = 9},
        {x = 25, y = 10},
        {x = 25, y = 11},
        {x = 25, y = 12}
      }, true)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 20012)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [253] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1127, "Success", "Instant")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [254] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 20, y = 17},
        {x = 20, y = 18},
        {x = 20, y = 19}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [255] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 8, y = 11},
        {x = 9, y = 11},
        {x = 10, y = 11},
        {x = 11, y = 11}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [256] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 15, y = 34},
        {x = 16, y = 34},
        {x = 17, y = 34}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [257] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 15, y = 26},
        {x = 16, y = 26},
        {x = 17, y = 26}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [258] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 19, y = 35},
        {x = 20, y = 35},
        {x = 21, y = 35}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [259] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 19, y = 34},
        {x = 20, y = 34},
        {x = 21, y = 34}
      }, true)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("battleend", eventid, 1189, "Success", "AfterReturn")
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [260] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 20, y = 37}
      }, true)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("battleend", eventid, 1189, "Success", "AfterReturn")
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [261] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 13, y = 19},
        {x = 13, y = 20},
        {x = 13, y = 21},
        {x = 13, y = 22}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [262] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 12, y = 19},
        {x = 12, y = 20},
        {x = 12, y = 21},
        {x = 12, y = 22}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [263] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 8, y = 13},
        {x = 9, y = 13},
        {x = 10, y = 13},
        {x = 11, y = 13}
      }, true)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 10026)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [264] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 20, y = 25},
        {x = 21, y = 25},
        {x = 22, y = 25},
        {x = 23, y = 25},
        {x = 24, y = 25}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [265] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 18, y = 17},
        {x = 18, y = 18},
        {x = 18, y = 19},
        {x = 18, y = 20}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [266] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 15, y = 17},
        {x = 15, y = 18},
        {x = 15, y = 19},
        {x = 15, y = 20}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [267] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 17, y = 15},
        {x = 17, y = 16},
        {x = 17, y = 17}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [268] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 8, y = 17},
        {x = 9, y = 17},
        {x = 10, y = 17},
        {x = 11, y = 17},
        {x = 12, y = 17},
        {x = 13, y = 17},
        {x = 14, y = 17},
        {x = 15, y = 17}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [269] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 5, y = 16},
        {x = 6, y = 16},
        {x = 7, y = 16},
        {x = 8, y = 16},
        {x = 9, y = 16},
        {x = 10, y = 16},
        {x = 11, y = 16},
        {x = 12, y = 16},
        {x = 13, y = 16},
        {x = 14, y = 16},
        {x = 15, y = 16},
        {x = 16, y = 16},
        {x = 17, y = 16},
        {x = 18, y = 16},
        {x = 19, y = 16}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [270] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 15, y = 3},
        {x = 15, y = 4},
        {x = 15, y = 5},
        {x = 15, y = 6},
        {x = 15, y = 7},
        {x = 15, y = 8},
        {x = 15, y = 9},
        {x = 15, y = 10},
        {x = 15, y = 11},
        {x = 15, y = 12}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [271] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 10, y = 18},
        {x = 10, y = 19},
        {x = 10, y = 20},
        {x = 10, y = 21},
        {x = 10, y = 22},
        {x = 10, y = 23}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [272] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 9, y = 18},
        {x = 9, y = 19},
        {x = 9, y = 20},
        {x = 9, y = 21},
        {x = 9, y = 22},
        {x = 9, y = 23}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [273] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 8, y = 21},
        {x = 9, y = 21},
        {x = 10, y = 21},
        {x = 11, y = 21}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [274] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 26, y = 29},
        {x = 26, y = 30},
        {x = 26, y = 31},
        {x = 27, y = 29},
        {x = 27, y = 30},
        {x = 27, y = 31},
        {x = 28, y = 29},
        {x = 28, y = 30},
        {x = 28, y = 31},
        {x = 29, y = 29},
        {x = 29, y = 30},
        {x = 29, y = 31},
        {x = 30, y = 29},
        {x = 30, y = 30},
        {x = 30, y = 31},
        {x = 31, y = 29},
        {x = 31, y = 30},
        {x = 31, y = 31},
        {x = 32, y = 29},
        {x = 32, y = 30},
        {x = 32, y = 31},
        {x = 33, y = 29},
        {x = 33, y = 30},
        {x = 33, y = 31},
        {x = 34, y = 29},
        {x = 34, y = 30},
        {x = 34, y = 31},
        {x = 35, y = 29},
        {x = 35, y = 30},
        {x = 35, y = 31},
        {x = 36, y = 29},
        {x = 36, y = 30},
        {x = 36, y = 31}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [275] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 15, y = 10},
        {x = 16, y = 10},
        {x = 17, y = 10},
        {x = 18, y = 10}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [276] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 15, y = 9},
        {x = 16, y = 9},
        {x = 17, y = 9},
        {x = 18, y = 9}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [277] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 14, y = 6},
        {x = 14, y = 7},
        {x = 14, y = 8},
        {x = 14, y = 9},
        {x = 14, y = 10}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [278] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 17, y = 7},
        {x = 17, y = 8},
        {x = 18, y = 7},
        {x = 18, y = 8},
        {x = 19, y = 7},
        {x = 19, y = 8},
        {x = 20, y = 7},
        {x = 20, y = 8},
        {x = 21, y = 7},
        {x = 21, y = 8},
        {x = 22, y = 7},
        {x = 22, y = 8},
        {x = 23, y = 7},
        {x = 23, y = 8}
      }, false)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [279] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 20, y = 6},
        {x = 20, y = 7},
        {x = 20, y = 8},
        {x = 20, y = 9},
        {x = 20, y = 10},
        {x = 20, y = 11},
        {x = 20, y = 12},
        {x = 20, y = 13},
        {x = 20, y = 14},
        {x = 20, y = 15},
        {x = 21, y = 6},
        {x = 21, y = 7},
        {x = 21, y = 8},
        {x = 21, y = 9},
        {x = 21, y = 10},
        {x = 21, y = 11},
        {x = 21, y = 12},
        {x = 21, y = 13},
        {x = 21, y = 14},
        {x = 21, y = 15}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [280] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1123, "Success", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [281] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 17, y = 6},
        {x = 17, y = 7},
        {x = 17, y = 8},
        {x = 17, y = 9},
        {x = 17, y = 10},
        {x = 17, y = 11},
        {x = 17, y = 12},
        {x = 17, y = 13}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [282] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 19, y = 10},
      {x = 19, y = 11},
      {x = 19, y = 12}
    }, true)
  end,
  [283] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "49500", 1)
  end,
  [284] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1295, "Success", "Instant")
  end,
  [285] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1295, "Success", "AfterReturn")
  end,
  [286] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 20, y = 38},
        {x = 20, y = 39},
        {x = 21, y = 38},
        {x = 21, y = 39},
        {x = 22, y = 38},
        {x = 22, y = 39},
        {x = 23, y = 38},
        {x = 23, y = 39},
        {x = 24, y = 38},
        {x = 24, y = 39}
      }, false)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [287] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = Not.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [288] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 1, y = 21},
        {x = 1, y = 22},
        {x = 1, y = 23},
        {x = 1, y = 24},
        {x = 1, y = 25},
        {x = 1, y = 26},
        {x = 2, y = 21},
        {x = 2, y = 22},
        {x = 2, y = 23},
        {x = 2, y = 24},
        {x = 2, y = 25},
        {x = 2, y = 26},
        {x = 3, y = 21},
        {x = 3, y = 22},
        {x = 3, y = 23},
        {x = 3, y = 24},
        {x = 3, y = 25},
        {x = 3, y = 26},
        {x = 4, y = 21},
        {x = 4, y = 22},
        {x = 4, y = 23},
        {x = 4, y = 24},
        {x = 4, y = 25},
        {x = 4, y = 26},
        {x = 5, y = 21},
        {x = 5, y = 22},
        {x = 5, y = 23},
        {x = 5, y = 24},
        {x = 5, y = 25},
        {x = 5, y = 26},
        {x = 6, y = 21},
        {x = 6, y = 22},
        {x = 6, y = 23},
        {x = 6, y = 24},
        {x = 6, y = 25},
        {x = 6, y = 26}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [289] = function(eventid)
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
  [290] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 12, y = 48},
      {x = 13, y = 48},
      {x = 14, y = 48},
      {x = 15, y = 48},
      {x = 16, y = 48}
    }, true)
  end,
  [291] = function(eventid)
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
  [292] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 12, y = 53},
        {x = 12, y = 54},
        {x = 12, y = 55},
        {x = 12, y = 56},
        {x = 12, y = 57},
        {x = 13, y = 53},
        {x = 13, y = 54},
        {x = 13, y = 55},
        {x = 13, y = 56},
        {x = 13, y = 57},
        {x = 14, y = 53},
        {x = 14, y = 54},
        {x = 14, y = 55},
        {x = 14, y = 56},
        {x = 14, y = 57},
        {x = 15, y = 53},
        {x = 15, y = 54},
        {x = 15, y = 55},
        {x = 15, y = 56},
        {x = 15, y = 57},
        {x = 16, y = 53},
        {x = 16, y = 54},
        {x = 16, y = 55},
        {x = 16, y = 56},
        {x = 16, y = 57}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [293] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 12, y = 24},
        {x = 13, y = 24},
        {x = 14, y = 24},
        {x = 15, y = 24},
        {x = 16, y = 24}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [294] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1295, "Success", "AfterReturn")
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 12, y = 48},
        {x = 13, y = 48},
        {x = 14, y = 48},
        {x = 15, y = 48},
        {x = 16, y = 48}
      }, true)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [295] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 6, y = 16},
      {x = 7, y = 16},
      {x = 8, y = 16},
      {x = 9, y = 16},
      {x = 10, y = 16},
      {x = 11, y = 16},
      {x = 12, y = 16},
      {x = 13, y = 16},
      {x = 14, y = 16},
      {x = 15, y = 16},
      {x = 16, y = 16},
      {x = 17, y = 16},
      {x = 18, y = 16},
      {x = 19, y = 16},
      {x = 20, y = 16},
      {x = 21, y = 16}
    }, true)
  end,
  [296] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1134, "Success", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [297] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 31, y = 7},
        {x = 32, y = 7},
        {x = 33, y = 7}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [298] = function(eventid)
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
  [299] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 37, y = 23}
    }, true)
  end,
  [300] = function(eventid)
    return TriggerManager.CreateTrigger("pretask", eventid, 10024)
  end,
  [301] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 33, y = 21},
      {x = 33, y = 22},
      {x = 33, y = 23},
      {x = 33, y = 24},
      {x = 33, y = 25},
      {x = 34, y = 21},
      {x = 34, y = 22},
      {x = 34, y = 23},
      {x = 34, y = 24},
      {x = 34, y = 25},
      {x = 35, y = 21},
      {x = 35, y = 22},
      {x = 35, y = 23},
      {x = 35, y = 24},
      {x = 35, y = 25},
      {x = 36, y = 21},
      {x = 36, y = 22},
      {x = 36, y = 23},
      {x = 36, y = 24},
      {x = 36, y = 25},
      {x = 37, y = 21},
      {x = 37, y = 22},
      {x = 37, y = 23},
      {x = 37, y = 24},
      {x = 37, y = 25},
      {x = 38, y = 21},
      {x = 38, y = 22},
      {x = 38, y = 23},
      {x = 38, y = 24},
      {x = 38, y = 25},
      {x = 39, y = 21},
      {x = 39, y = 22},
      {x = 39, y = 23},
      {x = 39, y = 24},
      {x = 39, y = 25}
    }, true)
  end,
  [302] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 24, y = 15}
    }, true)
  end,
  [303] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 10, y = 11},
        {x = 11, y = 11}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [304] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 10, y = 10}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [305] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 9, y = 10},
        {x = 10, y = 10},
        {x = 11, y = 10}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [306] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 9, y = 10},
        {x = 10, y = 10},
        {x = 11, y = 10}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [307] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 14, y = 22},
        {x = 15, y = 22},
        {x = 16, y = 22},
        {x = 17, y = 22},
        {x = 18, y = 22}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [308] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 32, y = 22},
        {x = 33, y = 22},
        {x = 34, y = 22}
      }, false)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 10022)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [309] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 14, y = 21},
        {x = 14, y = 22},
        {x = 14, y = 23},
        {x = 14, y = 24},
        {x = 14, y = 25},
        {x = 14, y = 26},
        {x = 15, y = 21},
        {x = 15, y = 22},
        {x = 15, y = 23},
        {x = 15, y = 24},
        {x = 15, y = 25},
        {x = 15, y = 26},
        {x = 16, y = 21},
        {x = 16, y = 22},
        {x = 16, y = 23},
        {x = 16, y = 24},
        {x = 16, y = 25},
        {x = 16, y = 26}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [310] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 18, y = 5},
        {x = 18, y = 6},
        {x = 18, y = 7},
        {x = 19, y = 5},
        {x = 19, y = 6},
        {x = 19, y = 7},
        {x = 20, y = 5},
        {x = 20, y = 6},
        {x = 20, y = 7},
        {x = 21, y = 5},
        {x = 21, y = 6},
        {x = 21, y = 7},
        {x = 22, y = 5},
        {x = 22, y = 6},
        {x = 22, y = 7},
        {x = 23, y = 5},
        {x = 23, y = 6},
        {x = 23, y = 7}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [311] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("pretask", eventid, 10029)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 14, y = 24},
        {x = 14, y = 25},
        {x = 14, y = 26},
        {x = 14, y = 27},
        {x = 15, y = 24},
        {x = 15, y = 25},
        {x = 15, y = 26},
        {x = 15, y = 27},
        {x = 16, y = 24},
        {x = 16, y = 25},
        {x = 16, y = 26},
        {x = 16, y = 27},
        {x = 17, y = 24},
        {x = 17, y = 25},
        {x = 17, y = 26},
        {x = 17, y = 27}
      }, true)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [312] = function(eventid)
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
  [313] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 21, y = 35}
    }, true)
  end,
  [314] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("pretask", eventid, 10040)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 8, y = 24},
        {x = 8, y = 25},
        {x = 9, y = 24},
        {x = 9, y = 25},
        {x = 10, y = 24},
        {x = 10, y = 25},
        {x = 11, y = 24},
        {x = 11, y = 25},
        {x = 12, y = 24},
        {x = 12, y = 25}
      }, true)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [315] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1123, "Success", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [316] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1124, "Success", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [317] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      upper:AddTask(root)
    end
    return root
  end,
  [318] = function(eventid)
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
  [319] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("pretask", eventid, 10022)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 16, y = 17}
      }, true)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [320] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 12, y = 29},
        {x = 12, y = 30},
        {x = 13, y = 29},
        {x = 13, y = 30},
        {x = 14, y = 29},
        {x = 14, y = 30},
        {x = 15, y = 29},
        {x = 15, y = 30}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [321] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 12, y = 8},
        {x = 13, y = 8},
        {x = 14, y = 8}
      }, true)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 20003)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [322] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 15, y = 5},
        {x = 15, y = 6},
        {x = 15, y = 7},
        {x = 16, y = 5},
        {x = 16, y = 6},
        {x = 16, y = 7},
        {x = 17, y = 5},
        {x = 17, y = 6},
        {x = 17, y = 7}
      }, true)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 20005)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [323] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 23, y = 28},
        {x = 23, y = 29},
        {x = 24, y = 28},
        {x = 24, y = 29},
        {x = 25, y = 28},
        {x = 25, y = 29},
        {x = 26, y = 28},
        {x = 26, y = 29},
        {x = 27, y = 28},
        {x = 27, y = 29}
      }, true)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 20006)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [324] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 13, y = 9},
        {x = 13, y = 10},
        {x = 13, y = 11},
        {x = 13, y = 12}
      }, true)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("pretask", eventid, 20002)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [325] = function(eventid)
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
  [326] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("pretask", eventid, 10042)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [327] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 5, y = 16}
    }, true)
  end,
  [328] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 2, y = 29},
      {x = 2, y = 30},
      {x = 3, y = 29},
      {x = 3, y = 30},
      {x = 4, y = 29},
      {x = 4, y = 30},
      {x = 5, y = 29},
      {x = 5, y = 30},
      {x = 6, y = 29},
      {x = 6, y = 30},
      {x = 7, y = 29},
      {x = 7, y = 30},
      {x = 8, y = 29},
      {x = 8, y = 30},
      {x = 9, y = 29},
      {x = 9, y = 30},
      {x = 10, y = 29},
      {x = 10, y = 30}
    }, true)
  end,
  [329] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1124, "Fail", "AfterReturn")
  end,
  [330] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 19, y = 6},
        {x = 19, y = 7},
        {x = 19, y = 8},
        {x = 19, y = 9},
        {x = 19, y = 10},
        {x = 20, y = 6},
        {x = 20, y = 7},
        {x = 20, y = 8},
        {x = 20, y = 9},
        {x = 20, y = 10}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [331] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger1 = TriggerManager.CreateTrigger("battleend", eventid, 1183, "Fail", "AfterReturn")
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [332] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 10, y = 8},
        {x = 10, y = 9},
        {x = 10, y = 10},
        {x = 10, y = 11},
        {x = 11, y = 8},
        {x = 11, y = 9},
        {x = 11, y = 10},
        {x = 11, y = 11},
        {x = 12, y = 8},
        {x = 12, y = 9},
        {x = 12, y = 10},
        {x = 12, y = 11},
        {x = 13, y = 8},
        {x = 13, y = 9},
        {x = 13, y = 10},
        {x = 13, y = 11},
        {x = 14, y = 8},
        {x = 14, y = 9},
        {x = 14, y = 10},
        {x = 14, y = 11},
        {x = 15, y = 8},
        {x = 15, y = 9},
        {x = 15, y = 10},
        {x = 15, y = 11},
        {x = 16, y = 8},
        {x = 16, y = 9},
        {x = 16, y = 10},
        {x = 16, y = 11}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [333] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 2, y = 21},
        {x = 3, y = 21},
        {x = 4, y = 21}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [334] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 2, y = 14},
        {x = 3, y = 14},
        {x = 4, y = 14},
        {x = 5, y = 14}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [335] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 27, y = 18},
        {x = 27, y = 19},
        {x = 28, y = 18},
        {x = 28, y = 19},
        {x = 29, y = 18},
        {x = 29, y = 19},
        {x = 30, y = 18},
        {x = 30, y = 19},
        {x = 31, y = 18},
        {x = 31, y = 19}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [336] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 1123, "Fail", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [337] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 9, y = 6},
        {x = 9, y = 7},
        {x = 10, y = 6},
        {x = 10, y = 7},
        {x = 11, y = 6},
        {x = 11, y = 7},
        {x = 12, y = 6},
        {x = 12, y = 7},
        {x = 13, y = 6},
        {x = 13, y = 7},
        {x = 14, y = 6},
        {x = 14, y = 7}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [338] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 14, y = 10},
        {x = 14, y = 11},
        {x = 14, y = 12},
        {x = 15, y = 10},
        {x = 15, y = 11},
        {x = 15, y = 12}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [339] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 16, y = 9},
        {x = 16, y = 10},
        {x = 17, y = 9},
        {x = 17, y = 10},
        {x = 18, y = 9},
        {x = 18, y = 10},
        {x = 19, y = 9},
        {x = 19, y = 10},
        {x = 20, y = 9},
        {x = 20, y = 10},
        {x = 21, y = 9},
        {x = 21, y = 10}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [340] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 8, y = 4},
        {x = 8, y = 5},
        {x = 8, y = 6},
        {x = 8, y = 7},
        {x = 8, y = 8},
        {x = 9, y = 4},
        {x = 9, y = 5},
        {x = 9, y = 6},
        {x = 9, y = 7},
        {x = 9, y = 8}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [341] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 12, y = 19},
        {x = 12, y = 20},
        {x = 13, y = 19},
        {x = 13, y = 20},
        {x = 14, y = 19},
        {x = 14, y = 20}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [342] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 10, y = 18},
        {x = 10, y = 19},
        {x = 11, y = 18},
        {x = 11, y = 19},
        {x = 12, y = 18},
        {x = 12, y = 19},
        {x = 13, y = 18},
        {x = 13, y = 19},
        {x = 14, y = 18},
        {x = 14, y = 19},
        {x = 15, y = 18},
        {x = 15, y = 19},
        {x = 16, y = 18},
        {x = 16, y = 19},
        {x = 17, y = 18},
        {x = 17, y = 19},
        {x = 18, y = 18},
        {x = 18, y = 19},
        {x = 19, y = 18},
        {x = 19, y = 19}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [343] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 4, y = 28},
        {x = 5, y = 28},
        {x = 6, y = 28},
        {x = 7, y = 28},
        {x = 8, y = 28},
        {x = 9, y = 28},
        {x = 10, y = 28},
        {x = 11, y = 28},
        {x = 12, y = 28}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [344] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 4, y = 28},
        {x = 5, y = 28},
        {x = 6, y = 28},
        {x = 7, y = 28},
        {x = 8, y = 28},
        {x = 9, y = 28},
        {x = 10, y = 28},
        {x = 11, y = 28},
        {x = 12, y = 28}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [345] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 16, y = 13},
        {x = 17, y = 13},
        {x = 18, y = 13},
        {x = 19, y = 13},
        {x = 20, y = 13}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [346] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {}, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [347] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 14, y = 11},
        {x = 15, y = 11},
        {x = 16, y = 11},
        {x = 17, y = 11},
        {x = 18, y = 11},
        {x = 19, y = 11}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [348] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 14, y = 10},
        {x = 15, y = 10},
        {x = 16, y = 10},
        {x = 17, y = 10},
        {x = 18, y = 10},
        {x = 19, y = 10}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [349] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 7, y = 19},
        {x = 7, y = 20},
        {x = 8, y = 19},
        {x = 8, y = 20},
        {x = 9, y = 19},
        {x = 9, y = 20},
        {x = 10, y = 19},
        {x = 10, y = 20},
        {x = 11, y = 19},
        {x = 11, y = 20}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [350] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 15, y = 26},
        {x = 16, y = 26},
        {x = 17, y = 26},
        {x = 18, y = 26},
        {x = 19, y = 26},
        {x = 20, y = 26},
        {x = 21, y = 26}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [351] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 14, y = 14},
        {x = 15, y = 14},
        {x = 16, y = 14},
        {x = 17, y = 14},
        {x = 18, y = 14},
        {x = 19, y = 14},
        {x = 20, y = 14},
        {x = 21, y = 14}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [352] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 14, y = 13},
        {x = 14, y = 14},
        {x = 15, y = 13},
        {x = 15, y = 14},
        {x = 16, y = 13},
        {x = 16, y = 14},
        {x = 17, y = 13},
        {x = 17, y = 14},
        {x = 18, y = 13},
        {x = 18, y = 14},
        {x = 19, y = 13},
        {x = 19, y = 14}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [353] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 9, y = 29},
        {x = 10, y = 29},
        {x = 11, y = 29},
        {x = 12, y = 29}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [354] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 17, y = 11},
        {x = 18, y = 11},
        {x = 19, y = 11},
        {x = 20, y = 11},
        {x = 21, y = 11},
        {x = 22, y = 11}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [355] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 11, y = 11},
        {x = 12, y = 11},
        {x = 13, y = 11},
        {x = 14, y = 11},
        {x = 15, y = 11}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [356] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 21, y = 42}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [357] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {}, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [358] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 18, y = 16},
        {x = 18, y = 17},
        {x = 19, y = 16},
        {x = 19, y = 17},
        {x = 20, y = 16},
        {x = 20, y = 17},
        {x = 21, y = 16},
        {x = 21, y = 17},
        {x = 22, y = 16},
        {x = 22, y = 17},
        {x = 23, y = 16},
        {x = 23, y = 17},
        {x = 24, y = 16},
        {x = 24, y = 17}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [359] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 13, y = 14},
        {x = 14, y = 14},
        {x = 15, y = 14},
        {x = 16, y = 14},
        {x = 17, y = 14},
        {x = 18, y = 14},
        {x = 19, y = 14},
        {x = 20, y = 14}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [360] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 19, y = 8},
        {x = 20, y = 8},
        {x = 21, y = 8},
        {x = 22, y = 8},
        {x = 23, y = 8},
        {x = 24, y = 8}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [361] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {}, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [362] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 13, y = 27},
        {x = 14, y = 27},
        {x = 15, y = 27},
        {x = 16, y = 27},
        {x = 17, y = 27},
        {x = 18, y = 27},
        {x = 19, y = 27},
        {x = 20, y = 27}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [363] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {}, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [364] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 32, y = 6},
        {x = 32, y = 7},
        {x = 32, y = 8},
        {x = 32, y = 9},
        {x = 32, y = 10},
        {x = 32, y = 11}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [365] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 25, y = 6},
        {x = 25, y = 7},
        {x = 25, y = 8},
        {x = 25, y = 9},
        {x = 25, y = 10},
        {x = 25, y = 11},
        {x = 26, y = 6},
        {x = 26, y = 7},
        {x = 26, y = 8},
        {x = 26, y = 9},
        {x = 26, y = 10},
        {x = 26, y = 11}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [366] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 13, y = 8},
        {x = 13, y = 9},
        {x = 13, y = 10},
        {x = 13, y = 11},
        {x = 13, y = 12},
        {x = 13, y = 13},
        {x = 13, y = 14}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [367] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 15, y = 6},
        {x = 15, y = 7},
        {x = 15, y = 8},
        {x = 15, y = 9},
        {x = 15, y = 10},
        {x = 15, y = 11},
        {x = 15, y = 12},
        {x = 15, y = 13}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [368] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 12, y = 26},
        {x = 13, y = 26},
        {x = 14, y = 26},
        {x = 15, y = 26},
        {x = 16, y = 26},
        {x = 17, y = 26}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [369] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 11, y = 17},
        {x = 11, y = 18},
        {x = 12, y = 17},
        {x = 12, y = 18},
        {x = 13, y = 17},
        {x = 13, y = 18},
        {x = 14, y = 17},
        {x = 14, y = 18},
        {x = 15, y = 17},
        {x = 15, y = 18},
        {x = 16, y = 17},
        {x = 16, y = 18}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [370] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 13, y = 18},
        {x = 14, y = 18},
        {x = 15, y = 18},
        {x = 16, y = 18},
        {x = 17, y = 18},
        {x = 18, y = 18}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [371] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 4, y = 23},
        {x = 5, y = 23},
        {x = 6, y = 23},
        {x = 7, y = 23},
        {x = 8, y = 23},
        {x = 9, y = 23},
        {x = 10, y = 23}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [372] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 18, y = 11},
        {x = 18, y = 12},
        {x = 18, y = 13},
        {x = 18, y = 14},
        {x = 18, y = 15},
        {x = 18, y = 16},
        {x = 18, y = 17},
        {x = 19, y = 11},
        {x = 19, y = 12},
        {x = 19, y = 13},
        {x = 19, y = 14},
        {x = 19, y = 15},
        {x = 19, y = 16},
        {x = 19, y = 17}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [373] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 12, y = 28},
        {x = 12, y = 29},
        {x = 12, y = 30},
        {x = 12, y = 31}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [374] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 22, y = 12},
        {x = 23, y = 12},
        {x = 24, y = 12},
        {x = 25, y = 12},
        {x = 26, y = 12},
        {x = 27, y = 12}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [375] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 21, y = 11},
        {x = 22, y = 11},
        {x = 23, y = 11},
        {x = 24, y = 11},
        {x = 25, y = 11},
        {x = 26, y = 11},
        {x = 27, y = 11},
        {x = 28, y = 11}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [376] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 11, y = 32},
        {x = 11, y = 33},
        {x = 12, y = 32},
        {x = 12, y = 33},
        {x = 13, y = 32},
        {x = 13, y = 33}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [377] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 21, y = 16},
        {x = 21, y = 17},
        {x = 21, y = 18},
        {x = 21, y = 19},
        {x = 21, y = 20},
        {x = 21, y = 21}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [378] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 12, y = 10},
        {x = 13, y = 10},
        {x = 14, y = 10}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [379] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 23, y = 13},
        {x = 23, y = 14},
        {x = 23, y = 15},
        {x = 23, y = 16},
        {x = 23, y = 17},
        {x = 23, y = 18},
        {x = 23, y = 19},
        {x = 24, y = 13},
        {x = 24, y = 14},
        {x = 24, y = 15},
        {x = 24, y = 16},
        {x = 24, y = 17},
        {x = 24, y = 18},
        {x = 24, y = 19}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [380] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 13, y = 34},
        {x = 14, y = 34},
        {x = 15, y = 34},
        {x = 16, y = 34},
        {x = 17, y = 34},
        {x = 18, y = 34},
        {x = 19, y = 34},
        {x = 20, y = 34}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [381] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 13, y = 33},
        {x = 14, y = 33},
        {x = 15, y = 33},
        {x = 16, y = 33},
        {x = 17, y = 33},
        {x = 18, y = 33}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [382] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 22, y = 14},
        {x = 22, y = 15},
        {x = 22, y = 16},
        {x = 22, y = 17},
        {x = 22, y = 18},
        {x = 22, y = 19}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [383] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 18, y = 22},
        {x = 18, y = 23},
        {x = 18, y = 24},
        {x = 18, y = 25}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [384] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 17, y = 13},
        {x = 18, y = 13},
        {x = 19, y = 13},
        {x = 20, y = 13},
        {x = 21, y = 13}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [385] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 3, y = 15}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [386] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 7, y = 10},
        {x = 7, y = 11},
        {x = 7, y = 12},
        {x = 8, y = 10},
        {x = 8, y = 11},
        {x = 8, y = 12}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [387] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 12, y = 6},
        {x = 13, y = 6},
        {x = 14, y = 6},
        {x = 15, y = 6}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [388] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 13, y = 13},
        {x = 14, y = 13},
        {x = 15, y = 13},
        {x = 16, y = 13},
        {x = 17, y = 13},
        {x = 18, y = 13},
        {x = 19, y = 13},
        {x = 20, y = 13}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [389] = function(eventid)
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
  [390] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 7, y = 13},
        {x = 7, y = 14},
        {x = 8, y = 13},
        {x = 8, y = 14},
        {x = 9, y = 13},
        {x = 9, y = 14},
        {x = 10, y = 13},
        {x = 10, y = 14},
        {x = 11, y = 13},
        {x = 11, y = 14},
        {x = 12, y = 13},
        {x = 12, y = 14}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [391] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 7, y = 13},
        {x = 7, y = 14},
        {x = 8, y = 13},
        {x = 8, y = 14},
        {x = 9, y = 13},
        {x = 9, y = 14},
        {x = 10, y = 13},
        {x = 10, y = 14},
        {x = 11, y = 13},
        {x = 11, y = 14},
        {x = 12, y = 13},
        {x = 12, y = 14}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [392] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 7, y = 34}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [393] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 4, y = 6}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [394] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 7002, "Success", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [395] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 7003, "Success", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [396] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 3, y = 7}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [397] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 7004, "Success", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [398] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 12, y = 2},
        {x = 12, y = 3},
        {x = 12, y = 4},
        {x = 12, y = 5}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [399] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 8, y = 14}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [400] = function(eventid)
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
  [401] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 4, y = 6}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [402] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 7007, "Success", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [403] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 7008, "Success", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [404] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 3, y = 19}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [405] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 5, y = 17},
        {x = 6, y = 17},
        {x = 7, y = 17}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [406] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("battleend", eventid, 7012, "Success", "AfterReturn")
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [407] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 12, y = 1},
        {x = 12, y = 2},
        {x = 12, y = 3},
        {x = 12, y = 4},
        {x = 12, y = 5},
        {x = 12, y = 6},
        {x = 13, y = 1},
        {x = 13, y = 2},
        {x = 13, y = 3},
        {x = 13, y = 4},
        {x = 13, y = 5},
        {x = 13, y = 6}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [408] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 12, y = 5}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [409] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 12, y = 2}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [410] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 9, y = 9},
        {x = 10, y = 9}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [411] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 13, y = 3},
        {x = 13, y = 4},
        {x = 13, y = 5},
        {x = 13, y = 6},
        {x = 13, y = 7}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [412] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 7, y = 3},
        {x = 7, y = 4},
        {x = 7, y = 5},
        {x = 7, y = 6},
        {x = 7, y = 7}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [413] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 13, y = 10},
        {x = 14, y = 10},
        {x = 15, y = 10}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [414] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 9, y = 2},
        {x = 9, y = 3},
        {x = 9, y = 4},
        {x = 9, y = 5}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [415] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 13, y = 10},
        {x = 14, y = 10},
        {x = 15, y = 10}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [416] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 13, y = 9},
        {x = 14, y = 9},
        {x = 15, y = 9},
        {x = 16, y = 9}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [417] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 13, y = 9},
        {x = 14, y = 9},
        {x = 15, y = 9},
        {x = 16, y = 9}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [418] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 17, y = 14},
        {x = 17, y = 15},
        {x = 17, y = 16},
        {x = 17, y = 17},
        {x = 18, y = 14},
        {x = 18, y = 15},
        {x = 18, y = 16},
        {x = 18, y = 17},
        {x = 19, y = 14},
        {x = 19, y = 15},
        {x = 19, y = 16},
        {x = 19, y = 17},
        {x = 20, y = 14},
        {x = 20, y = 15},
        {x = 20, y = 16},
        {x = 20, y = 17}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [419] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 4, y = 19},
        {x = 4, y = 20},
        {x = 4, y = 21},
        {x = 4, y = 22},
        {x = 5, y = 19},
        {x = 5, y = 20},
        {x = 5, y = 21},
        {x = 5, y = 22},
        {x = 6, y = 19},
        {x = 6, y = 20},
        {x = 6, y = 21},
        {x = 6, y = 22},
        {x = 7, y = 19},
        {x = 7, y = 20},
        {x = 7, y = 21},
        {x = 7, y = 22}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [420] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 4, y = 17},
        {x = 4, y = 18},
        {x = 4, y = 19},
        {x = 4, y = 20},
        {x = 5, y = 17},
        {x = 5, y = 18},
        {x = 5, y = 19},
        {x = 5, y = 20},
        {x = 6, y = 17},
        {x = 6, y = 18},
        {x = 6, y = 19},
        {x = 6, y = 20},
        {x = 7, y = 17},
        {x = 7, y = 18},
        {x = 7, y = 19},
        {x = 7, y = 20}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [421] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 15, y = 6},
        {x = 15, y = 7},
        {x = 15, y = 8},
        {x = 15, y = 9},
        {x = 16, y = 6},
        {x = 16, y = 7},
        {x = 16, y = 8},
        {x = 16, y = 9},
        {x = 17, y = 6},
        {x = 17, y = 7},
        {x = 17, y = 8},
        {x = 17, y = 9},
        {x = 18, y = 6},
        {x = 18, y = 7},
        {x = 18, y = 8},
        {x = 18, y = 9}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [422] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 8, y = 7},
        {x = 8, y = 8},
        {x = 8, y = 9},
        {x = 8, y = 10},
        {x = 9, y = 7},
        {x = 9, y = 8},
        {x = 9, y = 9},
        {x = 9, y = 10},
        {x = 10, y = 7},
        {x = 10, y = 8},
        {x = 10, y = 9},
        {x = 10, y = 10},
        {x = 11, y = 7},
        {x = 11, y = 8},
        {x = 11, y = 9},
        {x = 11, y = 10}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [423] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 19, y = 15},
        {x = 19, y = 16},
        {x = 19, y = 17},
        {x = 19, y = 18},
        {x = 20, y = 15},
        {x = 20, y = 16},
        {x = 20, y = 17},
        {x = 20, y = 18},
        {x = 21, y = 15},
        {x = 21, y = 16},
        {x = 21, y = 17},
        {x = 21, y = 18},
        {x = 22, y = 15},
        {x = 22, y = 16},
        {x = 22, y = 17},
        {x = 22, y = 18}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [424] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 10, y = 8},
        {x = 11, y = 8},
        {x = 12, y = 8},
        {x = 13, y = 8}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [425] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 15, y = 6},
        {x = 16, y = 6},
        {x = 17, y = 6},
        {x = 18, y = 6},
        {x = 19, y = 6}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [426] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 3, y = 16}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [427] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 15, y = 22},
        {x = 16, y = 22},
        {x = 17, y = 22},
        {x = 18, y = 22},
        {x = 19, y = 22},
        {x = 20, y = 22}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [428] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 16, y = 20},
        {x = 16, y = 21},
        {x = 16, y = 22},
        {x = 16, y = 23}
      }, true)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [429] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 16, y = 46},
        {x = 17, y = 46},
        {x = 18, y = 46},
        {x = 19, y = 46}
      }, true)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("battleend", eventid, 1186, "Either", "AfterReturn")
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [430] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 7, y = 14},
      {x = 8, y = 14},
      {x = 9, y = 14},
      {x = 10, y = 14},
      {x = 11, y = 14}
    }, true)
  end,
  [431] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 3, y = 12},
      {x = 4, y = 12}
    }, true)
  end,
  [432] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 2, y = 22},
      {x = 3, y = 22},
      {x = 4, y = 22},
      {x = 5, y = 22}
    }, true)
  end,
  [433] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 16, y = 8},
      {x = 16, y = 9},
      {x = 16, y = 10},
      {x = 16, y = 11}
    }, true)
  end,
  [434] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 2, y = 22},
      {x = 3, y = 22},
      {x = 4, y = 22},
      {x = 5, y = 22}
    }, true)
  end,
  [435] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 8, y = 6},
      {x = 8, y = 7},
      {x = 8, y = 8}
    }, true)
  end,
  [436] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 19, y = 11},
      {x = 20, y = 11},
      {x = 21, y = 11}
    }, true)
  end,
  [437] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 13, y = 19},
      {x = 13, y = 20},
      {x = 13, y = 21},
      {x = 13, y = 22},
      {x = 13, y = 23},
      {x = 13, y = 24}
    }, true)
  end,
  [438] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 10, y = 30},
      {x = 10, y = 31},
      {x = 10, y = 32},
      {x = 10, y = 33}
    }, true)
  end,
  [439] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 9, y = 18},
      {x = 9, y = 19},
      {x = 10, y = 18},
      {x = 10, y = 19},
      {x = 11, y = 18},
      {x = 11, y = 19}
    }, true)
  end,
  [440] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 4, y = 21},
      {x = 4, y = 22},
      {x = 5, y = 21},
      {x = 5, y = 22},
      {x = 6, y = 21},
      {x = 6, y = 22}
    }, true)
  end,
  [441] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 23, y = 5},
      {x = 23, y = 6},
      {x = 23, y = 7},
      {x = 23, y = 8},
      {x = 24, y = 5},
      {x = 24, y = 6},
      {x = 24, y = 7},
      {x = 24, y = 8}
    }, true)
  end,
  [442] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 2, y = 21},
      {x = 3, y = 21},
      {x = 4, y = 21},
      {x = 5, y = 21},
      {x = 6, y = 21}
    }, true)
  end,
  [443] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 11, y = 23},
      {x = 11, y = 24},
      {x = 11, y = 25},
      {x = 11, y = 26},
      {x = 12, y = 23},
      {x = 12, y = 24},
      {x = 12, y = 25},
      {x = 12, y = 26}
    }, true)
  end,
  [444] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 24, y = 19},
      {x = 24, y = 20},
      {x = 24, y = 21},
      {x = 24, y = 22},
      {x = 24, y = 23},
      {x = 24, y = 24}
    }, true)
  end,
  [445] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 14, y = 21},
      {x = 14, y = 22},
      {x = 15, y = 21},
      {x = 15, y = 22},
      {x = 16, y = 21},
      {x = 16, y = 22},
      {x = 17, y = 21},
      {x = 17, y = 22},
      {x = 18, y = 21},
      {x = 18, y = 22},
      {x = 19, y = 21},
      {x = 19, y = 22},
      {x = 20, y = 21},
      {x = 20, y = 22},
      {x = 21, y = 21},
      {x = 21, y = 22}
    }, true)
  end,
  [446] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 13, y = 23},
      {x = 13, y = 24},
      {x = 13, y = 25},
      {x = 14, y = 23},
      {x = 14, y = 24},
      {x = 14, y = 25},
      {x = 15, y = 23},
      {x = 15, y = 24},
      {x = 15, y = 25},
      {x = 16, y = 23},
      {x = 16, y = 24},
      {x = 16, y = 25},
      {x = 17, y = 23},
      {x = 17, y = 24},
      {x = 17, y = 25}
    }, true)
  end,
  [447] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 19, y = 26},
      {x = 20, y = 26},
      {x = 21, y = 26},
      {x = 22, y = 26}
    }, true)
  end,
  [448] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 10, y = 16},
      {x = 11, y = 16},
      {x = 12, y = 16},
      {x = 13, y = 16},
      {x = 14, y = 16}
    }, true)
  end,
  [449] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 13, y = 11},
      {x = 13, y = 12},
      {x = 14, y = 11},
      {x = 14, y = 12},
      {x = 15, y = 11},
      {x = 15, y = 12},
      {x = 16, y = 11},
      {x = 16, y = 12},
      {x = 17, y = 11},
      {x = 17, y = 12},
      {x = 18, y = 11},
      {x = 18, y = 12}
    }, true)
  end,
  [450] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 8, y = 39},
      {x = 8, y = 40},
      {x = 8, y = 41},
      {x = 8, y = 42},
      {x = 9, y = 39},
      {x = 9, y = 40},
      {x = 9, y = 41},
      {x = 9, y = 42}
    }, true)
  end,
  [451] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 20, y = 46},
      {x = 21, y = 46},
      {x = 22, y = 46},
      {x = 23, y = 46},
      {x = 24, y = 46}
    }, true)
  end,
  [452] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1120, "Success", "Instant")
  end,
  [453] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1126, "Success", "AfterReturn")
  end,
  [454] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 13, y = 11},
      {x = 13, y = 12},
      {x = 14, y = 11},
      {x = 14, y = 12}
    }, true)
  end,
  [455] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 27, y = 6},
      {x = 28, y = 6}
    }, true)
  end,
  [456] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 11, y = 23},
      {x = 12, y = 23},
      {x = 13, y = 23},
      {x = 14, y = 23}
    }, true)
  end,
  [457] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 15, y = 7},
      {x = 15, y = 8},
      {x = 16, y = 7},
      {x = 16, y = 8},
      {x = 17, y = 7},
      {x = 17, y = 8}
    }, true)
  end,
  [458] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 5, y = 4},
      {x = 6, y = 4},
      {x = 7, y = 4},
      {x = 8, y = 4}
    }, true)
  end,
  [459] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 14, y = 4},
      {x = 15, y = 4},
      {x = 16, y = 4}
    }, true)
  end,
  [460] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 2, y = 8},
      {x = 2, y = 9},
      {x = 3, y = 8},
      {x = 3, y = 9},
      {x = 4, y = 8},
      {x = 4, y = 9},
      {x = 5, y = 8},
      {x = 5, y = 9},
      {x = 6, y = 8},
      {x = 6, y = 9}
    }, true)
  end,
  [461] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 7018, "Success", "AfterReturn")
  end,
  [462] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 11, y = 5},
      {x = 11, y = 6},
      {x = 12, y = 5},
      {x = 12, y = 6},
      {x = 13, y = 5},
      {x = 13, y = 6},
      {x = 14, y = 5},
      {x = 14, y = 6},
      {x = 15, y = 5},
      {x = 15, y = 6}
    }, true)
  end,
  [463] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 7023, "Success", "AfterReturn")
  end,
  [464] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 4, y = 10},
      {x = 4, y = 11},
      {x = 5, y = 10},
      {x = 5, y = 11},
      {x = 6, y = 10},
      {x = 6, y = 11},
      {x = 7, y = 10},
      {x = 7, y = 11},
      {x = 8, y = 10},
      {x = 8, y = 11},
      {x = 9, y = 10},
      {x = 9, y = 11},
      {x = 10, y = 10},
      {x = 10, y = 11},
      {x = 11, y = 10},
      {x = 11, y = 11},
      {x = 12, y = 10},
      {x = 12, y = 11},
      {x = 13, y = 10},
      {x = 13, y = 11}
    }, true)
  end,
  [465] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 7026, "Success", "AfterReturn")
  end,
  [466] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 6, y = 22},
      {x = 6, y = 23},
      {x = 7, y = 22},
      {x = 7, y = 23},
      {x = 8, y = 22},
      {x = 8, y = 23},
      {x = 9, y = 22},
      {x = 9, y = 23}
    }, true)
  end,
  [467] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 4, y = 16},
      {x = 4, y = 17},
      {x = 5, y = 16},
      {x = 5, y = 17},
      {x = 6, y = 16},
      {x = 6, y = 17}
    }, true)
  end,
  [468] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 9, y = 20},
      {x = 9, y = 21},
      {x = 10, y = 20},
      {x = 10, y = 21},
      {x = 11, y = 20},
      {x = 11, y = 21},
      {x = 12, y = 20},
      {x = 12, y = 21}
    }, true)
  end,
  [469] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 12, y = 21},
      {x = 12, y = 22},
      {x = 13, y = 21},
      {x = 13, y = 22},
      {x = 14, y = 21},
      {x = 14, y = 22}
    }, true)
  end,
  [470] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 23, y = 24},
      {x = 23, y = 25},
      {x = 24, y = 24},
      {x = 24, y = 25},
      {x = 25, y = 24},
      {x = 25, y = 25},
      {x = 26, y = 24},
      {x = 26, y = 25}
    }, true)
  end,
  [471] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 11, y = 27},
      {x = 11, y = 28},
      {x = 12, y = 27},
      {x = 12, y = 28},
      {x = 13, y = 27},
      {x = 13, y = 28},
      {x = 14, y = 27},
      {x = 14, y = 28},
      {x = 15, y = 27},
      {x = 15, y = 28}
    }, true)
  end,
  [472] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 7, y = 11},
      {x = 7, y = 12},
      {x = 8, y = 11},
      {x = 8, y = 12},
      {x = 9, y = 11},
      {x = 9, y = 12},
      {x = 10, y = 11},
      {x = 10, y = 12}
    }, true)
  end,
  [473] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 7, y = 19},
      {x = 7, y = 20},
      {x = 8, y = 19},
      {x = 8, y = 20},
      {x = 9, y = 19},
      {x = 9, y = 20},
      {x = 10, y = 19},
      {x = 10, y = 20},
      {x = 11, y = 19},
      {x = 11, y = 20},
      {x = 12, y = 19},
      {x = 12, y = 20}
    }, true)
  end,
  [474] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 15, y = 17},
      {x = 15, y = 18},
      {x = 16, y = 17},
      {x = 16, y = 18},
      {x = 17, y = 17},
      {x = 17, y = 18},
      {x = 18, y = 17},
      {x = 18, y = 18}
    }, true)
  end,
  [476] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 8, y = 36},
      {x = 8, y = 37},
      {x = 9, y = 36},
      {x = 9, y = 37},
      {x = 10, y = 36},
      {x = 10, y = 37}
    }, true)
  end,
  [477] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = Or.Create()
      local trigger0 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 7, y = 28},
        {x = 8, y = 28},
        {x = 9, y = 28},
        {x = 10, y = 28},
        {x = 11, y = 28}
      }, true)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("gridpos", eventid, {
        {x = 11, y = 24},
        {x = 11, y = 25},
        {x = 11, y = 26},
        {x = 11, y = 27},
        {x = 11, y = 28}
      }, true)
      root:AddTask(trigger1)
      upper:AddTask(root)
    end
    return root
  end,
  [478] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 8, y = 17},
      {x = 8, y = 18},
      {x = 8, y = 19},
      {x = 9, y = 17},
      {x = 9, y = 18},
      {x = 9, y = 19},
      {x = 10, y = 17},
      {x = 10, y = 18},
      {x = 10, y = 19}
    }, true)
  end,
  [479] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 15, y = 9},
      {x = 15, y = 10},
      {x = 15, y = 11},
      {x = 15, y = 12},
      {x = 15, y = 13}
    }, true)
  end,
  [481] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 3, y = 9},
      {x = 3, y = 10},
      {x = 4, y = 9},
      {x = 4, y = 10},
      {x = 5, y = 9},
      {x = 5, y = 10},
      {x = 6, y = 9},
      {x = 6, y = 10}
    }, true)
  end,
  [482] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 17, y = 4},
      {x = 17, y = 5},
      {x = 17, y = 6},
      {x = 17, y = 7},
      {x = 17, y = 8},
      {x = 18, y = 4},
      {x = 18, y = 5},
      {x = 18, y = 6},
      {x = 18, y = 7},
      {x = 18, y = 8}
    }, true)
  end,
  [483] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 10, y = 14},
      {x = 10, y = 15},
      {x = 10, y = 16},
      {x = 10, y = 17},
      {x = 11, y = 14},
      {x = 11, y = 15},
      {x = 11, y = 16},
      {x = 11, y = 17}
    }, true)
  end,
  [484] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 15, y = 8},
      {x = 15, y = 9},
      {x = 16, y = 8},
      {x = 16, y = 9},
      {x = 17, y = 8},
      {x = 17, y = 9}
    }, true)
  end,
  [485] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 4, y = 24},
      {x = 4, y = 25},
      {x = 5, y = 24},
      {x = 5, y = 25},
      {x = 6, y = 24},
      {x = 6, y = 25},
      {x = 7, y = 24},
      {x = 7, y = 25},
      {x = 8, y = 24},
      {x = 8, y = 25}
    }, true)
  end,
  [486] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 11, y = 11},
      {x = 11, y = 12},
      {x = 12, y = 11},
      {x = 12, y = 12},
      {x = 13, y = 11},
      {x = 13, y = 12},
      {x = 14, y = 11},
      {x = 14, y = 12},
      {x = 15, y = 11},
      {x = 15, y = 12}
    }, true)
  end,
  [487] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 10, y = 19},
      {x = 10, y = 20},
      {x = 11, y = 19},
      {x = 11, y = 20},
      {x = 12, y = 19},
      {x = 12, y = 20},
      {x = 13, y = 19},
      {x = 13, y = 20},
      {x = 14, y = 19},
      {x = 14, y = 20}
    }, true)
  end,
  [488] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 19, y = 18},
      {x = 19, y = 19},
      {x = 20, y = 18},
      {x = 20, y = 19},
      {x = 21, y = 18},
      {x = 21, y = 19},
      {x = 22, y = 18},
      {x = 22, y = 19},
      {x = 23, y = 18},
      {x = 23, y = 19}
    }, true)
  end,
  [489] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 14, y = 9},
      {x = 14, y = 10},
      {x = 15, y = 9},
      {x = 15, y = 10}
    }, true)
  end,
  [490] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 8, y = 10},
      {x = 8, y = 11},
      {x = 8, y = 12},
      {x = 8, y = 13},
      {x = 8, y = 14},
      {x = 9, y = 10},
      {x = 9, y = 11},
      {x = 9, y = 12},
      {x = 9, y = 13},
      {x = 9, y = 14}
    }, true)
  end,
  [491] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 6, y = 15},
      {x = 6, y = 16},
      {x = 6, y = 17},
      {x = 7, y = 15},
      {x = 7, y = 16},
      {x = 7, y = 17},
      {x = 8, y = 15},
      {x = 8, y = 16},
      {x = 8, y = 17}
    }, true)
  end,
  [492] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 14, y = 27},
      {x = 14, y = 28},
      {x = 15, y = 27},
      {x = 15, y = 28},
      {x = 16, y = 27},
      {x = 16, y = 28}
    }, true)
  end,
  [493] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 13, y = 11},
      {x = 13, y = 12},
      {x = 14, y = 11},
      {x = 14, y = 12},
      {x = 15, y = 11},
      {x = 15, y = 12},
      {x = 16, y = 11},
      {x = 16, y = 12},
      {x = 17, y = 11},
      {x = 17, y = 12}
    }, true)
  end,
  [494] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 3, y = 24},
      {x = 3, y = 25},
      {x = 4, y = 24},
      {x = 4, y = 25},
      {x = 5, y = 24},
      {x = 5, y = 25},
      {x = 6, y = 24},
      {x = 6, y = 25},
      {x = 7, y = 24},
      {x = 7, y = 25}
    }, true)
  end,
  [495] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 19, y = 11},
      {x = 19, y = 12},
      {x = 20, y = 11},
      {x = 20, y = 12},
      {x = 21, y = 11},
      {x = 21, y = 12}
    }, true)
  end,
  [496] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 11, y = 19},
      {x = 12, y = 19},
      {x = 13, y = 19},
      {x = 14, y = 19},
      {x = 15, y = 19}
    }, true)
  end,
  [497] = function(eventid)
    return TriggerManager.CreateTrigger("gridpos", eventid, {
      {x = 18, y = 14},
      {x = 19, y = 14}
    }, true)
  end
}
return triggers
