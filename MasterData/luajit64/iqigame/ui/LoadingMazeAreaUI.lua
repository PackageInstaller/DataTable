-- chunkname: @IQIGame\\UI\\LoadingMazeAreaUI.lua

local LoadingMazeAreaUI = Base:Extend("LoadingMazeAreaUI", "IQIGame.Onigao.UI.LoadingMazeAreaUI", {})
local LoadingUIController = require("IQIGame.UI.Loading.LoadingUIController")

function LoadingMazeAreaUI:OnInit()
	self.MainController = LoadingUIController.New(self.Main, true, function(loadingLabel, progressText, count, progress)
		self:SetProgressText(loadingLabel, progressText, count, progress)
	end)
end

function LoadingMazeAreaUI:GetPreloadAssetPaths()
	return nil
end

function LoadingMazeAreaUI:GetOpenPreloadAssetPaths(userData)
	if userData == nil then
		return
	end

	local cfgMazeInstance = CfgMazeInstanceTable[MazeDataModule.MazeInstanceID]

	return {
		UIGlobalApi.GetImagePath(cfgMazeInstance.LoadingBackGround)
	}
end

function LoadingMazeAreaUI:OnOpen(userData)
	if userData == nil then
		return
	end

	local cfgMazeInstance = CfgMazeInstanceTable[MazeDataModule.MazeInstanceID]
	local bgPath = UIGlobalApi.GetImagePath(cfgMazeInstance.LoadingBackGround)
	local bgSprite = self.UIController:GetPreloadedAsset(bgPath)
	local randomIndex = math.random(1, #cfgMazeInstance.LoadingTxt)

	self.MainController:Show(bgSprite, cfgMazeInstance.LoadingTxt[randomIndex])

	local cfgChapterData = CfgChapterTable[cfgMazeInstance.ChapterId]

	self.NameText:GetComponent("Text").text = LoadingUIApi:GetString("TextArea", cfgChapterData.Name, cfgMazeInstance.Name)
end

function LoadingMazeAreaUI:OnClose(userData)
	return
end

function LoadingMazeAreaUI:OnAddListeners()
	self.MainController:AddListeners()
end

function LoadingMazeAreaUI:OnRemoveListeners()
	self.MainController:RemoveListeners()
end

function LoadingMazeAreaUI:OnPause()
	return
end

function LoadingMazeAreaUI:OnResume()
	return
end

function LoadingMazeAreaUI:OnCover()
	return
end

function LoadingMazeAreaUI:OnReveal()
	return
end

function LoadingMazeAreaUI:OnRefocus(userData)
	return
end

function LoadingMazeAreaUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.MainController:OnUpdate(elapseSeconds, realElapseSeconds)
end

function LoadingMazeAreaUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LoadingMazeAreaUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LoadingMazeAreaUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LoadingMazeAreaUI:OnDestroy()
	self.MainController:Dispose()
end

function LoadingMazeAreaUI:SetProgressText(loadingLabel, progressText, count, progress)
	UGUIUtil.SetText(loadingLabel, LoadingUIApi:GetString("Loading", count % 3))
	UGUIUtil.SetText(progressText, LoadingUIApi:GetString("goProgressTxt", progress))
end

return LoadingMazeAreaUI
