-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityReportDetailViewPresentor.lua

module("logic.extensions.guardcity.view.GuardCityReportDetailViewPresentor", package.seeall)

local GuardCityReportDetailViewPresentor = class("GuardCityReportDetailViewPresentor", ViewPresentor)

function GuardCityReportDetailViewPresentor:ctor()
	GuardCityReportDetailViewPresentor.super.ctor(self)
end

function GuardCityReportDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuardCityReportDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/guardcity/guardcityreportdetailview.prefab"
	}
end

function GuardCityReportDetailViewPresentor:buildViews()
	return {
		GuardCityReportDetailView.New()
	}
end

function GuardCityReportDetailViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GuardCityReportDetailViewPresentor
