-- chunkname: @modules/logic/fight/system/work/asfd/FightASFDFlow.lua

module("modules.logic.fight.system.work.asfd.FightASFDFlow", package.seeall)

local FightASFDFlow = class("FightASFDFlow", BaseFlow)

FightASFDFlow.DelayWaitTime = 61

local LSJReplaceRule = "2#1080"

function FightASFDFlow.emptyFunc()
	return
end

function FightASFDFlow:ctor(fightStepData, nextStepData, curIndex)
	self.fightStepData = fightStepData
	self.curIndex = curIndex
	self.asfdContext = self:getContext(fightStepData)
	self.nextStepData = nextStepData
end

function FightASFDFlow:createLSJSeq()
	local fightStepData = self.fightStepData

	self._sequence = FlowSequence.New()

	self._sequence:addWork(FightWorkCreateLSJASFDEmitter.New(fightStepData, self.asfdContext))

	local missileFlow = FlowSequence.New()
	local index = self.asfdContext.emitterAttackNum
	local co = FightASFDConfig.instance:getLSJCo(index)

	missileFlow:addWork(FightWorkLSJMissileASFD.New(fightStepData, self.asfdContext, co.duration))

	local parallelFlow = FlowParallel.New()
	local needWaitDone = self:checkNeedAddWaitDoneWork_LSJ(self.nextStepData)

	if needWaitDone then
		if self:isLastStep() then
			missileFlow:addWork(FightWorkLSJMissileASFDDone.New(fightStepData))
		else
			missileFlow:addWork(FightWorkMissileASFDDone.New(fightStepData))
		end

		parallelFlow:addWork(FightWorkWaitASFDArrivedDone.New(fightStepData))
	end

	parallelFlow:addWork(missileFlow)
	self._sequence:addWork(parallelFlow)
	self._sequence:addWork(FightWorkASFDOnlyDamageEffectFlow.New(fightStepData))
	self._sequence:addWork(FightWorkASFDTryPlayYXTimeline.New(fightStepData))
	self._sequence:addWork(FightWorkASFDEffectFlow.New(fightStepData))

	if self:isLastStep(self.nextStepData) then
		local delay = FightASFDConfig.instance.lsjLastASFDDelay

		self._sequence:addWork(DelayFuncWork.New(FightASFDFlow.emptyFunc, nil, delay))
	end

	if needWaitDone then
		self._sequence:addWork(FightWorkASFDDone.New(fightStepData, self.asfdContext))
	else
		self._sequence:addWork(FightWorkASFDContinueDone.New(fightStepData))
	end
end

function FightASFDFlow:createNormalSeq()
	local fightStepData = self.fightStepData

	self._sequence = FlowSequence.New()

	self._sequence:addWork(FightWorkCreateASFDEmitter.New(fightStepData))

	local missileFlow = FlowSequence.New()

	missileFlow:addWork(FightWorkMissileASFD.New(fightStepData, self.asfdContext))

	local parallelFlow = FlowParallel.New()
	local needWaitDone = self:checkNeedAddWaitDoneWork(self.nextStepData)

	if needWaitDone then
		missileFlow:addWork(FightWorkMissileASFDDone.New(fightStepData))
		parallelFlow:addWork(FightWorkWaitASFDArrivedDone.New(fightStepData))
	end

	parallelFlow:addWork(missileFlow)
	self._sequence:addWork(parallelFlow)
	self._sequence:addWork(FightWorkASFDOnlyDamageEffectFlow.New(fightStepData))
	self._sequence:addWork(FightWorkASFDTryPlayYXTimeline.New(fightStepData))
	self._sequence:addWork(FightWorkASFDEffectFlow.New(fightStepData))

	if needWaitDone then
		self._sequence:addWork(FightWorkASFDDone.New(fightStepData))
	else
		self._sequence:addWork(FightWorkASFDContinueDone.New(fightStepData))
	end
end

