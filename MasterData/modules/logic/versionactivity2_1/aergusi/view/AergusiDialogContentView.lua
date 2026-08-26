-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiDialogContentView.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogContentView", package.seeall)

local AergusiDialogContentView = class("AergusiDialogContentView", BaseView)

function AergusiDialogContentView:onInitView()
	self._gonextstep = gohelper.findChild(self.viewGO, "#go_nextstep")
	self._godialoguecontainer = gohelper.findChild(self.viewGO, "#go_dialoguecontainer")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content")
	self._goleftdialogueitem = gohelper.findChild(self.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_leftdialogueitem")
	self._gorightdialogueitem = gohelper.findChild(self.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_rightdialogueitem")
	self._gosystemmessageitem = gohelper.findChild(self.viewGO, "#go_dialoguecontainer/Scroll View/Viewport/#go_content/#go_systemmessageitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AergusiDialogContentView:addEvents()
	self._scrollcontent:AddOnValueChanged(self._onScrollValueChanged, self)
	self._nextStepClick:AddClickListener(self._onClickNextStep, self)
	self._drag:AddDragBeginListener(self._onBeginDrag, self)
	self._drag:AddDragEndListener(self._onEndDrag, self)
	self._nextStepClick2:AddClickListener(self._onClickNextStep, self)
end

function AergusiDialogContentView:removeEvents()
	self._scrollcontent:RemoveOnValueChanged()
	self._nextStepClick:RemoveClickListener()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
	self._nextStepClick2:RemoveClickListener()
end

function AergusiDialogContentView:_editableInitView()
	self._itemRootGos = {
		[AergusiEnum.DialogType.NormalLeft] = self._goleftdialogueitem,
		[AergusiEnum.DialogType.NormalRight] = self._gorightdialogueitem,
		[AergusiEnum.DialogType.SystemMsg] = self._gosystemmessageitem
	}
	self._scrollcontent = gohelper.findChildScrollRect(self.viewGO, "#go_dialoguecontainer/Scroll View")
	self._contentMinHeight = recthelper.getHeight(self._scrollcontent.transform)
	self._nextStepClick = gohelper.getClickWithDefaultAudio(self._gonextstep)
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._scrollcontent.gameObject)
	self._nextStepClick2 = gohelper.getClickWithDefaultAudio(self._scrollcontent.gameObject)
	self._rectTrContent = self._gocontent.transform

	for _, go in pairs(self._itemRootGos) do
		gohelper.setActive(go, false)
	end

	self._dialogueItemList = {}
	self._contentHeight = 0
	self._startServerTime = ServerTime.now()

	self:_addEvents()
end

function AergusiDialogContentView:_onScrollValueChanged()
	gohelper.setActive(self._goArrow, self._scrollcontent.verticalNormalizedPosition >= 0.01)
end

function AergusiDialogContentView:_onClickNextStep()
	if self._dragging then
		return
	end

	self:_playNext()
end

function AergusiDialogContentView:_onBeginDrag()
	self._dragging = true
end

function AergusiDialogContentView:_onEndDrag()
	self._dragging = false
end

function AergusiDialogContentView:onOpen()
	self._config = AergusiConfig.instance:getEpisodeConfig(nil, self.viewParam.episodeId)
	self.stepCoList = {}

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("waitOpen")
	TaskDispatcher.runDelay(self._startInitGroup, self, 0.83)
end

function AergusiDialogContentView:_startInitGroup()
	UIBlockMgr.instance:endBlock("waitOpen")

	local groupId = AergusiDialogModel.instance:getCurDialogGroup()

	self:_playGroup(groupId)
end

function AergusiDialogContentView:_playGroup(groupId, qutationStepCo)
	AergusiDialogModel.instance:addTargetGroup(groupId)
	AergusiDialogModel.instance:setDialogGroup(groupId)
	AergusiDialogModel.instance:setShowingGroup(true)
	AergusiController.instance:dispatchEvent(AergusiEvent.OnStartDialogGroup)
	self:_addStepList(groupId)
	self:_playNext(qutationStepCo)
end

function AergusiDialogContentView:_addStepList(groupId)
	local stepList = AergusiDialogModel.instance:getDialogStepList(groupId)

	for i = #stepList, 1, -1 do
		table.insert(self.stepCoList, stepList[i])
	end
end

function AergusiDialogContentView:_playNext(qutationStepCo)
	local leftError = AergusiDialogModel.instance:getLeftErrorTimes()

	if leftError <= 0 then
		return
	end

	local stepCo = self:_popNextStep()

	if not stepCo then
		self:_setDialogGroupDone()

		return
	end

	self._stepCo = stepCo

	local processes = AergusiModel.instance:getUnlockAutoTipProcess()

	if self._stepCo.id == processes[1] and self._stepCo.stepId == processes[2] then
		AergusiDialogModel.instance:setUnlockAutoShow(false)
	end

	local type = self._stepCo.pos
	local go = gohelper.cloneInPlace(self._itemRootGos[type])
	local item = AergusiDialogItem.CreateItem(self._stepCo, go, self._contentHeight, type)

	if type == AergusiEnum.DialogPos.Right then
		item:setQutation(qutationStepCo)
	end

	for _, v in pairs(self._dialogueItemList) do
		v:refresh()
	end

	table.insert(self._dialogueItemList, item)
	UIBlockMgr.instance:startBlock("waitOpen")
	AergusiDialogModel.instance:setCurDialogProcess(stepCo.id, stepCo.stepId)
	TaskDispatcher.runDelay(self._startDialogNextStep, self, 0.1)
end

function AergusiDialogContentView:_startDialogNextStep()
	UIBlockMgr.instance:endBlock("waitOpen")
	self:_setDialogRt()
	AergusiController.instance:dispatchEvent(AergusiEvent.OnStartDialogNextStep, self._stepCo)
	self:_checkAutoOperate()
end

function AergusiDialogContentView:_setDialogRt()
	self._contentHeight = self._contentHeight + self._dialogueItemList[#self._dialogueItemList]:getHeight() + AergusiEnum.IntervalY

	recthelper.setHeight(self._rectTrContent, Mathf.Max(self._contentHeight, self._contentMinHeight))
	self:playUpAnimation()
end

function AergusiDialogContentView:_checkAutoOperate()
	if self._stepCo.condition ~= "" then
		local conditions = string.splitToNumber(self._stepCo.condition, "#")

		if conditions[1] == AergusiEnum.OperationType.AutoBubble then
			local data = {}

			data.stepCo = self._stepCo

			AergusiController.instance:dispatchEvent(AergusiEvent.OnStartAutoBubbleDialog, data)
		elseif conditions[1] == AergusiEnum.OperationType.GetClue then
			local actId = VersionActivity2_1Enum.ActivityId.Aergusi
			local episodeId = self.viewParam.episodeId
			local operationType = AergusiEnum.OperationType.GetClue
			local params = string.format("%s", self._stepCo.stepId)

			Activity163Rpc.instance:sendAct163EvidenceOperationRequest(actId, episodeId, operationType, params, self._onGetClueFinished, self)
		end
	end
end

function AergusiDialogContentView:_onGetClueFinished(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	GameFacade.showToast(ToastEnum.Act163GetClueTip)
end

function AergusiDialogContentView:_setDialogGroupDone()
	local dialogShowing = AergusiDialogModel.instance:getShowingGroupState()

	if not dialogShowing then
		return
	end

	local groupId = AergusiDialogModel.instance:getCurDialogGroup()
	local groupCo = AergusiConfig.instance:getEvidenceConfig(groupId)

	if groupCo.dialogGroupType == AergusiEnum.DialogGroupType.Normal then
		self:_onShowingGroupFinished()
	else
		AergusiController.instance:openAergusiDialogStartView(groupId, self._onShowingGroupFinished, self)
	end
end

function AergusiDialogContentView:_onShowingGroupFinished()
	local groupId = AergusiDialogModel.instance:getCurDialogGroup()
	local groupCo = AergusiConfig.instance:getEvidenceConfig(groupId)

	AergusiDialogModel.instance:setShowingGroup(groupCo.dialogGroupType == AergusiEnum.DialogGroupType.Normal)
	AergusiController.instance:dispatchEvent(AergusiEvent.OnShowDialogGroupFinished, groupId)

	local isInteractDialog = AergusiConfig.instance:getEvidenceConfig(groupId).dialogGroupType == AergusiEnum.DialogGroupType.Interact

	if isInteractDialog then
		local nextPrompt = AergusiDialogModel.instance:getNextPromptOperate(false)
		local stepCo = AergusiConfig.instance:getDialogConfig(nextPrompt.groupId, nextPrompt.stepId)
		local conditions = string.splitToNumber(stepCo.condition, "#")

		if conditions[1] == AergusiEnum.OperationType.Refutation then
			AergusiController.instance:dispatchEvent(AergusiEvent.OnGuideEnterInteractRefutation)
		elseif conditions[1] == AergusiEnum.OperationType.Probe then
			AergusiController.instance:dispatchEvent(AergusiEvent.OnGuideEnterInteractProbe)
		end
	end

	if self._stepCo.condition ~= "" then
		local conditions = string.splitToNumber(self._stepCo.condition, "#")

		if conditions[1] == AergusiEnum.OperationType.NextDialogs then
			local actId = VersionActivity2_1Enum.ActivityId.Aergusi
			local episodeId = self.viewParam.episodeId
			local operationType = AergusiEnum.OperationType.NextDialogs
			local params = ""

			Activity163Rpc.instance:sendAct163EvidenceOperationRequest(actId, episodeId, operationType, params, self._onNextDialogFinished, self)
		elseif conditions[1] == AergusiEnum.OperationType.Submit then
			self:_checkWaitGuide(conditions[3])
		elseif conditions[1] == AergusiEnum.OperationType.EndEpisode then
			local actId = VersionActivity2_1Enum.ActivityId.Aergusi
			local episodeId = self.viewParam.episodeId
			local operationType = AergusiEnum.OperationType.EndEpisode
			local params = ""

			UIBlockMgr.instance:startBlock("waitEndEpisode")
			Activity163Rpc.instance:sendAct163EvidenceOperationRequest(actId, episodeId, operationType, params, self._onEndEpisode, self)
		end
	end

	local processes = AergusiModel.instance:getUnlockAutoTipProcess()

	if self._stepCo.id == processes[1] and self._stepCo.stepId == processes[2] then
		AergusiDialogModel.instance:setUnlockAutoShow(false)
	end
end

function AergusiDialogContentView:_checkWaitGuide(groupId)
	self._groupId = groupId

	if self._stepCo.id == AergusiEnum.FirstGroupId and self._stepCo.stepId == AergusiEnum.FirstGroupLastStepId and not GuideModel.instance:isGuideFinish(AergusiEnum.FirstDialogGuideId) and not GuideController.instance:isForbidGuides() then
		GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, self._onGuideFinish, self)

		return
	end

	self:_openClue()
end

function AergusiDialogContentView:_onGuideFinish(guideId)
	if guideId ~= AergusiEnum.FirstDialogGuideId then
		return
	end

	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, self._onGuideFinish, self)
	self:_openClue()
end

function AergusiDialogContentView:_openClue()
	local data = {}

	data.episodeId = self.viewParam.episodeId
	data.type = AergusiEnum.OperationType.Submit
	data.groupId = self._groupId
	data.stepId = self._stepCo.stepId
	data.couldPrompt = true
	data.callback = self._onSubmitEvidenceFinished
	data.callbackObj = self

	AergusiController.instance:openAergusiClueView(data)
end

function AergusiDialogContentView:_onEndEpisode(cmd, resultCode)
	UIBlockMgr.instance:endBlock("waitEndEpisode")

	local clueList = {}
	local clueConfigs = AergusiModel.instance.instance:getEpisodeClueConfigs(self.viewParam.episodeId, true)

	for _, v in pairs(clueConfigs) do
		table.insert(clueList, v.clueName)
	end

	if resultCode ~= 0 then
		StatController.instance:track(StatEnum.EventName.ExitArgusActivity, {
			[StatEnum.EventProperties.EpisodeId] = tostring(self.viewParam.episodeId),
			[StatEnum.EventProperties.Result] = "Abort",
			[StatEnum.EventProperties.UseTime] = ServerTime.now() - self._startServerTime,
			[StatEnum.EventProperties.GoalNum] = AergusiDialogModel.instance:getFinishedTargetGroupCount(),
			[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
			[StatEnum.EventProperties.HoldClueName] = clueList
		})
		self:closeThis()

		return
	end

	StatController.instance:track(StatEnum.EventName.ExitArgusActivity, {
		[StatEnum.EventProperties.EpisodeId] = tostring(self.viewParam.episodeId),
		[StatEnum.EventProperties.Result] = "Success",
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - self._startServerTime,
		[StatEnum.EventProperties.GoalNum] = AergusiDialogModel.instance:getFinishedTargetGroupCount() + 1,
		[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
		[StatEnum.EventProperties.HoldClueName] = clueList
	})
	AergusiController.instance:openAergusiDialogEndView(self.viewParam.episodeId, self._realClose, self)
end

function AergusiDialogContentView:_realClose()
	if self.viewParam and self.viewParam.callback then
		self.viewParam.callback(self.viewParam.callbackObj)
	end

	TaskDispatcher.runDelay(self._waitStoryPlay, self, 1)
end

function AergusiDialogContentView:_waitStoryPlay()
	self:closeThis()
end

function AergusiDialogContentView:_onNextDialogFinished(cmd, resultCode)
	if resultCode ~= 0 then
		self:closeThis()

		return
	end

	local conditions = string.splitToNumber(self._stepCo.condition, "#")

	self:_playGroup(conditions[2])
end

function AergusiDialogContentView:_onSubmitEvidenceFinished(groupId)
	if groupId == -1 then
		AergusiDialogModel.instance:setShowingGroup(true)

		return
	end

	if not groupId or groupId == 0 then
		AergusiDialogModel.instance:setShowingGroup(true)

		local groupId, stepId = AergusiDialogModel.instance:getCurDialogProcess()
		local curStepCo = AergusiConfig.instance:getDialogConfig(groupId, stepId)
		local type = AergusiEnum.OperationType.Submit

		AergusiController.instance:dispatchEvent(AergusiEvent.EvidenceError, curStepCo, type)

		return
	end

	self:_playGroup(groupId)
end

function AergusiDialogContentView:_popNextStep()
	local stepLen = #self.stepCoList

	if stepLen <= 0 then
		return
	end

	self.stepCoList[stepLen] = nil

	return self.stepCoList[stepLen]
end

function AergusiDialogContentView:playUpAnimation()
	if self._contentHeight <= self._contentMinHeight then
		return
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(self._scrollcontent.verticalNormalizedPosition, 0, 0.5, self._frameUpdate, self._frameFinished, self)
end

function AergusiDialogContentView:_frameUpdate(value)
	self._scrollcontent.verticalNormalizedPosition = value
end

function AergusiDialogContentView:_frameFinished()
	gohelper.setActive(self._goArrow, false)
end

function AergusiDialogContentView:onClose()
	return
end

function AergusiDialogContentView:_addEvents()
	self.addEventCb(self, AergusiController.instance, AergusiEvent.OnRefuteStartGroup, self._OnRefuteStartGroup, self)
	self.addEventCb(self, AergusiController.instance, AergusiEvent.OnDialogAskSuccess, self._onDialogAskSuccess, self)
	self.addEventCb(self, AergusiController.instance, AergusiEvent.OnClickEpisodeClueBtn, self._onEpisodeClueBtnClick, self)
end

function AergusiDialogContentView:_removeEvents()
	self.removeEventCb(self, AergusiController.instance, AergusiEvent.OnRefuteStartGroup, self._OnRefuteStartGroup, self)
	self.removeEventCb(self, AergusiController.instance, AergusiEvent.OnDialogAskSuccess, self._onDialogAskSuccess, self)
	self.removeEventCb(self, AergusiController.instance, AergusiEvent.OnClickEpisodeClueBtn, self._onEpisodeClueBtnClick, self)
end

function AergusiDialogContentView:_OnRefuteStartGroup(groupId)
	self:_playGroup(groupId)
end

function AergusiDialogContentView:_onDialogAskSuccess(stepCo)
	local conditions = string.splitToNumber(stepCo.condition, "#")

	self:_playGroup(conditions[2], stepCo)
end

function AergusiDialogContentView:_onEpisodeClueBtnClick()
	self:_setDialogGroupDone()
end

function AergusiDialogContentView:onDestroyView()
	UIBlockMgr.instance:endBlock("waitOpen")
	TaskDispatcher.cancelTask(self._startInitGroup, self)
	TaskDispatcher.cancelTask(self._waitStoryPlay, self)
	self:_removeEvents()

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	for _, item in ipairs(self._dialogueItemList) do
		item:destroy()
	end
end

return AergusiDialogContentView
