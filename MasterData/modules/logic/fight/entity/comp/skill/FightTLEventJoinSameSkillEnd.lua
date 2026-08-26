-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventJoinSameSkillEnd.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventJoinSameSkillEnd", package.seeall)

local FightTLEventJoinSameSkillEnd = class("FightTLEventJoinSameSkillEnd", FightTimelineTrackItem)

function FightTLEventJoinSameSkillEnd:onTrackStart(fightStepData, duration, paramsArr)
	return
end

function FightTLEventJoinSameSkillEnd:reset()
	return
end

function FightTLEventJoinSameSkillEnd:dispose()
	return
end

return FightTLEventJoinSameSkillEnd
