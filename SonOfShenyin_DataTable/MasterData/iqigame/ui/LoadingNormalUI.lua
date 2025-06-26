-- chunkname: @IQIGame\\UI\\LoadingNormalUI.lua

local LoadingNormalUI = Base:Extend("LoadingNormalUI", "IQIGame.Onigao.UI.LoadingNormalUI", {})
local LoadingUIController = require("IQIGame.UI.Loading.LoadingUIController")
local E_LoadingShowType = {
	SingleText = 1,
	SliderAndText = 0
}
local ImageBgResourceId = {
	1000001,
	1000002,
	1000003,
	1000004,
	1000005
}

function LoadingNormalUI:OnInit()
	self.MainController = LoadingUIController.New(function(progress, count)
		self:UpdateLoadingShow(progress, count)
	end)
	self.LoadingCommonNodes = {}

	LuaCodeInterface.BindOutlet(self.LoadingCommonComponentsCenterObj, self.LoadingCommonNodes)

	self.LoadingTypeNodes = {}

	LuaCodeInterface.BindOutlet(self.LoadingTypeCenterObj, self.LoadingTypeNodes)

	self.LoadingTypeNodes.SingleTextLoadingTypeNode = {}

	LuaCodeInterface.BindOutlet(self.LoadingTypeNodes.SingleTextLoadingTypeObj, self.LoadingTypeNodes.SingleTextLoadingTypeNode)

	self.LoadingTypeNodes.SliderAndTextLoadingTypeNode = {}

	LuaCodeInterface.BindOutlet(self.LoadingTypeNodes.SliderAndTextLoadingTypeObj, self.LoadingTypeNodes.SliderAndTextLoadingTypeNode)

	self.LoadingCommonNodes.BackgroundImage = self.LoadingCommonNodes.Background:GetComponent("Image")
	self.LoadingTypeNodes.SliderAndTextLoadingTypeNode.ProgressSliderCom = self.LoadingTypeNodes.SliderAndTextLoadingTypeNode.ProgressSlider:GetComponent("Slider")
end

function LoadingNormalUI:GetPreloadAssetPaths()
	return nil
end

function LoadingNormalUI:GetOpenPreloadAssetPaths(userData)
	return
end

function LoadingNormalUI:OnOpen(userData)
	if userData == nil then
		return
	end

	self.loadingShowType = E_LoadingShowType.SliderAndText

	self:InitLoadingShowType()
	self.MainController:Show(userData.sceneId, userData.canShowCustomProgress)
	self:RefreshBg()

	if self.refreshBgTimer then
		self.refreshBgTimer:Stop()

		self.refreshBgTimer = nil
	end

	self.refreshBgTimer = Timer.New(function()
		self:RefreshBg()
	end, 10, -1)

	self.refreshBgTimer:Start()
end

function LoadingNormalUI:OnClose(userData)
	if self.refreshBgTimer then
		self.refreshBgTimer:Stop()

		self.refreshBgTimer = nil
	end

	self:UpdateLoadingShow(1, 3)
end

function LoadingNormalUI:OnAddListeners()
	self.MainController:AddListeners()
end

function LoadingNormalUI:OnRemoveListeners()
	self.MainController:RemoveListeners()
end

function LoadingNormalUI:OnPause()
	return
end

function LoadingNormalUI:OnResume()
	return
end

function LoadingNormalUI:OnCover()
	return
end

function LoadingNormalUI:OnReveal()
	return
end

function LoadingNormalUI:OnRefocus(userData)
	return
end

function LoadingNormalUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.MainController:OnUpdate(elapseSeconds, realElapseSeconds)
end

function LoadingNormalUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LoadingNormalUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LoadingNormalUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LoadingNormalUI:RefreshBg()
	math.randomseed(os.time())

	local randomNum = math.random(1, #ImageBgResourceId)
	local id = ImageBgResourceId[randomNum]
	local path = CfgUtil.GetCfgResourceUrl(id)

	LuaUtility.ResourceLoadImage(self.Image_01, path)
end

function LoadingNormalUI:OnDestroy()
	if self.refreshBgTimer then
		self.refreshBgTimer:Stop()

		self.refreshBgTimer = nil
	end

	self.MainController:Dispose()

	self.LoadingCommonNodes.BackgroundImage = nil
	self.LoadingTypeNodes.SliderAndTextLoadingTypeNode.ProgressSliderCom = nil

	LuaCodeInterface.ClearOutlet(self.LoadingTypeNodes.SingleTextLoadingTypeObj, self.LoadingTypeNodes.SingleTextLoadingTypeNode)
	LuaCodeInterface.ClearOutlet(self.LoadingTypeNodes.SliderAndTextLoadingTypeObj, self.LoadingTypeNodes.SliderAndTextLoadingTypeNode)
	LuaCodeInterface.ClearOutlet(self.LoadingTypeCenterObj, self.LoadingTypeNodes)
	LuaCodeInterface.ClearOutlet(self.LoadingCommonComponentsCenterObj, self.LoadingCommonNodes)

	self.LoadingCommonNodes = nil
	self.LoadingTypeNodes = nil
	self.MainController = nil
end

function LoadingNormalUI:InitLoadingShowType()
	if self.loadingShowType == E_LoadingShowType.SliderAndText then
		self.LoadingTypeNodes.SliderAndTextLoadingTypeObj.gameObject:SetActive(true)
		self.LoadingTypeNodes.SingleTextLoadingTypeObj.gameObject:SetActive(false)
	elseif self.loadingShowType == E_LoadingShowType.SingleText then
		self.LoadingTypeNodes.SliderAndTextLoadingTypeObj.gameObject:SetActive(false)
		self.LoadingTypeNodes.SingleTextLoadingTypeObj.gameObject:SetActive(true)
	end
end

function LoadingNormalUI:UpdateLoadingShow(progress, count)
	if self.loadingShowType == E_LoadingShowType.SliderAndText then
		UGUIUtil.SetText(self.LoadingTypeNodes.SliderAndTextLoadingTypeNode.ProgressText, LoadingUIApi:GetNormalLoadingLabel(progress, count % 3))

		self.LoadingTypeNodes.SliderAndTextLoadingTypeNode.ProgressSliderCom.value = progress
	elseif self.loadingShowType == E_LoadingShowType.SingleText then
		UGUIUtil.SetText(self.LoadingTypeNodes.SingleTextLoadingTypeNode.ProgressText, LoadingUIApi:GetNormalLoadingLabel(progress, count % 3))
	end
end

return LoadingNormalUI
