-- chunkname: @IQIGame\\UI\\LoadingNormalUI.lua

local LoadingNormalUI = Base:Extend("LoadingNormalUI", "IQIGame.Onigao.UI.LoadingNormalUI", {})
local LoadingUIController = require("IQIGame.UI.Loading.LoadingUIController")

function LoadingNormalUI:OnInit()
	self.MainController = LoadingUIController.New(self.Main, false, function(loadingLabel, progressText, count, progress)
		self:SetProgressText(loadingLabel, progressText, count, progress)
	end)

	UGUIUtil.SetText(self.TitleText, LoadingUIApi:GetString("NormalTitleText"))
end

function LoadingNormalUI:GetPreloadAssetPaths()
	return nil
end

function LoadingNormalUI:GetOpenPreloadAssetPaths(userData)
	if userData == nil then
		return
	end

	local cfgLoadingDta = CfgLoadingTable[userData.sceneId]

	return {
		UIGlobalApi.GetImagePath(cfgLoadingDta.LoadingBackGround)
	}
end

function LoadingNormalUI:OnOpen(userData)
	if userData == nil then
		return
	end

	local cfgLoadingDta = CfgLoadingTable[userData.sceneId]
	local bgPath = UIGlobalApi.GetImagePath(cfgLoadingDta.LoadingBackGround)
	local bgSprite = self.UIController:GetPreloadedAsset(bgPath)
	local randomIndex = math.random(1, #cfgLoadingDta.Name)
	local loadingText = cfgLoadingDta.Name[randomIndex]

	self.MainController:Show(bgSprite, loadingText)
	UGUIUtil.SetText(self.TipTextMirror, loadingText)
end

function LoadingNormalUI:OnClose(userData)
	return
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

function LoadingNormalUI:OnDestroy()
	self.MainController:Dispose()
end

function LoadingNormalUI:SetProgressText(loadingLabel, progressText, count, progress)
	UGUIUtil.SetText(progressText, LoadingUIApi:GetString("NormalLoadingLabel", progress, count % 3))
end

return LoadingNormalUI
