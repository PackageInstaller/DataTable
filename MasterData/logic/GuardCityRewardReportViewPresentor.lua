-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityRewardReportViewPresentor.lua

module("logic.extensions.guardcity.view.GuardCityRewardReportViewPresentor", package.seeall)

local GuardCityRewardReportViewPresentor = class("GuardCityRewardReportViewPresentor", ViewPresentor)

function GuardCityRewardReportViewPresentor:ctor()
	GuardCityRewardReportViewPresentor.super.ctor(self)
end

function GuardCityRewardReportViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuardCityRewardReportViewPresentor:dependWhatResources()
	return {
		"ui/views/guardcity/guardcityrewardreportview.prefab"
	}
end

function GuardCityRewardReportViewPresentor:buildViews()
	return {
		GuardCityRewardReportView.New()
	}
end

function GuardCityRewardReportViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GuardCityRewardReportViewPresentor
