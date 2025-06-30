-- chunkname: @IQIGame\\UI\\DualTeamExploreInputNumberUI.lua

local DualTeamExploreInputNumberUIController = require("IQIGame.UI.DualTeamExplore.ActivityUI.DualTeamExploreInputNumberUIController")
local DualTeamExploreInputNumberUI = {}

DualTeamExploreInputNumberUI = Base:Extend("DualTeamExploreInputNumberUI", "IQIGame.Onigao.UI.DualTeamExploreInputNumberUI", DualTeamExploreInputNumberUI)

function DualTeamExploreInputNumberUI:GetViewPath()
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	return cfgDualTeamExploreControlData.DualTeamExploreInputNumberUI
end

function DualTeamExploreInputNumberUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function DualTeamExploreInputNumberUI:GetPreloadAssetPaths()
	self.Controller = DualTeamExploreInputNumberUIController.New(self.UIController)

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

function DualTeamExploreInputNumberUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function DualTeamExploreInputNumberUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function DualTeamExploreInputNumberUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function DualTeamExploreInputNumberUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function DualTeamExploreInputNumberUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function DualTeamExploreInputNumberUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function DualTeamExploreInputNumberUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function DualTeamExploreInputNumberUI:OnPause()
	self.Controller:OnPause()
end

function DualTeamExploreInputNumberUI:OnResume()
	self.Controller:OnResume()
end

function DualTeamExploreInputNumberUI:OnCover()
	self.Controller:OnCover()
end

function DualTeamExploreInputNumberUI:OnReveal()
	self.Controller:OnReveal()
end

function DualTeamExploreInputNumberUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function DualTeamExploreInputNumberUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function DualTeamExploreInputNumberUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function DualTeamExploreInputNumberUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function DualTeamExploreInputNumberUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function DualTeamExploreInputNumberUI:OnDestroy()
	self.Controller:OnDestroy()
end

return DualTeamExploreInputNumberUI
