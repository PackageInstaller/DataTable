-- chunkname: @modules/logic/fight/system/work/FightWorkAdditionalDamage.lua

module("modules.logic.fight.system.work.FightWorkAdditionalDamage", package.seeall)

local FightWorkAdditionalDamage = class("FightWorkAdditionalDamage", FightEffectBase)

function FightWorkAdditionalDamage:onStart()
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
		local floatType = FightEnum.FloatType.additional_damage

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

return FightWorkAdditionalDamage
