-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/filterview/BackpackQuickSelectItem.lua

module("logic.extensions.backpack.view.filterview.BackpackQuickSelectItem", package.seeall)

local M = class("BackpackQuickSelectItem")
local ItemStatus = CommEnum.BackPackFilterItemStatus

function M:ctor(compContainer)
	self.mainGo = compContainer.gameObject
end

function M:Awake()
	self._goNormal = goutil.findChild(self.mainGo, "normal")
	self._goSelect = goutil.findChild(self.mainGo, "select")
	self._goDiscard = goutil.findChild(self.mainGo, "disable")
	self._txtNormal = goutil.findChildTextComponent(self._goNormal, "Label")
	self._txtSelect = goutil.findChildTextComponent(self._goSelect, "Label")
	self._txtDiscard = goutil.findChildTextComponent(self._goDiscard, "Label")
	self._btn = Astral.ButtonAdapter.Get(self.mainGo)

	self._btn:AddClickListener(function()
		GlobalDispatcher:dispatchEvent(EventType.BACKPACK_RECYCLE_QUICK_SELECT_ITEM_CLICK, self._selectType, self._status)
	end, self)
end

function M:OnDestroy()
	self._btn:RemoveClickListener()
end

function M:autoClick()
	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_RECYCLE_QUICK_SELECT_ITEM_CLICK, self._selectType, self._status)
end

function M:setData(seletType, str)
	self._selectType = seletType
	self._txtNormal.text = str
	self._txtSelect.text = str
	self._txtDiscard.text = str
end

function M:setStatus(status)
	self._status = status

	goutil.setActive(self._goNormal, status == ItemStatus.Normal)
	goutil.setActive(self._goSelect, status == ItemStatus.Select)
	goutil.setActive(self._goDiscard, status == ItemStatus.Disable)
end

function M:getStatus()
	return self._status
end

return M
