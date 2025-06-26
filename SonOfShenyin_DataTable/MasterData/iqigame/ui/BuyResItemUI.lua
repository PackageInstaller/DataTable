-- chunkname: @IQIGame\\UI\\BuyResItemUI.lua

local equipScrollRootView = require("IQIGame.UI.Shop.BuyItemPanelSubView.EquipScrollRootView")
local giftScrollRootView = require("IQIGame.UI.Shop.BuyItemPanelSubView.GiftScrollRootView")
local itemScrollRootView = require("IQIGame.UI.Shop.BuyItemPanelSubView.ItemScrollRootView")
local skillScrollRootView = require("IQIGame.UI.Shop.BuyItemPanelSubView.SkillScrollRootView")
local BuyResItemUI = {
	canBuyNum = 0,
	unitPrice = 0,
	anButtonType = 1,
	buyNum = 1,
	islongAn = false
}

BuyResItemUI = Base:Extend("BuyResItemUI", "IQIGame.Onigao.UI.BuyResItemUI", BuyResItemUI)

function BuyResItemUI:OnInit()
	function self.OnLongAddClicked()
		self:OnClickLongAdd()
	end

	function self.OnLongTimerClicked()
		self:OnClickLongTimer()
	end

	function self.OnEndAddClicked()
		self:OnClickEndAdd()
	end

	function self.OnUpAddClicked(go)
		self:OnClickUpAdd(go)
	end

	function self.OnDownAddClicked(go)
		self:OnClickDownAdd(go)
	end

	function self.OnGotoBuyClicked()
		self:OnClickGotoBuy()
	end

	function self.OnMinClicked()
		self:OnClickMin()
	end

	function self.OnMaxClicked()
		self:OnClickMax()
	end

	function self.OnCloseClicked()
		self:OnClickClose()
	end

	function self.DelegateOnClickSkillDetailBtn()
		self:OnClickSkillDetailBtn()
	end

	function self.DelegateOnClickRoleDetailBtn()
		self:OnClickRoleDetailBtn()
	end

	self.equipScrollPanel = equipScrollRootView.New(self.equipScrollRoot)
	self.skillScrollPanel = skillScrollRootView.New(self.skillScrollRoot)
	self.giftScrollPanel = giftScrollRootView.New(self.giftScrollRoot)
	self.itemScrollPanel = itemScrollRootView.New(self.itemScrollRoot)
	self.longButtonSub = self.longButtonSub:GetComponent("LongButton")
	self.addLongBtn = self.addbtn:GetComponent("LongButton")
	self.itemiconImg = self.itemicon:GetComponent("Image")
	self.presentStarsCom = self.presentStars:GetComponent("SimpleStarComponent")
end

function BuyResItemUI:GetPreloadAssetPaths()
	return nil
end

function BuyResItemUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BuyResItemUI:IsManualShowOnOpen(userData)
	return false
end

function BuyResItemUI:GetBGM(userData)
	return nil
end

function BuyResItemUI:OnOpen(userData)
	self:ShowPanel()
	self:Refresh(userData.data)
end

function BuyResItemUI:OnClose(userData)
	self:HidePanel()
end

function BuyResItemUI:OnAddListeners()
	self.buttonBuy:GetComponent("Button").onClick:AddListener(self.OnGotoBuyClicked)
	self.buttonMin:GetComponent("Button").onClick:AddListener(self.OnMinClicked)
	self.buttonMax:GetComponent("Button").onClick:AddListener(self.OnMaxClicked)
	self.buttonClose:GetComponent("Button").onClick:AddListener(self.OnCloseClicked)
	self.addLongBtn.onLongDownClick:AddListener(self.OnLongAddClicked)
	self.longButtonSub.onLongDownClick:AddListener(self.OnLongAddClicked)

	self.addLongBtn.repeatCall = false
	self.addLongBtn.onLongDownEnd = self.OnEndAddClicked
	self.addLongBtn.OnPointerUpAction = self.OnUpAddClicked
	self.addLongBtn.OnPointerDownAction = self.OnDownAddClicked
	self.longButtonSub.repeatCall = false
	self.longButtonSub.onLongDownEnd = self.OnEndAddClicked
	self.longButtonSub.OnPointerUpAction = self.OnUpAddClicked
	self.longButtonSub.OnPointerDownAction = self.OnDownAddClicked

	self.skillDetailBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSkillDetailBtn)
	self.RoleDetailBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickRoleDetailBtn)
end

