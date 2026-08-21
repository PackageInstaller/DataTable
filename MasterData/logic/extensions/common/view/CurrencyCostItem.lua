-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/CurrencyCostItem.lua

module("logic.extensions.common.view.CurrencyCostItem", package.seeall)

local M = class("CurrencyCostItem")

function M:ctor(compContainer)
	self._go = compContainer.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
	self._cacheItemData = {}
	self._itemData = nil
end

function M:Awake()
	self.go_com_price_item = self:findUIElement("com_price_item_783944688")
	self.btn_btnClick = self:findUIElement("com_price_item_53564095", UIComponentType.ButtonAdapter)
	self.img_icon = self:findUIElement("com_price_item_1371069005", UIComponentType.Image)
	self.text_txtPrice = self:findUIElement("com_price_item_128774533", UIComponentType.Text)

	self.btn_btnClick:AddClickListener(self._onClickTips, self)
end

function M:updateData(moneyCode, costCount)
	if not moneyCode then
		return
	end

	MoneyUtil.setMoneyIcon(self.img_icon, moneyCode)

	if costCount then
		self.text_txtPrice.text = costCount
	end

	table.clear(self._cacheItemData)

	self._cacheItemData.itemId = moneyCode
	self._cacheItemData.count = costCount
	self._itemData = ItemUtil.createItemData(self._cacheItemData)
end

function M:setCostCount(costCount, color)
	local countStr = color and string.format("<color=%s>%s</color>", color, costCount) or costCount

	self.text_txtPrice.text = countStr
end

function M:setActive(value)
	goutil.setActive(self._go, value)
end

function M:setIconVisible(value)
	goutil.setActive(self.img_icon.gameObject, value)
end

function M:setIsBlockClick(value)
	self.isBlockClick = value
end

function M:_onClickTips()
	if self.isBlockClick then
		return
	end

	if not self._itemData then
		return
	end

	GlobalDispatcher:dispatchEvent(EventType.ITEM_NORMAL_MARK_TYPE, self._itemData, self.go_com_price_item, 0, true, false)
end

function M:findUIElement(key, mtype)
	return self._viewElementsRegistry:findUIElement(key, mtype)
end

function M:OnDestroy()
	self.btn_btnClick:RemoveClickListener()
	self._viewElementsRegistry:cleanRegistry()

	self._go = nil
	self._viewElementsRegistry = nil
	self._cacheItemData = nil
	self._itemData = nil
end

return M
