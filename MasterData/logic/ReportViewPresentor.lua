-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/report/view/ReportViewPresentor.lua

module("logic.extensions.report.view.ReportViewPresentor", package.seeall)

local ReportViewPresentor = class("ReportViewPresentor", ViewPresentor)

function ReportViewPresentor:ctor()
	ReportViewPresentor.super.ctor(self)
end

function ReportViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ReportViewPresentor:dependWhatResources()
	return {
		"ui/views/report/reportview.prefab"
	}
end

function ReportViewPresentor:buildViews()
	return {
		ReportView.New()
	}
end

return ReportViewPresentor
