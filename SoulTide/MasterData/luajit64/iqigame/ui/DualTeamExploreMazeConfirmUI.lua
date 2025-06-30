-- chunkname: @IQIGame\\UI\\DualTeamExploreMazeConfirmUI.lua

local DualTeamExploreMazeConfirmUIController = require("IQIGame.UI.DualTeamExplore.ActivityUI.DualTeamExploreMazeConfirmUIController")
local DualTeamExploreMazeConfirmUI = {}

DualTeamExploreMazeConfirmUI = Base:Extend("DualTeamExploreMazeConfirmUI", "IQIGame.Onigao.UI.DualTeamExploreMazeConfirmUI", DualTeamExploreMazeConfirmUI)

function DualTeamExploreMazeConfirmUI:GetViewPath()
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	return cfgDualTeamExploreControlData.DualTeamExploreMazeConfirmUI
end

function DualTeamExploreMazeConfirmUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function DualTeamExploreMazeConfirmUI:GetPreloadAssetPaths()
	self.Controller = DualTeamExploreMazeConfirmUIController.New(self.UIController)

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

function DualTeamExploreMazeConfirmUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function DualTeamExploreMazeConfirmUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function DualTeamExploreMazeConfirmUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function DualTeamExploreMazeConfirmUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function DualTeamExploreMazeConfirmUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function DualTeamExploreMazeConfirmUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function DualTeamExploreMazeConfirmUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function DualTeamExploreMazeConfirmUI:OnPause()
	self.Controller:OnPause()
end

function DualTeamExploreMazeConfirmUI:OnResume()
	self.Controller:OnResume()
end

function DualTeamExploreMazeConfirmUI:OnCover()
	self.Controller:OnCover()
end

function DualTeamExploreMazeConfirmUI:OnReveal()
	self.Controller:OnReveal()
end

function DualTeamExploreMazeConfirmUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function DualTeamExploreMazeConfirmUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function DualTeamExploreMazeConfirmUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function DualTeamExploreMazeConfirmUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function DualTeamExploreMazeConfirmUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function DualTeamExploreMazeConfirmUI:OnDestroy()
	self.Controller:OnDestroy()
end

return DualTeamExploreMazeConfirmUI
