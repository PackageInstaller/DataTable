-- chunkname: @IQIGame\\UI\\DualTeamExploreSeparateConfirmUI.lua

local DualTeamExploreSeparateConfirmUIController = require("IQIGame.UI.DualTeamExplore.ActivityUI.DualTeamExploreSeparateConfirmUIController")
local DualTeamExploreSeparateConfirmUI = {}

DualTeamExploreSeparateConfirmUI = Base:Extend("DualTeamExploreSeparateConfirmUI", "IQIGame.Onigao.UI.DualTeamExploreSeparateConfirmUI", DualTeamExploreSeparateConfirmUI)

function DualTeamExploreSeparateConfirmUI:GetViewPath()
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	return cfgDualTeamExploreControlData.DualTeamExploreSeparateConfirmUI
end

function DualTeamExploreSeparateConfirmUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function DualTeamExploreSeparateConfirmUI:GetPreloadAssetPaths()
	self.Controller = DualTeamExploreSeparateConfirmUIController.New(self.UIController)

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

function DualTeamExploreSeparateConfirmUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function DualTeamExploreSeparateConfirmUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function DualTeamExploreSeparateConfirmUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function DualTeamExploreSeparateConfirmUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function DualTeamExploreSeparateConfirmUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function DualTeamExploreSeparateConfirmUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function DualTeamExploreSeparateConfirmUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function DualTeamExploreSeparateConfirmUI:OnPause()
	self.Controller:OnPause()
end

function DualTeamExploreSeparateConfirmUI:OnResume()
	self.Controller:OnResume()
end

function DualTeamExploreSeparateConfirmUI:OnCover()
	self.Controller:OnCover()
end

function DualTeamExploreSeparateConfirmUI:OnReveal()
	self.Controller:OnReveal()
end

function DualTeamExploreSeparateConfirmUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function DualTeamExploreSeparateConfirmUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function DualTeamExploreSeparateConfirmUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function DualTeamExploreSeparateConfirmUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function DualTeamExploreSeparateConfirmUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function DualTeamExploreSeparateConfirmUI:OnDestroy()
	self.Controller:OnDestroy()
end

return DualTeamExploreSeparateConfirmUI
