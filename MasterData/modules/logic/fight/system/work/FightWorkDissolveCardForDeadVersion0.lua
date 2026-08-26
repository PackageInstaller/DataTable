-- chunkname: @modules/logic/fight/system/work/FightWorkDissolveCardForDeadVersion0.lua

module("modules.logic.fight.system.work.FightWorkDissolveCardForDeadVersion0", package.seeall)

local FightWorkDissolveCardForDeadVersion0 = class("FightWorkDissolveCardForDeadVersion0", BaseWork)

function FightWorkDissolveCardForDeadVersion0:ctor(actEffectData)
	self.actEffectData = actEffectData
end

function FightWorkDissolveCardForDeadVersion0:onStart()
	TaskDispatcher.runDelay(self._delayDone, self, 0.5)

	local entityId = self.actEffectData.targetId
	local entity = FightHelper.getEntity(entityId)

	if not entity then
		self:onDone(true)

		return
	end

	local entity_mo = entity:getMO()

	if entity_mo then
		local removeIndexes = self:_calcRemoveCard(entityId)

		if removeIndexes then
			self:_removeCard(removeIndexes)

			return
		end
	end

	self:onDone(true)
end

function FightWorkDissolveCardForDeadVersion0:_removeCard(removeIndexes)
	self._needRemoveCard = true
	self._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local cards = FightDataHelper.handCardMgr.handCard
	local oldCount = #cards

	table.sort(removeIndexes, FightWorkCardRemove2.sort)

	for i, v in ipairs(removeIndexes) do
		table.remove(cards, v)
	end

	local dt = 0.033
	local delayTime = 1.2 + dt * 7 + 3 * dt * (oldCount - #removeIndexes)

	if FightCardDataHelper.canCombineCardListForPerformance(cards) then
		TaskDispatcher.cancelTask(self._delayDone, self)
		TaskDispatcher.runDelay(self._delayDone, self, 10)
		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, self._onCombineDone, self)
		FightController.instance:dispatchEvent(FightEvent.CardRemove, removeIndexes, delayTime, true)
	else
		TaskDispatcher.runDelay(self._delayAfterPerformance, self, delayTime / FightModel.instance:getUISpeed())
		FightController.instance:dispatchEvent(FightEvent.CardRemove, removeIndexes)
	end
end

function FightWorkDissolveCardForDeadVersion0:_onCombineDone()
	self:onDone(true)
end

function FightWorkDissolveCardForDeadVersion0:_delayDone()
	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	self:onDone(true)
end

function FightWorkDissolveCardForDeadVersion0:_delayAfterPerformance()
	self:onDone(true)
end

function FightWorkDissolveCardForDeadVersion0:_calcRemoveCard(entityId)
	local cards = FightDataHelper.handCardMgr.handCard
	local dissolveCardIndexs

	for i = #cards, 1, -1 do
		local cardInfo = cards[i]

		if cardInfo.uid == entityId then
			dissolveCardIndexs = dissolveCardIndexs or {}

			table.insert(dissolveCardIndexs, i)
		end
	end

	return dissolveCardIndexs
end

function FightWorkDissolveCardForDeadVersion0:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
	TaskDispatcher.cancelTask(self._delayAfterPerformance, self)

	if self._needRemoveCard and self._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end

	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, self._onCombineDone, self)
end

return FightWorkDissolveCardForDeadVersion0
