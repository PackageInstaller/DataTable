-- chunkname: @modules/logic/room/view/trade/RoomWholesaleItem.lua

module("modules.logic.room.view.trade.RoomWholesaleItem", package.seeall)

local RoomWholesaleItem = class("RoomWholesaleItem", LuaCompBase)

function RoomWholesaleItem:onInitView()
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._goicon = gohelper.findChild(self.viewGO, "stuff/#go_icon")
	self._txtpricechange = gohelper.findChildText(self.viewGO, "stuff/change/#txt_pricechange")
	self._txtprice = gohelper.findChildText(self.viewGO, "stuff/#txt_price")
	self._simagerewardicon1 = gohelper.findChildSingleImage(self.viewGO, "stuff/#txt_price/#simage_rewardicon")
	self._txtinventory = gohelper.findChildText(self.viewGO, "order/#txt_inventory ")
	self._txtinventorycount = gohelper.findChildText(self.viewGO, "order/#txt_inventorycount")
	self._txtsold = gohelper.findChildText(self.viewGO, "order/#txt_sold")
	self._txtsoldcount = gohelper.findChildText(self.viewGO, "order/#txt_soldcount")
	self._inputvalue = gohelper.findChildTextMeshInputField(self.viewGO, "order/valuebg/#input_value")
	self._btnsub = gohelper.findChildClickWithDefaultAudio(self.viewGO, "order/#btn_sub")
	self._btnadd = gohelper.findChildClickWithDefaultAudio(self.viewGO, "order/#btn_add")
	self._txttotalprice = gohelper.findChildText(self.viewGO, "price/#txt_price")
	self._simagerewardicon2 = gohelper.findChildSingleImage(self.viewGO, "price/#txt_price/#simage_rewardicon")
	self._btnunconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_unconfirm")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_confirm")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomWholesaleItem:addEvents()
	self._btnsub:AddClickListener(self._btnsubOnClick, self)
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btnunconfirm:AddClickListener(self._btnunconfirmOnClick, self)
	self._inputvalue:AddOnValueChanged(self._onValueChanged, self)
end

function RoomWholesaleItem:removeEvents()
	self._btnsub:RemoveClickListener()
	self._btnadd:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self._btnunconfirm:RemoveClickListener()
	self._inputvalue:RemoveOnValueChanged()

	if self._btnsublongPrees then
		self._btnsublongPrees:RemoveLongPressListener()
	end

	if self._btnaddlongPrees then
		self._btnaddlongPrees:RemoveLongPressListener()
	end
end

function RoomWholesaleItem:init(go)
	self.viewGO = go

	self:onInitView()
end

function RoomWholesaleItem:addEventListeners()
	self:addEvents()
end

function RoomWholesaleItem:removeEventListeners()
	self:removeEvents()
end

function RoomWholesaleItem:_btnsubOnClick()
	if RoomTradeModel.instance:isMaxWeelyOrder() then
		GameFacade.showToast(ToastEnum.RoomWholesaleWeeklyMax)

		return
	end

	self._mo:reduceSoldCount()
	self:_refreshSoldCount()
end

function RoomWholesaleItem:_btnaddOnClick()
	if RoomTradeModel.instance:isMaxWeelyOrder() then
		GameFacade.showToast(ToastEnum.RoomWholesaleWeeklyMax)

		return
	end

	self._mo:addSoldCount()
	self:_refreshSoldCount()
end

function RoomWholesaleItem:_btnconfirmOnClick()
	if RoomTradeModel.instance:isMaxWeelyOrder() then
		GameFacade.showToast(ToastEnum.RoomWholesaleWeeklyMax)

		return
	end

	if self._mo:getSoldCount() <= 0 then
		return
	end

	RoomTradeController.instance:finishDailyOrder(RoomTradeEnum.Mode.Wholesale, self._mo.orderId, self._mo:getSoldCount())
end

function RoomWholesaleItem:_btnunconfirmOnClick()
	GameFacade.showToast(ToastEnum.RoomOrderNotCommit)
end

function RoomWholesaleItem:_onSubLongPress()
	self:_btnsubOnClick()
end

function RoomWholesaleItem:_onAddLongPress()
	self:_btnaddOnClick()
end

local PRESS_TIME = 0.5
local NEXT_PRESS_TIME = 0.1

