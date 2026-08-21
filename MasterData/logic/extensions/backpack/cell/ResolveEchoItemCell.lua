-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cell/ResolveEchoItemCell.lua

module("logic.extensions.backpack.cell.ResolveEchoItemCell", package.seeall)

local M = class("ResolveEchoItemCell", BackpackItemCell)

function M:_initComponents()
	self:_addComponent("normal", ItemCellComponet)
	self:_addComponent("echo", BackpackEchoItemCellComponet)
	self:_addComponent("breakpoint", BreakPointComponent)
end

function M:dealSelect()
	return
end

function M:onSelect(isSelected)
	return
end

function M:unSelect()
	return
end

return M
