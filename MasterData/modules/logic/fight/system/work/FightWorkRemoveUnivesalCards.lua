-- chunkname: @modules/logic/fight/system/work/FightWorkRemoveUnivesalCards.lua

module("modules.logic.fight.system.work.FightWorkRemoveUnivesalCards", package.seeall)

local FightWorkRemoveUnivesalCards = class("FightWorkRemoveUnivesalCards", FightEffectBase)

function FightWorkRemoveUnivesalCards:beforePlayEffectData()
	self.oldHandCard = FightDataUtil.copyData(FightDataHelper.handCardMgr.handCard)
end

function FightWorkRemoveUnivesalCards:onStart(context)
	if not FightCardDataHelper.cardChangeIsMySide(self.actEffectData) then
		self:onDone(true)

		return
	end

	self._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local removeIndexes = {}
	local cards = self.oldHandCard
	local oldCount = #cards

	for i = #cards, 1, -1 do
		local cardInfoMO = cards[i]

		if FightEnum.UniversalCard[cardInfoMO.skillId] then
			table.insert(removeIndexes, i)
		end
	end

	if #removeIndexes > 0 then
		local dt = 0.033
		local delayTime = 1.2 + dt * 7 + 3 * dt * (oldCount - #removeIndexes)
		local version = FightModel.instance:getVersion()

		if version >= 4 then
			self:com_registTimer(self._delayAfterPerformance, delayTime / FightModel.instance:getUISpeed())
			FightController.instance:dispatchEvent(FightEvent.CardRemove, removeIndexes)
		else
			FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
			self:onDone(true)
		end
	else
		self:onDone(true)
	end
end

function FightWorkRemoveUnivesalCards:_delayAfterPerformance()
	self:onDone(true)
end

function FightWorkRemoveUnivesalCards:clearWork()
	if self._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return FightWorkRemoveUnivesalCards
