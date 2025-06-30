-- chunkname: @IQIGame\\UI\\DualTeamExploreBagUI.lua

local DualTeamExploreBagUIController = require("IQIGame.UI.DualTeamExplore.ActivityUI.DualTeamExploreBagUIController")
local DualTeamExploreBagUI = {}

DualTeamExploreBagUI = Base:Extend("DualTeamExploreBagUI", "IQIGame.Onigao.UI.DualTeamExploreBagUI", DualTeamExploreBagUI)

function DualTeamExploreBagUI:GetViewPath()
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	return cfgDualTeamExploreControlData.DualTeamExploreBagUI
end

function DualTeamExploreBagUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function DualTeamExploreBagUI:GetPreloadAssetPaths()
	self.Controller = DualTeamExploreBagUIController.New(self.UIController)

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

function DualTeamExploreBagUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function DualTeamExploreBagUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function DualTeamExploreBagUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function DualTeamExploreBagUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function DualTeamExploreBagUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function DualTeamExploreBagUI:OnPause()
	self.Controller:OnPause()
end

function DualTeamExploreBagUI:OnResume()
	self.Controller:OnResume()
end

function DualTeamExploreBagUI:OnCover()
	self.Controller:OnCover()
end

function DualTeamExploreBagUI:OnReveal()
	self.Controller:OnReveal()
end

function DualTeamExploreBagUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function DualTeamExploreBagUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function DualTeamExploreBagUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function DualTeamExploreBagUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function DualTeamExploreBagUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function DualTeamExploreBagUI:OnDestroy()
	self.Controller:OnDestroy()
end

function DualTeamExploreBagUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function DualTeamExploreBagUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

return DualTeamExploreBagUI
