-- chunkname: @modules/logic/versionactivity1_3/jialabona/view/JiaLaBoNaGameView.lua

module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaGameView", package.seeall)

local JiaLaBoNaGameView = class("JiaLaBoNaGameView", BaseView)

function JiaLaBoNaGameView:onInitView()
	self._txtRemainingTimesNum = gohelper.findChildText(self.viewGO, "LeftTop/RemainingTimes/txt_RemainingTimes/#txt_RemainingTimesNum")
	self._txtTargetDecr = gohelper.findChildText(self.viewGO, "LeftTop/TargetList/Target1/#txt_TargetDesc")
	self._txtTarget2Decr = gohelper.findChildText(self.viewGO, "LeftTop/TargetList/Target2/#txt_TargetDesc")
	self._txtStage = gohelper.findChildText(self.viewGO, "Top/#txt_Stage")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Top/#txt_Title")
	self._txtTips = gohelper.findChildText(self.viewGO, "Top/Tips/image_TipsBG/#txt_Tips")
	self._btnReadBtn = gohelper.findChildButtonWithAudio(self.viewGO, "RightTop/#btn_ReadBtn")
	self._btnResetBtn = gohelper.findChildButtonWithAudio(self.viewGO, "RightTop/#btn_ResetBtn")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")
	self._goexcessive = gohelper.findChild(self.viewGO, "#go_excessive")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function JiaLaBoNaGameView:addEvents()
	self._btnResetBtn:AddClickListener(self._btnResetBtnOnClick, self)
	self._btnReadBtn:AddClickListener(self._btnReadBtnOnClick, self)
end

function JiaLaBoNaGameView:removeEvents()
	self._btnResetBtn:RemoveClickListener()
	self._btnReadBtn:RemoveClickListener()
end

function JiaLaBoNaGameView:_btnResetBtnOnClick()
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.PushBoxReset, MsgBoxEnum.BoxType.Yes_No, self._yesResetFunc)
end

function JiaLaBoNaGameView:_btnReadBtnOnClick()
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	if Va3ChessGameModel.instance:getRound() > 1 then
		if not self._litterPointTime or self._litterPointTime < Time.time then
			self._litterPointTime = Time.time + 0.3

			self:_returnPointGame()
		end
	else
		GameFacade.showToast(ToastEnum.ActivityChessNotBack)
	end
end

JiaLaBoNaGameView.UI_RESTART_BLOCK_KEY = "JiaLaBoNaGameViewsGameMainDelayRestart"

function JiaLaBoNaGameView:_editableInitView()
	function self._yesResetFunc()
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Start, true)
		TaskDispatcher.runDelay(self.delayRestartGame, self, JiaLaBoNaEnum.AnimatorTime.SwithSceneOpen)
		AudioMgr.instance:trigger(AudioEnum.ChessGame.GameReset)
	end

	self._imgTarget1Icon = gohelper.findChildImage(self.viewGO, "LeftTop/TargetList/Target1/image_TargetIcon")
	self._imgTarget2Icon = gohelper.findChildImage(self.viewGO, "LeftTop/TargetList/Target2/image_TargetIcon")
	self._govxfinish = gohelper.findChild(self.viewGO, "LeftTop/TargetList/Target1/vx_finish")
	self._govxglow = gohelper.findChild(self.viewGO, "LeftTop/TargetList/Target2/vx_glow")
	self._goTips = gohelper.findChild(self.viewGO, "Top/Tips")
	self._goresetgame = gohelper.findChild(self.viewGO, "excessive")

	gohelper.setActive(self._goTips, false)

	local goAnim = gohelper.findChild(self.viewGO, "#go_excessive/anim")
	local goresetAnim = gohelper.findChild(self.viewGO, "excessive/anim")

	self._swicthSceneAnimator = goAnim:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)
	self._resetGameAnimator = goresetAnim:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)
	self._viewAnimator = self.viewGO:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)

	gohelper.setActive(self._goexcessive, false)
	gohelper.setActive(self._goresetgame, false)

	self._isLastSwitchStart = false
end

