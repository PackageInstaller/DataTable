-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/LoginViewPresentor.lua

module("logic.extensions.login.view.LoginViewPresentor", package.seeall)

local LoginViewPresentor = class("LoginViewPresentor", ViewPresentor)

function LoginViewPresentor:ctor()
	LoginViewPresentor.super.ctor(self)
end

function LoginViewPresentor:dependWhatResources()
	local reses = {}

	table.insertto(reses, CommonResPath.loginviewAssets)

	if rescache.resLoadMode == Framework.ResourceLoadMode.Direct then
		table.insert(reses, CommonResPath.loginAnimTakePath)
	end

	return reses
end

function LoginViewPresentor:buildViews()
	local views = {}
	local mainView = LoginView.New()

	table.insert(views, mainView)

	return views
end

function LoginViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return LoginViewPresentor
