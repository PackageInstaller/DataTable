-- chunkname: @modules/logic/fight/system/work/FightWorkSkillFinallyHeal.lua

module("modules.logic.fight.system.work.FightWorkSkillFinallyHeal", package.seeall)

local FightWorkSkillFinallyHeal = class("FightWorkSkillFinallyHeal", BaseWork)

function FightWorkSkillFinallyHeal:ctor(fightStepData)
	self.fightStepData = fightStepData
	self._actEffect = {}
end

function FightWorkSkillFinallyHeal:addActEffectData(actEffectData)
	table.insert(self._actEffect, actEffectData)
end

function FightWorkSkillFinallyHeal:onStart()
	local attacker = FightHelper.getEntity(self.fightStepData.fromId)

	if not attacker then
		self:onDone(true)

		return
	end

	local skillId = self.fightStepData.actId
	local mo = attacker:getMO()
	local skinId = mo and mo.skin
	local timeline = FightConfig.instance:getSkinSkillTimeline(skinId, skillId)

	if string.nilorempty(timeline) then
		self:onDone(true)

		return
	end

	TaskDispatcher.runDelay(self._delayDone, self, 20 / FightModel.instance:getSpeed())
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, self._onSkillEnd, self)
	FightController.instance:registerCallback(FightEvent.OnTimelineHeal, self._onTimelineHeal, self)
end

function FightWorkSkillFinallyHeal:_delayDone()
	self:onDone(true)
end

function FightWorkSkillFinallyHeal:_onSkillEnd(attacker, skillId, fightStepData)
	if fightStepData ~= self.fightStepData then
		return
	end

	self:_removeEvents()

	for _, actEffectData in ipairs(self._actEffect) do
		local entity = FightHelper.getEntity(actEffectData.targetId)

		if entity and not entity.isDead then
			FightDataHelper.playEffectData(actEffectData)

			if actEffectData.effectType == FightEnum.EffectType.HEAL then
				FightFloatMgr.instance:float(entity.id, FightEnum.FloatType.heal, actEffectData.effectNum, nil, actEffectData.effectNum1 == 1)
			elseif actEffectData.effectType == FightEnum.EffectType.HEALCRIT then
				FightFloatMgr.instance:float(entity.id, FightEnum.FloatType.crit_heal, actEffectData.effectNum, nil, actEffectData.effectNum1 == 1)
			end

			if entity.nameUI then
				entity.nameUI:addHp(actEffectData.effectNum)

				if not FightSkillMgr.instance:isPlayingAnyTimeline() then
					entity.nameUI:setActive(true)
				end
			end

			FightController.instance:dispatchEvent(FightEvent.OnHpChange, entity, actEffectData.effectNum)
		end
	end

	self:onDone(true)
end

function FightWorkSkillFinallyHeal:_onTimelineHeal(actEffectData)
	tabletool.removeValue(self._actEffect, actEffectData)
end

function FightWorkSkillFinallyHeal:_removeEvents()
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, self._onSkillEnd, self)
	FightController.instance:unregisterCallback(FightEvent.OnTimelineHeal, self._onTimelineHeal, self)
end

function FightWorkSkillFinallyHeal:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
	self:_removeEvents()
end

return FightWorkSkillFinallyHeal
