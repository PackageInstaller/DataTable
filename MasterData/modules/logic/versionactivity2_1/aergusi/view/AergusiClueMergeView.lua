-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiClueMergeView.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiClueMergeView", package.seeall)

local AergusiClueMergeView = class("AergusiClueMergeView", BaseView)

function AergusiClueMergeView:onInitView()
	self._gocluemerge = gohelper.findChild(self.viewGO, "Right/#go_cluemerge")
	self._simagenotebg2 = gohelper.findChildSingleImage(self.viewGO, "Right/#go_cluemerge/#simage_notebg2")
	self._btnmergeclose = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_cluemerge/#btn_mergeclose")
	self._gofailedtips = gohelper.findChild(self.viewGO, "Right/#go_cluemerge/#go_failedtips")
	self._btnok = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_cluemerge/#btn_ok")
	self._btnlocked = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_cluemerge/#btn_locked")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AergusiClueMergeView:addEvents()
	self._btnmergeclose:AddClickListener(self._btnmergecloseOnClick, self)
	self._btnok:AddClickListener(self._btnokOnClick, self)
	self._btnlocked:AddClickListener(self._btnlockedOnClick, self)
end

function AergusiClueMergeView:removeEvents()
	self._btnmergeclose:RemoveClickListener()
	self._btnok:RemoveClickListener()
	self._btnlocked:RemoveClickListener()
end

function AergusiClueMergeView:_btnmergecloseOnClick()
	self._mergeAni:Play("close", 0, 0)
	TaskDispatcher.runDelay(self._realCloseClueMerge, self, 0.34)
end

function AergusiClueMergeView:_realCloseClueMerge()
	AergusiModel.instance:setMergeClueOpen(false)
	AergusiModel.instance:clearMergePosState()

	for i = 1, 2 do
		self._clueMergeItems[i]:refreshItem()
	end

	gohelper.setActive(self._gocluemerge, false)
	AergusiController.instance:dispatchEvent(AergusiEvent.OnClickCloseMergeClue)
end

function AergusiClueMergeView:_btnokOnClick()
	local mergeClues = AergusiModel.instance:getMergeClues()

	self._targetClue = AergusiModel.instance:getTargetMergeClue(mergeClues[1], mergeClues[2])

	if self._targetClue > 0 then
		local actId = VersionActivity2_1Enum.ActivityId.Aergusi
		local episodeId = self.viewParam.episodeId
		local operationType = AergusiEnum.OperationType.Merge
		local params = string.format("%s#%s#%s", mergeClues[1], mergeClues[2], self._targetClue)
		local callback = self._mergeSuccess
		local callbackObj = self

		Activity163Rpc.instance:sendAct163EvidenceOperationRequest(actId, episodeId, operationType, params, callback, callbackObj)
	else
		logError(string.format("线索%s与线索%s没法融合，请重新选择需要融合的线索！", mergeClues[1], mergeClues[2]))
	end
end

function AergusiClueMergeView:_mergeSuccess(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_hybrid)
	self._mergeAni:Play("merge", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("clueMerge")
	TaskDispatcher.runDelay(self._mergeFinished, self, 0.83)
end

function AergusiClueMergeView:_mergeFinished()
	AergusiModel.instance:setCurClueId(self._targetClue)
	AergusiModel.instance:clearMergePosState()
	AergusiController.instance:dispatchEvent(AergusiEvent.OnPlayMergeSuccess, self._targetClue)
	TaskDispatcher.runDelay(function()
		AergusiModel.instance:setMergeClueOpen(false)
		AergusiModel.instance:clearMergePosState()

		for i = 1, 2 do
			self._clueMergeItems[i]:refreshItem()
		end

		gohelper.setActive(self._gocluemerge, false)
		UIBlockMgr.instance:endBlock("clueMerge")
		AergusiController.instance:dispatchEvent(AergusiEvent.OnGuideClueMergeSuccess)
	end, nil, 0.83)
end

function AergusiClueMergeView:_btnlockedOnClick()
	return
end

function AergusiClueMergeView:_editableInitView()
	self:_addEvents()

	self._mergeAni = self._gocluemerge:GetComponent(typeof(UnityEngine.Animator))
end

function AergusiClueMergeView:onOpen()
	AergusiModel.instance:clearMergePosState()

	self._clueMergeItems = {}

	for i = 1, 2 do
		self._clueMergeItems[i] = AergusiClueMergeEvidenceItem.New()

		local root = gohelper.findChild(self.viewGO, "Right/#go_cluemerge/evidence" .. i)

		self._clueMergeItems[i]:init(root, i)
	end

	gohelper.setActive(self._gocluemerge, false)
end

function AergusiClueMergeView:_refreshMerge()
	local clues = AergusiModel.instance:getMergeClues()
	local allSelected = clues[1] > 0 and clues[2] > 0
	local targetClue = AergusiModel.instance:getTargetMergeClue(clues[1], clues[2])
	local showUnlock = allSelected and targetClue > 0

	gohelper.setActive(self._btnok.gameObject, showUnlock)
	gohelper.setActive(self._btnlocked.gameObject, not showUnlock and not allSelected)
	gohelper.setActive(self._gofailedtips.gameObject, not showUnlock and allSelected)
end

function AergusiClueMergeView:onClose()
	return
end

function AergusiClueMergeView:_addEvents()
	AergusiController.instance:registerCallback(AergusiEvent.OnClickStartMergeClue, self._onShowMerge, self)
	AergusiController.instance:registerCallback(AergusiEvent.OnClickClueMergeSelect, self._refreshMerge, self)
end

function AergusiClueMergeView:_removeEvents()
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickStartMergeClue, self._onShowMerge, self)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClickClueMergeSelect, self._refreshMerge, self)
end

function AergusiClueMergeView:_onShowMerge()
	self._mergeAni:Play("open", 0, 0)
	gohelper.setActive(self._gocluemerge, true)
end

function AergusiClueMergeView:onDestroyView()
	UIBlockMgr.instance:endBlock("clueMerge")
	TaskDispatcher.cancelTask(self._realCloseClueMerge, self)

	if self._clueMergeItems then
		for _, v in pairs(self._clueMergeItems) do
			v:destroy()
		end

		self._clueMergeItems = nil
	end

	self:_removeEvents()
end

return AergusiClueMergeView
