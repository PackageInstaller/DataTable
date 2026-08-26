-- chunkname: @modules/logic/fight/system/work/FightWorkExPointChange.lua

module("modules.logic.fight.system.work.FightWorkExPointChange", package.seeall)

local FightWorkExPointChange = class("FightWorkExPointChange", FightEffectBase)

function FightWorkExPointChange:beforePlayEffectData()
	self._entityId = self.actEffectData.targetId
	self._entityMO = FightDataHelper.entityMgr:getById(self._entityId)
	self._oldValue = self._entityMO and self._entityMO.exPoint
end

function FightWorkExPointChange:onStart()
	if not self._entityMO then
		self:onDone(true)

		return
	end

	self._newValue = self._entityMO and self._entityMO.exPoint

	if self._oldValue ~= self._newValue then
		FightController.instance:dispatchEvent(FightEvent.OnExPointChange, self._entityId, self._oldValue, self._newValue)

		local version = FightModel.instance:getVersion()

		if version < 1 and self._newValue < self._oldValue then
			if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Enter) then
				self:onDone(true)

				return
			end

			local removeIndexes = self:_calcRemoveCard()

			if removeIndexes then
				self:_removeCard(removeIndexes)

				return
			end
		end
	end

	self:onDone(true)
end

function FightWorkExPointChange:_removeCard(removeIndexes)
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
		self:com_registTimer(self._delayDone, 10)
		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, self._onCombineDone, self)
		FightController.instance:dispatchEvent(FightEvent.CardRemove, removeIndexes, delayTime, true)
	else
		self:com_registTimer(self._delayAfterPerformance, delayTime / FightModel.instance:getUISpeed())
		FightController.instance:dispatchEvent(FightEvent.CardRemove, removeIndexes)
	end
end

function FightWorkExPointChange:_onCombineDone()
	self:onDone(true)
end

function FightWorkExPointChange:_delayDone()
	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	self:onDone(true)
end

function FightWorkExPointChange:_delayAfterPerformance()
	self:onDone(true)
end

function FightWorkExPointChange:_calcRemoveCard()
	local cards = FightDataHelper.handCardMgr.handCard
	local dissolveCardIndexs

	for i, cardInfoMO in ipairs(cards) do
		local entityMO = FightDataHelper.entityMgr:getById(cardInfoMO.uid)

		if entityMO then
			local exPoint = entityMO:getExPoint()
			local maxExPoint = entityMO and entityMO:getUniqueSkillPoint() or 5
			local isBigSkill = FightCardDataHelper.isBigSkill(cardInfoMO.skillId)
			local isBigSkillInvalid = isBigSkill and exPoint < maxExPoint

			if isBigSkillInvalid then
				dissolveCardIndexs = dissolveCardIndexs or {}

				table.insert(dissolveCardIndexs, i)
			end
		end
	end

	return dissolveCardIndexs
end

function FightWorkExPointChange:clearWork()
	if self._needRemoveCard and self._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end

	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, self._onCombineDone, self)
end

return FightWorkExPointChange
