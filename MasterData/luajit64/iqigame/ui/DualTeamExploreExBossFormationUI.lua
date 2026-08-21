-- chunkname: @IQIGame\\UI\\DualTeamExploreExBossFormationUI.lua

local DualTeamExploreExBossFormationUIController = require("IQIGame.UI.DualTeamExplore.ActivityUI.DualTeamExploreExBossFormationUIController")
local DualTeamExploreExBossFormationUI = {}

DualTeamExploreExBossFormationUI = Base:Extend("DualTeamExploreExBossFormationUI", "IQIGame.Onigao.UI.DualTeamExploreExBossFormationUI", DualTeamExploreExBossFormationUI)

function DualTeamExploreExBossFormationUI:GetViewPath()
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	return cfgDualTeamExploreControlData.DualTeamExploreExBossFormationUI
end

function DualTeamExploreExBossFormationUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function DualTeamExploreExBossFormationUI:GetPreloadAssetPaths()
	self.Controller = DualTeamExploreExBossFormationUIController.New(self.UIController)

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

function DualTeamExploreExBossFormationUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function DualTeamExploreExBossFormationUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function DualTeamExploreExBossFormationUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function DualTeamExploreExBossFormationUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function DualTeamExploreExBossFormationUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function DualTeamExploreExBossFormationUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function DualTeamExploreExBossFormationUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function DualTeamExploreExBossFormationUI:OnPause()
	self.Controller:OnPause()
end

function DualTeamExploreExBossFormationUI:OnResume()
	self.Controller:OnResume()
end

function DualTeamExploreExBossFormationUI:OnCover()
	self.Controller:OnCover()
end

function DualTeamExploreExBossFormationUI:OnReveal()
	self.Controller:OnReveal()
end

function DualTeamExploreExBossFormationUI:OnRefocus(userData)
	self.Controller:OnRefocus()
end

function DualTeamExploreExBossFormationUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function DualTeamExploreExBossFormationUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function DualTeamExploreExBossFormationUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function DualTeamExploreExBossFormationUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function DualTeamExploreExBossFormationUI:OnDestroy()
	self.Controller:OnDestroy()
end

return DualTeamExploreExBossFormationUI
