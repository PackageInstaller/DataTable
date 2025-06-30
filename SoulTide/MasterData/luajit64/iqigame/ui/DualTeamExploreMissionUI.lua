-- chunkname: @IQIGame\\UI\\DualTeamExploreMissionUI.lua

local DualTeamExploreMissionUIController = require("IQIGame.UI.DualTeamExplore.ActivityUI.DualTeamExploreMissionUIController")
local DualTeamExploreMissionUI = {}

DualTeamExploreMissionUI = Base:Extend("DualTeamExploreMissionUI", "IQIGame.Onigao.UI.DualTeamExploreMissionUI", DualTeamExploreMissionUI)

function DualTeamExploreMissionUI:GetViewPath()
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	return cfgDualTeamExploreControlData.DualTeamExploreMissionUI
end

function DualTeamExploreMissionUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function DualTeamExploreMissionUI:GetPreloadAssetPaths()
	self.Controller = DualTeamExploreMissionUIController.New(self.UIController)

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

function DualTeamExploreMissionUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function DualTeamExploreMissionUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function DualTeamExploreMissionUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function DualTeamExploreMissionUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function DualTeamExploreMissionUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function DualTeamExploreMissionUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function DualTeamExploreMissionUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function DualTeamExploreMissionUI:OnPause()
	self.Controller:OnPause()
end

function DualTeamExploreMissionUI:OnResume()
	self.Controller:OnResume()
end

function DualTeamExploreMissionUI:OnCover()
	self.Controller:OnCover()
end

function DualTeamExploreMissionUI:OnReveal()
	self.Controller:OnReveal()
end

function DualTeamExploreMissionUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function DualTeamExploreMissionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function DualTeamExploreMissionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function DualTeamExploreMissionUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function DualTeamExploreMissionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function DualTeamExploreMissionUI:OnDestroy()
	self.Controller:OnDestroy()
end

return DualTeamExploreMissionUI
