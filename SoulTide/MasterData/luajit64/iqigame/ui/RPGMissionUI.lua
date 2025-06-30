-- chunkname: @IQIGame\\UI\\RPGMissionUI.lua

local RPGMissionUIController = require("IQIGame.UI.RPGActivityUI.RPGMissionUIController")
local RPGMissionUI = {}

RPGMissionUI = Base:Extend("RPGMissionUI", "IQIGame.Onigao.UI.RPGMissionUI", RPGMissionUI)

function RPGMissionUI:OnInit()
	local cfgRPGMazeControlData = CfgRPGMazeControlTable[RpgMazeModule.DailyDupPOD.rpgMazePOD.controlCid]
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(cfgRPGMazeControlData.RPGMissionUI))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	viewInstance:SetActive(true)
	self.Controller:Init(viewInstance)
	self.Controller:OnInit()
end

function RPGMissionUI:GetPreloadAssetPaths()
	self.Controller = RPGMissionUIController.New(self.UIController)

	local paths = {}
	local cfgRPGMazeControlData = CfgRPGMazeControlTable[RpgMazeModule.DailyDupPOD.rpgMazePOD.controlCid]

	table.insert(paths, UIGlobalApi.GetUIPrefab(cfgRPGMazeControlData.RPGMissionUI))

	local subPaths = self.Controller:GetPreloadAssetPaths()

	if subPaths ~= nil then
		for i = 1, #subPaths do
			table.insert(paths, subPaths[i])
		end
	end

	return paths
end

function RPGMissionUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function RPGMissionUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function RPGMissionUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function RPGMissionUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function RPGMissionUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function RPGMissionUI:OnPause()
	self.Controller:OnPause()
end

function RPGMissionUI:OnResume()
	self.Controller:OnResume()
end

function RPGMissionUI:OnCover()
	self.Controller:OnCover()
end

function RPGMissionUI:OnReveal()
	self.Controller:OnReveal()
end

function RPGMissionUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function RPGMissionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function RPGMissionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function RPGMissionUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function RPGMissionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function RPGMissionUI:OnDestroy()
	self.Controller:OnDestroy()
end

function RPGMissionUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function RPGMissionUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

return RPGMissionUI
