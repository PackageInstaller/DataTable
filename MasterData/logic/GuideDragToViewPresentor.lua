-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideDragToViewPresentor.lua

module("logic.extensions.guide.view.GuideDragToViewPresentor", package.seeall)

local GuideDragToViewPresentor = class("GuideDragToViewPresentor", GuideViewPresentor)

function GuideDragToViewPresentor:dependWhatResources()
	return {
		"ui/views/guide/guide_drag_to.prefab"
	}
end

function GuideDragToViewPresentor:buildViews()
	local views = {}
	local guideDragToView = GuideDragToView.New()

	table.insert(views, guideDragToView)

	return views
end

return GuideDragToViewPresentor
