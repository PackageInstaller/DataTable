-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/popupmenu/view/CommonPopupMenuViewPresentor.lua

module("logic.extensions.common.popupmenu.view.CommonPopupMenuViewPresentor", package.seeall)

local CommonPopupMenuViewPresentor = class("CommonPopupMenuViewPresentor", ViewWithGuidePresentor)

function CommonPopupMenuViewPresentor:ctor()
	CommonPopupMenuViewPresentor.super.ctor(self)
end

function CommonPopupMenuViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function CommonPopupMenuViewPresentor:dependWhatResources()
	return {
		"ui/views/common/popupmenu.prefab"
	}
end

function CommonPopupMenuViewPresentor:buildViews()
	local views = {}
	local view = CommonPopupMenuView.New()

	table.insert(views, view)

	return views
end

return CommonPopupMenuViewPresentor
