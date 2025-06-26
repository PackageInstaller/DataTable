local UIExpedition = {
    Name = UIWindowNames.UIExpedition,
    Layer = UILayers.BackgroudLayer,
    Model = require "UI.UIExpedition.UIExpeditionModel",
    Ctrl = require "UI.UIExpedition.UIExpeditionCtrl",
    View = require "UI.UIExpedition.UIExpeditionView",
    PrefabPath = "UI/Prefabs/View/UI/UIExpedition.prefab",
}

return {
    UIExpedition = UIExpedition
}