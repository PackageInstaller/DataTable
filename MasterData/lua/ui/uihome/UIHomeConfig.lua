--[[
-- added by wsh @ 2018-02-26
-- UITestMain模块窗口配置，要使用还需要导出到UI.Config.UIConfig.lua
--]]

-- 窗口配置
local UIHome = {
	Name = UIWindowNames.UIHome,
	Layer = UILayers.BackgroudLayer,
	Model = require "UI.UIHome.Model.UIHomeModel",
	Ctrl = require "UI.UIHome.Controller.UIHomeCtrl",
	View = require "UI.UIHome.View.UIHomeView",
	PrefabPath = "UI/Prefabs/View/UI/UILobby.prefab",
}

local UIComTop = {
	Name = UIWindowNames.UIComTop,
	Layer = UILayers.TopLayer,
    Model = require "UI.UIHome.Model.UIComTopModel",
	Ctrl = require "UI.UIHome.Controller.UIComTopCtrl",
	View =  require "UI.UIHome.View.UIComTopView",
	PrefabPath = "UI/Prefabs/View/UI/UIComTop.prefab"
}

return {
	UIHome = UIHome,
	UIComTop = UIComTop
}