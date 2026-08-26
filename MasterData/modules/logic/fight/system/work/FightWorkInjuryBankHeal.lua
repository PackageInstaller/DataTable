-- chunkname: @modules/logic/fight/system/work/FightWorkInjuryBankHeal.lua

module("modules.logic.fight.system.work.FightWorkInjuryBankHeal", package.seeall)

local FightWorkInjuryBankHeal = class("FightWorkInjuryBankHeal", FightEffectBase)

function FightWorkInjuryBankHeal:onStart()
	local performanceTime = 2 / FightModel.instance:getSpeed()
	local entity = FightHelper.getEntity(self.actEffectData.targetId)

	if entity then
		if entity.nameUI then
			local effectNum = self.actEffectData.effectNum
			local floatType = FightEnum.FloatType.heal

			FightFloatMgr.instance:float(entity.id, floatType, effectNum, nil, self.actEffectData.effectNum1 == 1)
			entity.nameUI:addHp(effectNum)
			FightController.instance:dispatchEvent(FightEvent.OnHpChange, entity, effectNum)
		end

		if entity.spine then
			local spineGO = entity.spine:getSpineGO()

			if not spineGO then
				self:onDone(true)

				return
			end

			if not entity.effect then
				self:onDone(true)

				return
			end

			local effectWrap = entity.effect:addHangEffect("buff/buff_jiaxue", nil, nil, performanceTime)

			FightRenderOrderMgr.instance:onAddEffectWrap(entity.id, effectWrap)
			effectWrap:setLocalPos(0, 0, 0)
			FightAudioMgr.instance:playAudio(410000015)

			local entityMO = FightDataHelper.entityMgr:getById(entity.id)

			if not entityMO then
				self:onDone(true)

				return
			end

			local buffDic = entityMO:getBuffDic()
			local hasFeature = false

			for i, buffMO in pairs(buffDic) do
				if FightConfig.instance:hasBuffFeature(buffMO.buffId, FightEnum.BuffFeature.InjuryBank) then
					hasFeature = true

					break
				end
			end

			if hasFeature then
				local root = gohelper.findChild(spineGO, ModuleEnum.SpineHangPointRoot)
				local special1 = root and gohelper.findChild(root, "special1")

				if not special1 then
					self:onDone(true)

					return
				end

				local effectConfig = lua_fight_sp_effect_kkny_heal.configDict[entityMO.skin]

				if not effectConfig then
					self:onDone(true)

					return
				end

				local effectWrap = entity.effect:addHangEffect(effectConfig.path, effectConfig.hangPoint, nil, performanceTime)

				FightRenderOrderMgr.instance:onAddEffectWrap(entity.id, effectWrap)
				effectWrap:setLocalPos(0, 0, 0)
				FightAudioMgr.instance:playAudio(effectConfig.audio)
			end
		end
	end

	self:com_registTimer(self._delayAfterPerformance, performanceTime)
end

function FightWorkInjuryBankHeal:clearWork()
	return
end

return FightWorkInjuryBankHeal
