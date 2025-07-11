--[[
-- added by wsh @ 2017-12-18
-- UILoading模块窗口配置，要使用还需要导出到UI.Config.UIConfig.lua
--]]

-- 窗口配置
local UILoading = {
	Name = UIWindowNames.UILoading,
	Layer = UILayers.UILoading,
	Model = require "UI.UILoading.Model.UILoadingModel",
	Ctrl = nil,
	View = require "UI.UILoading.View.UILoadingView",
	PrefabPath = "UI/Prefabs/View/UILoading.prefab",
}

local UIBlack = {
	Name = UIWindowNames.UIBlack,
	Layer = UILayers.UILoading,
	Model = nil,
	Ctrl = nil,
	View = require "UI.UILoading.View.UIBlackView",
	PrefabPath = "UI/Prefabs/View/UI/UIBlack.prefab",
}

return {
	-- 配置
	UILoading = UILoading,
	UIBlack = UIBlack,
}