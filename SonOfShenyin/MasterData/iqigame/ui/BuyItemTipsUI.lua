-- chunkname: @IQIGame\\UI\\BuyItemTipsUI.lua

local BuyItemTipsUI = {}

BuyItemTipsUI = Base:Extend("BuyItemTipsUI", "IQIGame.Onigao.UI.BuyItemTipsUI", BuyItemTipsUI)

function BuyItemTipsUI:OnInit()
	function self.DelegateCancelBtn()
		self:OnCancelBtnClick()
	end

	function self.DelegateConfrimBtn()
		self:OnConfrimBtnClick()
	end
end

function BuyItemTipsUI:GetPreloadAssetPaths()
	return nil
end

function BuyItemTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BuyItemTipsUI:IsManualShowOnOpen(userData)
	return false
end

function BuyItemTipsUI:GetBGM(userData)
	return nil
end

function BuyItemTipsUI:OnOpen(args)
	self.ItemCid = args[1]

	self:RefreshMisc()
end

function BuyItemTipsUI:OnClose(userData)
	return
end

function BuyItemTipsUI:OnAddListeners()
	self.ButtonCancel:GetComponent("Button").onClick:AddListener(self.DelegateCancelBtn)
	self.ButtonConfirm:GetComponent("Button").onClick:AddListener(self.DelegateConfrimBtn)
end

function BuyItemTipsUI:OnRemoveListeners()
	self.ButtonCancel:GetComponent("Button").onClick:RemoveListener(self.DelegateCancelBtn)
	self.ButtonConfirm:GetComponent("Button").onClick:RemoveListener(self.DelegateConfrimBtn)
end

function BuyItemTipsUI:OnPause()
	return
end

function BuyItemTipsUI:OnResume()
	return
end

function BuyItemTipsUI:OnCover()
	return
end

function BuyItemTipsUI:OnReveal()
	return
end

function BuyItemTipsUI:OnRefocus(userData)
	return
end

function BuyItemTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function BuyItemTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BuyItemTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BuyItemTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BuyItemTipsUI:OnDestroy()
	return
end

function BuyItemTipsUI:RefreshMisc()
	UGUIUtil.SetText(self.ItemNameText, CfgItemTable[self.ItemCid].Name)
end

function BuyItemTipsUI:OnCancelBtnClick()
	UIModule.CloseSelf(self)
end

function BuyItemTipsUI:OnConfrimBtnClick()
	self:OnCancelBtnClick()
	UIModule.Open(Constant.UIControllerName.ShopUI, Constant.UILayer.UI, {
		enterType = Constant.ShopEnterType.Normal
	})
end

return BuyItemTipsUI
