-- chunkname: @IQIGame\\UI\\DualTeamExploreLevelFormationUI.lua

local DualTeamExploreLevelFormationUIController = require("IQIGame.UI.DualTeamExplore.ActivityUI.DualTeamExploreLevelFormationUIController")
local DualTeamExploreLevelFormationUI = {}

DualTeamExploreLevelFormationUI = Base:Extend("DualTeamExploreLevelFormationUI", "IQIGame.Onigao.UI.DualTeamExploreLevelFormationUI", DualTeamExploreLevelFormationUI)

function DualTeamExploreLevelFormationUI:GetViewPath()
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	return cfgDualTeamExploreControlData.DualTeamExploreLevelFormationUI
end

function DualTeamExploreLevelFormationUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function DualTeamExploreLevelFormationUI:GetPreloadAssetPaths()
	self.Controller = DualTeamExploreLevelFormationUIController.New(self.UIController)

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

function DualTeamExploreLevelFormationUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function DualTeamExploreLevelFormationUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function DualTeamExploreLevelFormationUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function DualTeamExploreLevelFormationUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function DualTeamExploreLevelFormationUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function DualTeamExploreLevelFormationUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function DualTeamExploreLevelFormationUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function DualTeamExploreLevelFormationUI:OnPause()
	self.Controller:OnPause()
end

function DualTeamExploreLevelFormationUI:OnResume()
	self.Controller:OnResume()
end

function DualTeamExploreLevelFormationUI:OnCover()
	self.Controller:OnCover()
end

function DualTeamExploreLevelFormationUI:OnReveal()
	self.Controller:OnReveal()
end

function DualTeamExploreLevelFormationUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function DualTeamExploreLevelFormationUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function DualTeamExploreLevelFormationUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function DualTeamExploreLevelFormationUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function DualTeamExploreLevelFormationUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function DualTeamExploreLevelFormationUI:OnDestroy()
	self.Controller:OnDestroy()
end

return DualTeamExploreLevelFormationUI
