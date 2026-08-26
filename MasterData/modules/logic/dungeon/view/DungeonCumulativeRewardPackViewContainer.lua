-- chunkname: @modules/logic/dungeon/view/DungeonCumulativeRewardPackViewContainer.lua

module("modules.logic.dungeon.view.DungeonCumulativeRewardPackViewContainer", package.seeall)

local DungeonCumulativeRewardPackViewContainer = class("DungeonCumulativeRewardPackViewContainer", BaseViewContainer)

function DungeonCumulativeRewardPackViewContainer:buildViews()
	local views = {}

	table.insert(views, DungeonCumulativeRewardPackView.New())

	return views
end

return DungeonCumulativeRewardPackViewContainer
