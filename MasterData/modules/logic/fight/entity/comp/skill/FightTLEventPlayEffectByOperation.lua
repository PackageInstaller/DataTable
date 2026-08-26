-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventPlayEffectByOperation.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventPlayEffectByOperation", package.seeall)

local FightTLEventPlayEffectByOperation = class("FightTLEventPlayEffectByOperation", FightTimelineTrackItem)

function FightTLEventPlayEffectByOperation:onTrackStart(fightStepData, duration, paramsArr)
	FightTLEventPlayEffectByOperation.playing = true
	self.curCount = 0
	self.operationWorkList = {}

	self:com_registMsg(FightMsgId.OperationForPlayEffect, self.onOperationForPlayEffect)

	fightStepData.playerOperationCountForPlayEffectTimeline = 0
	self.fightStepData = fightStepData
	self.paramsArr = paramsArr
	self.effectType = tonumber(self.paramsArr[1])
	self.sequenceFlow = FightWorkFlowSequence.New()

	self:addWork2TimelineFinishWork(self.sequenceFlow)
	self:buildOperationWorkList()

	fightStepData.maxPlayerOperationCountForPlayEffectTimeline = #self.operationWorkList

	self:com_registTimer(self.playAllOperationWork, tonumber(self.paramsArr[3]))

	local type2ViewName = {
		[FightEnum.EffectType.NUODIKARANDOMATTACK] = "FightNuoDiKaQteView"
	}
	local viewName = type2ViewName[self.effectType]

	if viewName then
		ViewMgr.instance:openView(viewName, {
			effectType = self.effectType,
			timeLimit = tonumber(self.paramsArr[4]),
			paramsArr = paramsArr,
			fightStepData = fightStepData
		})
		self.sequenceFlow:registWork(FightWorkFunction, self.closeView, self, viewName)
	end

	local appendTimelineName = self.paramsArr[6]

	if not string.nilorempty(appendTimelineName) then
		local timeOffset = tonumber(self.paramsArr[5])

		self.sequenceFlow:registWork(FightWorkDelayTimer, timeOffset)

		local appendTimelineStepData = FightStepData.New(FightDef_pb.FightStep())

		appendTimelineStepData.actEffect = self.nuoDiKaTeamAttack
		appendTimelineStepData.fromId = fightStepData.fromId
		appendTimelineStepData.toId = fightStepData.toId
		appendTimelineStepData.actId = 0
		appendTimelineStepData.actType = FightEnum.ActType.SKILL
		appendTimelineStepData.stepUid = FightTLEventEntityVisible.latestStepUid or 0
		appendTimelineStepData.playerOperationCountForPlayEffectTimeline = 0
		appendTimelineStepData.maxPlayerOperationCountForPlayEffectTimeline = fightStepData.maxPlayerOperationCountForPlayEffectTimeline

		self.sequenceFlow:registWork(FightWorkFunction, self.setOperationCount, self, appendTimelineStepData, fightStepData)
		self.sequenceFlow:registWork(FightWorkPlayFakeStepTimeline, appendTimelineName, appendTimelineStepData)
	end
end

function FightTLEventPlayEffectByOperation:setOperationCount(appendTimelineStepData, fightStepData)
	appendTimelineStepData.playerOperationCountForPlayEffectTimeline = fightStepData.playerOperationCountForPlayEffectTimeline
end

function FightTLEventPlayEffectByOperation:buildOperationWorkList()
	self.timelineDic = {}
	self.timelineOriginDic = {}

	local arr = GameUtil.splitString2(self.paramsArr[2], false, ",", "#") or {}

	for i, v in ipairs(arr) do
		local count = tonumber(v[1])

		self.timelineDic[count] = {}

		local timelineArr = string.split(v[2], "|")

		for index, timelineName in ipairs(timelineArr) do
			table.insert(self.timelineDic[count], timelineName)
		end

		self.timelineOriginDic[count] = FightDataUtil.copyData(self.timelineDic[count])
	end

	local effectList = self.fightStepData.actEffect
	local parallelWork = self.sequenceFlow:registWork(FightWorkFlowParallel)

	self.nuoDiKaTeamAttack = {}

	for i, actEffectData in ipairs(effectList) do
		if actEffectData.effectType == self.effectType then
			local work = parallelWork:registWork(FightWorkPlayEffectTimelineByOperation, actEffectData, self.paramsArr, self.fightStepData, self.timelineDic, self.timelineOriginDic)

			table.insert(self.operationWorkList, work)
		end

		if actEffectData.effectType == FightEnum.EffectType.NUODIKATEAMATTACK then
			table.insert(self.nuoDiKaTeamAttack, actEffectData)
		end
	end
end

function FightTLEventPlayEffectByOperation:onOperationForPlayEffect(effectType)
	if effectType ~= self.effectType then
		return
	end

	self.curCount = self.curCount + 1

	local work = self.operationWorkList[self.curCount]

	if work then
		work:playTimeline()
		self:com_replyMsg(FightMsgId.OperationForPlayEffect, effectType)
	end
end

function FightTLEventPlayEffectByOperation:playAllOperationWork()
	if self.paramsArr[7] == "0" then
		for i, work in ipairs(self.operationWorkList) do
			self:com_sendFightEvent(FightEvent.PlayOnceQteWhenTimeout)
		end
	elseif self.paramsArr[7] == "1" then
		local delay = tonumber(self.paramsArr[4])
		local flow = self:com_registFlowSequence()

		for i, work in ipairs(self.operationWorkList) do
			flow:registWork(FightWorkDelayTimer, delay)
			flow:registWork(FightWorkFunction, self.playOneTimeline, self, work)
		end

		flow:start()
	else
		for i, work in ipairs(self.operationWorkList) do
			self:com_sendFightEvent(FightEvent.PlayOnceQteWhenTimeout)
		end
	end
end

function FightTLEventPlayEffectByOperation:playOneTimeline(work)
	self:com_sendFightEvent(FightEvent.PlayOnceQteWhenTimeout)
end

function FightTLEventPlayEffectByOperation:closeView(viewName)
	ViewMgr.instance:closeView(viewName, true)
end

function FightTLEventPlayEffectByOperation:onTrackEnd()
	return
end

function FightTLEventPlayEffectByOperation:onDestructor()
	FightTLEventPlayEffectByOperation.playing = false
end

return FightTLEventPlayEffectByOperation
