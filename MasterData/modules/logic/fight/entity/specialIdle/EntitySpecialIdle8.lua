-- chunkname: @modules/logic/fight/entity/specialIdle/EntitySpecialIdle8.lua

module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle8", package.seeall)

local EntitySpecialIdle8 = class("EntitySpecialIdle8", UserDataDispose)

function EntitySpecialIdle8:ctor(entity)
	self:__onInit()
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	FightController.instance:registerCallback(FightEvent.OnMySideRoundEnd, self._onMySideRoundEnd, self)

	self._act_round = 0
	self._round = 0
	self._entity = entity
end

function EntitySpecialIdle8:_onSkillPlayFinish(entity, skillId, fightStepData)
	if entity.id ~= self._entity.id then
		return
	end

	self._act_round = FightModel.instance:getCurRoundId()
end

function EntitySpecialIdle8:_onMySideRoundEnd()
	self._round = FightModel.instance:getCurRoundId()

	if self._round - self._act_round > 1 then
		self._act_round = self._round

		FightController.instance:dispatchEvent(FightEvent.PlaySpecialIdle, self._entity.id)
	end
end

function EntitySpecialIdle8:releaseSelf()
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)
	FightController.instance:unregisterCallback(FightEvent.OnMySideRoundEnd, self._onMySideRoundEnd, self)

	self._entity = nil

	self:__onDispose()
end

return EntitySpecialIdle8
