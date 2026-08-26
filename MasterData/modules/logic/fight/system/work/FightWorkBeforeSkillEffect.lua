-- chunkname: @modules/logic/fight/system/work/FightWorkBeforeSkillEffect.lua

module("modules.logic.fight.system.work.FightWorkBeforeSkillEffect", package.seeall)

local FightWorkBeforeSkillEffect = class("FightWorkBeforeSkillEffect", BaseWork)

function FightWorkBeforeSkillEffect:ctor(fightStepData)
	self.fightStepData = fightStepData
end

function FightWorkBeforeSkillEffect:onStart()
	TaskDispatcher.runDelay(self._delayDone, self, 0.5)
	FightController.instance:dispatchEvent(FightEvent.BeforeSkillEffect, self.fightStepData)

	return self:onDone(true)
end

function FightWorkBeforeSkillEffect:_delayDone()
	logError(" FightWorkBeforeSkillEffect 保底 done 了 ")

	return self:onDone(true)
end

function FightWorkBeforeSkillEffect:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

return FightWorkBeforeSkillEffect
