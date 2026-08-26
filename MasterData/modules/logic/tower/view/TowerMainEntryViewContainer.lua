-- chunkname: @modules/logic/tower/view/TowerMainEntryViewContainer.lua

module("modules.logic.tower.view.TowerMainEntryViewContainer", package.seeall)

local TowerMainEntryViewContainer = class("TowerMainEntryViewContainer", BaseViewContainer)

function TowerMainEntryViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerMainEntryView.New())

	return views
end

return TowerMainEntryViewContainer
