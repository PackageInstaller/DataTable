-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiDialogNormalLeftItem.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogNormalLeftItem", package.seeall)

local AergusiDialogNormalLeftItem = class("AergusiDialogNormalLeftItem", AergusiDialogItem)

function AergusiDialogNormalLeftItem:initView()
	self._gorolebg = gohelper.findChild(self.go, "rolebg")
	self._simageAvatar = gohelper.findChildSingleImage(self.go, "rolebg/image_avatar")
	self._gorolebggrey = gohelper.findChild(self.go, "rolebg_grey")
	self._simageAvatarGrey = gohelper.findChildSingleImage(self.go, "rolebg_grey/image_avatar")
	self._txtName = gohelper.findChildText(self.go, "name")
	self._txtNameGrey = gohelper.findChildText(self.go, "name_grey")
	self._goselectframe = gohelper.findChild(self.go, "content_bg/selectframe")
	self._txtContent = gohelper.findChildText(self.go, "content_bg/txt_content")
	self._contentRt = self._txtContent:GetComponent(gohelper.Type_RectTransform)
	self._btndoubted = gohelper.findChildButtonWithAudio(self.go, "content_bg/#btn_doubted")
	self._godoubted = gohelper.findChild(self.go, "content_bg/#go_doubted")
	self._btnobjection = gohelper.findChildButtonWithAudio(self.go, "content_bg/#go_doubted/#btn_objection")
	self._goobjectionmask = gohelper.findChild(self.go, "content_bg/#go_doubted/#btn_objection/mask")
	self._goobjectionselectframe = gohelper.findChild(self.go, "content_bg/#go_doubted/#btn_objection/selectframe")

	gohelper.setActive(self._goobjectionselectframe, false)

	self._btnask = gohelper.findChildButtonWithAudio(self.go, "content_bg/#go_doubted/#btn_ask")
	self._goaskmask = gohelper.findChild(self.go, "content_bg/#go_doubted/#btn_ask/mask")
	self._goaskselectframe = gohelper.findChild(self.go, "content_bg/#go_doubted/#btn_ask/selectframe")

	gohelper.setActive(self._goaskselectframe, false)

	self._btnclose = gohelper.findChildButtonWithAudio(self.go, "content_bg/#go_doubted/#btn_close")
	self._gomaskgrey = gohelper.findChild(self.go, "content_bg/mask_grey")
	self._contentBgRt = gohelper.findChildComponent(self.go, "content_bg", gohelper.Type_RectTransform)
	self._doubting = false
	self.go.name = string.format("normalleftitem_%s_%s", self.stepCo.id, self.stepCo.stepId)

	AudioMgr.instance:trigger(AudioEnum.Dialogue.play_ui_wulu_duihua)
	self:_addEvents()
end

function AergusiDialogNormalLeftItem:refresh()
	local curGroupId = AergusiDialogModel.instance:getCurDialogGroup()

	gohelper.setActive(self._gorolebg, curGroupId == self.stepCo.id)
	gohelper.setActive(self._gorolebggrey, curGroupId ~= self.stepCo.id)
	gohelper.setActive(self._txtName.gameObject, curGroupId == self.stepCo.id)
	gohelper.setActive(self._txtNameGrey.gameObject, curGroupId ~= self.stepCo.id)
	gohelper.setActive(self._gomaskgrey, curGroupId ~= self.stepCo.id)

	local isGroupShowing = AergusiDialogModel.instance:getShowingGroupState()
	local isInteractDialog = AergusiConfig.instance:getEvidenceConfig(self.stepCo.id).dialogGroupType == AergusiEnum.DialogGroupType.Interact

	gohelper.setActive(self._btndoubted.gameObject, isInteractDialog and not self._doubting and not isGroupShowing and curGroupId == self.stepCo.id)

	local var_2_0

	if isInteractDialog then
		::label_2_0::

		var_2_0 = self._doubting and not isGroupShowing and curGroupId == self.stepCo.id
	end

	gohelper.setActive(self._godoubted, var_2_0)

	if curGroupId ~= self.stepCo.id then
		gohelper.setActive(self._goselectframe, false)
	end

	self._simageAvatar:LoadImage(ResUrl.getHeadIconSmall(self.stepCo.speakerIcon))
	self._simageAvatarGrey:LoadImage(ResUrl.getHeadIconSmall(self.stepCo.speakerIcon))

	self._txtName.text = self.stepCo.speaker
	self._txtNameGrey.text = self.stepCo.speaker
	self._txtContent.text = self.stepCo.content

	local askdata = {}

	askdata.groupId = self.stepCo.id
	askdata.stepId = self.stepCo.stepId
	askdata.type = AergusiEnum.OperationType.Probe

	local isAskError = AergusiDialogModel.instance:isOperateHasError(askdata)

	gohelper.setActive(self._goaskmask, isAskError)

	local objectiondata = {}

	objectiondata.groupId = self.stepCo.id
	objectiondata.stepId = self.stepCo.stepId
	objectiondata.type = AergusiEnum.OperationType.Refutation

	local isObjectionError = AergusiDialogModel.instance:isOperateHasError(objectiondata)
	local isTargetStep = false

	if self.stepCo.condition ~= "" then
		local conditions = string.splitToNumber(self.stepCo.condition, "#")

		if conditions[1] == AergusiEnum.OperationType.Refutation then
			isTargetStep = true
		end
	end

	gohelper.setActive(self._goobjectionmask, isObjectionError and not isTargetStep)
