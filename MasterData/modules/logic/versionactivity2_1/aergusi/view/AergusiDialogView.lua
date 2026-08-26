-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiDialogView.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogView", package.seeall)

local AergusiDialogView = class("AergusiDialogView", BaseView)

function AergusiDialogView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._simagechatbg = gohelper.findChildSingleImage(self.viewGO, "#simage_chatbg")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")
	self._btnskip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_righttop/#btn_skip")
	self._imageskip = gohelper.findChildImage(self.viewGO, "#go_righttop/#btn_skip/#image_skip")
	self._btntimes = gohelper.findChildButtonWithAudio(self.viewGO, "#go_righttop/#btn_times")
	self._txttimes = gohelper.findChildText(self.viewGO, "#go_righttop/#btn_times/#txt_times")
	self._gotimelight = gohelper.findChild(self.viewGO, "#go_righttop/#btn_times/light")
	self._gotimegrey = gohelper.findChild(self.viewGO, "#go_righttop/#btn_times/grey")
	self._btnclue = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_clue")
	self._goeyegray = gohelper.findChild(self.viewGO, "#btn_clue/eye_grey")
	self._goeyelight = gohelper.findChild(self.viewGO, "#btn_clue/eye_light")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AergusiDialogView:addEvents()
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
	self._btntimes:AddClickListener(self._btntimesOnClick, self)
	self._btnclue:AddClickListener(self._btnclueOnClick, self)
end

function AergusiDialogView:removeEvents()
	self._btnskip:RemoveClickListener()
	self._btntimes:RemoveClickListener()
	self._btnclue:RemoveClickListener()
end

function AergusiDialogView:_btnskipOnClick()
	AergusiController.instance:dispatchEvent(AergusiEvent.EvidenceFinished)
	TaskDispatcher.runDelay(self.closeThis, self, 1)
end

function AergusiDialogView:_btntimesOnClick()
	local dialogShowing = AergusiDialogModel.instance:getShowingGroupState()

	if dialogShowing then
		return
	end

	local curGroupId = AergusiDialogModel.instance:getCurDialogGroup()
	local isInteractDialog = AergusiConfig.instance:getEvidenceConfig(curGroupId).dialogGroupType == AergusiEnum.DialogGroupType.Interact

	if not isInteractDialog then
		return
	end

	local nextPrompt = AergusiDialogModel.instance:getNextPromptOperate(false)

	if not nextPrompt then
		local data = AergusiDialogModel.instance:getLastPromptOperate(false)

		AergusiController.instance:dispatchEvent(AergusiEvent.OnClickShowResultTip, data)

		return
	end

	local actId = VersionActivity2_1Enum.ActivityId.Aergusi
	local episodeId = self.viewParam.episodeId
	local operationType = AergusiEnum.OperationType.Tip
	local params = ""

	Activity163Rpc.instance:sendAct163EvidenceOperationRequest(actId, episodeId, operationType, params, self._onShowTipFinished, self)
end

