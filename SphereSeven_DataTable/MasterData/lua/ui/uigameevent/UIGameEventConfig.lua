local UIGameEventMain = {
    Name = UIWindowNames.UIGameEventMain,
    Layer = UILayers.BackgroudLayer,
	Model = require "UI.UIGameEvent.Model.UIGameEventMainModel",
	Ctrl = require "UI.UIGameEvent.Controller.UIGameEventMainCtrl",
	View = require "UI.UIGameEvent.View.UIGameEventMainView",
	PrefabPath = "UI/Prefabs/View/UI/UIGameEventMain.prefab",
}

return {
	UIGameEventMain = UIGameEventMain,
}