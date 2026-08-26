-- chunkname: @modules/logic/versionactivity2_7/coopergarland/view/CooperGarlandGameViewContainer.lua

module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandGameViewContainer", package.seeall)

local CooperGarlandGameViewContainer = class("CooperGarlandGameViewContainer", BaseViewContainer)

function CooperGarlandGameViewContainer:buildViews()
	local views = {}

	table.insert(views, CooperGarlandGameView.New())
	table.insert(views, CooperGarlandGameScene.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function CooperGarlandGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self.overrideClose, self)

		return {
			self.navigateView
		}
	end
end

function CooperGarlandGameViewContainer:overrideClose()
	local isRemoveMode = CooperGarlandGameModel.instance:getIsRemoveMode()

	if isRemoveMode then
		CooperGarlandController.instance:changeRemoveMode()
	else
		CooperGarlandController.instance:setStopGame(true)
		GameFacade.showMessageBox(MessageBoxIdDefine.CooperGarlandExitGame, MsgBoxEnum.BoxType.Yes_No, self._confirmExit, self._closeMessBox, nil, self, self)
	end
end

function CooperGarlandGameViewContainer:_confirmExit()
	CooperGarlandStatHelper.instance:sendGameExit(ViewName.CooperGarlandGameView)
	self.navigateView:_reallyClose()
	CooperGarlandController.instance:exitGame()
end

function CooperGarlandGameViewContainer:_closeMessBox()
	CooperGarlandController.instance:setStopGame(false)
end

return CooperGarlandGameViewContainer
