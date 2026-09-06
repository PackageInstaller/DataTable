-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventpreview/view/EventPreviewViewPresentor.lua

module("logic.extensions.eventpreview.view.EventPreviewViewPresentor", package.seeall)

local EventPreviewViewPresentor = class("EventPreviewViewPresentor", ViewPresentor)

function EventPreviewViewPresentor:ctor()
	EventPreviewViewPresentor.super.ctor(self)
end

function EventPreviewViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EventPreviewViewPresentor:dependWhatResources()
	return {
		"ui/views/eventpreview/eventpreviewview.prefab"
	}
end

function EventPreviewViewPresentor:buildViews()
	return {
		EventPreviewView.New()
	}
end

return EventPreviewViewPresentor
