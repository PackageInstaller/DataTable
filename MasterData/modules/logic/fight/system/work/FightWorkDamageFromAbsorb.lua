-- chunkname: @modules/logic/fight/system/work/FightWorkDamageFromAbsorb.lua

module("modules.logic.fight.system.work.FightWorkDamageFromAbsorb", package.seeall)

local FightWorkDamageFromAbsorb = class("FightWorkDamageFromAbsorb", FightEffectBase)

function FightWorkDamageFromAbsorb:onStart()
	local entity = FightHelper.getEntity(self.actEffectData.targetId)

	if entity then
		local effectNum = self.actEffectData.effectNum

		if effectNum > 0 then
			if entity:isMySide() then
				if not -effectNum then
					do
						local floatNum = effectNum

						FightFloatMgr.instance:float(entity.id, FightEnum.FloatType.damage, floatNum, nil, self.actEffectData.effectNum1 == 1)

						if entity.nameUI then
							entity.nameUI:addHp(-effectNum)
						end

						FightController.instance:dispatchEvent(FightEvent.OnHpChange, entity, -effectNum)
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

	self:onDone(true)
end

function FightWorkDamageFromAbsorb:clearWork()
	return
end

return FightWorkDamageFromAbsorb