function BuyResItemUI:OnRemoveListeners()
	self.buttonBuy:GetComponent("Button").onClick:RemoveListener(self.OnGotoBuyClicked)
	self.buttonMin:GetComponent("Button").onClick:RemoveListener(self.OnMinClicked)
	self.buttonMax:GetComponent("Button").onClick:RemoveListener(self.OnMaxClicked)
	self.buttonClose:GetComponent("Button").onClick:RemoveListener(self.OnCloseClicked)
	self.addLongBtn.onLongDownClick:RemoveListener(self.OnLongAddClicked)
	self.longButtonSub.onLongDownClick:RemoveListener(self.OnLongAddClicked)
	self.skillDetailBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSkillDetailBtn)
	self.RoleDetailBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickRoleDetailBtn)
end

function BuyResItemUI:OnPause()
	return
end

function BuyResItemUI:OnResume()
	return
end

function BuyResItemUI:OnCover()
	return
end

function BuyResItemUI:OnReveal()
	return
end

function BuyResItemUI:OnRefocus(userData)
	return
end

function BuyResItemUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function BuyResItemUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BuyResItemUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BuyResItemUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BuyResItemUI:OnDestroy()
	self.equipScrollPanel:Dispose()
	self.giftScrollPanel:Dispose()
	self.itemScrollPanel:Dispose()
	self.skillScrollPanel:Dispose()

	self.longButtonSub = nil
	self.addLongBtn = nil
	self.itemiconImg = nil
	self.presentStarsCom = nil

	self:TimerClose()
	self:HidePanel()
	AssetUtil.UnloadAsset(self)
end

function BuyResItemUI:Refresh(data)
	self.Data = data

	self.itemicon:SetActive(false)

	if not self.Data.config.Free then
		AssetUtil.LoadImage(self, ShopUIApi:GetShopBuyIconPath(self.Data:GetPriceIconId()), self.itemiconImg)
		self.itemicon:SetActive(true)
	end

	if self.Data.config.Free then
		self.unitPrice = 0

		LuaUtility.SetGameObjectShow(self.BuyParent, false)
	else
		if self.Data.isDiscount and not self.Data.isDiscountWithoutPrice then
			self.unitPrice = self.Data:GetDiscount()
		else
			self.unitPrice = self.Data:GetPrice()
		end

		LuaUtility.SetGameObjectShow(self.BuyParent, true)
	end

	self:ResetShow()
	self:CheckBaseInfo()
	self:RefreshItem()
	self:RefreshOwnItemNum()
	self:RefreshCommodityDetail()
	self:RefreshItemInfoByType()

	self.buyNum = 1

	self:RefreshShowBuyNum()
end

function BuyResItemUI:ResetShow()
	LuaUtility.SetGameObjectShow(self.textBuyLimitParent, false)
	LuaUtility.SetGameObjectShow(self.TimeParent, false)
	self.equipScrollPanel:Hide()
	self.giftScrollPanel:Hide()
	self.itemScrollPanel:Hide()
	self.skillScrollPanel:Hide()
	LuaUtility.SetGameObjectShow(self.skillDetailBtn, false)
	LuaUtility.SetGameObjectShow(self.presentStars, false)
	LuaUtility.SetGameObjectShow(self.RoleDetailBtn, false)
	LuaUtility.SetGameObjectShow(self.roleElementImg, false)
	LuaUtility.SetGameObjectShow(self.roleProfessionImg, false)
	LuaUtility.SetGameObjectShow(self.haveParent, false)
end

function BuyResItemUI:CheckBaseInfo()
	self:CheckBuyLimit()
	self:CheckDiscount()
	self:CheckTime()
	self:CheckCommodityTagType()
	self:CheckDoubleTag()
end

function BuyResItemUI:CheckTime()
	if self.Data.refreshType ~= Constant.ShopRefreshType.None then
		LuaUtility.SetGameObjectShow(self.TimeParent, true)
		LuaUtility.SetText(self.textTime, self.Data:GetRefreshTimeText())
	end
end

function BuyResItemUI:CheckBuyLimit()
	if self.Data.buyLimitType == Constant.ShopBuyLimitType.Limit then
		LuaUtility.SetGameObjectShow(self.textBuyLimitParent, true)

		if self.Data.buyNum < self.Data.buyLimit then
			LuaUtility.SetText(self.textBuyLimit, self.Data:GetLimitText() .. ShopUIApi:PurchaseLimitation1(self.Data.buyNum, self.Data.buyLimit))
		else
			LuaUtility.SetText(self.textBuyLimit, self.Data:GetLimitText() .. ShopUIApi:GetZeroLimitation(self.Data.buyNum, self.Data.buyLimit))
		end
	end
end

function BuyResItemUI:CheckDiscount()
	if not self.Data.config.Free and self.Data.isDiscount then
		LuaUtility.SetText(self.textDiscount, self.Data:GetDiscountPercentText())
	end
end

function BuyResItemUI:CheckCommodityTagType()
	LuaUtility.SetGameObjectShow(self.longTremTag, self.Data:IsLongTremCommodity())
	LuaUtility.SetGameObjectShow(self.discountTag, self.Data:IsDiscountCommodity())
	LuaUtility.SetGameObjectShow(self.limitTimeTag, self.Data:IsLimitTimeCommodity())
