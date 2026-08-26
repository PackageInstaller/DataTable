-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiClueItem.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiClueItem", package.seeall)

local AergusiClueItem = class("AergusiClueItem", LuaCompBase)

function AergusiClueItem:init(go, index)
	self.go = go
	self._index = index
	self._simageclue = gohelper.findChildSingleImage(self.go, "#simage_clue")
	self._gorefresh = gohelper.findChild(self.go, "vx_refresh")
	self._goindexbg = gohelper.findChild(self.go, "indexbg")
	self._txtindex = gohelper.findChildText(self.go, "#txt_index")
	self._goselect = gohelper.findChild(self.go, "selectframe")
	self._goselectani = gohelper.findChild(self.go, "selectframe/ani")
	self._gomaskgrey = gohelper.findChild(self.go, "mask_grey")
	self._gonew = gohelper.findChild(self.go, "#go_new")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "#btn_click")
	self._txtindex.text = self._index

	gohelper.setAsFirstSibling(self.go)
	gohelper.setActive(self._gonew, false)
	gohelper.setActive(self._gorefresh, false)

	self._hasRefresh = false

	self:_addEvents()
end

function AergusiClueItem:hide()
	gohelper.setActive(self.go, false)
end

function AergusiClueItem:showTips(show)
	self._showTip = show

	TaskDispatcher.cancelTask(self._reshowAni, self)

	if show then
		gohelper.setActive(self._goselect, true)
		gohelper.setActive(self._goselectani, true)
		TaskDispatcher.runRepeat(self._reshowAni, self, 2)
	else
		gohelper.setActive(self._goselect, false)
	end
end

function AergusiClueItem:getClueId()
	return self._clueConfig.clueId
end

function AergusiClueItem:_reshowAni()
	gohelper.setActive(self._goselectani, false)
	gohelper.setActive(self._goselectani, true)
end

function AergusiClueItem:refresh(config, stepId)
	if not self._clueConfig or self._clueConfig.clueId ~= config.clueId then
		self._hasRefresh = false
	end

	self._clueConfig = config
	self._stepId = stepId

	gohelper.setActive(self.go, true)
	self:_sendReadClue()
	self:_refreshItem()
end

function AergusiClueItem:_btnClickOnClick()
	local hasErrorTiped = self._inEpisode and AergusiDialogModel.instance:isCurClueHasOperateError(self._stepId, self._clueConfig.clueId) or false

	if hasErrorTiped then
		GameFacade.showToast(ToastEnum.Act163ChangeClue)
	end

	self._hasRefresh = false

	local isOpen = AergusiModel.instance:isMergeClueOpen()

	if isOpen then
		local isSelected = AergusiModel.instance:isClueInMerge(self._clueConfig.clueId)

		if isSelected then
			return
		end

		local pos = AergusiModel.instance:getSelectPos()

		if pos <= 0 then
			return
		end

		AergusiModel.instance:setClueMergePosClueId(pos, self._clueConfig.clueId)
		AergusiController.instance:dispatchEvent(AergusiEvent.OnClickClueMergeSelect)
	else
		AergusiModel.instance:setCurClueId(self._clueConfig.clueId)

		if self._inEpisode and self._clueConfig.clueId == AergusiEnum.AdamClueId then
			local groupId, stepId = AergusiDialogModel.instance:getCurDialogProcess()

			if groupId == AergusiEnum.FirstGroupId and stepId == AergusiEnum.FirstGroupLastStepId then
				AergusiController.instance:dispatchEvent(AergusiEvent.OnGuideSelectAdam)
			end
		end

		AergusiController.instance:dispatchEvent(AergusiEvent.OnClickClueItem)
	end

	self:_sendReadClue()
end

function AergusiClueItem:_sendReadClue()
	local curClueId = AergusiModel.instance:getCurClueId()
	local isRead = AergusiModel.instance:isClueReaded(self._clueConfig.clueId)

	if not self._hasRefresh and not isRead and curClueId == self._clueConfig.clueId then
		local actId = VersionActivity2_1Enum.ActivityId.Aergusi

		if self._inEpisode then
			local episodeId = AergusiModel.instance:getCurEpisode()
			local operationType = AergusiEnum.OperationType.New
			local params = string.format("%s", self._clueConfig.clueId)

			Activity163Rpc.instance:sendAct163EvidenceOperationRequest(actId, episodeId, operationType, params)
		else
			Activity163Rpc.instance:sendAct163ReadClueRequest(actId, self._clueConfig.clueId)
		end
	end

	self._hasRefresh = true