function AergusiDialogView:_onShowTipFinished(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local nextPrompt = AergusiDialogModel.instance:getNextPromptOperate(false)

	AergusiController.instance:dispatchEvent(AergusiEvent.OnClickShowResultTip, nextPrompt)
	AergusiDialogModel.instance:addPromptOperate(nextPrompt, false)
end

function AergusiDialogView:_btnclueOnClick()
	local groupId, stepId = AergusiDialogModel.instance:getCurDialogProcess()
	local curStepCo = AergusiConfig.instance:getDialogConfig(groupId, stepId)

	if curStepCo.nextStep == 0 and curStepCo.conditions ~= "" then
		local conditions = string.splitToNumber(curStepCo.condition, "#")

		if conditions[1] == AergusiEnum.OperationType.Submit then
			AergusiController.instance:dispatchEvent(AergusiEvent.OnClickEpisodeClueBtn)

			return
		end
	end

	local dialogShowing = AergusiDialogModel.instance:getShowingGroupState()
	local isInteractDialog = AergusiConfig.instance:getEvidenceConfig(groupId).dialogGroupType == AergusiEnum.DialogGroupType.Interact
	local data = {}

	data.episodeId = self.viewParam.episodeId
	data.groupId = groupId
	data.stepId = stepId
	data.couldPrompt = not dialogShowing and isInteractDialog

	AergusiController.instance:openAergusiClueView(data)
end

function AergusiDialogView:_editableInitView()
	AergusiDialogModel.instance:setUnlockAutoShow(false)
	AergusiDialogModel.instance:clearDialogProcess()
	self:_addEvents()

	self._startServerTime = ServerTime.now()
end

function AergusiDialogView:_refreshView()
	local episodeInfo = AergusiModel.instance:getEpisodeInfo(self.viewParam.episodeId)

	gohelper.setActive(self._btnskip.gameObject, episodeInfo.passEvidence)

	self._txttimes.text = AergusiDialogModel.instance:getLeftPromptTimes()

	local clueconfigs = AergusiModel.instance:getEpisodeClueConfigs(self.viewParam.episodeId, true)
	local hasClueNotRead = AergusiModel.instance:hasClueNotRead(clueconfigs)

	gohelper.setActive(self._goeyelight, hasClueNotRead)
	gohelper.setActive(self._goeyegray, not hasClueNotRead)

	local dialogShowing = AergusiDialogModel.instance:getShowingGroupState()
	local curGroupId = AergusiDialogModel.instance:getCurDialogGroup()
	local isInteractDialog = AergusiConfig.instance:getEvidenceConfig(curGroupId).dialogGroupType == AergusiEnum.DialogGroupType.Interact

	gohelper.setActive(self._gotimegrey, dialogShowing or not isInteractDialog)
	gohelper.setActive(self._gotimelight, not dialogShowing and isInteractDialog)
end

function AergusiDialogView:onOpen()
	self:_refreshView()

	local isEpisodePass = AergusiModel.instance:isEpisodePassed(self.viewParam.episodeId)
	local processes = AergusiModel.instance:getUnlockAutoTipProcess()

	if not isEpisodePass and processes[1] ~= 0 then
		AergusiDialogModel.instance:setUnlockAutoShow(true)
	end
end

function AergusiDialogView:onClose()
	return
end

function AergusiDialogView:_addEvents()
	self.addEventCb(self, AergusiController.instance, AergusiEvent.EvidenceError, self._onEvidenceError, self)
	self.addEventCb(self, AergusiController.instance, AergusiEvent.StartOperation, self._refreshView, self)
	self.addEventCb(self, AergusiController.instance, AergusiEvent.OnStartDialogNextStep, self._refreshView, self)
	self.addEventCb(self, AergusiController.instance, AergusiEvent.OnShowDialogGroupFinished, self._refreshView, self)
end

function AergusiDialogView:_removeEvents()
	self.removeEventCb(self, AergusiController.instance, AergusiEvent.EvidenceError, self._onEvidenceError, self)
	self.removeEventCb(self, AergusiController.instance, AergusiEvent.StartOperation, self._refreshView, self)
	self.removeEventCb(self, AergusiController.instance, AergusiEvent.OnStartDialogNextStep, self._refreshView, self)
	self.removeEventCb(self, AergusiController.instance, AergusiEvent.OnShowDialogGroupFinished, self._refreshView, self)
end

function AergusiDialogView:_onEvidenceError(stepCo, type)
	local bubbleId = 0
	local leftErrorTimes = AergusiDialogModel.instance:getLeftErrorTimes()

	if leftErrorTimes > 0 then
		bubbleId = AergusiConfig.instance:getEvidenceConfig(stepCo.id).errorTip
	else
		local episodeCo = AergusiConfig.instance:getEpisodeConfig(nil, self.viewParam.episodeId)

		bubbleId = episodeCo.failedId
	end

	local bubbleData = {}

	bubbleData.bubbleId = bubbleId
	bubbleData.callback = self._onShowBubbleFinished
	bubbleData.callbackObj = self

	AergusiController.instance:dispatchEvent(AergusiEvent.OnStartErrorBubbleDialog, bubbleData)
	self:_refreshView()
end

function AergusiDialogView:_onShowBubbleFinished()
	local leftErrorTimes = AergusiDialogModel.instance:getLeftErrorTimes()

	if leftErrorTimes <= 0 then
		local data = {}

		data.episodeId = self.viewParam.episodeId

		AergusiController.instance:openAergusiFailView(data)

		local clueList = {}
		local clueConfigs = AergusiModel.instance.instance:getEpisodeClueConfigs(self.viewParam.episodeId, true)

		for _, v in pairs(clueConfigs) do
			table.insert(clueList, v.clueName)
		end

		StatController.instance:track(StatEnum.EventName.ExitArgusActivity, {
			[StatEnum.EventProperties.EpisodeId] = tostring(self.viewParam.episodeId),
			[StatEnum.EventProperties.Result] = "Fail",
			[StatEnum.EventProperties.UseTime] = ServerTime.now() - self._startServerTime,
			[StatEnum.EventProperties.GoalNum] = AergusiDialogModel.instance:getFinishedTargetGroupCount(),
			[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
			[StatEnum.EventProperties.HoldClueName] = clueList
		})
	end
end

function AergusiDialogView:onDestroyView()
	AergusiDialogModel.instance:setUnlockAutoShow(false)
	TaskDispatcher.cancelTask(self.closeThis, self)
	self:_removeEvents()
end

return AergusiDialogView
