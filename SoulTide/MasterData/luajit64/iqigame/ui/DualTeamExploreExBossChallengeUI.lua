-- chunkname: @IQIGame\\UI\\DualTeamExploreExBossChallengeUI.lua

local DualTeamExploreExBossChallengeUIController = require("IQIGame.UI.DualTeamExplore.ActivityUI.DualTeamExploreExBossChallengeUIController")
local DualTeamExploreExBossChallengeUI = {}

DualTeamExploreExBossChallengeUI = Base:Extend("DualTeamExploreExBossChallengeUI", "IQIGame.Onigao.UI.DualTeamExploreExBossChallengeUI", DualTeamExploreExBossChallengeUI)

function DualTeamExploreExBossChallengeUI:GetViewPath()
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	return cfgDualTeamExploreControlData.DualTeamExploreExBossChallengeUI
end

function DualTeamExploreExBossChallengeUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function DualTeamExploreExBossChallengeUI:GetPreloadAssetPaths()
	self.Controller = DualTeamExploreExBossChallengeUIController.New(self.UIController)

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

function DualTeamExploreExBossChallengeUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function DualTeamExploreExBossChallengeUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function DualTeamExploreExBossChallengeUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function DualTeamExploreExBossChallengeUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function DualTeamExploreExBossChallengeUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function DualTeamExploreExBossChallengeUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function DualTeamExploreExBossChallengeUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function DualTeamExploreExBossChallengeUI:OnPause()
	self.Controller:OnPause()
end

function DualTeamExploreExBossChallengeUI:OnResume()
	self.Controller:OnResume()
end

function DualTeamExploreExBossChallengeUI:OnCover()
	self.Controller:OnCover()
end

function DualTeamExploreExBossChallengeUI:OnReveal()
	self.Controller:OnReveal()
end

function DualTeamExploreExBossChallengeUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function DualTeamExploreExBossChallengeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function DualTeamExploreExBossChallengeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function DualTeamExploreExBossChallengeUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function DualTeamExploreExBossChallengeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function DualTeamExploreExBossChallengeUI:OnDestroy()
	self.Controller:OnDestroy()
end

return DualTeamExploreExBossChallengeUI
