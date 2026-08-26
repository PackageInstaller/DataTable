-- chunkname: @modules/logic/necrologiststory/game/v3a2/V3A2_RoleStoryItemTipsViewContainer.lua

module("modules.logic.necrologiststory.game.v3a2.V3A2_RoleStoryItemTipsViewContainer", package.seeall)

local V3A2_RoleStoryItemTipsViewContainer = class("V3A2_RoleStoryItemTipsViewContainer", BaseViewContainer)

function V3A2_RoleStoryItemTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, V3A2_RoleStoryItemTipsView.New())

	return views
end

return V3A2_RoleStoryItemTipsViewContainer
