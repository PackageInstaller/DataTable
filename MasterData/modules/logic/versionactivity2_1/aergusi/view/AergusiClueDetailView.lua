-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiClueDetailView.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiClueDetailView", package.seeall)

local AergusiClueDetailView = class("AergusiClueDetailView", BaseView)

function AergusiClueDetailView:onInitView()
	self._gocluedetail = gohelper.findChild(self.viewGO, "Right/#go_cluedetail")
	self._goevidence = gohelper.findChild(self.viewGO, "Right/#go_cluedetail/evidence")
	self._simageclueitem = gohelper.findChildSingleImage(self.viewGO, "Right/#go_cluedetail/evidence/#simage_clueitem")
	self._txtcluename = gohelper.findChildText(self.viewGO, "Right/#go_cluedetail/evidence/#txt_cluename")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "Right/#go_cluedetail/#scroll_desc")
	self._godesccontent = gohelper.findChild(self.viewGO, "Right/#go_cluedetail/#scroll_desc/Viewport/#go_desccontent")
	self._godescitem = gohelper.findChild(self.viewGO, "Right/#go_cluedetail/#scroll_desc/Viewport/#go_desccontent/#go_descitem")
	self._btnevidence = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_cluedetail/#btn_evidence")
	self._imageEvidence = gohelper.findChildImage(self.viewGO, "Right/#go_cluedetail/#btn_evidence")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AergusiClueDetailView:addEvents()
	self._btnevidence:AddClickListener(self._btnevidenceOnClick, self)
end

function AergusiClueDetailView:removeEvents()
	self._btnevidence:RemoveClickListener()
end

function AergusiClueDetailView:_btnevidenceOnClick()
	local actId = VersionActivity2_1Enum.ActivityId.Aergusi
	local episodeId = self.viewParam.episodeId
	local operationType = self.viewParam.type
	local curStep = self.viewParam.stepId
	local params = string.format("%s#%s", curStep, AergusiModel.instance:getCurClueId())

	Activity163Rpc.instance:sendAct163EvidenceOperationRequest(actId, episodeId, operationType, params, self._evidenceFinished, self)
end

