-- chunkname: @modules/logic/fight/system/work/FightWorkAct174UseCard.lua

module("modules.logic.fight.system.work.FightWorkAct174UseCard", package.seeall)

local FightWorkAct174UseCard = class("FightWorkAct174UseCard", FightEffectBase)

function FightWorkAct174UseCard:onConstructor()
	self.skipAutoPlayData = true
end

function FightWorkAct174UseCard:onStart()
	local useIndex = self.actEffectData.effectNum

	self:com_registTimer(self._delayAfterPerformance, 5)
	self:com_registFightEvent(FightEvent.PlayCardOver, self._onPlayCardOver)
	FightViewPartVisible.set(false, true, true, false, false)
	self:com_sendFightEvent(FightEvent.PlayHandCard, useIndex)
end

function FightWorkAct174UseCard:_onPlayCardOver()
	self:com_sendFightEvent(FightEvent.RefreshHandCard)
	self:onDone(true)
end

return FightWorkAct174UseCard
