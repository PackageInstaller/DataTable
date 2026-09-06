-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/CreateRoleViewPresentor.lua

module("logic.extensions.login.view.CreateRoleViewPresentor", package.seeall)

local CreateRoleViewPresentor = class("CreateRoleViewPresentor", ViewPresentor)

function CreateRoleViewPresentor:ctor()
	CreateRoleViewPresentor.super.ctor(self)
end

function CreateRoleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CreateRoleViewPresentor:dependWhatResources()
	return {
		"ui/views/login/createroleview.prefab",
		UIEffectManager.instance:getEffectPath("fx_ui_chuangjue/fx_ui_chuangjue_01.prefab")
	}
end

function CreateRoleViewPresentor:buildViews()
	return {
		CreateRoleView.New(),
		NamingView.New()
	}
end

return CreateRoleViewPresentor
