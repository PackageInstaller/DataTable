-- chunkname: @modules/logic/dungeon/view/DungeonRewardViewContainer.lua

module("modules.logic.dungeon.view.DungeonRewardViewContainer", package.seeall)

local DungeonRewardViewContainer = class("DungeonRewardViewContainer", BaseViewContainer)

function DungeonRewardViewContainer:buildViews()
	local views = {}

	table.insert(views, DungeonRewardView.New())

	return views
end

function DungeonRewardViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return DungeonRewardViewContainer
