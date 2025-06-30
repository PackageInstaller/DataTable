--[[
-- added by wsh @ 2017-11-30
-- UILogin模块窗口配置，要使用还需要导出到UI.Config.UIConfig.lua
-- 一个模块可以对应多个窗口，每个窗口对应一个配置项
-- 使用范例：
-- 窗口配置表 ={
--		名字Name
--		UI层级Layer
-- 		控制器类Controller
--		模型类Model
--		视图类View
--		资源加载路径PrefabPath
-- } 
--]]

-- 窗口配置
local UISsLogin = {
	Name = UIWindowNames.UISsLogin,
	Layer = UILayers.BackgroudLayer,
	Model = require "UI.UISsLogin.UISsLoginModel",
	Ctrl = require "UI.UISsLogin.UISsLoginCtrl",
	View = require "UI.UISsLogin.UISsLoginView",
	PrefabPath = "UI/Prefabs/View/UI/UILogin.prefab",
}

local UISsLoginServer = {
	Name = UIWindowNames.UISsLoginServer,
	Layer = UILayers.BackgroudLayer,
	Model = require "UI.UISsLogin.UISsLoginServerModel",
	Ctrl = require "UI.UISsLogin.UISsLoginServerCtrl",
	View = require "UI.UISsLogin.UISsLoginServerView",
	PrefabPath = "UI/Prefabs/View/UISsLoginServer.prefab",
}

local UILoginStatute = {
	Name = UIWindowNames.UILoginStatute,
	Layer = UILayers.TipLayer,
	Model = nil,
	Ctrl = nil,
	View = require "UI.UISsLogin.UILoginStatuteView",
	PrefabPath = "UI/Prefabs/View/UI/UILoginStatute.prefab",
}

local UILoginStatuteDetail = {
	Name = UIWindowNames.UILoginStatuteDetail,
	Layer = UILayers.TipLayer,
	Model = require "UI.UISsLogin.UILoginStatuteDetailModel",
	Ctrl = nil,
	View = require "UI.UISsLogin.UILoginStatuteDetailView",
	PrefabPath = "UI/Prefabs/View/UI/UILoginStatuteDetail.prefab",
}

local UILoginChoose = {
	Name = UIWindowNames.UILoginChoose,
	Layer = UILayers.TipLayer,
	Model = nil,
	Ctrl = nil,
	View = require "UI.UISsLogin.UILoginChooseView",
	PrefabPath = "UI/Prefabs/View/UI/UILoginChoose.prefab",
}

local UILoginGenerateCode = {
	Name = UIWindowNames.UILoginGenerateCode,
	Layer = UILayers.TipLayer,
	Model = nil,
	Ctrl = nil,
	View = require "UI.UISsLogin.UILoginGenerateCodeView",
	PrefabPath = "UI/Prefabs/View/UI/UILoginGenerateCode.prefab",
}

local UILoginSetLang = {
	Name = UIWindowNames.UILoginSetLang,
	Layer = UILayers.TipLayer,
	Model = nil,
	Ctrl = nil,
	View = require "UI.UISsLogin.UILoginSetLang.UILoginSetLangView",
	PrefabPath = "UI/Prefabs/View/UI/UILoginSetLang.prefab",
}

return {
	-- 配置
	UISsLogin = UISsLogin,
	UISsLoginServer = UISsLoginServer,
	UILoginStatute = UILoginStatute,
	UILoginStatuteDetail = UILoginStatuteDetail,
	UILoginChoose = UILoginChoose,
	UILoginGenerateCode = UILoginGenerateCode,
	UILoginSetLang = UILoginSetLang,
}