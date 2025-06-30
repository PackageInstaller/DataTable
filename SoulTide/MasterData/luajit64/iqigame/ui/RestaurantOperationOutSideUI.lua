-- chunkname: @IQIGame\\UI\\RestaurantOperationOutSideUI.lua

local RestaurantOperationOutSideUI = {
	isPlaying = false,
	ChangeSceneEffectPlayId = 0
}

RestaurantOperationOutSideUI = Base:Extend("RestaurantOperationOutSideUI", "IQIGame.Onigao.UI.RestaurantOperationOutSideUI", RestaurantOperationOutSideUI)

function RestaurantOperationOutSideUI:OnInit()
	function self.DelegateBtnBackRestaurant()
		self:OnBtnBackRestaurant()
	end

	function self.DelegateBtnClose()
		self:OnBtnClose()
	end

	function self.DelegateChangeInRoom()
		self:OnChangeInRoom()
	end
end

function RestaurantOperationOutSideUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantOperationOutSideUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantOperationOutSideUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantOperationOutSideUI:GetBGM(userData)
	return nil
end

function RestaurantOperationOutSideUI:OnOpen(userData)
	self:StopEffect()

	local isPlayEff = userData.PlayEffect

	if isPlayEff then
		self:PlayEffect(true, function()
			self:UpdateView()
		end)
	else
		self:UpdateView()
	end

	RestaurantOperationModule.ROScene:ShowScene(true)
end

function RestaurantOperationOutSideUI:OnClose(userData)
	self:StopEffect()
end

function RestaurantOperationOutSideUI:OnAddListeners()
	self.BtnBackRestaurant:GetComponent("Button").onClick:AddListener(self.DelegateBtnBackRestaurant)
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
	EventDispatcher.AddEventListener(EventID.ROSceneChangeInRoomEvent, self.DelegateChangeInRoom)
end

function RestaurantOperationOutSideUI:OnRemoveListeners()
	self.BtnBackRestaurant:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnBackRestaurant)
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
	EventDispatcher.RemoveEventListener(EventID.ROSceneChangeInRoomEvent, self.DelegateChangeInRoom)
end

function RestaurantOperationOutSideUI:OnPause()
	return
end

function RestaurantOperationOutSideUI:OnResume()
	return
end

function RestaurantOperationOutSideUI:OnCover()
	return
end

function RestaurantOperationOutSideUI:OnReveal()
	return
end

function RestaurantOperationOutSideUI:OnRefocus(userData)
	return
end

function RestaurantOperationOutSideUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantOperationOutSideUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantOperationOutSideUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantOperationOutSideUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantOperationOutSideUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function RestaurantOperationOutSideUI:UpdateView()
	return
end

function RestaurantOperationOutSideUI:StopEffect()
	self.EffectOpen:SetActive(false)
	self.EffectClose:SetActive(false)

	if self.changeTimer then
		self.changeTimer:Stop()

		self.changeTimer = nil
	end
end

function RestaurantOperationOutSideUI:PlayEffect(isOpen, callBack)
	self:StopEffect()

	self.isPlaying = true

	if isOpen then
		self.EffectOpen:SetActive(true)
	else
		self.EffectClose:SetActive(true)
	end

	self.changeTimer = Timer.New(function()
		if callBack then
			callBack()
		end

		self.isPlaying = false
	end, 2)

	self.changeTimer:Start()
end

function RestaurantOperationOutSideUI:OnChangeInRoom()
	self:OnBtnBackRestaurant()
end

function RestaurantOperationOutSideUI:OnBtnBackRestaurant()
	if self.isPlaying then
		return
	end

	self:PlayEffect(false, function()
		UIModule.CloseSelf(self)
		RestaurantOperationModule.ChangeSceneArea(RestaurantOperationConstant.SceneType.Scene_Inside)
	end)
end

function RestaurantOperationOutSideUI:OnBtnClose()
	UIModule.CloseSelf(self)
	RestaurantOperationModule.ExitRestaurantScene()
end

return RestaurantOperationOutSideUI
