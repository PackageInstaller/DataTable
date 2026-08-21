-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cell/TreasureRewardItemCell.lua

module("logic.extensions.backpack.cell.TreasureRewardItemCell", package.seeall)

local M = class("TreasureRewardItemCell", ItemCell)

function M:_initComponents()
	M.super._initComponents(self)
	self:_addComponent("itemName", BackpackNameComponent)
end

function M:dealSelect()
	GlobalDispatcher:dispatchEvent(EventType.ITEM_TREASURE_CHOOSE, self._index)
end

function M:dealLongSelect()
	local data = ToolTipsUtil.createItemTipsData(ItemData.New({
		count = 0,
		itemId = self._data:getItemId()
	}), self._go)

	ToolTipsMgr.showTips(data.viewName, data)
end

function M:onSelect(isSelected)
	local normalComp = self:getComponent("normal")

	normalComp:setItemSelect(isSelected)
end

function M:dealLongSelectExit()
	return
end

function M:setNumVisible(visible)
	local numCom = self:getComponent("num")

	if numCom then
		numCom:setVisible(visible)
	end
end

function M:setItemName(text)
	local nameCom = self:getComponent("itemName")

	if nameCom then
		nameCom:setVisible(true)
		nameCom:setNameText(text)
	end
end

function M:setIndex(index)
	self._index = index
end

return M
