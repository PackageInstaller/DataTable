-- chunkname: @modules/logic/fight/system/work/FightWorkUseCards.lua

module("modules.logic.fight.system.work.FightWorkUseCards", package.seeall)

local FightWorkUseCards = class("FightWorkUseCards", FightEffectBase)

function FightWorkUseCards:onStart()
	FightPlayCardModel.instance:setUsedCard(self.actEffectData.cardInfoList)
	FightController.instance:dispatchEvent(FightEvent.SetUseCards)
	FightViewPartVisible.set(false, false, false, false, true)
	self:onDone(true)
end

function FightWorkUseCards:_delayDone()
	self:onDone(true)
end

function FightWorkUseCards:clearWork()
	return
end

return FightWorkUseCards
