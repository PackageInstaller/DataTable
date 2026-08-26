-- chunkname: @modules/logic/versionactivity1_3/chess/view/game/Activity1_3ChessGameView.lua

module("modules.logic.versionactivity1_3.chess.view.game.Activity1_3ChessGameView", package.seeall)

local Activity1_3ChessGameView = class("Activity1_3ChessGameView", BaseView)
local lifeStateAniName = {
	lose = "idle_black",
	losing = "hit",
	normal = "idle_light"
}
local excessiveAniName = {
	loop = "loop",
	open = "open",
	close = "close"
}

Activity1_3ChessGameView.UI_RESET_BLOCK_KEY = "Activity1_3ChessGameViewResetBlock"

function Activity1_3ChessGameView:onInitView()
	self._animatorLife1 = gohelper.findChildComponent(self.viewGO, "LeftTop/LifeTimes/txt_LifeTimes/LifeTimesIcons/#image_LifeTimesIcons1", typeof(UnityEngine.Animator))
	self._animatorLife2 = gohelper.findChildComponent(self.viewGO, "LeftTop/LifeTimes/txt_LifeTimes/LifeTimesIcons/#image_LifeTimesIcons2", typeof(UnityEngine.Animator))
	self._animatorLife3 = gohelper.findChildComponent(self.viewGO, "LeftTop/LifeTimes/txt_LifeTimes/LifeTimesIcons/#image_LifeTimesIcons3", typeof(UnityEngine.Animator))
	self._txtTargetDesc = gohelper.findChildText(self.viewGO, "LeftTop/TargetList/Target1/#txt_TargetDesc")
	self._imageTargetIcon = gohelper.findChildImage(self.viewGO, "LeftTop/TargetList/Target1/image_TargetIcon")
	self._gotargetFinish = gohelper.findChild(self.viewGO, "LeftTop/TargetList/Target1/vx_finish")
	self._txtTargetDesc2 = gohelper.findChildText(self.viewGO, "LeftTop/TargetList/Target2/#txt_TargetDesc")
	self._imageTargetIcon2 = gohelper.findChildImage(self.viewGO, "LeftTop/TargetList/Target2/image_TargetIcon")
	self._gotargetStar = gohelper.findChild(self.viewGO, "LeftTop/TargetList/Target2/vx_glow")
	self._txtStage = gohelper.findChildText(self.viewGO, "Top/#txt_Stage")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Top/#txt_Title")
	self._txtTips = gohelper.findChildText(self.viewGO, "Top/Tips/image_TipsBG/#txt_Tips")
	self._btnResetBtn = gohelper.findChildButtonWithAudio(self.viewGO, "RightTop/#btn_ResetBtn")
	self._btnReadBtn = gohelper.findChildButtonWithAudio(self.viewGO, "RightTop/#btn_ReadBtn")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")
	self._goTop = gohelper.findChild(self.viewGO, "Top")
	self._exTargetGo = gohelper.findChild(self.viewGO, "LeftTop/TargetList/Target2")
	self._goTargetList = gohelper.findChild(self.viewGO, "LeftTop/TargetList")
	self._goTipsRoot = gohelper.findChild(self.viewGO, "Top/Tips")
	self._goResetExcessive = gohelper.findChild(self.viewGO, "excessive")
	self._goNextMapExcessive = gohelper.findChild(self.viewGO, "#go_excessive")

	gohelper.setActive(self._goResetExcessive, false)
	gohelper.setActive(self._goNextMapExcessive, false)

	self._animatorResetExcessive = gohelper.findChildComponent(self.viewGO, "excessive/anim", typeof(UnityEngine.Animator))
	self._animatorNextMapExcessive = gohelper.findChildComponent(self.viewGO, "#go_excessive/anim", typeof(UnityEngine.Animator))
	self._viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity1_3ChessGameView:addEvents()
	self._btnResetBtn:AddClickListener(self._btnResetBtnOnClick, self)
	self._btnReadBtn:AddClickListener(self._btnBackOnClick, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.SetViewVictory, self.onSetViewVictory, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.SetViewFail, self.onSetViewFail, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.CurrentHpUpdate, self.refreshLifeCount, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.GameResultQuit, self.onResultQuit, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.CurrentConditionUpdate, self.refreshConditions, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.TargetUpdate, self.refreshConditions, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.GameMapDataUpdate, self.refreshUI, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.GameToastUpdate, self.showTips, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.BeforeEnterNextMap, self._beforeEnterNextMap, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.EnterNextMap, self._onEnterNextMap, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.PlayStoryFinish, self._onPlayStoryFinish, self)
	self.addEventCb(self, Va3ChessGameController.instance, Va3ChessEvent.EventBattleReturn, self._onReturnChessFromBattleGroup, self)
	self.addEventCb(self, Activity1_3ChessController.instance, Activity1_3ChessEvent.AfterResetChessGame, self.onResetGame, self)
	self.addEventCb(self, Activity1_3ChessController.instance, Activity1_3ChessEvent.OnReadChessGame, self.onReadGame, self)
	self.addEventCb(self, Activity1_3ChessController.instance, Activity1_3ChessEvent.ClickReset, self.eventResetFunc, self)
	self.addEventCb(self, Activity1_3ChessController.instance, Activity1_3ChessEvent.ClickRead, self._btnReadBtnOnClick, self)
	self.addEventCb(self, StoryController.instance, StoryEvent.StoryFrontViewDestroy, self._afterPlayStory, self)
