-- chunkname: @modules/logic/rouge/view/RougeFactionItem.lua

module("modules.logic.rouge.view.RougeFactionItem", package.seeall)

local RougeFactionItem = class("RougeFactionItem", RougeSimpleItemBase)
local csAnimatorPlayer = SLFramework.AnimatorPlayer

function RougeFactionItem:ctor(ctorParam)
	RougeSimpleItemBase.ctor(self, ctorParam)

	self._staticData.parentScrollViewGo = ctorParam.baseViewContainer:getScrollViewGo()
	self._staticData.startViewAllInfo = RougeController.instance:getStartViewAllInfo()
	self._selected = RougeFactionItemSelected.New(self)
	self._unSelected = RougeFactionItemUnselected.New(self)
	self._locked = RougeFactionItemLocked.New(self)
end

function RougeFactionItem:_editableInitView()
	RougeSimpleItemBase._editableInitView(self)

	self._animatorPlayer = csAnimatorPlayer.Get(self.viewGO)
	self._animSelf = self._animatorPlayer.animator

	self._selected:init(gohelper.findChild(self.viewGO, "Select"))
	self._unSelected:init(gohelper.findChild(self.viewGO, "Unselect"))
	self._locked:init(gohelper.findChild(self.viewGO, "Locked"))
	self._selected:setActive(false)
	self._unSelected:setActive(false)
	self._locked:setActive(false)
end

function RougeFactionItem:onDestroyView()
	RougeSimpleItemBase.onDestroyView(self)
	GameUtil.onDestroyViewMember(self, "_selected")
	GameUtil.onDestroyViewMember(self, "_unSelected")
	GameUtil.onDestroyViewMember(self, "_locked")
end

function RougeFactionItem:setSelected(isSelect)
	if not self:isUnLocked() then
		return
	end

	RougeSimpleItemBase.setSelected(self, isSelect)
end

function RougeFactionItem:onSelect(isSelected)
	self._staticData.isSelected = isSelected

	self._selected:setActive(isSelected)
	self._unSelected:setActive(not isSelected)
end

function RougeFactionItem:setData(mo)
	self._mo = mo
	self._isUnLocked = mo.isUnLocked

	self._selected:setData(mo)
	self._unSelected:setData(mo)
	self._locked:setData(mo)

	local isSelected = self:isSelected()

	if self:isUnLocked() then
		self._selected:setActive(isSelected)
		self._unSelected:setActive(not isSelected)
		self._locked:setActive(false)
	else
		self._locked:setActive(true)
	end
end

function RougeFactionItem:isUnLocked()
	return self._mo.isUnLocked
end

function RougeFactionItem:style()
	local CO = self._mo.styleCO

	return CO.id
end

function RougeFactionItem:difficulty()
	local p = self:parent()

	return p:_difficulty()
end

function RougeFactionItem:setIsLocked(isLock, ignorePlayIdleAnim)
	self._locked:setActive(isLock)

	if not ignorePlayIdleAnim then
		self:playIdle()
		self:onSelect(self._staticData.isSelected)
	end
end

function RougeFactionItem:playOpen(isNewUnlock)
	if isNewUnlock == true then
		self._isNewUnlockAnim = true

		self:setIsLocked(true, true)
	end

	self._playAnim(self, UIAnimationName.Open, self._onOpenEnd, self)
end

function RougeFactionItem:playIdle()
	self._animSelf.enabled = true

	self._animSelf:Play(UIAnimationName.Open, 0, 1)
end

function RougeFactionItem:playClose()
	self._playAnim(self, UIAnimationName.Close, self._onCloseEnd, self)
end

function RougeFactionItem:setOnOpenEndCb(cb)
	self._onOpenEndCb = cb
end

function RougeFactionItem:_onOpenEnd()
	if self._onOpenEndCb then
		self._onOpenEndCb()

		self._onOpenEndCb = nil
	end

	if self._isNewUnlockAnim then
		self._playAnim(self, UIAnimationName.Unlock, self._onUnlockEnd, self)

		self._isNewUnlockAnim = nil
	end
end

function RougeFactionItem:setOnCloseEndCb(cb)
	self._onCloseEndCb = cb
end

function RougeFactionItem:_onCloseEnd()
	if self._onCloseEndCb then
		self._onCloseEndCb()

		self._onCloseEndCb = nil
	end
end

function RougeFactionItem:setOnUnlockEndCb(cb)
	self._onUnlockEndCb = cb
end

function RougeFactionItem:_onUnlockEnd()
	if self._onUnlockEndCb then
		self._onUnlockEndCb()

		self._onUnlockEndCb = nil
	end

	self:setIsLocked(false)
	self:onSelect(self._staticData.isSelected)
end

function RougeFactionItem:_playAnim(name, cb, cbObj)
	self._animatorPlayer:Play(name, cb, cbObj)
end

return RougeFactionItem
