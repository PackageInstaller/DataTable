-- chunkname: @modules/logic/versionactivity3_9/hedone/view/HedoneGameViewContainer.lua

module("modules.logic.versionactivity3_9.hedone.view.HedoneGameViewContainer", package.seeall)

local HedoneGameViewContainer = class("HedoneGameViewContainer", BaseViewContainer)

function HedoneGameViewContainer:buildViews()
	local views = {}

	table.insert(views, HedoneGameScene.New())
	table.insert(views, HedoneGameView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function HedoneGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self.overrideCloseFunc, self)

		return {
			self.navigateView
		}
	end
end

function HedoneGameViewContainer:overrideCloseFunc()
	HedoneGameController.instance:stopGame(HedoneGameEnum.StopSource.ExitDialog)
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130PuzzleExit, MsgBoxEnum.BoxType.Yes_No, self.closeFunc, self.cancelFunc, nil, self, self)
end

function HedoneGameViewContainer:cancelFunc()
	HedoneGameController.instance:resumeGame(HedoneGameEnum.StopSource.ExitDialog)
end

function HedoneGameViewContainer:closeFunc()
	HedoneStatHelper.sendSettleInfo(HedoneStatHelper.OperationType.ExitGame, HedoneStatHelper.GameResultStat.Exit)
	HedoneGameModel.instance:setGameEnd()
	self:closeThis()
end

return HedoneGameViewContainer
