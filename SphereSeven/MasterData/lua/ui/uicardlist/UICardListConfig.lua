---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/5/24 16:58
---

local UITransition = {
    Name = UIWindowNames.UICardList,
    Layer = UILayers.BackgroudLayer,
    Model = require "UI.UICardList.UICardListModel",
    Ctrl = require "UI.UICardList.UICardListCtrl",
    View = require "UI.UICardList.UICardListView",
    PrefabPath = "UI/Prefabs/View/UI/UICardList.prefab",
}

return {
    -- 配置
    UITransition = UITransition,
}