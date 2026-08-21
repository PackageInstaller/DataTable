-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/filterview/EquipDiceFilterItem.lua

module("logic.extensions.backpack.view.filterview.EquipDiceFilterItem", package.seeall)

local M = class("EquipDiceFilterItem")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	self._btn = Astral.ButtonAdapter.Get(self.mainGO)
	self._txtDice = goutil.findChildComponent(self.mainGO, "normal/Text", UIComponentType.TMPText)
	self._goSelect = goutil.findChild(self.mainGO, "select")

	local go = goutil.findChild(self.mainGO, "normal/diceItem")

	self._diceIconItem = Astral.LuaComponentContainer.Add(go, EquipDiceIconSimplifyItem)

	self._diceIconItem:setActive(true)
end

function M:destroyUI()
	self.mainGO = nil
	self._clickEvent = nil
end

function M:bindEvents()
	self._btn:AddClickListener(self._onClick, self)
end

function M:unbindEvents()
	self._btn:RemoveClickListener()
end

function M:_onClick()
	local add = not self._goSelect.activeSelf

	goutil.setActive(self._goSelect, add)

	if self._clickEvent then
		GlobalDispatcher:dispatchEvent(self._clickEvent, self._diceAttMo, add)
	end
end

function M:updateData(diceAttMo)
	self._diceAttMo = diceAttMo
	self._txtDice.text = self._diceAttMo:getFilterDesc()

	self._diceIconItem:updateIcon(self._diceAttMo)
end

function M:setSelect(isSelect)
	goutil.setActive(self._goSelect, isSelect)
end

function M:setClickEvent(evt)
	self._clickEvent = evt
end

return M
