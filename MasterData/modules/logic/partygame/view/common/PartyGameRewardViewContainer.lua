-- chunkname: @modules/logic/partygame/view/common/PartyGameRewardViewContainer.lua

module("modules.logic.partygame.view.common.PartyGameRewardViewContainer", package.seeall)

local PartyGameRewardViewContainer = class("PartyGameRewardViewContainer", BaseViewContainer)

function PartyGameRewardViewContainer:buildViews()
	local views = {}

	table.insert(views, PartyGameRewardView.New())

	return views
end

return PartyGameRewardViewContainer
