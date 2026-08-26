-- chunkname: @modules/logic/necrologiststory/game/v3a1/V3A1_RoleStoryFailViewContainer.lua

module("modules.logic.necrologiststory.game.v3a1.V3A1_RoleStoryFailViewContainer", package.seeall)

local V3A1_RoleStoryFailViewContainer = class("V3A1_RoleStoryFailViewContainer", BaseViewContainer)

function V3A1_RoleStoryFailViewContainer:buildViews()
	local views = {}

	table.insert(views, V3A1_RoleStoryFailView.New())

	return views
end

return V3A1_RoleStoryFailViewContainer
