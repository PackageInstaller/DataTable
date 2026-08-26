-- chunkname: @modules/logic/versionactivity3_0/karong/view/KaRongDrawViewContainer.lua

module("modules.logic.versionactivity3_0.karong.view.KaRongDrawViewContainer", package.seeall)

local KaRongDrawViewContainer = class("KaRongDrawViewContainer", BaseViewContainer)

function KaRongDrawViewContainer:buildViews()
	self._view = KaRongDrawView.New()

	return {
		TabViewGroup.New(1, "#go_btns"),
		self._view,
		KaRongTalkView.New()
	}
end

function KaRongDrawViewContainer:buildTabViews(tabContainerId)
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

function KaRongDrawViewContainer:_onNavigateCloseCallBack()
	GameFacade.showMessageBox(MessageBoxIdDefine.Act176PuzzleMazeQuitGame, MsgBoxEnum.BoxType.Yes_No, self._closeView, nil, nil, self)
end

function KaRongDrawViewContainer:_closeView()
	self._view:stat(KaRongDrawEnum.GameResult.Abort)
	self:closeThis()
end

return KaRongDrawViewContainer
