-- chunkname: @modules/logic/fight/system/work/FightWorkCardRemove2.lua

module("modules.logic.fight.system.work.FightWorkCardRemove2", package.seeall)

local FightWorkCardRemove2 = class("FightWorkCardRemove2", FightEffectBase)

function FightWorkCardRemove2:beforePlayEffectData()
	self.oldHandCard = FightDataUtil.copyData(FightDataHelper.handCardMgr.handCard)
end

function FightWorkCardRemove2:onStart()
	if not FightCardDataHelper.cardChangeIsMySide(self.actEffectData) then
		self:onDone(true)

		return
	end

	self._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local removeIndexes = string.splitToNumber(self.actEffectData.reserveStr, "#")

	if #removeIndexes > 0 then
		local cards = self.oldHandCard

		table.sort(removeIndexes, FightWorkCardRemove2.sort)

		local delayTime = FightCardDataHelper.calcRemoveCardTime(cards, removeIndexes)

		for i, v in ipairs(removeIndexes) do
			table.remove(cards, v)
		end

		local version = FightModel.instance:getVersion()

		if version >= 4 then
			self:com_registTimer(self._delayAfterPerformance, delayTime / FightModel.instance:getUISpeed())
			FightController.instance:dispatchEvent(FightEvent.CardRemove2, removeIndexes)
		else
			FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
			self:onDone(true)
		end

		return
	end

	self:onDone(true)
end

function FightWorkCardRemove2.sort(item1, item2)
	return item2 < item1
end

function FightWorkCardRemove2:_delayAfterPerformance()
	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	self:onDone(true)
end

function FightWorkCardRemove2:clearWork()
	if self._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return FightWorkCardRemove2
