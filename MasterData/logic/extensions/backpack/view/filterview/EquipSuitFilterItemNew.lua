-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/filterview/EquipSuitFilterItemNew.lua

module("logic.extensions.backpack.view.filterview.EquipSuitFilterItemNew", package.seeall)

local M = class("EquipSuitFilterItemNew")

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
	self._text = goutil.findChildComponent(self.mainGO, "Label (1)", UIComponentType.Text)
	self._imgSelect = goutil.findChild(self.mainGO, "select")
end

function M:destroyUI()
	self.mainGO = nil
	self._clickEvent = nil
	self._isCanClick = false
end

function M:bindEvents()
	self._btn:AddClickListener(self._onClick, self)
end

function M:unbindEvents()
	self._btn:RemoveClickListener()
end

function M:_onClick()
	if self._clickEvent and self._isCanClick then
		GlobalDispatcher:dispatchEvent(self._clickEvent, self._suitMo)
	end
end

function M:updateData(suitMo)
	self._suitMo = suitMo
	self._isCanClick = suitMo:getIsOwner()

	local name = suitMo:getName()
	local color = self._isCanClick and "#F7F6F1" or "#454542"

	self._text.text = string.format("<color=%s>%s</color>", color, name)
end

function M:setSelect(isSelect)
	goutil.setActive(self._imgSelect, isSelect)
end

function M:setClickEvent(evt)
	self._clickEvent = evt
end

return M
