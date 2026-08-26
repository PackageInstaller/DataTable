-- chunkname: @modules/logic/fight/entity/specialIdle/EntitySpecialIdle4.lua

module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle4", package.seeall)

local EntitySpecialIdle4 = class("EntitySpecialIdle4", UserDataDispose)

function EntitySpecialIdle4:ctor(entity)
	self:__onInit()
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)

	self._entity = entity
end

function EntitySpecialIdle4:_onSkillPlayFinish(entity, skillId, fightStepData)
	if entity.id ~= self._entity.id then
		return
	end

	for i, v in ipairs(fightStepData.actEffect) do
		if v.effectType == FightEnum.EffectType.EXPOINTCHANGE and v.configEffect ~= 0 then
			FightController.instance:dispatchEvent(FightEvent.PlaySpecialIdle, entity.id)

			break
		end
	end
end

function EntitySpecialIdle4:releaseSelf()
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)

	self._entity = nil

	self:__onDispose()
end

return EntitySpecialIdle4