function AergusiClueDetailView:_evidenceFinished(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local groupId = 0
	local clueList = {}
	local clueConfigs = AergusiModel.instance.instance:getEpisodeClueConfigs(self.viewParam.episodeId, true)

	for _, v in pairs(clueConfigs) do
		table.insert(clueList, v.clueName)
	end

	local clueId = AergusiModel.instance:getCurClueId()
	local curGroupId = AergusiDialogModel.instance:getCurDialogGroup()

	if msg.operationResult == "0" then
		groupId = self.viewParam.groupId

		StatController.instance:track(StatEnum.EventName.AergusiClueInteractive, {
			[StatEnum.EventProperties.EpisodeId] = tostring(self.viewParam.episodeId),
			[StatEnum.EventProperties.ClueInteractiveType] = self.viewParam.type == AergusiEnum.OperationType.Refutation and "Refute" or "Evidence",
			[StatEnum.EventProperties.TargetTip] = AergusiConfig.instance:getEvidenceConfig(curGroupId).conditionStr,
			[StatEnum.EventProperties.ClueId] = tostring(clueId),
			[StatEnum.EventProperties.ClueName] = AergusiConfig.instance:getClueConfig(clueId).clueName,
			[StatEnum.EventProperties.RefuteDialogId] = tostring(curGroupId),
			[StatEnum.EventProperties.RefuteStepId] = tostring(self.viewParam.stepId),
			[StatEnum.EventProperties.ClueInteractiveResult] = "Success",
			[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
			[StatEnum.EventProperties.HoldClueName] = clueList
		})
	else
		StatController.instance:track(StatEnum.EventName.AergusiClueInteractive, {
			[StatEnum.EventProperties.EpisodeId] = tostring(self.viewParam.episodeId),
			[StatEnum.EventProperties.ClueInteractiveType] = self.viewParam.type == AergusiEnum.OperationType.Refutation and "Refute" or "Evidence",
			[StatEnum.EventProperties.TargetTip] = AergusiConfig.instance:getEvidenceConfig(curGroupId).conditionStr,
			[StatEnum.EventProperties.ClueId] = tostring(clueId),
			[StatEnum.EventProperties.ClueName] = AergusiConfig.instance:getClueConfig(clueId).clueName,
			[StatEnum.EventProperties.RefuteDialogId] = tostring(curGroupId),
			[StatEnum.EventProperties.RefuteStepId] = tostring(self.viewParam.stepId),
			[StatEnum.EventProperties.ClueInteractiveResult] = "Fail",
			[StatEnum.EventProperties.PatienceNum] = AergusiDialogModel.instance:getLeftErrorTimes(),
			[StatEnum.EventProperties.HoldClueName] = clueList
		})

		local data = {}

		data.groupId = curGroupId
		data.stepId = self.viewParam.stepId
		data.type = self.viewParam.type
		data.clueId = clueId

		AergusiDialogModel.instance:addErrorOperate(data)
		GameFacade.showToast(ToastEnum.Act163EvidenceWrongClue)
	end

	if self.viewParam.callback then
		self.viewParam.callback(self.viewParam.callbackObj, groupId)
	end

	self:closeThis()
end

function AergusiClueDetailView:_editableInitView()
	self._evidenceAnim = self._goevidence:GetComponent(typeof(UnityEngine.Animator))
	self._descItems = {}

	self:_addEvents()
end

function AergusiClueDetailView:onOpen()
	gohelper.setActive(self._gocluedetail, true)

	self._isInEpisode = self.viewParam and self.viewParam.episodeId > 0

	self:_refreshDetail()
end

function AergusiClueDetailView:_refreshDetail()
	gohelper.setActive(self._btnevidence.gameObject, (self.viewParam and self.viewParam.type and (self.viewParam.type == AergusiEnum.OperationType.Submit or self.viewParam.type == AergusiEnum.OperationType.Refutation) or nil) and true)

	local curClueId = AergusiModel.instance:getCurClueId()
	local clueCo = AergusiConfig.instance:getClueConfig(curClueId)

	self._simageclueitem:LoadImage(ResUrl.getV2a1AergusiSingleBg(clueCo.clueIcon))

	self._txtcluename.text = clueCo.clueName

	for _, v in ipairs(self._descItems) do
		v:hide()
	end

	local descCos = string.split(clueCo.clueDesc, "|")

	for i = 1, #descCos do
		if not self._descItems[i] then
			local itemGo = gohelper.cloneInPlace(self._godescitem, "item" .. i)

			self._descItems[i] = AergusiClueDescItem.New()

			self._descItems[i]:init(itemGo)
		end

		self._descItems[i]:refreshItem(descCos[i])
	end

	local hasErrorTiped = self._isInEpisode and AergusiDialogModel.instance:isCurClueHasOperateError(self.viewParam.stepId, curClueId) or false

	if hasErrorTiped then
		UISpriteSetMgr.instance:setV2a1AergusiSprite(self._imageEvidence, "v2a1_aergusi_clue_btn2")
	else
		UISpriteSetMgr.instance:setV2a1AergusiSprite(self._imageEvidence, "v2a1_aergusi_clue_btn1")
	end
end

function AergusiClueDetailView:onClose()
	return
end

function AergusiClueDetailView:_addEvents()
	AergusiController.instance:registerCallback(AergusiEvent.OnClickClueItem, self._onClickClue, self)
	AergusiController.instance:registerCallback(AergusiEvent.OnPlayMergeSuccess, self._onPlayMergeSuccess, self)
	AergusiController.instance:registerCallback(AergusiEvent.OnPlayPromptTip, self._refreshDetail, self)
end

function AergusiClueDetailView:_removeEvents()
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickClueItem, self._onClickClue, self)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnPlayMergeSuccess, self._onPlayMergeSuccess, self)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnPlayPromptTip, self._refreshDetail, self)
end

function AergusiClueDetailView:_onClickClue()
	self._evidenceAnim:Play("switch", 0, 0)
	TaskDispatcher.runDelay(self._refreshDetail, self, 0.2)
end

function AergusiClueDetailView:_onPlayMergeSuccess(clueId)
	self._evidenceAnim:Play("open", 0, 0)
	self:_refreshDetail()
	UIBlockMgr.instance:startBlock("waitOpen")
	TaskDispatcher.runDelay(function()
		UIBlockMgr.instance:endBlock("waitOpen")
		AergusiController.instance:dispatchEvent(AergusiEvent.OnPlayClueItemNewMerge, clueId)
	end, nil, 0.5)
end

function AergusiClueDetailView:onDestroyView()
	UIBlockMgr.instance:endBlock("waitOpen")
	TaskDispatcher.cancelTask(self._refreshDetail, self)
	self._simageclueitem:UnLoadImage()
	self:_removeEvents()

	if self._descItems then
		for _, descItem in pairs(self._descItems) do
			descItem:destroy()
		end

		self._descItems = nil
	end
end

return AergusiClueDetailView
