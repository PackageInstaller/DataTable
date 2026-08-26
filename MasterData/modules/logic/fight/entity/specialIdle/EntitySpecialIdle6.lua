-- chunkname: @modules/logic/fight/entity/specialIdle/EntitySpecialIdle6.lua

module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle6", package.seeall)

local EntitySpecialIdle6 = class("EntitySpecialIdle6", UserDataDispose)

function EntitySpecialIdle6:ctor(entity)
	self:__onInit()
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)

	self._entity = entity
end

function EntitySpecialIdle6:_onSkillPlayFinish(entity, skillId, fightStepData)
	local def_entity = FightHelper.getEntity(fightStepData.toId)

	if def_entity and def_entity:isMySide() then
		local entityMO = def_entity:getMO()

		if entityMO and entityMO.modelId == 3025 then
			for i, v in ipairs(fightStepData.actEffect) do
				if v.effectType == FightEnum.EffectType.MISS and v.targetId == def_entity.id then
					local buffDic = entityMO:getBuffDic()

					for index, buffMO in pairs(buffDic) do
						if buffMO.buffId == 710601 or buffMO.buffId == 710602 then
							FightController.instance:dispatchEvent(FightEvent.PlaySpecialIdle, def_entity.id)

							return
						end
					end
				end
			end
		end
	end
end

function EntitySpecialIdle6:releaseSelf()
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillPlayFinish, self)

	self._entity = nil

	self:__onDispose()
end

return EntitySpecialIdle6
