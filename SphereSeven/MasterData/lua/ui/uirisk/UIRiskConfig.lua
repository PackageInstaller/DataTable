---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/5/24 16:58
---

local UIRisk = {
    Name = UIWindowNames.UIRisk,
    Layer = UILayers.BackgroudLayer,
    Model = require "UI.UIRisk.UIRiskModel",
    Ctrl = nil,
    View = require "UI.UIRisk.UIRiskView",
    PrefabPath = "UI/Prefabs/View/UI/UIRisk.prefab",
}

return {
    -- 配置
    UIRisk = UIRisk,
}