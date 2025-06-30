local UIGameEventLevelMain = {
    Name = UIWindowNames.UIGameEventLevelMain,
    Layer = UILayers.BackgroudLayer,
	Model = require "UI.UIGameEventLevel.Model.UIGameEventLevelMainModel",
	Ctrl = require "UI.UIGameEventLevel.Controller.UIGameEventLevelMainCtrl",
	View = require "UI.UIGameEventLevel.View.UIGameEventLevelMainView",
	PrefabPath = "UI/Prefabs/View/UI/GameEventLevel/UIGameEventLevelMain.prefab",
}

local UIGameEventLevel2Main = {
    Name = UIWindowNames.UIGameEventLevel2Main,
    Layer = UILayers.BackgroudLayer,
	Model = require "UI.UIGameEventLevel.Model.UIGameEventLevel2MainModel",
	Ctrl = require "UI.UIGameEventLevel.Controller.UIGameEventLevel2MainCtrl",
	View = require "UI.UIGameEventLevel.View.UIGameEventLevel2MainView",
	PrefabPath = "UI/Prefabs/View/UI/GameEventLevel/UIGameEventLevel2Main.prefab",
}

local UIGameEventLevelExLevel = {
    Name = UIWindowNames.UIGameEventLevelExLevel,
    Layer = UILayers.BackgroudLayer,
	Model = require "UI.UIGameEventLevel.Model.UIGameEventLevelExLevelModel",
	Ctrl = require "UI.UIGameEventLevel.Controller.UIGameEventLevelExLevelCtrl",
	View = require "UI.UIGameEventLevel.View.UIGameEventLevelExLevelView",
	PrefabPath = "UI/Prefabs/View/UI/GameEventLevel/UIGameEventLevelExLevel.prefab",
}


local UIGameEventLevelTask = {
    Name = UIWindowNames.UIGameEventLevelTask,
    Layer = UILayers.BackgroudLayer,
	Model = require "UI.UIGameEventLevel.Model.UIGameEventLevelTaskModel",
	Ctrl = require "UI.UIGameEventLevel.Controller.UIGameEventLevelTaskCtrl",
	View = require "UI.UIGameEventLevel.View.UIGameEventLevelTaskView",
	PrefabPath = "UI/Prefabs/View/UI/GameEventLevel/UIGameEventLevelTask.prefab",
}


local UIGameEventLevelStore = {
    Name = UIWindowNames.UIGameEventLevelStore,
    Layer = UILayers.BackgroudLayer,
	Model = require "UI.UIGameEventLevel.Model.UIGameEventLevelStoreModel",
	Ctrl = require "UI.UIGameEventLevel.Controller.UIGameEventLevelStoreCtrl",
	View = require "UI.UIGameEventLevel.View.UIGameEventLevelStoreView",
	PrefabPath = "UI/Prefabs/View/UI/GameEventLevel/UIGameEventLevelStore.prefab",
}

local UIGameEventLevelRateUp = {
    Name = UIWindowNames.UIGameEventLevelRateUp,
    Layer = UILayers.InfoLayer,
	Model = require "UI.UIGameEventLevel.Model.UIGameEventLevelRateUpModel",
	Ctrl = require "UI.UIGameEventLevel.Controller.UIGameEventLevelRateUpCtrl",
	View = require "UI.UIGameEventLevel.View.UIGameEventLevelRateUpView",
	PrefabPath = "UI/Prefabs/View/UI/GameEventLevel/UIGameEventLevelRateUp.prefab",
}


return {
	UIGameEventLevelMain = UIGameEventLevelMain,
	UIGameEventLevel2Main = UIGameEventLevel2Main,
	UIGameEventLevelExLevel = UIGameEventLevelExLevel,
	UIGameEventLevelTask = UIGameEventLevelTask,
	UIGameEventLevelStore = UIGameEventLevelStore,
	UIGameEventLevelRateUp = UIGameEventLevelRateUp,
}