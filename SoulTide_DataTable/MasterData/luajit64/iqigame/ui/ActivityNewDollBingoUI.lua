-- chunkname: @IQIGame\\UI\\ActivityNewDollBingoUI.lua

local ActivityNewDollBingoUIController = require("IQIGame.UI.Activity.DollBingo.ActivityUI.ActivityNewDollBingoUIController")
local ActivityNewDollBingoUI = {}

ActivityNewDollBingoUI = Base:Extend("ActivityNewDollBingoUI", "IQIGame.Onigao.UI.ActivityNewDollBingoUI", ActivityNewDollBingoUI)

function ActivityNewDollBingoUI:GetViewPath()
	local cfgNewCharacterData = CfgNewCharacterActivityTable[ActiveOperationEventModule.GetEventDataPOD(DollBingoModule.operateEventID).dataCfgId]

	return cfgNewCharacterData.BingoUI
end

function ActivityNewDollBingoUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function ActivityNewDollBingoUI:GetPreloadAssetPaths()
	self.Controller = ActivityNewDollBingoUIController.New(self.UIController)

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

function ActivityNewDollBingoUI:GetOpenPreloadAssetPaths(userData)
	self.operateEventID = userData

	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function ActivityNewDollBingoUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function ActivityNewDollBingoUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function ActivityNewDollBingoUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function ActivityNewDollBingoUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function ActivityNewDollBingoUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function ActivityNewDollBingoUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function ActivityNewDollBingoUI:OnPause()
	self.Controller:OnPause()
end

function ActivityNewDollBingoUI:OnResume()
	self.Controller:OnResume()
end

function ActivityNewDollBingoUI:OnCover()
	self.Controller:OnCover()
end

function ActivityNewDollBingoUI:OnReveal()
	self.Controller:OnReveal()
end

function ActivityNewDollBingoUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function ActivityNewDollBingoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function ActivityNewDollBingoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function ActivityNewDollBingoUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function ActivityNewDollBingoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function ActivityNewDollBingoUI:OnDestroy()
	self.Controller:OnDestroy()
end

return ActivityNewDollBingoUI
