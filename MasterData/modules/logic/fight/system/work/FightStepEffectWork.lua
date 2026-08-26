-- chunkname: @modules/logic/fight/system/work/FightStepEffectWork.lua

module("modules.logic.fight.system.work.FightStepEffectWork", package.seeall)

local FightStepEffectWork = class("FightStepEffectWork", BaseWork)

function FightStepEffectWork:ctor(fightStepData)
	self.fightStepData = fightStepData
	self._workFlow = nil
end

function FightStepEffectWork:onStart()
	if self._workFlow then
		return self._workFlow:start()
	end
end

function FightStepEffectWork:setFlow(flow)
	self._workFlow = flow

	flow:registFinishCallback(self._onFlowDone, self)
end

function FightStepEffectWork:_onFlowDone()
	return self:onDone(true)
end

function FightStepEffectWork:clearWork()
	if self._workFlow then
		self._workFlow:disposeSelf()

		self._workFlow = nil
	end
end

return FightStepEffectWork
