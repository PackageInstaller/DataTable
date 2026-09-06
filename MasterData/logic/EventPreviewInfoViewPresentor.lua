-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventpreview/view/EventPreviewInfoViewPresentor.lua

module("logic.extensions.eventpreview.view.EventPreviewInfoViewPresentor", package.seeall)

local EventPreviewInfoViewPresentor = class("EventPreviewInfoViewPresentor", ViewPresentor)

function EventPreviewInfoViewPresentor:ctor()
	EventPreviewInfoViewPresentor.super.ctor(self)
end

function EventPreviewInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EventPreviewInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/eventpreview/eventpreviewinfoview.prefab"
	}
end

function EventPreviewInfoViewPresentor:buildViews()
	return {
		EventPreviewInfoView.New()
	}
end

return EventPreviewInfoViewPresentor
