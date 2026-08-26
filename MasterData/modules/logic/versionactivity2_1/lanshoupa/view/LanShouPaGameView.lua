-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/view/LanShouPaGameView.lua

module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaGameView", package.seeall)

local LanShouPaGameView = class("LanShouPaGameView", BaseView)

LanShouPaGameView.TextShowInterval = 0.06
LanShouPaGameView.ScrollTalkMargin = {
	Top = 20,
	Bottom = 20
}
LanShouPaGameView.TextMaxHeight = 200
LanShouPaGameView.TipHeight = 30
LanShouPaGameView.offsetY = 1
LanShouPaGameView.offsetX = 2.5

function LanShouPaGameView:onInitView()
	self._txtRemainingTimesNum = gohelper.findChildText(self.viewGO, "LeftTop/RemainingTimes/txt_RemainingTimes/#txt_RemainingTimesNum")
	self._txtTargetDecr = gohelper.findChildText(self.viewGO, "LeftTop/TargetList/Target1/#txt_TargetDesc")
	self._txtMapName = gohelper.findChildText(self.viewGO, "Top/Tips/image_TipsBG/#txt_Tips")
	self._txtTips = gohelper.findChildText(self.viewGO, "Top/Tips2/image_TipsBG/#txt_Tips")
	self._btnReadBtn = gohelper.findChildButtonWithAudio(self.viewGO, "RightTop/#btn_ReadBtn")
	self._btnResetBtn = gohelper.findChildButtonWithAudio(self.viewGO, "RightTop/#btn_ResetBtn")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")
	self._goexcessive = gohelper.findChild(self.viewGO, "#go_excessive")
	self._gotouch = gohelper.findChild(self.viewGO, "#go_touch")
	self._isPlayingDialog = false

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LanShouPaGameView:addEvents()
	self._btnResetBtn:AddClickListener(self._btnResetBtnOnClick, self)
	self._btnReadBtn:AddClickListener(self._btnReadBtnOnClick, self)
	self.addEventCb(self, ChessGameController.instance, ChessGameEvent.PlayDialogue, self.showDialog, self)
end

function LanShouPaGameView:removeEvents()
	self._btnResetBtn:RemoveClickListener()
	self._btnReadBtn:RemoveClickListener()
	self.removeEventCb(self, ChessGameController.instance, ChessGameEvent.PlayDialogue, self.showDialog, self)
end

function LanShouPaGameView:_btnResetBtnOnClick()
	if ChessGameController.instance:isNeedBlock() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.PushBoxReset, MsgBoxEnum.BoxType.Yes_No, self._yesResetFunc)
end

function LanShouPaGameView:_btnReadBtnOnClick()
	if ChessGameController.instance.eventMgr:isPlayingFlow() then
		return
	end

	if ChessGameModel.instance:getRound() > 0 then
		if not self._litterPointTime or self._litterPointTime < Time.time then
			self._litterPointTime = Time.time + 0.3

			gohelper.setActive(self.gotalk, false)
			self:_returnPointGame(ChessGameEnum.RollBack.LastPoint)
		end
	else
		GameFacade.showToast(ToastEnum.ActivityChessNotBack)
	end
end

LanShouPaGameView.UI_RESTART_BLOCK_KEY = "LanShouPaGameViewsGameMainDelayRestart"

function LanShouPaGameView:_editableInitView()
	function self._yesResetFunc()
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Start, true)
		TaskDispatcher.runDelay(self.delayRestartGame, self, LanShouPaEnum.AnimatorTime.SwithSceneOpen)
		gohelper.setActive(self.gotalk, false)
		ChessGameController.instance.eventMgr:stopFlow()
		self:onFinishTalk()
		ChessStatController.instance:statReset()
		AudioMgr.instance:trigger(AudioEnum.ChessGame.GameReset)
	end

	self._govxfinish = gohelper.findChild(self.viewGO, "LeftTop/TargetList/Target1/vx_finish")
	self._goMapName = gohelper.findChild(self.viewGO, "Top/Tips")
	self._aniMapName = self._goMapName:GetComponent(LanShouPaEnum.ComponentType.Animator)
	self._goTips = gohelper.findChild(self.viewGO, "Top/Tips2")
	self._aniTips = self._goTips:GetComponent(LanShouPaEnum.ComponentType.Animator)
	self._goresetgame = gohelper.findChild(self.viewGO, "excessive")

	local goAnim = gohelper.findChild(self.viewGO, "#go_excessive/anim")
	local goresetAnim = gohelper.findChild(self.viewGO, "excessive/anim")

	self._swicthSceneAnimator = goAnim:GetComponent(LanShouPaEnum.ComponentType.Animator)
	self._resetGameAnimator = goresetAnim:GetComponent(LanShouPaEnum.ComponentType.Animator)
	self._viewAnimator = self.viewGO:GetComponent(LanShouPaEnum.ComponentType.Animator)

	gohelper.setActive(self._goexcessive, false)
	gohelper.setActive(self._goresetgame, false)

	self._isLastSwitchStart = false

	self:_initDialogView()
