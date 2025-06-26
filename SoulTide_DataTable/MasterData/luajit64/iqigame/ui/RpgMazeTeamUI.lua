-- chunkname: @IQIGame\\UI\\RpgMazeTeamUI.lua

local RpgMazeTeamUIController = require("IQIGame.UI.RPGActivityUI.RpgMazeTeamUIController")
local RpgMazeTeamUI = {}

RpgMazeTeamUI = Base:Extend("RpgMazeTeamUI", "IQIGame.Onigao.UI.RpgMazeTeamUI", RpgMazeTeamUI)

function RpgMazeTeamUI:GetViewPath()
	if HorizontalRPGModule.IsShow() then
		local cfgRPGMazeControlData = CfgHorizontalRPGControlTable[HorizontalRPGModule.globalCid]

		return cfgRPGMazeControlData.HorizontalRPGMazeTeamUI
	end

	local cfgRPGMazeControlData = CfgRPGMazeControlTable[RpgMazeModule.DailyDupPOD.rpgMazePOD.controlCid]

	return cfgRPGMazeControlData.RpgMazeTeamUI
end

function RpgMazeTeamUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function RpgMazeTeamUI:GetPreloadAssetPaths()
	self.Controller = RpgMazeTeamUIController.New(self.UIController)

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

function RpgMazeTeamUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function RpgMazeTeamUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function RpgMazeTeamUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function RpgMazeTeamUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function RpgMazeTeamUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function RpgMazeTeamUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function RpgMazeTeamUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function RpgMazeTeamUI:OnPause()
	self.Controller:OnPause()
end

function RpgMazeTeamUI:OnResume()
	self.Controller:OnResume()
end

function RpgMazeTeamUI:OnCover()
	self.Controller:OnCover()
end

function RpgMazeTeamUI:OnReveal()
	self.Controller:OnReveal()
end

function RpgMazeTeamUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function RpgMazeTeamUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function RpgMazeTeamUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function RpgMazeTeamUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function RpgMazeTeamUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function RpgMazeTeamUI:OnDestroy()
	self.Controller:OnDestroy()
end

return RpgMazeTeamUI
