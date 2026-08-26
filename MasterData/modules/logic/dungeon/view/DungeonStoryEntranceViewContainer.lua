-- chunkname: @modules/logic/dungeon/view/DungeonStoryEntranceViewContainer.lua

module("modules.logic.dungeon.view.DungeonStoryEntranceViewContainer", package.seeall)

local DungeonStoryEntranceViewContainer = class("DungeonStoryEntranceViewContainer", BaseViewContainer)

function DungeonStoryEntranceViewContainer:buildViews()
	local views = {}

	table.insert(views, DungeonStoryEntranceView.New())

	return views
end

return DungeonStoryEntranceViewContainer
