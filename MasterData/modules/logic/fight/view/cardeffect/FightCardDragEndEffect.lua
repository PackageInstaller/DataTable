-- chunkname: @modules/logic/fight/view/cardeffect/FightCardDragEndEffect.lua

module("modules.logic.fight.view.cardeffect.FightCardDragEndEffect", package.seeall)

local FightCardDragEndEffect = class("FightCardDragEndEffect", BaseWork)
local TimeFactor = 1
local dt = TimeFactor * 0.033

function FightCardDragEndEffect:ctor()
	return
end

function FightCardDragEndEffect:onStart(context)
	FightCardDragEndEffect.super.onStart(self, context)

	self._dt = dt / FightModel.instance:getUISpeed()
	self._dragItem = context.handCardItemList[context.index]
	self._cardCount = context.cardCount
	self._handCardTr = context.handCardTr
	self._targetIndex = context.targetIndex

	local curScale, _, _ = transformhelper.getLocalScale(self._dragItem.tr)

	self._tweenWork = TweenWork.New({
		type = "DOTweenFloat",
		to = 1,
		from = curScale,
		t = self._dt * 4,
		frameCb = self._tweenFrameScale,
		cbObj = self
	})

	self._tweenWork:registerDoneListener(self._onWorkDone, self)
	self._tweenWork:onStart()
end

function FightCardDragEndEffect:_tweenFrameScale(value)
	self._dragScale = value

	self:_updateDragHandCards()
end

function FightCardDragEndEffect:_onWorkDone()
	local itemList = self.context.handCardItemList
	local handCards = self.context.handCards
	local dragIndex = self.context.index
	local targetIndex = self.context.targetIndex
	local cardCount = self.context.cardCount

	FightCardDragEffect.setCardsUniversalMatch(itemList, handCards, dragIndex, targetIndex, cardCount, false)
	self:onDone(true)
end

function FightCardDragEndEffect:_updateDragHandCards()
	local dragIndex = self.context.index
	local dragItem = self._dragItem
	local cardCount = self._cardCount
	local dragScale = self._dragScale
	local handCardItemList = self.context.handCardItemList
	local targetPosY = FightViewHandCard.HandCardHeight * (dragScale - 1) / 2

	recthelper.setAnchorY(dragItem.tr, targetPosY)
	transformhelper.setLocalScale(dragItem.tr, dragScale, dragScale, 1)

	for i = 1, cardCount do
		local toIndex = i

		if i ~= dragIndex then
			if dragIndex < i and i <= self._targetIndex then
				toIndex = i - 1
			elseif i < dragIndex and i >= self._targetIndex then
				toIndex = i + 1
			end
		else
			toIndex = self._targetIndex
		end

		local item = handCardItemList[i]

		if item then
			local curPosX = recthelper.getAnchorX(item.tr)
			local targetPosX = FightViewHandCard.calcCardPosXDraging(toIndex, cardCount, self._targetIndex, dragScale)

			recthelper.setAnchorX(item.tr, targetPosX)
		end
	end
end

function FightCardDragEndEffect:clearWork()
	if self._tweenWork then
		self._tweenWork:onStop()
		self._tweenWork:unregisterDoneListener(self._onWorkDone, self)

		self._tweenWork = nil
	end
end

return FightCardDragEndEffect
