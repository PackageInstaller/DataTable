-- chunkname: @IQIGame\\UI\\DualTeamExploreMazeSettlementUI.lua

local DualTeamExploreMazeSettlementUIController = require("IQIGame.UI.DualTeamExplore.ActivityUI.DualTeamExploreMazeSettlementUIController")
local DualTeamExploreMazeSettlementUI = {}

DualTeamExploreMazeSettlementUI = Base:Extend("DualTeamExploreMazeSettlementUI", "IQIGame.Onigao.UI.DualTeamExploreMazeSettlementUI", DualTeamExploreMazeSettlementUI)

function DualTeamExploreMazeSettlementUI:GetViewPath()
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	return cfgDualTeamExploreControlData.DualTeamExploreMazeSettlementUI
end

function DualTeamExploreMazeSettlementUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function DualTeamExploreMazeSettlementUI:GetPreloadAssetPaths()
	self.Controller = DualTeamExploreMazeSettlementUIController.New(self.UIController)

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

function DualTeamExploreMazeSettlementUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function DualTeamExploreMazeSettlementUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function DualTeamExploreMazeSettlementUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function DualTeamExploreMazeSettlementUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function DualTeamExploreMazeSettlementUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function DualTeamExploreMazeSettlementUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function DualTeamExploreMazeSettlementUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function DualTeamExploreMazeSettlementUI:OnPause()
	self.Controller:OnPause()
end

function DualTeamExploreMazeSettlementUI:OnResume()
	self.Controller:OnResume()
end

function DualTeamExploreMazeSettlementUI:OnCover()
	self.Controller:OnCover()
end

function DualTeamExploreMazeSettlementUI:OnReveal()
	self.Controller:OnReveal()
end

function DualTeamExploreMazeSettlementUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function DualTeamExploreMazeSettlementUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function DualTeamExploreMazeSettlementUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function DualTeamExploreMazeSettlementUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function DualTeamExploreMazeSettlementUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function DualTeamExploreMazeSettlementUI:OnDestroy()
	self.Controller:OnDestroy()
end

return DualTeamExploreMazeSettlementUI