function JiaLaBoNaGameView:onOpen()
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.SetViewVictory, self.onSetViewVictory, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.SetViewFail, self.onSetViewFail, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.CurrentRoundUpdate, self.refreshRound, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.GameResultQuit, self.onResultQuit, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.CurrentConditionUpdate, self.refreshConditions, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.GameMapDataUpdate, self.refreshUI, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.SetCenterHintText, self.setUICenterHintText, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.ResetGameByResultView, self.handleResetByResult, self)
	self.addEventCb(self, JiaLaBoNaController.instance, JiaLaBoNaEvent.Refresh120MapData, self.refreshUI, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.GameLoadingMapStateUpdate, self._onReadyGoNextMap, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.GameToastUpdate, self._onToastUpdate, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.EventBattleReturn, self._onReturnChessFromBattleGroup, self)
	self:refreshUI()
	self:_setOpenAnimSpeed(true)
	TaskDispatcher.runDelay(self._onResetOpenAnim, self, 1)
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_level_title_appear)
end

function JiaLaBoNaGameView:onClose()
	UIBlockMgr.instance:endBlock(JiaLaBoNaGameView.UI_RESTART_BLOCK_KEY)
	TaskDispatcher.cancelTask(self.delayRestartGame, self)
	TaskDispatcher.cancelTask(self._returnPointGame, self)
	TaskDispatcher.cancelTask(self._onHideToast, self)
	TaskDispatcher.cancelTask(self._onDelayRefreshMainTask, self)
	TaskDispatcher.cancelTask(self._onResetOpenAnim, self)
end

function JiaLaBoNaGameView:_getEpisodeCfg()
	local actId = Va3ChessModel.instance:getActId()
	local episodeId = Va3ChessModel.instance:getEpisodeId()

	if self._curEpisodeCfg and self._curEpisodeCfg.activity == actId and self._curEpisodeCfg.id == episodeId then
		return self._curEpisodeCfg
	end

	if actId ~= nil and episodeId ~= nil then
		local cfg = Va3ChessConfig.instance:getEpisodeCo(actId, episodeId)

		self._curEpisodeCfg = cfg
		self._curMainConditions = cfg and GameUtil.splitString2(cfg.mainConfition, true, "|", "#")
		self._curConditionDesc = cfg and string.split(cfg.mainConditionStr, "|")
		self._extStarConditions = cfg and GameUtil.splitString2(cfg.extStarCondition, true, "|", "#")

		return self._curEpisodeCfg
	end
end

function JiaLaBoNaGameView:_onResetOpenAnim()
	if self._needResetViewOpen then
		self:_setOpenAnimSpeed(false)
	end
end

function JiaLaBoNaGameView:_setOpenAnimSpeed(isStop)
	self._needResetViewOpen = isStop
	self._viewAnimator.speed = isStop and 0 or 1

	self._viewAnimator:Play(UIAnimationName.Open, 0, 0)
	self._viewAnimator:Update(0)
end

function JiaLaBoNaGameView:refreshUI()
	local episodeCfg = self:_getEpisodeCfg()

	if episodeCfg then
		self._txtStage.text = episodeCfg.orderId
		self._txtTitle.text = episodeCfg.name
	end

	self:refreshConditions()
	self:refreshRound()
end

function JiaLaBoNaGameView:onSetViewVictory()
	Stat1_3Controller.instance:jiaLaBoNaStatSuccess()

	local episodeCfg = self:_getEpisodeCfg()

	self:refreshConditions()

	if episodeCfg then
		if episodeCfg.storyClear == 0 then
			JiaLaBoNaGameView.openWinResult()

			return
		end

		local story = episodeCfg.storyClear

		if episodeCfg.storyRepeat == 1 or not StoryModel.instance:isStoryHasPlayed(story) then
			local param = {}

			param.blur = true
			param.mark = true
			param.hideStartAndEndDark = true
			param.isReplay = false

			StoryController.instance:playStories({
				story
			}, param, JiaLaBoNaGameView._onStroyClearFinish)
		else
			JiaLaBoNaGameView.openWinResult()
		end
	end
end

