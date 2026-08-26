-- chunkname: @modules/logic/necrologiststory/game/v3a7/V3A7_RoleStoryGameViewContainer.lua

module("modules.logic.necrologiststory.game.v3a7.V3A7_RoleStoryGameViewContainer", package.seeall)

local V3A7_RoleStoryGameViewContainer = class("V3A7_RoleStoryGameViewContainer", BaseViewContainer)

function V3A7_RoleStoryGameViewContainer:buildViews()
	local views = {}

	table.insert(views, V3A7_RoleStoryGameView.New())
	table.insert(views, NecrologistStoryCommonView.New("#go_topright"))
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function V3A7_RoleStoryGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		navView:setOverrideClose(self.onCloseOverride, self)

		return {
			navView
		}
	end
end

function V3A7_RoleStoryGameViewContainer:onCloseOverride()
	self:closeThis()
end

return V3A7_RoleStoryGameViewContainer
