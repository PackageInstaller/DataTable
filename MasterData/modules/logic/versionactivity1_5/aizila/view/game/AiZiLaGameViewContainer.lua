-- chunkname: @modules/logic/versionactivity1_5/aizila/view/game/AiZiLaGameViewContainer.lua

module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameViewContainer", package.seeall)

local AiZiLaGameViewContainer = class("AiZiLaGameViewContainer", BaseViewContainer)

function AiZiLaGameViewContainer:buildViews()
	local views = {}

	self._gameView = AiZiLaGameView.New()

	table.insert(views, self._gameView)
	table.insert(views, TabViewGroup.New(1, "#go_BackBtns"))

	return views
end

function AiZiLaGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self._navigateButtonsView:setOverrideClose(self._overrideCloseFunc, self)
		self._navigateButtonsView:setHelpId(HelpEnum.HelpId.Role1_5AiziLa)

		return {
			self._navigateButtonsView
		}
	end
end

function AiZiLaGameViewContainer:_overrideCloseFunc()
	if self._gameView:isLockOp() then
		return
	end

	AiZiLaGameController.instance:exitGame()
end

function AiZiLaGameViewContainer:needPlayRiseAnim()
	return self._gameView:needPlayRiseAnim()
end

function AiZiLaGameViewContainer:startViewOpenBlock()
	return
end

return AiZiLaGameViewContainer
