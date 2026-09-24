-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/view/game/SpLilyaGameViewContainer.lua

module("modules.logic.versionactivity4_0.sp_lilya.view.game.SpLilyaGameViewContainer", package.seeall)

local SpLilyaGameViewContainer = class("SpLilyaGameViewContainer", BaseViewContainer)

function SpLilyaGameViewContainer:buildViews()
	local views = {}

	table.insert(views, SpLilyaGameView.New())
	table.insert(views, SpLilyaGameScene.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function SpLilyaGameViewContainer:buildTabViews(tabContainerId)
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

function SpLilyaGameViewContainer:overrideCloseFunc()
	SpLilyaGameController.instance:stopGame()
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130PuzzleExit, MsgBoxEnum.BoxType.Yes_No, self.closeFunc, self.cancelFunc, nil, self, self)
end

function SpLilyaGameViewContainer:cancelFunc()
	SpLilyaGameController.instance:startGame()
end

function SpLilyaGameViewContainer:closeFunc()
	SpLilyaGameController.instance:exitGame()
end

return SpLilyaGameViewContainer
