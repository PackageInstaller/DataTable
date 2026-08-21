local UIActivityFightSoulelist = {
    Name = UIWindowNames.UIActivityFightSoulelist,
    Layer = UILayers.NormalLayer,
    Model = require "UI.UIActivity.UIActivityFightSoulelist.UIActivityFightSoulelistModel",
    Ctrl = nil,
    View = require "UI.UIActivity.UIActivityFightSoulelist.UIActivityFightSoulelistView",
    PrefabPath = "UI/Prefabs/View/UI/UIActivityFightSoulelist.prefab",
}


return {
    -- 配置
    UIActivityFightSoulelist = UIActivityFightSoulelist,
}