-- chunkname: @IQIGame\\UI\\DualTeamExploreMainUI.lua

local DualTeamExploreMainUIController = require("IQIGame.UI.DualTeamExplore.ActivityUI.DualTeamExploreMainUIController")
local DualTeamExploreMainUI = {}

DualTeamExploreMainUI = Base:Extend("DualTeamExploreMainUI", "IQIGame.Onigao.UI.DualTeamExploreMainUI", DualTeamExploreMainUI)

function DualTeamExploreMainUI:GetViewPath()
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	return cfgDualTeamExploreControlData.DualTeamExploreMainUI
end

function DualTeamExploreMainUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function DualTeamExploreMainUI:GetPreloadAssetPaths()
	self.Controller = DualTeamExploreMainUIController.New(self.UIController)

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

function DualTeamExploreMainUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function DualTeamExploreMainUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function DualTeamExploreMainUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function DualTeamExploreMainUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function DualTeamExploreMainUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function DualTeamExploreMainUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function DualTeamExploreMainUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function DualTeamExploreMainUI:OnPause()
	self.Controller:OnPause()
end

function DualTeamExploreMainUI:OnResume()
	self.Controller:OnResume()
end

function DualTeamExploreMainUI:OnCover()
	self.Controller:OnCover()
end

function DualTeamExploreMainUI:OnReveal()
	self.Controller:OnReveal()
end

function DualTeamExploreMainUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function DualTeamExploreMainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function DualTeamExploreMainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function DualTeamExploreMainUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function DualTeamExploreMainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function DualTeamExploreMainUI:OnDestroy()
	self.Controller:OnDestroy()
end

return DualTeamExploreMainUI
