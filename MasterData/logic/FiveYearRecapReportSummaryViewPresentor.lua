-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fiveyearrecap/view/FiveYearRecapReportSummaryViewPresentor.lua

module("logic.extensions.fiveyearrecap.view.FiveYearRecapReportSummaryViewPresentor", package.seeall)

local FiveYearRecapReportSummaryViewPresentor = class("FiveYearRecapReportSummaryViewPresentor", ViewPresentor)

function FiveYearRecapReportSummaryViewPresentor:ctor()
	FiveYearRecapReportSummaryViewPresentor.super.ctor(self)
end

function FiveYearRecapReportSummaryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FiveYearRecapReportSummaryViewPresentor:dependWhatResources()
	return {
		"ui/views/fiveyearrecap/fiveyearrecapreportsummaryview.prefab"
	}
end

function FiveYearRecapReportSummaryViewPresentor:buildViews()
	return {
		FiveYearRecapReportSummaryView.New()
	}
end

return FiveYearRecapReportSummaryViewPresentor