end

function AergusiDialogNormalLeftItem:calculateHeight()
	local width = self._txtContent.preferredWidth

	if width <= AergusiEnum.MessageTxtMaxWidth then
		local contentBgHeight = AergusiEnum.MessageTxtOneLineHeight + AergusiEnum.MessageBgOffsetHeight

		recthelper.setSize(self._contentBgRt, width + AergusiEnum.MessageBgOffsetWidth, contentBgHeight)
		recthelper.setSize(self._contentRt, width, AergusiEnum.MessageTxtOneLineHeight)

		return
	end

	width = AergusiEnum.MessageTxtMaxWidth

	local height = self._txtContent.preferredHeight
	local contentBgHeight = height + AergusiEnum.MessageBgOffsetHeight

	recthelper.setSize(self._contentBgRt, AergusiEnum.MessageTxtMaxWidth + AergusiEnum.MessageBgOffsetWidth, contentBgHeight)
	recthelper.setSize(self._contentRt, width, height)
end

function AergusiDialogNormalLeftItem:getHeight()
	local width = self._txtContent.preferredWidth

	if width <= AergusiEnum.MessageTxtMaxWidth then
		local contentBgHeight = AergusiEnum.MessageTxtOneLineHeight + AergusiEnum.MessageBgOffsetHeight

		self.height = Mathf.Max(AergusiEnum.MinHeight[self.type] + AergusiEnum.DialogDoubtOffsetHeight, contentBgHeight + AergusiEnum.MessageNameHeight + AergusiEnum.DialogDoubtOffsetHeight)

		return self.height
	end

	width = AergusiEnum.MessageTxtMaxWidth

	local height = AergusiEnum.MessageTxtOneLineHeight * self._txtContent:GetTextInfo(self.stepCo.content).lineCount
	local contentBgHeight = height + AergusiEnum.MessageBgOffsetHeight

	self.height = Mathf.Max(AergusiEnum.MinHeight[self.type] + AergusiEnum.DialogDoubtOffsetHeight, contentBgHeight + AergusiEnum.MessageNameHeight + AergusiEnum.DialogDoubtOffsetHeight)

	return self.height
end

function AergusiDialogNormalLeftItem:_addEvents()
	self._btndoubted:AddClickListener(self._btndoubtedOnClick, self)
	self._btnobjection:AddClickListener(self._btnobjectionOnClick, self)
	self._btnask:AddClickListener(self._btnaskOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, AergusiController.instance, AergusiEvent.OnShowDialogGroupFinished, self._onShowDialogGroupFinished, self)
	self.addEventCb(self, AergusiController.instance, AergusiEvent.OnClickShowResultTip, self._onShowTips, self)
	self.addEventCb(self, AergusiController.instance, AergusiEvent.OnDialogDoubtClick, self._onDialogDoubtClick, self)
