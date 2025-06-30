-- chunkname: @IQIGame\\UI\\JewelryFormationSpeedUI.lua

local JewelryFormationSpeedUI = {
	speed = 0,
	jewelryCid = 0
}

JewelryFormationSpeedUI = Base:Extend("JewelryFormationSpeedUI", "IQIGame.Onigao.UI.JewelryFormationSpeedUI", JewelryFormationSpeedUI)

function JewelryFormationSpeedUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnSliderChanged(value)
		self:OnSliderChanged(value)
	end

	self.Slider = self.SpeedSlider:GetComponent("Slider")
	self.Slider.minValue = 0
	self.Slider.wholeNumbers = true
end

function JewelryFormationSpeedUI:GetPreloadAssetPaths()
	return nil
end

function JewelryFormationSpeedUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function JewelryFormationSpeedUI:IsManualShowOnOpen(userData)
	return false
end

function JewelryFormationSpeedUI:GetBGM(userData)
	return nil
end

function JewelryFormationSpeedUI:OnOpen(userData)
	self.SoulPrefabData = userData.soulPrefab
	self.jewelryCid = userData.jewelryCid
	self.speed = userData.speed

	self:UpdateView()
end

function JewelryFormationSpeedUI:OnClose(userData)
	SoulPrefabModule.SendSetJewelrySpeed(self.SoulPrefabData.id, self.jewelryCid, self.speed)
end

function JewelryFormationSpeedUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.Slider.onValueChanged:AddListener(self.DelegateOnSliderChanged)
end

function JewelryFormationSpeedUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.Slider.onValueChanged:RemoveListener(self.DelegateOnSliderChanged)
end

function JewelryFormationSpeedUI:OnPause()
	return
end

function JewelryFormationSpeedUI:OnResume()
	return
end

function JewelryFormationSpeedUI:OnCover()
	return
end

function JewelryFormationSpeedUI:OnReveal()
	return
end

function JewelryFormationSpeedUI:OnRefocus(userData)
	return
end

function JewelryFormationSpeedUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function JewelryFormationSpeedUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function JewelryFormationSpeedUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function JewelryFormationSpeedUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function JewelryFormationSpeedUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	self.Slider = nil
end

function JewelryFormationSpeedUI:UpdateView()
	local cfgItemData = CfgItemTable[self.jewelryCid]

	self.Slider.maxValue = cfgItemData.SpeedLimit
	self.Slider.value = self.speed

	UGUIUtil.SetText(self.SliderNum, tostring(self.speed))
end

function JewelryFormationSpeedUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function JewelryFormationSpeedUI:OnSliderChanged(value)
	self.speed = value

	UGUIUtil.SetText(self.SliderNum, tostring(self.speed))
end

return JewelryFormationSpeedUI
