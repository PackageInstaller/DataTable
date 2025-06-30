-- chunkname: @IQIGame\\UI\\HorizontalRPGMazeBossChallengeDetailUI.lua

local HorizontalRPGMazeBossChallengeDetailUIController = require("IQIGame.UI.ExploreHall.HorizontalRPG.HorizontalRPGMazeBossChallengeDetail.HorizontalRPGMazeBossChallengeDetailUIController")
local HorizontalRPGMazeBossChallengeDetailUI = {}

HorizontalRPGMazeBossChallengeDetailUI = Base:Extend("HorizontalRPGMazeBossChallengeDetailUI", "IQIGame.Onigao.UI.HorizontalRPGMazeBossChallengeDetailUI", HorizontalRPGMazeBossChallengeDetailUI)

require("IQIGame.UIExternalApi.HorizontalRPGMazeBossChallengeDetailUIApi")

function HorizontalRPGMazeBossChallengeDetailUI:GetViewPath()
	local cfgRPGMazeControlData = CfgHorizontalRPGControlTable[HorizontalRPGModule.globalCid]

	return cfgRPGMazeControlData.MazeExBossDetailUI
end

function HorizontalRPGMazeBossChallengeDetailUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function HorizontalRPGMazeBossChallengeDetailUI:GetPreloadAssetPaths()
	self.Controller = HorizontalRPGMazeBossChallengeDetailUIController.New(self.UIController)

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

function HorizontalRPGMazeBossChallengeDetailUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function HorizontalRPGMazeBossChallengeDetailUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function HorizontalRPGMazeBossChallengeDetailUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function HorizontalRPGMazeBossChallengeDetailUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function HorizontalRPGMazeBossChallengeDetailUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function HorizontalRPGMazeBossChallengeDetailUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function HorizontalRPGMazeBossChallengeDetailUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function HorizontalRPGMazeBossChallengeDetailUI:OnPause()
	self.Controller:OnPause()
end

function HorizontalRPGMazeBossChallengeDetailUI:OnResume()
	self.Controller:OnResume()
end

function HorizontalRPGMazeBossChallengeDetailUI:OnCover()
	self.Controller:OnCover()
end

function HorizontalRPGMazeBossChallengeDetailUI:OnReveal()
	self.Controller:OnReveal()
end

function HorizontalRPGMazeBossChallengeDetailUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function HorizontalRPGMazeBossChallengeDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function HorizontalRPGMazeBossChallengeDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function HorizontalRPGMazeBossChallengeDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function HorizontalRPGMazeBossChallengeDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function HorizontalRPGMazeBossChallengeDetailUI:OnDestroy()
	self.Controller:OnDestroy()
end

return HorizontalRPGMazeBossChallengeDetailUI
