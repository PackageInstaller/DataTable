-- chunkname: @IQIGame\\UI\\PushShop\\PushGiftItemView.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local pushItemDetailView = require("IQIGame.UI.PushShop.PushItemDetailView")
local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickBuyBtn()
		self:OnClickBuyBtn()
	end

	self.giftItemView = ItemCell.New(self.GiftItemView, true, true, true)
	self.previewItemPool = UIViewObjectPool.New(self.ItemPrefab, self.ItemDetailContent.transform, function(_view)
		return pushItemDetailView.New(_view)
	end)

	self:AddListeners()
end

function m:AddListeners()
	self.BuyButton:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBuyBtn)
end

function m:RemoveListeners()
	self.BuyButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBuyBtn)
end

function m:SetData(commodityID, index)
	self.commodityCfg = CfgCommodityTable[commodityID]
	self.itemCfg = CfgItemTable[self.commodityCfg.ItemId]

	UGUIUtil.SetText(self.GiftName, self.itemCfg.Name)

	local numStr = ""

	if index < 10 then
		numStr = "0" .. index
	else
		numStr = tostring(index)
	end

	UGUIUtil.SetText(self.GiftIndexText, numStr)
	self.giftItemView:SetItemByCid(self.commodityCfg.ItemId)
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[self.commodityCfg.Price[1][1]].Icon), self.PriceImg:GetComponent("Image"))
	LuaUtility.SetGameObjectShow(self.PriceImg, true)
	LuaUtility.SetGameObjectShow(self.RedDot, RedDotModule.CheckRedDot_PushGiftCommodityByID(commodityID))

	local Purchased = false

	LuaUtility.SetGameObjectShow(self.BuyPriceText, not Purchased)
	LuaUtility.SetGameObjectShow(self.purchasedText, Purchased)
	LuaUtility.SetGameObjectShow(self.PriceImg, not Purchased)
	LuaUtility.SetGameObjectShow(self.PriceImg, not Purchased)

	self.BuyButton:GetComponent("Button").interactable = not Purchased

	local isDiscount = self.commodityCfg.DiscountRate ~= 0
	local isDiscountWithoutPrice = isDiscount and #self.commodityCfg.Discount == 0

	if isDiscount and not isDiscountWithoutPrice then
		LuaUtility.SetText(self.BuyPriceText, self.commodityCfg.Discount[2])
	else
		LuaUtility.SetText(self.BuyPriceText, self.commodityCfg.Price[1][2])
	end

	LuaUtility.SetGameObjectShow(self.DisCountRoot, isDiscount)

	if isDiscount then
		LuaUtility.SetText(self.textDiscount, ShopUIApi:GetDiscountPercentText(self.commodityCfg))
	end

	self.endTime = PlayerModule.GetLimitTimeGiftDataByID(commodityID)

	self:RefreshItemList()
	self:RefreshCountdown()
end

function m:RefreshItemList()
	self.previewItemPool:ForItems(function(_item)
		_item:Hide()
	end)

	local previewItemsData = ItemModule.GetGiftPreviewItems(self.itemCfg)

	for i = 1, #previewItemsData do
		local previewItem = self.previewItemPool:GetFree(function(_item)
			return not _item.View.activeSelf
		end)

		previewItem:Show()
		previewItem:SetData(previewItemsData[i])
	end
end

function m:RefreshCountdown()
	self:UpdateSurplusTime()

	if self.timer == nil then
		self.timer = Timer.New(function()
			self:UpdateSurplusTime()
		end, 1, -1)

		self.timer:Start()
	end
end

function m:UpdateSurplusTime()
	local serverTime = math.floor(tonumber(PlayerModule.GetServerTime()))
	local surplusTime = tonumber(self.endTime) - serverTime

	if surplusTime <= 0 then
		surplusTime = 0
	end

	UGUIUtil.SetText(self.TimeText, DateTimeFormat(surplusTime, BuyEnergyUIApi:GetTimeFormat(surplusTime)))
end

function m:OnClickBuyBtn()
	local commodityData = ShopModule.GetCommodityDataByShopAndCommodityID(self.commodityCfg.ShopID, self.commodityCfg.Id)

	ShopModule.BuyItem(commodityData, 1)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	self.giftItemView:Dispose()
	self.previewItemPool:Dispose(function(_item)
		_item:Dispose()
	end)

	self.previewItemPool = nil

	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
