-- chunkname: @modules/logic/versionactivity3_8/echosong/view/V3a8EchoSongGameViewContainer.lua

module("modules.logic.versionactivity3_8.echosong.view.V3a8EchoSongGameViewContainer", package.seeall)

local V3a8EchoSongGameViewContainer = class("V3a8EchoSongGameViewContainer", BaseViewContainer)

function V3a8EchoSongGameViewContainer:buildViews()
	local views = {}

	self._gameSceneView = V3a8EchoSongGameSceneView.New()

	table.insert(views, self._gameSceneView)
	table.insert(views, V3a8EchoSongGameBallView.New())
	table.insert(views, V3a8EchoSongGameView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function V3a8EchoSongGameViewContainer:getGameSceneView()
	return self._gameSceneView
end

function V3a8EchoSongGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		}, 3855001)

		self.navigateView:setOverrideClose(self.overrideCloseFunc, self)

		return {
			self.navigateView
		}
	end
end

function V3a8EchoSongGameViewContainer:overrideCloseFunc()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.EchoSongInGuide) then
		logNormal("V3a8EchoSongGameViewContainer 指引中，不能操作")

		return
	end

	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.PauseGame)
	GameFacade.showMessageBox(MessageBoxIdDefine.EchoSongGameExitConfirm, MsgBoxEnum.BoxType.Yes_No, self.yesClose, self.resumeGame, nil, self, self)
end

function V3a8EchoSongGameViewContainer:yesClose()
	V3a8EchoSongController.instance:sendGameAbort()
	self:closeThis()
end

function V3a8EchoSongGameViewContainer:resumeGame()
	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.ResumeGame)
end

return V3a8EchoSongGameViewContainer
