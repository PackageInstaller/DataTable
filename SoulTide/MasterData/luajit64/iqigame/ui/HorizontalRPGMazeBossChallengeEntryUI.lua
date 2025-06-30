-- chunkname: @IQIGame\\UI\\HorizontalRPGMazeBossChallengeEntryUI.lua

local HorizontalRPGMazeBossChallengeEntryUIController = require("IQIGame.UI.ExploreHall.HorizontalRPG.HorizontalRPGMazeBossChallengeEntry.HorizontalRPGMazeBossChallengeEntryUIController")
local HorizontalRPGMazeBossChallengeEntryUI = {}

HorizontalRPGMazeBossChallengeEntryUI = Base:Extend("HorizontalRPGMazeBossChallengeEntryUI", "IQIGame.Onigao.UI.HorizontalRPGMazeBossChallengeEntryUI", HorizontalRPGMazeBossChallengeEntryUI)

require("IQIGame.UIExternalApi.HorizontalRPGMazeBossChallengeEntryUIApi")

function HorizontalRPGMazeBossChallengeEntryUI:GetViewPath()
	local cfgRPGMazeControlData = CfgHorizontalRPGControlTable[HorizontalRPGModule.globalCid]

	return cfgRPGMazeControlData.MazeBossChallengeEntryUI
end

function HorizontalRPGMazeBossChallengeEntryUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function HorizontalRPGMazeBossChallengeEntryUI:GetPreloadAssetPaths()
	self.Controller = HorizontalRPGMazeBossChallengeEntryUIController.New(self.UIController)

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

function HorizontalRPGMazeBossChallengeEntryUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function HorizontalRPGMazeBossChallengeEntryUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function HorizontalRPGMazeBossChallengeEntryUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function HorizontalRPGMazeBossChallengeEntryUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function HorizontalRPGMazeBossChallengeEntryUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function HorizontalRPGMazeBossChallengeEntryUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function HorizontalRPGMazeBossChallengeEntryUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function HorizontalRPGMazeBossChallengeEntryUI:OnPause()
	self.Controller:OnPause()
end

function HorizontalRPGMazeBossChallengeEntryUI:OnResume()
	self.Controller:OnResume()
end

function HorizontalRPGMazeBossChallengeEntryUI:OnCover()
	self.Controller:OnCover()
end

function HorizontalRPGMazeBossChallengeEntryUI:OnReveal()
	self.Controller:OnReveal()
end

function HorizontalRPGMazeBossChallengeEntryUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function HorizontalRPGMazeBossChallengeEntryUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function HorizontalRPGMazeBossChallengeEntryUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function HorizontalRPGMazeBossChallengeEntryUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function HorizontalRPGMazeBossChallengeEntryUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function HorizontalRPGMazeBossChallengeEntryUI:OnDestroy()
	self.Controller:OnDestroy()
end

return HorizontalRPGMazeBossChallengeEntryUI
