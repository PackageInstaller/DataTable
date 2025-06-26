-- chunkname: @IQIGame\\UI\\Bag\\CurrencyCell.lua

CurrencyCell = {
	ItemCID = 0
}

function CurrencyCell.New(viewGo, itemCid)
	local o = Clone(CurrencyCell)

	o.ItemCID = itemCid
	o.ViewGo = viewGo
	o.View = {}

	LuaCodeInterface.BindOutlet(viewGo, o.View)

	function o.DelegateOnClick()
		o:OnClick()
	end

	function o.DelegateOnClickTip()
		o:OnClickTip()
	end

	function o.DelegateNumAttrOnChangeValue(key, value)
		o:OnNumAttrChangeValue(key, value)
	end

	function o.DelegateItemOnChangeValue(value)
		o:OnItemChangeValue(value)
	end

	function o.DelegateOnUpdateItemDebts()
		o:OnUpdateItemDebts()
	end

	function o.DelegatePlayerSomeInfoChange(key, value)
		o:OnPlayerSomeInfoChange(key, value)
	end

	o:AddEventListeners()

	if itemCid ~= nil then
		o:SetData(itemCid)
	end

	return o
end

function CurrencyCell:AddEventListeners()
	if self.View.AddBtn ~= nil then
		self.View.AddBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClick)
	end

	self.View.TipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTip)
	EventDispatcher.AddEventListener(EventID.PlayerNumAttrsChange, self.DelegateNumAttrOnChangeValue)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateItemOnChangeValue)
	EventDispatcher.AddEventListener(EventID.PlayerSomeInfoChange, self.DelegatePlayerSomeInfoChange)
	EventDispatcher.AddEventListener(EventID.UpdateItemDebts, self.DelegateOnUpdateItemDebts)
end

function CurrencyCell:RemoveEventListeners()
	if self.View.AddBtn ~= nil then
		self.View.AddBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClick)
	end

	self.View.TipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTip)
	EventDispatcher.RemoveEventListener(EventID.PlayerNumAttrsChange, self.DelegateNumAttrOnChangeValue)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateItemOnChangeValue)
	EventDispatcher.RemoveEventListener(EventID.PlayerSomeInfoChange, self.DelegatePlayerSomeInfoChange)
	EventDispatcher.RemoveEventListener(EventID.UpdateItemDebts, self.DelegateOnUpdateItemDebts)
end

function CurrencyCell:SetData(itemCid)
	self.ItemCID = itemCid

	local cfgItemData = CfgItemTable[self.ItemCID]

	if cfgItemData == nil then
		logError("cfgItemData is nil. itemCid: " .. tostring(itemCid))

		return
	end

	if self.View.Icon == nil then
		logError("self.View.Icon is nil.")

		return
	end

	local iconPath = MoneyGridApi:GetString("MoneyCellIconPath", self.ItemCID)

	if iconPath == "" then
		iconPath = UIGlobalApi.GetIconPath(CfgItemTable[self.ItemCID].Icon)
	end

	AssetUtil.LoadImage(self, iconPath, self.View.Icon:GetComponent("Image"))
	self:UpdateView()
end

function CurrencyCell:Dispose()
	self:RemoveEventListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.ViewGo, self.View)

	self.View = nil
	self.ViewGo = nil
end

function CurrencyCell:OnClick()
	if self.ItemCID == Constant.ItemID.TREASURE then
		UIModule.Open(Constant.UIControllerName.BuyMallPanelUI, Constant.UILayer.UI)
	elseif self.ItemCID == Constant.ItemID.ID_PAYPOINT_SHOW then
		JumpModule.Jump(10202004)
	else
		local cfgExchange

		for i, v in pairsCfg(CfgExchangeTable) do
			if v.GetItem == self.ItemCID then
				cfgExchange = v

				break
			end
		end

		if cfgExchange then
			UIModule.Open(Constant.UIControllerName.BuyExchangePanelUI, Constant.UILayer.UI, cfgExchange)
		end
	end
end

function CurrencyCell:OnClickTip()
	UIModule.Open(Constant.UIControllerName.MoneyPanelInfoUI, Constant.UILayer.UI, {
		self.ItemCID,
		self.ViewGo.transform
	})
end

function CurrencyCell:OnNumAttrChangeValue(key, value)
	if self.ItemCID == key then
		self:UpdateView()
	end
end

function CurrencyCell:OnItemChangeValue(value)
	for i = 1, #value do
		if self.ItemCID == value[i].cid then
			self:UpdateView()

			break
		end
	end
end

function CurrencyCell:OnUpdateItemDebts()
	self:UpdateView()
end

function CurrencyCell:OnPlayerSomeInfoChange(key, value)
	if key == "payPoint" then
		self:UpdateView()
	end
end

function CurrencyCell:UpdateView()
	if self.View.ValueText ~= nil then
		if self.ItemCID == Constant.ItemID.VACATION_TIME then
			self.View.ValueText:GetComponent("Text").text = MoneyGridApi:GetString("ValueMaxValueText", WarehouseModule.GetItemNumByCfgID(self.ItemCID, true), CfgPlayerLevelTable[PlayerModule.PlayerInfo.baseInfo.pLv].RestTime)
		elseif self.ItemCID == Constant.ItemID.ID_PAYPOINT_SHOW then
			local num = PlayerModule.PlayerInfo.baseInfo.payPoint
			local debt = PlayerModule.PlayerInfo.itemDebts[self.ItemCID]

			if debt ~= nil then
				num = num - debt
			end

			self.View.ValueText:GetComponent("Text").text = MoneyGridApi:GetString("ValueText", num)
		else
			self.View.ValueText:GetComponent("Text").text = MoneyGridApi:GetString("ValueText", WarehouseModule.GetItemNumByCfgID(self.ItemCID, true))
		end
	end

	local canBuy = WarehouseModule.CheckCurrencyCanBuy(self.ItemCID)

	if self.View.AddBtn ~= nil then
		self.View.AddBtn:SetActive(canBuy)
	end

	if self.View.CanBuyView ~= nil and self.View.CanNotBuyView ~= nil then
		self.View.CanBuyView:SetActive(canBuy)
		self.View.CanNotBuyView:SetActive(not canBuy)
	end
end
