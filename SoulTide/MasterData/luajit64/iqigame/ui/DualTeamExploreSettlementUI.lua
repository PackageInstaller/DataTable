-- chunkname: @IQIGame\\UI\\DualTeamExploreSettlementUI.lua

local DualTeamExploreSettlementUIController = require("IQIGame.UI.DualTeamExplore.ActivityUI.DualTeamExploreSettlementUIController")
local DualTeamExploreSettlementUI = {}

DualTeamExploreSettlementUI = Base:Extend("DualTeamExploreSettlementUI", "IQIGame.Onigao.UI.DualTeamExploreSettlementUI", DualTeamExploreSettlementUI)

function DualTeamExploreSettlementUI:GetViewPath()
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	return cfgDualTeamExploreControlData.DualTeamExploreSettlementUI
end

function DualTeamExploreSettlementUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function DualTeamExploreSettlementUI:GetPreloadAssetPaths()
	self.Controller = DualTeamExploreSettlementUIController.New(self.UIController)

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

function DualTeamExploreSettlementUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function DualTeamExploreSettlementUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function DualTeamExploreSettlementUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function DualTeamExploreSettlementUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function DualTeamExploreSettlementUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function DualTeamExploreSettlementUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function DualTeamExploreSettlementUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function DualTeamExploreSettlementUI:OnPause()
	self.Controller:OnPause()
end

function DualTeamExploreSettlementUI:OnResume()
	self.Controller:OnResume()
end

function DualTeamExploreSettlementUI:OnCover()
	self.Controller:OnCover()
end

function DualTeamExploreSettlementUI:OnReveal()
	self.Controller:OnReveal()
end

function DualTeamExploreSettlementUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function DualTeamExploreSettlementUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function DualTeamExploreSettlementUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function DualTeamExploreSettlementUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function DualTeamExploreSettlementUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function DualTeamExploreSettlementUI:OnDestroy()
	self.Controller:OnDestroy()
end

return DualTeamExploreSettlementUI
