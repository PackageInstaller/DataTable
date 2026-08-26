-- chunkname: @modules/logic/fight/system/work/FightWorkCounterChange381.lua

module("modules.logic.fight.system.work.FightWorkCounterChange381", package.seeall)

local FightWorkCounterChange381 = class("FightWorkCounterChange381", FightEffectBase)

function FightWorkCounterChange381:onStart()
	local counterId = self.actEffectData.effectNum
	local counterValue = self.actEffectData.reserveStr

	FightController.instance:dispatchEvent(FightEvent.OnCounterChange, counterId, counterValue)

	return self:onDone(true)
end

return FightWorkCounterChange381
