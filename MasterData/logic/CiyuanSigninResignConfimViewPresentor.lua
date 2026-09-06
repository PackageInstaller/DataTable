-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuansignin/view/CiyuanSigninResignConfimViewPresentor.lua

module("logic.extensions.ciyuansignin.view.CiyuanSigninResignConfimViewPresentor", package.seeall)

local CiyuanSigninResignConfimViewPresentor = class("CiyuanSigninResignConfimViewPresentor", ViewPresentor)

function CiyuanSigninResignConfimViewPresentor:ctor()
	CiyuanSigninResignConfimViewPresentor.super.ctor(self)
end

function CiyuanSigninResignConfimViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CiyuanSigninResignConfimViewPresentor:dependWhatResources()
	return {
		"ui/views/ciyuansignin/ciyuansigninresignconfimview.prefab"
	}
end

function CiyuanSigninResignConfimViewPresentor:buildViews()
	return {
		CiyuanSigninResignConfimView.New()
	}
end

return CiyuanSigninResignConfimViewPresentor
