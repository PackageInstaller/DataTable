-- chunkname: @modules/logic/versionactivity3_5/lamona/view/LamonaGameViewContainer.lua

module("modules.logic.versionactivity3_5.lamona.view.LamonaGameViewContainer", package.seeall)

local LamonaGameViewContainer = class("LamonaGameViewContainer", BaseViewContainer)

function LamonaGameViewContainer:buildViews()
	local views = {}

	table.insert(views, LamonaGameView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function LamonaGameViewContainer:buildTabViews(tabContainerId)
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

function LamonaGameViewContainer:overrideCloseFunc()
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130PuzzleExit, MsgBoxEnum.BoxType.Yes_No, self.closeFunc, nil, nil, self)
end

function LamonaGameViewContainer:closeFunc()
	LamonaStatHelper.instance:sendOperationInfo(LamonaStatHelper.OperationType.gameExit)
	self:closeThis()
end

return LamonaGameViewContainer
