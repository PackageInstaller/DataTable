-- chunkname: @modules/logic/fight/system/work/FightWorkShieldValueChange.lua

module("modules.logic.fight.system.work.FightWorkShieldValueChange", package.seeall)

local FightWorkShieldValueChange = class("FightWorkShieldValueChange", FightEffectBase)

function FightWorkShieldValueChange:beforePlayEffectData()
	self._entityId = self.actEffectData.targetId
	self._entityMO = FightDataHelper.entityMgr:getById(self._entityId)
	self._oldValue = self._entityMO and self._entityMO.shieldValue
end

function FightWorkShieldValueChange:onStart()
	if not self._entityMO then
		self:onDone(true)

		return
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
	end

	self:onDone(true)
end

function FightWorkShieldValueChange:_getOriginFloatType()
	local index = tabletool.indexOf(self.fightStepData.actEffect, self.actEffectData)

	if index then
		local nextMO = self.fightStepData.actEffect[index + 1]

		if nextMO and nextMO.effectType == FightEnum.EffectType.SHIELDBROCKEN then
			nextMO = self.fightStepData.actEffect[index + 2]
		end

		if nextMO and nextMO.targetId == self._entityId then
			if nextMO.effectType == FightEnum.EffectType.ORIGINDAMAGE then
				return FightEnum.FloatType.damage_origin
			elseif nextMO.effectType == FightEnum.EffectType.ORIGINCRIT then
				return FightEnum.FloatType.crit_damage_origin
			elseif nextMO.effectType == FightEnum.EffectType.ADDITIONALDAMAGE then
				return FightEnum.FloatType.additional_damage
			elseif nextMO.effectType == FightEnum.EffectType.ADDITIONALDAMAGECRIT then
				return FightEnum.FloatType.crit_additional_damage
			end
		end
	end
end

return FightWorkShieldValueChange
