---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/5/24 16:58
---

local UIReward = {
    Name = UIWindowNames.UIReward,
    Layer = UILayers.InfoLayer,
    Model = require "UI.UIReward.UIRewardModel",
    Ctrl = nil,
    View = require "UI.UIReward.UIRewardView",
    PrefabPath = "UI/Prefabs/View/UI/UIReward_New.prefab",
}

return {
    -- 配置
    UIReward = UIReward,
}