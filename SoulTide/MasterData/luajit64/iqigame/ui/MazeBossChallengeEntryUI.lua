-- chunkname: @IQIGame\\UI\\MazeBossChallengeEntryUI.lua

local MazeBossChallengeEntryUIController = require("IQIGame.UI.RPGActivityUI.MazeBossChallengeEntryUIController")
local MazeBossChallengeEntryUI = {}

MazeBossChallengeEntryUI = Base:Extend("MazeBossChallengeEntryUI", "IQIGame.Onigao.UI.MazeBossChallengeEntryUI", MazeBossChallengeEntryUI)

function MazeBossChallengeEntryUI:GetViewPath()
	local cfgRPGMazeControlData = CfgRPGMazeControlTable[RpgMazeModule.DailyDupPOD.rpgMazePOD.controlCid]

	return cfgRPGMazeControlData.MazeBossChallengeEntryUI
end

function MazeBossChallengeEntryUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function MazeBossChallengeEntryUI:GetPreloadAssetPaths()
	self.Controller = MazeBossChallengeEntryUIController.New(self.UIController)

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

function MazeBossChallengeEntryUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function MazeBossChallengeEntryUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function MazeBossChallengeEntryUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function MazeBossChallengeEntryUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function MazeBossChallengeEntryUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function MazeBossChallengeEntryUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function MazeBossChallengeEntryUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function MazeBossChallengeEntryUI:OnPause()
	self.Controller:OnPause()
end

function MazeBossChallengeEntryUI:OnResume()
	self.Controller:OnResume()
end

function MazeBossChallengeEntryUI:OnCover()
	self.Controller:OnCover()
end

function MazeBossChallengeEntryUI:OnReveal()
	self.Controller:OnReveal()
end

function MazeBossChallengeEntryUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function MazeBossChallengeEntryUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function MazeBossChallengeEntryUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function MazeBossChallengeEntryUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function MazeBossChallengeEntryUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function MazeBossChallengeEntryUI:OnDestroy()
	self.Controller:OnDestroy()
end

return MazeBossChallengeEntryUI
