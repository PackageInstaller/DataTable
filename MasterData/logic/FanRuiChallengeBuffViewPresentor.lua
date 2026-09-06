-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruichallenge/view/FanRuiChallengeBuffViewPresentor.lua

module("logic.extensions.fanruichallenge.view.FanRuiChallengeBuffViewPresentor", package.seeall)

local FanRuiChallengeBuffViewPresentor = class("FanRuiChallengeBuffViewPresentor", ViewPresentor)

function FanRuiChallengeBuffViewPresentor:ctor()
	FanRuiChallengeBuffViewPresentor.super.ctor(self)
end

function FanRuiChallengeBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FanRuiChallengeBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/fanruichallenge/fanruichallengebuffview.prefab"
	}
end

function FanRuiChallengeBuffViewPresentor:buildViews()
	return {
		FanRuiChallengeBuffView.New()
	}
end

return FanRuiChallengeBuffViewPresentor
