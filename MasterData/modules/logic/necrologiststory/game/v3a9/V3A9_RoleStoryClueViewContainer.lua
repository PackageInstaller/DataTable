-- chunkname: @modules/logic/necrologiststory/game/v3a9/V3A9_RoleStoryClueViewContainer.lua

module("modules.logic.necrologiststory.game.v3a9.V3A9_RoleStoryClueViewContainer", package.seeall)

local V3A9_RoleStoryClueViewContainer = class("V3A9_RoleStoryClueViewContainer", BaseViewContainer)

function V3A9_RoleStoryClueViewContainer:buildViews()
	local views = {}

	table.insert(views, V3A9_RoleStoryClueView.New())

	return views
end

return V3A9_RoleStoryClueViewContainer
