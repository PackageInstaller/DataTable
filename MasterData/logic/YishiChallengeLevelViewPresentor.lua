-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yishichallenge/view/YishiChallengeLevelViewPresentor.lua

module("logic.extensions.yishichallenge.view.YishiChallengeLevelViewPresentor", package.seeall)

local YishiChallengeLevelViewPresentor = class("YishiChallengeLevelViewPresentor", ViewPresentor)

function YishiChallengeLevelViewPresentor:ctor()
	YishiChallengeLevelViewPresentor.super.ctor(self)
end

function YishiChallengeLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YishiChallengeLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/yishichallenge/yishichallengelevelview.prefab"
	}
end

function YishiChallengeLevelViewPresentor:buildViews()
	return {
		YishiChallengeLevelView.New()
	}
end

return YishiChallengeLevelViewPresentor