end

function Activity1_3ChessGameView:removeEvents()
	self._btnResetBtn:RemoveClickListener()
	self._btnReadBtn:RemoveClickListener()
end

function Activity1_3ChessGameView:_btnBackOnClick()
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	local actId = Va3ChessModel.instance:getActId()

	Stat1_3Controller.instance:bristleMarkUseRead()
	Activity1_3ChessController.instance:requestBackChessGame(actId)
end

function Activity1_3ChessGameView:_btnReadBtnOnClick()
	Stat1_3Controller.instance:bristleMarkUseRead()
	UIBlockMgr.instance:startBlock(Activity1_3ChessGameView.UI_RESET_BLOCK_KEY)
	self:_playReadProgressAniamtion(true)
	TaskDispatcher.runDelay(self.delayReadProgress, self, 0.8)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.GameReset)
end

function Activity1_3ChessGameView:delayReadProgress()
	UIBlockMgr.instance:endBlock(Activity1_3ChessGameView.UI_RESET_BLOCK_KEY)
	TaskDispatcher.cancelTask(self.delayReadProgress, self)

	local actId = Va3ChessModel.instance:getActId()

	Activity1_3ChessController.instance:requestReadChessGame(actId, self.playReadAniamtionClose, self)
end

function Activity1_3ChessGameView:_btnResetBtnOnClick()
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.PushBoxReset, MsgBoxEnum.BoxType.Yes_No, self.btnResetFunc, nil, nil, self)
end

function Activity1_3ChessGameView:btnResetFunc()
	Stat1_3Controller.instance:bristleStatReset()
	self:_resetFunc()
end

function Activity1_3ChessGameView:eventResetFunc()
	Stat1_3Controller.instance:bristleStatStart()
	self:_resetFunc()
end

function Activity1_3ChessGameView:_resetFunc()
	UIBlockMgr.instance:startBlock(Activity1_3ChessGameView.UI_RESET_BLOCK_KEY)
	self:_playResetAniamtion(true)
	TaskDispatcher.runDelay(self.delayRestartGame, self, 0.8)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.GameReset)
end

function Activity1_3ChessGameView:delayRestartGame()
	UIBlockMgr.instance:endBlock(Activity1_3ChessGameView.UI_RESET_BLOCK_KEY)
	TaskDispatcher.cancelTask(self.delayRestartGame, self)

	local episodeId = Va3ChessModel.instance:getEpisodeId()

	if episodeId then
		Activity1_3ChessController.instance:beginResetChessGame(episodeId, self.playResetAniamtionClose, self)
	end
end

function Activity1_3ChessGameView:_editableInitView()
	self._lifeState = {
		true,
		true,
		true
	}

	MainCameraMgr.instance:addView(self.viewName, self.initCamera, self.resetCamera, self)
end

function Activity1_3ChessGameView:initCamera()
	if Va3ChessGameModel.instance:isPlayingStory() then
		return
	end

	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	local scale = GameUtil.getAdapterScale(true)

	camera.orthographicSize = 7.5 * scale

	Activity1_3ChessGameController.instance:setSceneCamera(true)
end

function Activity1_3ChessGameView:resetCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = false

	Activity1_3ChessGameController.instance:setSceneCamera(false)
	self.removeEventCb(self, StoryController.instance, StoryEvent.StoryFrontViewDestroy, self._afterPlayStory, self)
end

function Activity1_3ChessGameView:onUpdateParam()
	return
end

function Activity1_3ChessGameView:onOpen()
	gohelper.setActive(self._goTipsRoot, false)
	AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.GameTitleAppear)
	self:refreshUI()
end

function Activity1_3ChessGameView:onClose()
	return
end

function Activity1_3ChessGameView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshConditions, self)
	TaskDispatcher.cancelTask(self.delayRestartGame, self)
	TaskDispatcher.cancelTask(self.delayReadProgress, self)
	TaskDispatcher.cancelTask(self._delayHideTips, self)
end

