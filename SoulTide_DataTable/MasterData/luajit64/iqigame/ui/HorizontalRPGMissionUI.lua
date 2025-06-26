-- chunkname: @IQIGame\\UI\\HorizontalRPGMissionUI.lua

local HorizontalRPGMissionUIController = require("IQIGame.UI.ExploreHall.HorizontalRPG.HorizontalRPGMission.HorizontalRPGMissionUIController")
local HorizontalRPGMissionUI = {}

HorizontalRPGMissionUI = Base:Extend("HorizontalRPGMissionUI", "IQIGame.Onigao.UI.HorizontalRPGMissionUI", HorizontalRPGMissionUI)

require("IQIGame.UIExternalApi.HorizontalRPGMissionUIApi")

function HorizontalRPGMissionUI:GetViewPath()
	local cfgRPGMazeControlData = CfgHorizontalRPGControlTable[HorizontalRPGModule.globalCid]

	return cfgRPGMazeControlData.HorizontalRPGMissionUI
end

function HorizontalRPGMissionUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function HorizontalRPGMissionUI:GetPreloadAssetPaths()
	self.Controller = HorizontalRPGMissionUIController.New(self.UIController)

	local paths = {}

	table.insert(paths, UIGlobalApi.GetUIPrefab(self:GetViewPath()))

	local subPaths = self.Controller:GetPreloadAssetPaths()

	if subPaths ~= nil then
		for i = 1, #subPaths do
			table.insert(paths, subPaths[i])
		end
	end

	return paths
end

function HorizontalRPGMissionUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function HorizontalRPGMissionUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function HorizontalRPGMissionUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function HorizontalRPGMissionUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function HorizontalRPGMissionUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function HorizontalRPGMissionUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function HorizontalRPGMissionUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function HorizontalRPGMissionUI:OnPause()
	self.Controller:OnPause()
end

function HorizontalRPGMissionUI:OnResume()
	self.Controller:OnResume()
end

function HorizontalRPGMissionUI:OnCover()
	self.Controller:OnCover()
end

function HorizontalRPGMissionUI:OnReveal()
	self.Controller:OnReveal()
end

function HorizontalRPGMissionUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function HorizontalRPGMissionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function HorizontalRPGMissionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function HorizontalRPGMissionUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function HorizontalRPGMissionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function HorizontalRPGMissionUI:OnDestroy()
	self.Controller:OnDestroy()
end

return HorizontalRPGMissionUI
