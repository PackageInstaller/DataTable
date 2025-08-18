-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\BuyRelicPackConfirmDlg.lua

local ResColor = require("ClientData/ResColor")
local ResRandClient = require("ClientData/ResRandClient")
local RelicPkgStoreCellMixin = require("UI/MainState/Trade/RelicPkgStoreCellMixin")
local BuyRelicPackChild = require("UI/MainState/Trade/BuyRelicPackChild")
local EventConst = require("EventConst")
local RelicPkgStoreCellChild = Class("RelicPkgStoreCellChild", UIControls.Child)

MixinClass(RelicPkgStoreCellChild, RelicPkgStoreCellMixin, true)

function RelicPkgStoreCellChild:ctor()
	self:ctorMixin(false)
end

local strClassName = "BuyRelicPackConfirmDlg"
local BuyRelicPackConfirmDlg = Class(strClassName, UIControls.Window)

function BuyRelicPackConfirmDlg:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBoxClose)

	self.btnBuy = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnBuy:addEventClick(self.onItemBuy)

	self.imgMoney1 = UIControls.Image(self, "BgPanel/PricePanel/Icon")
	self.txtMoney1 = UIControls.ShortNumLabel(self, "BgPanel/PricePanel/TextNum")
	self.imgMoney2 = UIControls.Image(self, "BgPanel/PricePanel/Icon2")
	self.txtMoney2 = UIControls.ShortNumLabel(self, "BgPanel/PricePanel/TextNum2")
	self.panelContent = UIControls.Panel(self, "BgPanel/ContentPanel")
	self.labelTitle = UIControls.Label(self, "BgPanel/ContentPanel/TextTitle")
	self.labelContent = UIControls.Label(self, "BgPanel/ContentPanel/TextContent")
end

function BuyRelicPackConfirmDlg:showShopItem(item, orderUI, buyCB, cellClass, cellPrefab)
	self.buyCB = buyCB
	self._curItem = item

	if self.cellShop then
		self.cellShop:destroy()
	end

	self.cellShop = RelicPkgStoreCellChild(self, "BgPanel/ItemPanel", "System/Common/Grid/GridStoreRelicPackItem", 0, 0, true)

	self.cellShop:setData(item)
	self:_updateItem()

	if orderUI and orderUI.mWindow then
		self:setOrder(orderUI.mWindow:getOrder() + 5)
	end

	self:setVisible(true)
end

function BuyRelicPackConfirmDlg:_updateItem()
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

	self.labelTitle:setText(descTitle)

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

	if self.relicChildList then
		for _, relicChild in ipairs(self.relicChildList) do
			relicChild:destroy()
		end
	end

	self.relicChildList = {}

	local object = self._curItem.object
	local relicIds = ResRandClient[object.resData.extend_args3[1]].show_ids

	for _, relicId in ipairs(relicIds) do
		local relic = BaseObject.GetObject(relicId)

		if CurAvatar and CurAvatar.bagRelics[relicId] then
			relic = CurAvatar.bagRelics[relicId]
		end

		local relicChild = BuyRelicPackChild(self, "BgPanel/RelicPackPanel/Content", "System/Store/RelicPackChild", 0, 0, true)

		relicChild:setRelic(relic)
		table.insert(self.relicChildList, relicChild)
	end
end

function BuyRelicPackConfirmDlg:_doBuy()
	local moneyInfo = self._curItem.data.use[2]

	if moneyInfo then
		ClientUtils.checkMoneyChange(moneyInfo.ID, moneyInfo.discount, self.itemBuyCb, self, true)
	else
		self:itemBuyCb()
	end
end

function BuyRelicPackConfirmDlg:onBoxClose(sender)
	self:setVisible(false)
end

function BuyRelicPackConfirmDlg:itemBuyCb()
	RPC.shopExchange(self._curItem.shopID, self._curItem.id, 1, 0)
	self:setVisible(false)
end

function BuyRelicPackConfirmDlg:onItemBuy(sender)
	local moneyInfo = self._curItem.data.use[1]

	ClientUtils.checkMoneyChange(moneyInfo.ID, moneyInfo.discount, self._doBuy, self, true)
end

return BuyRelicPackConfirmDlg
