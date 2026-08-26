-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiLevelView.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiLevelView", package.seeall)

local AergusiLevelView = class("AergusiLevelView", BaseView)

function AergusiLevelView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._gopath = gohelper.findChild(self.viewGO, "#go_path")
	self._goscrollcontent = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent")
	self._gostages = gohelper.findChild(self.viewGO, "#go_path/#go_scrollcontent/#go_stages")
	self._gotitle = gohelper.findChild(self.viewGO, "#go_title")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#go_title/#simage_title")
	self._gotime = gohelper.findChild(self.viewGO, "#go_title/#go_time")
	self._txtlimittime = gohelper.findChildText(self.viewGO, "#go_title/#go_time/#txt_limittime")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_task")
	self._gotaskAni = gohelper.findChild(self.viewGO, "#btn_task/ani")
	self._goreddotreward = gohelper.findChild(self.viewGO, "#btn_task/#go_reddotreward")
	self._btnClue = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Clue")
	self._goeyelight = gohelper.findChild(self.viewGO, "#btn_Clue/eye_light")
	self._govxget = gohelper.findChild(self.viewGO, "#btn_Clue/vx_get")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AergusiLevelView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnClue:AddClickListener(self._btnClueOnClick, self)
	self._btnimage_TryBtn:AddClickListener(self._btnimage_TryBtnOnClick, self)
end

function AergusiLevelView:removeEvents()
	self._btntask:RemoveClickListener()
	self._btnClue:RemoveClickListener()
	self._btnimage_TryBtn:RemoveClickListener()
end

function AergusiLevelView:_btnClueOnClick()
	AergusiController.instance:openAergusiClueView()
end

function AergusiLevelView:_btntaskOnClick()
	AergusiController.instance:openAergusiTaskView()
end

function AergusiLevelView:_editableInitView()
	RedDotController.instance:addRedDot(self._goreddotreward, RedDotEnum.DotNode.V2a1AergusiTaskRed, VersionActivity2_1Enum.ActivityId.Aergusi)

	self._viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._stageAnimator = self._gostages:GetComponent(typeof(UnityEngine.Animator))
	self._taskAnimator = self._gotaskAni:GetComponent(typeof(UnityEngine.Animator))
	self._scrollcontent = self._gopath:GetComponent(gohelper.Type_LimitedScrollRect)
	self._drag = UIDragListenerHelper.New()

	self._drag:createByScrollRect(self._scrollcontent)

	self._levelItems = {}

	gohelper.setActive(self._gotime, false)

	self._btnimage_TryBtn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Try/image_TryBtn")
end

function AergusiLevelView:_setInitLevelPos()
	local maxUnlockIndex = AergusiModel.instance:getMaxUnlockEpisodeIndex()
	local posX = transformhelper.getLocalPos(self._goscrollcontent.transform)

	posX = 0.2 * (maxUnlockIndex - 3) * AergusiEnum.LevelScrollWidth < 0 and posX or posX - 0.2 * (maxUnlockIndex - 3) * AergusiEnum.LevelScrollWidth

	transformhelper.setLocalPos(self._goscrollcontent.transform, posX, 0, 0)
end

function AergusiLevelView:onUpdateParam()
	return
end

function AergusiLevelView:onOpen()
	self._viewCanvasGroup = self.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._viewCanvasGroup.enabled = false

	TaskDispatcher.runDelay(self._enableCanvasgroup, self, 0.7)
	self:_addEvents()
	self:_checkFirstEnter()
	self:_refreshItems()
	self:_refreshButtons()
	self:_refreshDeadline()
	self:_setInitLevelPos()
	TaskDispatcher.runRepeat(self._refreshDeadline, self, TimeUtil.OneMinuteSecond)
end

function AergusiLevelView:_enableCanvasgroup()
	self._viewCanvasGroup.enabled = true
end