end

function LanShouPaGameView:onOpen()
	self.addEventCb(self, ChessGameController.instance, ChessGameEvent.GameResultQuit, self.onResultQuit, self)
	self.addEventCb(self, ChessGameController.instance, ChessGameEvent.CurrentConditionUpdate, self.refreshConditions, self)
	self.addEventCb(self, ChessGameController.instance, ChessGameEvent.GameMapDataUpdate, self.refreshUI, self)
	self.addEventCb(self, ChessGameController.instance, ChessGameEvent.RollBack, self.onRollBack, self)
	self.addEventCb(self, ChessGameController.instance, ChessGameEvent.GameLoadingMapStateUpdate, self._onReadyGoNextMap, self)
	self.addEventCb(self, ChessGameController.instance, ChessGameEvent.ClickOnTalking, self._clickOnTalking, self)
	self.addEventCb(self, ChessGameController.instance, ChessGameEvent.GameToastUpdate, self._onToastUpdate, self)
	self:refreshUI()
	TaskDispatcher.runDelay(self._onTitleOpen, self, ChessGameEnum.TitleOpenAnimTime)
end

function LanShouPaGameView:_onTitleOpen()
	TaskDispatcher.cancelTask(self._onTitleOpen, self)
	gohelper.setActive(self._goMapName, false)
end

function LanShouPaGameView:onClose()
	UIBlockMgr.instance:endBlock(LanShouPaGameView.UI_RESTART_BLOCK_KEY)
	TaskDispatcher.cancelTask(self.delayRestartGame, self)
	TaskDispatcher.cancelTask(self._onHideToast, self)
	TaskDispatcher.cancelTask(self._onResetOpenAnim, self)
	TaskDispatcher.cancelTask(self._onTitleOpen, self)
	TaskDispatcher.cancelTask(self.playNextStep, self)
	TaskDispatcher.cancelTask(self.onFinishTalk, self)
	TaskDispatcher.cancelTask(self._playfunc, self)
	TaskDispatcher.cancelTask(self.refreshConditions, self)
	TaskDispatcher.cancelTask(self._openCallback, self)
	self:removeUpdateBeat()
end

function LanShouPaGameView:_initDialogView()
	self.dialogMap = {}
	self.isStartTalk = false
	self.gotalk = gohelper.findChild(self.viewGO, "go_talk")
	self.gotalkRect = self.gotalk:GetComponent(gohelper.Type_RectTransform)
	self.scrolltalk = gohelper.findChildScrollRect(self.gotalk, "Scroll View")
	self.txttalk = gohelper.findChildText(self.gotalk, "Scroll View/Viewport/Content/txt_talk")

	gohelper.setActive(self.gotalk, false)
end

function LanShouPaGameView:_getEpisodeCfg()
	local actId = ChessModel.instance:getActId()
	local episodeId = ChessModel.instance:getEpisodeId()

	if self._curEpisodeCfg and self._curEpisodeCfg.activity == actId and self._curEpisodeCfg.id == episodeId then
		return self._curEpisodeCfg
	end

	if actId ~= nil and episodeId ~= nil then
		local cfg = ChessConfig.instance:getEpisodeCo(actId, episodeId)

		self._curEpisodeCfg = cfg
		self._curMainConditions = cfg and GameUtil.splitString2(cfg.mainConfition, true, "|", "#")
		self._curConditionDesc = cfg and string.split(cfg.mainConditionStr, "|")
		self._mapNames = cfg and string.split(cfg.mapName, "#")

		return self._curEpisodeCfg
	end
end

function LanShouPaGameView:refreshUI()
	local episodeCfg = self:_getEpisodeCfg()
	local nowMapIndex = ChessGameModel.instance:getNowMapIndex()

	self._txtMapName.text = self._mapNames[nowMapIndex]

	self:refreshConditions()
end

function LanShouPaGameView:onRollBack()
	self:onFinishTalk()
end