JiaLaBoNaGameView.OPEN_WIN_RESULT = "JiaLaBoNaGameView.JiaLaBoNaGameView.OPEN_WIN_RESULT"

function JiaLaBoNaGameView._onStroyClearFinish()
	UIBlockMgr.instance:startBlock(JiaLaBoNaGameView.STROY_CLEARR_FINISH)
	TaskDispatcher.runDelay(JiaLaBoNaGameView.openWinResult, nil, 1)
end

function JiaLaBoNaGameView.openWinResult()
	UIBlockMgr.instance:endBlock(JiaLaBoNaGameView.STROY_CLEARR_FINISH)

	local episodeId = Va3ChessModel.instance:getEpisodeId()
	local v1 = "OnChessWinPause" .. episodeId
	local v2 = GuideEvent[v1]
	local v3 = GuideEvent.OnChessWinContinue
	local v4 = JiaLaBoNaGameView._openSuccessView
	local v5

	GuideController.instance:GuideFlowPauseAndContinue(v1, v2, v3, v4, v5)
end

function JiaLaBoNaGameView._openSuccessView()
	AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerArrive)
	ViewMgr.instance:openView(ViewName.JiaLaBoNaGameResultView, {
		result = true
	})
end

function JiaLaBoNaGameView:onSetViewFail()
	Stat1_3Controller.instance:jiaLaBoNaStatFail()

	local failReason = Va3ChessGameModel.instance:getFailReason()

	if failReason == Va3ChessEnum.FailReason.MaxRound then
		Va3ChessGameModel.instance:setRound(Va3ChessGameModel.instance:getRound() + 1)
		self:refreshRound()
	end

	ViewMgr.instance:openView(ViewName.JiaLaBoNaGameResultView, {
		result = false
	})
end

function JiaLaBoNaGameView:refreshRound()
	local episodeCfg = self:_getEpisodeCfg()

	if episodeCfg then
		local round = episodeCfg.maxRound - Va3ChessGameModel.instance:getRound() + 1

		self._txtRemainingTimesNum.text = string.format("%s", math.max(round, 0))
	end
end

function JiaLaBoNaGameView:onResultQuit()
	self:closeThis()
end

function JiaLaBoNaGameView:delayRestartGame()
	TaskDispatcher.cancelTask(self.delayRestartGame, self)
	Stat1_3Controller.instance:jiaLaBoNaStatReset()
	JiaLaBoNaController.instance:resetStartGame()
end

function JiaLaBoNaGameView:_returnPointGame()
	Stat1_3Controller.instance:jiaLaBoNaMarkUseRead()
	JiaLaBoNaController.instance:returnPointGame()
end

function JiaLaBoNaGameView:refreshConditions()
	local episodeCfg = self:_getEpisodeCfg()

	if episodeCfg then
		local taskLen = #self._curMainConditions
		local actId = episodeCfg.activityId
		local finishIndex = self:_findFinishIndex(self._curMainConditions, actId)

		self._curShowMainTaskDesStr = self._curConditionDesc[finishIndex + 1] or self._curConditionDesc[finishIndex]
		self._curMainTaskFinishAll = taskLen <= finishIndex

		local target2Finish = self:_checkTarget2Finish(self._extStarConditions, actId)

		self._txtTarget2Decr.text = episodeCfg.conditionStr

		if self._lastTarget2Finish ~= target2Finish then
			self._lastTarget2Finish = target2Finish

			self:_setColorByFinish(self._imgTarget2Icon, target2Finish)
			gohelper.setActive(self._govxglow, false)

			if target2Finish then
				gohelper.setActive(self._govxglow, true)
			end
		end

		if self._lastFinishIndex ~= finishIndex then
			self._lastFinishIndex = finishIndex

			gohelper.setActive(self._govxfinish, false)

			if finishIndex > 0 then
				self:_setColorByFinish(self._imgTarget1Icon, finishIndex > 0)
				gohelper.setActive(self._govxfinish, true)
				TaskDispatcher.cancelTask(self._onDelayRefreshMainTask, self)
				TaskDispatcher.runDelay(self._onDelayRefreshMainTask, self, 0.5)
				AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_target_flushed)
			else
				self:_onDelayRefreshMainTask()
			end
		end
	end
