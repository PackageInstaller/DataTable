


local UITestTool = {
    Name = UIWindowNames.UITestTool,
    Layer = UILayers.InfoLayer,
    Model = require "UI.UITestTool.UITestToolModel",
    Ctrl = require "UI.UITestTool.UITestToolCtrl",
    View = require "UI.UITestTool.UITestToolView",
    PrefabPath = "UI/Prefabs/View/UI/UITestTool.prefab",
}

return {
    UITestTool = UITestTool,
}