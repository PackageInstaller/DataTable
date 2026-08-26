-- chunkname: @modules/logic/fight/system/work/FightWorkBFSGSkillStart.lua

module("modules.logic.fight.system.work.FightWorkBFSGSkillStart", package.seeall)

local FightWorkBFSGSkillStart = class("FightWorkBFSGSkillStart", FightEffectBase)

function FightWorkBFSGSkillStart:onStart()
	FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill = 1
	FightModel.forceParallelSkill = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, false)
	self:onDone(true)
end

function FightWorkBFSGSkillStart:clearWork()
	return
end

return FightWorkBFSGSkillStart
