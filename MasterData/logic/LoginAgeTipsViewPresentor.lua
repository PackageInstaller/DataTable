-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/LoginAgeTipsViewPresentor.lua

module("logic.extensions.login.view.LoginAgeTipsViewPresentor", package.seeall)

local LoginAgeTipsViewPresentor = class("LoginAgeTipsViewPresentor", ViewPresentor)

function LoginAgeTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.TopMost
end

function LoginAgeTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/login/loginagetipsview.prefab"
	}
end

function LoginAgeTipsViewPresentor:buildViews()
	return {
		LoginAgeTipsView.New()
	}
end

function LoginAgeTipsViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return LoginAgeTipsViewPresentor
