-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventJoinSameSkillStart.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventJoinSameSkillStart", package.seeall)

local FightTLEventJoinSameSkillStart = class("FightTLEventJoinSameSkillStart", FightTimelineTrackItem)

function FightTLEventJoinSameSkillStart:onTrackStart(fightStepData, duration, paramsArr)
	if not FightModel.instance:canParallelSkill(fightStepData) then
		return
	end

	self._attacker = FightHelper.getEntity(fightStepData.fromId)

	if self._attacker and self._attacker.skill then
		self._attacker.skill:recordSameSkillStartParam(fightStepData, paramsArr)
	end
end

return FightTLEventJoinSameSkillStart
