-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuansignin/view/CiyuanSigninProgressViewPresentor.lua

module("logic.extensions.ciyuansignin.view.CiyuanSigninProgressViewPresentor", package.seeall)

local CiyuanSigninProgressViewPresentor = class("CiyuanSigninProgressViewPresentor", ViewPresentor)

function CiyuanSigninProgressViewPresentor:ctor()
	CiyuanSigninProgressViewPresentor.super.ctor(self)
end

function CiyuanSigninProgressViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CiyuanSigninProgressViewPresentor:dependWhatResources()
	return {
		"ui/views/ciyuansignin/ciyuansigninprogressview.prefab"
	}
end

function CiyuanSigninProgressViewPresentor:buildViews()
	return {
		CiyuanSigninProgressView.New()
	}
end

return CiyuanSigninProgressViewPresentor
