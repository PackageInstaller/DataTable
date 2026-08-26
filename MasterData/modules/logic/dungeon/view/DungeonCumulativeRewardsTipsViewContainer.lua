-- chunkname: @modules/logic/dungeon/view/DungeonCumulativeRewardsTipsViewContainer.lua

module("modules.logic.dungeon.view.DungeonCumulativeRewardsTipsViewContainer", package.seeall)

local DungeonCumulativeRewardsTipsViewContainer = class("DungeonCumulativeRewardsTipsViewContainer", BaseViewContainer)

function DungeonCumulativeRewardsTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, DungeonCumulativeRewardsTipsView.New())

	return views
end

return DungeonCumulativeRewardsTipsViewContainer
