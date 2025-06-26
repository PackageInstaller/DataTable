-- chunkname: @IQIGame\\UI\\Shop\\ShopEquipCell.lua

local ShopEquipCell = {}

function ShopEquipCell.New(view)
	local obj = Clone(ShopEquipCell)

	obj:Initialize(view)

	return obj
end

function ShopEquipCell:Initialize(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.itemCell = EquipCell.New(self.goItem)
	self.imgMoney = self.goMoneyBlock.transform:Find("Image_01"):GetComponent("Image")
	self.tfName = self.goName:GetComponent("Text")
	self.tfDiscount = self.goDiscountBlock.transform:Find("Text_01"):GetComponent("Text")
	self.tfMoneyCost = self.goMoneyBlock.transform:Find("Text_01"):GetComponent("Text")
	self.tfCondition = self.goConditionBlock.transform:Find("Text_01"):GetComponent("Text")
	self.tfCount = self.goCount:GetComponent("Text")
	self.btnBuy = self.goBtnBuy:GetComponent("Button")

	function self.onClickBtnBuyDelegate()
		self:OnClickBtnBuy()
	end

	self.goSellOutBlock.transform:Find("Text_01"):GetComponent("Text").text = ShopUIApi:GetString("goSellOutDesc")

	self:OnAddListener()
end

function ShopEquipCell:Refresh(cfgGoodsData, index, shopId)
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

function ShopEquipCell:OnDestroy()
	self:OnRemoveListener()
	self.itemCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function ShopEquipCell:OnAddListener()
	self.btnBuy.onClick:AddListener(self.onClickBtnBuyDelegate)
end

function ShopEquipCell:OnRemoveListener()
	self.btnBuy.onClick:RemoveListener(self.onClickBtnBuyDelegate)
end

function ShopEquipCell:RefreshMisc()
	self.tfName.text = ShopBuyItemUIApi:GetString("ItemNameTxt", self.cfgItemData.Name, self.isSellOut)
	self.tfCount.text = ShopBuyItemUIApi:GetString("goCount", self.cfgGoodsData.ItemId[2], self.isSellOut)

	local moneyPath = UIGlobalApi.GetIconPath(CfgItemTable[self.cfgGoodsData.Cost[1]].Icon)

	AssetUtil.LoadImage(self, moneyPath, self.imgMoney)
end

function ShopEquipCell:RefreshItemCell()
	self.itemCell:RefreshByCID(self.cfgItemData.Id, nil, true)
end

function ShopEquipCell:RefreshDiscount()
	if self.cfgGoodsData.Cost[2] == self.cfgGoodsData.OriginalCost then
		self.goDiscountBlock:SetActive(false)
	else
		self.goDiscountBlock:SetActive(true)

		local discount = math.floor((self.cfgGoodsData.OriginalCost - self.cfgGoodsData.Cost[2]) / self.cfgGoodsData.OriginalCost * 100)

		self.tfDiscount.text = ShopBuyItemUIApi:GetString("goDiscount", discount, self.isSellOut)
	end

	self.tfMoneyCost.text = ShopBuyItemUIApi:GetString("goMoneyCost", self.cfgGoodsData.Cost[2], WarehouseModule.GetItemNumByCfgID(self.cfgGoodsData.Cost[1]), self.isSellOut)
end

function ShopEquipCell:RefreshCondition()
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

function ShopEquipCell:RefreshSellOut()
	self.goSellOutBlock:SetActive(self.isSellOut)
end

function ShopEquipCell:OnClickBtnBuy()
	if self.isSellOut or not self.isConditionOk then
		return
	end

	UIModule.Open(Constant.UIControllerName.ShopBuyPanelUI, Constant.UILayer.UI, {
		self.cfgGoodsData,
		self.shopId,
		self.index
	})
end

return ShopEquipCell
