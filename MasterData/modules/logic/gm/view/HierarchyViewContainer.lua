-- chunkname: @modules/logic/gm/view/HierarchyViewContainer.lua

module("modules.logic.gm.view.HierarchyViewContainer", package.seeall)

local HierarchyViewContainer = class("HierarchyViewContainer", BaseViewContainer)

function HierarchyViewContainer:buildViews()
	local views = {}

	table.insert(views, HierarchyView.New())

	return views
end

return HierarchyViewContainer
