-- chunkname: @IQIGame\\UI\\DualTeamExploreBattleConfirmUI.lua

local DualTeamExploreBattleConfirmUIController = require("IQIGame.UI.DualTeamExplore.ActivityUI.DualTeamExploreBattleConfirmUIController")
local DualTeamExploreBattleConfirmUI = {}

DualTeamExploreBattleConfirmUI = Base:Extend("DualTeamExploreBattleConfirmUI", "IQIGame.Onigao.UI.DualTeamExploreBattleConfirmUI", DualTeamExploreBattleConfirmUI)

function DualTeamExploreBattleConfirmUI:GetViewPath()
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	return cfgDualTeamExploreControlData.DualTeamExploreBattleConfirmUI
end

function DualTeamExploreBattleConfirmUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function DualTeamExploreBattleConfirmUI:GetPreloadAssetPaths()
	self.Controller = DualTeamExploreBattleConfirmUIController.New(self.UIController)

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

function DualTeamExploreBattleConfirmUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function DualTeamExploreBattleConfirmUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function DualTeamExploreBattleConfirmUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function DualTeamExploreBattleConfirmUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function DualTeamExploreBattleConfirmUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function DualTeamExploreBattleConfirmUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function DualTeamExploreBattleConfirmUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function DualTeamExploreBattleConfirmUI:OnPause()
	self.Controller:OnPause()
end

function DualTeamExploreBattleConfirmUI:OnResume()
	self.Controller:OnResume()
end

function DualTeamExploreBattleConfirmUI:OnCover()
	self.Controller:OnCover()
end

function DualTeamExploreBattleConfirmUI:OnReveal()
	self.Controller:OnReveal()
end

function DualTeamExploreBattleConfirmUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function DualTeamExploreBattleConfirmUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function DualTeamExploreBattleConfirmUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function DualTeamExploreBattleConfirmUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function DualTeamExploreBattleConfirmUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function DualTeamExploreBattleConfirmUI:OnDestroy()
	self.Controller:OnDestroy()
end

return DualTeamExploreBattleConfirmUI
