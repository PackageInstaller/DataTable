-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/view/PuzzleMazeDrawViewContainer.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeDrawViewContainer", package.seeall)

local PuzzleMazeDrawViewContainer = class("PuzzleMazeDrawViewContainer", BaseViewContainer)

function PuzzleMazeDrawViewContainer:buildViews()
	self._view = PuzzleMazeDrawView.New()

	return {
		TabViewGroup.New(1, "#go_btns"),
		self._view,
		PuzzleMazeSimulatePlaneComp.New(),
		ZhiXinQuanErTalkView.New()
	}
end

function PuzzleMazeDrawViewContainer:buildTabViews(tabContainerId)
	local navigateButtonsView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	navigateButtonsView:setOverrideClose(self._onNavigateCloseCallBack, self)

	return {
		navigateButtonsView
	}
end

function PuzzleMazeDrawViewContainer:_onNavigateCloseCallBack()
	GameFacade.showMessageBox(MessageBoxIdDefine.Act176PuzzleMazeQuitGame, MsgBoxEnum.BoxType.Yes_No, self._closeView, nil, nil, self)
end

function PuzzleMazeDrawViewContainer:_closeView()
	self._view:stat(PuzzleEnum.GameResult.Abort)
	self:closeThis()
end

return PuzzleMazeDrawViewContainer
