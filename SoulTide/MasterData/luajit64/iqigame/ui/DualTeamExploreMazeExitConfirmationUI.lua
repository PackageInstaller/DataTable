-- chunkname: @IQIGame\\UI\\DualTeamExploreMazeExitConfirmationUI.lua

local DualTeamExploreMazeExitConfirmationUIController = require("IQIGame.UI.DualTeamExplore.ActivityUI.DualTeamExploreMazeExitConfirmationUIController")
local DualTeamExploreMazeExitConfirmationUI = {}

DualTeamExploreMazeExitConfirmationUI = Base:Extend("DualTeamExploreMazeExitConfirmationUI", "IQIGame.Onigao.UI.DualTeamExploreMazeExitConfirmationUI", DualTeamExploreMazeExitConfirmationUI)

function DualTeamExploreMazeExitConfirmationUI:GetViewPath()
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	return cfgDualTeamExploreControlData.DualTeamExploreMazeExitConfirmationUI
end

function DualTeamExploreMazeExitConfirmationUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function DualTeamExploreMazeExitConfirmationUI:GetPreloadAssetPaths()
	self.Controller = DualTeamExploreMazeExitConfirmationUIController.New(self.UIController)

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

function DualTeamExploreMazeExitConfirmationUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function DualTeamExploreMazeExitConfirmationUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function DualTeamExploreMazeExitConfirmationUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function DualTeamExploreMazeExitConfirmationUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function DualTeamExploreMazeExitConfirmationUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function DualTeamExploreMazeExitConfirmationUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function DualTeamExploreMazeExitConfirmationUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function DualTeamExploreMazeExitConfirmationUI:OnPause()
	self.Controller:OnPause()
end

function DualTeamExploreMazeExitConfirmationUI:OnResume()
	self.Controller:OnResume()
end

function DualTeamExploreMazeExitConfirmationUI:OnCover()
	self.Controller:OnCover()
end

function DualTeamExploreMazeExitConfirmationUI:OnReveal()
	self.Controller:OnReveal()
end

function DualTeamExploreMazeExitConfirmationUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function DualTeamExploreMazeExitConfirmationUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function DualTeamExploreMazeExitConfirmationUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function DualTeamExploreMazeExitConfirmationUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function DualTeamExploreMazeExitConfirmationUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function DualTeamExploreMazeExitConfirmationUI:OnDestroy()
	self.Controller:OnDestroy()
end

return DualTeamExploreMazeExitConfirmationUI
