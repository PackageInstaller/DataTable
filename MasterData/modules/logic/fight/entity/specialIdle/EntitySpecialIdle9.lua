-- chunkname: @modules/logic/fight/entity/specialIdle/EntitySpecialIdle9.lua

module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle9", package.seeall)

local EntitySpecialIdle9 = class("EntitySpecialIdle9", UserDataDispose)

function EntitySpecialIdle9:ctor(entity)
	self:__onInit()
	FightController.instance:registerCallback(FightEvent.OnMySideRoundEnd, self._onMySideRoundEnd, self)

	self._entity = entity
end

function EntitySpecialIdle9:_onMySideRoundEnd()
	FightController.instance:dispatchEvent(FightEvent.PlaySpecialIdle, self._entity.id)
end

function EntitySpecialIdle9:releaseSelf()
	FightController.instance:unregisterCallback(FightEvent.OnMySideRoundEnd, self._onMySideRoundEnd, self)

	self._entity = nil

	self:__onDispose()
end

return EntitySpecialIdle9
