-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\BuyRelicConfirmDlg.lua

local ResColor = require("ClientData/ResColor")
local RelicStoreCellMixin = require("UI/MainState/Trade/RelicStoreCellMixin")
local EventConst = require("EventConst")
local RelicTipsInfoPanel = require("UI/Common/Tips/RelicTipsInfoPanel")
local RelicStoreCellChild = Class("RelicStoreCellChild", UIControls.Child)

MixinClass(RelicStoreCellChild, RelicStoreCellMixin, true)

function RelicStoreCellChild:ctor()
	self:ctorMixin(false)
end

local strClassName = "BuyRelicConfirmDlg"
local BuyRelicConfirmDlg = Class(strClassName, UIControls.Window)

function BuyRelicConfirmDlg:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBoxClose)

	self.btnBuy = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnBuy:addEventClick(self.onItemBuy)

	self.imgMoney1 = UIControls.Image(self, "BgPanel/PricePanel/Icon")
	self.txtMoney1 = UIControls.ShortNumLabel(self, "BgPanel/PricePanel/TextNum")
	self.imgMoney2 = UIControls.Image(self, "BgPanel/PricePanel/Icon2")
	self.txtMoney2 = UIControls.ShortNumLabel(self, "BgPanel/PricePanel/TextNum2")
	self.panelContent = UIControls.Panel(self, "BgPanel/ContentPanel")
	self.labelContent = UIControls.Label(self, "BgPanel/ContentPanel/TextContent")
	self.panelRelicInfo = RelicTipsInfoPanel(self, "BgPanel")
end

function BuyRelicConfirmDlg:showShopItem(item, orderUI, buyCB, cellClass, cellPrefab)
	self.buyCB = buyCB
	self._curItem = item

	if self.cellShop then
		self.cellShop:destroy()
	end

	self.cellShop = RelicStoreCellChild(self, "BgPanel/ItemPanel", "System/Common/Grid/GridStoreRelicItem", 0, 0, true)

	self.cellShop:setData(item)
	self.panelRelicInfo:setRelic(item.object)
	self:_updateItem()

	if orderUI and orderUI.mWindow then
		self:setOrder(orderUI.mWindow:getOrder() + 5)
	end

	self:setVisible(true)
end

function BuyRelicConfirmDlg:_updateItem()
	if self._curItem == nil then
		return
	end

	local data = self._curItem.data
	local contentDesc = self._curItem.desc
	local descTitle = self._curItem:hasCustomDesc() and Lang.get(1673) or Lang.get(1681)
	local contentIsEmpty = contentDesc == nil

	self.panelContent:setVisible(not contentIsEmpty)

	if contentDesc ~= nil then
		self.labelContent:setText(contentDesc)
	end

	for idx = 1, 2 do
		local moneyInfo = data.use[idx]

		self["imgMoney" .. idx]:setVisible(moneyInfo ~= nil)
		self["txtMoney" .. idx]:setVisible(moneyInfo ~= nil)

		if moneyInfo then
			local moneyPath = ClientUtils.getMoneyIcon(moneyInfo.ID)

			if moneyPath then
				self["imgMoney" .. idx]:setImage(moneyPath[1], moneyPath[2])
			else
				local itemPath = BaseObject.getItemIconPath(moneyInfo.ID)

				if itemPath then
					self["imgMoney" .. idx]:setImage(itemPath[1], itemPath[2])
				end
			end

			self["txtMoney" .. idx]:setNum(moneyInfo.discount)

			local haveV = ClientUtils.getMoney(moneyInfo.ID)

			if haveV >= moneyInfo.discount then
				self["txtMoney" .. idx]:setFontColor(ResColor.BLACK)
			else
				self["txtMoney" .. idx]:setFontColor(ResColor.RED)
			end
		end
	end
end

function BuyRelicConfirmDlg:_doBuy()
	local moneyInfo = self._curItem.data.use[2]

	if moneyInfo then
		ClientUtils.checkMoneyChange(moneyInfo.ID, moneyInfo.discount, self.itemBuyCb, self, true)
	else
		self:itemBuyCb()
	end
end

function BuyRelicConfirmDlg:onBoxClose(sender)
	self:setVisible(false)
end

function BuyRelicConfirmDlg:itemBuyCb()
	RPC.shopExchange(self._curItem.shopID, self._curItem.id, 1, 0)
	self:setVisible(false)
end

function BuyRelicConfirmDlg:onItemBuy(sender)
	local moneyInfo = self._curItem.data.use[1]

	ClientUtils.checkMoneyChange(moneyInfo.ID, moneyInfo.discount, self._doBuy, self, true)
end

return BuyRelicConfirmDlg