end

function AergusiDialogNormalLeftItem:_removeEvents()
	self._btndoubted:RemoveClickListener()
	self._btnobjection:RemoveClickListener()
	self._btnask:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, AergusiController.instance, AergusiEvent.OnShowDialogGroupFinished, self._onShowDialogGroupFinished, self)
	self.removeEventCb(self, AergusiController.instance, AergusiEvent.OnClickShowResultTip, self._onShowTips, self)
	self.removeEventCb(self, AergusiController.instance, AergusiEvent.OnDialogDoubtClick, self._onDialogDoubtClick, self)
end

function AergusiDialogNormalLeftItem:_onShowDialogGroupFinished()
	self:refresh()

	if AergusiDialogModel.instance:getUnlockAutoShow() then
		local data = AergusiDialogModel.instance:getNextPromptOperate(false)

		self:_onShowTips(data)
	end
end

function AergusiDialogNormalLeftItem:_onShowTips(data)
	if self.stepCo.id == data.groupId and self.stepCo.stepId == data.stepId then
		if data.type == AergusiEnum.OperationType.Refutation then
			AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_pop)
			gohelper.setActive(self._btndoubted.gameObject, false)
			gohelper.setActive(self._godoubted, true)
			gohelper.setActive(self._goselectframe, true)
			gohelper.setActive(self._goobjectionselectframe, true)
			gohelper.setActive(self._goaskselectframe, false)
		elseif data.type == AergusiEnum.OperationType.Probe then
			AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_pop)
			gohelper.setActive(self._btndoubted.gameObject, false)
			gohelper.setActive(self._godoubted, true)
			gohelper.setActive(self._goselectframe, true)
			gohelper.setActive(self._goobjectionselectframe, false)
			gohelper.setActive(self._goaskselectframe, true)
		end
	else
		gohelper.setActive(self._goselectframe, false)
		gohelper.setActive(self._godoubted, false)

		local isInteractDialog = AergusiConfig.instance:getEvidenceConfig(self.stepCo.id).dialogGroupType == AergusiEnum.DialogGroupType.Interact

		gohelper.setActive(self._btndoubted.gameObject, isInteractDialog)
	end
end

function AergusiDialogNormalLeftItem:_onDialogDoubtClick(stepCo)
	if stepCo.id == self.stepCo.id and stepCo.stepId == self.stepCo.stepId then
		self._doubting = true
	else
		gohelper.setActive(self._goselectframe, false)

		self._doubting = false
	end

	self:refresh()
end

function AergusiDialogNormalLeftItem:_btndoubtedOnClick()
	AergusiController.instance:dispatchEvent(AergusiEvent.OnDialogDoubtClick, self.stepCo)
end

function AergusiDialogNormalLeftItem:_btnobjectionOnClick()
	local groupId = 0

	if self.stepCo.condition ~= "" then
		local conditions = string.splitToNumber(self.stepCo.condition, "#")

		if conditions[1] == AergusiEnum.OperationType.Refutation then
			groupId = conditions[3]
		end
	end

	local data = {}

	data.episodeId = AergusiModel.instance:getCurEpisode()
	data.type = AergusiEnum.OperationType.Refutation
	data.groupId = groupId
	data.stepId = self.stepCo.stepId
	data.couldPrompt = true
	data.callback = self._onRefuteEvidenceFinished
	data.callbackObj = self

	AergusiController.instance:openAergusiClueView(data)
end

function AergusiDialogNormalLeftItem:_onRefuteEvidenceFinished(groupId)
	if groupId < 0 then
		return
	end

	if groupId > 0 then
		AergusiController.instance:dispatchEvent(AergusiEvent.OnRefuteStartGroup, groupId)
	else
		self:refresh()

		local type = AergusiEnum.OperationType.Refutation

		AergusiController.instance:dispatchEvent(AergusiEvent.EvidenceError, self.stepCo, type)
	end
end

