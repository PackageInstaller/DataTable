-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdChampionScheduleReportViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdChampionScheduleReportViewPresentor", package.seeall)

local YouthArenaThirdChampionScheduleReportViewPresentor = class("YouthArenaThirdChampionScheduleReportViewPresentor", ViewPresentor)

function YouthArenaThirdChampionScheduleReportViewPresentor:ctor()
	YouthArenaThirdChampionScheduleReportViewPresentor.super.ctor(self)
end

function YouthArenaThirdChampionScheduleReportViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function YouthArenaThirdChampionScheduleReportViewPresentor:dependWhatResources()
	return {
		"ui/views/youtharenathird/youtharenathirdreportview.prefab"
	}
end

function YouthArenaThirdChampionScheduleReportViewPresentor:buildViews()
	return {
		YouthArenaThirdChampionScheduleReportView.New()
	}
end

return YouthArenaThirdChampionScheduleReportViewPresentor
