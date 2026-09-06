-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/PopupWindowNoGuideViewPresentor.lua

module("logic.extensions.tips.view.PopupWindowNoGuideViewPresentor", package.seeall)

local PopupWindowNoGuideViewPresentor = class("PopupWindowNoGuideViewPresentor", ViewPresentor)

function PopupWindowNoGuideViewPresentor:ctor()
	PopupWindowNoGuideViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.PopupWindowViewPriority
end

function PopupWindowNoGuideViewPresentor:dependWhatResources()
	return {
		"ui/views/tips/popupwindow_new.prefab"
	}
end

function PopupWindowNoGuideViewPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function PopupWindowNoGuideViewPresentor:buildViews()
	local views = {}
	local popupWindowView = PopupWindowView.New()

	table.insert(views, popupWindowView)

	return views
end

return PopupWindowNoGuideViewPresentor
