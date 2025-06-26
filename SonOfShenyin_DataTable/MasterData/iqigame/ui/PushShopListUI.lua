-- chunkname: @IQIGame\\UI\\PushShopListUI.lua

local pushGiftItemView = require("IQIGame.UI.PushShop.PushGiftItemView")
local PushShopListUI = {
	GiftItemList = {}
}

PushShopListUI = Base:Extend("PushShopListUI", "IQIGame.Onigao.UI.PushShopListUI", PushShopListUI)

function PushShopListUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnNotifyLimitedTimePkg()
		self:OnNotifyLimitedTimePkg()
	end
end

function PushShopListUI:GetPreloadAssetPaths()
	return nil
end

function PushShopListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PushShopListUI:IsManualShowOnOpen(userData)
	return false
end

function PushShopListUI:GetBGM(userData)
	return nil
end

function PushShopListUI:OnOpen(userData)
	self:RefreshGiftListInfo()
end

function PushShopListUI:OnClose(userData)
	return
end

function PushShopListUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.AddEventListener(EventID.NotifyLimitedTimePkg, self.DelegateOnNotifyLimitedTimePkg)
end

function PushShopListUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.NotifyLimitedTimePkg, self.DelegateOnNotifyLimitedTimePkg)
end

function PushShopListUI:OnPause()
	return
end

function PushShopListUI:OnResume()
	return
end

function PushShopListUI:OnCover()
	return
end

function PushShopListUI:OnReveal()
	return
end

function PushShopListUI:OnRefocus(userData)
	return
end

function PushShopListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PushShopListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PushShopListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PushShopListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PushShopListUI:OnDestroy()
	for k, v in pairs(self.GiftItemList) do
		v:Dispose()
	end

	self.GiftItemList = nil

	AssetUtil.UnloadAsset(self)
end

function PushShopListUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.PushShopListUI)
end

function PushShopListUI:OnNotifyLimitedTimePkg()
	self:RefreshGiftListInfo()
end

function PushShopListUI:RefreshGiftListInfo()
	local commodityIDs = PlayerModule.GetLimitTimeGifts()

	self:ScreenCommodityData(commodityIDs)
end

function PushShopListUI:ScreenCommodityData(commodityIDs)
	self.CommodityIDs = {}

	for k, v in pairs(commodityIDs) do
		local isPop = PlayerPrefsUtil.GetString("", v .. Constant.PlayerPrefsConst.LimitedTimeGiftPop .. PlayerModule.PlayerInfo.baseInfo.guid, "false")
		local endTime = PlayerModule.GetLimitTimeGiftDataByID(v)

		if isPop == "true" and endTime ~= nil and endTime > 0 then
			table.insert(self.CommodityIDs, v)
		end
	end

	if #self.CommodityIDs == 0 then
		UIModule.CloseSelf(self)

		return
	end

	for i = 1, #self.GiftItemList do
		if i > #self.CommodityIDs then
			self.GiftItemList[i]:Hide()
		end
	end

	for i = 1, #self.CommodityIDs do
		local giftItem = self:CreateGiftItem(i)

		giftItem:SetData(self.CommodityIDs[i], i)
		giftItem:Show()
	end
end

function PushShopListUI:CreateGiftItem(index)
	local giftItem = self.GiftItemList[index]

	if giftItem == nil then
		local obj = UnityEngine.Object.Instantiate(self.GiftItemPrefab)

		obj.transform:SetParent(self.GiftItemListContent.transform, false)

		local giftItemView = pushGiftItemView.New(obj)

		self.GiftItemList[index] = giftItemView
		giftItem = giftItemView
	end

	return giftItem
end

return PushShopListUI
