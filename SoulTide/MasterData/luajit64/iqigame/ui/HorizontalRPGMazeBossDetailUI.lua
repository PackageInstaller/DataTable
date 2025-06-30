-- chunkname: @IQIGame\\UI\\HorizontalRPGMazeBossDetailUI.lua

local HorizontalRPGMazeBossDetailUIController = require("IQIGame.UI.ExploreHall.HorizontalRPG.HorizontalRPGMazeBossDetail.HorizontalRPGMazeBossDetailUIController")
local HorizontalRPGMazeBossDetailUI = {}

HorizontalRPGMazeBossDetailUI = Base:Extend("HorizontalRPGMazeBossDetailUI", "IQIGame.Onigao.UI.HorizontalRPGMazeBossDetailUI", HorizontalRPGMazeBossDetailUI)

require("IQIGame.UIExternalApi.HorizontalRPGMazeBossDetailUIApi")

function HorizontalRPGMazeBossDetailUI:GetViewPath()
	local cfgRPGMazeControlData = CfgHorizontalRPGControlTable[HorizontalRPGModule.globalCid]

	return cfgRPGMazeControlData.MazeBossDetailUI
end

function HorizontalRPGMazeBossDetailUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function HorizontalRPGMazeBossDetailUI:GetPreloadAssetPaths()
	self.Controller = HorizontalRPGMazeBossDetailUIController.New(self.UIController)

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

function HorizontalRPGMazeBossDetailUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function HorizontalRPGMazeBossDetailUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function HorizontalRPGMazeBossDetailUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function HorizontalRPGMazeBossDetailUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function HorizontalRPGMazeBossDetailUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function HorizontalRPGMazeBossDetailUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function HorizontalRPGMazeBossDetailUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function HorizontalRPGMazeBossDetailUI:OnPause()
	self.Controller:OnPause()
end

function HorizontalRPGMazeBossDetailUI:OnResume()
	self.Controller:OnResume()
end

function HorizontalRPGMazeBossDetailUI:OnCover()
	self.Controller:OnCover()
end

function HorizontalRPGMazeBossDetailUI:OnReveal()
	self.Controller:OnReveal()
end

function HorizontalRPGMazeBossDetailUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function HorizontalRPGMazeBossDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function HorizontalRPGMazeBossDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function HorizontalRPGMazeBossDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function HorizontalRPGMazeBossDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function HorizontalRPGMazeBossDetailUI:OnDestroy()
	self.Controller:OnDestroy()
end

return HorizontalRPGMazeBossDetailUI
