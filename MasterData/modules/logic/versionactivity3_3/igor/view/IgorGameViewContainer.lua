-- chunkname: @modules/logic/versionactivity3_3/igor/view/IgorGameViewContainer.lua

module("modules.logic.versionactivity3_3.igor.view.IgorGameViewContainer", package.seeall)

local IgorGameViewContainer = class("IgorGameViewContainer", BaseViewContainer)

function IgorGameViewContainer:buildViews()
	local views = {}

	table.insert(views, IgorGameView.New())
	table.insert(views, IgorGameEntityView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function IgorGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			self.navigateView
		}
	end
end

function IgorGameViewContainer:_overrideCloseFunc()
	IgorModel.instance:setPause(true)
	GameFacade.showMessageBox(MessageBoxIdDefine.IgorGameExitConfirm, MsgBoxEnum.BoxType.Yes_No, self.exitGame, self.cancelExitGame, nil, self, self)
end

function IgorGameViewContainer:exitGame()
	IgorController.instance:statOperation(IgorEnum.StatOperationType.Exit)
	self:closeThis()
end

function IgorGameViewContainer:cancelExitGame()
	IgorModel.instance:setPause(false)
end

function IgorGameViewContainer:playOpenTransition()
	local param = {}

	param.noBlock = true
	param.duration = 2.5

	IgorGameViewContainer.super.playOpenTransition(self, param)
end

function IgorGameViewContainer:playCloseTransition()
	self:onPlayCloseTransitionFinish()
end

return IgorGameViewContainer
