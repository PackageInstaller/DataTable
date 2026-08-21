-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/FilterTipsItem.lua

module("logic.extensions.common.view.FilterTipsItem", package.seeall)

local M = class("FilterTipsItem")

function M:ctor(compContainer)
	self._mainGO = compContainer.gameObject

	self:_buildUI()
end

function M:OnDestroy()
	self:unbindEvents()
end

function M:_buildUI()
	self._btnSelf = UIComponentType.ButtonAdapter(self._mainGO)
	self._toggle = self._mainGO:GetComponent(UIComponentType.SpaceXToggle)
	self._normalGO = goutil.findChild(self._mainGO, "normal")
	self._txtNormal = goutil.findChildTextComponent(self._normalGO, "Text")
	self._selectGO = goutil.findChild(self._mainGO, "select")
	self._txtSelect = goutil.findChildTextComponent(self._selectGO, "Text")

	self:setToggleEnabled(false)
	self:bindEvents()
end

function M:bindEvents()
	self._btnSelf:AddClickListener(self._clickSelf, self)
end

function M:unbindEvents()
	self._btnSelf:RemoveClickListener()
end

function M:setListIndex(idx)
	self._listIndex = idx
end

function M:setFilterIndex(idx)
	self._filterIndex = idx
end

function M:setClickCallback(callback, target)
	self._clickCallback = callback
	self._clickTarget = target
end

function M:setToggleEnabled(enabled)
	self._toggle.enabled = enabled
end

function M:setName(nameStr)
	self._txtNormal.text = nameStr
	self._txtSelect.text = nameStr
end

function M:setSelected(selected)
	goutil.setActive(self._normalGO, not selected)
	goutil.setActive(self._selectGO, selected)
end

function M:_clickSelf()
	if self._clickCallback then
		self._clickCallback(self._clickTarget, self._listIndex, self._filterIndex)
	end
end

return M
