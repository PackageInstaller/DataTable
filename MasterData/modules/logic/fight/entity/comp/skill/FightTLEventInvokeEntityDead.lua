-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventInvokeEntityDead.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventInvokeEntityDead", package.seeall)

local FightTLEventInvokeEntityDead = class("FightTLEventInvokeEntityDead", FightTimelineTrackItem)

function FightTLEventInvokeEntityDead:onTrackStart(fightStepData, duration, paramsArr)
	for _, actEffectData in ipairs(fightStepData.actEffect) do
		if actEffectData.effectType == FightEnum.EffectType.DEAD then
			FightController.instance:dispatchEvent(FightEvent.InvokeEntityDeadImmediately, actEffectData.targetId, fightStepData)
		end
	end
end

function FightTLEventInvokeEntityDead:onTrackEnd()
	return
end

function FightTLEventInvokeEntityDead:onDestructor()
	return
end

return FightTLEventInvokeEntityDead
