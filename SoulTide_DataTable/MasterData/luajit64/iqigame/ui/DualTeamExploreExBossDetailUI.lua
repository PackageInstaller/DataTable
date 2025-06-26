-- chunkname: @IQIGame\\UI\\DualTeamExploreExBossDetailUI.lua

local DualTeamExploreExBossDetailUIController = require("IQIGame.UI.DualTeamExplore.ActivityUI.DualTeamExploreExBossDetailUIController")
local DualTeamExploreExBossDetailUI = {}

DualTeamExploreExBossDetailUI = Base:Extend("DualTeamExploreExBossDetailUI", "IQIGame.Onigao.UI.DualTeamExploreExBossDetailUI", DualTeamExploreExBossDetailUI)

function DualTeamExploreExBossDetailUI:GetViewPath()
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	return cfgDualTeamExploreControlData.DualTeamExploreExBossDetailUI
end

function DualTeamExploreExBossDetailUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function DualTeamExploreExBossDetailUI:GetPreloadAssetPaths()
	self.Controller = DualTeamExploreExBossDetailUIController.New(self.UIController)

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

function DualTeamExploreExBossDetailUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function DualTeamExploreExBossDetailUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function DualTeamExploreExBossDetailUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function DualTeamExploreExBossDetailUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function DualTeamExploreExBossDetailUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function DualTeamExploreExBossDetailUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function DualTeamExploreExBossDetailUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function DualTeamExploreExBossDetailUI:OnPause()
	self.Controller:OnPause()
end

function DualTeamExploreExBossDetailUI:OnResume()
	self.Controller:OnResume()
end

function DualTeamExploreExBossDetailUI:OnCover()
	self.Controller:OnCover()
end

function DualTeamExploreExBossDetailUI:OnReveal()
	self.Controller:OnReveal()
end

function DualTeamExploreExBossDetailUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function DualTeamExploreExBossDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function DualTeamExploreExBossDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function DualTeamExploreExBossDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function DualTeamExploreExBossDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function DualTeamExploreExBossDetailUI:OnDestroy()
	self.Controller:OnDestroy()
end

return DualTeamExploreExBossDetailUI
