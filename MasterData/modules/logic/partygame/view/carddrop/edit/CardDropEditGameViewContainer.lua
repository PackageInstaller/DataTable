-- chunkname: @modules/logic/partygame/view/carddrop/edit/CardDropEditGameViewContainer.lua

module("modules.logic.partygame.view.carddrop.edit.CardDropEditGameViewContainer", package.seeall)

local CardDropEditGameViewContainer = class("CardDropEditGameViewContainer", BaseViewContainer)

function CardDropEditGameViewContainer:buildViews()
	return {
		CardDropEditGameView.New(),
		TabViewGroup.New(1, "top_left")
	}
end

function CardDropEditGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self._navigateButtonView:setCloseCheck(self.closeCallback, self)

		return {
			self._navigateButtonView
		}
	end
end

function CardDropEditGameViewContainer:closeCallback()
	CardDropGameController.EditMode = false

	PartyGameController.instance:exitGame()

	return false
end

return CardDropEditGameViewContainer
