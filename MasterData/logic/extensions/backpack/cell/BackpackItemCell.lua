-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cell/BackpackItemCell.lua

module("logic.extensions.backpack.cell.BackpackItemCell", package.seeall)

local M = class("BackpackItemCell", ListBinderCell)

function M:_initComponents()
	self:_addComponent("normal", ItemCellComponet)
	self:_addComponent("num", BackpackNumComponent)
	self:_addComponent("sign", BackpackSignComponent)
	self:_addComponent("notGetType", BackpackNotGetTypeComponent)
	self:_addComponent("usingType", BackpackUsingTypeComponent)
	self:_addComponent("breakpoint", BreakPointComponent)
	self:_addComponent("animation", BackpackAnimationComponent)
	self:_addComponent("CanvasGroup", BackpackCanvasGroupComponet)
	self:_addComponent("preset", PresetComponent)
	self:_addComponent("levelNum", LevelHideComponent)
	self:_addComponent("operate", BackpackOperateHideComponent)
	self:_addComponent("holeCount", HoleCountHideComponent)
	self:_addComponent("equip", BackpackEquipItemCellHideComponet)
	self:_addComponent("lock", LockHideComponent)
	self:_addComponent("discard", DiscardHideComponent)
end

function M:setSelectEvent(evt)
	self._evt = evt
end

function M:dealSelect()
	GlobalDispatcher:dispatchEvent(self._evt, self._data, self._go, self._cellIndex)
end

function M:onSelect(isSelected)
	local normalComp = self:getComponent("normal")

	normalComp:setItemSelect(isSelected)
end

function M:hideRed()
	local normalComp = self:getComponent("normal")

	normalComp:hideRed()
end

return M
