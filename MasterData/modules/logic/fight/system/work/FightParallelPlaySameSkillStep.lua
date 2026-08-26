-- chunkname: @modules/logic/fight/system/work/FightParallelPlaySameSkillStep.lua

module("modules.logic.fight.system.work.FightParallelPlaySameSkillStep", package.seeall)

local FightParallelPlaySameSkillStep = class("FightParallelPlaySameSkillStep", BaseWork)

function FightParallelPlaySameSkillStep:ctor(fightStepData, preStepData)
	self.fightStepData = fightStepData
	self.preStepData = preStepData

	FightController.instance:registerCallback(FightEvent.ParallelPlaySameSkillCheck, self._parallelPlaySameSkillCheck, self)
end

function FightParallelPlaySameSkillStep:onStart()
	self:onDone(true)
end

function FightParallelPlaySameSkillStep:_parallelPlaySameSkillCheck(playingFightStepData)
	if playingFightStepData ~= self.preStepData then
		return
	end

	if self.fightStepData.fromId == self.preStepData.fromId and self.fightStepData.actId == self.preStepData.actId and self.fightStepData.toId == self.preStepData.toId then
		FightController.instance:dispatchEvent(FightEvent.ParallelPlaySameSkillDoneThis, playingFightStepData)
	end
end

function FightParallelPlaySameSkillStep:clearWork()
	FightController.instance:unregisterCallback(FightEvent.ParallelPlaySameSkillCheck, self._parallelPlaySameSkillCheck, self)
end

return FightParallelPlaySameSkillStep
