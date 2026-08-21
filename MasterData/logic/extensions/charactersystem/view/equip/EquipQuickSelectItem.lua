-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipQuickSelectItem.lua

module("logic.extensions.charactersystem.view.equip.EquipQuickSelectItem", package.seeall)

local M = class("EquipQuickSelectItem")

function M:ctor(compContainer)
	self.mainGo = compContainer.gameObject
end

function M:Awake()
	self._goSelect = goutil.findChild(self.mainGo, "select")
	self._txtName = goutil.findChildTextComponent(self.mainGo, "Label (1)")
	self._btn = Astral.ButtonAdapter.Get(self.mainGo)

	self._btn:AddClickListener(self._clickBtn, self)
end

function M:OnDestroy()
	self._btn:RemoveClickListener()
end

function M:_clickBtn()
	self._isSelect = not self._isSelect

	goutil.setActive(self._goSelect, self._isSelect)
	GlobalDispatcher:dispatchEvent(EventType.EQUIP_QUICK_SELECT_CLICK, self._quality, self._isSelect)
end

function M:setData(quality, name)
	self._quality = quality
	self._txtName.text = name
end

function M:setStatus(isSelect)
	self._isSelect = isSelect

	goutil.setActive(self._goSelect, isSelect)
end

return M
