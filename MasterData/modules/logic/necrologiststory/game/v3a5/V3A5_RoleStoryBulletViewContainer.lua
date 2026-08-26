-- chunkname: @modules/logic/necrologiststory/game/v3a5/V3A5_RoleStoryBulletViewContainer.lua

module("modules.logic.necrologiststory.game.v3a5.V3A5_RoleStoryBulletViewContainer", package.seeall)

local V3A5_RoleStoryBulletViewContainer = class("V3A5_RoleStoryBulletViewContainer", BaseViewContainer)

function V3A5_RoleStoryBulletViewContainer:buildViews()
	local views = {}

	table.insert(views, V3A5_RoleStoryBulletView.New())

	return views
end

return V3A5_RoleStoryBulletViewContainer