function Activity1_3ChessGameView:refreshUI()
	local episodeCfg = self:_getEpisodeCfg()

	if episodeCfg then
		self._txtStage.text = episodeCfg.orderId
		self._txtTitle.text = episodeCfg.name
	end

	self:refreshConditions()
	self:refreshLifeCount()
end

function Activity1_3ChessGameView:onSetViewVictory()
	Stat1_3Controller.instance:bristleStatSuccess()
	self:refreshConditions()

	local episodeCfg = self:_getEpisodeCfg()

	if episodeCfg then
		if episodeCfg.storyClear == 0 then
			self.openWinResult()

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
			}, param, Activity1_3ChessGameView.openWinResult)
		else
			self.openWinResult()
		end
	end
end

function Activity1_3ChessGameView.openWinResult()
	local episodeId = Va3ChessModel.instance:getEpisodeId()
	local v1 = "OnChessWinPause" .. episodeId
	local v2 = GuideEvent[v1]
	local v3 = GuideEvent.OnChessWinContinue
	local v4 = Activity1_3ChessGameView._openSuccessView
	local v5

	GuideController.instance:GuideFlowPauseAndContinue(v1, v2, v3, v4, v5)
end

function Activity1_3ChessGameView._openSuccessView()
	AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerArrive)
	ViewMgr.instance:openView(ViewName.Activity1_3ChessResultView, {
		result = true
	})
end

function Activity1_3ChessGameView:onSetViewFail()
	Stat1_3Controller.instance:bristleStatFail()
	self:refreshConditions()
	ViewMgr.instance:openView(ViewName.Activity1_3ChessResultView, {
		result = false
	})
end

function Activity1_3ChessGameView:onResultQuit()
	self:closeThis()
end

