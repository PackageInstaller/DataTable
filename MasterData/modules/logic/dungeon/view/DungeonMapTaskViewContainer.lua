-- chunkname: @modules/logic/dungeon/view/DungeonMapTaskViewContainer.lua

module("modules.logic.dungeon.view.DungeonMapTaskViewContainer", package.seeall)

local DungeonMapTaskViewContainer = class("DungeonMapTaskViewContainer", BaseViewContainer)

function DungeonMapTaskViewContainer:buildViews()
	local views = {}

	table.insert(views, DungeonMapTaskView.New())

	return views
end

return DungeonMapTaskViewContainer
