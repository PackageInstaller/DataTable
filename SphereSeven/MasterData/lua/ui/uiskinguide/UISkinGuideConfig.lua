
local UISkinGuide = {
    Name = UIWindowNames.UISkinGuide,
    Layer = UILayers.NormalLayer,
    Model = require "UI.UISkinGuide.UISkinGuideModel",
    Ctrl = nil,
    View = require "UI.UISkinGuide.UISkinGuideView",
    PrefabPath = "UI/Prefabs/View/UI/UISkinGuide.prefab",
}

return {
    UISkinGuide = UISkinGuide,
}