-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wuwenchallenge/view/WuWenChallengeLevelViewPresentor.lua

module("logic.extensions.wuwenchallenge.view.WuWenChallengeLevelViewPresentor", package.seeall)

local WuWenChallengeLevelViewPresentor = class("WuWenChallengeLevelViewPresentor", ViewPresentor)

function WuWenChallengeLevelViewPresentor:ctor()
	WuWenChallengeLevelViewPresentor.super.ctor(self)
end

function WuWenChallengeLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WuWenChallengeLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/wuwenchallenge/wuwenchallengelevelview.prefab"
	}
end

function WuWenChallengeLevelViewPresentor:buildViews()
	return {
		WuWenChallengeLevelView.New()
	}
end

return WuWenChallengeLevelViewPresentor