function Activity1_3ChessGameView:refreshConditions()
	local episodeCfg = self:_getEpisodeCfg()

	if not episodeCfg then
		return
	end

	local actId = Va3ChessModel.instance:getActId()
	local mainTargetIndex = Va3ChessGameModel.instance:getFinishedTargetNum() + 1
	local conditions = string.split(episodeCfg.starCondition, "|")

	if self._curTargetIndex then
		local needUpdateTarget = not (mainTargetIndex <= self._curTargetIndex or mainTargetIndex > #conditions)

		self._curTargetIndex = mainTargetIndex

		if needUpdateTarget then
			gohelper.setActive(self._gotargetFinish, false)
			gohelper.setActive(self._gotargetFinish, true)
			AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.MainTargetRefresh)
			TaskDispatcher.runDelay(self.refreshConditions, self, 0.5)

			return
		end

		local conditionDesc = string.split(episodeCfg.conditionStr, "|")

		if mainTargetIndex <= #conditions then
			local params = string.splitToNumber(conditions[mainTargetIndex], "#")

			self._txtTargetDesc.text = conditionDesc[mainTargetIndex] or Va3ChessMapUtils.getClearConditionDesc(params, actId)
		else
			self._txtTargetDesc.text = conditionDesc[#conditionDesc]
		end

		self._imageTargetIcon.color = GameUtil.parseColor(Activity1_3ChessEnum.ChessGameEnum.MainTargetColorGray)

		local exConditions = string.split(episodeCfg.extStarCondition, "|")

		if #exConditions > 1 then
			local finishedCount = 0
			local isFinished = true

			for i = 1, #exConditions do
				local params = string.splitToNumber(exConditions[i], "#")

				isFinished = Va3ChessMapUtils.isClearConditionFinish(params, actId)

				if isFinished then
					finishedCount = finishedCount + 1
				end
			end

			isFinished = finishedCount == #exConditions

			local exConditionDesc = episodeCfg.extConditionStr

			exConditionDesc = string.format("%s (%s/%s)", exConditionDesc, finishedCount, #exConditions)
			self._txtTargetDesc2.text = exConditionDesc

			if isFinished then
				self._imageTargetIcon2.color = GameUtil.parseColor(Activity1_3ChessEnum.ChessGameEnum.ExTargetColorActive or Activity1_3ChessEnum.ChessGameEnum.ExTargetColorGray)

				if isFinished then
					gohelper.setActive(self._gotargetStar, true)
				end
			end
		else
			local params = string.splitToNumber(episodeCfg.extStarCondition, "#")

			if not episodeCfg.extConditionStr then
				local exConditionDesc = Va3ChessMapUtils.getClearConditionDesc(params, actId)
				local isFinished = false

				if params[1] == Va3ChessEnum.ChessClearCondition.InteractAllFinish then
					local unFinishedCount
					local var_25_3, var_25_4 = Va3ChessMapUtils.isClearConditionFinish(params, actId)

					isFinished = var_25_3
					exConditionDesc = episodeCfg.extConditionStr .. string.format("(%s/%s)", #params - 1 - var_25_4, #params - 1)
				else
					isFinished = Va3ChessMapUtils.isClearConditionFinish(params, actId)
				end

				self._txtTargetDesc2.text = exConditionDesc

				if isFinished then
					self._imageTargetIcon2.color = GameUtil.parseColor(Activity1_3ChessEnum.ChessGameEnum.ExTargetColorActive or Activity1_3ChessEnum.ChessGameEnum.ExTargetColorGray)

					if isFinished then
						gohelper.setActive(self._gotargetStar, true)
					end
				end
			end
		end
	end
end

function Activity1_3ChessGameView:initLifeCountView()
	for i = 1, 3 do
		self["_animatorLife" .. i]:Play(lifeStateAniName.normal)
	end
end

function Activity1_3ChessGameView:refreshLifeCount(skipAnimation)
	local hp = Va3ChessGameModel.instance:getHp()
	local hpThreshold = {
		0,
		1,
		2
	}

	for i = 1, 3 do
		if self._lifeState[i] and hp > hpThreshold[i] then
			self["_animatorLife" .. i]:Play(lifeStateAniName.normal)
		elseif self._lifeState[i] then
			self._lifeState[i] = false

			if not skipAnimation then
				self["_animatorLife" .. i]:Play(lifeStateAniName.losing)
			else
				self["_animatorLife" .. i]:Play(lifeStateAniName.lose)
			end
		end
	end
end

function Activity1_3ChessGameView:showTips(tipsId)
	local actId = Va3ChessModel.instance:getActId()
	local tipsCfg = Va3ChessConfig.instance:getTipsCfg(actId, tipsId)

	gohelper.setActive(self._goTipsRoot, true)

	self._txtTips.text = tipsCfg.content

	TaskDispatcher.runDelay(self._delayHideTips, self, 1)
end

function Activity1_3ChessGameView:_delayHideTips()
	gohelper.setActive(self._goTipsRoot, false)
end

function Activity1_3ChessGameView:onResetGame()
	self._lifeState = {
		true,
		true,
		true
	}

	self:refreshLifeCount(true)
end

function Activity1_3ChessGameView:onReadGame()
	self._lifeState = {
		true,
		true,
		true
	}

	self:refreshLifeCount(true)
end

function Activity1_3ChessGameView:_beforeEnterNextMap()
	UIBlockMgr.instance:startBlock(Activity1_3ChessGameView.UI_RESET_BLOCK_KEY)
	AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.NextStage)
	self:_playNextMapAniamtion(true)
end

function Activity1_3ChessGameView:_onEnterNextMap()
	UIBlockMgr.instance:endBlock(Activity1_3ChessGameView.UI_RESET_BLOCK_KEY)
	self:_playNextMapAniamtion(false)
end

function Activity1_3ChessGameView:_afterPlayStory()
	Activity1_3ChessGameController.instance:setSceneCamera(true)
end

function Activity1_3ChessGameView:_getEpisodeCfg()
	local actId = Va3ChessModel.instance:getActId()
	local episodeId = Va3ChessModel.instance:getEpisodeId()

	if actId ~= nil and episodeId ~= nil then
		return Va3ChessConfig.instance:getEpisodeCo(actId, episodeId)
	end
end

function Activity1_3ChessGameView:_onPlayStoryFinish()
	Activity1_3ChessGameController.instance:setSceneCamera(true)
end

function Activity1_3ChessGameView:_onReturnChessFromBattleGroup()
	local actId = Va3ChessModel.instance:getActId()

	Activity1_3ChessController.instance:requestBackChessGame(actId)
end

function Activity1_3ChessGameView:playCloseAniamtion()
	gohelper.setActive(self._goTop, false)
	self._viewAnimator:Play(UIAnimationName.Close)
end

function Activity1_3ChessGameView:playViewAnimation(aniName)
	self._viewAnimator:Play(aniName, 0, 0)
end

function Activity1_3ChessGameView:playResetAniamtionClose()
	self:_playResetAniamtion(false)
end

function Activity1_3ChessGameView:_playResetAniamtion(begin)
	gohelper.setActive(self._goResetExcessive, true)
	self._animatorResetExcessive:Play((begin or nil) and (excessiveAniName.open or excessiveAniName.close))
end

function Activity1_3ChessGameView:playReadAniamtionClose()
	self:_playReadProgressAniamtion(false)
end

function Activity1_3ChessGameView:_playReadProgressAniamtion(begin)
	gohelper.setActive(self._goResetExcessive, true)
	self._animatorResetExcessive:Play((begin or nil) and (excessiveAniName.open or excessiveAniName.close))
end

function Activity1_3ChessGameView:_playNextMapAniamtion(begin)
	gohelper.setActive(self._goNextMapExcessive, true)
	self._animatorNextMapExcessive:Play((begin or nil) and (excessiveAniName.open or excessiveAniName.close))
end

return Activity1_3ChessGameView
