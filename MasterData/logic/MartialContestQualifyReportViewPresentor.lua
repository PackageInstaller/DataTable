-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialContestQualifyReportViewPresentor.lua

module("logic.extensions.martialcontest.view.MartialContestQualifyReportViewPresentor", package.seeall)

local MartialContestQualifyReportViewPresentor = class("MartialContestQualifyReportViewPresentor", ViewPresentor)

function MartialContestQualifyReportViewPresentor:ctor()
	MartialContestQualifyReportViewPresentor.super.ctor(self)
end

function MartialContestQualifyReportViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MartialContestQualifyReportViewPresentor:dependWhatResources()
	return {
		"ui/views/martialcontest/martialcontestqualifyreportview.prefab"
	}
end

function MartialContestQualifyReportViewPresentor:buildViews()
	return {
		MartialContestQualifyReportView.New()
	}
end

return MartialContestQualifyReportViewPresentor
