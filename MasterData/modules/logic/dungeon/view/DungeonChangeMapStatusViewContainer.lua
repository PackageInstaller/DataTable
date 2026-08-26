-- chunkname: @modules/logic/dungeon/view/DungeonChangeMapStatusViewContainer.lua

module("modules.logic.dungeon.view.DungeonChangeMapStatusViewContainer", package.seeall)

local DungeonChangeMapStatusViewContainer = class("DungeonChangeMapStatusViewContainer", BaseViewContainer)

function DungeonChangeMapStatusViewContainer:buildViews()
	local views = {}

	table.insert(views, DungeonChangeMapStatusView.New())

	return views
end

return DungeonChangeMapStatusViewContainer
