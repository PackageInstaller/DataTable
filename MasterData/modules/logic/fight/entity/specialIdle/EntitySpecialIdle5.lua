-- chunkname: @modules/logic/fight/entity/specialIdle/EntitySpecialIdle5.lua

module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle5", package.seeall)

local EntitySpecialIdle5 = class("EntitySpecialIdle5", UserDataDispose)

function EntitySpecialIdle5:ctor(entity)
	self:__onInit()
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)

	self._entity = entity
end

function EntitySpecialIdle5:_onSkillPlayFinish(entity, skillId, fightStepData)
	if entity.id ~= self._entity.id then
		return
	end

	for index, skill_id in ipairs(self._entity:getMO().skillGroup2) do
		if skillId == skill_id then
			FightController.instance:dispatchEvent(FightEvent.PlaySpecialIdle, entity.id)

			break
		end
	end
end

function EntitySpecialIdle5:releaseSelf()
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)

	self._entity = nil

	self:__onDispose()
end

return EntitySpecialIdle5
