-- chunkname: @modules/logic/dungeon/view/map/DungeonRecheckElementsViewContainer.lua

module("modules.logic.dungeon.view.map.DungeonRecheckElementsViewContainer", package.seeall)

local DungeonRecheckElementsViewContainer = class("DungeonRecheckElementsViewContainer", BaseViewContainer)

function DungeonRecheckElementsViewContainer:buildViews()
	local views = {}

	table.insert(views, DungeonRecheckElementsView.New())

	return views
end

return DungeonRecheckElementsViewContainer
