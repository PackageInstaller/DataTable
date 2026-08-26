-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventALFCardEffect.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventALFCardEffect", package.seeall)

local FightTLEventALFCardEffect = class("FightTLEventALFCardEffect", FightTimelineTrackItem)

function FightTLEventALFCardEffect:onTrackStart(fightStepData, duration, paramsArr)
	return
end

function FightTLEventALFCardEffect:onTrackEnd()
	return
end

return FightTLEventALFCardEffect
