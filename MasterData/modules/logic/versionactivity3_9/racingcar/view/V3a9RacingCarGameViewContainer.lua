-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/V3a9RacingCarGameViewContainer.lua

module("modules.logic.versionactivity3_9.racingcar.view.V3a9RacingCarGameViewContainer", package.seeall)

local V3a9RacingCarGameViewContainer = class("V3a9RacingCarGameViewContainer", BaseViewContainer)

function V3a9RacingCarGameViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a9RacingCarGameView.New())
	table.insert(views, V3a9RacingCarGameCoinView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_lefttop"))

	return views
end

function V3a9RacingCarGameViewContainer:buildTabViews(tabContainerId)
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

function V3a9RacingCarGameViewContainer:overrideCloseFunc()
	if V3a9RacingCarModel.instance:getPauseChangeLane() then
		logNormal("V3a9RacingCarGameViewContainer 引导中，不给退出")

		return
	end

	V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.OnPauseGame, true)
	GameFacade.showMessageBox(MessageBoxIdDefine.EchoSongGameExitConfirm, MsgBoxEnum.BoxType.Yes_No, self.yesClose, self.resumeGame, nil, self, self)
end

function V3a9RacingCarGameViewContainer:yesClose()
	V3a9RacingCarController.instance:sendGameExitStat()
	self:closeThis()
	EnterActivityViewOnExitFightSceneHelper.enterRacingCar()
end

function V3a9RacingCarGameViewContainer:resumeGame()
	V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.OnPauseGame, false)
end

return V3a9RacingCarGameViewContainer