end

function JiaLaBoNaGameView:_setColorByFinish(graphic, isFinish)
	SLFramework.UGUI.GuiHelper.SetColor(graphic, isFinish and "#AFD3FF" or "#808080")
end

function JiaLaBoNaGameView:_onDelayRefreshMainTask()
	self._txtTargetDecr.text = self._curShowMainTaskDesStr

	self:_setColorByFinish(self._imgTarget1Icon, self._curMainTaskFinishAll)
end

function JiaLaBoNaGameView:_findFinishIndex(params2, actId)
	local taskLen = #params2

	for i = 1, taskLen do
		if not Va3ChessMapUtils.isClearConditionFinish(params2[i], actId) then
			return i - 1
		end
	end

	return taskLen
end

function JiaLaBoNaGameView:_checkTarget2Finish(params2, actId)
	if params2 then
		for i, params in ipairs(params2) do
			if not Va3ChessMapUtils.isClearConditionFinish(params, actId) then
				return false
			end
		end
	end

	return true
end

function JiaLaBoNaGameView:setUICenterHintText()
	return
end

function JiaLaBoNaGameView:handleResetByResult()
	return
end

function JiaLaBoNaGameView:_onReadyGoNextMap(state, isRestStart)
	local isStar = state == Va3ChessEvent.LoadingMapState.Start

	self:switchScene(isStar, isStar and isRestStart)

	if state == Va3ChessEvent.LoadingMapState.Finish then
		self:_onResetOpenAnim()
	end
end

function JiaLaBoNaGameView:switchScene(isStart, isResetStart)
	local tempStart = isStart == true

	if self._isLastSwitchStart == tempStart then
		return
	end

	if self._curSwitchSceneGO == nil then
		if isResetStart then
			self._curSwitchSceneGO = self._goresetgame or self._goexcessive
		end

		if isResetStart then
			self._curSwitchSceneAnim = self._resetGameAnimator or self._swicthSceneAnimator
		end
	end

	self._isLastSwitchStart = tempStart

	if tempStart then
		UIBlockMgr.instance:startBlock(JiaLaBoNaGameView.UI_RESTART_BLOCK_KEY)
		gohelper.setActive(self._curSwitchSceneGO, true)
	end

	self._curSwitchSceneAnim:Play(tempStart and "open" or "close")
	TaskDispatcher.cancelTask(self._onHideSwitchScene, self)
	TaskDispatcher.runDelay(self._onHideSwitchScene, self, 0.3)
end

function JiaLaBoNaGameView:_onHideSwitchScene()
	if self._isLastSwitchStart then
		self._curSwitchSceneAnim:Play("loop")
	else
		UIBlockMgr.instance:endBlock(JiaLaBoNaGameView.UI_RESTART_BLOCK_KEY)

		if self._curSwitchSceneGO then
			gohelper.setActive(self._curSwitchSceneGO, false)

			self._curSwitchSceneGO = nil
			self._curSwitchSceneAnim = nil
		end
	end
end

function JiaLaBoNaGameView:_onReturnChessFromBattleGroup()
	JiaLaBoNaController.instance:returnPointGame()
end

function JiaLaBoNaGameView:_onToastUpdate(toastId)
	local actId = Va3ChessModel.instance:getActId()

	if actId == Va3ChessEnum.ActivityId.Act120 then
		local co = Activity120Config.instance:getTipsCo(actId, toastId)

		if not co then
			logError(string.format("export_伽菈波娜飘字 activityId:%s id:%s", actId, toastId))

			return
		end

		if co.audioId and co.audioId ~= 0 then
			AudioMgr.instance:trigger(co.audioId)
		end

		TaskDispatcher.cancelTask(self._onHideToast, self)
		TaskDispatcher.runDelay(self._onHideToast, self, 5)

		self._txtTips.text = co.tips

		gohelper.setActive(self._goTips, true)
	end
end

function JiaLaBoNaGameView:_onHideToast()
	gohelper.setActive(self._goTips, false)
end

return JiaLaBoNaGameView
