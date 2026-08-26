-- chunkname: @modules/logic/fight/view/cardeffect/FightCardDissolveCardsAfterPlay.lua

module("modules.logic.fight.view.cardeffect.FightCardDissolveCardsAfterPlay", package.seeall)

local FightCardDissolveCardsAfterPlay = class("FightCardDissolveCardsAfterPlay", BaseWork)

function FightCardDissolveCardsAfterPlay:onStart(context)
	FightController.instance:dispatchEvent(FightEvent.SetBlockCardOperate, true)

	local removeIndexes = context.dissolveCardIndexsAfterPlay

	if removeIndexes and #removeIndexes > 0 then
		TaskDispatcher.runDelay(self._delayDone, self, 10)
		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, self._onCombineDone, self)

		local cards = self.context.beforeDissolveCards
		local delayTime = FightCardDataHelper.calcRemoveCardTime2(cards, removeIndexes)

		for i, v in ipairs(removeIndexes) do
			FightController.instance:dispatchEvent(FightEvent.CardRemove, {
				v
			}, delayTime, true)
		end

		return
	end

	self:onDone(true)
end

function FightCardDissolveCardsAfterPlay:_onCombineDone()
	self:onDone(true)
end

function FightCardDissolveCardsAfterPlay:_delayDone()
	self:onDone(true)
end

function FightCardDissolveCardsAfterPlay:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, self._onCombineDone, self)
end

return FightCardDissolveCardsAfterPlay
