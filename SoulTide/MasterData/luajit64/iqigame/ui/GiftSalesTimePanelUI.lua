-- chunkname: @IQIGame\\UI\\GiftSalesTimePanelUI.lua

local GiftSalesTimePanelUI = {
	limitTimeMalls = {},
	giftSalesTimeCells = {}
}

GiftSalesTimePanelUI = Base:Extend("GiftSalesTimePanelUI", "IQIGame.Onigao.UI.GiftSalesTimePanelUI", GiftSalesTimePanelUI)

require("IQIGame.UIExternalApi.GiftSalesTimePanelUIApi")

local GiftSalesTimeCell = require("IQIGame.UI.GiftSalesTimePanel.GiftSalesTimeCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function GiftSalesTimePanelUI:OnInit()
	UGUIUtil.SetText(self.TextTitle, GiftSalesTimePanelUIApi:GetString("TextTitle"))

	function self.DelegateCloseBtn()
		self:OnCloseBtn()
	end

	function self.DelegatePurchaseTipEvent()
		self:OnPurchaseTipEvent()
	end

	self.GiftSaleMould:SetActive(false)

	self.giftSalesTimeCellPool = UIObjectPool.New(6, function()
		return GiftSalesTimeCell.New(UnityEngine.Object.Instantiate(self.GiftSaleMould))
	end, function(cell)
		cell:Dispose()
	end)
end

function GiftSalesTimePanelUI:GetPreloadAssetPaths()
	return nil
end

function GiftSalesTimePanelUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GiftSalesTimePanelUI:IsManualShowOnOpen(userData)
	return false
end

function GiftSalesTimePanelUI:GetBGM(userData)
	return nil
end

function GiftSalesTimePanelUI:OnOpen(userData)
	self:UpdateView()
end

function GiftSalesTimePanelUI:OnClose(userData)
	return
end

function GiftSalesTimePanelUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:AddListener(self.DelegateCloseBtn)
	EventDispatcher.AddEventListener(EventID.PurchaseTipEvent, self.DelegatePurchaseTipEvent)
end

function GiftSalesTimePanelUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:RemoveListener(self.DelegateCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.PurchaseTipEvent, self.DelegatePurchaseTipEvent)
end

function GiftSalesTimePanelUI:OnPause()
	return
end

function GiftSalesTimePanelUI:OnResume()
	return
end

function GiftSalesTimePanelUI:OnCover()
	return
end

function GiftSalesTimePanelUI:OnReveal()
	return
end

function GiftSalesTimePanelUI:OnRefocus(userData)
	return
end

function GiftSalesTimePanelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GiftSalesTimePanelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GiftSalesTimePanelUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GiftSalesTimePanelUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GiftSalesTimePanelUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.giftSalesTimeCells) do
		self.giftSalesTimeCellPool:Release(v)
	end

	self.giftSalesTimeCells = {}

	self.giftSalesTimeCellPool:Dispose()
end

function GiftSalesTimePanelUI:OnCloseBtn()
	UIModule.CloseSelf(self)
end

function GiftSalesTimePanelUI:OnPurchaseTipEvent()
	self:UpdateView()
end

function GiftSalesTimePanelUI:UpdateView()
	self.limitTimeMalls = {}

	for i, v in pairs(PurchaseTipModule.purchaseTipList) do
		if v.Type == 3 then
			table.insert(self.limitTimeMalls, v)
		end
	end

	table.sort(self.limitTimeMalls, function(a, b)
		return a.Order < b.Order
	end)

	for i, v in pairs(self.giftSalesTimeCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.giftSalesTimeCellPool:Release(v)
	end

	self.giftSalesTimeCells = {}

	for i = 1, #self.limitTimeMalls do
		local cfgData = self.limitTimeMalls[i]
		local cell = self.giftSalesTimeCellPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.ContentNode.transform, false)
		cell:SetData(cfgData)
		table.insert(self.giftSalesTimeCells, cell)
	end
end

return GiftSalesTimePanelUI
