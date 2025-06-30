-- chunkname: @IQIGame\\UI\\ActivityListUI.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local activityListTabView = require("IQIGame.UI.ActivityList.ActivityListTabView")
local ActivityListUI = {
	normalIndex = 1
}

ActivityListUI = Base:Extend("ActivityListUI", "IQIGame.Onigao.UI.ActivityListUI", ActivityListUI)

function ActivityListUI:OnInit()
	function self.DelegateOnClickTab(cfgID)
		self:OnClickTab(cfgID)
	end

	function self.DelegateOnTaskNotifyEvent()
		self:OnTaskNotifyEvent()
	end

	function self.DelegateOnTaskRemoveEvent()
		self:OnTaskNotifyEvent()
	end

	function self.DelegateOnActivityUpdateEvent()
		self:OnActivityUpdateEvent()
	end

	function self.DelegateOnTaskFinishEvent()
		self:OnTaskFinishEvent()
	end

	function self.DelegateOnClearRedDotEvent()
		self:OnClearRedDotEvent()
	end

	self.tabItemPool = UIViewObjectPool.New(self.TabPrefab, self.LeftTabContent.transform, function(_view)
		return activityListTabView.New(_view, self.DelegateOnClickTab)
	end)
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
end

function ActivityListUI:GetPreloadAssetPaths()
	local preloadAssets = {}

	for k, v in pairsCfg(CfgActivityListTable) do
		if not LuaUtility.StrIsNullOrEmpty(v.Background) then
			table.insert(preloadAssets, UIGlobalApi.GetImagePath(v.Background))
		end
	end

	return preloadAssets
end

function ActivityListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ActivityListUI:IsManualShowOnOpen(userData)
	return false
end

function ActivityListUI:GetBGM(userData)
	return nil
end

function ActivityListUI:OnOpen(userData)
	self.lastCfgID = nil
	self.selectCfgID = nil
	self.teamID = userData.teamID
	self.selectViewType = userData.selectViewType

	self:InitViewInfo()
end

function ActivityListUI:OnClose(userData)
	self:DestoryLastActivityGameObject()
end

function ActivityListUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.TaskNotifyTask, self.DelegateOnTaskNotifyEvent)
	EventDispatcher.AddEventListener(EventID.ActivityUpdateEvent, self.DelegateOnActivityUpdateEvent)
	EventDispatcher.AddEventListener(EventID.TaskNotifyFinish, self.DelegateOnTaskFinishEvent)
	EventDispatcher.AddEventListener(EventID.ClearRedDotEvent, self.DelegateOnClearRedDotEvent)
	EventDispatcher.AddEventListener(EventID.TaskNotifyRemove, self.DelegateOnTaskRemoveEvent)
end

function ActivityListUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyTask, self.DelegateOnTaskNotifyEvent)
	EventDispatcher.RemoveEventListener(EventID.ActivityUpdateEvent, self.DelegateOnActivityUpdateEvent)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyFinish, self.DelegateOnTaskFinishEvent)
	EventDispatcher.RemoveEventListener(EventID.ClearRedDotEvent, self.DelegateOnClearRedDotEvent)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyRemove, self.DelegateOnTaskRemoveEvent)
end

function ActivityListUI:OnPause()
	return
end

function ActivityListUI:OnResume()
	return
end

function ActivityListUI:OnCover()
	if self.activityInstance then
		self.activityInstance:__OnCover()
	end
end

function ActivityListUI:OnReveal()
	if self.activityInstance then
		self.activityInstance:__OnReveal()
	end
end

function ActivityListUI:OnRefocus(userData)
	return
end

function ActivityListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ActivityListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	if self.activityInstance then
		self.activityInstance:__OnDepthChanged(uiGroupDepth, depthInUIGroup)
	end
end

function ActivityListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ActivityListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ActivityListUI:OnDestroy()
	self.tabItemPool:Dispose(function(_item)
		_item:Dispose()
	end)

	self.tabItemPool = nil

	self:DestoryLastActivityGameObject()
	self.commonReturnBtn:Dispose()
	AssetUtil.UnloadAsset(self)
end

function ActivityListUI:InitViewInfo()
	self.tabList = ActivityListModule.GetActivityListByTeamID(self.teamID)

	self:InitSelectViewIndex()

	self.needItRefreshSelectTab = self.selectCfgID == nil or not ActivityListModule.GetActivityListCfgIsExist(self.selectCfgID, self.tabList)

	self:CreateTeamTabList()
end

function ActivityListUI:InitSelectViewIndex()
	self.normalIndex = 1

	if self.selectViewType ~= nil then
		for i = 1, #self.tabList do
			if self.tabList[i].ActivityType == self.selectViewType then
				self.normalIndex = i
				self.selectViewType = nil

				break
			end
		end
	end
end

function ActivityListUI:CreateTeamTabList()
	self.tabItemPool:ForItems(function(_item)
		_item:Hide()
	end)

	for i = 1, #self.tabList do
		local tabItem = self.tabItemPool:GetFree(function(_item)
			return not _item.View.activeSelf
		end)

		tabItem:Show()
		tabItem:SetData(self.tabList[i])

		if i == self.normalIndex and self.needItRefreshSelectTab then
			tabItem:OnClickBtn()
		end
	end
end

function ActivityListUI:OnClickTab(cfgID)
	self.tabItemPool:ForItems(function(_item)
		_item:OnUnSelected()
	end)

	self.selectCfgID = cfgID

	if self.selectCfgID == self.lastCfgID then
		return
	else
		self:DestoryLastActivityGameObject()
	end

	self.selectActivityListCfg = CfgActivityListTable[self.selectCfgID]

	local prefabPath = UIGlobalApi.GetUIPrefab(self.selectActivityListCfg.ActivityPrefab)

	AssetUtil.LoadAsset(self, prefabPath, self.OnLoadPrefabSuccess)

	local asset = self.UIController:GetPreloadedAsset(UIGlobalApi.GetImagePath(self.selectActivityListCfg.Background))

	self.Background:GetComponent("Image").sprite = asset
	self.lastCfgID = self.selectCfgID
end

function ActivityListUI:OnLoadPrefabSuccess(assetName, asset, duration, userData)
	self.activityInstance = ActivityListModule.GetActivityListGameobjectLuaByType(self.selectActivityListCfg.ActivityType, GameObject.Instantiate(asset, self.ActivityContent.transform))

	self.activityInstance:Show()
	self.activityInstance:SetData(self.selectActivityListCfg)
end

function ActivityListUI:DestoryLastActivityGameObject()
	if self.activityInstance ~= nil then
		self.activityInstance:Dispose()

		self.activityInstance = nil
	end
end

function ActivityListUI:OnTaskNotifyEvent()
	self:RefreshTabsRedDot()
end

function ActivityListUI:OnActivityUpdateEvent()
	self:InitViewInfo()
	self:RefreshTabsRedDot()
end

function ActivityListUI:OnTaskFinishEvent()
	self:InitViewInfo()
	self:RefreshTabsRedDot()
end

function ActivityListUI:OnClearRedDotEvent()
	self:RefreshTabsRedDot()
end

function ActivityListUI:RefreshTabsRedDot()
	self.tabItemPool:ForItems(function(_item)
		if _item.View.activeSelf then
			_item:RefreshRedDot()
		end
	end)
end

return ActivityListUI
