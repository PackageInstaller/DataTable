-- chunkname: @modules/logic/fight/system/work/FightWorkPolarizationLevel.lua

module("modules.logic.fight.system.work.FightWorkPolarizationLevel", package.seeall)

local FightWorkPolarizationLevel = class("FightWorkPolarizationLevel", FightEffectBase)

function FightWorkPolarizationLevel:onStart()
	FightRoundSequence.roundTempData.PolarizationLevel = FightRoundSequence.roundTempData.PolarizationLevel or {}
	FightRoundSequence.roundTempData.PolarizationLevel[self.actEffectData.configEffect] = self.actEffectData

	FightController.instance:dispatchEvent(FightEvent.PolarizationLevel, self.actEffectData.effectNum)
	self:onDone(true)
end

function FightWorkPolarizationLevel:clearWork()
	return
end

return FightWorkPolarizationLevel
