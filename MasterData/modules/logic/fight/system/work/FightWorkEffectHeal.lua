-- chunkname: @modules/logic/fight/system/work/FightWorkEffectHeal.lua

module("modules.logic.fight.system.work.FightWorkEffectHeal", package.seeall)

local FightWorkEffectHeal = class("FightWorkEffectHeal", FightEffectBase)

function FightWorkEffectHeal:onStart()
	if not self.actEffectData then
		self:onDone(true)

		return
	end

	local entity = FightHelper.getEntity(self.actEffectData.targetId)

	if entity then
		if not entity.nameUI then
			self:onDone(true)

			return
		end

		local prevHp = entity.nameUI:getHp()
		local effectNum = self.actEffectData.effectNum

		if self.actEffectData.effectType == FightEnum.EffectType.HEALCRIT then
			if not FightEnum.FloatType.crit_heal then
				local floatType = FightEnum.FloatType.heal

				FightFloatMgr.instance:float(entity.id, floatType, effectNum, nil, self.actEffectData.effectNum1 == 1)
				entity.nameUI:addHp(effectNum)
				FightController.instance:dispatchEvent(FightEvent.OnHpChange, entity, effectNum)

				local nowHp = entity.nameUI:getHp()

				if prevHp <= 0 and nowHp > 0 and not FightSkillMgr.instance:isPlayingAnyTimeline() then
					entity.nameUI:setActive(true)
				end

				local configEffect = self.actEffectData.configEffect

				if configEffect == FightEnum.BehaviourId.FakeHpToHeal then
					FightController.instance:dispatchEvent(FightEvent.OnTrigger_HSY_FakeHPEffect, self.actEffectData.targetId)
				end
			end
		end
	end

	FightGameMgr.triggerBuffMgr:triggerBuffEffect(self.actEffectData)
	self:onDone(true)
end

return FightWorkEffectHeal
