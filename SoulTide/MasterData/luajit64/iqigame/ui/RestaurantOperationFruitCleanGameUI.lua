-- chunkname: @IQIGame\\UI\\RestaurantOperationFruitCleanGameUI.lua

local RestaurantOperationFruitCleanGameUI = {}

RestaurantOperationFruitCleanGameUI = Base:Extend("RestaurantOperationFruitCleanGameUI", "IQIGame.Onigao.UI.RestaurantOperationFruitCleanGameUI", RestaurantOperationFruitCleanGameUI)

function RestaurantOperationFruitCleanGameUI:OnInit()
	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end
end

function RestaurantOperationFruitCleanGameUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantOperationFruitCleanGameUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantOperationFruitCleanGameUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantOperationFruitCleanGameUI:GetBGM(userData)
	return nil
end

function RestaurantOperationFruitCleanGameUI:OnOpen(userData)
	return
end

function RestaurantOperationFruitCleanGameUI:OnClose(userData)
	return
end

function RestaurantOperationFruitCleanGameUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
end

function RestaurantOperationFruitCleanGameUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
end

function RestaurantOperationFruitCleanGameUI:OnPause()
	return
end

function RestaurantOperationFruitCleanGameUI:OnResume()
	return
end

function RestaurantOperationFruitCleanGameUI:OnCover()
	return
end

function RestaurantOperationFruitCleanGameUI:OnReveal()
	return
end

function RestaurantOperationFruitCleanGameUI:OnRefocus(userData)
	return
end

function RestaurantOperationFruitCleanGameUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantOperationFruitCleanGameUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantOperationFruitCleanGameUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantOperationFruitCleanGameUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantOperationFruitCleanGameUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function RestaurantOperationFruitCleanGameUI:OnClickConfirmBtn()
	UIModule.CloseSelf(self)
end

return RestaurantOperationFruitCleanGameUI
