
local UIRoleInfo = {
    Name = UIWindowNames.UIRoleInfo,
    Layer = UILayers.BackgroudLayer,
    Model = require "UI.UIRoleInfo.UIRoleInfoModel",
    Ctrl = require "UI.UIRoleInfo.UIRoleInfoCtrl",
    View = require "UI.UIPlayerInfo.UIPlayerInfoView",
    PrefabPath = "UI/Prefabs/View/UI/UIPlayerInfo.prefab",
}

return {
    -- 配置
    UIRoleInfo = UIRoleInfo,
}