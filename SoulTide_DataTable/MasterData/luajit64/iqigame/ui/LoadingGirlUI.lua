-- chunkname: @IQIGame\\UI\\LoadingGirlUI.lua

local LoadingGirlUI = Base:Extend("LoadingGirlUI", "IQIGame.Onigao.UI.LoadingGirlUI", {})
local LoadingUIController = require("IQIGame.UI.Loading.LoadingUIController")

function LoadingGirlUI:OnInit()
	self.MainController = LoadingUIController.New(self.Main, false, function(loadingLabel, progressText, count, progress)
		self:SetProgressText(loadingLabel, progressText, count, progress)
	end)
end

function LoadingGirlUI:GetPreloadAssetPaths()
	return nil
end

function LoadingGirlUI:GetOpenPreloadAssetPaths(userData)
	if userData == nil then
		return
	end

	local cfgLoadingDta = CfgLoadingTable[userData.sceneId]

	return {
		UIGlobalApi.GetImagePath(cfgLoadingDta.LoadingBackGround)
	}
end

function LoadingGirlUI:OnOpen(userData)
	if userData == nil then
		return
	end

	local cfgLoadingDta = CfgLoadingTable[userData.sceneId]
	local bgPath = UIGlobalApi.GetImagePath(cfgLoadingDta.LoadingBackGround)
	local bgSprite = self.UIController:GetPreloadedAsset(bgPath)
	local randomIndex = math.random(1, #cfgLoadingDta.Name)

	self.MainController:Show(bgSprite, cfgLoadingDta.Name[randomIndex])
end

function LoadingGirlUI:OnClose(userData)
	return
end

function LoadingGirlUI:OnAddListeners()
	self.MainController:AddListeners()
end

function LoadingGirlUI:OnRemoveListeners()
	self.MainController:RemoveListeners()
end

function LoadingGirlUI:OnPause()
	return
end

function LoadingGirlUI:OnResume()
	return
end

function LoadingGirlUI:OnCover()
	return
end

function LoadingGirlUI:OnReveal()
	return
end

function LoadingGirlUI:OnRefocus(userData)
	return
end

function LoadingGirlUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.MainController:OnUpdate(elapseSeconds, realElapseSeconds)
end

function LoadingGirlUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LoadingGirlUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LoadingGirlUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LoadingGirlUI:OnDestroy()
	self.MainController:Dispose()
end

function LoadingGirlUI:SetProgressText(loadingLabel, progressText, count, progress)
	UGUIUtil.SetText(loadingLabel, LoadingUIApi:GetString("Loading", count % 3))
	UGUIUtil.SetText(progressText, LoadingUIApi:GetString("goProgressTxt", progress))
end

return LoadingGirlUI
