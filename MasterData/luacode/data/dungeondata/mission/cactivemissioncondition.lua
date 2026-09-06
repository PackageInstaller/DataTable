local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local triggers = {
  [1] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "skill2unlock", "", 3)
  end,
  [2] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "skill2unlock", "", 6)
  end,
  [3] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "0", 5)
  end,
  [4] = function(eventid)
    return
  end,
  [5] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "guild", "", 1)
  end,
  [6] = function(eventid)
    return
  end,
  [7] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "boshrush", "1", 4)
  end,
  [8] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "friend", "", 3)
  end,
  [9] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "cavernExploreAward", "0", 4)
  end,
  [10] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "cavernExploreAward", "0", 8)
  end,
  [11] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "EquipRare", "3", 1)
  end,
  [12] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "EquipRare", "3", 3)
  end,
  [13] = function(eventid)
    return
  end,
  [14] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "present", "", 3)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [15] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "present", "", 6)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [16] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "outerSpace", "", 2)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [17] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "supportrole", "", 5)
  end,
  [18] = function(eventid)
    return
  end,
  [19] = function(eventid)
    return
  end,
  [20] = function(eventid)
    return
  end,
  [21] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "finishTask", "90008;90009;90010;90011;90012;90013", 6)
  end,
  [22] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "finishTask", "90014;90015;90016;90017;90018;90019", 6)
  end,
  [23] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "equipBreak", "2", 3)
  end,
  [24] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "equipBreak", "3", 3)
  end,
  [25] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "alchemy", "", 1)
  end,
  [26] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "alchemy", "", 50)
  end,
  [27] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "alchemy", "", 100)
  end,
  [28] = function(eventid)
    return
  end,
  [29] = function(eventid)
    return
  end,
  [30] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "1", 5)
  end,
  [31] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "10105", 3)
  end,
  [32] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "10105", 5)
  end,
  [33] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "1", 20)
  end,
  [34] = function(eventid)
    return
  end,
  [35] = function(eventid)
    return
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
    return
  end,
  [40] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "roleSkill", "3", 2)
  end,
  [41] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "roleSkill", "3", 4)
  end,
  [42] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "roleSkill", "3", 6)
  end,
  [43] = function(eventid)
    return
  end,
  [44] = function(eventid)
    return
  end,
  [45] = function(eventid)
    return
  end,
  [46] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "roleSkill", "4", 2)
  end,
  [47] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "roleSkill", "4", 4)
  end,
  [48] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "roleSkill", "4", 6)
  end,
  [49] = function(eventid)
    return
  end,
  [50] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "finishTask", "90020;90021;90022;90023;90024;90025", 6)
  end,
  [51] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "finishTask", "90026;90027;90028;90029;90030;90031", 6)
  end,
  [52] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "finishTask", "90032;90033;90034;90035;90036;90037", 6)
  end,
  [53] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "finishTask", "90038;90039;90040;90041;90042;90043", 6)
  end,
  [54] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "finishTask", "90044;90045;90046;90047;90048;90049", 6)
  end,
  [55] = function(eventid)
    return
  end,
  [56] = function(eventid)
    return
  end,
  [106] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "finishTask", "90057;90058;90059;90060;90061;90062", 6)
  end,
  [107] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "finishTask", "90063;90064;90065;90066;90067;90068", 6)
  end,
  [108] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "finishTask", "90069;90070;90071;90072;90073;90074", 6)
  end,
  [109] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "finishTask", "90075;90076;90077;90078;90079;90080", 6)
  end,
  [110] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "finishTask", "90081;90082;90083;90084;90085;90086", 6)
  end,
  [111] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "finishTask", "90087;90088;90089;90090;90091;90092", 6)
  end,
  [112] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "finishTask", "90093;90094;90095;90096;90097;90098", 6)
  end,
  [113] = function(eventid)
    return
  end,
  [114] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "monster", "total", 5)
  end,
  [115] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "monster", "total", 10)
  end,
  [116] = function(eventid)
    return
  end,
  [117] = function(eventid)
    return
  end,
  [118] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "skill2unlock", "", 3)
  end,
  [119] = function(eventid)
    return
  end,
  [120] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "0", 5)
  end,
  [121] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "0", 10)
  end,
  [122] = function(eventid)
    return
  end,
  [123] = function(eventid)
    return
  end,
  [124] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "friend", "", 3)
  end,
  [125] = function(eventid)
    return
  end,
  [126] = function(eventid)
    return
  end,
  [127] = function(eventid)
    return
  end,
  [128] = function(eventid)
    return
  end,
  [129] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "guild", "", 1)
  end,
  [130] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "2", 5)
  end,
  [131] = function(eventid)
    return
  end,
  [132] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "skill2unlock", "", 6)
  end,
  [133] = function(eventid)
    return
  end,
  [134] = function(eventid)
    return
  end,
  [135] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "0", 15)
  end,
  [136] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "cavernExploreAward", "0", 6)
  end,
  [137] = function(eventid)
    return
  end,
  [138] = function(eventid)
    return
  end,
  [139] = function(eventid)
    return
  end,
  [140] = function(eventid)
    return
  end,
  [141] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "realm", "0", 15)
  end,
  [142] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "supportrole", "", 3)
  end,
  [143] = function(eventid)
    return
  end,
  [144] = function(eventid)
    return
  end,
  [145] = function(eventid)
    return
  end,
  [146] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "boshrush", "1", 4)
  end,
  [147] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "outerSpace", "", 1)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [148] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "2", 10)
  end,
  [149] = function(eventid)
    return
  end,
  [150] = function(eventid)
    return
  end,
  [151] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "EquipRare", "3", 1)
  end,
  [152] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "boshrush", "1", 7)
  end,
  [153] = function(eventid)
    local root = ComposedTrigger.Create()
    do
      local upper = root
      local root = And.Create()
      local trigger0 = TriggerManager.CreateTrigger("counter", eventid, "outerSpace", "", 2)
      root:AddTask(trigger0)
      upper:AddTask(root)
    end
    return root
  end,
  [154] = function(eventid)
    return TriggerManager.CreateTrigger("counter", eventid, "pvpWin", "2", 15)
  end
}
return triggers
