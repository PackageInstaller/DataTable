-- chunkname: @modules/logic/versionactivity1_3/chess/view/game/Activity1_3ChessGameViewContainer.lua

module("modules.logic.versionactivity1_3.chess.view.game.Activity1_3ChessGameViewContainer", package.seeall)

local Activity1_3ChessGameViewContainer = class("Activity1_3ChessGameViewContainer", BaseViewContainer)
local COLSE_BLOCK_KEY = "ChessGameViewColseBlockKey"
local CloseViewTime = 0.5

function Activity1_3ChessGameViewContainer:buildViews()
	local views = {}

	self._gameView = Activity1_3ChessGameView.New()

	table.insert(views, self._gameView)
	table.insert(views, TabViewGroup.New(1, "#go_BackBtns"))
	table.insert(views, TabViewGroup.New(2, "gamescene"))

	return views
end

function Activity1_3ChessGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.VersionActivity_1_3Chess)

		navigateView:setOverrideClose(self.overrideOnCloseClick, self)

		return {
			navigateView
		}
	elseif tabContainerId == 2 then
		return {
			Activity1_3ChessGameScene.New()
		}
	end
end

function Activity1_3ChessGameViewContainer:onContainerOpen()
	return
end

function Activity1_3ChessGameViewContainer:onContainerClose()
	return
end

function Activity1_3ChessGameViewContainer:onContainerOpenFinish()
	self._gameView:initCamera()
end

function Activity1_3ChessGameViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function Activity1_3ChessGameViewContainer:onContainerUpdateParam()
	TaskDispatcher.runDelay(self._setUnitCameraNextFrame, self, 0.1)
end

function Activity1_3ChessGameViewContainer:_setUnitCameraNextFrame()
	Activity1_3ChessGameController.instance:setSceneCamera(true)
end

function Activity1_3ChessGameViewContainer:overrideOnCloseClick()
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, self.closeFunc, nil, nil, self)
end

function Activity1_3ChessGameViewContainer:closeFunc()
	Stat1_3Controller.instance:bristleStatAbort()
	UIBlockMgr.instance:startBlock(COLSE_BLOCK_KEY)
	self._gameView:playCloseAniamtion()
	TaskDispatcher.runDelay(self._delayCloseFunc, self, CloseViewTime)
end

function Activity1_3ChessGameViewContainer:_delayCloseFunc()
	UIBlockMgr.instance:endBlock(COLSE_BLOCK_KEY)
	self:closeThis()
end

return Activity1_3ChessGameViewContainer
