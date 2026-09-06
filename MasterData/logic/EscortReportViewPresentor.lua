-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/escort/view/EscortReportViewPresentor.lua

module("logic.extensions.escort.view.EscortReportViewPresentor", package.seeall)

local EscortReportViewPresentor = class("EscortReportViewPresentor", ViewWithGuidePresentor)

function EscortReportViewPresentor:ctor()
	EscortReportViewPresentor.super.ctor(self)
end

function EscortReportViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function EscortReportViewPresentor:dependWhatResources()
	return {
		"ui/views/escort/escortreportview.prefab"
	}
end

function EscortReportViewPresentor:buildViews()
	return {
		EscortReportView.New()
	}
end

return EscortReportViewPresentor
