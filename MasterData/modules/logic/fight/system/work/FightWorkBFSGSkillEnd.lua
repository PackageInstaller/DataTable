-- chunkname: @modules/logic/fight/system/work/FightWorkBFSGSkillEnd.lua

module("modules.logic.fight.system.work.FightWorkBFSGSkillEnd", package.seeall)

local FightWorkBFSGSkillEnd = class("FightWorkBFSGSkillEnd", FightEffectBase)

function FightWorkBFSGSkillEnd:onStart()
	FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill = false
	FightModel.forceParallelSkill = false

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, false, true)
	self:onDone(true)
end

function FightWorkBFSGSkillEnd:clearWork()
	return
end

return FightWorkBFSGSkillEnd
