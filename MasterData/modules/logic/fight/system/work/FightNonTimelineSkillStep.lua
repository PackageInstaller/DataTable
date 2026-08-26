-- chunkname: @modules/logic/fight/system/work/FightNonTimelineSkillStep.lua

module("modules.logic.fight.system.work.FightNonTimelineSkillStep", package.seeall)

local FightNonTimelineSkillStep = class("FightNonTimelineSkillStep", BaseWork)

function FightNonTimelineSkillStep:ctor(fightStepData, preFightStepData, skillCounter)
	self.fightStepData = fightStepData
end

function FightNonTimelineSkillStep:onStart()
	FightController.instance:dispatchEvent(FightEvent.OnInvokeSkill, self.fightStepData)
	self:onDone(true)
end

return FightNonTimelineSkillStep
