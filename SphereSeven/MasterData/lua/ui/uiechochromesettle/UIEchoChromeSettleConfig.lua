local UIEchoChromeSettle = {
    Name = UIWindowNames.UIEchoChromeSettle,
    Layer = UILayers.InfoLayer,
    Model = require "UI.UIEchoChromeSettle.UIEchoChromeSettleModel",
    Ctrl = require "UI.UIEchoChromeSettle.UIEchoChromeSettleCtrl",
    View = require "UI.UIEchoChromeSettle.UIEchoChromeSettleView",
    PrefabPath = "UI/Prefabs/View/UI/UIEchoChromeSettle.prefab",
}
return {UIEchoChromeSettle = UIEchoChromeSettle}