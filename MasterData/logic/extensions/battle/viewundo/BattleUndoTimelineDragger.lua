-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewundo/BattleUndoTimelineDragger.lua

module("logic.extensions.battle.viewundo.BattleUndoTimelineDragger", package.seeall)

local BattleUndoTimelineDragger = class("BattleUndoTimelineDragger")

function BattleUndoTimelineDragger:ctor(mainGO)
	self.mainGO = mainGO

	self:buildUI()
	self:bindEvents()
end

function BattleUndoTimelineDragger:destroy()
	self:unbindEvents()
	self:destroyUI()
end

function BattleUndoTimelineDragger:buildUI()
	local goViewPort = goutil.findChild(self.mainGO, "viewPort")
	local goContent = goutil.findChild(self.mainGO, "viewPort/content")

	self._dragTrigger = Astral.UIDragTrigger.Get(goViewPort)
	self._goItemRoot = goutil.findChild(self.mainGO, "viewPort/content/headList")
	self._goAxisRoot = goutil.findChild(self.mainGO, "viewPort/content/axisList")
	self._canvasGroupItemRoot = goutil.addComponentOnce(self._goItemRoot, ComponentType.CanvasGroup)
	self._transContentContainer = goContent.transform
	self._transItemContainer = self._goItemRoot.transform
	self._halfViewPortWidth = RectTransformUtils.GetWidth(goViewPort.transform) * 0.5
	self._itemStateHandler = Handler.New()
	self._queryItemPositionHandler = Handler.New()
	self._checkIndexHandler = Handler.New()
	self._currentSelectedIndex = -1
	self._beginDragPos = false
end

function BattleUndoTimelineDragger:destroyUI()
	self._dragTrigger = false
	self._transContentContainer = false
	self._transItemContainer = false
	self._goItemRoot = false
	self._goAxisRoot = false
	self._canvasGroupItemRoot = false
	self._itemStateHandler = false
	self._queryItemPositionHandler = false
	self._checkIndexHandler = false
end

function BattleUndoTimelineDragger:bindEvents()
	self._dragTrigger:AddBeginDragListener(self._onBeginDragListener, self)
	self._dragTrigger:AddEndDragListener(self._onEndDragListener, self)
end

function BattleUndoTimelineDragger:unbindEvents()
	self._dragTrigger:RemoveBeginDragListener()
	self._dragTrigger:RemoveEndDragListener()
end

function BattleUndoTimelineDragger:clear()
	self._currentSelectedIndex = -1
end

function BattleUndoTimelineDragger:setAlpha(alpha)
	self._canvasGroupItemRoot.alpha = alpha
end

function BattleUndoTimelineDragger:setAxisRootVisible(visible)
	goutil.setActive(self._goAxisRoot, visible)
end

function BattleUndoTimelineDragger:getItemRoot()
	return self._goItemRoot
end

function BattleUndoTimelineDragger:getAxisRoot()
	return self._goAxisRoot
end

function BattleUndoTimelineDragger:setItemStateListener(callback, callbackSelf)
	self._itemStateHandler:setListener(callback, callbackSelf)
end

function BattleUndoTimelineDragger:setQueryItemPositionListener(callback, callbackSelf)
	self._queryItemPositionHandler:setListener(callback, callbackSelf)
end

function BattleUndoTimelineDragger:setCheckIndexListener(callback, callbackSelf)
	self._checkIndexHandler:setListener(callback, callbackSelf)
end

function BattleUndoTimelineDragger:getCurrentIndex()
	return self._currentSelectedIndex
end

function BattleUndoTimelineDragger:prepareForOpenAnimation(index)
	local itemX = self._queryItemPositionHandler:call(index)
	local toX = self._halfViewPortWidth - itemX + 300

	RectTransformUtils.SetAnchoredPosition(self._transContentContainer, toX, 0)
end

function BattleUndoTimelineDragger:selectIndex(index, immediately)
	if self._currentSelectedIndex == index then
		return
	end

	local itemX = self._queryItemPositionHandler:call(index)

	if not itemX then
		return
	end

	local lastIndex = self._currentSelectedIndex

	if lastIndex > 0 then
		self._itemStateHandler:call(lastIndex, false)
	end

	local duration = lastIndex - index > 3 and 0.65 or 0.5
	local toX = self._halfViewPortWidth - itemX

	self._currentSelectedIndex = index

	self._transContentContainer:DOKill(true)

	if immediately then
		RectTransformUtils.SetAnchoredPosition(self._transContentContainer, toX, 0)
	else
		self._transContentContainer:DOAnchorPosX(toX, duration):SetEase(DG.Tweening.Ease.OutCirc)
	end

	self._itemStateHandler:call(index, true)

	return true
end

function BattleUndoTimelineDragger:_onBeginDragListener(eventData)
	self._beginDragPos = eventData.position
end

local kPreIndexDistance = 200

function BattleUndoTimelineDragger:_onEndDragListener(eventData)
	local position = eventData.position
	local toIndex = self._currentSelectedIndex
	local deltaX = position.x - self._beginDragPos.x
	local deltaIndex = checkint(deltaX / kPreIndexDistance)

	toIndex = toIndex - deltaIndex
	toIndex = self._checkIndexHandler:call(toIndex)

	self:selectIndex(toIndex)
end

return BattleUndoTimelineDragger
