-- chunkname: @modules/logic/fight/system/work/FightWorkCardDeckNum.lua

module("modules.logic.fight.system.work.FightWorkCardDeckNum", package.seeall)

local FightWorkCardDeckNum = class("FightWorkCardDeckNum", FightEffectBase)

function FightWorkCardDeckNum:beforePlayEffectData()
	self.afterDeckNum = FightDataHelper.fieldMgr.deckNum
end

function FightWorkCardDeckNum:onStart()
	local curDeckNum = FightDataHelper.fieldMgr.deckNum

	self:com_sendFightEvent(FightEvent.CardBoxNumChange, self.afterDeckNum, curDeckNum)
	self:onDone(true)
end

return FightWorkCardDeckNum
