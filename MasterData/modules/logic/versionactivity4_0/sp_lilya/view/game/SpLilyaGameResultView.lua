-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/view/game/SpLilyaGameResultView.lua

module("modules.logic.versionactivity4_0.sp_lilya.view.game.SpLilyaGameResultView", package.seeall)

local SpLilyaGameResultView = class("SpLilyaGameResultView", BaseView)

function SpLilyaGameResultView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg2")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._gotargetitem = gohelper.findChild(self.viewGO, "targets/#go_targetitem")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_quitgame")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_restart")
	self._goFinishStar = gohelper.findChild(self.viewGO, "targets/#go_targetitem/result/go_finish")
	self._goUnFinishStar = gohelper.findChild(self.viewGO, "targets/#go_targetitem/result/go_unfinish")
	self._txtDesc = gohelper.findChildText(self.viewGO, "targets/#go_targetitem/txt_taskdesc")
	self._animator = gohelper.findChildAnim(self.viewGO, "")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SpLilyaGameResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
	NavigateMgr.instance:addEscape(ViewName.SpLilyaGameResultView, self._btncloseOnClick, self)
end

function SpLilyaGameResultView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
end

function SpLilyaGameResultView:_btncloseOnClick()
	self._closeClicked = true

	local gameMo = SpLilyaGameModel.instance:getGameMO()
	local isWin = gameMo and gameMo.gameResult == SpLilyaEnum.GameResult.Success
	local episodeId = SpLilyaGameModel.instance:getCurEpisodeId()

	if isWin and episodeId then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingBlackView2)
		GameSceneMgr.instance:dispatchEvent(SceneEventName.OpenLoading, SceneType.Main)
		SpLilyaController.instance:finishEpisodeLevel(episodeId)
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.StoryFrontView)
		self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	else
		self:closeThis()
	end
end

function SpLilyaGameResultView:_onOpenViewFinish(viewName)
	if viewName == "StoryFrontView" then
		self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
		GameSceneMgr.instance:dispatchEvent(SceneEventName.CloseLoading, SceneType.Main)
		self:_onEpisodeFinished()
	end
end

function SpLilyaGameResultView:_btnquitgameOnClick()
	self:_btncloseOnClick()
end

function SpLilyaGameResultView:_btnrestartOnClick()
	self._isRestart = true

	SpLilyaGameController.instance:restartGame()
end

function SpLilyaGameResultView:_onEpisodeFinished()
	if self._closeClicked then
		self:closeThis()
	end
end

function SpLilyaGameResultView:_editableInitView()
	return
end

function SpLilyaGameResultView:onUpdateParam()
	self._isRestart = false
	self._closeClicked = false
end

function SpLilyaGameResultView:onOpen()
	self._animator:Play("open", 0, 0)
	self:onUpdateParam()
	self:refreshUI()

	local gameMo = SpLilyaGameModel.instance:getGameMO()
	local isSucc = gameMo and gameMo.gameResult == SpLilyaEnum.GameResult.Success

	AudioMgr.instance:trigger((isSucc or nil) and (AudioEnum4_0.SpLilya.play_ui_yuanzheng_mrs_win or AudioEnum4_0.SpLilya.play_ui_yuanzheng_mrs_fail))
end

function SpLilyaGameResultView:refreshUI()
	local gameMo = SpLilyaGameModel.instance:getGameMO()
	local isSucc = gameMo.gameResult == SpLilyaEnum.GameResult.Success

	gohelper.setActive(self._gosuccess, isSucc)
	gohelper.setActive(self._gofail, not isSucc)
	gohelper.setActive(self._goFinishStar, isSucc)
	gohelper.setActive(self._goUnFinishStar, not isSucc)
	gohelper.setActive(self._btnquitgame, not isSucc)
	gohelper.setActive(self._btnrestart, not isSucc)

	self._txtDesc.text = gameMo.gameConfig.winDesc
end

function SpLilyaGameResultView:onClose()
	if self._isRestart then
		return
	end

	if self._closeClicked then
		self._closeClicked = false

		SpLilyaGameController.instance:exitGame()
	end

	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	self._animator:Play("close", 0, 0)
end

function SpLilyaGameResultView:onDestroyView()
	return
end

return SpLilyaGameResultView
