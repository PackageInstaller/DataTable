-- chunkname: @IQIGame\\UI\\RestaurantOperationCardListGameUI.lua

local RestaurantOperationCardListGameUI = {}

RestaurantOperationCardListGameUI = Base:Extend("RestaurantOperationCardListGameUI", "IQIGame.Onigao.UI.RestaurantOperationCardListGameUI", RestaurantOperationCardListGameUI)

function RestaurantOperationCardListGameUI:OnInit()
	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end
end

function RestaurantOperationCardListGameUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantOperationCardListGameUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantOperationCardListGameUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantOperationCardListGameUI:GetBGM(userData)
	return nil
end

function RestaurantOperationCardListGameUI:OnOpen(userData)
	return
end

function RestaurantOperationCardListGameUI:OnClose(userData)
	return
end

function RestaurantOperationCardListGameUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
end

function RestaurantOperationCardListGameUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
end

function RestaurantOperationCardListGameUI:OnPause()
	return
end

function RestaurantOperationCardListGameUI:OnResume()
	return
end

function RestaurantOperationCardListGameUI:OnCover()
	return
end

function RestaurantOperationCardListGameUI:OnReveal()
	return
end

function RestaurantOperationCardListGameUI:OnRefocus(userData)
	return
end

function RestaurantOperationCardListGameUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantOperationCardListGameUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantOperationCardListGameUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantOperationCardListGameUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantOperationCardListGameUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function RestaurantOperationCardListGameUI:OnClickConfirmBtn()
	UIModule.CloseSelf(self)
end

return RestaurantOperationCardListGameUI
