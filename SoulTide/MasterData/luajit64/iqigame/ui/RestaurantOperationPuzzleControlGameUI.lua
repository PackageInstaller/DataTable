-- chunkname: @IQIGame\\UI\\RestaurantOperationPuzzleControlGameUI.lua

local RestaurantOperationPuzzleControlGameUI = {}

RestaurantOperationPuzzleControlGameUI = Base:Extend("RestaurantOperationPuzzleControlGameUI", "IQIGame.Onigao.UI.RestaurantOperationPuzzleControlGameUI", RestaurantOperationPuzzleControlGameUI)

function RestaurantOperationPuzzleControlGameUI:OnInit()
	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end
end

function RestaurantOperationPuzzleControlGameUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantOperationPuzzleControlGameUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantOperationPuzzleControlGameUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantOperationPuzzleControlGameUI:GetBGM(userData)
	return nil
end

function RestaurantOperationPuzzleControlGameUI:OnOpen(userData)
	return
end

function RestaurantOperationPuzzleControlGameUI:OnClose(userData)
	return
end

function RestaurantOperationPuzzleControlGameUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
end

function RestaurantOperationPuzzleControlGameUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
end

function RestaurantOperationPuzzleControlGameUI:OnPause()
	return
end

function RestaurantOperationPuzzleControlGameUI:OnResume()
	return
end

function RestaurantOperationPuzzleControlGameUI:OnCover()
	return
end

function RestaurantOperationPuzzleControlGameUI:OnReveal()
	return
end

function RestaurantOperationPuzzleControlGameUI:OnRefocus(userData)
	return
end

function RestaurantOperationPuzzleControlGameUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantOperationPuzzleControlGameUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantOperationPuzzleControlGameUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantOperationPuzzleControlGameUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantOperationPuzzleControlGameUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function RestaurantOperationPuzzleControlGameUI:OnClickConfirmBtn()
	UIModule.CloseSelf(self)
end

return RestaurantOperationPuzzleControlGameUI
