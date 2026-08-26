-- chunkname: @modules/logic/fight/system/work/FightWorkEffectDamage.lua

module("modules.logic.fight.system.work.FightWorkEffectDamage", package.seeall)

local FightWorkEffectDamage = class("FightWorkEffectDamage", FightEffectBase)

function FightWorkEffectDamage:onStart()
	if self.actEffectData.custom_nuoDiKaDamageSign then
		self:com_sendFightEvent(FightEvent.OnCurrentHpChange, self.actEffectData.targetId)
		self:onDone(true)

		return
	end

	local hurtInfo = self.actEffectData.hurtInfo

	if not hurtInfo then
		self:onDone(true)

		return
	end

	local damageNum = hurtInfo.damage
	local reduceTeamShareShield = hurtInfo.reduceTeamShareShield
	local entity = FightHelper.getEntity(self.actEffectData.targetId)

	if entity then
		local floatNum = damageNum
		local floatType = self:getFloatType()

		if self.actEffectData.configEffect == 30006 then
			floatType = FightEnum.FloatType.damage
		end

		floatNum = entity:isMySide() and -floatNum or floatNum

		FightFloatMgr.instance:float(entity.id, floatType, floatNum, nil, self.actEffectData.effectNum1 == 1)

		local reduceHpNum = hurtInfo.reduceHp

		if reduceHpNum ~= 0 then
			if entity.nameUI then
				entity.nameUI:addHp(reduceHpNum)
			end

			FightController.instance:dispatchEvent(FightEvent.OnHpChange, entity, reduceHpNum)
		end

		local reduceShieldNum = hurtInfo.reduceShield

		if reduceShieldNum ~= 0 then
			reduceShieldNum = -reduceShieldNum
		end

		if entity.nameUI then
			local oldValue = entity.nameUI._curShield

			entity.nameUI:setShield(oldValue + reduceShieldNum)
		end

		if reduceShieldNum ~= 0 then
			FightController.instance:dispatchEvent(FightEvent.OnShieldChange, entity, reduceShieldNum)
		end

		if reduceTeamShareShield ~= 0 then
			FightMsgMgr.sendMsg(FightMsgId.RefreshYaMiShieldAfterDamage)
		end
	end

	FightGameMgr.triggerBuffMgr:triggerBuffEffect(self.actEffectData)
	self:onDone(true)
end

function FightWorkEffectDamage:getFloatType()
	local isRestrain = FightHelper.isRestrain(self.fightStepData.fromId, self.actEffectData.targetId)
	local isOppositeSide = FightHelper.isOppositeByEntityId(self.fightStepData.fromId, self.actEffectData.targetId)

	if (self.actEffectData.hurtInfo or nil) and self.actEffectData.hurtInfo.careerRestraint and isOppositeSide then
		if self.actEffectData.effectType == FightEnum.EffectType.DAMAGE then
			return FightEnum.FloatType.restrain
		elseif self.actEffectData.effectType == FightEnum.EffectType.CRIT then
			return FightEnum.FloatType.crit_restrain
		end
	elseif self.actEffectData.effectType == FightEnum.EffectType.DAMAGE then
		return FightEnum.FloatType.damage
	elseif self.actEffectData.effectType == FightEnum.EffectType.CRIT then
		return FightEnum.FloatType.crit_damage
	end

	return FightEnum.FloatType.damage
end

return FightWorkEffectDamage
