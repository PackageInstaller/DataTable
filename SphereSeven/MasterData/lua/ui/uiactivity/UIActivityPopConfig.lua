

local UIActivityPop ={
    Name = UIWindowNames.UIActivityPop,
    Layer = UILayers.NormalLayer,
    Model = require "UI.UIActivity.UIActivityPopModel",
    Ctrl = require "UI.UIActivity.UIActivityPopCtrl",
    View = require "UI.UIActivity.UIActivityPopView",
    PrefabPath = "UI/Prefabs/View/UI/UIActivityPop.prefab",
}

return {
    UIActivityPop= UIActivityPop,
}