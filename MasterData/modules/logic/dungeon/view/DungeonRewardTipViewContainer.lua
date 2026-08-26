-- chunkname: @modules/logic/dungeon/view/DungeonRewardTipViewContainer.lua

module("modules.logic.dungeon.view.DungeonRewardTipViewContainer", package.seeall)

local DungeonRewardTipViewContainer = class("DungeonRewardTipViewContainer", BaseViewContainer)

function DungeonRewardTipViewContainer:buildViews()
	local views = {}

	table.insert(views, DungeonRewardTipView.New())

	return views
end

function DungeonRewardTipViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return DungeonRewardTipViewContainer
