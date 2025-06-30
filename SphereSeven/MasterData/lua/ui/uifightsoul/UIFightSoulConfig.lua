-- 窗口配置
local UIFightSoulMain = {
	Name = UIWindowNames.UIFightSoulMain,
	Layer = UILayers.BackgroudLayer,
	Model = require "UI.UIFightSoul.Model.UIFightSoulMainModel",
	Ctrl = require "UI.UIFightSoul.Controller.UIFightSoulMainCtrl",
	View = require "UI.UIFightSoul.View.UIFightSoulMainView",
	PrefabPath = "UI/Prefabs/View/UI/UIFightSoulMain.prefab",
}

local UIFightSoulLevelUp = {
	Name = UIWindowNames.UIFightSoulLevelUp,
	Layer = UILayers.BackgroudLayer,
	Model = require "UI.UIFightSoul.Model.UIFightSoulLevelUpModel",
	Ctrl = require "UI.UIFightSoul.Controller.UIFightSoulLevelUpCtrl",
	View = require "UI.UIFightSoul.View.UIFightSoulLevelUpView",
	PrefabPath = "UI/Prefabs/View/UI/UIFightSoulLevelUp.prefab",
}

local UIFightSoulFilter = {
	Name = UIWindowNames.UIFightSoulFilter,
	Layer = UILayers.InfoLayer,
	Model = require "UI.UIFightSoul.Model.UIFightSoulFilterModel",
	Ctrl = nil,
	View = require "UI.UIFightSoul.View.UIFightSoulFilterView",
	PrefabPath = "UI/Prefabs/View/UI/UIFightSoulFilter.prefab",
}

local UIFightSoulMerge = {
	Name = UIWindowNames.UIFightSoulMerge,
	Layer = UILayers.BackgroudLayer,
	Model = require "UI.UIFightSoul.Model.UIFightSoulMergeModel",
	Ctrl = require "UI.UIFightSoul.Controller.UIFightSoulMergeCtrl",
	View = require "UI.UIFightSoul.View.UIFightSoulMergeView",
	PrefabPath = "UI/Prefabs/View/UI/UIFightSoulMerge.prefab",
}

local UIFightSoulDecompose = {
	Name = UIWindowNames.UIFightSoulDecompose,
	Layer = UILayers.BackgroudLayer,
	Model = require "UI.UIFightSoul.Model.UIFightSoulDecomposeModel",
	Ctrl = require "UI.UIFightSoul.Controller.UIFightSoulDecomposeCtrl",
	View = require "UI.UIFightSoul.View.UIFightSoulDecomposeView",
	PrefabPath = "UI/Prefabs/View/UI/UIFightSoulDecompose.prefab",
}

local UIFightSoulMergeMaterials = {
    Name = UIWindowNames.UIFightSoulMergeMaterials,
    Layer = UILayers.TopLayer,
	Model = require "UI.UIFightSoul.Model.UIFightSoulMergeMaterialsModel",
	Ctrl = require "UI.UIFightSoul.Controller.UIFightSoulMergeMaterialsCtrl",
	View = require "UI.UIFightSoul.View.UIFightSoulMergeMaterialsView",
	PrefabPath = "UI/Prefabs/View/UI/UIFightSoulMergeMaterials.prefab",
}

return {
	UIFightSoulMain = UIFightSoulMain,
	UIFightSoulLevelUp = UIFightSoulLevelUp,
	UIFightSoulFilter = UIFightSoulFilter,
	UIFightSoulMerge = UIFightSoulMerge,
	UIFightSoulDecompose = UIFightSoulDecompose,
	UIFightSoulMergeMaterials = UIFightSoulMergeMaterials,
}