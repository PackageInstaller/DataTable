-- chunkname: @modules/logic/dungeon/view/DungeonCumulativeRewardsViewContainer.lua

module("modules.logic.dungeon.view.DungeonCumulativeRewardsViewContainer", package.seeall)

local DungeonCumulativeRewardsViewContainer = class("DungeonCumulativeRewardsViewContainer", BaseViewContainer)

function DungeonCumulativeRewardsViewContainer:buildViews()
	local views = {}

	table.insert(views, DungeonCumulativeRewardsView.New())

	return views
end

return DungeonCumulativeRewardsViewContainer
