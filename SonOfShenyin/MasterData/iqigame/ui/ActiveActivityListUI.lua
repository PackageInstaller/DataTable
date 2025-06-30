-- chunkname: @IQIGame\\UI\\ActiveActivityListUI.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local activityListTabView = require("IQIGame.UI.ActiveActivityList.ActiveActivityListTabView")
local ActiveActivityListUI = {
	normalIndex = 1
}

ActiveActivityListUI = Base:Extend("ActiveActivityListUI", "IQIGame.Onigao.UI.ActiveActivityListUI", ActiveActivityListUI)

function ActiveActivityListUI:OnInit()
	function self.DelegateOnClickTab(isFather, cfgID, fatherTabView)
		self:OnClickTab(isFather, cfgID, fatherTabView)
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

function ActiveActivityListUI:GetPreloadAssetPaths()
	local preloadAssets = {}

	for k, v in pairsCfg(CfgActivityListTable) do
		table.insert(preloadAssets, UIGlobalApi.GetImagePath(v.Background))
	end

	return preloadAssets
end

function ActiveActivityListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ActiveActivityListUI:IsManualShowOnOpen(userData)
	return false
end

function ActiveActivityListUI:GetBGM(userData)
	return nil
end

function ActiveActivityListUI:OnOpen(userData)
	self.lastCfgID = nil
	self.selectCfgID = nil
	self.fatherTabCfgID = nil
	self.teamID = userData.teamID
	self.selectViewType = userData.selectViewType

	self:InitViewInfo()
end

function ActiveActivityListUI:OnClose(userData)
	self:DestoryLastActivityGameObject()
end

function ActiveActivityListUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.TaskNotifyTask, self.DelegateOnTaskNotifyEvent)
	EventDispatcher.AddEventListener(EventID.ActivityUpdateEvent, self.DelegateOnActivityUpdateEvent)
	EventDispatcher.AddEventListener(EventID.TaskNotifyFinish, self.DelegateOnTaskFinishEvent)
	EventDispatcher.AddEventListener(EventID.ClearRedDotEvent, self.DelegateOnClearRedDotEvent)
	EventDispatcher.AddEventListener(EventID.TaskNotifyRemove, self.DelegateOnTaskRemoveEvent)
end

function ActiveActivityListUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyTask, self.DelegateOnTaskNotifyEvent)
	EventDispatcher.RemoveEventListener(EventID.ActivityUpdateEvent, self.DelegateOnActivityUpdateEvent)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyFinish, self.DelegateOnTaskFinishEvent)
	EventDispatcher.RemoveEventListener(EventID.ClearRedDotEvent, self.DelegateOnClearRedDotEvent)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyRemove, self.DelegateOnTaskRemoveEvent)
end

function ActiveActivityListUI:OnPause()
	return
end

function ActiveActivityListUI:OnResume()
	return
end

function ActiveActivityListUI:OnCover()
	if self.activityInstance then
		self.activityInstance:__OnCover()
	end
end

function ActiveActivityListUI:OnReveal()
	if self.activityInstance then
		self.activityInstance:__OnReveal()
	end
end

function ActiveActivityListUI:OnRefocus(userData)
	return
end

function ActiveActivityListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ActiveActivityListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	if self.activityInstance then
		self.activityInstance:__OnDepthChanged(uiGroupDepth, depthInUIGroup)
	end
end

function ActiveActivityListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ActiveActivityListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ActiveActivityListUI:OnDestroy()
	self.tabItemPool:Dispose(function(_item)
		_item:Dispose()
	end)

	self.tabItemPool = nil

	self:DestoryLastActivityGameObject()
	self.commonReturnBtn:Dispose()
	AssetUtil.UnloadAsset(self)
end

function ActiveActivityListUI:InitViewInfo()
	self.tabList = ActiveActivityListModule.GetActivityListByTeamID(self.teamID)

	self:InitSelectViewIndex()

	self.needItRefreshSelectTab = self.fatherTabCfgID == nil or not ActiveActivityListModule.GetActivityListCfgIsExist(self.fatherTabCfgID, self.tabList)

	self:CreateTeamTabList()
end

function ActiveActivityListUI:InitSelectViewIndex()
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

function ActiveActivityListUI:CreateTeamTabList()
	self.tabItemPool:ForItems(function(_item)
		_item:Hide()
	end)

	for i = 1, #self.tabList do
		local tabItem = self.tabItemPool:GetFree(function(_item)
			return not _item.View.activeSelf
		end)

		tabItem:Show()
		tabItem:SetData(self.tabList[i])

		if i == self.normalIndex then
			self.firstTabItem = tabItem
		end
	end

	if self.firstTabItem ~= nil and self.needItRefreshSelectTab then
		self.firstTabItem:OnClickBtn()
	end
end

function ActiveActivityListUI:OnClickTab(isFather, cfgID, fatherTabView)
	if isFather then
		self.fatherTabCfgID = cfgID
	end

	self.selectCfgID = cfgID

	if self.selectCfgID == self.lastCfgID then
		return
	end

	self.tabItemPool:ForItems(function(_item)
		if fatherTabView ~= _item then
			_item:OnUnSelected()
		end
	end)
	self:DestoryLastActivityGameObject()

	self.selectActivityListCfg = CfgActivityListTable[self.selectCfgID]

	local prefabPath = UIGlobalApi.GetUIPrefab(self.selectActivityListCfg.ActivityPrefab)

	AssetUtil.LoadAsset(self, prefabPath, self.OnLoadPrefabSuccess)

	local asset = self.UIController:GetPreloadedAsset(UIGlobalApi.GetImagePath(self.selectActivityListCfg.Background))

	self.Background:GetComponent("Image").sprite = asset
	self.lastCfgID = self.selectCfgID
end

function ActiveActivityListUI:OnLoadPrefabSuccess(assetName, asset, duration, userData)
	self.activityInstance = ActiveActivityListModule.GetActivityListGameobjectLuaByType(self.selectActivityListCfg.ActivityType, self.selectActivityListCfg.Branch, GameObject.Instantiate(asset, self.ActivityContent.transform))

	self.activityInstance:Show()
	self.activityInstance:SetData(self.selectActivityListCfg)
end

function ActiveActivityListUI:DestoryLastActivityGameObject()
	if self.activityInstance ~= nil then
		self.activityInstance:Dispose()

		self.activityInstance = nil
	end
end

function ActiveActivityListUI:OnTaskNotifyEvent()
	self:RefreshTabsRedDot()
end

function ActiveActivityListUI:OnActivityUpdateEvent()
	self:InitViewInfo()
	self:RefreshTabsRedDot()
end

function ActiveActivityListUI:OnTaskFinishEvent()
	self:InitViewInfo()
	self:RefreshTabsRedDot()
end

function ActiveActivityListUI:OnClearRedDotEvent()
	self:RefreshTabsRedDot()
end

function ActiveActivityListUI:RefreshTabsRedDot()
	self.tabItemPool:ForItems(function(_item)
		if _item.View.activeSelf then
			_item:RefreshRedDot()
		end
	end)
end

return ActiveActivityListUI
