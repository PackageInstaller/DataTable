-- chunkname: @modules/logic/fight/entity/specialIdle/EntitySpecialIdle7.lua

module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle7", package.seeall)

local EntitySpecialIdle7 = class("EntitySpecialIdle7", UserDataDispose)

function EntitySpecialIdle7:ctor(entity)
	self:__onInit()
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)

	self._entity = entity
end

function EntitySpecialIdle7:_onSkillPlayFinish(entity, skillId, fightStepData)
	if entity.id ~= self._entity.id then
		return
	end

	for i, v in ipairs(fightStepData.actEffect) do
		if v.effectType == FightEnum.EffectType.DEAD then
			FightController.instance:dispatchEvent(FightEvent.PlaySpecialIdle, entity.id)

			break
		end
	end
end

function EntitySpecialIdle7:releaseSelf()
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)

	self._entity = nil

	self:__onDispose()
end

return EntitySpecialIdle7
