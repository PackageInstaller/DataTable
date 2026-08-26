-- chunkname: @modules/logic/fight/system/work/FightWorkMasterCardRemove.lua

module("modules.logic.fight.system.work.FightWorkMasterCardRemove", package.seeall)

local FightWorkMasterCardRemove = class("FightWorkMasterCardRemove", FightEffectBase)

function FightWorkMasterCardRemove:beforePlayEffectData()
	self.oldHandCard = FightDataUtil.copyData(FightDataHelper.handCardMgr.handCard)
end

function FightWorkMasterCardRemove:onStart()
	if not FightCardDataHelper.cardChangeIsMySide(self.actEffectData) then
		self:onDone(true)

		return
	end

	self._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local removeIndexes = string.splitToNumber(self.actEffectData.reserveStr, "#")

	if #removeIndexes > 0 then
		AudioMgr.instance:trigger(20190020)

		local cards = self.oldHandCard

		table.sort(removeIndexes, FightWorkCardRemove2.sort)

		local delayTime = FightCardDataHelper.calcRemoveCardTime(cards, removeIndexes, 0.7)

		for i, v in ipairs(removeIndexes) do
			table.remove(cards, v)
		end

		local version = FightModel.instance:getVersion()

		if version >= 4 then
			self:com_registTimer(self._delayAfterPerformance, delayTime / FightModel.instance:getUISpeed())
			FightController.instance:dispatchEvent(FightEvent.MasterCardRemove, removeIndexes)
		else
			FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
			self:onDone(true)
		end

		return
	end

	self:onDone(true)
end

function FightWorkMasterCardRemove:_delayAfterPerformance()
	self:onDone(true)
end

function FightWorkMasterCardRemove:clearWork()
	if self._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return FightWorkMasterCardRemove
