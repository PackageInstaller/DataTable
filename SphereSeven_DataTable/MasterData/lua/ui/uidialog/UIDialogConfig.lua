
local UIDialog = 
{
    Name = UIWindowNames.UIDialog,
    Layer = UILayers.NormalLayer,
    Model = nil,
    Ctrl = nil,
    View = require "UI.UIDialog.UIDialogView",
    PrefabPath = "UI/Prefabs/View/UI/UIDialog.prefab",
}

return { UIDialog = UIDialog }