-- chunkname: @modules/logic/fight/system/work/FightWorkFightStep.lua

module("modules.logic.fight.system.work.FightWorkFightStep", package.seeall)

local FightWorkFightStep = class("FightWorkFightStep", FightEffectBase)

function FightWorkFightStep:onStart()
	if not self._workFlow then
		self._workFlow = FightWorkFlowSequence.New()
		FightStepBuilder.lastEffect = nil

		FightStepBuilder.addEffectWork(self._workFlow, self.actEffectData.fightStep)

		FightStepBuilder.lastEffect = nil
	end

	self._workFlow:addWork(Work2FightWork.New(FightWorkShowEquipSkillEffect, self.actEffectData.fightStep))

	if self.actEffectData.fightStep.actType == FightEnum.ActType.SKILL and not FightHelper.isTimelineStep(self.actEffectData.fightStep) then
		self._workFlow:addWork(Work2FightWork.New(FightNonTimelineSkillStep, self.actEffectData.fightStep))
	end

	self:cancelFightWorkSafeTimer()
	self._workFlow:registFinishCallback(self._onFlowDone, self)

	return self._workFlow:start()
end

function FightWorkFightStep:setFlow(flow)
	self._workFlow = flow
end

function FightWorkFightStep:_onFlowDone()
	return self:onDone(true)
end

function FightWorkFightStep:clearWork()
	if self._workFlow then
		self._workFlow:disposeSelf()

		self._workFlow = nil
	end
end

return FightWorkFightStep
