local UIChooseEquip = {
    Name = UIWindowNames.UIChooseEquip,
    Layer = UILayers.BackgroudLayer,
    Model = require "UI.UIIntens.UIEquipIntens.UIChooseEquip.UIChooseEquipModel",
    Ctrl = require "UI.UIIntens.UIEquipIntens.UIChooseEquip.UIChooseEquipCtrl",
    View = require "UI.UIIntens.UIEquipIntens.UIChooseEquip.UIChooseEquipView",
    PrefabPath = "UI/Prefabs/UI/Intens/UIChooseEquip.prefab",
}

return {
    -- 配置
    UIChooseEquip = UIChooseEquip,
}