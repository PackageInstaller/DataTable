-- chunkname: @modules/logic/fight/view/cardeffect/FightCardDragEffect.lua

module("modules.logic.fight.view.cardeffect.FightCardDragEffect", package.seeall)

local FightCardDragEffect = class("FightCardDragEffect", BaseWork)
local LinkEffectPath = "ui/viewres/fight/ui_effect_dna_b.prefab"
local _linkEffectLoader, _linkEffectGO
local TimeFactor = 1
local dt = TimeFactor * 0.033

function FightCardDragEffect:onStart(context)
	FightCardDragEffect.super.onStart(self, context)

	self._dt = dt / FightModel.instance:getUISpeed()
	self._tweenIds = {}
	self._dragItem = context.handCardItemList[context.index]
	self._position = context.position
	self._cardCount = context.cardCount
	self._handCardTr = context.handCardTr
	self._handCards = context.handCards

	gohelper.setAsLastSibling(self._dragItem.go)

	local curScale, _, _ = transformhelper.getLocalScale(self._dragItem.tr)

	self._dragScale = curScale
	self._prevIndex = self.context.index
	self._after_drag_card_list = {}

	for i = 1, #self.context.handCardItemList do
		table.insert(self._after_drag_card_list, self.context.handCardItemList[i])
	end

	self._sequence = FlowSequence.New()

	local end_scale = 1.14
	local frame_num = 5

	self._sequence:addWork(FunctionWork.New(function()
		self:_playCardSpringEffect(self.context.index)
	end))
	self._sequence:addWork(TweenWork.New({
		type = "DOTweenFloat",
		from = curScale,
		to = end_scale,
		t = self._dt * frame_num,
		frameCb = self._tweenFrameScale,
		cbObj = self
	}))
	self._sequence:registerDoneListener(self._onWorkDone, self)
	self._sequence:start()
	FightController.instance:registerCallback(FightEvent.DragHandCard, self._onDragHandCard, self)
	FightController.instance:registerCallback(FightEvent.CardLongPressEffectEnd, self._onCardLongPressEffectEnd, self)
end

function FightCardDragEffect:_onCardLongPressEffectEnd()
	gohelper.setAsLastSibling(self._dragItem.go)
end

function FightCardDragEffect:_tweenFrameScale(value)
	self._dragScale = value

	transformhelper.setLocalScale(self._dragItem.tr, self._dragScale, self._dragScale, 1)

	local targetPosY = FightViewHandCard.HandCardHeight * (self._dragScale - 1) / 2

	recthelper.setAnchorY(self._dragItem.tr, targetPosY)
end

function FightCardDragEffect:_playCardSpringEffect(targetIndex)
	self:_killAllPosTween()

	for i = 1, self._cardCount do
		if i ~= targetIndex then
			local item = self._after_drag_card_list[i]
			local offset_num = 0

			if math.abs(i - targetIndex) == 1 then
				offset_num = i < targetIndex and 8 or -8
			end

			local tweenId = ZProj.TweenHelper.DOAnchorPosX(item.tr, FightViewHandCard.calcCardPosX(i) + offset_num, 5 * self._dt, function()
				self:_setCardsUniversalMatch(targetIndex)
			end)

			table.insert(self._tweenIds, tweenId)
		end
	end
end

function FightCardDragEffect:onStop()
	FightCardDragEffect.super.onStop(self)
	self._sequence:unregisterDoneListener(self._onWorkDone, self)

	if self._sequence.status == WorkStatus.Running then
		self._sequence:stop()
	end
end

function FightCardDragEffect:clearWork()
	FightController.instance:unregisterCallback(FightEvent.DragHandCard, self._onDragHandCard, self)
	FightController.instance:unregisterCallback(FightEvent.CardLongPressEffectEnd, self._onCardLongPressEffectEnd, self)
	self:_killAllPosTween()
	self:_killDragTween()

	if _linkEffectLoader then
		_linkEffectLoader:dispose()
	end

	_linkEffectLoader = nil
	_linkEffectGO = nil
	self._after_drag_card_list = {}
end

function FightCardDragEffect:_killDragTween()
	if self._drag_tween then
		ZProj.TweenHelper.KillById(self._drag_tween)

		self._drag_tween = nil
	end
end

function FightCardDragEffect:_killAllPosTween()
	if self._tweenIds then
		for _, tweenId in ipairs(self._tweenIds) do
			ZProj.TweenHelper.KillById(tweenId)
		end
	end

	self._tweenIds = {}
end

function FightCardDragEffect:_onWorkDone()
	self._sequence:unregisterDoneListener(self._onWorkDone, self)
end

function FightCardDragEffect:_onDragHandCard(index, position)
	self._position = position

	self:_updateDragHandCards()
end

