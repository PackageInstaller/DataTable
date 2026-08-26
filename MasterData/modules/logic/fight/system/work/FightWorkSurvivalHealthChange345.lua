-- chunkname: @modules/logic/fight/system/work/FightWorkSurvivalHealthChange345.lua

module("modules.logic.fight.system.work.FightWorkSurvivalHealthChange345", package.seeall)

local FightWorkSurvivalHealthChange345 = class("FightWorkSurvivalHealthChange345", FightEffectBase)

function FightWorkSurvivalHealthChange345:beforePlayEffectData()
	self.oldHealth = FightHelper.getSurvivalEntityHealth(self.actEffectData.targetId)
end

function FightWorkSurvivalHealthChange345:onStart()
	local curValue = FightHelper.getSurvivalEntityHealth(self.actEffectData.targetId)
	local offset = self.actEffectData.effectNum

	FightController.instance:dispatchEvent(FightEvent.HeroHealthValueChange, self.actEffectData.targetId, self.oldHealth, curValue, offset)

	return self:onDone(true)
end

return FightWorkSurvivalHealthChange345
