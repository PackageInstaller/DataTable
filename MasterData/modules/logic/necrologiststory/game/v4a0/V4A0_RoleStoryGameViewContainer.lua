-- chunkname: @modules/logic/necrologiststory/game/v4a0/V4A0_RoleStoryGameViewContainer.lua

module("modules.logic.necrologiststory.game.v4a0.V4A0_RoleStoryGameViewContainer", package.seeall)

local V4A0_RoleStoryGameViewContainer = class("V4A0_RoleStoryGameViewContainer", BaseViewContainer)

function V4A0_RoleStoryGameViewContainer:buildViews()
	local views = {}

	self.gameView = V4A0_RoleStoryGameView.New()

	table.insert(views, self.gameView)
	table.insert(views, NecrologistStoryCommonView.New("#go_topright"))
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function V4A0_RoleStoryGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		navView:setCloseCheck(self.checkClose, self)

		return {
			navView
		}
	end
end

function V4A0_RoleStoryGameViewContainer:checkClose()
	if self.gameView:getResultVisible() then
		self.gameView:setResultVisible(false)

		return false
	end

	if self.gameView:trySwitchEnter() then
		return false
	end

	return true
end

return V4A0_RoleStoryGameViewContainer
