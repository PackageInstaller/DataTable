-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruichallenge/view/FanRuiChallengeControlViewPresentor.lua

module("logic.extensions.fanruichallenge.view.FanRuiChallengeControlViewPresentor", package.seeall)

local FanRuiChallengeControlViewPresentor = class("FanRuiChallengeControlViewPresentor", ViewPresentor)

function FanRuiChallengeControlViewPresentor:ctor()
	FanRuiChallengeControlViewPresentor.super.ctor(self)
end

function FanRuiChallengeControlViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FanRuiChallengeControlViewPresentor:dependWhatResources()
	return {
		"ui/views/fanruichallenge/fanruichallengecontrolview.prefab"
	}
end

function FanRuiChallengeControlViewPresentor:buildViews()
	return {
		FanRuiChallengeControlView.New()
	}
end

return FanRuiChallengeControlViewPresentor
