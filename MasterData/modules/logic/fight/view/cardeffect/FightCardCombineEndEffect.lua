-- chunkname: @modules/logic/fight/view/cardeffect/FightCardCombineEndEffect.lua

module("modules.logic.fight.view.cardeffect.FightCardCombineEndEffect", package.seeall)

local FightCardCombineEndEffect = class("FightCardCombineEndEffect", BaseWork)

function FightCardCombineEndEffect:onStart(context)
	if context.preCombineIndex and context.newCardCount > 0 then
		local preCombineIndex = context.preCombineIndex
		local preCardCount = context.preCardCount
		local handCardItemList = context.handCardItemList
		local oldPosXList = context.oldPosXList

		for i = 1, preCardCount do
			recthelper.setAnchorX(handCardItemList[i].tr, oldPosXList[i])
		end

		self._flow = FightCardCombineEffect.buildCombineEndFlow(preCombineIndex, preCardCount, preCardCount, handCardItemList)

		self._flow:registerDoneListener(self._onMoveEnd, self)
		self._flow:start()
	else
		self:onDone(true)
	end
end

function FightCardCombineEndEffect:_onMoveEnd()
	self:onDone(true)
end

function FightCardCombineEndEffect:clearWork()
	if self._flow then
		self._flow:stop()
		self._flow:unregisterDoneListener(self._onBornEnd, self)
	end
end

return FightCardCombineEndEffect
