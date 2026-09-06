-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityRewardTabViewPresentor.lua

module("logic.extensions.guardcity.view.GuardCityRewardTabViewPresentor", package.seeall)

local GuardCityRewardTabViewPresentor = class("GuardCityRewardTabViewPresentor", ViewPresentor)

function GuardCityRewardTabViewPresentor:ctor()
	GuardCityRewardTabViewPresentor.super.ctor(self)
end

function GuardCityRewardTabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuardCityRewardTabViewPresentor:dependWhatResources()
	return {
		"ui/views/guardcity/guardcityrewardtabview.prefab"
	}
end

function GuardCityRewardTabViewPresentor:buildViews()
	return {
		GuardCityRewardTabView.New()
	}
end

function GuardCityRewardTabViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GuardCityRewardTabViewPresentor