function RoomWholesaleItem:_editableInitView()
	self._btnsublongPrees = SLFramework.UGUI.UILongPressListener.Get(self._btnsub.gameObject)

	self._btnsublongPrees:SetLongPressTime({
		PRESS_TIME,
		NEXT_PRESS_TIME
	})
	self._btnsublongPrees:AddLongPressListener(self._onSubLongPress, self)

	self._btnaddlongPrees = SLFramework.UGUI.UILongPressListener.Get(self._btnadd.gameObject)

	self._btnaddlongPrees:SetLongPressTime({
		PRESS_TIME,
		NEXT_PRESS_TIME
	})
	self._btnaddlongPrees:AddLongPressListener(self._onAddLongPress, self)
end

function RoomWholesaleItem:onUpdateParam()
	return
end

function RoomWholesaleItem:onOpen()
	return
end

function RoomWholesaleItem:onClose()
	return
end

function RoomWholesaleItem:onDestroy()
	self._simagerewardicon1:UnLoadImage()
	self._simagerewardicon2:UnLoadImage()
end

function RoomWholesaleItem:onUpdateMo(mo)
	self._mo = mo
	self._txtname.text = mo:getGoodsName()

	self:setIconItem()
	self:setUnitPrice()
	self:onRefresh()
end

function RoomWholesaleItem:setIconItem()
	self._iconItem = self._iconItem or IconMgr.instance:getCommonItemIcon(self._goicon.gameObject)

	local type, id, quantity = self._mo:getItem()

	self._iconItem:setMOValue(type, id, quantity, nil, true)
	transformhelper.setLocalScale(self._iconItem.go.transform, 0.8, 0.8, 1)
	self._iconItem:isShowQuality(false)
	self._iconItem:isShowCount(false)
end

function RoomWholesaleItem:setUnitPrice()
	local type, id, price = self._mo:getUnitPrice()
	local _, icon = ItemModel.instance:getItemConfigAndIcon(type, id)

	if icon ~= self._priceIcon then
		self._simagerewardicon1:LoadImage(icon)
		self._simagerewardicon2:LoadImage(icon)

		self._priceIcon = icon
	end

	local langutilprice = luaLang("room_wholesaleorder_utilprice")

	self._txtprice.text = GameUtil.getSubPlaceholderLuaLangOneParam(langutilprice, GameUtil.numberDisplay(price))

	local langpriceratio = luaLang("room_wholesaleorder_priceratio")

	self._txtpricechange.text = GameUtil.getSubPlaceholderLuaLangOneParam(langpriceratio, self._mo:getPriceRatio())
end

function RoomWholesaleItem:onRefresh()
	self._txtinventorycount.text = self._mo:getMaxCountStr()
	self._txtsoldcount.text = self._mo:getTodaySoldCountStr()

	self:_refreshSoldCount()
	self:_refreshBtn()
end

function RoomWholesaleItem:_refreshSoldCount()
	local sold = self._mo:getSoldCount() or 0
	local _, _, price = self._mo:getUnitPrice()
	local totalPrice = GameUtil.numberDisplay(sold * price)

	self._inputvalue:SetText(sold)

	self._txttotalprice.text = totalPrice

	self:_refreshBtn()
end

function RoomWholesaleItem:_onValueChanged()
	local inputValue = self._inputvalue:GetText()

	if string.nilorempty(inputValue) then
		inputValue = 0
	end

	self._mo:setSoldCount(tonumber(inputValue))
	self:_refreshSoldCount()
end

function RoomWholesaleItem:_refreshBtn()
	local isMaxWeelyOrder = RoomTradeModel.instance:isMaxWeelyOrder()
	local isCanSold = self._mo:getMaxCount() > 0
	local sold = self._mo:getSoldCount() or 0

	gohelper.setActive(self._btnunconfirm.gameObject, not isCanSold)
	gohelper.setActive(self._btnconfirm.gameObject, isCanSold)
	ZProj.UGUIHelper.SetGrayscale(self._btnconfirm.gameObject, isMaxWeelyOrder or self._mo:getSoldCount() <= 0)
	ZProj.UGUIHelper.SetGrayscale(self._btnsub.gameObject, sold <= 0 or isMaxWeelyOrder)
	ZProj.UGUIHelper.SetGrayscale(self._btnadd.gameObject, sold >= self._mo:getMaxCount() or isMaxWeelyOrder)
end

RoomWholesaleItem.ResUrl = "ui/viewres/room/trade/roomwholesaleitem.prefab"

return RoomWholesaleItem
