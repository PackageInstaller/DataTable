-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiClueListView.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiClueListView", package.seeall)

local AergusiClueListView = class("AergusiClueListView", BaseView)

function AergusiClueListView:onInitView()
	self._scrollclueitems = gohelper.findChildScrollRect(self.viewGO, "Left/#scroll_clueitems")
	self._goscrollcontent = gohelper.findChild(self.viewGO, "Left/#scroll_clueitems/viewport/content")
	self._btntimes = gohelper.findChildButtonWithAudio(self.viewGO, "Left/titlebg/titlecn/#btn_times")
	self._gotimegrey = gohelper.findChild(self.viewGO, "Left/titlebg/titlecn/#btn_times/grey")
	self._txttimes = gohelper.findChildText(self.viewGO, "Left/titlebg/titlecn/#btn_times/#txt_times")
	self._btnmix = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_mix")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AergusiClueListView:addEvents()
	self._btnmix:AddClickListener(self._btnmixOnClick, self)
	self._btntimes:AddClickListener(self._btntimesOnClick, self)
end

function AergusiClueListView:removeEvents()
	self._btnmix:RemoveClickListener()
	self._btntimes:RemoveClickListener()
end

function AergusiClueListView:_btnmixOnClick()
	AergusiModel.instance:setMergeClueOpen(true)
	AergusiController.instance:dispatchEvent(AergusiEvent.OnClickStartMergeClue)
end

function AergusiClueListView:_btntimesOnClick()
	if not self.viewParam.couldPrompt then
		return
	end

	local leftPromptsNum = AergusiDialogModel.instance:getLeftPromptTimes()

	if leftPromptsNum <= 0 then
		return
	end

	local nextPrompt = AergusiDialogModel.instance:getNextPromptOperate(true)

	if not nextPrompt then
		local data = AergusiDialogModel.instance:getLastPromptOperate(true)

		if not data or not data.clueId or self.viewParam.stepId ~= data.stepId then
			data = AergusiDialogModel.instance:getLastPromptOperate(false)

			GameFacade.showToast(ToastEnum.Act163HasTiped)
			AergusiController.instance:dispatchEvent(AergusiEvent.OnClickShowResultTip, data)
			self:closeThis()

			return
		end

		GameFacade.showToast(ToastEnum.Act163HasTiped)
		self:_showTipClue(data.clueId)

		return
	elseif self.viewParam.stepId ~= nextPrompt.stepId then
		nextPrompt = AergusiDialogModel.instance:getNextPromptOperate(false)

		if not nextPrompt then
			GameFacade.showToast(ToastEnum.Act163HasTiped)

			local data = AergusiDialogModel.instance:getLastPromptOperate(false)

			AergusiController.instance:dispatchEvent(AergusiEvent.OnClickShowResultTip, data)
			self:closeThis()

			return
		end
	end

	local actId = VersionActivity2_1Enum.ActivityId.Aergusi
	local episodeId = self.viewParam.episodeId
	local operationType = AergusiEnum.OperationType.Tip
	local params = ""

	Activity163Rpc.instance:sendAct163EvidenceOperationRequest(actId, episodeId, operationType, params, self._onShowTipFinished, self)
end

