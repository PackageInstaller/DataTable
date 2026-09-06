-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceReportDetailPresentor.lua

module("logic.extensions.rankrace.view.RankRaceReportDetailPresentor", package.seeall)

local RankRaceReportDetailPresentor = class("RankRaceReportDetailPresentor", ViewPresentor)

function RankRaceReportDetailPresentor:ctor()
	RankRaceReportDetailPresentor.super.ctor(self)
end

function RankRaceReportDetailPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RankRaceReportDetailPresentor:dependWhatResources()
	return {
		"ui/views/rankrace/rankracereportdetailview.prefab"
	}
end

function RankRaceReportDetailPresentor:buildViews()
	return {
		RankRaceReportDetailView.New()
	}
end

return RankRaceReportDetailPresentor
