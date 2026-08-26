-- chunkname: @modules/logic/fight/system/work/FightWorkResonanceLevel.lua

module("modules.logic.fight.system.work.FightWorkResonanceLevel", package.seeall)

local FightWorkResonanceLevel = class("FightWorkResonanceLevel", FightEffectBase)

function FightWorkResonanceLevel:onStart()
	FightRoundSequence.roundTempData.ResonanceLevel = self.actEffectData.effectNum

	FightController.instance:dispatchEvent(FightEvent.ResonanceLevel, self.actEffectData.effectNum)
	self:onDone(true)
end

function FightWorkResonanceLevel:clearWork()
	return
end

return FightWorkResonanceLevel
