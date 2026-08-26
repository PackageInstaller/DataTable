-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventRemoveSummoned.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventRemoveSummoned", package.seeall)

local FightTLEventRemoveSummoned = class("FightTLEventRemoveSummoned", FightTimelineTrackItem)

function FightTLEventRemoveSummoned:onTrackStart(fightStepData, duration, paramsArr)
	if paramsArr[1] == "1" then
		for i, v in ipairs(fightStepData.actEffect) do
			if v.effectType == FightEnum.EffectType.SUMMONEDDELETE then
				local class = FightWork2Work.New(FightWorkSummonedDelete, fightStepData, v)

				class:onStart()
			end
		end
	end
end

function FightTLEventRemoveSummoned:onTrackEnd()
	return
end

function FightTLEventRemoveSummoned:reset()
	return
end

function FightTLEventRemoveSummoned:dispose()
	return
end

return FightTLEventRemoveSummoned
