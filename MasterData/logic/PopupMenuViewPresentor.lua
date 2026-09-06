-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/PopupMenuViewPresentor.lua

module("logic.extensions.tips.view.PopupMenuViewPresentor", package.seeall)

local PopupMenuViewPresentor = class("PopupMenuViewPresentor", TipsViewPresentorBase)

function PopupMenuViewPresentor:dependWhatResources()
	return {
		"ui/views/tips/popupmenu.prefab"
	}
end

function PopupMenuViewPresentor:attachToWhichRoot()
	return ViewRootType.TopMost
end

function PopupMenuViewPresentor:buildViews()
	local views = {}
	local popupMenuView = PopupMenuView.New()

	table.insert(views, popupMenuView)

	return views
end

return PopupMenuViewPresentor
