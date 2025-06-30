-- chunkname: @IQIGame\\UI\\MazeBossDetailUI.lua

local MazeBossDetailUIController = require("IQIGame.UI.RPGActivityUI.MazeBossDetailUIController")
local MazeBossDetailUI = {}

MazeBossDetailUI = Base:Extend("MazeBossDetailUI", "IQIGame.Onigao.UI.MazeBossDetailUI", MazeBossDetailUI)

function MazeBossDetailUI:GetViewPath()
	local cfgRPGMazeControlData = CfgRPGMazeControlTable[RpgMazeModule.DailyDupPOD.rpgMazePOD.controlCid]

	return cfgRPGMazeControlData.MazeBossDetailUI
end

function MazeBossDetailUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	viewInstance:SetActive(true)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function MazeBossDetailUI:GetPreloadAssetPaths()
	self.Controller = MazeBossDetailUIController.New(self.UIController)

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

function MazeBossDetailUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function MazeBossDetailUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function MazeBossDetailUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function MazeBossDetailUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function MazeBossDetailUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function MazeBossDetailUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function MazeBossDetailUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function MazeBossDetailUI:OnPause()
	self.Controller:OnPause()
end

function MazeBossDetailUI:OnResume()
	self.Controller:OnResume()
end

function MazeBossDetailUI:OnCover()
	self.Controller:OnCover()
end

function MazeBossDetailUI:OnReveal()
	self.Controller:OnReveal()
end

function MazeBossDetailUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function MazeBossDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function MazeBossDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function MazeBossDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function MazeBossDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function MazeBossDetailUI:OnDestroy()
	self.Controller:OnDestroy()
end

return MazeBossDetailUI
