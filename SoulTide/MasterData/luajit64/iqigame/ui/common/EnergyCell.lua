-- chunkname: @IQIGame\\UI\\Common\\EnergyCell.lua

EnergyCell = {}

function EnergyCell.New(viewGo)
	local o = Clone(EnergyCell)

	o.ViewGo = viewGo
	o.Controller = {}

	LuaCodeInterface.BindOutlet(viewGo, o.Controller)

	function o.DelegateOnClick()
		o:OnClick()
	end

	function o.DelegateOnClickTip()
		o:OnClickTip()
	end

	function o.DelegateOnChangeValue(propName, value)
		o:OnChangeValue(propName, value)
	end

	function o.delegatePlayerInfoChanged()
		o:OnPlayerLiveChange()
	end

	function o.DelegateOnUpdateItemDebts()
		o:OnUpdateItemDebts()
	end

	o:AddEventListeners()
	o:UpdateView()

	return o
end

function EnergyCell:AddEventListeners()
	self.Controller.TipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTip)
	self.Controller.AddBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClick)
	EventDispatcher.AddEventListener(EventID.PlayerNumAttrsChange, self.DelegateOnChangeValue)
	EventDispatcher.AddEventListener(EventID.PlayerInfoChanged, self.delegatePlayerInfoChanged)
	EventDispatcher.AddEventListener(EventID.UpdateItemDebts, self.DelegateOnUpdateItemDebts)
end

function EnergyCell:RemoveEventListeners()
	self.Controller.TipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTip)
	self.Controller.AddBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClick)
	EventDispatcher.RemoveEventListener(EventID.PlayerNumAttrsChange, self.DelegateOnChangeValue)
	EventDispatcher.RemoveEventListener(EventID.PlayerInfoChanged, self.delegatePlayerInfoChanged)
	EventDispatcher.RemoveEventListener(EventID.UpdateItemDebts, self.DelegateOnUpdateItemDebts)
end

function EnergyCell:Dispose()
	self:RemoveEventListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.ViewGo, self.Controller)

	self.Controller = nil
	self.ViewGo = nil
end

function EnergyCell:OnClick()
	local cfgExchange

	for i, v in pairsCfg(CfgExchangeTable) do
		if v.GetItem == Constant.ItemID.ENERGY then
			cfgExchange = v

			break
		end
	end

	if cfgExchange then
		UIModule.Open(Constant.UIControllerName.BuyExchangePanelUI, Constant.UILayer.UI, cfgExchange)
	end
end

function EnergyCell:OnClickTip()
	UIModule.Open(Constant.UIControllerName.MoneyPanelInfoUI, Constant.UILayer.UI, {
		Constant.ItemID.ENERGY,
		self.ViewGo.transform
	})
end

function EnergyCell:OnChangeValue(id, value)
	if id == Constant.ItemID.ENERGY then
		self:UpdateView()
	end
end

function EnergyCell:OnPlayerLiveChange()
	self:UpdateView()
end

function EnergyCell:OnUpdateItemDebts()
	self:UpdateView()
end

function EnergyCell:UpdateView()
	local maxEnergy = -1

	for i, v in pairsCfg(CfgPlayerLevelTable) do
		if v.Level == PlayerModule.PlayerInfo.baseInfo.pLv then
			maxEnergy = v.EnergyMax

			break
		end
	end

	if maxEnergy == -1 then
		local tempLv = -1

		for i, v in pairsCfg(CfgPlayerLevelTable) do
			if tempLv < v.Level then
				tempLv = v.Level
				maxEnergy = v.EnergyMax
			end
		end
	end

	local iconPath = MoneyGridApi:GetString("MoneyCellIconPath", Constant.ItemID.ENERGY)

	if iconPath == "" then
		iconPath = UIGlobalApi.GetIconPath(CfgItemTable[Constant.ItemID.ENERGY].Icon)
	end

	AssetUtil.LoadImage(self, iconPath, self.Controller.Icon:GetComponent("Image"))
	UGUIUtil.SetText(self.Controller.ValueText, MoneyGridApi:GetString("ValueMaxValueText", WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ENERGY, true), maxEnergy))
end
