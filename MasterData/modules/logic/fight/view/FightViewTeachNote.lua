-- chunkname: @modules/logic/fight/view/FightViewTeachNote.lua

module("modules.logic.fight.view.FightViewTeachNote", package.seeall)

local FightViewTeachNote = class("FightViewTeachNote", BaseView)
local failEpisode
local failCount = 0

function FightViewTeachNote:onInitView()
	self._teachNoteGO = gohelper.findChild(self.viewGO, "root/teachnote")
	self._teachNoteAnimator = self._teachNoteGO:GetComponent(typeof(UnityEngine.Animator))
	self._btnTeachNote = gohelper.findChildButtonWithAudio(self.viewGO, "root/teachnote/#btn_help")
	self._btnTeachNoteSkip = gohelper.findChildButtonWithAudio(self.viewGO, "root/teachnote/#go_skipbtn/btn_skipguide")
	self._btnsGO = gohelper.findChild(self.viewGO, "root/btns")

	local skipCanvas = gohelper.onceAddComponent(gohelper.findChild(self.viewGO, "root/teachnote/#go_skipbtn"), typeof(UnityEngine.Canvas))
	local guideCanvas = gohelper.onceAddComponent(ViewMgr.instance:getUILayer(UILayerName.Guide), typeof(UnityEngine.Canvas))

	skipCanvas.overrideSorting = true
	skipCanvas.sortingOrder = guideCanvas.sortingOrder + 1
end

function FightViewTeachNote:addEvents()
	self._btnTeachNote:AddClickListener(self._onClickTeachNote, self)
	self._btnTeachNoteSkip:AddClickListener(self._onClickTeachNoteSkip, self)
	self.addEventCb(self, FightController.instance, FightEvent.PushEndFight, self._pushEndFight, self)
	self.addEventCb(self, FightController.instance, FightEvent.StageChanged, self._delayCheckShowAnim, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._delayCheckShowAnim, self)
end

function FightViewTeachNote:removeEvents()
	self._btnTeachNote:RemoveClickListener()
	self._btnTeachNoteSkip:RemoveClickListener()
	self.removeEventCb(self, FightController.instance, FightEvent.PushEndFight, self._pushEndFight, self)
	self.removeEventCb(self, FightController.instance, FightEvent.StageChanged, self._delayCheckShowAnim, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._delayCheckShowAnim, self)
	TaskDispatcher.cancelTask(self._checkShowAnim, self)
end

function FightViewTeachNote:onOpen()
	local episodeCO = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)
	local isSpEpisode = episodeCO and episodeCO.type == DungeonEnum.EpisodeType.Sp
	local guideId = self:_getGuideId()
	local hasHelpPage = false

	for _, helpPageCO in ipairs(lua_helppage.configList) do
		if helpPageCO.unlockGuideId == guideId then
			hasHelpPage = true
		end
	end

	self._episodeId = DungeonModel.instance.curSendEpisodeId
	self._isSpAndHasHelpPage = isSpEpisode and hasHelpPage

	gohelper.setActive(self._teachNoteGO, self._isSpAndHasHelpPage)
	self:_checkShowAnim()
end

function FightViewTeachNote:_onOpenView(viewName)
	if not self._isSpAndHasHelpPage then
		return
	end

	if viewName == ViewName.GuideView and self._teachNoteGO.activeInHierarchy and self._teachNoteAnimator.enabled then
		self._teachNoteAnimator.enabled = false
	end

	self:_checkShowSkip()
end

function FightViewTeachNote:_delayCheckShowAnim()
	if not self._isSpAndHasHelpPage then
		return
	end

	TaskDispatcher.runDelay(self._checkShowAnim, self, 0.5)
end

