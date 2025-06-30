-- chunkname: @IQIGame\\UI\\Bag\\MazeCurrencyCell.lua

MazeCurrencyCell = {
	CurrencyCID = 0,
	ClientOccupiedCurrency = 0
}

function MazeCurrencyCell.New(viewGo, currencyCid)
	local o = Clone(MazeCurrencyCell)

	o.CurrencyCID = currencyCid
	o.ViewGo = viewGo
	o.View = {}

	LuaCodeInterface.BindOutlet(viewGo, o.View)

	function o.DelegateOnClick()
		o:OnClick()
	end

	function o.DelegateOnClickTip()
		o:OnClickTip()
	end

	function o.DelegateOnUpdateItem()
		o:OnUpdateItem()
	end

	function o.DelegateOnUpdateNumAttr()
		o:OnUpdateNumAttr()
	end

	o:AddEventListeners()
	o:UpdateView()

	return o
end

function MazeCurrencyCell:AddEventListeners()
	if self.View.AddBtn ~= nil then
		self.View.AddBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClick)
	end

	if self.View.TipBtn then
		self.View.TipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTip)
	end

	EventDispatcher.AddEventListener(EventID.MazeUpdateItem, self.DelegateOnUpdateItem)
	EventDispatcher.AddEventListener(EventID.MazeUpdateNumAttr, self.DelegateOnUpdateNumAttr)
end

function MazeCurrencyCell:RemoveEventListeners()
	if self.View.AddBtn ~= nil then
		self.View.AddBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClick)
	end

	if self.View.TipBtn then
		self.View.TipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTip)
	end

	EventDispatcher.RemoveEventListener(EventID.MazeUpdateItem, self.DelegateOnUpdateItem)
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateNumAttr, self.DelegateOnUpdateNumAttr)
end

function MazeCurrencyCell:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveEventListeners()
	LuaCodeInterface.ClearOutlet(self.ViewGo, self.View)

	self.View = nil
	self.ViewGo = nil
end

function MazeCurrencyCell:OnClick()
	if self.CurrencyCID == Constant.ItemID.TREASURE then
		UIModule.Open(Constant.UIControllerName.BuyMallPanelUI, Constant.UILayer.UI)
	elseif self.ItemCID == Constant.ItemID.ID_PAYPOINT_SHOW then
		JumpModule.Jump(10202004)
	else
		local cfgExchange

		for i, v in pairsCfg(CfgExchangeTable) do
			if v.GetItem == self.CurrencyCID then
				cfgExchange = v

				break
			end
		end

		if cfgExchange then
			UIModule.Open(Constant.UIControllerName.BuyExchangePanelUI, Constant.UILayer.UI, cfgExchange)
		end
	end
end

function MazeCurrencyCell:OnClickTip()
	UIModule.Open(Constant.UIControllerName.MoneyPanelInfoUI, Constant.UILayer.UI, {
		self.CurrencyCID,
		self.ViewGo.transform
	})
end

function MazeCurrencyCell:OnUpdateItem()
	self:UpdateNum()
end

function MazeCurrencyCell:OnUpdateNumAttr()
	self:UpdateNum()
end

function MazeCurrencyCell:UpdateView()
	local iconPath = MoneyGridApi:GetString("MoneyCellIconPath", self.CurrencyCID)

	if iconPath == "" then
		iconPath = UIGlobalApi.GetIconPath(CfgItemTable[self.CurrencyCID].Icon)
	end

	AssetUtil.LoadImage(self, iconPath, self.View.Icon:GetComponent("Image"))
	self:UpdateNum()

	local canBuy = WarehouseModule.CheckCurrencyCanBuy(self.ItemCID)

	if self.View.AddBtn ~= nil then
		self.View.AddBtn:SetActive(canBuy)
	end

	if self.View.CanBuyView ~= nil and self.View.CanNotBuyView ~= nil then
		self.View.CanBuyView:SetActive(canBuy)
		self.View.CanNotBuyView:SetActive(not canBuy)
	end
end

function MazeCurrencyCell:UpdateNum()
	self.View.ValueText:GetComponent("Text").text = tostring(self:GetItemNum())
end

function MazeCurrencyCell:GetItemNum()
	return MazeDataModule.GetItemNumByCfgID(self.CurrencyCID) - self.ClientOccupiedCurrency
end

function MazeCurrencyCell:SetClientOccupiedCurrency(value)
	self.ClientOccupiedCurrency = value

	self:UpdateNum()
end
