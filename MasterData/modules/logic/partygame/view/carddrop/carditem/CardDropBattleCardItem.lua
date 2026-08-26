-- chunkname: @modules/logic/partygame/view/carddrop/carditem/CardDropBattleCardItem.lua

module("modules.logic.partygame.view.carddrop.carditem.CardDropBattleCardItem", package.seeall)

local CardDropBattleCardItem = class("CardDropBattleCardItem", PartyGameCommonCard)

function CardDropBattleCardItem:init(go, side)
	self.side = side

	CardDropBattleCardItem.super.init(self, go)
end

function CardDropBattleCardItem:onInitView()
	CardDropBattleCardItem.super.onInitView(self)

	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self.viewParentRectTr = self.viewRectTr.parent

	local comp = self.viewGO:GetComponent(CardDropEnum.TypeLayout)

	if comp then
		comp:DestroyImmediate()
	end

	self.viewRectTr.anchorMin = CardDropEnum.BattleCardAnchorMinMax
	self.viewRectTr.anchorMax = CardDropEnum.BattleCardAnchorMinMax

	transformhelper.setLocalScale(self.viewRectTr, CardDropEnum.HandCardScale, CardDropEnum.HandCardScale, CardDropEnum.HandCardScale)
end

function CardDropBattleCardItem:setStartPos(rectTr)
	local screenPos = recthelper.uiPosToScreenPos(rectTr)
	local anchorX, anchorY = recthelper.screenPosToAnchorPos2(screenPos, self.viewParentRectTr)

	recthelper.setAnchor(self.viewRectTr, anchorX, anchorY)
end

function CardDropBattleCardItem:flyToTarget()
	self:clearTween()
	self:show()

	self.tweenId = ZProj.TweenHelper.DOAnchorPos(self.viewRectTr, self.targetAnchorX, self.targetAnchorY, CardDropEnum.FlyToBattleAreaDuration, self.onFlyDone, self, nil, CardDropEnum.FlyToBattleAreaEaseType)

	local targetScale = CardDropEnum.BattleCardScale

	self.scaleTweenId = ZProj.TweenHelper.DOScale(self.viewRectTr, targetScale, targetScale, targetScale, CardDropEnum.FlyToBattleAreaDuration, self.onScaleDone, self, nil, CardDropEnum.FlyToBattleAreaEaseType)
end

function CardDropBattleCardItem:onFlyDone()
	self.tweenId = nil
end

function CardDropBattleCardItem:onScaleDone()
	self.scaleTweenId = nil
end

function CardDropBattleCardItem:setTargetAnchor(rectTr)
	local screenPos = recthelper.uiPosToScreenPos(rectTr)
	local anchorX, anchorY = recthelper.screenPosToAnchorPos2(screenPos, self.viewParentRectTr)

	self.targetAnchorX = anchorX
	self.targetAnchorY = anchorY
end

function CardDropBattleCardItem:clearTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	if self.scaleTweenId then
		ZProj.TweenHelper.KillById(self.scaleTweenId)

		self.scaleTweenId = nil
	end
end

function CardDropBattleCardItem:playAnim(animName, callback, callbackObj)
	self.animatorPlayer:Play(animName, callback, callbackObj)
end

function CardDropBattleCardItem:onDestroy()
	self:clearTween()
	CardDropBattleCardItem.super.onDestroy(self)
end

return CardDropBattleCardItem
