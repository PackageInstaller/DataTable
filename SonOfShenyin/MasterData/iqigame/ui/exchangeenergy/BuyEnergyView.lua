-- chunkname: @IQIGame\\UI\\ExChangeEnergy\\BuyEnergyView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateBuyItemResultEvent()
		self:BuyItemResultEvent()
	end

	self:InitShowInfo()
	self:AddListeners()
end

function m:AddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	EventDispatcher.AddEventListener(EventID.BuyItemResult, self.DelegateBuyItemResultEvent)
end

function m:RemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	EventDispatcher.RemoveEventListener(EventID.BuyItemResult, self.DelegateBuyItemResultEvent)
end

function m:InitShowInfo()
	self.IconCell = ItemCell.New(self.Icon, false)

	self.IconCell:SetItem(ItemData.CreateByCIDAndNumber(Constant.ItemCid.NORMAL_MONEY, 0))

	self.EnergyCell = ItemCell.New(self.EnergyImg, false)

	self.EnergyCell:SetItem(ItemData.CreateByCIDAndNumber(Constant.ItemCid.STRENGTH, 0))
	UGUIUtil.SetText(self.IconName, CfgItemTable[Constant.ItemCid.NORMAL_MONEY].Name)
	UGUIUtil.SetText(self.EnergyName, CfgItemTable[Constant.ItemCid.STRENGTH].Name)
	UGUIUtil.SetText(self.Text, BuyEnergyUIApi:GetBuyCountTitle())
	UGUIUtil.SetTextsInChildren(self.ConfirmBtn, BuyEnergyUIApi:GetConfrimButtonText())
end

function m:SetData()
	self.shopData = ShopModule.GetShopDataWithShopID(15)
	self.shopItemData = self.shopData.itemDic[1]
	self.shopItemCfg = self.shopItemData.config
	self.isMaxBuyCount = self.shopItemData.buyNum >= self.shopItemCfg.Time

	local curBuyPrice = self.shopItemData.buyNum >= self.shopItemCfg.Time and self.shopItemCfg.Price[#self.shopItemCfg.Price] or self.shopItemCfg.Price[self.shopItemData.buyNum + 1]

	self.NeedMoneyCid = curBuyPrice[1]
	self.NeedMoneyCount = curBuyPrice[2]

	UGUIUtil.SetText(self.MoneyNumText, curBuyPrice[2])
	UGUIUtil.SetText(self.EnergyNum, self.shopItemCfg.Number)
	UGUIUtil.SetText(self.RestNum, self.shopItemData.buyNum)
	UGUIUtil.SetText(self.AllNum, "/" .. self.shopItemCfg.Time)
	UGUIUtil.SetText(self.TipText, BuyEnergyUIApi:GetBuyTips(self.NeedMoneyCount, self.shopItemCfg.Number))
	LuaUtility.SetTransGameObjectShow(self.CanBuyParent.transform, not self.isMaxBuyCount)
	LuaUtility.SetTransGameObjectShow(self.CanNotBuyParent.transform, self.isMaxBuyCount)
end

function m:OnClickConfirmBtn()
	if self.isMaxBuyCount then
		NoticeModule.ShowNotice(12016)

		return
	end

	if WarehouseModule.GetItemNumByCfgID(self.NeedMoneyCid) < self.NeedMoneyCount then
		NoticeModule.ShowNotice(12017)

		return
	end

	ShopModule.BuyItemRequest(self.shopItemData.cid, 1)
end

function m:BuyItemResultEvent()
	self:SetData()
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Dispose()
	self:RemoveListeners()
	self.IconCell:Dispose()
	self.EnergyCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
