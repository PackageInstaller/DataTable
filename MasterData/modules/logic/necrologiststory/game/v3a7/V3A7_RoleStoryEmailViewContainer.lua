-- chunkname: @modules/logic/necrologiststory/game/v3a7/V3A7_RoleStoryEmailViewContainer.lua

module("modules.logic.necrologiststory.game.v3a7.V3A7_RoleStoryEmailViewContainer", package.seeall)

local V3A7_RoleStoryEmailViewContainer = class("V3A7_RoleStoryEmailViewContainer", BaseViewContainer)

function V3A7_RoleStoryEmailViewContainer:buildViews()
	local views = {}

	table.insert(views, V3A7_RoleStoryEmailView.New())

	return views
end

return V3A7_RoleStoryEmailViewContainer
