local UIActivity = {
    Name = UIWindowNames.UIActivity,
    Layer = UILayers.BackgroudLayer,
    Model = require "UI.UIActivity.UIActivityModel",
    Ctrl = require "UI.UIActivity.UIActivityCtrl",
    View = require "UI.UIActivity.UIActivityView",
    PrefabPath = "UI/Prefabs/View/UI/UIActivity.prefab",
}

local UIGuideGift = {
    Name = UIWindowNames.UIGuideGift,
    Layer = UILayers.NormalLayer,
    Model = require "UI.UIActivity.GuideGift.UIGuideGiftModel",
    Ctrl = null,
    View = require "UI.UIActivity.GuideGift.UIGuideGiftView",
    PrefabPath = "UI/Prefabs/View/UI/UIGuideGift.prefab",
}

return {
    -- 配置
    UIActivity = UIActivity,
    UIGuideGift = UIGuideGift,
}