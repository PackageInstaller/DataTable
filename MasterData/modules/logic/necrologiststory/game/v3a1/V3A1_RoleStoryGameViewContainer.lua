-- chunkname: @modules/logic/necrologiststory/game/v3a1/V3A1_RoleStoryGameViewContainer.lua

module("modules.logic.necrologiststory.game.v3a1.V3A1_RoleStoryGameViewContainer", package.seeall)

local V3A1_RoleStoryGameViewContainer = class("V3A1_RoleStoryGameViewContainer", BaseViewContainer)

function V3A1_RoleStoryGameViewContainer:buildViews()
	local views = {}

	table.insert(views, V3A1_RoleStoryGameView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function V3A1_RoleStoryGameViewContainer:buildTabViews(tabContainerId)
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

return V3A1_RoleStoryGameViewContainer
