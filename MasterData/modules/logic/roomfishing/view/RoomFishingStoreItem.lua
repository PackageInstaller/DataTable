-- chunkname: @modules/logic/roomfishing/view/RoomFishingStoreItem.lua

module("modules.logic.roomfishing.view.RoomFishingStoreItem", package.seeall)

local RoomFishingStoreItem = class("RoomFishingStoreItem", NormalStoreGoodsItem)

function RoomFishingStoreItem:onInitView()
	RoomFishingStoreItem.super.onInitView(self)

	self._gocurrency = gohelper.findChild(self.viewGO, "go_currency")
	self._imagecurrency = gohelper.findChildImage(self.viewGO, "go_currency/icon")
	self._txtcurrency = gohelper.findChildText(self.viewGO, "go_currency/txt_quantity")
end

function RoomFishingStoreItem:addEvents()
	RoomFishingStoreItem.super.addEvents(self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
end

function RoomFishingStoreItem:removeEvents()
	RoomFishingStoreItem.super.removeEvents(self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
end

function RoomFishingStoreItem:_onCurrencyChange()
	self:refreshCurrency()
end

function RoomFishingStoreItem:onUpdateMO(mo)
	RoomFishingStoreItem.super.onUpdateMO(self, mo)
	gohelper.setActive(self._goNormalBg, false)
	self:refreshCurrency()
end

function RoomFishingStoreItem:refreshRare()
	UISpriteSetMgr.instance:setV2a5MainActivitySprite(self._rare, "v2a5_store_quality_" .. self.itemConfig.rare, true)
	gohelper.setActive(self._rare.gameObject, true)
end

function RoomFishingStoreItem:refreshCurrency()
	local mo = self._mo
	local goodsConfig = StoreConfig.instance:getGoodsConfig(mo.goodsId)
	local cost = goodsConfig and goodsConfig.cost

	if string.nilorempty(cost) then
		gohelper.setActive(self._gocurrency, false)
	else
		local costs = string.split(cost, "|")

		if not costs[mo.buyCount + 1] then
			local costParam = costs[#costs]
			local costInfo = string.splitToNumber(costParam, "#")
			local costType = costInfo[1]
			local costId = costInfo[2]
			local costQuantity = costInfo[3]
			local hasQuantity = ItemModel.instance:getItemQuantity(costType, costId)

			self._txtcurrency.text = GameUtil.numberDisplay(hasQuantity)

			local color = "#FFFFFF"
			local color2 = "#0B0C0D"

			if costQuantity and hasQuantity < costQuantity then
				color = "#BF2E11"
				color2 = "#BF2E11"
			end

			SLFramework.UGUI.GuiHelper.SetColor(self._txtcurrency, color)
			SLFramework.UGUI.GuiHelper.SetColor(self._txtmaterialNum, color2)

			local costConfig = ItemModel.instance:getItemConfigAndIcon(costType, costId)
			local str = string.format("%s_1", costConfig.icon)

			UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagecurrency, str)
			gohelper.setActive(self._gocurrency, true)
		end
	end
end

return RoomFishingStoreItem
