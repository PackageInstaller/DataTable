-- chunkname: @IQIGame\\UI\\RpgMazeEntryUI.lua

local RpgMazeEntryUIController = require("IQIGame.UI.RPGActivityUI.RpgMazeEntryUIController")
local RpgMazeEntryUI = {}

RpgMazeEntryUI = Base:Extend("RpgMazeEntryUI", "IQIGame.Onigao.UI.RpgMazeEntryUI", RpgMazeEntryUI)

function RpgMazeEntryUI:OnInit()
	local cfgRPGMazeControlData = CfgRPGMazeControlTable[RpgMazeModule.DailyDupPOD.rpgMazePOD.controlCid]
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(cfgRPGMazeControlData.RpgMazeEntryUI))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	viewInstance:SetActive(true)
	self.Controller:Init(viewInstance)
	self.Controller:OnInit()
end

function RpgMazeEntryUI:GetPreloadAssetPaths()
	self.Controller = RpgMazeEntryUIController.New(self.UIController)

	local paths = {}
	local cfgRPGMazeControlData = CfgRPGMazeControlTable[RpgMazeModule.DailyDupPOD.rpgMazePOD.controlCid]

	table.insert(paths, UIGlobalApi.GetUIPrefab(cfgRPGMazeControlData.RpgMazeEntryUI))

	local subPaths = self.Controller:GetPreloadAssetPaths()

	if subPaths ~= nil then
		for i = 1, #subPaths do
			table.insert(paths, subPaths[i])
		end
	end

	return paths
end

function RpgMazeEntryUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function RpgMazeEntryUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function RpgMazeEntryUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function RpgMazeEntryUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function RpgMazeEntryUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function RpgMazeEntryUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function RpgMazeEntryUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function RpgMazeEntryUI:OnPause()
	self.Controller:OnPause()
end

function RpgMazeEntryUI:OnResume()
	self.Controller:OnResume()
end

function RpgMazeEntryUI:OnCover()
	self.Controller:OnCover()
end

function RpgMazeEntryUI:OnReveal()
	self.Controller:OnReveal()
end

function RpgMazeEntryUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function RpgMazeEntryUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function RpgMazeEntryUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function RpgMazeEntryUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function RpgMazeEntryUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function RpgMazeEntryUI:OnDestroy()
	self.Controller:OnDestroy()
end

return RpgMazeEntryUI
