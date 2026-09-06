-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fiveyearrecap/view/FiveYearRecapReportViewPresentor.lua

module("logic.extensions.fiveyearrecap.view.FiveYearRecapReportViewPresentor", package.seeall)

local FiveYearRecapReportViewPresentor = class("FiveYearRecapReportViewPresentor", ViewPresentor)

function FiveYearRecapReportViewPresentor:ctor()
	FiveYearRecapReportViewPresentor.super.ctor(self)
end

function FiveYearRecapReportViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FiveYearRecapReportViewPresentor:dependWhatResources()
	return {
		"ui/views/fiveyearrecap/fiveyearrecapreportview.prefab"
	}
end

function FiveYearRecapReportViewPresentor:buildViews()
	return {
		FiveYearRecapReportView.New()
	}
end

return FiveYearRecapReportViewPresentor
