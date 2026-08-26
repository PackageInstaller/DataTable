-- chunkname: @modules/logic/versionactivity1_5/aizila/view/game/AiZiLaGameStateViewContainer.lua

module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameStateViewContainer", package.seeall)

local AiZiLaGameStateViewContainer = class("AiZiLaGameStateViewContainer", BaseViewContainer)

function AiZiLaGameStateViewContainer:buildViews()
	local views = {}

	self._gameStateView = AiZiLaGameStateView.New()

	table.insert(views, self._gameStateView)

	return views
end

function AiZiLaGameStateViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self._navigateButtonsView
		}
	end
end

return AiZiLaGameStateViewContainer
