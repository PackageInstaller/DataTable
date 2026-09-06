-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruichallenge/view/FanRuiChallengeLifeViewPresentor.lua

module("logic.extensions.fanruichallenge.view.FanRuiChallengeLifeViewPresentor", package.seeall)

local FanRuiChallengeLifeViewPresentor = class("FanRuiChallengeLifeViewPresentor", ViewPresentor)

function FanRuiChallengeLifeViewPresentor:ctor()
	FanRuiChallengeLifeViewPresentor.super.ctor(self)
end

function FanRuiChallengeLifeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FanRuiChallengeLifeViewPresentor:dependWhatResources()
	return {
		"ui/views/fanruichallenge/fanruichallengelifeview.prefab"
	}
end

function FanRuiChallengeLifeViewPresentor:buildViews()
	return {
		FanRuiChallengeLifeView.New()
	}
end

return FanRuiChallengeLifeViewPresentor