function AergusiLevelView:_checkFirstEnter()
	local firstEnter = PlayerPrefsHelper.getNumber(PlayerPrefsKey.Version2_1FirstTimeEnter, 0)
	local firstEpisode = AergusiModel.instance:getFirstEpisode()
	local episodeMo = AergusiModel.instance:getEpisodeInfo(firstEpisode)

	if firstEnter == 0 and not episodeMo.passBeforeStory then
		AergusiModel.instance:setNewUnlockEpisode(firstEpisode)
	end

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.Version2_1FirstTimeEnter, 1)

	local newFinishEpisode = AergusiModel.instance:getNewFinishEpisode()
	local clueconfigs = AergusiModel.instance:getAllClues(false)
	local hasClueNotRead = AergusiModel.instance:hasClueNotRead(clueconfigs)

	gohelper.setActive(self._goeyelight, newFinishEpisode > 0 or hasClueNotRead)
	gohelper.setActive(self._govxget, newFinishEpisode > 0)
end

function AergusiLevelView:_refreshButtons()
	local firstEpisode = AergusiModel.instance:getFirstEpisode()
	local isClueUnlock = AergusiModel.instance:isEpisodePassed(firstEpisode)

	gohelper.setActive(self._btnClue.gameObject, isClueUnlock)

	local hasRewards = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a1AergusiTaskRed, VersionActivity2_1Enum.ActivityId.Aergusi)

	gohelper.setActive(self._gotaskAni, hasRewards)

	if hasRewards then
		self._taskAnimator:Play("loop", 0, 0)
	end
end

function AergusiLevelView:_refreshItems()
	local levelCos = AergusiModel.instance:getEpisodeInfos()
	local prefabPath = self.viewContainer:getSetting().otherRes[1]

	for i, v in ipairs(levelCos) do
		if not self._levelItems[v.episodeId] then
			local stageGo = gohelper.findChild(self._gostages, "stage" .. i)
			local cloneGo = self:getResInst(prefabPath, stageGo)

			self._levelItems[v.episodeId] = AergusiLevelItem.New()

			self._levelItems[v.episodeId]:init(cloneGo)
		end

		self._levelItems[v.episodeId]:refreshItem(v, i)
	end
end

function AergusiLevelView:_refreshDeadline()
	self._txtlimittime.text = ActivityHelper.getActivityRemainTimeStr(VersionActivity2_1Enum.ActivityId.Aergusi)
end

function AergusiLevelView:_onEnterEpisode(episodeId)
	self._isRestart = false

	AergusiModel.instance:setCurEpisode(episodeId)

	self._config = AergusiConfig.instance:getEpisodeConfig(nil, episodeId)
	self._isEpisodePassed = AergusiModel.instance:isEpisodePassed(self._config.episodeId)

	self:_startEnterGame()
end

function AergusiLevelView:_startEnterGame()
	local isStoryEpisode = AergusiModel.instance:isStoryEpisode(self._config.episodeId)

	if isStoryEpisode then
		self:_enterBeforeStory()
	else
		Activity163Rpc.instance:sendAct163StartEvidenceRequest(self._config.activityId, self._config.episodeId, self._enterBeforeStory, self)
	end
end

function AergusiLevelView:_enterBeforeStory()
	if self._config.beforeStoryId > 0 and not self._isRestart then
		local data = {}

		if not StoryModel.instance:isStoryFinished(self._config.beforeStoryId) then
			data.skipMessageId = MessageBoxIdDefine.Act163StorySkip
		end

		StoryController.instance:playStory(self._config.beforeStoryId, data, self._enterEvidence, self)
	else
		self:_enterEvidence()
	end
end

function AergusiLevelView:_enterEvidence()
	local isStoryEpisode = AergusiModel.instance:isStoryEpisode(self._config.episodeId)

	if not isStoryEpisode then
		local data = {}

		data.episodeId = self._config.episodeId
		data.callback = self._enterAfterStory
		data.callbackObj = self

		AergusiController.instance:openAergusiDialogView(data)
	else
		TaskDispatcher.runDelay(self._episodeFinished, self, 0.5)
		self:_enterAfterStory()
	end
end

function AergusiLevelView:_onRestartEvidence()
	self._isRestart = true

	self:_startEnterGame()
