-- chunkname: @IQIGame\\UI\\LoadingTownUI.lua

local LoadingTownUI = Base:Extend("LoadingTownUI", "IQIGame.Onigao.UI.LoadingTownUI", {})
local LoadingUIController = require("IQIGame.UI.Loading.LoadingUIController")

function LoadingTownUI:OnInit()
	self.MainController = LoadingUIController.New(self.Main, false, function(loadingLabel, progressText, count, progress)
		self:SetProgressText(loadingLabel, progressText, count, progress)
	end)
end

function LoadingTownUI:GetPreloadAssetPaths()
	return nil
end

function LoadingTownUI:GetOpenPreloadAssetPaths(userData)
	if userData == nil then
		return
	end

	local cfgLoadingDta = CfgLoadingTable[userData.sceneId]

	return {
		UIGlobalApi.GetImagePath(cfgLoadingDta.LoadingBackGround)
	}
end

function LoadingTownUI:OnOpen(userData)
	if userData == nil then
		return
	end

	local cfgLoadingDta = CfgLoadingTable[userData.sceneId]
	local bgPath = UIGlobalApi.GetImagePath(cfgLoadingDta.LoadingBackGround)
	local bgSprite = self.UIController:GetPreloadedAsset(bgPath)
	local randomIndex = math.random(1, #cfgLoadingDta.Name)

	self.MainController:Show(bgSprite, cfgLoadingDta.Name[randomIndex])
end

function LoadingTownUI:OnClose(userData)
	return
end

function LoadingTownUI:OnAddListeners()
	self.MainController:AddListeners()
end

function LoadingTownUI:OnRemoveListeners()
	self.MainController:RemoveListeners()
end

function LoadingTownUI:OnPause()
	return
end

function LoadingTownUI:OnResume()
	return
end

function LoadingTownUI:OnCover()
	return
end

function LoadingTownUI:OnReveal()
	return
end

function LoadingTownUI:OnRefocus(userData)
	return
end

function LoadingTownUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.MainController:OnUpdate(elapseSeconds, realElapseSeconds)
end

function LoadingTownUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LoadingTownUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LoadingTownUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LoadingTownUI:OnDestroy()
	self.MainController:Dispose()
end

function LoadingTownUI:SetProgressText(loadingLabel, progressText, count, progress)
	UGUIUtil.SetText(loadingLabel, LoadingUIApi:GetString("Loading", count % 3))
	UGUIUtil.SetText(progressText, LoadingUIApi:GetString("goProgressTxt", progress))
end

return LoadingTownUI
