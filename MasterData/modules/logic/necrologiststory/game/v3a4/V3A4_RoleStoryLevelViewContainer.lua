-- chunkname: @modules/logic/necrologiststory/game/v3a4/V3A4_RoleStoryLevelViewContainer.lua

module("modules.logic.necrologiststory.game.v3a4.V3A4_RoleStoryLevelViewContainer", package.seeall)

local V3A4_RoleStoryLevelViewContainer = class("V3A4_RoleStoryLevelViewContainer", BaseViewContainer)

function V3A4_RoleStoryLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, V3A4_RoleStoryLevelView.New())
	table.insert(views, NecrologistStoryCommonView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function V3A4_RoleStoryLevelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			navView
		}
	end
end

return V3A4_RoleStoryLevelViewContainer
