-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruichallenge/view/FanRuiChallengeDestinyViewPresentor.lua

module("logic.extensions.fanruichallenge.view.FanRuiChallengeDestinyViewPresentor", package.seeall)

local FanRuiChallengeDestinyViewPresentor = class("FanRuiChallengeDestinyViewPresentor", ViewPresentor)

function FanRuiChallengeDestinyViewPresentor:ctor()
	FanRuiChallengeDestinyViewPresentor.super.ctor(self)
end

function FanRuiChallengeDestinyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FanRuiChallengeDestinyViewPresentor:dependWhatResources()
	return {
		"ui/views/fanruichallenge/fanruichallengedestinyview.prefab"
	}
end

function FanRuiChallengeDestinyViewPresentor:buildViews()
	return {
		FanRuiChallengeDestinyView.New()
	}
end

return FanRuiChallengeDestinyViewPresentor
