-- chunkname: @IQIGame\\UI\\PushGiftUI.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local pushItemDetailView = require("IQIGame.UI.PushShop.PushItemDetailView")
local PushGiftUI = {}

PushGiftUI = Base:Extend("PushGiftUI", "IQIGame.Onigao.UI.PushGiftUI", PushGiftUI)

function PushGiftUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickBuyButton()
		self:OnClickBuyButton()
	end

	function self.DelegateNotifyLimitedTimePkg()
		self:OnNotifyLimitedTimePkg()
	end

	self.previewItemPool = UIViewObjectPool.New(self.ItemDetailPrefab, self.ItemDetailContent.transform, function(_view)
		return pushItemDetailView.New(_view)
	end)
end

function PushGiftUI:GetPreloadAssetPaths()
	return nil
end

function PushGiftUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PushGiftUI:IsManualShowOnOpen(userData)
	return false
end

function PushGiftUI:GetBGM(userData)
	return nil
end

function PushGiftUI:OnOpen(userData)
	self.commodityData = userData.shopCommodityData
	self.commodityID = userData.commodityID

	self:RefreshGiftInfo()
end

function PushGiftUI:OnClose(userData)
	EventDispatcher.Dispatch(EventID.PushGiftUIClosed)
end

function PushGiftUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.BuyButton:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBuyButton)
	EventDispatcher.AddEventListener(EventID.NotifyLimitedTimePkg, self.DelegateNotifyLimitedTimePkg)
end

function PushGiftUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.BuyButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBuyButton)
	EventDispatcher.RemoveEventListener(EventID.NotifyLimitedTimePkg, self.DelegateNotifyLimitedTimePkg)
end

function PushGiftUI:OnPause()
	return
end

function PushGiftUI:OnResume()
	return
end

function PushGiftUI:OnCover()
	return
end

function PushGiftUI:OnReveal()
	return
end

function PushGiftUI:OnRefocus(userData)
	return
end

function PushGiftUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PushGiftUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PushGiftUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PushGiftUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PushGiftUI:OnDestroy()
	self.previewItemPool:Dispose(function(_item)
		_item:Dispose()
	end)

	self.previewItemPool = nil

	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end

	AssetUtil.UnloadAsset(self)
end

function PushGiftUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function PushGiftUI:OnClickBuyButton()
	ShopModule.BuyItem(self.commodityData, 1)
end

function PushGiftUI:OnNotifyLimitedTimePkg()
	UIModule.CloseSelf(self)
end

function PushGiftUI:RefreshGiftInfo()
	self.commodityCfg = CfgCommodityTable[self.commodityID]
	self.itemCfg = CfgItemTable[self.commodityCfg.ItemId]

	UGUIUtil.SetText(self.GiftName, self.itemCfg.Name)
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[self.commodityCfg.Price[1][1]].Icon), self.PriceImg:GetComponent("Image"))
	LuaUtility.SetGameObjectShow(self.PriceImg, true)

	self.endTime = PlayerModule.GetLimitTimeGiftDataByID(self.commodityID)

	self:RefreshItemList()
	self:RefreshPriceInfo()
	self:RefreshCountdown()
end

function PushGiftUI:RefreshItemList()
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

function PushGiftUI:RefreshPriceInfo()
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
end

function PushGiftUI:RefreshCountdown()
	self:UpdateSurplusTime()

	if self.timer == nil then
		self.timer = Timer.New(function()
			self:UpdateSurplusTime()
		end, 1, -1)

		self.timer:Start()
	end
end

function PushGiftUI:UpdateSurplusTime()
	local surplusTime = tonumber(self.endTime) - math.floor(tonumber(PlayerModule.GetServerTime()))

	if surplusTime <= 0 then
		surplusTime = 0
	end

	UGUIUtil.SetText(self.TimeText, DateTimeFormat(surplusTime, BuyEnergyUIApi:GetTimeFormat(surplusTime)))
end

return PushGiftUI
