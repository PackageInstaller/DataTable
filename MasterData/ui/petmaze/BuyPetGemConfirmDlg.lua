-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PetMaze\\BuyPetGemConfirmDlg.lua

local ResColor = require("ClientData/ResColor")
local ShopCellMixin = require("UI/MainState/Trade/ShopCellMixin")
local RearHouseShopCellMixin = require("UI/RearHouse/RearHouseShopCellMixin")
local GemRandomInfoPanel = require("UI/Pet/GemRandomInfoPanel")
local ShopCellChild = Class("BuyPetGemConfirmDlg_ShopCellChild", UIControls.Child)

MixinClass(ShopCellChild, ShopCellMixin, true)

function ShopCellChild:ctor()
	self:ctorMixin(false)
end

local RearHouseShopCellChild = Class("BuyPetGemConfirmDlg_RearHouseShopCellChild", UIControls.Child)

MixinClass(RearHouseShopCellChild, RearHouseShopCellMixin, true)

function RearHouseShopCellChild:ctor()
	self:ctorMixin(false)
end

local strClassName = "BuyPetGemConfirmDlg"
local BuyPetGemConfirmDlg = Class(strClassName, UIControls.Window)

function BuyPetGemConfirmDlg:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBoxClose)

	self.btnBuy = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnBuy:addEventClick(self.onItemBuy)

	self.imgMoney1 = UIControls.Image(self, "BgPanel/PricePanel/Icon")
	self.txtMoney1 = UIControls.ShortNumLabel(self, "BgPanel/PricePanel/TextNum")
	self.imgMoney2 = UIControls.Image(self, "BgPanel/PricePanel/Icon2")
	self.txtMoney2 = UIControls.ShortNumLabel(self, "BgPanel/PricePanel/TextNum2")
	self.gemRandomInfo = GemRandomInfoPanel(self, "BgPanel/RandomInfoPanel")
end

function BuyPetGemConfirmDlg:showShopItem(item, orderUI, buyCB, cellClass, cellPrefab)
	self.buyCB = buyCB
	self._curItem = item
	self._buyCount = 1

	if self.cellShop then
		self.cellShop:destroy()
	end

	self:_initShopCell(cellClass, cellPrefab)
	self.cellShop:setData(item)
	self:_updateItem()
	self.gemRandomInfo:setData(item.object)

	if orderUI and orderUI.mWindow then
		self:setOrder(orderUI.mWindow:getOrder() + 5)
	end

	self:setVisible(true)
end

function BuyPetGemConfirmDlg:_initShopCell(cellClass, cellPrefab)
	if cellClass then
		self.cellShop = cellClass(self, "BgPanel/ItemPanel", cellPrefab, 0, 0, true)
	elseif self._curItem:isRearHouseType() == true then
		self.cellShop = RearHouseShopCellChild(self, "BgPanel/ItemPanel", "System/Common/Grid/GridBackyardStoreItem", 0, 0, true)
	else
		self.cellShop = ShopCellChild(self, "BgPanel/ItemPanel", "System/Common/Grid/GridStoreItem", 0, 0, true)
	end
end

function BuyPetGemConfirmDlg:_updateItem()
	if self._curItem == nil then
		return
	end

	local data = self._curItem.data

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

function BuyPetGemConfirmDlg:_doBuy()
	local moneyInfo = self._curItem.data.use[2]

	if moneyInfo then
		ClientUtils.checkMoneyChange(moneyInfo.ID, moneyInfo.discount, self.itemBuyCb, self, true)
	else
		self:itemBuyCb()
	end
end

function BuyPetGemConfirmDlg:onBoxClose(sender)
	self:setVisible(false)
end

function BuyPetGemConfirmDlg:itemBuyCb()
	if self.buyCB then
		self.buyCB(self._curItem.id, self._buyCount)
	else
		RPC.shopExchange(self._curItem.shopID, self._curItem.id, self._buyCount, 0)
	end

	self:setVisible(false)
end

function BuyPetGemConfirmDlg:onItemBuy(sender)
	local moneyInfo = self._curItem.data.use[1]

	ClientUtils.checkMoneyChange(moneyInfo.ID, moneyInfo.discount, self._doBuy, self, true)
end

function BuyPetGemConfirmDlg:setGoRechargeCallBack(cb)
	self.goRechargeCallBack = cb
end

return BuyPetGemConfirmDlg
