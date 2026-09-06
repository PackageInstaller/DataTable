-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/ScuffleReportViewPresentor.lua

module("logic.extensions.scuffle.view.ScuffleReportViewPresentor", package.seeall)

local ScuffleReportViewPresentor = class("ScuffleReportViewPresentor", ViewPresentor)

function ScuffleReportViewPresentor:ctor()
	ScuffleReportViewPresentor.super.ctor(self)
end

function ScuffleReportViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScuffleReportViewPresentor:dependWhatResources()
	return {
		"ui/views/scuffle/scufflereportview.prefab"
	}
end

function ScuffleReportViewPresentor:buildViews()
	return {
		ScuffleReportView.New()
	}
end

return ScuffleReportViewPresentor
