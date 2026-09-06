-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/XjchallengeViewPresentor.lua

module("logic.extensions.xingjiang.view.XjchallengeViewPresentor", package.seeall)

local XjchallengeViewPresentor = class("XjchallengeViewPresentor", ViewPresentor)

function XjchallengeViewPresentor:ctor()
	XjchallengeViewPresentor.super.ctor(self)
end

function XjchallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XjchallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/xingjiang/xjchallengeview.prefab"
	}
end

function XjchallengeViewPresentor:buildViews()
	return {
		XjchallengeView.New()
	}
end

return XjchallengeViewPresentor