function FightASFDFlow:createPullOutSeq()
	self._sequence = FlowSequence.New()

	local parallelFlow = FlowParallel.New()

	parallelFlow:addWork(FightWorkASFDClearEmitter.New(self.fightStepData))
	parallelFlow:addWork(FightWorkASFDPullOut.New(self.fightStepData))

	local damageSeq = FlowSequence.New()

	damageSeq:addWork(FightWorkASFDOnlyDamageEffectFlow.New(self.fightStepData))
	damageSeq:addWork(FightWorkASFDTryPlayYXTimeline.New(self.fightStepData))
	damageSeq:addWork(FightWorkASFDEffectFlow.New(self.fightStepData))
	parallelFlow:addWork(damageSeq)
	self._sequence:addWork(parallelFlow)
	self._sequence:addWork(FightWorkASFDDone.New(self.fightStepData))
end

function FightASFDFlow:getContext(fightStepData)
	local context = FightASFDHelper.getStepContext(fightStepData, self.curIndex)
	local isLastStep = self:isLastStep(self.nextStepData)

	if context then
		context.isLastStep = isLastStep

		return context
	end

	logError("not found EMITTER FIGHT NOTIFY !!!")

	return {
		splitNum = 0,
		emitterAttackMaxNum = 2,
		emitterAttackNum = self.curIndex,
		isLastStep = isLastStep
	}
end

function FightASFDFlow:checkNeedAddWaitDoneWork_LSJ(nextStepData)
	if self:isLastStep(nextStepData) then
		return true
	end

	if self:checkHasMonsterChangeEffectType(self.fightStepData) then
		return true
	end

	return false
end

function FightASFDFlow:checkNeedAddWaitDoneWork(nextStepData)
	if self:isLastStep(nextStepData) then
		return true
	end

	if self:checkHasMonsterChangeEffectType(self.fightStepData) then
		return true
	end

	if FightASFDHelper.isALFPullOutStep(nextStepData, self.curIndex) then
		return true
	end

	return false
end

function FightASFDFlow:isLastStep(nextStepData)
	if not nextStepData then
		return true
	end

	if not FightHelper.isASFDSkill(nextStepData.actId) then
		return true
	end

	return false
end

function FightASFDFlow:checkHasMonsterChangeEffectType(fightStepData)
	if not fightStepData then
		return false
	end

	for _, actEffectData in ipairs(fightStepData.actEffect) do
		if actEffectData.effectType == FightEnum.EffectType.MONSTERCHANGE then
			return true
		end

		if actEffectData.effectType == FightEnum.EffectType.FIGHTSTEP and self:checkHasMonsterChangeEffectType(actEffectData.fightStepData) then
			return true
		end
	end

	return false
end

function FightASFDFlow:onStart()
	if FightASFDHelper.checkRule(LSJReplaceRule, self.fightStepData.fromId, self.asfdContext) then
		self:createLSJSeq()
	elseif FightASFDHelper.isALFPullOutStep(self.fightStepData, self.curIndex) then
		self:createPullOutSeq()
	else
		self:createNormalSeq()
	end

	self._sequence:registerDoneListener(self._flowDone, self)
	self._sequence:start()
end

function FightASFDFlow:hasDone()
	return not self._sequence or self._sequence.status ~= WorkStatus.Running
end

function FightASFDFlow:stopSkillFlow()
	if self._sequence and self._sequence.status == WorkStatus.Running then
		self._sequence:stop()
		self._sequence:unregisterDoneListener(self._flowDone, self)

		self._sequence = nil
	end
end

function FightASFDFlow:_flowDone()
	if self._sequence then
		self._sequence:unregisterDoneListener(self._flowDone, self)

		self._sequence = nil
	end

	self:onDone(true)
end

function FightASFDFlow:clearWork()
	if self._sequence then
		self._sequence:stop()
		self._sequence:unregisterDoneListener(self._flowDone, self)

		self._sequence = nil
	end
end

return FightASFDFlow
