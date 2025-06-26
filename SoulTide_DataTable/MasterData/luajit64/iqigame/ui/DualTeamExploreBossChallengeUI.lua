-- chunkname: @IQIGame\\UI\\DualTeamExploreBossChallengeUI.lua

local DualTeamExploreBossChallengeUIController = require("IQIGame.UI.DualTeamExplore.ActivityUI.DualTeamExploreBossChallengeUIController")
local DualTeamExploreBossChallengeUI = {}

DualTeamExploreBossChallengeUI = Base:Extend("DualTeamExploreBossChallengeUI", "IQIGame.Onigao.UI.DualTeamExploreBossChallengeUI", DualTeamExploreBossChallengeUI)

function DualTeamExploreBossChallengeUI:GetViewPath()
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	return cfgDualTeamExploreControlData.DualTeamExploreBossChallengeUI
end

function DualTeamExploreBossChallengeUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function DualTeamExploreBossChallengeUI:GetPreloadAssetPaths()
	self.Controller = DualTeamExploreBossChallengeUIController.New(self.UIController)

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

function DualTeamExploreBossChallengeUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function DualTeamExploreBossChallengeUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function DualTeamExploreBossChallengeUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function DualTeamExploreBossChallengeUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function DualTeamExploreBossChallengeUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function DualTeamExploreBossChallengeUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function DualTeamExploreBossChallengeUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function DualTeamExploreBossChallengeUI:OnPause()
	self.Controller:OnPause()
end

function DualTeamExploreBossChallengeUI:OnResume()
	self.Controller:OnResume()
end

function DualTeamExploreBossChallengeUI:OnCover()
	self.Controller:OnCover()
end

function DualTeamExploreBossChallengeUI:OnReveal()
	self.Controller:OnReveal()
end

function DualTeamExploreBossChallengeUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function DualTeamExploreBossChallengeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function DualTeamExploreBossChallengeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function DualTeamExploreBossChallengeUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function DualTeamExploreBossChallengeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function DualTeamExploreBossChallengeUI:OnDestroy()
	self.Controller:OnDestroy()
end

return DualTeamExploreBossChallengeUI
