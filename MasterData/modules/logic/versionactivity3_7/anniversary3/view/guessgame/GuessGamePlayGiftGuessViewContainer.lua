-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/guessgame/GuessGamePlayGiftGuessViewContainer.lua

module("modules.logic.versionactivity3_7.anniversary3.view.guessgame.GuessGamePlayGiftGuessViewContainer", package.seeall)

local GuessGamePlayGiftGuessViewContainer = class("GuessGamePlayGiftGuessViewContainer", BaseViewContainer)

function GuessGamePlayGiftGuessViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "#go_lefttop"),
		TabViewGroup.New(2, "#go_righttop"),
		TabViewGroup.New(3, "#go_npcs"),
		GuessGamePlayGiftGuessView.New()
	}
end

function GuessGamePlayGiftGuessViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateButtonView:setCloseCheck(self.closeCallback, self)

		return {
			self.navigateButtonView
		}
	elseif tabContainerId == 2 then
		return {
			GuessGamePlayTaskTipView.New()
		}
	elseif tabContainerId == 3 then
		return {
			GuessGamePlayNpcSelectGiftView.New()
		}
	end
end

function GuessGamePlayGiftGuessViewContainer:closeCallback()
	GameFacade.showMessageBox(MessageBoxIdDefine.GuessGameExitGame, MsgBoxEnum.BoxType.Yes_No, self.onClickYes, nil, nil, self, nil)
end

function GuessGamePlayGiftGuessViewContainer:onClickYes()
	GuessGameController.instance:exitGame()
end

return GuessGamePlayGiftGuessViewContainer
