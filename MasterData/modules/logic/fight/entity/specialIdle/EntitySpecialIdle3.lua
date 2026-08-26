-- chunkname: @modules/logic/fight/entity/specialIdle/EntitySpecialIdle3.lua

module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle3", package.seeall)

local EntitySpecialIdle3 = class("EntitySpecialIdle3", UserDataDispose)

function EntitySpecialIdle3:ctor(entity)
	self:__onInit()
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)

	self._entity = entity
end

function EntitySpecialIdle3:_onSkillPlayFinish(entity, skillId)
	if entity.id ~= self._entity.id then
		return
	end

	if FightCardDataHelper.isBigSkill(skillId) then
		FightController.instance:dispatchEvent(FightEvent.PlaySpecialIdle, entity.id)
	end
end

function EntitySpecialIdle3:releaseSelf()
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)

	self._entity = nil

	self:__onDispose()
end

return EntitySpecialIdle3
