-- chunkname: @modules/logic/rouge/view/RougeDifficultyItem.lua

module("modules.logic.rouge.view.RougeDifficultyItem", package.seeall)

local RougeDifficultyItem = class("RougeDifficultyItem", RougeSimpleItemBase)
local csTweenHelper = ZProj.TweenHelper
local csAnimatorPlayer = SLFramework.AnimatorPlayer

RougeDifficultyItem.ScalerSelected = 1
RougeDifficultyItem.ScalerSelectedAdjacent = 0.9
RougeDifficultyItem.ScalerNormal = 0.85

function RougeDifficultyItem:ctor(ctorParam)
	RougeSimpleItemBase.ctor(self, ctorParam)

	self._staticData.parentScrollViewGo = ctorParam.baseViewContainer:getScrollViewGo()
	self._staticData.geniusBranchStartViewInfo = RougeOutsideModel.instance:getGeniusBranchStartViewAllInfo()
	self._selected = RougeDifficultyItemSelected.New(self)
	self._unSelected = RougeDifficultyItemUnselected.New(self)
	self._locked = RougeDifficultyItemLocked.New(self)
end

function RougeDifficultyItem:_editableInitView()
	RougeSimpleItemBase._editableInitView(self)

	self._animatorPlayer = csAnimatorPlayer.Get(self.viewGO)
	self._animSelf = self._animatorPlayer.animator
	self._root = gohelper.findChild(self.viewGO, "Root")
	self._rootTrans = self._root.transform

	self._selected:init(gohelper.findChild(self._root, "Select"))
	self._unSelected:init(gohelper.findChild(self._root, "Unselect"))
	self._locked:init(gohelper.findChild(self._root, "Locked"))

	self._itemClick = gohelper.getClickWithAudio(self._gobg)

	self:setScale(RougeDifficultyItem.ScalerSelectedAdjacent)
	self._selected:setActive(false)
	self._unSelected:setActive(false)
	self._locked:setActive(false)
end

function RougeDifficultyItem:onDestroyView()
	RougeSimpleItemBase.onDestroyView(self)
	self:_killTween()
	GameUtil.onDestroyViewMember(self, "_selected")
	GameUtil.onDestroyViewMember(self, "_unSelected")
	GameUtil.onDestroyViewMember(self, "_locked")
end

function RougeDifficultyItem:setSelected(isSelect)
	if not self:isUnLocked() then
		return
	end

	RougeSimpleItemBase.setSelected(self, isSelect)
end

function RougeDifficultyItem:onSelect(isSelected)
	self._staticData.isSelected = isSelected

	self._selected:setActive(isSelected)
	self._unSelected:setActive(not isSelected)
end

function RougeDifficultyItem:setData(mo)
	self._mo = mo
	self._isUnLocked = mo.isUnLocked

	self._selected:setData(mo)
	self._unSelected:setData(mo)
	self._locked:setData(mo)

	local isSelected = self:isSelected()

	if self:isUnLocked() then
		self._selected:setActive(isSelected)
		self._unSelected:setActive(not isSelected)
	else
		self._locked:setActive(true)
	end
end

function RougeDifficultyItem:isUnLocked()
	return self._mo.isUnLocked
end

function RougeDifficultyItem:setScale(s, isAnim)
	if isAnim then
		self:tweenScale(s)
	else
		transformhelper.setLocalScale(self._rootTrans, s, s, s)
	end
end

function RougeDifficultyItem:setScale01(s)
	s = s or 1
	s = GameUtil.remap(s, 0, 1, RougeDifficultyItem.ScalerSelectedAdjacent, RougeDifficultyItem.ScalerSelected)

	self:setScale(s)
end

function RougeDifficultyItem:tweenScale(s, duration)
	duration = duration or 0.4

	self:_killTween()

	self._tweenRotationId = csTweenHelper.DOScale(self._rootTrans, s, s, s, duration, nil, nil, nil, EaseType.OutQuad)
end

function RougeDifficultyItem:_killTween()
	GameUtil.onDestroyViewMember_TweenId(self, "_tweenRotationId")
end

function RougeDifficultyItem:setIsLocked(isLock, ignorePlayIdleAnim)
	self._locked:setActive(isLock)

	if not ignorePlayIdleAnim then
		self:playIdle()
		self:onSelect(self._staticData.isSelected)
	end
end

function RougeDifficultyItem:playOpen(isNewUnlock)
	if isNewUnlock == true then
		self._isNewUnlockAnim = true

		self:setIsLocked(true, true)
	end

	self._playAnim(self, UIAnimationName.Open, self._onOpenEnd, self)
end

function RougeDifficultyItem:playIdle()
	self._animSelf.enabled = true

	self._animSelf:Play(UIAnimationName.Open, 0, 1)
end

function RougeDifficultyItem:playClose()
	self._playAnim(self, UIAnimationName.Close, self._onCloseEnd, self)
end

function RougeDifficultyItem:setOnOpenEndCb(cb)
	self._onOpenEndCb = cb
end

function RougeDifficultyItem:_onOpenEnd()
	if self._onOpenEndCb then
		self._onOpenEndCb()

		self._onOpenEndCb = nil
	end

	if self._isNewUnlockAnim then
		self._playAnim(self, UIAnimationName.Unlock, self._onUnlockEnd, self)

		self._isNewUnlockAnim = nil
	end
end

function RougeDifficultyItem:setOnCloseEndCb(cb)
	self._onCloseEndCb = cb
end

function RougeDifficultyItem:_onCloseEnd()
	if self._onCloseEndCb then
		self._onCloseEndCb()

		self._onCloseEndCb = nil
	end
end

function RougeDifficultyItem:setOnUnlockEndCb(cb)
	self._onUnlockEndCb = cb
end

function RougeDifficultyItem:_onUnlockEnd()
	if self._onUnlockEndCb then
		self._onUnlockEndCb()

		self._onUnlockEndCb = nil
	end

	self:setIsLocked(false)
	self:onSelect(self._staticData.isSelected)
end

function RougeDifficultyItem:_playAnim(name, cb, cbObj)
	self._animatorPlayer:Play(name, cb, cbObj)
end

return RougeDifficultyItem
