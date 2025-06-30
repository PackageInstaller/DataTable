
local UINoviceGuide = {
    Name = UIWindowNames.UINoviceGuide,
    Layer = UILayers.TipLayer,
    Model = require "UI.UINoviceGuide.UINoviceGuideModel",
    Ctrl = require "UI.UINoviceGuide.UINoviceGuideCtrl",
    View = require "UI.UINoviceGuide.UINoviceGuideView",
    PrefabPath = "UI/Prefabs/View/UI/UINoviceGuide.prefab",
}

return {UINoviceGuide = UINoviceGuide};