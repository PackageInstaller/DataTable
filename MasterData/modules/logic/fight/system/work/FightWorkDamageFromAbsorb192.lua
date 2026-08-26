-- chunkname: @modules/logic/fight/system/work/FightWorkDamageFromAbsorb192.lua

module("modules.logic.fight.system.work.FightWorkDamageFromAbsorb192", package.seeall)

local FightWorkDamageFromAbsorb192 = class("FightWorkDamageFromAbsorb192", FightEffectBase)

function FightWorkDamageFromAbsorb192:onStart()
	local hurtInfo = self.actEffectData.hurtInfo
	local hurtDamage = hurtInfo.damage
	local reduceHp = hurtInfo.reduceHp
	local entityId = self.actEffectData.targetId
	local entity = FightHelper.getEntity(entityId)

	if entity then
		if hurtDamage > 0 then
			if entity:isMySide() then
				if not -hurtDamage then
					do
						local floatNum = hurtDamage

						FightFloatMgr.instance:float(entity.id, FightEnum.FloatType.damage, floatNum, nil, hurtInfo.assassinate)

						if entity.nameUI then
							entity.nameUI:addHp(-reduceHp)
						end

						FightController.instance:dispatchEvent(FightEvent.OnHpChange, entity, -reduceHp)
					end

					if not entity.effect then
						self:onDone(true)

						return
					end
				end
			end
		end

		if entity.spine then
			local spineGO = entity.spine:getSpineGO()

			if not spineGO then
				self:onDone(true)

				return
			end

			local root = gohelper.findChild(spineGO, ModuleEnum.SpineHangPointRoot)
			local special1 = root and gohelper.findChild(root, "special1")

			if not special1 then
				self:onDone(true)

				return
			end

			local entityMO = FightDataHelper.entityMgr:getById(entity.id)

			if not entityMO then
				self:onDone(true)

				return
			end

			local effectConfig = lua_fight_sp_effect_kkny_bear_damage.configDict[entityMO.skin]

			if not effectConfig then
				self:onDone(true)

				return
			end

			local effectWrap = entity.effect:addHangEffect(effectConfig.path, effectConfig.hangPoint, nil, 1.2 / FightModel.instance:getSpeed())

			FightAudioMgr.instance:playAudio(effectConfig.audio)
			FightRenderOrderMgr.instance:onAddEffectWrap(entity.id, effectWrap)
			effectWrap:setLocalPos(0, 0, 0)
		end
	end

	FightMsgMgr.sendMsg(FightMsgId.EntityHurt, entityId, hurtInfo)
	self:onDone(true)
end

return FightWorkDamageFromAbsorb192
