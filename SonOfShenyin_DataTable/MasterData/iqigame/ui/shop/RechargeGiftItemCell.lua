-- chunkname: @IQIGame\\UI\\Shop\\RechargeGiftItemCell.lua

local RechargeGiftItemCell = {}
local FontColorEnum = {
	Black = 2,
	White = 1
}

function RechargeGiftItemCell.New(go, mainView)
	local o = Clone(RechargeGiftItemCell)

	o:Initialize(go, mainView)

	return o
end

function RechargeGiftItemCell:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()

	if self.Timer == nil then
		self.Timer = Timer.New(function()
			self:CheckTime()
		end, 1, -1)

		self.Timer:Start()
	end
end

function RechargeGiftItemCell:InitComponent()
	self.buttonBuy = self.buttonBuy:GetComponent("Button")
	self.itemImageCom = self.itemImage:GetComponent("Image")
end

function RechargeGiftItemCell:InitDelegate()
	function self.ButtonBuyDelegate()
		self:OnButtonBuyClick()
	end
end

function RechargeGiftItemCell:AddListener()
	self.buttonBuy.onClick:AddListener(self.ButtonBuyDelegate)
end

function RechargeGiftItemCell:RemoveListener()
	self.buttonBuy.onClick:RemoveListener(self.ButtonBuyDelegate)
end

function RechargeGiftItemCell:Dispose()
	self:RemoveListener()

	if self.Timer then
		self.Timer:Stop()

		self.Timer = nil
	end

	self.itemImageCom = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	AssetUtil.UnloadAsset(self)

	self.gameObject = nil
end

function RechargeGiftItemCell:OnButtonBuyClick()
	UIModule.Open(Constant.UIControllerName.BuyResItemUI, Constant.UILayer.UI, {
		data = self.Data
	})
end

function RechargeGiftItemCell:Refresh(data)
	self.Data = data
	self.itemCfg = CfgItemTable[self.Data.config.ItemId]

	LuaUtility.SetText(self.textItemName, self.itemCfg.Name)
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.itemCfg.Icon), self.itemImageCom, function()
		LuaUtility.SetImageNativeSizeWithGameObject(self.itemImageCom.gameObject)
	end)

	self.fontColorType = FontColorEnum.Black

	local type = 4

	if self.Data:IsLimitTimeCommodity() then
		type = 3
		self.fontColorType = FontColorEnum.White
	elseif self.Data:IsCyclicRefreshCommodity() then
		type = 1
		self.fontColorType = FontColorEnum.White
	elseif self.Data.config.Free then
		type = 2
		self.fontColorType = FontColorEnum.White
	end

	AssetUtil.LoadImage(self, ShopUIApi:GetCommodityTypeImg(type), self.typeBG:GetComponent("Image"))
	self:Reset()
	self:CheckTime()
	self:CheckBuyLimit()
	self:CheckDiscount()
	self:CheckCommodityTagType()
	self:CheckBuyCondition()
	self:SetRedDotState()
end

function RechargeGiftItemCell:Reset()
	LuaUtility.SetGameObjectShow(self.timeRoot, false)
	LuaUtility.SetGameObjectShow(self.SellOutRoot, false)
	LuaUtility.SetGameObjectShow(self.imagePriceDelete, false)
end

function RechargeGiftItemCell:CheckTime()
	if self.Data.refreshType ~= Constant.ShopRefreshType.None then
		LuaUtility.SetGameObjectShow(self.timeRoot, true)
		LuaUtility.SetText(self.textTime, self.Data:GetRefreshTimeText())
	end
end

function RechargeGiftItemCell:CheckDiscount()
	LuaUtility.SetGameObjectShow(self.textDiscountNum, not self.Data.config.Free)
	LuaUtility.SetGameObjectShow(self.freeText, self.Data.config.Free)
	LuaUtility.SetGameObjectShow(self.imageCurrencyIcon, false)

	if self.Data.config.Free then
		LuaUtility.SetGameObjectShow(self.imageCurrencyIcon, false)
		LuaUtility.SetText(self.textDiscountNum, ShopUIApi:GetCommodityPriceText(self.fontColorType, ShopUIApi:GetFreeText()))
	else
		LuaUtility.SetGameObjectShow(self.imageCurrencyIcon, true)
		AssetUtil.LoadImage(self, ShopUIApi:GetShopBuyIconPath(self.Data:GetPriceIconId()), self.imageCurrencyIcon:GetComponent("Image"))

		if self.Data.isDiscount and not self.Data.isDiscountWithoutPrice then
			LuaUtility.SetText(self.textDiscountNum, ShopUIApi:GetCommodityPriceText(self.fontColorType, self.Data:GetDiscount()))
		else
			LuaUtility.SetText(self.textDiscountNum, ShopUIApi:GetCommodityPriceText(self.fontColorType, self.Data:GetPrice()))
		end

		if self.Data.isDiscount then
			LuaUtility.SetText(self.textDiscount, self.Data:GetDiscountPercentText())
		end
	end
end

function RechargeGiftItemCell:CheckBuyLimit()
	LuaUtility.SetGameObjectShow(self.residueRoot, self.Data.buyLimitType == Constant.ShopBuyLimitType.Limit)

	if self.Data.buyLimitType == Constant.ShopBuyLimitType.Limit then
		if self.Data.buyNum < self.Data.buyLimit then
			LuaUtility.SetText(self.textLimitTag, self.Data:GetLimitText() .. ShopUIApi:PurchaseLimitation1(self.Data.buyNum, self.Data.buyLimit))
		else
			LuaUtility.SetGameObjectShow(self.SellOutRoot, true)
			LuaUtility.SetText(self.textLimitTag, self.Data:GetLimitText() .. ShopUIApi:GetZeroLimitation(0, self.Data.buyLimit))
		end
	end
end

function RechargeGiftItemCell:CheckCommodityTagType()
	LuaUtility.SetGameObjectShow(self.longTremTag, self.Data:IsLongTremCommodity())
	LuaUtility.SetGameObjectShow(self.discountTag, self.Data:IsDiscountCommodity())
	LuaUtility.SetGameObjectShow(self.limitTimeTag, self.Data:IsLimitTimeCommodity())
end

function RechargeGiftItemCell:CheckBuyCondition()
	if not self.Data.isBuy and self.Data.buyConditionId ~= nil then
		UGUIUtil.SetText(self.conditionText, CfgConditionTable[self.Data.buyConditionId].Name)
		LuaUtility.SetGameObjectShow(self.conditionRoot, true)
	else
		LuaUtility.SetGameObjectShow(self.conditionRoot, false)
	end
end

function RechargeGiftItemCell:SetRedDotState()
	LuaUtility.SetGameObjectShow(self.RedDot, self.Data.config.Free and self.Data.buyNum < self.Data.buyLimit and self.Data.isBuy)
end

return RechargeGiftItemCell
