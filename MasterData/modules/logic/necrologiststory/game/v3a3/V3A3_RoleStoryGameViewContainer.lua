-- chunkname: @modules/logic/necrologiststory/game/v3a3/V3A3_RoleStoryGameViewContainer.lua

module("modules.logic.necrologiststory.game.v3a3.V3A3_RoleStoryGameViewContainer", package.seeall)

local V3A3_RoleStoryGameViewContainer = class("V3A3_RoleStoryGameViewContainer", BaseViewContainer)

function V3A3_RoleStoryGameViewContainer:buildViews()
	local views = {}

	table.insert(views, V3A3_RoleStoryGameView.New())
	table.insert(views, NecrologistStoryCommonView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function V3A3_RoleStoryGameViewContainer:buildTabViews(tabContainerId)
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

return V3A3_RoleStoryGameViewContainer
