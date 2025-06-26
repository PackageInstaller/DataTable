-- chunkname: @IQIGame\\UI\\Shop\\SecondaryTapItem.lua

local SecondaryTapItem = {}

function SecondaryTapItem.New(go, isRecommend)
	local o = Clone(SecondaryTapItem)

	o:Initialize(go, isRecommend)

	return o
end

function SecondaryTapItem:Initialize(go, isRecommend)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.isRecommend = isRecommend

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
	self:SetSelect(false)
	self:SetRedDotState(false)
end

function SecondaryTapItem:InitComponent()
	self.buttonClick = self.buttonClick:GetComponent("Button")
end

function SecondaryTapItem:InitDelegate()
	function self.buttonClickDelegate()
		self:OnButtonClick()
	end

	function self.OnNotifyChangeShopItemsSucceedDelegate()
		self:OnNotifyChangeShopItems()
	end
end

function SecondaryTapItem:AddListener()
	self.buttonClick.onClick:AddListener(self.buttonClickDelegate)
	EventDispatcher.AddEventListener(EventID.NotifyChangeShopItems, self.OnNotifyChangeShopItemsSucceedDelegate)
end

function SecondaryTapItem:RemoveListener()
	self.buttonClick.onClick:RemoveListener(self.buttonClickDelegate)
	EventDispatcher.RemoveEventListener(EventID.NotifyChangeShopItems, self.OnNotifyChangeShopItemsSucceedDelegate)
end

function SecondaryTapItem:OnButtonClick()
	if self.isRecommend then
		EventDispatcher.Dispatch(EventID.ShopUIRecommendSecondaryTagClickEvent, self)
	else
		EventDispatcher.Dispatch(EventID.ShopUISecondaryTagClickEvent, self)
	end
end

function SecondaryTapItem:OnNotifyChangeShopItems()
	self:RefreshRedDot()
end

function SecondaryTapItem:Show(show)
	LuaUtility.SetGameObjectShow(self.gameObject, show)
end

function SecondaryTapItem:GetIsShow()
	return self.gameObject.activeSelf
end

function SecondaryTapItem:SetSelect(isSelect)
	LuaUtility.SetGameObjectShow(self.gameObjectCheck, isSelect)
	LuaUtility.SetGameObjectShow(self.gameObjectNormal, not isSelect)
end

function SecondaryTapItem:ResetShow()
	LuaUtility.SetGameObjectShow(self.gameObjectCheck, false)
end

function SecondaryTapItem:Refresh(Data)
	self.Data = Data

	local shopCfg = CfgShopTable[self.Data]

	self:SetSelect(false)

	if self.isRecommend then
		local recommendData = self.Data

		LuaUtility.SetGameObjectShow(self.imageTimeLimit, false)
		LuaUtility.SetGameObjectShow(self.imageNew, false)
		LuaUtility.SetGameObjectShow(self.objectDiscount, false)
		LuaUtility.SetGameObjectShow(self.objectCheckDiscount, false)

		if self.Data.isMonthCard then
			UGUIUtil.SetText(self.textCheckName, recommendData.name)
			UGUIUtil.SetText(self.textNormalName, recommendData.name)
		else
			local mItemData = ItemData.CreateByCIDAndNumber(recommendData.config.ItemId, 0)

			UGUIUtil.SetText(self.textNormalName, mItemData:GetCfg().Name)
			UGUIUtil.SetText(self.textCheckName, mItemData:GetCfg().Name)

			if recommendData.config.OpenTime and recommendData.config.CloseTime and recommendData.config.OpenTime ~= "" and recommendData.config.OpenTime ~= "" then
				LuaUtility.SetGameObjectShow(self.imageTimeLimit, true)
			end

			if recommendData.config.Free then
				-- block empty
			elseif recommendData.isDiscount then
				LuaUtility.SetGameObjectShow(self.objectDiscount, true)
				LuaUtility.SetGameObjectShow(self.objectCheckDiscount, true)
				LuaUtility.SetText(self.textDiscount, recommendData:GetDiscountPercentText())
				LuaUtility.SetText(self.textCheckDiscount, recommendData:GetDiscountPercentText())
			end
		end
	else
		local ShopIdData = self.Data
		local cfgShopData = ShopModule.GetShopCfgWithID(ShopIdData)

		UGUIUtil.SetText(self.textNormalName, cfgShopData.TagName)
		UGUIUtil.SetText(self.textCheckName, cfgShopData.TagName)
		LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(shopCfg.NormaToggleImg), self.normalImg:GetComponent("Image"))
		LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(shopCfg.CheckToggleImg), self.checkImg:GetComponent("Image"))
	end

	self:RefreshRedDot()
end

function SecondaryTapItem:RefreshRedDot()
	local commodityDatas = ShopModule.GetSortForTypeDataList(self.Data)

	self:SetRedDotState(ShopModule.GetHasFreeCommodity(commodityDatas))
end

function SecondaryTapItem:SetRedDotState(state)
	LuaUtility.SetGameObjectShow(self.RedDot, state)
end

function SecondaryTapItem:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return SecondaryTapItem
