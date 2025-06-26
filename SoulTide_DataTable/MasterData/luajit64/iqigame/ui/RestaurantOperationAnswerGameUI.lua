-- chunkname: @IQIGame\\UI\\RestaurantOperationAnswerGameUI.lua

local RestaurantOperationAnswerGameUI = {}

RestaurantOperationAnswerGameUI = Base:Extend("RestaurantOperationAnswerGameUI", "IQIGame.Onigao.UI.RestaurantOperationAnswerGameUI", RestaurantOperationAnswerGameUI)

function RestaurantOperationAnswerGameUI:OnInit()
	function self.DelegateOnBtnClose()
		self:OnBtnClose()
	end
end

function RestaurantOperationAnswerGameUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantOperationAnswerGameUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantOperationAnswerGameUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantOperationAnswerGameUI:GetBGM(userData)
	return nil
end

function RestaurantOperationAnswerGameUI:OnOpen(userData)
	return
end

function RestaurantOperationAnswerGameUI:OnClose(userData)
	return
end

function RestaurantOperationAnswerGameUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnClose)
end

function RestaurantOperationAnswerGameUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnClose)
end

function RestaurantOperationAnswerGameUI:OnPause()
	return
end

function RestaurantOperationAnswerGameUI:OnResume()
	return
end

function RestaurantOperationAnswerGameUI:OnCover()
	return
end

function RestaurantOperationAnswerGameUI:OnReveal()
	return
end

function RestaurantOperationAnswerGameUI:OnRefocus(userData)
	return
end

function RestaurantOperationAnswerGameUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantOperationAnswerGameUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantOperationAnswerGameUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantOperationAnswerGameUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantOperationAnswerGameUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function RestaurantOperationAnswerGameUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

return RestaurantOperationAnswerGameUI
