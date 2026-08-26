-- chunkname: @modules/logic/fight/system/work/FightWorkBFSGConvertCard.lua

module("modules.logic.fight.system.work.FightWorkBFSGConvertCard", package.seeall)

local FightWorkBFSGConvertCard = class("FightWorkBFSGConvertCard", FightEffectBase)

function FightWorkBFSGConvertCard:onStart()
	if not FightCardDataHelper.cardChangeIsMySide(self.actEffectData) then
		self:onDone(true)

		return
	end

	local cards = FightDataHelper.handCardMgr.handCard
	local index = self.actEffectData.effectNum
	local cardInfo = cards[index]

	if cardInfo then
		FightController.instance:dispatchEvent(FightEvent.RefreshOneHandCard, index)
	end

	self:onDone(true)
end

function FightWorkBFSGConvertCard:_delayDone()
	self:onDone(true)
end

function FightWorkBFSGConvertCard:clearWork()
	return
end

return FightWorkBFSGConvertCard
