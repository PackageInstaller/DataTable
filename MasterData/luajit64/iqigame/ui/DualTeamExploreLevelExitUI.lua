-- chunkname: @IQIGame\\UI\\DualTeamExploreLevelExitUI.lua

local DualTeamExploreLevelExitUIController = require("IQIGame.UI.DualTeamExplore.ActivityUI.DualTeamExploreLevelExitUIController")
local DualTeamExploreLevelExitUI = {}

DualTeamExploreLevelExitUI = Base:Extend("DualTeamExploreLevelExitUI", "IQIGame.Onigao.UI.DualTeamExploreLevelExitUI", DualTeamExploreLevelExitUI)

function DualTeamExploreLevelExitUI:GetViewPath()
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	return cfgDualTeamExploreControlData.DualTeamExploreLevelExitUI
end

function DualTeamExploreLevelExitUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function DualTeamExploreLevelExitUI:GetPreloadAssetPaths()
	self.Controller = DualTeamExploreLevelExitUIController.New(self.UIController)

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

function DualTeamExploreLevelExitUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function DualTeamExploreLevelExitUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function DualTeamExploreLevelExitUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function DualTeamExploreLevelExitUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function DualTeamExploreLevelExitUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function DualTeamExploreLevelExitUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function DualTeamExploreLevelExitUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function DualTeamExploreLevelExitUI:OnPause()
	self.Controller:OnPause()
end

function DualTeamExploreLevelExitUI:OnResume()
	self.Controller:OnResume()
end

function DualTeamExploreLevelExitUI:OnCover()
	self.Controller:OnCover()
end

function DualTeamExploreLevelExitUI:OnReveal()
	self.Controller:OnReveal()
end

function DualTeamExploreLevelExitUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function DualTeamExploreLevelExitUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function DualTeamExploreLevelExitUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function DualTeamExploreLevelExitUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function DualTeamExploreLevelExitUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function DualTeamExploreLevelExitUI:OnDestroy()
	self.Controller:OnDestroy()
end

return DualTeamExploreLevelExitUI
