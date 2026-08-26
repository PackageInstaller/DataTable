-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/guessgame/GuessGamePlayViewContainer.lua

module("modules.logic.versionactivity3_7.anniversary3.view.guessgame.GuessGamePlayViewContainer", package.seeall)

local GuessGamePlayViewContainer = class("GuessGamePlayViewContainer", BaseViewContainer)

function GuessGamePlayViewContainer:buildViews()
	return {
		GuessGamePlayView.New(),
		TabViewGroup.New(1, "#go_lefttop"),
		TabViewGroup.New(2, "#go_npcs")
	}
end

function GuessGamePlayViewContainer:buildTabViews(tabContainerId)
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
			GuessGamePlayNpcsView.New()
		}
	end
end

function GuessGamePlayViewContainer:closeCallback()
	GameFacade.showMessageBox(MessageBoxIdDefine.GuessGameExitGame, MsgBoxEnum.BoxType.Yes_No, self.onClickYes, nil, nil, self, nil)
end

function GuessGamePlayViewContainer:onClickYes()
	GuessGameController.instance:exitGame()
end

return GuessGamePlayViewContainer
