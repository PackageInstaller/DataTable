-- chunkname: @IQIGame\\UI\\PlaceGameBagUI.lua

local PlaceGameBagUI = {
	showChildViewIndex = 1,
	moneyCellPool = {}
}

PlaceGameBagUI = Base:Extend("PlaceGameBagUI", "IQIGame.Onigao.UI.PlaceGameBagUI", PlaceGameBagUI)

require("IQIGame.UIExternalApi.PlaceGameBagUIApi")

local PlaceGameBagView = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameBag.PlaceGameBagView")
local PlaceGameBagExchangeView = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameBag.PlaceGameBagExchangeView")

function PlaceGameBagUI:OnInit()
	function self.DelegateBtnClose()
		self:OnBtnClose()
	end

	function self.DelegateToggleEquip(isOn)
		self:OnToggleEquip(isOn)
	end

	function self.DelegateToggleExchange(isOn)
		self:OnToggleExchange(isOn)
	end

	self.placeGameBagView = PlaceGameBagView.New(self.goBagView)
	self.placeGameExchangeView = PlaceGameBagExchangeView.New(self.goExchangeView)

	local cfgControlData = CfgPlaceGameControlTable[PlaceGameModule.GlobalCid]

	self.TicketMould:SetActive(false)

	for i = 1, #cfgControlData.MoneyId do
		local moneyID = cfgControlData.MoneyId[i]
		local moneyObj = UnityEngine.Object.Instantiate(self.TicketMould)

		moneyObj:SetActive(true)
		moneyObj.transform:SetParent(self.TicketNode.transform, false)

		local moneyCell = CurrencyCell.New(moneyObj, moneyID)

		table.insert(self.moneyCellPool, moneyCell)
	end
end

function PlaceGameBagUI:GetPreloadAssetPaths()
	return nil
end

function PlaceGameBagUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PlaceGameBagUI:IsManualShowOnOpen(userData)
	return false
end

function PlaceGameBagUI:GetBGM(userData)
	return nil
end

function PlaceGameBagUI:OnOpen(userData)
	self.showChildViewIndex = 1
	self.toggleEquip:GetComponent("Toggle").isOn = true

	self:UpdateView()
end

function PlaceGameBagUI:OnClose(userData)
	self.placeGameBagView:Close()
	self.placeGameExchangeView:Close()
end

function PlaceGameBagUI:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
	self.toggleEquip:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateToggleEquip)
	self.toggleExchange:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateToggleExchange)
end

function PlaceGameBagUI:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
	self.toggleEquip:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateToggleEquip)
	self.toggleExchange:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateToggleExchange)
end

function PlaceGameBagUI:OnPause()
	return
end

function PlaceGameBagUI:OnResume()
	return
end

function PlaceGameBagUI:OnCover()
	return
end

function PlaceGameBagUI:OnReveal()
	return
end

function PlaceGameBagUI:OnRefocus(userData)
	return
end

function PlaceGameBagUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PlaceGameBagUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PlaceGameBagUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PlaceGameBagUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PlaceGameBagUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.placeGameBagView:Dispose()
	self.placeGameExchangeView:Dispose()

	for i, v in pairs(self.moneyCellPool) do
		v:Dispose()
	end
end

function PlaceGameBagUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

function PlaceGameBagUI:OnToggleEquip(isOn)
	if isOn then
		self.showChildViewIndex = 1

		self:RefreshChildView()
	end
end

function PlaceGameBagUI:OnToggleExchange(isOn)
	if isOn then
		self.showChildViewIndex = 2

		self:RefreshChildView()
	end
end

function PlaceGameBagUI:UpdateView()
	self:RefreshChildView()
end

function PlaceGameBagUI:RefreshChildView()
	if self.showChildViewIndex == 1 then
		self.placeGameBagView:Open()
	else
		self.placeGameBagView:Close()
	end

	if self.showChildViewIndex == 2 then
		self.placeGameExchangeView:Open()
	else
		self.placeGameExchangeView:Close()
	end
end

return PlaceGameBagUI
