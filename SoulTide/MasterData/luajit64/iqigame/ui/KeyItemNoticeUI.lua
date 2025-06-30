-- chunkname: @IQIGame\\UI\\KeyItemNoticeUI.lua

local KeyItemNoticeUI = Base:Extend("KeyItemNoticeUI", "IQIGame.Onigao.UI.KeyItemNoticeUI", {})

function KeyItemNoticeUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnCloseBigFloatNoticeUI()
		self:OnCloseBigFloatNoticeUI()
	end

	self.TitleText:GetComponent("Text").text = KeyItemNoticeUIApi:GetString("TitleText")

	local go = UnityEngine.Object.Instantiate(self.UIController:GetPreloadedAsset(UIGlobalApi.GetItemCellAssetPath()))

	go.transform:SetParent(self.ItemCellParent.transform, false)

	self.ItemCell = ItemCell.New(go, false)
end

function KeyItemNoticeUI:GetPreloadAssetPaths()
	return {
		UIGlobalApi.GetItemCellAssetPath()
	}
end

function KeyItemNoticeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function KeyItemNoticeUI:OnOpen(userData)
	self.MainPanel.transform:SetParent(self["Pos" .. userData.index].transform, false)

	local cfgItemData = CfgItemTable[userData.itemCid]

	self.ItemNameText:GetComponent("Text").text = KeyItemNoticeUIApi:GetString("ItemNameText", cfgItemData.Name)
	self.ItemDescText:GetComponent("Text").text = KeyItemNoticeUIApi:GetString("ItemDescText", cfgItemData.Describe)

	self.ItemCell:SetItemByCID(cfgItemData.Id, 1)

	self.DelayCloseTimer = Timer.New(function()
		self.DelayCloseTimer = nil

		UIModule.Close(Constant.UIControllerName.KeyItemNoticeUI)
	end, 3)

	self.DelayCloseTimer:Start()
end

function KeyItemNoticeUI:OnClose(userData)
	self:StopDelayCloseTimer()
end

function KeyItemNoticeUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.AddEventListener(EventID.CloseBigFloatNoticeUI, self.DelegateOnCloseBigFloatNoticeUI)
end

function KeyItemNoticeUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.CloseBigFloatNoticeUI, self.DelegateOnCloseBigFloatNoticeUI)
end

function KeyItemNoticeUI:OnPause()
	return
end

function KeyItemNoticeUI:OnResume()
	return
end

function KeyItemNoticeUI:OnCover()
	return
end

function KeyItemNoticeUI:OnReveal()
	return
end

function KeyItemNoticeUI:OnRefocus(userData)
	return
end

function KeyItemNoticeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function KeyItemNoticeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function KeyItemNoticeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function KeyItemNoticeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function KeyItemNoticeUI:OnDestroy()
	self.ItemCell:Dispose()
end

function KeyItemNoticeUI:StopDelayCloseTimer()
	if self.DelayCloseTimer ~= nil then
		self.DelayCloseTimer:Stop()

		self.DelayCloseTimer = nil
	end
end

function KeyItemNoticeUI:OnClickCloseBtn()
	EventDispatcher.Dispatch(EventID.CloseBigFloatNoticeUI)
end

function KeyItemNoticeUI:OnCloseBigFloatNoticeUI()
	self:StopDelayCloseTimer()
	UIModule.Close(Constant.UIControllerName.KeyItemNoticeUI)
end

return KeyItemNoticeUI
