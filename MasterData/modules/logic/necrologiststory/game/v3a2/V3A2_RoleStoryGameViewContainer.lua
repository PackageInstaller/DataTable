-- chunkname: @modules/logic/necrologiststory/game/v3a2/V3A2_RoleStoryGameViewContainer.lua

module("modules.logic.necrologiststory.game.v3a2.V3A2_RoleStoryGameViewContainer", package.seeall)

local V3A2_RoleStoryGameViewContainer = class("V3A2_RoleStoryGameViewContainer", BaseViewContainer)

function V3A2_RoleStoryGameViewContainer:buildViews()
	local views = {}

	table.insert(views, V3A2_RoleStoryGameView.New())
	table.insert(views, V3A2_RoleStoryEventView.New())
	table.insert(views, NecrologistStoryCommonView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function V3A2_RoleStoryGameViewContainer:buildTabViews(tabContainerId)
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

return V3A2_RoleStoryGameViewContainer
