-- chunkname: @modules/logic/partygame/view/common/PartyGameTeamResultGuideViewContainer.lua

module("modules.logic.partygame.view.common.PartyGameTeamResultGuideViewContainer", package.seeall)

local PartyGameTeamResultGuideViewContainer = class("PartyGameTeamResultGuideViewContainer", BaseViewContainer)

function PartyGameTeamResultGuideViewContainer:buildViews()
	local views = {}

	table.insert(views, PartyGameTeamResultGuideView.New())

	return views
end

return PartyGameTeamResultGuideViewContainer
