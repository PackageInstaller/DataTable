local UIExpeditionTipConfig = {
    Name = UIWindowNames.UIExpeditionTip,
    Layer = UILayers.TipLayer,
    Model = require "UI.UIExpeditionTip.UIExpeditionTipModel",
    Ctrl = require "UI.UIExpeditionTip.UIExpeditionTipCtrl",
    View = require "UI.UIExpeditionTip.UIExpeditionTipView",
    PrefabPath = "UI/Prefabs/View/UI/UIExpeditionTip.prefab",
}

return {
    UIExpeditionTipConfig = UIExpeditionTipConfig
}