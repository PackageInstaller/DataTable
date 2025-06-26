-- chunkname: @IQIGame\\UI\\ResourceDownloadUI.lua

local ResourceDownloadUI = {
	type = 0
}

ResourceDownloadUI = Base:Extend("ResourceDownloadUI", "IQIGame.Onigao.UI.ResourceDownloadUI", ResourceDownloadUI)

function ResourceDownloadUI:OnInit()
	function self.DelegateOnResourceUpdateChanged(sender, args)
		self:OnResourceUpdateChanged(sender, args)
	end
end

function ResourceDownloadUI:GetPreloadAssetPaths()
	return nil
end

function ResourceDownloadUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ResourceDownloadUI:IsManualShowOnOpen(userData)
	return false
end

function ResourceDownloadUI:GetBGM(userData)
	return nil
end

function ResourceDownloadUI:OnOpen(userData)
	self.type = userData == nil and 0 or userData.type == nil and 0 or userData.type
end

function ResourceDownloadUI:OnClose(userData)
	return
end

function ResourceDownloadUI:OnAddListeners()
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ResourceUpdateChangedEventArgs.EventId, self.DelegateOnResourceUpdateChanged)
end

function ResourceDownloadUI:OnRemoveListeners()
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ResourceUpdateChangedEventArgs.EventId, self.DelegateOnResourceUpdateChanged)
end

function ResourceDownloadUI:OnPause()
	return
end

function ResourceDownloadUI:OnResume()
	return
end

function ResourceDownloadUI:OnCover()
	return
end

function ResourceDownloadUI:OnReveal()
	return
end

function ResourceDownloadUI:OnRefocus(userData)
	return
end

function ResourceDownloadUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.type == 1 then
		self:RefreshProgress(ResourceS.ResourceBlackboard.CheckMd5Progress)
	end
end

function ResourceDownloadUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ResourceDownloadUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ResourceDownloadUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ResourceDownloadUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function ResourceDownloadUI:OnResourceUpdateChanged(sender, args)
	if self.type ~= 0 then
		return
	end

	local info = args.UserData

	self:RefreshProgress(info.ProcessNormalize)
end

function ResourceDownloadUI:RefreshProgress(progress)
	local progressImage = self.ProgressImg:GetComponent(typeof(UnityEngine.UI.Image))

	progressImage.fillAmount = progress

	local textField = self.ProgressText:GetComponent(typeof(UnityEngine.UI.Text))

	textField.text = math.round(progress * 100) .. "%"
end

return ResourceDownloadUI
