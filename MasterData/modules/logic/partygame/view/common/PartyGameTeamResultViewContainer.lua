-- chunkname: @modules/logic/partygame/view/common/PartyGameTeamResultViewContainer.lua

module("modules.logic.partygame.view.common.PartyGameTeamResultViewContainer", package.seeall)

local PartyGameTeamResultViewContainer = class("PartyGameTeamResultViewContainer", BaseViewContainer)

function PartyGameTeamResultViewContainer:buildViews()
	local views = {}

	table.insert(views, PartyGameTeamResultView.New())

	return views
end

return PartyGameTeamResultViewContainer
