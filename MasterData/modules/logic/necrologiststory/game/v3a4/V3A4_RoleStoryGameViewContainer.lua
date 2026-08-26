-- chunkname: @modules/logic/necrologiststory/game/v3a4/V3A4_RoleStoryGameViewContainer.lua

module("modules.logic.necrologiststory.game.v3a4.V3A4_RoleStoryGameViewContainer", package.seeall)

local V3A4_RoleStoryGameViewContainer = class("V3A4_RoleStoryGameViewContainer", BaseViewContainer)

function V3A4_RoleStoryGameViewContainer:buildViews()
	local views = {}

	table.insert(views, V3A4_RoleStoryGameView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function V3A4_RoleStoryGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			navView
		}
	end
end

return V3A4_RoleStoryGameViewContainer
