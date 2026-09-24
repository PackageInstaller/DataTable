-- chunkname: @modules/logic/versionactivity4_0/deleike/view/DeleikeGameViewContainer.lua

module("modules.logic.versionactivity4_0.deleike.view.DeleikeGameViewContainer", package.seeall)

local DeleikeGameViewContainer = class("DeleikeGameViewContainer", BaseViewContainer)

function DeleikeGameViewContainer:buildViews()
	local views = {}

	table.insert(views, DeleikeGameScene.New())
	table.insert(views, DeleikeGameView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function DeleikeGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		}, 4001001)

		self.navigateView:setOverrideClose(self.overrideCloseFunc, self)

		return {
			self.navigateView
		}
	end
end

function DeleikeGameViewContainer:overrideCloseFunc()
	DeleikeGameMgr.instance:setInputLocked(true)
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130PuzzleExit, MsgBoxEnum.BoxType.Yes_No, self.closeFunc, self.cancelFunc, nil, self, self)
end

function DeleikeGameViewContainer:closeFunc()
	DeleikeController.instance:closeGameView(true)
end

function DeleikeGameViewContainer:cancelFunc()
	DeleikeGameMgr.instance:setInputLocked(false)
end

return DeleikeGameViewContainer