function AergusiClueListView:_onShowTipFinished(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local nextPrompt = AergusiDialogModel.instance:getNextPromptOperate(true)

	if self.viewParam.stepId ~= nextPrompt.stepId then
		self:closeThis()

		nextPrompt = AergusiDialogModel.instance:getNextPromptOperate(false)

		AergusiController.instance:dispatchEvent(AergusiEvent.OnClickShowResultTip, nextPrompt)
		AergusiDialogModel.instance:addPromptOperate(nextPrompt, false)

		return
	end

	self:_showTipClue(nextPrompt.clueId)
	AergusiDialogModel.instance:addPromptOperate(nextPrompt, true)
end

function AergusiClueListView:_showTipClue(clueId)
	if not clueId or clueId <= 0 then
		return
	end

	AergusiModel.instance:setCurClueId(clueId)

	local clueCo = AergusiConfig.instance:getClueConfig(clueId)
	local showTipsClues = {}

	table.insert(showTipsClues, clueId)

	if clueCo.materialId ~= "" then
		local materialCos = string.splitToNumber(clueCo.materialId, "#")

		for _, materialId in ipairs(materialCos) do
			table.insert(showTipsClues, materialId)
		end
	end

	for _, v in pairs(self._clueItems) do
		local showTip = false

		for _, tipClueId in pairs(showTipsClues) do
			if v:getClueId() == tipClueId then
				showTip = true
			end
		end

		v:showTips(showTip)
	end

	AergusiController.instance:dispatchEvent(AergusiEvent.OnPlayPromptTip)
end

function AergusiClueListView:_editableInitView()
	self._drag = UIDragListenerHelper.New()

	self._drag:createByScrollRect(self._scrollclueitems.gameObject)
	self:_addEvents()

	self._clueLines = {}

	for i = 1, 3 do
		local clueLine = gohelper.findChild(self._scrollclueitems.gameObject, "viewport/content/Line" .. i)
		local clue = {}

		clue.go = clueLine
		clue.anim = clueLine:GetComponent(typeof(UnityEngine.Animator))
		clue.items = {}

		for j = 1, 3 do
			clue.items[j] = {}
			clue.items[j].root = gohelper.findChild(clue.go, string.format("clue%s_%s", i, j))
			clue.items[j].go = self:getResInst(self.viewContainer:getSetting().otherRes[1], clue.items[j].root, "clueitem")
		end

		self._clueLines[i] = clue
	end

	self._clueItems = {}
end

function AergusiClueListView:onOpen()
	self._isInEpisode = self.viewParam and self.viewParam.episodeId > 0
	self._clueConfigs = self:_getClueConfigs()

	local clueId = self._clueConfigs[1].clueId

	AergusiModel.instance:setCurClueId(clueId)
	self:_refreshClueRoots()
	self:_refreshItem()
	self:_refreshBtn()
	self:_playRootsAnim("move1")

	if AergusiDialogModel.instance:getUnlockAutoShow() then
		local nextPrompt = AergusiDialogModel.instance:getNextPromptOperate(true)

		if not nextPrompt then
			local data = AergusiDialogModel.instance:getLastPromptOperate(true, self.viewParam.stepId)

			GameFacade.showToast(ToastEnum.Act163HasTiped)
			self:_showTipClue(data.clueId)

			return
		end

		self:_showTipClue(nextPrompt.clueId)
	end
end

function AergusiClueListView:_playRootsAnim(aniName)
	for _, v in pairs(self._clueLines) do
		v.anim:Play(aniName, 0, 0)
	end
end

function AergusiClueListView:_refreshClueRoots()
	local lineCount = #self._clueConfigs % 3 == 0 and math.floor(#self._clueConfigs / 3) or math.floor(#self._clueConfigs / 3) + 1

	for _, v in ipairs(self._clueLines) do
		gohelper.setActive(v.go, false)
	end

	for i = 1, lineCount do
		if not self._clueLines[i] then
			local targetLine = i % 3 == 0 and 3 or i % 3
			local goClueLine = gohelper.cloneInPlace(self._clueLines[targetLine].go, "Line" .. tostring(i))
			local clue = {}

			clue.go = goClueLine
			clue.anim = goClueLine:GetComponent(typeof(UnityEngine.Animator))
			clue.items = {}

			for j = 1, 3 do
				clue.items[j] = {}
				clue.items[j].root = gohelper.findChild(clue.go, string.format("clue%s_%s", targetLine, j))
				clue.items[j].go = gohelper.findChild(clue.items[j].root, "clueitem")
			end

			self._clueLines[i] = clue
		end

		gohelper.setActive(self._clueLines[i].go, true)
	end

	if #self._clueConfigs % 3 > 0 then
		for i = #self._clueConfigs % 3, 3 do
			gohelper.setActive(self._clueLines[lineCount].items[i].go, false)
		end
	end
end

function AergusiClueListView:_getClueConfigs()
	return self._isInEpisode and AergusiModel.instance:getEpisodeClueConfigs(self.viewParam.episodeId, self._isInEpisode) or AergusiModel.instance:getAllClues(self._isInEpisode)
end

function AergusiClueListView:_refreshItem()
	for _, v in pairs(self._clueItems) do
		v:hide()
	end

	for index, v in ipairs(self._clueConfigs) do
		if not self._clueItems[index] then
			local targetLine = index % 3 == 0 and math.floor(index / 3) or math.floor(index / 3) + 1
			local indexRow = index - 3 * (targetLine - 1)
			local item = AergusiClueItem.New()
			local root = self._clueLines[targetLine].items[indexRow].go

			item:init(root, index)

			self._clueItems[index] = item
		end

		self._clueItems[index]:setInEpisode(self._isInEpisode)
		self._clueItems[index]:refresh(v, self.viewParam and self.viewParam.stepId)
	end
end

function AergusiClueListView:_refreshBtn()
	local couldMix = false

	if self.viewParam and self.viewParam.episodeId then
		local leftPromptsNum = AergusiDialogModel.instance:getLeftPromptTimes()

		self._txttimes.text = leftPromptsNum

		local groupId = AergusiDialogModel.instance:getCurDialogGroup()
		local groupCo = AergusiConfig.instance:getEvidenceConfig(groupId)
		local mixClues = AergusiModel.instance:getCouldMergeClues(self._clueConfigs)

		couldMix = groupCo.showFusion > 0 and #mixClues > 0

		gohelper.setActive(self._btntimes.gameObject, true)
		gohelper.setActive(self._gotimegrey, not self.viewParam.couldPrompt or leftPromptsNum <= 0)
	else
		gohelper.setActive(self._btntimes.gameObject, false)
	end

	if couldMix then
		AergusiController.instance:dispatchEvent(AergusiEvent.OnGuideShowClueMerge)
	end

	gohelper.setActive(self._btnmix.gameObject, couldMix)
end

function AergusiClueListView:_addEvents()
	AergusiController.instance:registerCallback(AergusiEvent.StartOperation, self._onRefreshClueList, self)
	AergusiController.instance:registerCallback(AergusiEvent.OnPlayMergeSuccess, self._onRefreshClueList, self)
	self._drag:registerCallback(self._drag.EventBegin, self._onDragBegin, self)
	self._drag:registerCallback(self._drag.EventEnd, self._onDragEnd, self)
end

function AergusiClueListView:_removeEvents()
	AergusiController.instance:unregisterCallback(AergusiEvent.StartOperation, self._onRefreshClueList, self)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnPlayMergeSuccess, self._onRefreshClueList, self)
	self._drag:release()
end

function AergusiClueListView:_onDragBegin()
	self._positionX, self._positionY = transformhelper.getPos(self._goscrollcontent.transform)
end

function AergusiClueListView:_onDragEnd()
	local _, posY = transformhelper.getPos(self._goscrollcontent.transform)

	if posY - 50 < self._positionY then
		self:_playRootsAnim("move2")
	elseif posY + 50 > self._positionY then
		self:_playRootsAnim("move1")
	end
end

function AergusiClueListView:_onRefreshClueList()
	self._clueConfigs = self:_getClueConfigs()

	self:_refreshClueRoots()
	self:_refreshItem()
	self:_refreshBtn()
end

function AergusiClueListView:onClose()
	return
end

function AergusiClueListView:onDestroyView()
	self:_removeEvents()

	if self._clueItems then
		for _, v in pairs(self._clueItems) do
			v:destroy()
		end

		self._clueItems = nil
	end
end

return AergusiClueListView
