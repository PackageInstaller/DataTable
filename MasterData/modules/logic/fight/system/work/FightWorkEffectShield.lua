-- chunkname: @modules/logic/fight/system/work/FightWorkEffectShield.lua

module("modules.logic.fight.system.work.FightWorkEffectShield", package.seeall)

local FightWorkEffectShield = class("FightWorkEffectShield", FightEffectBase)

function FightWorkEffectShield:beforePlayEffectData()
	self._entityId = self.actEffectData.targetId
	self._entityMO = FightDataHelper.entityMgr:getById(self._entityId)

	if self._entityMO then
		self._oldValue = self._entityMO.shieldValue or 0
	end
end

function FightWorkEffectShield:onStart()
	if self.actEffectData.custom_nuoDiKaDamageSign then
		self:onDone(true)

		return
	end

	if self._entityMO then
		self._newValue = self._entityMO.shieldValue or 0
	end

	local entity = FightHelper.getEntity(self._entityId)

	if entity and entity.nameUI then
		entity.nameUI:setShield(self.actEffectData.effectNum)

		local changeValue = self.actEffectData.effectNum - self._oldValue

		if changeValue < 0 then
			local floatNum = entity:isMySide() and changeValue or -changeValue
			local floatType = self:_getOriginFloatType() or FightEnum.FloatType.damage

			FightFloatMgr.instance:float(entity.id, floatType, floatNum, nil, self.actEffectData.buffActId == 1)
		end

		FightController.instance:dispatchEvent(FightEvent.OnShieldChange, entity, changeValue)
		self:com_sendFightEvent(FightEvent.ChangeShield, entity.id)
	end

	self:onDone(true)
end

function FightWorkEffectShield:_getOriginFloatType()
	local index = tabletool.indexOf(self.fightStepData.actEffect, self.actEffectData)

	if index then
		local nextMO = self.fightStepData.actEffect[index + 1]

		if nextMO and nextMO.effectType == FightEnum.EffectType.SHIELDBROCKEN then
			nextMO = self.fightStepData.actEffect[index + 2]
		end

		if nextMO and nextMO.targetId == self.actEffectData.targetId then
			local isRestrain = FightHelper.isRestrain(self.fightStepData.fromId, self.actEffectData.targetId)

			if nextMO.hurtInfo then
				isRestrain = nextMO.hurtInfo.careerRestraint
			end

			if nextMO.effectType == FightEnum.EffectType.ORIGINDAMAGE then
				return FightEnum.FloatType.damage_origin
			elseif nextMO.effectType == FightEnum.EffectType.ORIGINCRIT then
				return FightEnum.FloatType.crit_damage_origin
			elseif nextMO.effectType == FightEnum.EffectType.ADDITIONALDAMAGE then
				return FightEnum.FloatType.additional_damage
			elseif nextMO.effectType == FightEnum.EffectType.ADDITIONALDAMAGECRIT then
				return FightEnum.FloatType.crit_additional_damage
			elseif nextMO.effectType == FightEnum.EffectType.DAMAGE then
				local isOppositeSide = FightHelper.isOppositeByEntityId(self.fightStepData.fromId, self.actEffectData.targetId)

				return (isRestrain and isOppositeSide or nil) and (FightEnum.FloatType.restrain or FightEnum.FloatType.damage)
			elseif nextMO.effectType == FightEnum.EffectType.CRIT then
				local isOppositeSide = FightHelper.isOppositeByEntityId(self.fightStepData.fromId, self.actEffectData.targetId)

				return (isRestrain and isOppositeSide or nil) and (FightEnum.FloatType.crit_restrain or FightEnum.FloatType.crit_damage)
			elseif nextMO.effectType == FightEnum.EffectType.DEADLYPOISONORIGINDAMAGE then
				return FightEnum.FloatType.damage_origin
			elseif nextMO.effectType == FightEnum.EffectType.DEADLYPOISONORIGINCRIT then
				return FightEnum.FloatType.crit_damage_origin
			end
		end
	end
end

return FightWorkEffectShield
