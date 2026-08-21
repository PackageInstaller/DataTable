-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/LoginViewPresentor.lua

module("logic.extensions.login.view.LoginViewPresentor", package.seeall)

local M = class("LoginViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Login_login_start_view_copy
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, LoginView.New())
	table.insert(views, RemoteToolPasswordView.New())

	return views
end

function M:attachToWhichRoot()
	return ViewRootType.Hud
end

return M
