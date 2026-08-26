-- chunkname: @modules/logic/fight/system/work/FightWorkCardsCompose.lua

module("modules.logic.fight.system.work.FightWorkCardsCompose", package.seeall)

local FightWorkCardsCompose = class("FightWorkCardsCompose", FightEffectBase)

function FightWorkCardsCompose:onConstructor()
	self.skipAutoPlayData = true
end

function FightWorkCardsCompose:onStart()
	self._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local cards = FightDataHelper.handCardMgr.handCard
	local canCombine = FightCardDataHelper.canCombineCardListForPerformance(cards)

	if canCombine then
		self:com_registTimer(self._delayDone, 10)
		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, self._onCombineDone, self)
		FightController.instance:dispatchEvent(FightEvent.CardsCompose)
	else
		self:onDone(true)
	end
end

function FightWorkCardsCompose:_onCombineDone()
	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	self:onDone(true)
end

function FightWorkCardsCompose:_delayDone()
	FightController.instance:dispatchEvent(FightEvent.CardsComposeTimeOut)
	self:onDone(true)
end

function FightWorkCardsCompose:clearWork()
	if self._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end

	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, self._onCombineDone, self)
end

return FightWorkCardsCompose
