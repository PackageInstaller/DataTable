-- chunkname: @modules/logic/fight/system/work/FightWorkCardRemove.lua

module("modules.logic.fight.system.work.FightWorkCardRemove", package.seeall)

local FightWorkCardRemove = class("FightWorkCardRemove", FightEffectBase)
local RemoveType = {
	Default = 0,
	DeviceRemove = 1,
	HeDuoNie = 2
}

function FightWorkCardRemove:onConstructor()
	self.SAFETIME = 3
end

function FightWorkCardRemove:beforePlayEffectData()
	self:setRefrigeratorSign()

	self.oldCardList = FightDataUtil.copyData(FightDataHelper.handCardMgr.handCard)
end

function FightWorkCardRemove:onStart()
	if not FightCardDataHelper.cardChangeIsMySide(self.actEffectData) then
		self:onDone(true)

		return
	end

	self._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local removeType = self.actEffectData.effectNum
	local removeIndexes = string.splitToNumber(self.actEffectData.reserveStr, "#")

	if #removeIndexes > 0 then
		local cards = self.oldCardList

		table.sort(removeIndexes, FightWorkCardRemove2.sort)

		for i, v in ipairs(removeIndexes) do
			table.remove(cards, v)
		end

		local version = FightModel.instance:getVersion()

		if version >= 4 then
			if removeType == RemoveType.DeviceRemove then
				FightController.instance:registerCallback(FightEvent.OnDevice_RemoveHandCardDone, self._delayAfterPerformance, self)
				FightController.instance:dispatchEvent(FightEvent.OnDevice_RemoveHandCard, removeIndexes)
			elseif removeType == RemoveType.HeDuoNie then
				FightController.instance:registerCallback(FightEvent.OnHeDuoNieRemoveCardDone, self._delayAfterPerformance, self)
				FightController.instance:dispatchEvent(FightEvent.OnHeDuoNieRemoveCard, removeIndexes)
			else
				local delayTime = FightCardDataHelper.calcRemoveCardTime(cards, removeIndexes)

				delayTime = delayTime / FightModel.instance:getUISpeed()

				if self.timeOffsetRefrigerator then
					delayTime = delayTime + self.timeOffsetRefrigerator
				end

				self:com_registTimer(self._delayAfterPerformance, delayTime)
				FightController.instance:dispatchEvent(FightEvent.CardRemove, removeIndexes)
			end
		else
			FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
			self:onDone(true)
		end

		return
	end

	self:onDone(true)
end

function FightWorkCardRemove:setRefrigeratorSign()
	local jsonParam = self.actEffectData.jsonParam

	if jsonParam then
		local buffActActiveIds = jsonParam.buffActActiveIds
		local arr = string.split(buffActActiveIds, "|")

		for _, v in ipairs(arr) do
			local value = string.split(v, "#")
			local buffActId = tonumber(value[1])

			if buffActId == 10034 then
				local cardList = FightDataHelper.handCardMgr:getHandCard()
				local indexArr = string.split(value[2], ",")

				for i = 1, #indexArr do
					local index = tonumber(indexArr[i])

					if cardList[index] then
						cardList[index].clientData.custom_addToRefrigerator = true
						self.timeOffsetRefrigerator = 0.5

						FightMsgMgr.sendMsg(FightMsgId.CardRemoveRefrieratorTimeline)
					end
				end
			end
		end
	end
end

function FightWorkCardRemove:_onCombineDone()
	self:onDone(true)
end

function FightWorkCardRemove:_delayAfterPerformance()
	self:onDone(true)
end

function FightWorkCardRemove:_delayDone()
	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	self:onDone(true)
end

function FightWorkCardRemove:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, self._onCombineDone, self)
	FightController.instance:unregisterCallback(FightEvent.OnDevice_RemoveHandCardDone, self._delayAfterPerformance, self)
	FightController.instance:unregisterCallback(FightEvent.OnHeDuoNieRemoveCardDone, self._delayAfterPerformance, self)

	if self._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return FightWorkCardRemove
