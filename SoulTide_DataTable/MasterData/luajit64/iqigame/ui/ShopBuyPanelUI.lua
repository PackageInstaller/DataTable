-- chunkname: @IQIGame\\UI\\ShopBuyPanelUI.lua

local ShopBuyPanelUI = Base:Extend("ShopBuyPanelUI", "IQIGame.Onigao.UI.ShopBuyPanelUI", {})

function ShopBuyPanelUI:OnInit()
	self:Initialize()
end

function ShopBuyPanelUI:GetPreloadAssetPaths()
	return nil
end

function ShopBuyPanelUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ShopBuyPanelUI:OnOpen(userData)
	self:Refresh(userData)
end

function ShopBuyPanelUI:OnClose(userData)
	return
end

function ShopBuyPanelUI:OnPause()
	return
end

function ShopBuyPanelUI:OnResume()
	return
end

function ShopBuyPanelUI:OnCover()
	return
end

function ShopBuyPanelUI:OnReveal()
	return
end

function ShopBuyPanelUI:OnRefocus(userData)
	return
end

function ShopBuyPanelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ShopBuyPanelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ShopBuyPanelUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ShopBuyPanelUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ShopBuyPanelUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.itemCell:Dispose()
end

function ShopBuyPanelUI:Initialize()
	self.itemCell = ItemCell.PackageOrReuseView(self, self.goItemCell, false, true)
	self.tfName = self.goName:GetComponent("Text")
	self.tfCount = self.goCount:GetComponent("Text")
	self.tfDesc = self.goDesc:GetComponent("Text")
	self.tfCost = self.goCost:GetComponent("Text")
	self.moneyIcon = self.goMoneyIcon:GetComponent("Image")
	self.btnBuy = self.goBtnBuy:GetComponent("Button")
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnBuyDelegate()
		self:OnClickBtnBuy()
	end

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onBuySuccessDelegate(shopId)
		self:OnBuySuccess(shopId)
	end

	self.goTitle:GetComponent("Text").text = ShopBuyPanelUIApi:GetString("goTitle")
	self.goBtnBuy.transform:Find("Text"):GetComponent("Text").text = ShopBuyPanelUIApi:GetString("goBtnBuyTxt")
end

function ShopBuyPanelUI:Refresh(userData)
	self.cfgGoodsData = userData[1]
	self.shopId = userData[2]
	self.goodsIndex = userData[3]
	self.cfgItemData = CfgItemTable[self.cfgGoodsData.ItemId[1]]

	self:RefreshMisc()
end

function ShopBuyPanelUI:RefreshMisc()
	self.itemCell:SetItemByCID(self.cfgItemData.Id)

	self.tfName.text = ShopBuyPanelUIApi:GetString("goName", self.cfgItemData.Name)
	self.tfCount.text = ShopBuyPanelUIApi:GetString("goCount", self.cfgGoodsData.ItemId[2])
	self.tfDesc.text = ShopBuyPanelUIApi:GetString("goDesc", self.cfgItemData.Describe)

	UGUIUtil.SetText(self.goType, ItemTipsApi:GetString("goType", self.cfgItemData.Type, self.cfgItemData.SubType))

	local path = UIGlobalApi.IconPath .. CfgItemTable[self.cfgGoodsData.Cost[1]].Icon

	AssetUtil.LoadImage(self, path, self.moneyIcon)

	self.tfCost.text = ShopBuyPanelUIApi:GetString("goCost", self.cfgGoodsData.Cost[2], WarehouseModule.GetItemNumByCfgID(self.cfgGoodsData.Cost[1]))
end

function ShopBuyPanelUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnBuy.onClick:AddListener(self.onClickBtnBuyDelegate)
	EventDispatcher.AddEventListener(EventID.BuyShopItemEvent, self.onBuySuccessDelegate)
end

function ShopBuyPanelUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnBuy.onClick:RemoveListener(self.onClickBtnBuyDelegate)
	EventDispatcher.RemoveEventListener(EventID.BuyShopItemEvent, self.onBuySuccessDelegate)
end

function ShopBuyPanelUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.ShopBuyPanelUI)
end

function ShopBuyPanelUI:OnClickBtnBuy()
	if self.cfgGoodsData.Cost[1] == Constant.ItemID.MONEY then
		if self.cfgGoodsData.Cost[2] <= PlayerModule.GetNumAttrValue(Constant.ItemID.MONEY) then
			ShopModule.SendBuyMsg(self.shopId, self.goodsIndex)
		else
			NoticeModule.ShowNoticeNoCallback(21040014)
		end
	elseif self.cfgGoodsData.Cost[1] == Constant.ItemID.TREASURE then
		if self.cfgGoodsData.Cost[2] <= PlayerModule.GetNumAttrValue(Constant.ItemID.TREASURE) then
			ShopModule.SendBuyMsg(self.shopId, self.goodsIndex)
		else
			NoticeModule.ShowNoticeNoCallback(21040015)
		end
	elseif self.cfgGoodsData.Cost[1] == Constant.ItemID.CONTRIBUTION then
		if self.cfgGoodsData.Cost[2] <= PlayerModule.GetNumAttrValue(Constant.ItemID.CONTRIBUTION) then
			ShopModule.SendBuyMsg(self.shopId, self.goodsIndex)
		else
			NoticeModule.ShowNoticeNoCallback(21040053)
		end
	elseif self.cfgGoodsData.Cost[2] <= WarehouseModule.GetItemNumByCfgID(self.cfgGoodsData.Cost[1]) then
		ShopModule.SendBuyMsg(self.shopId, self.goodsIndex)
	else
		NoticeModule.ShowNoticeNoCallback(21045004, CfgItemTable[self.cfgGoodsData.Cost[1]].Name)
	end

	EventDispatcher.Dispatch(EventID.DoSomeThingEvent)
end

function ShopBuyPanelUI:OnBuySuccess(shopId)
	self:OnClickBtnClose()
end

return ShopBuyPanelUI
