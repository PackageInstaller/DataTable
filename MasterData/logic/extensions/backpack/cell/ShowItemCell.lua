-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cell/ShowItemCell.lua

module("logic.extensions.backpack.cell.ShowItemCell", package.seeall)

local M = class("ShowItemCell", ListBinderCell)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)
end

function M:_initComponents()
	self:_addComponent("normal", ItemCellComponet)
end

function M:dealSelect()
	return
end

return M
