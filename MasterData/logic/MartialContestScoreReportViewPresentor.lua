-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialContestScoreReportViewPresentor.lua

module("logic.extensions.martialcontest.view.MartialContestScoreReportViewPresentor", package.seeall)

local MartialContestScoreReportViewPresentor = class("MartialContestScoreReportViewPresentor", ViewPresentor)

function MartialContestScoreReportViewPresentor:ctor()
	MartialContestScoreReportViewPresentor.super.ctor(self)
end

function MartialContestScoreReportViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MartialContestScoreReportViewPresentor:dependWhatResources()
	return {
		"ui/views/martialcontest/martialcontestscorereportview.prefab"
	}
end

function MartialContestScoreReportViewPresentor:buildViews()
	return {
		MartialContestScoreReportView.New()
	}
end

return MartialContestScoreReportViewPresentor
