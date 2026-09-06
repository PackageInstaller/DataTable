-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/UserProtocalViewPresentor.lua

module("logic.extensions.login.view.UserProtocalViewPresentor", package.seeall)

local UserProtocalViewPresentor = class("UserProtocalViewPresentor", ViewPresentor)

function UserProtocalViewPresentor:attachToWhichRoot()
	return ViewRootType.TopMost
end

function UserProtocalViewPresentor:dependWhatResources()
	return {
		"ui/views/login/userprotocalview.prefab"
	}
end

function UserProtocalViewPresentor:buildViews()
	return {
		UserProtocalView.New()
	}
end

function UserProtocalViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return UserProtocalViewPresentor
