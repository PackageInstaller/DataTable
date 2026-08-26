-- chunkname: @modules/logic/fight/system/work/FightWorkEnchantDepresseDamage314.lua

module("modules.logic.fight.system.work.FightWorkEnchantDepresseDamage314", package.seeall)

local FightWorkEnchantDepresseDamage314 = class("FightWorkEnchantDepresseDamage314", FightEffectBase)

function FightWorkEnchantDepresseDamage314:onStart()
	local entity = FightHelper.getEntity(self.actEffectData.targetId)

	if entity then
		local effectNum = self.actEffectData.effectNum

		if effectNum > 0 then
			if entity:isMySide() then
				if not -effectNum then
					local floatNum = effectNum

					FightFloatMgr.instance:float(entity.id, FightEnum.FloatType.damage, floatNum, nil, self.actEffectData.effectNum1 == 1)

					if entity.nameUI then
						entity.nameUI:addHp(-effectNum)
					end

					FightController.instance:dispatchEvent(FightEvent.OnHpChange, entity, -effectNum)
				end
			end
		end
	end

	self:onDone(true)
end

return FightWorkEnchantDepresseDamage314
