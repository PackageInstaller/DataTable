-- chunkname: @modules/logic/playercard/view/comp/PlayerCardLayoutItem.lua

module("modules.logic.playercard.view.comp.PlayerCardLayoutItem", package.seeall)

local PlayerCardLayoutItem = class("PlayerCardLayoutItem", LuaCompBase)

PlayerCardLayoutItem.TweenDuration = 0.16

function PlayerCardLayoutItem:ctor(param)
	self._param = param
	self.viewRoot = param.viewRoot.transform
	self.layout = param.layout
	self.cardComp = param.cardComp
end

function PlayerCardLayoutItem:init(go)
	self.go = go
	self.transform = go.transform
	self.goPut = gohelper.findChild(go, "card/put")
	self.frame = gohelper.findChild(go, "frame")
	self.goCard = gohelper.findChild(go, "card")
	self.animCard = self.goCard:GetComponent(typeof(UnityEngine.Animator))
	self.trsCard = self.goCard.transform
	self.goSelect = gohelper.findChild(go, "card/select")
	self.goTop = gohelper.findChild(go, "card/top")
	self.trsTop = self.goTop.transform
	self.goDown = gohelper.findChild(go, "card/down")
	self.trsDown = self.goDown.transform
	self.canvasGroup = gohelper.onceAddComponent(self.goCard, gohelper.Type_CanvasGroup)
	self.goBlack = gohelper.findChild(go, "card/blackmask")
	self.goDrag = gohelper.findChild(go, "card/drag")

	self:AddDrag(self.goDrag)
	gohelper.setActive(self.frame, false)
	gohelper.setActive(self.goSelect, false)
end

function PlayerCardLayoutItem:getCenterScreenPosY()
	local x, y = recthelper.uiPosToScreenPos2(self.trsCard)

	return y
end

function PlayerCardLayoutItem:isInArea(y)
	local _, y1 = recthelper.uiPosToScreenPos2(self.trsTop)
	local _, y2 = recthelper.uiPosToScreenPos2(self.trsDown)

	return y <= y1 and y2 <= y
end

function PlayerCardLayoutItem:getLayoutGO()
	return self.go
end

function PlayerCardLayoutItem:addEventListeners()
	return
end

function PlayerCardLayoutItem:removeEventListeners()
	return
end

function PlayerCardLayoutItem:getLayoutKey()
	return self._param.layoutKey
end

function PlayerCardLayoutItem:setLayoutIndex(index)
	self.index = index
end

function PlayerCardLayoutItem:exchangeIndex(item)
	item.index = self.index
	self.index = item.index
end

function PlayerCardLayoutItem:setEditMode(isEdit)
	gohelper.setActive(self.frame, isEdit)
	gohelper.setActive(self.goSelect, isEdit)

	if isEdit then
		self.animCard:Play("wiggle")
	end
end

function PlayerCardLayoutItem:AddDrag(go)
	if self._drag or gohelper.isNil(go) then
		return
	end

	self._drag = SLFramework.UGUI.UIDragListener.Get(go)

	self._drag:AddDragBeginListener(self._onBeginDrag, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddDragEndListener(self._onEndDrag, self)
end

function PlayerCardLayoutItem:canDrag()
	return true
end

function PlayerCardLayoutItem:_onBeginDrag(dragTransform, pointerEventData)
	if not self:canDrag() then
		self.inDrag = false

		return
	end

	if self.inDrag then
		return
	end

	gohelper.addChildPosStay(self.viewRoot, self.goCard)
	gohelper.setAsLastSibling(self.goCard)
	gohelper.setAsLastSibling(self.go)
	self:killTweenId()

	local anchorPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.viewRoot)

	self:_tweenToPos(self.trsCard, anchorPos)

	self.inDrag = true

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)

	if self.layout then
		self.layout:startUpdate(self)
	end
end

function PlayerCardLayoutItem:_onDrag(dragTransform, pointerEventData)
	if not self:canDrag() then
		self.inDrag = false

		return
	end

	if not self.inDrag then
		return
	end

	local anchorPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.viewRoot)

	self:_tweenToPos(self.trsCard, anchorPos)

	self.inDrag = true
end

function PlayerCardLayoutItem:_onEndDrag(dragTransform, pointerEventData)
	if not self.inDrag then
		return
	end

	self.inDrag = false

	local anchorPos = recthelper.rectToRelativeAnchorPos(self.frame.transform.position, self.viewRoot)

	UIBlockMgr.instance:startBlock("PlayerCardLayoutItem")
	self._tweenToPos(self, self.trsCard, anchorPos, self.onEndDragTweenCallback, self)

	if self.layout then
		self.layout:closeUpdate()
	end
end

function PlayerCardLayoutItem:onEndDragTweenCallback()
	UIBlockMgr.instance:endBlock("PlayerCardLayoutItem")
	gohelper.addChildPosStay(self.go, self.goCard)
	gohelper.setAsLastSibling(self.goCard)
	gohelper.setActive(self.goPut, false)
	gohelper.setActive(self.goPut, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_success)
end

function PlayerCardLayoutItem:_tweenToPos(transform, anchorPos, callback, callbackObj)
	self:killTweenId()

	local curAnchorX, curAnchorY = recthelper.getAnchor(transform)

	if math.abs(curAnchorX - anchorPos.x) > 10 or math.abs(curAnchorY - anchorPos.y) > 10 then
		self.posTweenId = ZProj.TweenHelper.DOAnchorPos(transform, anchorPos.x, anchorPos.y, PlayerCardLayoutItem.TweenDuration, callback, callbackObj)
	else
		recthelper.setAnchor(transform, anchorPos.x, anchorPos.y)

		if callback then
			callback(callbackObj)
		end
	end
end

function PlayerCardLayoutItem:killTweenId()
	if self.posTweenId then
		ZProj.TweenHelper.KillById(self.posTweenId)

		self.posTweenId = nil
	end
end

function PlayerCardLayoutItem:updateAlpha(alpha)
	self.canvasGroup.alpha = alpha
end

function PlayerCardLayoutItem:getHeight()
	if self.cardComp and self.cardComp.getLayoutHeight then
		return self.cardComp:getLayoutHeight()
	else
		return recthelper.getHeight(self.go.transform)
	end
end

function PlayerCardLayoutItem:onStartDrag()
	self:updateAlpha(self.inDrag and 1 or 0.6)

	if self.inDrag then
		self.animCard:Play("idle")
	end

	gohelper.setActive(self.goBlack, not self.inDrag)
end

function PlayerCardLayoutItem:onEndDrag()
	self:updateAlpha(1)
	self.animCard:Play("wiggle")
	gohelper.setActive(self.goBlack, false)
end

function PlayerCardLayoutItem:onDestroy()
	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()
	end

	self:killTweenId()
	UIBlockMgr.instance:endBlock("PlayerCardLayoutItem")
end

return PlayerCardLayoutItem
