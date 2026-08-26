-- chunkname: @modules/logic/necrologiststory/game/v3a9/V3A9_RoleStoryResultViewContainer.lua

module("modules.logic.necrologiststory.game.v3a9.V3A9_RoleStoryResultViewContainer", package.seeall)

local V3A9_RoleStoryResultViewContainer = class("V3A9_RoleStoryResultViewContainer", BaseViewContainer)

function V3A9_RoleStoryResultViewContainer:buildViews()
	local views = {}

	table.insert(views, V3A9_RoleStoryResultView.New())

	return views
end

return V3A9_RoleStoryResultViewContainer
