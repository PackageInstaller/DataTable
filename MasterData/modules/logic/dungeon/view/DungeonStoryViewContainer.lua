-- chunkname: @modules/logic/dungeon/view/DungeonStoryViewContainer.lua

module("modules.logic.dungeon.view.DungeonStoryViewContainer", package.seeall)

local DungeonStoryViewContainer = class("DungeonStoryViewContainer", BaseViewContainer)

function DungeonStoryViewContainer:buildViews()
	local views = {}

	table.insert(views, DungeonStoryView.New())

	return views
end

return DungeonStoryViewContainer
