-- chunkname: @IQIGame\\UI\\DualTeamExploreLevelEntryUI.lua

local DualTeamExploreLevelEntryUIController = require("IQIGame.UI.DualTeamExplore.ActivityUI.DualTeamExploreLevelEntryUIController")
local DualTeamExploreLevelEntryUI = {}

DualTeamExploreLevelEntryUI = Base:Extend("DualTeamExploreLevelEntryUI", "IQIGame.Onigao.UI.DualTeamExploreLevelEntryUI", DualTeamExploreLevelEntryUI)

function DualTeamExploreLevelEntryUI:GetViewPath()
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	return cfgDualTeamExploreControlData.DualTeamExploreLevelEntryUI
end

function DualTeamExploreLevelEntryUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function DualTeamExploreLevelEntryUI:GetPreloadAssetPaths()
	self.Controller = DualTeamExploreLevelEntryUIController.New(self.UIController)

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

function DualTeamExploreLevelEntryUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function DualTeamExploreLevelEntryUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function DualTeamExploreLevelEntryUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function DualTeamExploreLevelEntryUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function DualTeamExploreLevelEntryUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function DualTeamExploreLevelEntryUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function DualTeamExploreLevelEntryUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function DualTeamExploreLevelEntryUI:OnPause()
	self.Controller:OnPause()
end

function DualTeamExploreLevelEntryUI:OnResume()
	self.Controller:OnResume()
end

function DualTeamExploreLevelEntryUI:OnCover()
	self.Controller:OnCover()
end

function DualTeamExploreLevelEntryUI:OnReveal()
	self.Controller:OnReveal()
end

function DualTeamExploreLevelEntryUI:OnRefocus(userData)
	self.Controller:OnRefocus()
end

function DualTeamExploreLevelEntryUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function DualTeamExploreLevelEntryUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function DualTeamExploreLevelEntryUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function DualTeamExploreLevelEntryUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function DualTeamExploreLevelEntryUI:OnDestroy()
	self.Controller:OnDestroy()
end

return DualTeamExploreLevelEntryUI
