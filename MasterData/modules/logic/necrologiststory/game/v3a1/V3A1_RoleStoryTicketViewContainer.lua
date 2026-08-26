-- chunkname: @modules/logic/necrologiststory/game/v3a1/V3A1_RoleStoryTicketViewContainer.lua

module("modules.logic.necrologiststory.game.v3a1.V3A1_RoleStoryTicketViewContainer", package.seeall)

local V3A1_RoleStoryTicketViewContainer = class("V3A1_RoleStoryTicketViewContainer", BaseViewContainer)

function V3A1_RoleStoryTicketViewContainer:buildViews()
	local views = {}

	table.insert(views, V3A1_RoleStoryTicketView.New())

	return views
end

return V3A1_RoleStoryTicketViewContainer