end

function BuyResItemUI:CheckDoubleTag()
	LuaUtility.SetGameObjectShow(self.typeTagRoot, self.Data.useDouble or not self.Data.config.IsDouble)
	LuaUtility.SetGameObjectShow(self.doubleTagRoot, not self.Data.useDouble and self.Data.config.IsDouble)
end

function BuyResItemUI:RefreshItem()
	local itemCfg = CfgItemTable[self.Data.config.ItemId]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(itemCfg.Icon), self.ByItemIconImg:GetComponent("Image"))
	UGUIUtil.SetText(self.ItemName, itemCfg.Name)

	if self.Data.type ~= Constant.ShopType.GiftBag then
		UGUIUtil.SetText(self.ItemNum, ShopUIApi:ShowShopNum(self.Data.config.Number))
	end
end

function BuyResItemUI:RefreshOwnItemNum()
	if self.Data.buyLimit == 0 then
		self.canBuyNum = 99
	else
		self.canBuyNum = self.Data.buyLimit - self.Data.buyNum
	end
end

function BuyResItemUI:RefreshCommodityDetail()
	local itemCfg = CfgItemTable[self.Data.config.ItemId]

	if itemCfg.ItemTypes == Constant.ItemType.Skill then
		self.skillScrollPanel:SetData(itemCfg)
		self.skillScrollPanel:Show()
	elseif itemCfg.ItemTypes == Constant.ItemType.Equip then
		self.equipScrollPanel:SetData(itemCfg)
		self.equipScrollPanel:Show()
	elseif itemCfg.ItemTypes == Constant.ItemType.Gift then
		self.giftScrollPanel:SetData(self:GetpPreviewItemsData(itemCfg))
		self.giftScrollPanel:Show()
	elseif itemCfg.ItemTypes == Constant.ItemType.Currency and itemCfg.ItemSubTypes == Constant.ItemSubType[Constant.ItemType.Currency].Currency then
		self.giftScrollPanel:SetData(self:GetpPreviewItemsData(itemCfg))
		self.giftScrollPanel:Show()
	else
		self.itemScrollPanel:SetData(itemCfg)
		self.itemScrollPanel:Show()
	end
end

function BuyResItemUI:GetpPreviewItemsData(itemCfg)
	local previewItemsData = {}

	if itemCfg.ItemTypes == Constant.ItemType.Gift then
		previewItemsData = ItemModule.GetGiftPreviewItems(itemCfg)
	elseif itemCfg.Id == Constant.ItemCid.TOLL_MONEY then
		if self.Data.useDouble then
			local itemData = {}

			itemData.cid = self.Data.config.ItemId
			itemData.count = self.Data.config.Number + (self.Data.config.Additional[2] ~= nil and self.Data.config.Additional[2] or 0)

			table.insert(previewItemsData, itemData)
		elseif self.Data.config.IsDouble then
			for i = 1, 2 do
				local itemData = {}

				itemData.cid = self.Data.config.ItemId
				itemData.count = self.Data.config.Number

				table.insert(previewItemsData, itemData)
			end
		else
			local itemData = {}

			itemData.cid = self.Data.config.ItemId
			itemData.count = self.Data.config.Number

			table.insert(previewItemsData, itemData)
		end
	else
		local itemData = {}

		itemData.cid = self.Data.config.ItemId
		itemData.count = self.Data.config.Number

		table.insert(previewItemsData, itemData)
	end

	return previewItemsData
end

function BuyResItemUI:RefreshItemInfoByType()
	local itemCfg = CfgItemTable[self.Data.config.ItemId]

	if itemCfg.ItemTypes == Constant.ItemType.Skill then
		LuaUtility.SetGameObjectShow(self.presentStars, true)
		self.presentStarsCom:UpdateView(itemCfg.Quality, 0)
		LuaUtility.SetGameObjectShow(self.skillDetailBtn, true)
	elseif itemCfg.ItemTypes == Constant.ItemType.Hero then
		LuaUtility.SetGameObjectShow(self.RoleDetailBtn, true)

		local path = WarlockApi:GetElementIconPath(CfgHeroTable[itemCfg.LikeId].Elements)

		AssetUtil.LoadImage(self, path, self.roleElementImg:GetComponent("Image"))

		path = WarlockApi:GetProfessionIconPath(CfgHeroTable[itemCfg.LikeId].Profession)

		AssetUtil.LoadImage(self, path, self.roleProfessionImg:GetComponent("Image"))
		LuaUtility.SetGameObjectShow(self.roleElementImg, true)
		LuaUtility.SetGameObjectShow(self.roleProfessionImg, true)
	elseif itemCfg.ItemTypes == Constant.ItemType.Item then
		LuaUtility.SetGameObjectShow(self.haveParent, true)
		UGUIUtil.SetText(self.haveNumText, WarehouseModule.GetItemNumByCfgID(itemCfg.Id))
	end