function LanShouPaGameView:refreshConditions()
	local episodeCfg = self:_getEpisodeCfg()
	local completedCount = ChessGameModel.instance:getCompletedCount() or 1
	local targetList = string.split(episodeCfg.mainConditionStr, "|")

	if self._curTargetIndex then
		local needUpdateTarget = not (completedCount <= self._curTargetIndex or completedCount > #targetList)

		self._curTargetIndex = completedCount

		if needUpdateTarget then
			gohelper.setActive(self._govxfinish, false)
			gohelper.setActive(self._govxfinish, true)
			TaskDispatcher.runDelay(self.refreshConditions, self, 0.5)

			return
		end

		local targetNum

		self._txtTargetDecr.text = targetList[completedCount + 1 > #targetList and #targetList or completedCount + 1]
	end
end

function LanShouPaGameView:onResultQuit()
	self:closeThis()
end

function LanShouPaGameView:delayRestartGame()
	TaskDispatcher.cancelTask(self.delayRestartGame, self)
	LanShouPaController.instance:resetStartGame()
end

function LanShouPaGameView:_returnPointGame()
	LanShouPaController.instance:returnPointGame(ChessGameEnum.RollBack.LastPoint)
end

function LanShouPaGameView:_onReadyGoNextMap(state, isRestStart)
	local isStart = state == ChessGameEvent.LoadingMapState.Start

	self:switchScene(isStart, isStart and isRestStart)

	if state == ChessGameEvent.LoadingMapState.Finish and isRestStart then
		self._isOpenAnim = true

		self._viewAnimator:Play(UIAnimationName.Open, 0, 0)
		self._viewAnimator:Update(0)
		TaskDispatcher.runDelay(self._openCallback, self, 1)
	end
end

function LanShouPaGameView:_openCallback()
	TaskDispatcher.cancelTask(self._openCallback, self)

	self._isOpenAnim = false
end

function LanShouPaGameView:switchScene(isStart, isResetStart)
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
		UIBlockMgr.instance:startBlock(LanShouPaGameView.UI_RESTART_BLOCK_KEY)
		gohelper.setActive(self._curSwitchSceneGO, true)
		gohelper.setActive(self._gotouch, false)
	end

	self._curSwitchSceneAnim:Play(tempStart and "open" or "close")
	TaskDispatcher.cancelTask(self._onHideSwitchScene, self)
	TaskDispatcher.runDelay(self._onHideSwitchScene, self, 0.3)
end

function LanShouPaGameView:_onHideSwitchScene()
	if self._isLastSwitchStart then
		self._curSwitchSceneAnim:Play("loop")
	else
		UIBlockMgr.instance:endBlock(LanShouPaGameView.UI_RESTART_BLOCK_KEY)

		if self._curSwitchSceneGO then
			gohelper.setActive(self._curSwitchSceneGO, false)
			gohelper.setActive(self._gotouch, true)

			self._curSwitchSceneGO = nil
			self._curSwitchSceneAnim = nil
		end

		local nowMapIndex = ChessGameModel.instance:getNowMapIndex()

		self._txtMapName.text = self._mapNames[nowMapIndex]

		gohelper.setActive(self._goMapName, true)
		TaskDispatcher.runDelay(self._onTitleOpen, self, ChessGameEnum.TitleOpenAnimTime)
	end
end

function LanShouPaGameView:_onToastUpdate(co)
	TaskDispatcher.cancelTask(self._onHideToast, self)
	TaskDispatcher.runDelay(self._onHideToast, self, 5)

	self._txtTips.text = co.content

	gohelper.setActive(self._goTips, true)
	self._aniTips:Play("open", 0, 0)
end

function LanShouPaGameView:_onHideToast()
	gohelper.setActive(self._goTips, false)
end

function LanShouPaGameView:showDialog(param)
	local uiCamera = CameraMgr.instance:getUICamera()
	local mainCamera = CameraMgr.instance:getMainCamera()
	local interactId = param.id
	local interactMo = ChessGameInteractModel.instance:getInteractById(interactId)
	local x, y = interactMo:getXY()
	local pos = {
		z = 0,
		x = x,
		y = y
	}
	local tempPos = ChessGameHelper.nodePosToWorldPos(pos)
	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local _, offsetY, _ = transformhelper.getLocalPos(mainTrans)
	local v2Pos = recthelper.worldPosToAnchorPos(Vector3.New(tempPos.x + LanShouPaGameView.offsetX, tempPos.y + offsetY + LanShouPaGameView.offsetY, 0), self.viewGO.transform, uiCamera, mainCamera)

	transformhelper.setLocalPos(self.gotalk.transform, v2Pos.x, v2Pos.y, 0)
	self:startTalk(param.txtco)
end

function LanShouPaGameView:startTalk(config)
	if self.isStartTalk then
		return
	end

	self._isPlayingDialog = true
	self._dialogConfigGroup = config
	self.isStartTalk = true

	ChessGameModel.instance:setTalk(true)

	self.curStepIndex = 1
	self.curCharIndex = 0
	self.lastShowTime = Time.time - LanShouPaGameView.TextShowInterval
	self.dialogConfig = self._dialogConfigGroup[self.curStepIndex]
	self.dialogLength = utf8.len(self.dialogConfig.content)

	self:initUpdateBeat()
end

function LanShouPaGameView:initUpdateBeat()
	self.updateHandle = UpdateBeat:CreateListener(self._onTalkFrame, self)

	UpdateBeat:AddListener(self.updateHandle)

	self.lateUpdateHandle = LateUpdateBeat:CreateListener(self._onTalkFrameLateUpdate, self)

	LateUpdateBeat:AddListener(self.lateUpdateHandle)
end

function LanShouPaGameView:_onTalkFrame()
	if self.closedView then
		return
	end

	if not self.isStartTalk then
		return
	end

	if self.waitPlayNextStep or self.waitFinishTalk then
		return
	end

	local currentTime = Time.time

	if currentTime - self.lastShowTime < LanShouPaGameView.TextShowInterval then
		return
	end

	self:showTalkContent()
end

function LanShouPaGameView:showTalkContent()
	if self.closedView then
		return
	end

	self.lastShowTime = Time.time
	self.curCharIndex = self.curCharIndex + 1

	gohelper.setActive(self._goTalkNode, true)
	gohelper.setActive(self.gotalk, true)
	gohelper.setActive(self.gotalkDot, true)

	self.txttalk.text = utf8.sub(self.dialogConfig.content, 1, self.curCharIndex)
	self.scrolltalk.verticalNormalizedPosition = 0
	self.isDirty = true

	if self.curCharIndex == self.dialogLength + 1 then
		local nextStepConfig = self._dialogConfigGroup[self.curStepIndex + 1]

		if nextStepConfig then
			self.waitPlayNextStep = true
		else
			self.waitFinishTalk = true
		end
	end
end

function LanShouPaGameView:playNextStep()
	self._isPlayingDialog = true
	self.waitPlayNextStep = false
	self.curCharIndex = 0
	self.curStepIndex = self.curStepIndex
	self.dialogConfig = self._dialogConfigGroup[self.curStepIndex]
	self.dialogLength = utf8.len(self.dialogConfig.content)
end

function LanShouPaGameView:onFinishTalk()
	self.waitFinishTalk = false
	self.waitPlayNextStep = false
	self.isStartTalk = false
	self.lastShowTime = 0
	self.curCharIndex = 0
	self.curStepIndex = 1

	gohelper.setActive(self.gotalk, false)
	gohelper.setActive(self._goTalkNode, false)
	self:removeUpdateBeat()
	ChessGameModel.instance:setTalk(false)
	ChessGameController.instance:autoSelectPlayer()
	ChessGameController.instance:dispatchEvent(ChessGameEvent.DialogEnd)
end

function LanShouPaGameView:_onTalkFrameLateUpdate()
	TaskDispatcher.cancelTask(self._onTalkFrameLateUpdate, self)

	if self.closedView then
		return
	end

	if not self.isStartTalk then
		return
	end

	if self.waitPlayNextStep or self.waitFinishTalk then
		return
	end

	if not self.isDirty then
		return
	end

	self.isDirty = false

	local talkHeight = 0
	local preferredHeight = self.txttalk.preferredHeight
	local margin = LanShouPaGameView.ScrollTalkMargin.Top + LanShouPaGameView.ScrollTalkMargin.Bottom

	talkHeight = preferredHeight > LanShouPaGameView.TextMaxHeight and LanShouPaGameView.TextMaxHeight + margin or preferredHeight + margin

	if self.waitPlayNextStep then
		talkHeight = talkHeight + LanShouPaGameView.TipHeight
	end

	recthelper.setHeight(self.gotalkRect, talkHeight)
	gohelper.fitScreenOffset(self.gotalk.transform)
end

function LanShouPaGameView:removeUpdateBeat()
	if self.updateHandle then
		UpdateBeat:RemoveListener(self.updateHandle)
	end

	if self.lateUpdateHandle then
		UpdateBeat:RemoveListener(self.lateUpdateHandle)
	end
end

function LanShouPaGameView:_clickOnTalking()
	if self.isStartTalk then
		self:removeUpdateBeat()

		if self._isPlayingDialog then
			self.txttalk.text = self.dialogConfig.content
			self.curStepIndex = self.curStepIndex + 1
			self.isDirty = true

			self:_onTalkFrameLateUpdate()

			self._isPlayingDialog = false
		else
			self:initUpdateBeat()

			if self.waitPlayNextStep then
				self:playNextStep()
			elseif self.waitFinishTalk then
				self:onFinishTalk()
			else
				local nextStepConfig = self._dialogConfigGroup[self.curStepIndex]

				if nextStepConfig then
					self:playNextStep()
				else
					self:onFinishTalk()
				end
			end
		end
	else
		self:onFinishTalk()
	end
end

return LanShouPaGameView
