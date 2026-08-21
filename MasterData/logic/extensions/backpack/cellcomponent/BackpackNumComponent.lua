-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/BackpackNumComponent.lua

module("logic.extensions.backpack.cellcomponent.BackpackNumComponent", package.seeall)

local M = class("BackpackNumComponent", CellBaseComponent)

function M:ctor(cell)
	M.super.ctor(self, cell)

	self._numText = nil
	self._numCostText = nil
	self._visible = false
end

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()

	self._numBgNode = registry:findUIElement("backpack_item_-2077706482")
	self._numText = registry:findUIElement("backpack_item_977509436", UIComponentType.Text)
	self._numCostText = registry:findUIElement("backpack_item_372005575", UIComponentType.Text)

	self:setVisible(true)
end

local noShowItemTypeList = {
	GameEnum.ItemTypeEnum.EchoItemType,
	GameEnum.ItemTypeEnum.HeroType,
	GameEnum.ItemTypeEnum.HeroSkin,
	GameEnum.ItemTypeEnum.ProtomerItemType,
	GameEnum.ItemTypeEnum.DisplayCard,
	GameEnum.ItemTypeEnum.Portrait,
	GameEnum.ItemTypeEnum.DiceItem,
	GameEnum.ItemTypeEnum.EquipItemType
}

function M:updateData(itemData)
	self._num = itemData:getCount()

	if table.indexof(noShowItemTypeList, itemData:getType()) then
		self:setVisible(false)
	else
		self:setVisible(true)
		self:setCountText(self._num)
	end
end

function M:setCountText(text)
	if self._visible then
		text = ItemUtil.formatItemCount(text)
		self._numText.text = text
	end
end

function M:setCostText(text)
	if self._visible then
		text = ItemUtil.formatItemCount(text)
		self._numCostText.text = text
	end
end

function M:setCountTextActive(visible)
	goutil.setActive(self._numText.gameObject, visible)
end

function M:setCostTextActive(visible)
	goutil.setActive(self._numCostText.gameObject, visible)
end

function M:isVisible()
	return self._visible
end

function M:setVisible(visible)
	self._visible = visible

	goutil.setActive(self._numBgNode, visible)
	goutil.setActive(self._numText.gameObject, visible)

	local normalComp = self._cell:getComponent("normal")

	normalComp:adjustClickArea()
end

function M:setNumBgNodeVisible(visible)
	goutil.setActive(self._numBgNode, visible)
end

function M:setNumVisibleInGainItem()
	local visible = self._num and self._num > 1

	goutil.setActive(self._numBgNode, visible)
	goutil.setActive(self._numText.gameObject, visible)
end

function M:setTextColor(color)
	self._numText.color = color
	self._numCostText.color = color
end

return M
