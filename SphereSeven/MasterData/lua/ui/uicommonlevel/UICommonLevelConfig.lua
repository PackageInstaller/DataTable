local UICommonLevel = {
    Name = UIWindowNames.UICommonLevel,
    Layer = UILayers.BackgroudLayer,
    Model = require "UI.UICommonLevel.UICommonLevelModel",
    Ctrl = nil,
    View = require "UI.UICommonLevel.UICommonLevelView",
    PrefabPath = "UI/Prefabs/View/UI/UICommonLevel.prefab",
}

return {
    -- 配置
    UICommonLevel = UICommonLevel,
}