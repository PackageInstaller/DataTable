-- chunkname: @modules/logic/necrologiststory/game/v3a1/V3A1_RoleStorySuccessViewContainer.lua

module("modules.logic.necrologiststory.game.v3a1.V3A1_RoleStorySuccessViewContainer", package.seeall)

local V3A1_RoleStorySuccessViewContainer = class("V3A1_RoleStorySuccessViewContainer", BaseViewContainer)

function V3A1_RoleStorySuccessViewContainer:buildViews()
	local views = {}

	table.insert(views, V3A1_RoleStorySuccessView.New())

	return views
end

return V3A1_RoleStorySuccessViewContainer