function FightCardDragEffect:_updateDragHandCards()
	local dragItem = self._dragItem
	local cardCount = self._cardCount
	local dragScale = 1
	local anchorPos = recthelper.screenPosToAnchorPos(self._position, self._handCardTr)
	local totalWidth = FightViewHandCard.calcTotalWidth(cardCount, dragScale)
	local halfCardWidth = FightViewHandCard.HandCardWidth * 0.5
	local targetPosX = anchorPos.x - FightViewHandCard.HalfWidth

	targetPosX = Mathf.Clamp(targetPosX, -totalWidth + halfCardWidth, -halfCardWidth)

	self:_killDragTween()

	local curPosX = recthelper.getAnchorX(dragItem.tr)

	if math.abs(curPosX - targetPosX) > 20 then
		self._drag_tween = ZProj.TweenHelper.DOAnchorPosX(dragItem.tr, targetPosX, 6 * self._dt)
	else
		recthelper.setAnchorX(dragItem.tr, targetPosX)
	end

	local targetIndex = FightViewHandCard.calcCardIndexDraging(targetPosX, cardCount, dragScale)

	self:_setCardsUniversalMatch(targetIndex)

	if self._prevIndex and targetIndex ~= self._prevIndex then
		local now = Time.realtimeSinceStartup

		if not self._lastPlayTime or now > self._lastPlayTime + 0.25 then
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_FightMoveCard)

			self._lastPlayTime = now
		end

		local card_item = table.remove(self._after_drag_card_list, self._prevIndex)

		table.insert(self._after_drag_card_list, targetIndex, card_item)
		self:_playCardSpringEffect(targetIndex)
	end

	self._prevIndex = targetIndex
end

function FightCardDragEffect:_setCardsUniversalMatch(targetIndex)
	local dragIndex = self.context.index
	local handCardItemList = self.context.handCardItemList
	local cardCount = self._cardCount

	FightCardDragEffect.setCardsUniversalMatch(handCardItemList, self._handCards, dragIndex, targetIndex, cardCount, true)
end

function FightCardDragEffect.setCardsUniversalMatch(handCardItemList, handCards, dragIndex, targetIndex, cardCount, hasLinkEffect)
	local dragCardMO = handCards[dragIndex]

	if not dragCardMO then
		logError("dragCardMO = nil, dragIndex = " .. dragIndex .. ", handCardCount = " .. #handCards)
	end

	local dragCardItem = handCardItemList[dragIndex]
	local dragCardPosX = recthelper.getAnchorX(dragCardItem.tr)
	local isUniversalCard = FightEnum.UniversalCard[dragCardMO.skillId]
	local nearestCardOffset, nearestCardIndex

	for i = 1, cardCount do
		if i ~= dragIndex then
			local item = handCardItemList[i]

			if item then
				local curPosX = recthelper.getAnchorX(item.tr)
				local offset = dragCardPosX - curPosX

				if offset > 0 and (not nearestCardOffset or offset < nearestCardOffset) and offset < 2 * FightViewHandCard.HandCardWidth then
					nearestCardOffset = offset
					nearestCardIndex = i
				end
			end
		end
	end

	local linkHandCardItem

	for i = 1, cardCount do
		if i ~= dragIndex then
			local item = handCardItemList[i]

			if item then
				item:setUniversal(false)

				if isUniversalCard and i == nearestCardIndex and FightCardDataHelper.canCombineWithUniversalForPerformance(dragCardMO, handCards[i]) then
					item:setUniversal(true)

					linkHandCardItem = item
				end
			end
		end
	end

	if hasLinkEffect then
		FightCardDragEffect._setUniversalLinkEffect(dragCardItem, linkHandCardItem)
	end

	handCardItemList[dragIndex]:setUniversal(isUniversalCard)
end

function FightCardDragEffect._setUniversalLinkEffect(dragCardItem, handCardItem)
	if handCardItem then
		local dragCardPosX = recthelper.getAnchorX(dragCardItem.tr)
		local handCardPosX = recthelper.getAnchorX(handCardItem.tr)

		if dragCardPosX - handCardPosX > FightViewHandCard.HandCardWidth then
			if not _linkEffectLoader then
				_linkEffectGO = gohelper.create2d(handCardItem.go, "linkEffect")
				_linkEffectLoader = PrefabInstantiate.Create(_linkEffectGO)

				_linkEffectLoader:startLoad(LinkEffectPath)
			end

			gohelper.addChild(handCardItem.go, _linkEffectGO)
			recthelper.setAnchorX(_linkEffectGO.transform, 170)
		elseif _linkEffectGO then
			recthelper.setAnchorX(_linkEffectGO.transform, 10000)
		end
	elseif _linkEffectGO then
		recthelper.setAnchorX(_linkEffectGO.transform, 10000)
	end
end

return FightCardDragEffect
