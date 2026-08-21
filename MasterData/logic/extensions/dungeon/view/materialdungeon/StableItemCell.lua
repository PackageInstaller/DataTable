-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/materialdungeon/StableItemCell.lua

module("logic.extensions.dungeon.view.materialdungeon.StableItemCell", package.seeall)

local M = class("StableItemCell", ItemCell)

function M:dealSelect()
	local normalComp = self:getComponent("normal")

	self:onSelect(not normalComp:getItemSelect())

	local cellRange = self._cellRange and self._cellRange or self._go
	local data = ToolTipsUtil.createItemTipsData(self._data, cellRange, self._showTipsPassEvent)

	data.viewName = ViewName.ToolTipsFixView
	data.bindGo = cellRange
	data.offsetY = -60

	ToolTipsMgr.showTips(ViewName.ToolTipsFixView, data)
end

function M:setCellRange(obj)
	self._cellRange = obj
end

return M
