-- chunkname: @modules/logic/fight/system/work/FightWorkCardDeckDelete.lua

module("modules.logic.fight.system.work.FightWorkCardDeckDelete", package.seeall)

local FightWorkCardDeckDelete = class("FightWorkCardDeckDelete", FightEffectBase)

function FightWorkCardDeckDelete:onConstructor()
	self.SAFETIME = 3
end

function FightWorkCardDeckDelete:beforePlayEffectData()
	self.beforeNum = FightDataHelper.fieldMgr.deckNum
end

function FightWorkCardDeckDelete:onStart()
	local cardInfoList = self.actEffectData.cardInfoList

	if cardInfoList and #cardInfoList < 1 then
		return self:onDone(true)
	end

	local curDeckNum = FightDataHelper.fieldMgr.deckNum

	self:com_sendFightEvent(FightEvent.CardBoxNumChange, self.beforeNum, curDeckNum)
	self:com_registFightEvent(FightEvent.CardDeckDeleteDone, self._delayDone)
	self:com_sendFightEvent(FightEvent.CardDeckDelete, self.actEffectData.cardInfoList)
end

return FightWorkCardDeckDelete
