-- chunkname: @modules/logic/fight/system/work/FightWorkAddHandCard.lua

module("modules.logic.fight.system.work.FightWorkAddHandCard", package.seeall)

local FightWorkAddHandCard = class("FightWorkAddHandCard", FightEffectBase)
local ADD_CARD_TYPE = {
	Default = 0,
	HeDuoNie = 1
}

function FightWorkAddHandCard:onStart()
	if not FightCardDataHelper.cardChangeIsMySide(self.actEffectData) then
		self:onDone(true)

		return
	end

	self._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local addType = self.actEffectData.effectNum
	local version = FightModel.instance:getVersion()

	if version >= 4 then
		if addType == ADD_CARD_TYPE.HeDuoNie then
			self:heDuoNieHandle()
		else
			self:defaultHandle()
		end
	else
		FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
		self:onDone(true)
	end
end

function FightWorkAddHandCard:heDuoNieHandle()
	self:cancelFightWorkSafeTimer()
	self:com_registTimer(self._fightWorkSafeTimer, 1)
	FightDataHelper.tempMgr:getHeDuoNieDataMgr():clearData()
	self:com_registFightEvent(FightEvent.OnHeDuoNieAddCardDone, self._delayAfterPerformance)
	self:com_sendFightEvent(FightEvent.OnHeDuoNieAddCard)
end

function FightWorkAddHandCard:defaultHandle()
	local flow = self:com_registFlowParallel()

	if self.actEffectData.reserveId == "10034" then
		local cardList = FightDataHelper.handCardMgr:getHandCard()
		local cardData = cardList[#cardList]

		cardData.clientData.custom_addFromRefrigerator = true

		local work = FightMsgMgr.sendMsg(FightMsgId.CardAddRefrieratorTimeline)

		flow:addWork(work)
	end

	local delayTime = 0.5 / FightModel.instance:getUISpeed()

	flow:registWork(FightWorkDelayTimer, delayTime)
	flow:registWork(FightWorkSendEvent, FightEvent.AddHandCard)
	self:playWorkAndDone(flow)
end

function FightWorkAddHandCard:clearWork()
	if self._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return FightWorkAddHandCard
