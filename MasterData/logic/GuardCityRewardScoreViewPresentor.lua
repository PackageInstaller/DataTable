-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityRewardScoreViewPresentor.lua

module("logic.extensions.guardcity.view.GuardCityRewardScoreViewPresentor", package.seeall)

local GuardCityRewardScoreViewPresentor = class("GuardCityRewardScoreViewPresentor", ViewPresentor)

function GuardCityRewardScoreViewPresentor:ctor()
	GuardCityRewardScoreViewPresentor.super.ctor(self)
end

function GuardCityRewardScoreViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuardCityRewardScoreViewPresentor:dependWhatResources()
	return {
		"ui/views/guardcity/guardcityrewardscoreview.prefab"
	}
end

function GuardCityRewardScoreViewPresentor:buildViews()
	return {
		GuardCityRewardScoreView.New()
	}
end

function GuardCityRewardScoreViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GuardCityRewardScoreViewPresentor
