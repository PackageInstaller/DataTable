-- chunkname: @modules/logic/fight/system/flow/FightSkillFlow.lua

module("modules.logic.fight.system.flow.FightSkillFlow", package.seeall)

local FightSkillFlow = class("FightSkillFlow", BaseFlow)

function FightSkillFlow:ctor(fightStepData)
	self.fightStepData = fightStepData
	self._sequence = FlowSequence.New()

	self._sequence:addWork(FightWorkSkillSwitchSpine.New(fightStepData))
	self._sequence:addWork(FightWorkSkillSwitchSpineByServerSkin.New(fightStepData))
	self._sequence:addWork(FightWorkSkillSwitchSpineByAssistRole.New(fightStepData))

	local skillReleaseFlow = FlowParallel.New()

	self._sequence:addWork(skillReleaseFlow)
	skillReleaseFlow:addWork(FightWorkStepSkill.New(fightStepData))

	local dealdParallelFlow

	for _, actEffectData in ipairs(fightStepData.actEffect) do
		if actEffectData.effectType == FightEnum.EffectType.DEAD then
			local deadWork = FightWork2Work.New(FightWorkEffectDeadPerformance, fightStepData, actEffectData, true)

			dealdParallelFlow = dealdParallelFlow or FlowParallel.New()

			dealdParallelFlow:addWork(deadWork)
		end
	end

	if dealdParallelFlow then
		skillReleaseFlow:addWork(dealdParallelFlow)
	end

	local effectHealWork

	for _, actEffectData in ipairs(fightStepData.actEffect) do
		local isHealEffect = actEffectData.effectType == FightEnum.EffectType.HEAL or actEffectData.effectType == FightEnum.EffectType.HEALCRIT

		if isHealEffect and actEffectData.effectNum > 0 then
			if not effectHealWork then
				effectHealWork = FightWorkSkillFinallyHeal.New(fightStepData)

				skillReleaseFlow:addWork(effectHealWork)
			end

			effectHealWork:addActEffectData(actEffectData)
		end
	end
end

function FightSkillFlow:onStart()
	FightController.instance:registerCallback(FightEvent.ParallelPlayNextSkillDoneThis, self._parallelDoneThis, self)
	FightController.instance:registerCallback(FightEvent.ForceEndSkillStep, self._forceEndSkillStep, self)
	FightController.instance:registerCallback(FightEvent.FightWorkStepSkillTimeout, self._onFightWorkStepSkillTimeout, self)
	FightController.instance:dispatchEvent(FightEvent.OnSkillFlowStart, self.fightStepData)
	self._sequence:registerDoneListener(self._skillFlowDone, self)
	self._sequence:start({})
end

function FightSkillFlow:_onFightWorkStepSkillTimeout(fightStepData)
	if fightStepData == self.fightStepData then
		if self._sequence then
			self._sequence:stop()
		end

		self:onDone(true)
	end
end

function FightSkillFlow:clearWork()
	FightController.instance:dispatchEvent(FightEvent.OnSkillTimeLineDone, self.fightStepData)
	FightController.instance:unregisterCallback(FightEvent.ParallelPlayNextSkillDoneThis, self._parallelDoneThis, self)
	FightController.instance:unregisterCallback(FightEvent.ForceEndSkillStep, self._forceEndSkillStep, self)
	FightController.instance:unregisterCallback(FightEvent.FightWorkStepSkillTimeout, self._onFightWorkStepSkillTimeout, self)
end

function FightSkillFlow:onDestroy()
	if self._sequence then
		self._sequence:stop()
		self._sequence:unregisterDoneListener(self._skillFlowDone, self)

		self._sequence = nil
	end

	FightSkillFlow.super.onDestroy(self)
end

function FightSkillFlow:addAfterSkillEffects(works)
	self._sequence:addWork(FightWorkSkillSwitchSpineEnd.New(self.fightStepData))
	self._sequence:addWork(FightWorkSkillSwitchSpineByServerSkinEnd.New(self.fightStepData))
	self._sequence:addWork(FightWorkSkillSwitchSpineByAssistRoleEnd.New(self.fightStepData))

	for _, work in ipairs(works) do
		self._sequence:addWork(work)
	end
end

function FightSkillFlow:hasDone()
	if self._sequence and self._sequence.status == WorkStatus.Running then
		return false
	end

	return true
end

function FightSkillFlow:stopSkillFlow()
	if self._sequence and self._sequence.status == WorkStatus.Running then
		self._sequence:stop()
		self._sequence:unregisterDoneListener(self._skillFlowDone, self)

		self._sequence = nil
	end

	FightController.instance:unregisterCallback(FightEvent.ParallelPlayNextSkillDoneThis, self._parallelDoneThis, self)
end

function FightSkillFlow:_skillFlowDone()
	FightController.instance:dispatchEvent(FightEvent.OnSkillFlowDone, self.fightStepData)

	if self._sequence then
		self._sequence:unregisterDoneListener(self._skillFlowDone, self)

		self._sequence = nil

		if self._parallelDone or self._forceEndDone then
			return
		end

		self:onDone(true)
	end
end

function FightSkillFlow:_parallelDoneThis(fightStepData)
	if self.fightStepData == fightStepData then
		self._parallelDone = true

		self:onDone(true)
	end
end

function FightSkillFlow:_forceEndSkillStep(step)
	if step == self.fightStepData then
		self._forceEndDone = true

		self:onDone(true)
	end
end

return FightSkillFlow
