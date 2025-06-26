-- chunkname: @IQIGame\\UI\\MazeBossChallengeDetailUI.lua

local MazeBossChallengeDetailUIController = require("IQIGame.UI.RPGActivityUI.MazeBossChallengeDetailUIController")
local MazeBossChallengeDetailUI = {}

MazeBossChallengeDetailUI = Base:Extend("MazeBossChallengeDetailUI", "IQIGame.Onigao.UI.MazeBossChallengeDetailUI", MazeBossChallengeDetailUI)

function MazeBossChallengeDetailUI:GetViewPath()
	local cfgRPGMazeControlData = CfgRPGMazeControlTable[RpgMazeModule.DailyDupPOD.rpgMazePOD.controlCid]

	return cfgRPGMazeControlData.MazeBossChallengeDetailUI
end

function MazeBossChallengeDetailUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function MazeBossChallengeDetailUI:GetPreloadAssetPaths()
	self.Controller = MazeBossChallengeDetailUIController.New(self.UIController)

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

function MazeBossChallengeDetailUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function MazeBossChallengeDetailUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function MazeBossChallengeDetailUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function MazeBossChallengeDetailUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function MazeBossChallengeDetailUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function MazeBossChallengeDetailUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function MazeBossChallengeDetailUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function MazeBossChallengeDetailUI:OnPause()
	self.Controller:OnPause()
end

function MazeBossChallengeDetailUI:OnResume()
	self.Controller:OnResume()
end

function MazeBossChallengeDetailUI:OnCover()
	self.Controller:OnCover()
end

function MazeBossChallengeDetailUI:OnReveal()
	self.Controller:OnReveal()
end

function MazeBossChallengeDetailUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function MazeBossChallengeDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function MazeBossChallengeDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function MazeBossChallengeDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function MazeBossChallengeDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function MazeBossChallengeDetailUI:OnDestroy()
	self.Controller:OnDestroy()
end

return MazeBossChallengeDetailUI
