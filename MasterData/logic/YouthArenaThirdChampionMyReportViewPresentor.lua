-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdChampionMyReportViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdChampionMyReportViewPresentor", package.seeall)

local YouthArenaThirdChampionMyReportViewPresentor = class("YouthArenaThirdChampionMyReportViewPresentor", ViewPresentor)

function YouthArenaThirdChampionMyReportViewPresentor:ctor()
	YouthArenaThirdChampionMyReportViewPresentor.super.ctor(self)
end

function YouthArenaThirdChampionMyReportViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function YouthArenaThirdChampionMyReportViewPresentor:dependWhatResources()
	return {
		"ui/views/youtharenathird/youtharenathirdreportview.prefab"
	}
end

function YouthArenaThirdChampionMyReportViewPresentor:buildViews()
	return {
		YouthArenaThirdChampionMyReportView.New()
	}
end

return YouthArenaThirdChampionMyReportViewPresentor
