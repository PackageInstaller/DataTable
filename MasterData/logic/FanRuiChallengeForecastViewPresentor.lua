-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruichallenge/view/FanRuiChallengeForecastViewPresentor.lua

module("logic.extensions.fanruichallenge.view.FanRuiChallengeForecastViewPresentor", package.seeall)

local FanRuiChallengeForecastViewPresentor = class("FanRuiChallengeForecastViewPresentor", ViewPresentor)

function FanRuiChallengeForecastViewPresentor:ctor()
	FanRuiChallengeForecastViewPresentor.super.ctor(self)
end

function FanRuiChallengeForecastViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FanRuiChallengeForecastViewPresentor:dependWhatResources()
	return {
		"ui/views/fanruichallenge/fanruichallengeforecastview.prefab"
	}
end

function FanRuiChallengeForecastViewPresentor:buildViews()
	return {
		FanRuiChallengeForecastView.New()
	}
end

return FanRuiChallengeForecastViewPresentor
