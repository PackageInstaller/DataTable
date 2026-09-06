local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local triggers = {
  [1] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "monster", "total", 50)
  end,
  [2] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "monster", "total", 500)
  end,
  [3] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "monster", "total", 2000)
  end,
  [4] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "openBox", "", 1)
  end,
  [5] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "openBox", "", 100)
  end,
  [6] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "openBox", "", 500)
  end,
  [7] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "openTree", "", 1)
  end,
  [8] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "openTree", "", 50)
  end,
  [9] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "openTree", "", 250)
  end,
  [10] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "globalBattleWin", "", 100)
  end,
  [11] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "globalBattleWin", "", 500)
  end,
  [12] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "globalBattleWin", "", 1000)
  end,
  [13] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "35002", 100000)
  end,
  [14] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "35002", 5000000)
  end,
  [15] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "35002", 50000000)
  end,
  [16] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "dungeon", "", 1)
  end,
  [17] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "dungeon", "", 50)
  end,
  [18] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "dungeon", "", 100)
  end,
  [19] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1187, "Success", "AfterReturn")
  end,
  [20] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1127, "Success", "AfterReturn")
  end,
  [21] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1134, "Success", "AfterReturn")
  end,
  [22] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1189, "Success", "AfterReturn")
  end,
  [23] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1294, "Success", "AfterReturn")
  end,
  [24] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1295, "Success", "AfterReturn")
  end,
  [25] = function(eventid)
    return TriggerManager.CreateTrigger("battleend", eventid, 1356, "Success", "AfterReturn")
  end,
  [26] = function(eventid)
    return
  end,
  [27] = function(eventid)
    return
  end,
  [28] = function(eventid)
    return
  end,
  [29] = function(eventid)
    return
  end,
  [30] = function(eventid)
    return
  end,
  [31] = function(eventid)
    return
  end,
  [32] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "equipstrengthen", "total", 1)
  end,
  [33] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "friend", "", 1)
  end,
  [34] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "friend", "", 10)
  end,
  [35] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "friend", "", 100)
  end,
  [36] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = Or.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "card", "0", 1)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [37] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = Or.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "realm", "1", 1)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("counter", eventid, "realm", "2", 1)
      root:AddTask(trigger1)
      local trigger2 = TriggerManager.CreateTrigger("counter", eventid, "realm", "3", 1)
      root:AddTask(trigger2)
      local trigger3 = TriggerManager.CreateTrigger("counter", eventid, "realm", "4", 1)
      root:AddTask(trigger3)
      upper:AddTask(root)
    end
    return root
  end,
  [38] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "buyitem", "0", 1)
  end,
  [39] = function(eventid)
    return
  end,
  [40] = function(eventid)
    return
  end,
  [41] = function(eventid)
    return
  end,
  [42] = function(eventid)
    return
  end,
  [43] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "cavernExplore", "0", 1)
  end,
  [44] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "buildLevel", "0", 1)
  end,
  [45] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "autoExplore", "0", 1)
  end,
  [46] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "rolequantity", "total", 10)
  end,
  [47] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "rolequantity", "total", 30)
  end,
  [48] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "rolequantity", "total", 50)
  end,
  [49] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "equipNum", "total", 20)
  end,
  [50] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "equipNum", "total", 200)
  end,
  [51] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "equipNum", "total", 500)
  end,
  [52] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "task", "0", 10)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [53] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "task", "0", 100)
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
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "task", "0", 200)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [55] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "cavernExplore", "0", 20)
  end,
  [56] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "cavernExplore", "0", 100)
  end,
  [57] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "autoExplore", "0", 100)
  end,
  [58] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "autoExplore", "0", 500)
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
      upper:AddTask(root)
    end
    return root
  end,
  [62] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "yardBuildLevel", "0", 2)
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
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "yardBuildLevel", "100", 3)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [64] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "yardBuildLevel", "200", 4)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [65] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "yardBuildLevel", "300", 1)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [66] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "yardBuildLevel", "100", 3)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("counter", eventid, "yardBuildLevel", "200", 4)
      root:AddTask(trigger1)
      local trigger2 = TriggerManager.CreateTrigger("counter", eventid, "yardBuildLevel", "300", 1)
      root:AddTask(trigger2)
      local trigger3 = TriggerManager.CreateTrigger("counter", eventid, "yardBuildLevel", "400", 3)
      root:AddTask(trigger3)
      local trigger4 = TriggerManager.CreateTrigger("counter", eventid, "yardBuildLevel", "500", 3)
      root:AddTask(trigger4)
      local trigger5 = TriggerManager.CreateTrigger("counter", eventid, "yardBuildLevel", "600", 3)
      root:AddTask(trigger5)
      local trigger6 = TriggerManager.CreateTrigger("counter", eventid, "yardBuildLevel", "700", 1)
      root:AddTask(trigger6)
      upper:AddTask(root)
    end
    return root
  end,
  [67] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "unlockroom", "total", 3)
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
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "unlockroom", "total", 2)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [69] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "buyitem", "9", 1)
  end,
  [70] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "buyitem", "13", 1)
  end,
  [71] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "equipfumo", "total", 1)
  end,
  [72] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "equipfumo", "total", 100)
  end,
  [73] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "equipfumo", "total", 500)
  end,
  [74] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "equipstrengthen", "total", 1)
  end,
  [75] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "equipstrengthen", "total", 100)
  end,
  [76] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "equipstrengthen", "total", 500)
  end,
  [77] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "stairLevel", "total", 136)
  end,
  [78] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = Or.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "card", "3", 100)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [79] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = Or.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "card", "3", 1000)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [80] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "friendpoint", "", 100)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [81] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "totalsign", "", 3)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [82] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "totaltime", "", 2)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
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
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "bossrush", "", 1)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [85] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "supportrole", "", 5)
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
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "runenum", "", 3)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [87] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "retreatnum", "", 3)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [88] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "rarityrole", "4", 2)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [89] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "alchemy", "", 2)
  end,
  [90] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "evolution", "2", 2)
  end,
  [91] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "roleSkill", "3", 2)
  end,
  [92] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "friendpoint", "", 1000)
  end,
  [93] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "friendpoint", "", 5000)
  end,
  [94] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "card", "3", 30)
  end,
  [95] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "card", "3", 100)
  end,
  [96] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "card", "3", 500)
  end,
  [97] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "card", "3", 1000)
  end,
  [98] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "buyitem", "9", 50)
  end,
  [99] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "buyitem", "9", 100)
  end,
  [100] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "35018", 100)
  end,
  [101] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "35018", 1000)
  end,
  [102] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "item", "35018", 5000)
  end,
  [103] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "yardBuildLevel", "100", 3)
      root:AddTask(trigger0)
      local trigger1 = TriggerManager.CreateTrigger("counter", eventid, "yardBuildLevel", "200", 4)
      root:AddTask(trigger1)
      local trigger2 = TriggerManager.CreateTrigger("counter", eventid, "yardBuildLevel", "300", 2)
      root:AddTask(trigger2)
      local trigger3 = TriggerManager.CreateTrigger("counter", eventid, "yardBuildLevel", "400", 3)
      root:AddTask(trigger3)
      upper:AddTask(root)
    end
    return root
  end,
  [104] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "stairLevel", "total", 236)
  end,
  [105] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "stairLevel", "total", 436)
  end,
  [106] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "friendpoint", "", 200)
  end,
  [107] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "comment", "", 1)
  end,
  [108] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "alchemy", "", 2)
  end,
  [109] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "alchemy", "", 2)
  end,
  [110] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "equipBreak", "2", 2)
  end,
  [111] = function(eventid)
    return
  end,
  [112] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "roleClothes", "6", 2)
  end,
  [113] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "battleAchievement", "1", 10)
  end,
  [114] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "giftBag", "1", 5)
  end,
  [115] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "dreamSpiral", "", 1)
  end,
  [116] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "giftBag", "2", 5)
  end,
  [117] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "dreamDungeon", "", 1)
  end,
  [118] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "battleAchievement", "1", 1)
  end,
  [119] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "evolution", "1", 1)
  end,
  [120] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "evolution", "2", 3)
  end,
  [121] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "roleSkill", "5", 1)
  end,
  [122] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "roleSkill", "5", 3)
  end,
  [123] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "roleClothes", "6", 1)
  end,
  [124] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "roleClothes", "6", 10)
  end,
  [125] = function(eventid)
    return
  end,
  [126] = function(eventid)
    return
  end,
  [127] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "equipBreak", "1", 3)
  end,
  [128] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "equipBreak", "2", 3)
  end,
  [129] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "giftBag", "2", 10)
  end,
  [130] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "dreamSpiral", "", 1)
  end,
  [131] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "dreamSpiral", "", 2)
  end,
  [132] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "alchemy", "", 1)
  end,
  [133] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "alchemy", "", 50)
  end,
  [134] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "alchemy", "", 100)
  end,
  [135] = function(eventid)
    return
  end,
  [136] = function(eventid)
    return
  end,
  [137] = function(eventid)
    return
  end,
  [138] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "outerSpace", "", 2)
  end,
  [139] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "1", 3)
  end,
  [140] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "lockFurnitrue", "", 1)
  end,
  [141] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "lockFurnitrue", "", 5)
  end,
  [142] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "lockFurnitrue", "", 10)
  end,
  [143] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "outerSpace", "", 1)
  end,
  [144] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "outerSpace", "", 5)
  end,
  [145] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "outerSpace", "", 20)
  end,
  [146] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "1", 10)
  end,
  [147] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "1", 100)
  end,
  [148] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "1", 500)
  end,
  [149] = function(eventid)
    return
  end,
  [150] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "evolution", "3", 6)
  end,
  [151] = function(eventid)
    return
  end,
  [152] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "equipBreak", "1", 1)
  end
}
return triggers
