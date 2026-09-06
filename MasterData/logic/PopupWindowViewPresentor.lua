-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/PopupWindowViewPresentor.lua

module("logic.extensions.tips.view.PopupWindowViewPresentor", package.seeall)

local PopupWindowViewPresentor = class("PopupWindowViewPresentor", ViewWithGuidePresentor)

function PopupWindowViewPresentor:ctor()
	PopupWindowViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.PopupWindowViewPriority
end

function PopupWindowViewPresentor:dependWhatResources()
	return {
		"ui/views/tips/popupwindow_new.prefab"
	}
end

function PopupWindowViewPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function PopupWindowViewPresentor:buildViews()
	local views = {}
	local popupWindowView = PopupWindowView.New()

	table.insert(views, popupWindowView)

	return views
end

return PopupWindowViewPresentor
