-- chunkname: @modules/logic/necrologiststory/game/v3a5/V3A5_RoleStoryGameViewContainer.lua

module("modules.logic.necrologiststory.game.v3a5.V3A5_RoleStoryGameViewContainer", package.seeall)

local V3A5_RoleStoryGameViewContainer = class("V3A5_RoleStoryGameViewContainer", BaseViewContainer)

function V3A5_RoleStoryGameViewContainer:buildViews()
	local views = {}

	self.gameView = V3A5_RoleStoryGameView.New()

	table.insert(views, self.gameView)
	table.insert(views, V3A5_RoleStoryGameAnimView.New())
	table.insert(views, NecrologistStoryCommonView.New("#go_topright"))
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function V3A5_RoleStoryGameViewContainer:buildTabViews(tabContainerId)
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

function V3A5_RoleStoryGameViewContainer:onCloseOverride()
	if self.gameView:backEpisodeView() then
		return
	end

	self:closeThis()
end

return V3A5_RoleStoryGameViewContainer
