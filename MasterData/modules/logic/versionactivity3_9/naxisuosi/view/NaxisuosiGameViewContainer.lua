-- chunkname: @modules/logic/versionactivity3_9/naxisuosi/view/NaxisuosiGameViewContainer.lua

module("modules.logic.versionactivity3_9.naxisuosi.view.NaxisuosiGameViewContainer", package.seeall)

local NaxisuosiGameViewContainer = class("NaxisuosiGameViewContainer", BaseViewContainer)

function NaxisuosiGameViewContainer:buildViews()
	local views = {}

	table.insert(views, NaxisuosiGameView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function NaxisuosiGameViewContainer:buildTabViews(tabContainerId)
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

function NaxisuosiGameViewContainer:overrideCloseFunc()
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130PuzzleExit, MsgBoxEnum.BoxType.Yes_No, self.closeFunc, self.cancelFunc, nil, self, self)
end

function NaxisuosiGameViewContainer:cancelFunc()
	return
end

function NaxisuosiGameViewContainer:closeFunc()
	NaxisuosiController.instance:endGame()
end

return NaxisuosiGameViewContainer
