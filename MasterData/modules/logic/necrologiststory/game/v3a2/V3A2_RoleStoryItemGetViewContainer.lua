-- chunkname: @modules/logic/necrologiststory/game/v3a2/V3A2_RoleStoryItemGetViewContainer.lua

module("modules.logic.necrologiststory.game.v3a2.V3A2_RoleStoryItemGetViewContainer", package.seeall)

local V3A2_RoleStoryItemGetViewContainer = class("V3A2_RoleStoryItemGetViewContainer", BaseViewContainer)

function V3A2_RoleStoryItemGetViewContainer:buildViews()
	local views = {}

	table.insert(views, V3A2_RoleStoryItemGetView.New())

	return views
end

return V3A2_RoleStoryItemGetViewContainer