function FightViewTeachNote:_checkShowAnim()
	if not self._isSpAndHasHelpPage then
		return
	end

	if FightWorkPlayHandCard.playing > 0 then
		return
	end

	if self.viewContainer.fightViewHandCard:isMoveCardFlow() then
		return
	end

	if self.viewContainer.fightViewHandCard:isCombineCardFlow() then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		return
	end

	local isPlayCard = FightWorkPlayHandCard.playing > 0
	local isMoveCard = self.viewContainer.fightViewHandCard:isMoveCardFlow()
	local isCombineCard = self.viewContainer.fightViewHandCard:isCombineCardFlow()
	local isCardOp = isPlayCard or isMoveCard or isCombineCard
	local isOpenGuideView = ViewMgr.instance:isOpen(ViewName.GuideView)
	local isCardStage = FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate

	if not isCardOp and not isOpenGuideView and isCardStage and failCount > 0 then
		self._teachNoteAnimator.enabled = true

		self._teachNoteAnimator:Play("fightview_teachnote_loop")
	end

	self:_checkShowSkip()
end

function FightViewTeachNote:_checkShowSkip()
	if not self._isSpAndHasHelpPage then
		return
	end

	local isOpenGuideView = ViewMgr.instance:isOpen(ViewName.GuideView)

	if isOpenGuideView and failCount > 0 then
		gohelper.setActive(self._btnTeachNoteSkip.gameObject, true)
		transformhelper.setLocalScale(self._btnsGO.transform, 0, 0, 0)
	else
		gohelper.setActive(self._btnTeachNoteSkip.gameObject, false)
		transformhelper.setLocalScale(self._btnsGO.transform, 1, 1, 1)
	end
end

function FightViewTeachNote:_pushEndFight()
	if self._episodeId ~= failEpisode then
		failCount = 0
	end

	failEpisode = self._episodeId

	local fightRecordMO = FightModel.instance:getRecordMO()
	local result = fightRecordMO and fightRecordMO.fightResult

	failCount = (result == FightEnum.FightResult.Fail or result == FightEnum.FightResult.OutOfRoundFail) and failCount + 1 or 0
end

function FightViewTeachNote:_onClickTeachNote()
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Enter) or FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DistributeCard) then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.GuideView) and not GuideUtil.isGuideViewTarget(self._btnTeachNote.gameObject) then
		return
	end

	local guideId = self:_getGuideId()

	if guideId then
		local viewParam = {
			id = HelpEnum.HelpId.Fight,
			viewParam = HelpEnum.HelpId.Fight,
			guideId = guideId
		}

		ViewMgr.instance:openView(ViewName.HelpView, viewParam)
	else
		logError("没有正在执行的教学笔记引导，无法打开帮助说明界面")
	end
end

function FightViewTeachNote:_onClickTeachNoteSkip()
	local guideId = self:_getDoingGuideId()

	if guideId then
		GuideController.instance:oneKeyFinishGuide(guideId, false)
		gohelper.setActive(self._btnTeachNoteSkip.gameObject, false)
		transformhelper.setLocalScale(self._btnsGO.transform, 1, 1, 1)
	else
		logError("没有正在执行的教学笔记引导，无法跳过引导")
	end
end

function FightViewTeachNote:_getGuideId()
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local guideCOList = GuideConfig.instance:getGuideList()

	for _, oneGuideCO in ipairs(guideCOList) do
		local triggerParams = FightStrUtil.instance:getSplitCache(oneGuideCO.trigger, "#")
		local triggerType = triggerParams[1]
		local triggerParam = tonumber(triggerParams[2])

		if triggerType and triggerType == "EnterEpisode" and triggerParam and triggerParam == episodeId and oneGuideCO.restart == 1 then
			return oneGuideCO.id
		end
	end
end

function FightViewTeachNote:_getDoingGuideId()
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local guideCOList = GuideConfig.instance:getGuideList()

	for _, oneGuideCO in ipairs(guideCOList) do
		local triggerParams = FightStrUtil.instance:getSplitCache(oneGuideCO.trigger, "#")
		local triggerType = triggerParams[1]
		local triggerParam = tonumber(triggerParams[2])

		if triggerType and triggerType == "EnterEpisode" and triggerParam and triggerParam == episodeId and oneGuideCO.restart == 1 then
			local guideMO = GuideModel.instance:getById(oneGuideCO.id)

			if guideMO and (not guideMO.isFinish or guideMO.currStepId > 0) then
				return oneGuideCO.id
			end
		end
	end
end

return FightViewTeachNote