end

function AergusiClueItem:setInEpisode(inEpisode)
	self._inEpisode = inEpisode
end

function AergusiClueItem:_refreshItem()
	local hasErrorTiped = self._inEpisode and AergusiDialogModel.instance:isCurClueHasOperateError(self._stepId, self._clueConfig.clueId) or false
	local isOpen = AergusiModel.instance:isMergeClueOpen()
	local curClueId = AergusiModel.instance:getCurClueId()

	if isOpen then
		local isInMerge = AergusiModel.instance:isClueInMerge(self._clueConfig.clueId)
		local showGrey = isInMerge or hasErrorTiped

		gohelper.setActive(self._gomaskgrey, showGrey)

		local factorValue = showGrey and 1 or 0

		ZProj.UGUIHelper.SetGrayFactor(self._simageclue.gameObject, factorValue)
		ZProj.UGUIHelper.SetGrayFactor(self._goindexbg, factorValue)
		gohelper.setActive(self._goselect, self._showTip)
		gohelper.setActive(self._goselectani, self._showTip)
	else
		gohelper.setActive(self._gomaskgrey, hasErrorTiped)

		local factorValue = hasErrorTiped and 1 or 0

		ZProj.UGUIHelper.SetGrayFactor(self._simageclue.gameObject, factorValue)
		ZProj.UGUIHelper.SetGrayFactor(self._goindexbg, factorValue)
		gohelper.setActive(self._goselect, curClueId == self._clueConfig.clueId or self._showTip)
		gohelper.setActive(self._goselectani, self._showTip)
		self._simageclue:LoadImage(ResUrl.getV2a1AergusiSingleBg(self._clueConfig.clueIcon))
	end

	local isRead = AergusiModel.instance:isClueReaded(self._clueConfig.clueId)

	gohelper.setActive(self._gonew, not isRead)
end

function AergusiClueItem:_addEvents()
	self._btnclick:AddClickListener(self._btnClickOnClick, self)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickStartMergeClue, self._onStartMergeClue, self)
	AergusiController.instance:registerCallback(AergusiEvent.OnClueReadUpdate, self._refreshItem, self)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickClueItem, self._onClickClueItem, self)
	AergusiController.instance:registerCallback(AergusiEvent.OnPlayClueItemNewMerge, self._onPlayClueItemNewMerge, self)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickClueMergeItem, self._refreshItem, self)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickClueMergeSelect, self._refreshItem, self)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickCloseMergeClue, self._refreshItem, self)
end

function AergusiClueItem:_removeEvents()
	self._btnclick:RemoveClickListener()
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickStartMergeClue, self._onStartMergeClue, self)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClueReadUpdate, self._refreshItem, self)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickClueItem, self._onClickClueItem, self)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnPlayClueItemNewMerge, self._onPlayClueItemNewMerge, self)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickClueMergeItem, self._refreshItem, self)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickClueMergeSelect, self._refreshItem, self)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickCloseMergeClue, self._refreshItem, self)
end

function AergusiClueItem:_onClickClueItem()
	self:_refreshItem()
end

function AergusiClueItem:_onStartMergeClue()
	self:_refreshItem()
end

function AergusiClueItem:_onPlayClueItemNewMerge(clueId)
	TaskDispatcher.cancelTask(self._reshowAni, self)

	if clueId == self._clueConfig.clueId then
		gohelper.setActive(self._gorefresh, true)
		gohelper.setActive(self._goselect, true)
		self:_refreshItem()
	else
		TaskDispatcher.cancelTask(self._reshowAni, self)

		self._showTip = false

		gohelper.setActive(self._gorefresh, false)
		gohelper.setActive(self._goselect, false)
	end
end

function AergusiClueItem:destroy()
	TaskDispatcher.cancelTask(self._reshowAni, self)
	self._simageclue:UnLoadImage()
	self:_removeEvents()
end

return AergusiClueItem
