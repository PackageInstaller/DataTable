-- chunkname: @modules/logic/fight/view/cardeffect/FightCardCheckCombineCards.lua

module("modules.logic.fight.view.cardeffect.FightCardCheckCombineCards", package.seeall)

local FightCardCheckCombineCards = class("FightCardCheckCombineCards", BaseWork)

function FightCardCheckCombineCards:onStart(context)
	FightController.instance:dispatchEvent(FightEvent.SetBlockCardOperate, true)
	FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, self._onCombineDone, self)
	FightController.instance:dispatchEvent(FightEvent.PlayCombineCards, self.context.cards)
end

function FightCardCheckCombineCards:_onCombineDone()
	self:onDone(true)
end

function FightCardCheckCombineCards:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, self._onCombineDone, self)
	FightController.instance:unregisterCallback(FightEvent.PlayDiscardEffect, self._onPlayDiscardEffect, self)
end

return FightCardCheckCombineCards
