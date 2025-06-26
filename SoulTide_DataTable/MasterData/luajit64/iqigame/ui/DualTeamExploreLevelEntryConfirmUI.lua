-- chunkname: @IQIGame\\UI\\DualTeamExploreLevelEntryConfirmUI.lua

local DualTeamExploreLevelEntryConfirmUIController = require("IQIGame.UI.DualTeamExplore.ActivityUI.DualTeamExploreLevelEntryConfirmUIController")
local DualTeamExploreLevelEntryConfirmUI = {}

DualTeamExploreLevelEntryConfirmUI = Base:Extend("DualTeamExploreLevelEntryConfirmUI", "IQIGame.Onigao.UI.DualTeamExploreLevelEntryConfirmUI", DualTeamExploreLevelEntryConfirmUI)

function DualTeamExploreLevelEntryConfirmUI:GetViewPath()
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	return cfgDualTeamExploreControlData.DualTeamExploreLevelEntryConfirmUI
end

function DualTeamExploreLevelEntryConfirmUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function DualTeamExploreLevelEntryConfirmUI:GetPreloadAssetPaths()
	self.Controller = DualTeamExploreLevelEntryConfirmUIController.New(self.UIController)

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

function DualTeamExploreLevelEntryConfirmUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function DualTeamExploreLevelEntryConfirmUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function DualTeamExploreLevelEntryConfirmUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function DualTeamExploreLevelEntryConfirmUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function DualTeamExploreLevelEntryConfirmUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function DualTeamExploreLevelEntryConfirmUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function DualTeamExploreLevelEntryConfirmUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function DualTeamExploreLevelEntryConfirmUI:OnPause()
	self.Controller:OnPause()
end

function DualTeamExploreLevelEntryConfirmUI:OnResume()
	self.Controller:OnResume()
end

function DualTeamExploreLevelEntryConfirmUI:OnCover()
	self.Controller:OnCover()
end

function DualTeamExploreLevelEntryConfirmUI:OnReveal()
	self.Controller:OnReveal()
end

function DualTeamExploreLevelEntryConfirmUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function DualTeamExploreLevelEntryConfirmUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function DualTeamExploreLevelEntryConfirmUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function DualTeamExploreLevelEntryConfirmUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function DualTeamExploreLevelEntryConfirmUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function DualTeamExploreLevelEntryConfirmUI:OnDestroy()
	self.Controller:OnDestroy()
end

return DualTeamExploreLevelEntryConfirmUI
