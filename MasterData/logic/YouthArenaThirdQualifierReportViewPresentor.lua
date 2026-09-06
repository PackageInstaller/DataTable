-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdQualifierReportViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdQualifierReportViewPresentor", package.seeall)

local YouthArenaThirdQualifierReportViewPresentor = class("YouthArenaThirdQualifierReportViewPresentor", ViewPresentor)

function YouthArenaThirdQualifierReportViewPresentor:ctor()
	YouthArenaThirdQualifierReportViewPresentor.super.ctor(self)
end

function YouthArenaThirdQualifierReportViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function YouthArenaThirdQualifierReportViewPresentor:dependWhatResources()
	return {
		"ui/views/youtharenathird/youtharenathirdreportview.prefab"
	}
end

function YouthArenaThirdQualifierReportViewPresentor:buildViews()
	return {
		YouthArenaThirdQualifierReportView.New()
	}
end

return YouthArenaThirdQualifierReportViewPresentor
