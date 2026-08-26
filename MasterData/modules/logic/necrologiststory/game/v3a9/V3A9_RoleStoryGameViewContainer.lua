-- chunkname: @modules/logic/necrologiststory/game/v3a9/V3A9_RoleStoryGameViewContainer.lua

module("modules.logic.necrologiststory.game.v3a9.V3A9_RoleStoryGameViewContainer", package.seeall)

local V3A9_RoleStoryGameViewContainer = class("V3A9_RoleStoryGameViewContainer", BaseViewContainer)

function V3A9_RoleStoryGameViewContainer:buildViews()
	local views = {}

	table.insert(views, V3A9_RoleStoryGameView.New())
	table.insert(views, NecrologistStoryCommonView.New("#go_topright"))
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function V3A9_RoleStoryGameViewContainer:buildTabViews(tabContainerId)
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

return V3A9_RoleStoryGameViewContainer
