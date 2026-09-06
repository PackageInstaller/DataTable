-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialContestScoreReportDetailViewPresentor.lua

module("logic.extensions.martialcontest.view.MartialContestScoreReportDetailViewPresentor", package.seeall)

local MartialContestScoreReportDetailViewPresentor = class("MartialContestScoreReportDetailViewPresentor", ViewPresentor)

function MartialContestScoreReportDetailViewPresentor:ctor()
	MartialContestScoreReportDetailViewPresentor.super.ctor(self)
end

function MartialContestScoreReportDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MartialContestScoreReportDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/martialcontest/martialcontestscorereportdetailview.prefab"
	}
end

function MartialContestScoreReportDetailViewPresentor:buildViews()
	return {
		MartialContestScoreReportDetailView.New()
	}
end

return MartialContestScoreReportDetailViewPresentor
