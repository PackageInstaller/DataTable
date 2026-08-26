-- chunkname: @modules/logic/fight/entity/specialIdle/EntitySpecialIdle1.lua

module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle1", package.seeall)

local EntitySpecialIdle1 = class("EntitySpecialIdle1", UserDataDispose)

function EntitySpecialIdle1:ctor(entity)
	self:__onInit()
	FightController.instance:registerCallback(FightEvent.OnBuffUpdate, self._onBuffUpdate, self)

	self._entity = entity
end

function EntitySpecialIdle1:detectState()
	local entity_mo = self._entity:getMO()

	if entity_mo then
		local buffDic = entity_mo:getBuffDic()

		if buffDic then
			for i, buff in pairs(buffDic) do
				if buff.buffId == 30513 or buff.buffId == 30515 then
					FightController.instance:dispatchEvent(FightEvent.PlaySpecialIdle, self._entity.id)
				end
			end
		end
	end
end

function EntitySpecialIdle1:_onBuffUpdate(targetId, effectType, buffId)
	if targetId ~= self._entity.id then
		return
	end

	if effectType == FightEnum.EffectType.BUFFADD and (buffId == 30513 or buffId == 30515) then
		FightController.instance:dispatchEvent(FightEvent.PlaySpecialIdle, self._entity.id)
	end
end

function EntitySpecialIdle1:releaseSelf()
	FightController.instance:unregisterCallback(FightEvent.OnBuffUpdate, self._onBuffUpdate, self)

	self._entity = nil

	self:__onDispose()
end

return EntitySpecialIdle1
