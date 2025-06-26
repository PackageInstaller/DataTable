-- chunkname: @IQIGame\\UI\\MapTaskUI.lua

local MapTaskUI = {}

MapTaskUI = Base:Extend("MapTaskUI", "IQIGame.Onigao.UI.MapTaskUI", MapTaskUI)

function MapTaskUI:OnInit()
	return
end

function MapTaskUI:GetPreloadAssetPaths()
	return nil
end

function MapTaskUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MapTaskUI:IsManualShowOnOpen(userData)
	return false
end

function MapTaskUI:GetBGM(userData)
	return nil
end

function MapTaskUI:OnOpen(userData)
	return
end

function MapTaskUI:OnClose(userData)
	return
end

function MapTaskUI:OnAddListeners()
	return
end

function MapTaskUI:OnRemoveListeners()
	return
end

function MapTaskUI:OnPause()
	return
end

function MapTaskUI:OnResume()
	return
end

function MapTaskUI:OnCover()
	return
end

function MapTaskUI:OnReveal()
	return
end

function MapTaskUI:OnRefocus(userData)
	return
end

function MapTaskUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MapTaskUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MapTaskUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MapTaskUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MapTaskUI:OnDestroy()
	return
end

return MapTaskUI
