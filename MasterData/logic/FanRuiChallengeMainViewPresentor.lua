-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruichallenge/view/FanRuiChallengeMainViewPresentor.lua

module("logic.extensions.fanruichallenge.view.FanRuiChallengeMainViewPresentor", package.seeall)

local FanRuiChallengeMainViewPresentor = class("FanRuiChallengeMainViewPresentor", ViewPresentor)

function FanRuiChallengeMainViewPresentor:ctor()
	FanRuiChallengeMainViewPresentor.super.ctor(self)
end

function FanRuiChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FanRuiChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/fanruichallenge/fanruichallengemainview.prefab"
	}
end

function FanRuiChallengeMainViewPresentor:buildViews()
	return {
		FanRuiChallengeMainView.New()
	}
end

return FanRuiChallengeMainViewPresentor
