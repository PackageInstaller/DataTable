local UIShowStarLightList = {
    Name = UIWindowNames.UIShowStarLightList,
    Layer = UILayers.NormalLayer,
    Model = require "UI.UIActivity.UIShowStarLightList.UIShowStarLightListModel",
    Ctrl = nil,
    View = require "UI.UIActivity.UIShowStarLightList.UIShowStarLightListView",
    PrefabPath = "UI/Prefabs/View/UI/UIShowStarLightList.prefab",
}


return {
    -- 配置
    UIShowStarLightList = UIShowStarLightList,
}