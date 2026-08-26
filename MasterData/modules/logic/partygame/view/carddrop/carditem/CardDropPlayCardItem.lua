-- chunkname: @modules/logic/partygame/view/carddrop/carditem/CardDropPlayCardItem.lua

module("modules.logic.partygame.view.carddrop.carditem.CardDropPlayCardItem", package.seeall)

local CardDropPlayCardItem = class("CardDropPlayCardItem", PartyGameCommonCard)

function CardDropPlayCardItem.getTargetX(side, index)
	local maxIndex = CardDropGameController.instance.maxSelectedCount

	if side == CardDropEnum.Side.My then
		return -CardDropEnum.HandCardWidth * (maxIndex - index)
	else
		return CardDropEnum.HandCardWidth * (maxIndex - index)
	end
end

function CardDropPlayCardItem.getFlyDelay(index)
	return CardDropEnum.StartFlyInterval * (index - 1)
end

function CardDropPlayCardItem:init(go, index, side)
	self.side = side

	CardDropPlayCardItem.super.init(self, go, index)
end

function CardDropPlayCardItem:onInitView()
	CardDropPlayCardItem.super.onInitView(self)

	local comp = self.viewGO:GetComponent(CardDropEnum.TypeLayout)

	if comp then
		comp:DestroyImmediate()
	end

	if self.side == CardDropEnum.Side.My then
		self.viewRectTr.pivot = CardDropEnum.HandCardPivot
		self.viewRectTr.anchorMin = CardDropEnum.HandCardAnchorMinMax
		self.viewRectTr.anchorMax = CardDropEnum.HandCardAnchorMinMax

		self:flyToTargetPosX()
	else
		self.viewRectTr.pivot = CardDropEnum.PlayCardPivot
		self.viewRectTr.anchorMin = CardDropEnum.PlayCardAnchorMinMax
		self.viewRectTr.anchorMax = CardDropEnum.PlayCardAnchorMinMax

		TaskDispatcher.runDelay(self.flyToTargetPosX, self, CardDropPlayCardItem.getFlyDelay(self.index))
	end

	transformhelper.setLocalScale(self.viewRectTr, CardDropEnum.HandCardScale, CardDropEnum.HandCardScale, CardDropEnum.HandCardScale)
	gohelper.setActive(self._goselectnum, true)
end

function CardDropPlayCardItem:flyToTargetPosX()
	self:clearFlyTween()

	local targetX = CardDropPlayCardItem.getTargetX(self.side, self.index)

	self.flyTweenId = ZProj.TweenHelper.DOAnchorPosX(self.viewRectTr, targetX, CardDropEnum.StartFlyDuration, nil, nil, nil, CardDropEnum.StartFlyEaseType)
end

function CardDropPlayCardItem:clearFlyTween()
	if self.flyTweenId then
		ZProj.TweenHelper.KillById(self.flyTweenId)

		self.flyTweenId = nil
	end
end

function CardDropPlayCardItem:updateId(id)
	CardDropPlayCardItem.super.updateId(self, id)

	self._txtselectnum.text = self.index
end

function CardDropPlayCardItem:onDestroy()
	self:clearFlyTween()
	CardDropPlayCardItem.super.onDestroy(self)
end

return CardDropPlayCardItem
