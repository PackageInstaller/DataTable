local UIEquipScrap = {
    Name = UIWindowNames.UIEquipScrap,
    Layer = UILayers.BackgroudLayer,
    Model = require "UI.UIIntens.UIEquipIntens.UIEquipScrap.UIEquipScrapModel",
    Ctrl = require "UI.UIIntens.UIEquipIntens.UIEquipScrap.UIEquipScrapCtrl",
    View = require "UI.UIIntens.UIEquipIntens.UIEquipScrap.UIEquipScrapView",
    PrefabPath = "UI/Prefabs/View/UI/UIEquipScrap.prefab",
}

return {
    -- 配置
    UIEquipScrap = UIEquipScrap,
}