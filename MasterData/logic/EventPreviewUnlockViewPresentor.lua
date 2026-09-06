-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventpreview/view/EventPreviewUnlockViewPresentor.lua

module("logic.extensions.eventpreview.view.EventPreviewUnlockViewPresentor", package.seeall)

local EventPreviewUnlockViewPresentor = class("EventPreviewUnlockViewPresentor", ViewPresentor)

function EventPreviewUnlockViewPresentor:ctor()
	EventPreviewUnlockViewPresentor.super.ctor(self)
end

function EventPreviewUnlockViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EventPreviewUnlockViewPresentor:dependWhatResources()
	return {
		"ui/views/eventpreview/eventpreviewunlockview.prefab"
	}
end

function EventPreviewUnlockViewPresentor:buildViews()
	return {
		EventPreviewUnlockView.New()
	}
end

return EventPreviewUnlockViewPresentor
