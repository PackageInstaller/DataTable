-- chunkname: @modules/logic/fight/system/work/FightWorkEffectEnchantBurnDamage.lua

module("modules.logic.fight.system.work.FightWorkEffectEnchantBurnDamage", package.seeall)

local FightWorkEffectEnchantBurnDamage = class("FightWorkEffectEnchantBurnDamage", FightEffectBase)

function FightWorkEffectEnchantBurnDamage:onStart()
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

					local effectWrap = entity.effect:addHangEffect("buff/buff_shenghuo", "mountbody", nil, 1.5 / FightModel.instance:getSpeed())

					FightAudioMgr.instance:playAudio(4307301)
					FightRenderOrderMgr.instance:onAddEffectWrap(entity.id, effectWrap)
					effectWrap:setLocalPos(0, 0, 0)
				end
			end
		end
	end

	self:onDone(true)
end

return FightWorkEffectEnchantBurnDamage
