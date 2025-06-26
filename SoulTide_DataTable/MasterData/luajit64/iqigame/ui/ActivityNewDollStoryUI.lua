-- chunkname: @IQIGame\\UI\\ActivityNewDollStoryUI.lua

local ActivityNewDollStoryUIController = require("IQIGame.UI.Activity.DollBingo.ActivityUI.ActivityNewDollStoryUIController")
local ActivityNewDollStoryUI = {}

ActivityNewDollStoryUI = Base:Extend("ActivityNewDollStoryUI", "IQIGame.Onigao.UI.ActivityNewDollStoryUI", ActivityNewDollStoryUI)

function ActivityNewDollStoryUI:GetViewPath()
	local cfgNewCharacterData = CfgNewCharacterActivityTable[ActiveOperationEventModule.GetEventDataPOD(DollBingoModule.operateEventID).dataCfgId]

	return cfgNewCharacterData.StoryUI
end

function ActivityNewDollStoryUI:OnInit()
	local viewPrefab = self.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(self:GetViewPath()))
	local viewInstance = UnityEngine.Object.Instantiate(viewPrefab)

	viewInstance.transform:SetParent(self.ViewRoot.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent(typeof(UnityEngine.Canvas)), viewInstance)
	self.Controller:InitView(viewInstance)
	self.Controller:OnInit()
end

function ActivityNewDollStoryUI:GetPreloadAssetPaths()
	self.Controller = ActivityNewDollStoryUIController.New(self.UIController)

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

function ActivityNewDollStoryUI:GetOpenPreloadAssetPaths(userData)
	return self.Controller:GetOpenPreloadAssetPaths(userData)
end

function ActivityNewDollStoryUI:IsManualShowOnOpen(userData)
	return self.Controller:IsManualShowOnOpen(userData)
end

function ActivityNewDollStoryUI:GetBGM(userData)
	return self.Controller:GetBGM(userData)
end

function ActivityNewDollStoryUI:OnOpen(userData)
	self.Controller:OnOpen(userData)
end

function ActivityNewDollStoryUI:OnClose(userData)
	self.Controller:OnClose(userData)
end

function ActivityNewDollStoryUI:OnAddListeners()
	self.Controller:OnAddListeners()
end

function ActivityNewDollStoryUI:OnRemoveListeners()
	self.Controller:OnRemoveListeners()
end

function ActivityNewDollStoryUI:OnPause()
	self.Controller:OnPause()
end

function ActivityNewDollStoryUI:OnResume()
	self.Controller:OnResume()
end

function ActivityNewDollStoryUI:OnCover()
	self.Controller:OnCover()
end

function ActivityNewDollStoryUI:OnReveal()
	self.Controller:OnReveal()
end

function ActivityNewDollStoryUI:OnRefocus(userData)
	self.Controller:OnRefocus(userData)
end

function ActivityNewDollStoryUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.Controller:OnUpdate(elapseSeconds, realElapseSeconds)
end

function ActivityNewDollStoryUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	self.Controller:OnDepthChanged(uiGroupDepth, depthInUIGroup)
end

function ActivityNewDollStoryUI:OnLoadSucceed(assetName, asset, duration, userData)
	self.Controller:OnLoadSucceed(assetName, asset, duration, userData)
end

function ActivityNewDollStoryUI:OnLoadFailed(assetName, status, errorMessage, userData)
	self.Controller:OnLoadFailed(assetName, status, errorMessage, userData)
end

function ActivityNewDollStoryUI:OnDestroy()
	self.Controller:OnDestroy()
end

return ActivityNewDollStoryUI
