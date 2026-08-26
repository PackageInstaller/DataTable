-- chunkname: @modules/logic/fight/system/work/FightWorkRemoveEntityCards.lua

module("modules.logic.fight.system.work.FightWorkRemoveEntityCards", package.seeall)

local FightWorkRemoveEntityCards = class("FightWorkRemoveEntityCards", FightEffectBase)

function FightWorkRemoveEntityCards:beforePlayEffectData()
	self.oldHandCard = FightDataUtil.copyData(FightDataHelper.handCardMgr.handCard)
end

function FightWorkRemoveEntityCards:onStart()
	if not FightCardDataHelper.cardChangeIsMySide(self.actEffectData) then
		self:onDone(true)

		return
	end

	self._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local cards = self.oldHandCard
	local count = #cards
	local removeCount = 0

	for i = #cards, 1, -1 do
		local cardInfoMO = cards[i]

		if cardInfoMO.uid == self.actEffectData.targetId then
			removeCount = removeCount + 1
		end
	end

	if removeCount > 0 then
		local dt = 0.033
		local delayTime = 1.2 + dt * 7 + 3 * dt * (count - removeCount)
		local version = FightModel.instance:getVersion()

		if version >= 4 then
			self:com_registTimer(self._delayAfterPerformance, delayTime / FightModel.instance:getUISpeed())
			FightController.instance:dispatchEvent(FightEvent.RemoveEntityCards, self.actEffectData.targetId)
		else
			FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
			self:onDone(true)
		end
	else
		self:onDone(true)
	end
end

function FightWorkRemoveEntityCards:_delayAfterPerformance()
	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	self:onDone(true)
end

function FightWorkRemoveEntityCards:clearWork()
	if self._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return FightWorkRemoveEntityCards
