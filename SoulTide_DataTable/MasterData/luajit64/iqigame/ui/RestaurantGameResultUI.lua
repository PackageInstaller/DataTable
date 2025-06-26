-- chunkname: @IQIGame\\UI\\RestaurantGameResultUI.lua

local RestaurantGameResultUI = {}

RestaurantGameResultUI = Base:Extend("RestaurantGameResultUI", "IQIGame.Onigao.UI.RestaurantGameResultUI", RestaurantGameResultUI)

function RestaurantGameResultUI:OnInit()
	function self.DelegateOnClickBtnBack()
		self:OnClickBtnBack()
	end
end

function RestaurantGameResultUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantGameResultUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantGameResultUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantGameResultUI:GetBGM(userData)
	return nil
end

function RestaurantGameResultUI:OnOpen(userData)
	local success = userData.Success

	self.Success:SetActive(success)
	self.Fail:SetActive(not success)
end

function RestaurantGameResultUI:OnClose(userData)
	return
end

function RestaurantGameResultUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
end

function RestaurantGameResultUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
end

function RestaurantGameResultUI:OnPause()
	return
end

function RestaurantGameResultUI:OnResume()
	return
end

function RestaurantGameResultUI:OnCover()
	return
end

function RestaurantGameResultUI:OnReveal()
	return
end

function RestaurantGameResultUI:OnRefocus(userData)
	return
end

function RestaurantGameResultUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantGameResultUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantGameResultUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantGameResultUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantGameResultUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function RestaurantGameResultUI:OnClickBtnBack()
	UIModule.CloseSelf(self)
end

return RestaurantGameResultUI
