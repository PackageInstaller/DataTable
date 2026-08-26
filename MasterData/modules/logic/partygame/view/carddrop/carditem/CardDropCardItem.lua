-- chunkname: @modules/logic/partygame/view/carddrop/carditem/CardDropCardItem.lua

module("modules.logic.partygame.view.carddrop.carditem.CardDropCardItem", package.seeall)

local CardDropCardItem = class("CardDropCardItem", PartyGameCommonCard)

function CardDropCardItem.getTargetX(index)
	return -CardDropEnum.HandCardWidth * (index - 1)
end

function CardDropCardItem.getFlyDelay(index)
	return CardDropEnum.StartFlyInterval * (index - 1)
end

function CardDropCardItem:_editableInitView()
	CardDropCardItem.super._editableInitView(self)

	self.click = SLFramework.UGUI.UIClickListener.Get(self.viewGO)

	self.click:AddClickListener(self.onClick, self)

	self.longPress = SLFramework.UGUI.UILongPressListener.Get(self.viewGO)

	self.longPress:SetLongPressTime({
		0.5,
		99999
	})
	self.longPress:AddLongPressListener(self.onLongPress, self)

	local comp = self.viewGO:GetComponent(CardDropEnum.TypeLayout)

	if comp then
		comp:DestroyImmediate()
	end

	self.viewRectTr.pivot = CardDropEnum.HandCardPivot
	self.viewRectTr.anchorMin = CardDropEnum.HandCardAnchorMinMax
	self.viewRectTr.anchorMax = CardDropEnum.HandCardAnchorMinMax

	transformhelper.setLocalScale(self.viewRectTr, CardDropEnum.HandCardScale, CardDropEnum.HandCardScale, CardDropEnum.HandCardScale)
	self:directSetAnchorX(CardDropEnum.StartAnchorX)
	self.addEventCb(self, CardDropGameController.instance, CardDropGameEvent.OnSelectedCardChange, self.onSelectedCardChange, self)
	TaskDispatcher.runDelay(self.flyToTargetPosX, self, CardDropCardItem.getFlyDelay(self.index))
end

function CardDropCardItem:directSetAnchorX(anchorX)
	recthelper.setAnchorX(self.viewRectTr, anchorX)
end

function CardDropCardItem:flyToTargetPosX()
	self:clearFlyTween()

	local targetX = CardDropCardItem.getTargetX(self.index)

	self.flyTweenId = ZProj.TweenHelper.DOAnchorPosX(self.viewRectTr, targetX, CardDropEnum.StartFlyDuration, nil, nil, nil, CardDropEnum.StartFlyEaseType)
end

function CardDropCardItem:onSelectedCardChange()
	local selectIndex = CardDropGameController.instance:getIndexSelectedIndex(self.index)

	if selectIndex then
		gohelper.setActive(self._goselectframe, true)
		gohelper.setActive(self._goselectnum, true)

		self._txtselectnum.text = selectIndex

		self:tweenRootPosY(CardDropEnum.HandCardSelectedAnchorY, CardDropEnum.HandCardSelectDuration)
	else
		gohelper.setActive(self._goselectframe, false)
		gohelper.setActive(self._goselectnum, false)
		self:tweenRootPosY(0, CardDropEnum.HandCardSelectDuration)
	end
end

function CardDropCardItem:tweenRootPosY(targetPosY, duration)
	self:clearTween()

	self.tweenId = ZProj.TweenHelper.DOAnchorPosY(self.rootRectTr, targetPosY, duration, nil, nil, nil, EaseType.OutCubic)
end

function CardDropCardItem:clearTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function CardDropCardItem:clearFlyTween()
	if self.flyTweenId then
		ZProj.TweenHelper.KillById(self.flyTweenId)

		self.flyTweenId = nil
	end
end

function CardDropCardItem:onClick()
	if CardDropGameController.instance:isCommited() then
		return
	end

	AudioMgr.instance:trigger(340130)

	local selectIndex = CardDropGameController.instance:getIndexSelectedIndex(self.index)

	if selectIndex then
		CardDropGameController.instance:removeSelectedIndex(self.index)
	else
		CardDropGameController.instance:addSelectCount(self.index)
	end
end

local OpenParam = {
	offsetX = -20,
	offsetY = 80
}

function CardDropCardItem:onLongPress()
	if CardDropGameController.instance:isCommited() then
		return
	end

	OpenParam.cardId = self:getCardId()
	OpenParam.screenPos = recthelper.uiPosToScreenPos(self.viewRectTr)

	ViewMgr.instance:openView(ViewName.CardDropCardTipView, OpenParam)
end

function CardDropCardItem:onDestroy()
	self:clearTween()
	self:clearFlyTween()

	if self.longPress then
		self.longPress:RemoveLongPressListener()

		self.longPress = nil
	end

	if self.click then
		self.click:RemoveClickListener()

		self.click = nil
	end

	CardDropCardItem.super.onDestroy(self)
end

return CardDropCardItem
