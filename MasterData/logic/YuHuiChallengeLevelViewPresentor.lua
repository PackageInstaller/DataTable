-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yuhuichallenge/view/YuHuiChallengeLevelViewPresentor.lua

module("logic.extensions.yuhuichallenge.view.YuHuiChallengeLevelViewPresentor", package.seeall)

local YuHuiChallengeLevelViewPresentor = class("YuHuiChallengeLevelViewPresentor", ViewPresentor)

function YuHuiChallengeLevelViewPresentor:ctor()
	YuHuiChallengeLevelViewPresentor.super.ctor(self)
end

function YuHuiChallengeLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YuHuiChallengeLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/yuhuichallenge/yuhuichallengelevelview.prefab"
	}
end

function YuHuiChallengeLevelViewPresentor:buildViews()
	return {
		YuHuiChallengeLevelView.New()
	}
end

return YuHuiChallengeLevelViewPresentor
