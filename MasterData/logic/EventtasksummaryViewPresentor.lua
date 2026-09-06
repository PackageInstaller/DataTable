-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/EventtasksummaryViewPresentor.lua

module("logic.extensions.eventtasksummary.view.EventtasksummaryViewPresentor", package.seeall)

local EventtasksummaryViewPresentor = class("EventtasksummaryViewPresentor", ViewPresentor)

function EventtasksummaryViewPresentor:ctor()
	EventtasksummaryViewPresentor.super.ctor(self)
end

function EventtasksummaryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EventtasksummaryViewPresentor:dependWhatResources()
	return {
		"ui/views/eventtasksummary/eventtasksummaryview.prefab"
	}
end

function EventtasksummaryViewPresentor:buildViews()
	return {
		EventtasksummaryView.New()
	}
end

return EventtasksummaryViewPresentor
