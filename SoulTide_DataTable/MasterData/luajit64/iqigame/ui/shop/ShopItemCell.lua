-- chunkname: @IQIGame\\UI\\Shop\\ShopItemCell.lua

local ShopItemCell = {}

function ShopItemCell.New(go)
	local o = Clone(ShopItemCell)

	o:Initialize(go)

	return o
end

function ShopItemCell:Initialize(go)
	self.View = go

	LuaCodeInterface.BindOutlet(go, self)

	self.itemCell = ItemCell.PackageOrReuseView(self, self.goItem, true, true, true)
	self.cellQualityBg = self.goCellQualityBg:GetComponent("Image")
	self.imgMoney = self.goMoneyBlock.transform:Find("Image_01"):GetComponent("Image")
	self.tfName = self.goName:GetComponent("Text")
	self.tfDiscount = self.goDiscountBlock.transform:Find("Text_01"):GetComponent("Text")
	self.tfMoneyCost = self.goMoneyBlock.transform:Find("Text_01"):GetComponent("Text")
	self.tfCondition = self.goConditionBlock.transform:Find("Text_01"):GetComponent("Text")
	self.tfCount = self.goCount:GetComponent("Text")
	self.goSellOutBlock.transform:Find("Text_01"):GetComponent("Text").text = ShopUIApi:GetString("goSellOutDesc")
end

function ShopItemCell:Refresh(cfgGoodsData, index, shopId)
	self.cfgGoodsData = cfgGoodsData
	self.index = index
	self.shopId = shopId
	self.cfgItemData = CfgItemTable[self.cfgGoodsData.ItemId[1]]

	local shopData = ShopModule.GetShopDataByShopId(self.shopId)

	self.isSellOut = false

	for i = 1, #shopData.buyGoodsList do
		if shopData.buyGoodsList[i] == self.index then
			self.isSellOut = true

			break
		end
	end

	self:RefreshMisc()
	self:RefreshItemCell()
	self:RefreshDiscount()
	self:RefreshCondition()
	self:RefreshSellOut()
end

function ShopItemCell:OnDestroy()
	self.itemCell:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function ShopItemCell:RefreshMisc()
	self.tfName.text = ShopBuyItemUIApi:GetString("ItemNameTxt", self.cfgItemData.Name, self.isSellOut)
	self.tfCount.text = ShopBuyItemUIApi:GetString("goCount", self.cfgGoodsData.ItemId[2], self.isSellOut)

	local moneyPath = UIGlobalApi.GetIconPath(CfgItemTable[self.cfgGoodsData.Cost[1]].Icon)

	AssetUtil.LoadImage(self, moneyPath, self.imgMoney)
end

function ShopItemCell:RefreshItemCell()
	local itemCfgOrData = self.cfgItemData

	if self.cfgItemData.Type == Constant.ItemType.EvilErosionEquip then
		itemCfgOrData = ItemData.CreateByCIDAndNumber(self.cfgItemData.Id, self.cfgGoodsData.ItemId[2])
	end

	self.itemCell:SetItem(itemCfgOrData)
	AssetUtil.LoadImage(self, ShopUIApi:GetEvilErosionShopFrame(self.cfgItemData.Quality), self.cellQualityBg)
end

function ShopItemCell:RefreshDiscount()
	if self.cfgGoodsData.Cost[2] == self.cfgGoodsData.OriginalCost then
		self.goDiscountBlock:SetActive(false)
	else
		self.goDiscountBlock:SetActive(true)

		local discount = math.floor((self.cfgGoodsData.OriginalCost - self.cfgGoodsData.Cost[2]) / self.cfgGoodsData.OriginalCost * 100)

		self.tfDiscount.text = ShopBuyItemUIApi:GetString("goDiscount", discount, self.isSellOut)
	end

	self.tfMoneyCost.text = ShopBuyItemUIApi:GetString("goMoneyCost", self.cfgGoodsData.Cost[2], WarehouseModule.GetItemNumByCfgID(self.cfgGoodsData.Cost[1]), self.isSellOut)
end

function ShopItemCell:RefreshCondition()
	self.isConditionOk = true

	if self.cfgGoodsData.UnlockCondition > 0 then
		local canBuy, limitResult = ConditionModule.Check(self.cfgGoodsData.UnlockCondition)

		if canBuy == false then
			self.goConditionBlock:SetActive(true)

			self.tfCondition.text = ShopBuyItemUIApi:GetString("goCondition", tostring(limitResult), self.isSellOut)
			self.isConditionOk = false

			return
		end
	end

	self.goConditionBlock:SetActive(false)
end

function ShopItemCell:RefreshSellOut()
	self.goSellOutBlock:SetActive(self.isSellOut)
	self.goMoneyPanel:SetActive(not self.isSellOut)
end

function ShopItemCell:OnClickBtnBuy()
	if self.isSellOut or not self.isConditionOk then
		return
	end

	UIModule.Open(Constant.UIControllerName.ShopBuyPanelUI, Constant.UILayer.UI, {
		self.cfgGoodsData,
		self.shopId,
		self.index
	})
end

return ShopItemCell
