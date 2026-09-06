-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tcpanduola/PopupBuffViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.PopupBuffViewPresentor", package.seeall)

local PopupBuffViewPresentor = class("PopupBuffViewPresentor", ViewPresentor)

function PopupBuffViewPresentor:ctor()
	PopupBuffViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.PopupBuffViewPriority
end

function PopupBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PopupBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/popupbuffview.prefab"
	}
end

function PopupBuffViewPresentor:buildViews()
	return {
		PopupBuffView.New()
	}
end

return PopupBuffViewPresentor