end

function BuyResItemUI:OnClickGotoBuy()
	if self.Data.isBuy == false then
		NoticeModule.ShowNotice(54001)

		return
	end

	if self.Data.buyLimitType == Constant.ShopBuyLimitType.Limit and self.Data.buyNum >= self.Data.buyLimit then
		ShopUIApi:TipNoBuyNum()

		return
	end

	ShopModule.BuyItem(self.Data, self.buyNum)
	UIModule.Close(Constant.UIControllerName.BuyResItemUI)
end

function BuyResItemUI:OnClickMin()
	self.buyNum = 1

	self:RefreshShowBuyNum()
end

function BuyResItemUI:OnClickSub()
	if self.buyNum == 1 then
		if self.islongAn == true then
			self:TimerClose()
		end

		return
	end

	self.buyNum = self.buyNum - 1

	self:RefreshShowBuyNum()
end

function BuyResItemUI:OnClickMax()
	local limitnum = 0

	if WarehouseModule.GetUseMoneyIsEnough(self.Data:GetPriceIconId(), self.unitPrice * self.canBuyNum) == false then
		local ownnum = WarehouseModule.GetItemNumByCfgID(self.Data:GetPriceIconId())

		limitnum = math.floor(ownnum / self.Data:GetPrice())

		if limitnum <= 0 then
			limitnum = 1
		end
	else
		limitnum = self.canBuyNum
	end

	if self.buyNum == limitnum then
		NoticeModule.ShowNotice(12025)
	end

	self.buyNum = limitnum

	self:RefreshShowBuyNum()
end

function BuyResItemUI:TimerClose()
	if self.timer ~= nil then
		self.timer:Stop()
	end

	self.timer = nil
end

function BuyResItemUI:OnClickLongTimer()
	if self.anButtonType == 1 then
		self:OnClickAdd()
	else
		self:OnClickSub()
	end
end

function BuyResItemUI:OnClickLongAdd()
	self.islongAn = true

	self:TimerClose()

	self.timer = Timer.New(self.OnLongTimerClicked, 0.12, -1)

	self.timer:Start()
end

function BuyResItemUI:OnClickEndAdd()
	return
end

function BuyResItemUI:OnClickDownAdd(go)
	if go.name == "addBtn" then
		self.anButtonType = 1
	else
		self.anButtonType = 2
	end
end

function BuyResItemUI:OnClickUpAdd(go)
	if self.islongAn == true then
		self.islongAn = false

		self:TimerClose()
	elseif self.anButtonType == 1 then
		self:OnClickAdd()
	else
		self:OnClickSub()
	end
end

function BuyResItemUI:OnClickAdd()
	if WarehouseModule.GetUseMoneyIsEnough(self.Data:GetPriceIconId(), self.unitPrice * (self.buyNum + 1)) == false then
		if self.islongAn == true then
			self:TimerClose()
		end

		return
	end

	if self.buyNum == self.canBuyNum then
		NoticeModule.ShowNotice(12025)

		if self.islongAn == true then
			self:TimerClose()
		end

		return
	end

	self.buyNum = self.buyNum + 1

	self:RefreshShowBuyNum()
end

function BuyResItemUI:OnClickClose()
	UIModule.Close(Constant.UIControllerName.BuyResItemUI)
end

function BuyResItemUI:OnClickSkillDetailBtn()
	UIModule.Open(Constant.UIControllerName.DetailsPreviewUI, Constant.UILayer.UI, {
		type = Constant.ItemType.Skill,
		cid = CfgItemTable[self.Data.config.ItemId].LikeId
	})
end

function BuyResItemUI:OnClickRoleDetailBtn()
	UIModule.Open(Constant.UIControllerName.DetailsPreviewUI, Constant.UILayer.UI, {
		type = Constant.ItemType.Hero,
		cid = CfgItemTable[self.Data.config.ItemId].LikeId
	})
end

function BuyResItemUI:RefreshShowBuyNum()
	UGUIUtil.SetText(self.buynumText, self.buyNum)

	if self.Data.config.Free then
		UGUIUtil.SetText(self.priceText, ShopUIApi:GetFreeText())
	else
		UGUIUtil.SetText(self.priceText, self.unitPrice * self.buyNum)
	end
end

function BuyResItemUI:ShowPanel()
	if self.Timer == nil then
		self.Timer = Timer.New(function()
			self:CheckTime()
		end, 1, -1)

		self.Timer:Start()
	end
end

function BuyResItemUI:HidePanel()
	if self.Timer then
		self.Timer:Stop()

		self.Timer = nil
	end
end

return BuyResItemUI
