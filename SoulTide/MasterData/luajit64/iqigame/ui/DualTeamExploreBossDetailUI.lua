-- chunkname: @IQIGame\\UI\\DualTeamExploreBossDetailUI.lua

local DualTeamExploreBossDetailUIController = require("IQIGame.UI.DualTeamExplore.ActivityUI.DualTeamExploreBossDetailUIController")
local DualTeamExploreBossDetailUI = {}

DualTeamExploreBossDetailUI = Base:Extend("DualTeamExploreBossDetailUI", "IQIGame.Onigao.UI.DualTeamExploreBossDetailUI", DualTeamExploreBossDetailUI)

function DualTeamExploreBossDetailUI:GetViewPath()
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	return cfgDualTeamExploreControlData.DualTeamExploreBossDetailUI
end

function DualTeamExploreBossDetailUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function DualTeamExploreBossDetailUI:GetPreloadAssetPaths()
	self.Controller = DualTeamExploreBossDetailUIController.New(self.UIController)

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

function DualTeamExploreBossDetailUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function DualTeamExploreBossDetailUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function DualTeamExploreBossDetailUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function DualTeamExploreBossDetailUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function DualTeamExploreBossDetailUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function DualTeamExploreBossDetailUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function DualTeamExploreBossDetailUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function DualTeamExploreBossDetailUI:OnPause()
	self.Controller:OnPause()
end

function DualTeamExploreBossDetailUI:OnResume()
	self.Controller:OnResume()
end

function DualTeamExploreBossDetailUI:OnCover()
	self.Controller:OnCover()
end

function DualTeamExploreBossDetailUI:OnReveal()
	self.Controller:OnReveal()
end

function DualTeamExploreBossDetailUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function DualTeamExploreBossDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function DualTeamExploreBossDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function DualTeamExploreBossDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function DualTeamExploreBossDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function DualTeamExploreBossDetailUI:OnDestroy()
	self.Controller:OnDestroy()
end

return DualTeamExploreBossDetailUI
