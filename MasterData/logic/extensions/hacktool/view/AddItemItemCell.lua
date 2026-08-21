-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/AddItemItemCell.lua

module("logic.extensions.hacktool.view.AddItemItemCell", package.seeall)

local M = class("AddItemItemCell", ItemCell)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)

	self._isShowTips = false

	self:setShowSelectedEffect(false)
end

function M:_initComponents()
	self:_addComponent("normal", ItemCellComponet)
	self:_addComponent("name", BackpackNameComponent)
	self:_addComponent("num", BackpackNumComponent)
	self:_changePos()
end

function M:_changePos()
	self._go.transform.anchorMin = Vector2(0, 1)
	self._go.transform.anchorMax = Vector2(0, 1)
end

return M
