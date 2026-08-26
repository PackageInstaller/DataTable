-- chunkname: @modules/logic/fight/system/work/FightWorkEffectCardEffectChange.lua

module("modules.logic.fight.system.work.FightWorkEffectCardEffectChange", package.seeall)

local FightWorkEffectCardEffectChange = class("FightWorkEffectCardEffectChange", FightEffectBase)

function FightWorkEffectCardEffectChange:onStart()
	if not FightCardDataHelper.cardChangeIsMySide(self.actEffectData) then
		self:onDone(true)

		return
	end

	local flow = self:com_registFlowSequence()
	local needRemoveEffect = FightMsgMgr.sendMsg(FightMsgId.CheckCardRemoveRefrieratorEffect)

	if needRemoveEffect then
		self._revertVisible = true

		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)
		FightMsgMgr.sendMsg(FightMsgId.CardRemoveRefrieratorEffect)
		flow:registWork(FightWorkDelayTimer, 0.7 / FightModel.instance:getUISpeed())
	end

	local indexs = string.splitToNumber(self.actEffectData.reserveStr, "#")
	local handCards = FightDataHelper.handCardMgr.handCard

	for i, v in ipairs(indexs) do
		if handCards[v] then
			flow:registWork(FightWorkSendEvent, FightEvent.RefreshOneHandCard, v)
			flow:registWork(FightWorkSendEvent, FightEvent.CardEffectChange, v)
		end
	end

	self:playWorkAndDone(flow)
end

function FightWorkEffectCardEffectChange:clearWork()
	if self._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return FightWorkEffectCardEffectChange