function AergusiDialogNormalLeftItem:_btnaskOnClick()
	if self.stepCo.condition ~= "" then
		local conditions = string.splitToNumber(self.stepCo.condition, "#")

		if conditions[1] == AergusiEnum.OperationType.NotKeyProbe then
			local clueList = {}
			local episodeId = AergusiModel.instance:getCurEpisode()
			local clueConfigs = AergusiModel.instance.instance:getEpisodeClueConfigs(episodeId, true)

			for _, v in pairs(clueConfigs) do
				table.insert(clueList, v.clueName)
			end

			StatController.instance:track(StatEnum.EventName.AergusiProbe, {
				[StatEnum.EventProperties.EpisodeId] = tostring(episodeId),
				[StatEnum.EventProperties.TargetTip] = AergusiConfig.instance:getEvidenceConfig(self.stepCo.id).conditionStr,
				[StatEnum.EventProperties.ProbeDialogId] = tostring(self.stepCo.id),
				[StatEnum.EventProperties.ProbeStepId] = tostring(self.stepCo.stepId),
				[StatEnum.EventProperties.ProbeResult] = "NotKey Probe",
				[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
				[StatEnum.EventProperties.HoldClueName] = clueList
			})

			local bubbleGroupId = conditions[2]

			AergusiController.instance:dispatchEvent(AergusiEvent.OnDialogNotKeyAsk, bubbleGroupId)

			return
		end
	end

	local actId = VersionActivity2_1Enum.ActivityId.Aergusi
	local episodeId = AergusiModel.instance:getCurEpisode()
	local operationType = AergusiEnum.OperationType.Probe
	local curStep = self.stepCo.stepId
	local params = string.format("%s", curStep)

	Activity163Rpc.instance:sendAct163EvidenceOperationRequest(actId, episodeId, operationType, params, self._onAskFinished, self)
end

function AergusiDialogNormalLeftItem:_onAskFinished(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local clueList = {}
	local episodeId = AergusiModel.instance:getCurEpisode()
	local clueConfigs = AergusiModel.instance.instance:getEpisodeClueConfigs(episodeId, true)

	for _, v in pairs(clueConfigs) do
		table.insert(clueList, v.clueName)
	end

	if msg.operationResult == "0" then
		StatController.instance:track(StatEnum.EventName.AergusiProbe, {
			[StatEnum.EventProperties.EpisodeId] = tostring(episodeId),
			[StatEnum.EventProperties.TargetTip] = AergusiConfig.instance:getEvidenceConfig(self.stepCo.id).conditionStr,
			[StatEnum.EventProperties.ProbeDialogId] = tostring(self.stepCo.id),
			[StatEnum.EventProperties.ProbeStepId] = tostring(self.stepCo.stepId),
			[StatEnum.EventProperties.ProbeResult] = "Key Probe",
			[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
			[StatEnum.EventProperties.HoldClueName] = clueList
		})
		AergusiController.instance:dispatchEvent(AergusiEvent.OnDialogAskSuccess, self.stepCo)
	else
		StatController.instance:track(StatEnum.EventName.AergusiProbe, {
			[StatEnum.EventProperties.EpisodeId] = tostring(episodeId),
			[StatEnum.EventProperties.TargetTip] = AergusiConfig.instance:getEvidenceConfig(self.stepCo.id).conditionStr,
			[StatEnum.EventProperties.ProbeDialogId] = tostring(self.stepCo.id),
			[StatEnum.EventProperties.ProbeStepId] = tostring(self.stepCo.stepId),
			[StatEnum.EventProperties.ProbeResult] = "Invalid Probe",
			[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
			[StatEnum.EventProperties.HoldClueName] = clueList
		})

		local data = {}

		data.groupId = self.stepCo.id
		data.stepId = self.stepCo.stepId
		data.type = AergusiEnum.OperationType.Probe

		AergusiDialogModel.instance:addErrorOperate(data)
		self:refresh()
		AergusiController.instance:dispatchEvent(AergusiEvent.OnDialogAskFail, self.stepCo)
	end
end

function AergusiDialogNormalLeftItem:_btncloseOnClick()
	self._doubting = false

	self:refresh()
end

function AergusiDialogNormalLeftItem:onDestroy()
	self:_removeEvents()
	self._simageAvatar:UnLoadImage()
	self._simageAvatarGrey:UnLoadImage()
end

return AergusiDialogNormalLeftItem
