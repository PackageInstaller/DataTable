-- chunkname: @modules/logic/activity/view/chessmap/ActivityChessGameContainer.lua

module("modules.logic.activity.view.chessmap.ActivityChessGameContainer", package.seeall)

local ActivityChessGameContainer = class("ActivityChessGameContainer", BaseViewContainer)

function ActivityChessGameContainer:buildViews()
	local views = {}

	table.insert(views, ActivityChessGameScene.New())
	table.insert(views, ActivityChessGameMain.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function ActivityChessGameContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.ChessGame109)

		self._navigateButtonView:setOverrideClose(self.overrideOnCloseClick, self)

		return {
			self._navigateButtonView
		}
	end
end

function ActivityChessGameContainer:setHelpVisible(value)
	self._navigateButtonView:setHelpVisible(value)
end

function ActivityChessGameContainer:overrideOnCloseClick()
	local function yesFunc()
		ViewMgr.instance:closeView(ViewName.ActivityChessGame, nil, true)

		local actId = Activity109ChessModel.instance:getActId()

		Activity109Rpc.instance:sendGetAct109InfoRequest(actId)
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, yesFunc)
end

return ActivityChessGameContainer
