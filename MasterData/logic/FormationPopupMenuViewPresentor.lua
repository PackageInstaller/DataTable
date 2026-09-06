-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/FormationPopupMenuViewPresentor.lua

module("logic.extensions.common.popupmenu.view.FormationPopupMenuViewPresentor", package.seeall)

local FormationPopupMenuViewPresentor = class("FormationPopupMenuViewPresentor", ViewWithGuidePresentor)

function FormationPopupMenuViewPresentor:ctor()
	FormationPopupMenuViewPresentor.super.ctor(self)
end

function FormationPopupMenuViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function FormationPopupMenuViewPresentor:dependWhatResources()
	return {
		"ui/views/formation/fmtpopupmenu.prefab"
	}
end

function FormationPopupMenuViewPresentor:buildViews()
	local views = {}
	local view = FormationPopupMenuView.New()

	table.insert(views, view)

	return views
end

return FormationPopupMenuViewPresentor
