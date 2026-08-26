-- chunkname: @modules/logic/partygame/view/common/PartyGameRewardGuideViewContainer.lua

module("modules.logic.partygame.view.common.PartyGameRewardGuideViewContainer", package.seeall)

local PartyGameRewardGuideViewContainer = class("PartyGameRewardGuideViewContainer", BaseViewContainer)

function PartyGameRewardGuideViewContainer:buildViews()
	local views = {}

	table.insert(views, PartyGameRewardGuideView.New())

	return views
end

return PartyGameRewardGuideViewContainer
