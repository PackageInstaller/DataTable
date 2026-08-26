-- chunkname: @modules/logic/backpack/view/BackpackCategoryListItem.lua

module("modules.logic.backpack.view.BackpackCategoryListItem", package.seeall)

local BackpackCategoryListItem = class("BackpackCategoryListItem", ListScrollCell)

function BackpackCategoryListItem:init(go)
	self._bgs = self:getUserDataTb_()
	self._nameTxt = self:getUserDataTb_()
	self._subnameTxt = self:getUserDataTb_()

	for i = 1, 2 do
		self._bgs[i] = gohelper.findChild(go, "bg" .. tostring(i))
		self._nameTxt[i] = gohelper.findChildText(self._bgs[i], "#txt_itemcn" .. tostring(i))
		self._subnameTxt[i] = gohelper.findChildText(self._bgs[i], "#txt_itemen" .. tostring(i))
	end

	gohelper.setActive(self._bgs[2], false)

	self._btnCategory = SLFramework.UGUI.UIClickListener.Get(go)
	self._deadline1 = gohelper.findChild(go, "bg1/#txt_itemcn1/deadline1")
	self._deadlinebg = gohelper.findChildImage(go, "bg1/#txt_itemcn1/deadline1/deadlinebg")
	self._deadlineTxt1 = gohelper.findChildText(self._deadline1, "deadlinetxt")
	self._deadlineEffect = gohelper.findChild(self._deadline1, "#effect")
	self._deadlinetimeicon = gohelper.findChildImage(self._deadline1, "deadlinetxt/timeicon")
	self._format1 = gohelper.findChildText(self._deadline1, "deadlinetxt/format")
	self._lastIsDay = nil
end

function BackpackCategoryListItem:addEventListeners()
	self._btnCategory:AddClickListener(self._onItemClick, self)
	TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 1)
end

function BackpackCategoryListItem:removeEventListeners()
	self._btnCategory:RemoveClickListener()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self, 1)
end

function BackpackCategoryListItem:onUpdateMO(mo)
	self._mo = mo

	local target = self:_isSelected()

	gohelper.setActive(self._bgs[1], not target)
	gohelper.setActive(self._bgs[2], target)

	if target then
		self._nameTxt[2].text = mo.name
		self._subnameTxt[2].text = mo.subname
	else
		self._nameTxt[1].text = mo.name
		self._subnameTxt[1].text = mo.subname
	end

	self:_onRefreshDeadline()
end

function BackpackCategoryListItem:_onRefreshDeadline()
	if self:_isSelected() then
		return
	end

	local _deadlineGo, _deadlineTxt, _format, _hasday, _deadlinebg, _deadlinetimeicon, _deadlineEffect

	if self._mo.id == ItemEnum.CategoryType.Equip then
		gohelper.setActive(self._deadline1, false)

		return
	end

	_deadlineTxt = self._deadlineTxt1
	_format = self._format1
	_deadlinebg = self._deadlinebg
	_deadlinetimeicon = self._deadlinetimeicon
	_deadlineEffect = self._deadlineEffect

	local deadline = BackpackModel.instance:getCategoryItemsDeadline(self._mo.id)

	if deadline and deadline > 0 and self._mo.id ~= 0 then
		gohelper.setActive(self._deadline1, true)

		local limitSec = math.floor(deadline - ServerTime.now())

		if limitSec <= 0 then
			gohelper.setActive(self._deadline1, false)

			return
		end

		_deadlineTxt.text, _format.text, _hasday = TimeUtil.secondToRoughTime(limitSec, true)

		if self._lastIsDay == nil or self._lastIsDay ~= _hasday then
			UISpriteSetMgr.instance:setCommonSprite(_deadlinebg, _hasday and "daojishi_01" or "daojishi_02")
			UISpriteSetMgr.instance:setCommonSprite(_deadlinetimeicon, _hasday and "daojishiicon_01" or "daojishiicon_02")
			SLFramework.UGUI.GuiHelper.SetColor(_deadlineTxt, _hasday and "#98D687" or "#E99B56")
			SLFramework.UGUI.GuiHelper.SetColor(_format, _hasday and "#98D687" or "#E99B56")
			gohelper.setActive(_deadlineEffect, not _hasday)

			self._lastIsDay = _hasday
		end
	else
		gohelper.setActive(self._deadline1, false)
	end
end

function BackpackCategoryListItem:_isSelected()
	return self._mo.id == BackpackModel.instance:getCurCategoryId()
end

function BackpackCategoryListItem:_onItemClick()
	if self:_isSelected() then
		return
	end

	BackpackModel.instance:setItemAniHasShown(false)
	BackpackModel.instance:setCurCategoryId(self._mo.id)
	BackpackController.instance:dispatchEvent(BackpackEvent.SelectCategory)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
end

function BackpackCategoryListItem:onDestroy()
	self._lastIsDay = nil
end

return BackpackCategoryListItem