end

function AergusiLevelView:_enterAfterStory()
	if self._config.afterStoryId > 0 then
		local data = {}

		if not StoryModel.instance:isStoryFinished(self._config.afterStoryId) then
			data.skipMessageId = MessageBoxIdDefine.Act163StorySkip
		end

		StoryController.instance:playStory(self._config.afterStoryId, data, self._afterStoryFinished, self)
	else
		self:_episodeFinished()
	end
end

function AergusiLevelView:_afterStoryFinished()
	TaskDispatcher.runDelay(self._episodeFinished, self, 0.5)
end

function AergusiLevelView:_episodeFinished()
	if not self._isEpisodePassed then
		AergusiModel.instance:setNewFinishEpisode(self._config.episodeId)

		local nextEpisode = AergusiModel.instance:getEpisodeNextEpisode(self._config.episodeId)

		if nextEpisode > 0 then
			AergusiModel.instance:setNewUnlockEpisode(nextEpisode)
		end
	end

	self._viewAnimator:Play("open", 0, 0)
	self._stageAnimator:Play("open", 0, 0)

	self._viewCanvasGroup.enabled = false

	self:_setInitLevelPos()
	TaskDispatcher.runDelay(self._backLevel, self, 0.7)
end

function AergusiLevelView:_backLevel()
	self._viewCanvasGroup.enabled = true

	self:_checkFirstEnter()
	self:_refreshItems()
	self:_refreshButtons()
end

function AergusiLevelView:_onOperationFinished()
	self:_refreshItems()
	self:_refreshButtons()
end

function AergusiLevelView:_addEvents()
	AergusiController.instance:registerCallback(AergusiEvent.EnterEpisode, self._onEnterEpisode, self)
	AergusiController.instance:registerCallback(AergusiEvent.EvidenceFinished, self._enterAfterStory, self)
	AergusiController.instance:registerCallback(AergusiEvent.StartOperation, self._onOperationFinished, self)
	AergusiController.instance:registerCallback(AergusiEvent.RestartEvidence, self._onRestartEvidence, self)
	AergusiController.instance:registerCallback(AergusiEvent.OnClueReadUpdate, self._refreshButtons, self)
	self._drag:registerCallback(self._drag.EventBegin, self._onDragBegin, self)
	self._drag:registerCallback(self._drag.EventEnd, self._onDragEnd, self)
end

function AergusiLevelView:_onDragBegin()
	self._positionX = transformhelper.getPos(self._goscrollcontent.transform)

	AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_slide)
end

function AergusiLevelView:_onDragEnd()
	local posX = transformhelper.getPos(self._goscrollcontent.transform)

	if posX < self._positionX then
		self._stageAnimator:Play("slipleft", 0, 0)
	else
		self._stageAnimator:Play("slipright", 0, 0)
	end
end

function AergusiLevelView:_removeEvents()
	self._drag:release()
	AergusiController.instance:unregisterCallback(AergusiEvent.EnterEpisode, self._onEnterEpisode, self)
	AergusiController.instance:unregisterCallback(AergusiEvent.EvidenceFinished, self._enterAfterStory, self)
	AergusiController.instance:unregisterCallback(AergusiEvent.StartOperation, self._onOperationFinished, self)
	AergusiController.instance:unregisterCallback(AergusiEvent.RestartEvidence, self._onRestartEvidence, self)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClueReadUpdate, self._refreshButtons, self)
end

function AergusiLevelView:onClose()
	self._viewCanvasGroup.enabled = false

	self:_removeEvents()
end

function AergusiLevelView:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshDeadline, self)
	TaskDispatcher.cancelTask(self._backLevel, self)
	TaskDispatcher.cancelTask(self._episodeFinished, self)

	if self._levelItems then
		for _, v in pairs(self._levelItems) do
			v:destroy()
		end

		self._levelItems = nil
	end
end

local kJumpId = 10012118

function AergusiLevelView:_btnimage_TryBtnOnClick()
	GameFacade.jump(kJumpId)
end

return AergusiLevelView
