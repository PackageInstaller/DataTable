-- chunkname: @modules/logic/fight/view/cardeffect/FightCardLongPressEffect.lua

module("modules.logic.fight.view.cardeffect.FightCardLongPressEffect", package.seeall)

local FightCardLongPressEffect = class("FightCardLongPressEffect", BaseWork)

function FightCardLongPressEffect:ctor()
	return
end

function FightCardLongPressEffect:onStart(context)
	FightCardLongPressEffect.super.onStart(self, context)

	self._dragItem = context.handCardItemList[context.index]
	self._cardCount = context.cardCount

	gohelper.setAsLastSibling(self._dragItem.go)

	local dt = 0.033

	self._sequence = FlowSequence.New()

	self._sequence:addWork(TweenWork.New({
		from = 1,
		type = "DOTweenFloat",
		to = 0.9,
		t = dt * 3,
		frameCb = self._tweenFrameScale,
		cbObj = self
	}))
	self._sequence:addWork(TweenWork.New({
		from = 0.9,
		type = "DOTweenFloat",
		to = 1.2,
		t = dt * 4,
		frameCb = self._tweenFrameScale,
		cbObj = self
	}))
	self._sequence:registerDoneListener(self._onWorkDone, self)
	self._sequence:start()
end

function FightCardLongPressEffect:_tweenFrameScale(value)
	self._dragScale = value

	self:_updateDragHandCards()
end

function FightCardLongPressEffect:onStop()
	FightCardLongPressEffect.super.onStop(self)
	self._sequence:stop()
end

function FightCardLongPressEffect:_onWorkDone()
	self._sequence:unregisterDoneListener(self._onWorkDone, self)

	local cardItem = self.context.handCardItemList[self.context.index]

	if cardItem.cardInfoMO then
		if cardItem.cardInfoMO then
			FightController.instance:dispatchEvent(FightEvent.ShowCardSkillTips, cardItem.cardInfoMO, cardItem.cardInfoMO.uid, cardItem.cardInfoMO)
		end

		self:onDone(true)
	end
end

function FightCardLongPressEffect:_updateDragHandCards()
	local dragIndex = self.context.index
	local dragItem = self._dragItem
	local cardCount = self._cardCount
	local dragScale = self._dragScale
	local handCardItemList = self.context.handCardItemList
	local targetPosY = FightViewHandCard.HandCardHeight * (dragScale - 1) / 2

	recthelper.setAnchorY(dragItem.tr, targetPosY)
	transformhelper.setLocalScale(dragItem.tr, dragScale, dragScale, 1)

	for i = 1, cardCount do
		local item = handCardItemList[i]
		local curPosX = recthelper.getAnchorX(item.tr)
		local targetPosX = FightViewHandCard.calcCardPosXDraging(i, cardCount, dragIndex, dragScale)

		recthelper.setAnchorX(item.tr, targetPosX)
	end
end

return FightCardLongPressEffect
