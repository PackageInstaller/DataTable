local UIEquipLevelUp = {
    Name = UIWindowNames.UIEquipLevelUp,
    Layer = UILayers.InfoLayer,
    Model = require "UI.UIIntens.UIEquipIntens.UIEquipLevelUp.UIEquipLevelUpModel",
    Ctrl = require "UI.UIIntens.UIEquipIntens.UIEquipLevelUp.UIEquipLevelUpCtrl",
    View = require "UI.UIIntens.UIEquipIntens.UIEquipLevelUp.UIEquipLevelUpView",
    PrefabPath = "UI/Prefabs/UI/Intens/UIEquipLevelUp.prefab",
}

return {
    -- 配置
    UIEquipLevelUp = UIEquipLevelUp,
}