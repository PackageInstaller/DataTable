---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/5/24 16:58
---

local UIBattleMode = {
    Name = UIWindowNames.UIBattleMode,
    Layer = UILayers.BackgroudLayer,
    Model = require "UI.UIBattleMode.UIBattleModeModel",
    Ctrl = require "UI.UIBattleMode.UIBattleModeCtrl",
    View = require "UI.UIBattleMode.UIBattleModeView",
    PrefabPath = "UI/Prefabs/View/UI/UIBattleMode.prefab",
}

return {
    -- 配置
    UIBattleMode = UIBattleMode,
}