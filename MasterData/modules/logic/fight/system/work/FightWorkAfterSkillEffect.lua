-- chunkname: @modules/logic/fight/system/work/FightWorkAfterSkillEffect.lua

module("modules.logic.fight.system.work.FightWorkAfterSkillEffect", package.seeall)

local FightWorkAfterSkillEffect = class("FightWorkAfterSkillEffect", BaseWork)

function FightWorkAfterSkillEffect:ctor(fightStepData)
	self.fightStepData = fightStepData
end

function FightWorkAfterSkillEffect:onStart()
	TaskDispatcher.runDelay(self._delayDone, self, 0.5)
	FightController.instance:dispatchEvent(FightEvent.AfterSkillEffect, self.fightStepData)

	return self:onDone(true)
end

function FightWorkAfterSkillEffect:_delayDone()
	logError(" FightWorkAfterSkillEffect 保底 done 了 ")

	return self:onDone(true)
end

function FightWorkAfterSkillEffect:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return FightWorkAfterSkillEffect
