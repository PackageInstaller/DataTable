

local UIPlayerInceptionInfo = {
    Name = UIWindowNames.UIPlayerInceptionInfo,
    Layer = UILayers.BackgroudLayer,
    Model = require "UI.UIPlayerInceptionInfo.UIPlayerInceptionInfoModel",
    Ctrl = require "UI.UIPlayerInceptionInfo.UIPlayerInceptionInfoCtrl",
    View = require "UI.UIPlayerInceptionInfo.UIPlayerInceptionInfoView",
    PrefabPath = "UI/Prefabs/View/UI/UIPlayerInceptionInfo.prefab",
}

return {UIPlayerInceptionInfo = UIPlayerInceptionInfo};