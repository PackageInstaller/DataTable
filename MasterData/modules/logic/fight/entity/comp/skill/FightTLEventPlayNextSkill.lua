-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventPlayNextSkill.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventPlayNextSkill", package.seeall)

local FightTLEventPlayNextSkill = class("FightTLEventPlayNextSkill", FightTimelineTrackItem)

function FightTLEventPlayNextSkill:onTrackStart(fightStepData, duration, paramsArr)
	if FightModel.instance:canParallelSkill(fightStepData) then
		FightController.instance:dispatchEvent(FightEvent.ParallelPlayNextSkillCheck, fightStepData)
	end
end

return FightTLEventPlayNextSkill
