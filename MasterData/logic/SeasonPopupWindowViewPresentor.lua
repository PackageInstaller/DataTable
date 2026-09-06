-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/popup/SeasonPopupWindowViewPresentor.lua

module("logic.extensions.tips.view.SeasonPopupWindowViewPresentor", package.seeall)

local SeasonPopupWindowViewPresentor = class("SeasonPopupWindowViewPresentor", ViewWithGuidePresentor)

function SeasonPopupWindowViewPresentor:ctor()
	SeasonPopupWindowViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.PopupWindowViewPriority
end

function SeasonPopupWindowViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonpopupwindow.prefab"
	}
end

function SeasonPopupWindowViewPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function SeasonPopupWindowViewPresentor:buildViews()
	local views = {}
	local popupWindowView = PopupWindowView.New()

	table.insert(views, popupWindowView)

	return views
end

return SeasonPopupWindowViewPresentor
