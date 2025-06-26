-- chunkname: @IQIGame\\UI\\LoadingHomeUI.lua

local LoadingHomeUI = Base:Extend("LoadingHomeUI", "IQIGame.Onigao.UI.LoadingHomeUI", {})
local LoadingUIController = require("IQIGame.UI.Loading.LoadingUIController")

function LoadingHomeUI:OnInit()
	self.MainController = LoadingUIController.New(self.Main, true, function(loadingLabel, progressText, count, progress)
		self:SetProgressText(loadingLabel, progressText, count, progress)
	end)
end

function LoadingHomeUI:GetPreloadAssetPaths()
	return nil
end

function LoadingHomeUI:GetOpenPreloadAssetPaths(userData)
	if userData == nil then
		return
	end

	local cfgLoadingDta = CfgLoadingTable[userData.sceneId]

	if cfgLoadingDta == nil then
		cfgLoadingDta = CfgLoadingTable[SceneID.Home]
	end

	return {
		UIGlobalApi.GetImagePath(cfgLoadingDta.LoadingBackGround)
	}
end

function LoadingHomeUI:OnOpen(userData)
	if userData == nil then
		return
	end

	local cfgLoadingDta = CfgLoadingTable[userData.sceneId]

	if cfgLoadingDta == nil then
		cfgLoadingDta = CfgLoadingTable[SceneID.Home]
	end

	local bgPath = UIGlobalApi.GetImagePath(cfgLoadingDta.LoadingBackGround)
	local bgSprite = self.UIController:GetPreloadedAsset(bgPath)
	local randomIndex = math.random(1, #cfgLoadingDta.Name)

	self.MainController:Show(bgSprite, cfgLoadingDta.Name[randomIndex])
end

function LoadingHomeUI:OnClose(userData)
	return
end

function LoadingHomeUI:OnAddListeners()
	self.MainController:AddListeners()
end

function LoadingHomeUI:OnRemoveListeners()
	self.MainController:RemoveListeners()
end

function LoadingHomeUI:OnPause()
	return
end

function LoadingHomeUI:OnResume()
	return
end

function LoadingHomeUI:OnCover()
	return
end

function LoadingHomeUI:OnReveal()
	return
end

function LoadingHomeUI:OnRefocus(userData)
	return
end

function LoadingHomeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.MainController:OnUpdate(elapseSeconds, realElapseSeconds)
end

function LoadingHomeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LoadingHomeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LoadingHomeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LoadingHomeUI:OnDestroy()
	self.MainController:Dispose()
end

function LoadingHomeUI:SetProgressText(loadingLabel, progressText, count, progress)
	UGUIUtil.SetText(loadingLabel, LoadingUIApi:GetString("Loading", count % 3))
	UGUIUtil.SetText(progressText, LoadingUIApi:GetString("goProgressTxt", progress))
end

return LoadingHomeUI
