-- chunkname: @IQIGame\\UI\\RpgMazeDetailUI.lua

local RpgMazeDetailUIController = require("IQIGame.UI.RPGActivityUI.RpgMazeDetailUIController")
local RpgMazeDetailUI = {}

RpgMazeDetailUI = Base:Extend("RpgMazeDetailUI", "IQIGame.Onigao.UI.RpgMazeDetailUI", RpgMazeDetailUI)

function RpgMazeDetailUI:GetViewPath()
	local cfgRPGMazeControlData = CfgRPGMazeControlTable[RpgMazeModule.DailyDupPOD.rpgMazePOD.controlCid]

	return cfgRPGMazeControlData.RpgMazeDetailUI
end

function RpgMazeDetailUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function RpgMazeDetailUI:GetPreloadAssetPaths()
	self.Controller = RpgMazeDetailUIController.New(self.UIController)

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

function RpgMazeDetailUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function RpgMazeDetailUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function RpgMazeDetailUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function RpgMazeDetailUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function RpgMazeDetailUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function RpgMazeDetailUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function RpgMazeDetailUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function RpgMazeDetailUI:OnPause()
	self.Controller:OnPause()
end

function RpgMazeDetailUI:OnResume()
	self.Controller:OnResume()
end

function RpgMazeDetailUI:OnCover()
	self.Controller:OnCover()
end

function RpgMazeDetailUI:OnReveal()
	self.Controller:OnReveal()
end

function RpgMazeDetailUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function RpgMazeDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function RpgMazeDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function RpgMazeDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function RpgMazeDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function RpgMazeDetailUI:OnDestroy()
	self.Controller:OnDestroy()
end

return RpgMazeDetailUI
