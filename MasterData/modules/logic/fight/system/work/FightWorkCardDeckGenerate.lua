-- chunkname: @modules/logic/fight/system/work/FightWorkCardDeckGenerate.lua

module("modules.logic.fight.system.work.FightWorkCardDeckGenerate", package.seeall)

local FightWorkCardDeckGenerate = class("FightWorkCardDeckGenerate", FightEffectBase)

function FightWorkCardDeckGenerate:beforePlayEffectData()
	self.beforeNum = FightDataHelper.fieldMgr.deckNum
end

function FightWorkCardDeckGenerate:onStart()
	local curDeckNum = FightDataHelper.fieldMgr.deckNum

	self:com_sendFightEvent(FightEvent.CardBoxNumChange, self.beforeNum, curDeckNum)
	self:com_registFightEvent(FightEvent.CardDeckGenerateDone, self._delayDone)
	self:com_sendFightEvent(FightEvent.CardDeckGenerate, self.actEffectData.cardInfoList)
	self:onDone(true)
end

function FightWorkCardDeckGenerate:clearWork()
	return
end

return FightWorkCardDeckGenerate
