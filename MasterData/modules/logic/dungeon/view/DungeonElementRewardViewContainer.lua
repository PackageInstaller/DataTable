-- chunkname: @modules/logic/dungeon/view/DungeonElementRewardViewContainer.lua

module("modules.logic.dungeon.view.DungeonElementRewardViewContainer", package.seeall)

local DungeonElementRewardViewContainer = class("DungeonElementRewardViewContainer", BaseViewContainer)

function DungeonElementRewardViewContainer:buildViews()
	local views = {}

	table.insert(views, DungeonElementRewardView.New())

	return views
end

function DungeonElementRewardViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return DungeonElementRewardViewContainer
