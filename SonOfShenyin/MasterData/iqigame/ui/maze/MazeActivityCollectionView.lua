-- chunkname: @IQIGame\\UI\\Maze\\MazeActivityCollectionView.lua

local UITabList = require("IQIGame.UI.Common.UITabList")
local TabItemCell = {}

function TabItemCell.New(view, clickHandler)
	local obj = Clone(TabItemCell)

	obj:__Init(view, clickHandler)

	return obj
end

function TabItemCell:__Init(view, clickHandler)
	self.gameObject = view
	self.clickHandler = clickHandler

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.delegateOnClickItem()
		self:Select()
	end

	self.gameObject:GetComponent("Button").onClick:AddListener(self.delegateOnClickItem)
end

function TabItemCell:Show(seasonId)
	self.seasonId = seasonId

	self.gameObject:SetActive(true)
	UGUIUtil.SetText(self.selectTabText, MazeApi:GetMazeSeasonText(seasonId))
	UGUIUtil.SetText(self.unSelectTabText, MazeApi:GetMazeSeasonText(seasonId))
end

function TabItemCell:SetSelectState(state)
	LuaUtility.SetGameObjectShow(self.selectParent, state)
	LuaUtility.SetGameObjectShow(self.unSelectParent, not state)

	if self.clickHandler then
		self.clickHandler(state, self.seasonId)
	end
end

function TabItemCell:Select()
	LuaUtility.SetGameObjectShow(self.selectParent, true)
	LuaUtility.SetGameObjectShow(self.unSelectParent, false)

	if self.clickHandler then
		self.clickHandler(self.seasonId)
	end
end

function TabItemCell:UnSelect()
	LuaUtility.SetGameObjectShow(self.selectParent, false)
	LuaUtility.SetGameObjectShow(self.unSelectParent, true)
end

function TabItemCell:Hide()
	self.gameObject:SetActive(false)
end

function TabItemCell:Dispose()
	self.gameObject:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickItem)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local collectionItemClass = require("IQIGame/UI/Maze/MazeActivityCollectionItemView")
local memoryItemClass = require("IQIGame/UI/Maze/MazeActivityMemoryItemView")
local CollectionDetailMainClass = require("IQIGame/UI/Maze/MazeActivityCollectionDetailMainView")
local CollectionDetailSecondClass = require("IQIGame/UI/Maze/MazeActivityCollectionDetailSecondView")
local CollectionRewardClass = require("IQIGame/UI/Maze/MazeActivityCollectionRewardView")
local MazeActivityCollectionView = {
	tabItemList = {},
	itemCellList = {},
	MemoryItemList = {}
}

MazeActivityCollectionView.leftTabType = {
	memory = 2,
	collection = 1
}

function MazeActivityCollectionView.New(go)
	local o = Clone(MazeActivityCollectionView)

	o:Initialize(go)

	return o
end

function MazeActivityCollectionView:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.itemCellList = {}

	self:InitComponent()
	self:InitDelegate()
	self:InitLeftTabList()
end

function MazeActivityCollectionView:InitComponent()
	self.topTabScroll = self.tabsScroll:GetComponent("ScrollAreaList")

	function self.topTabScroll.onRenderCell(cell)
		self:UpdateTopTabsScroll(cell)
	end

	function self.topTabScroll.onRenderEnd()
		self:OnRenderTopTabEnd()
	end

	self.collectionScrollCom = self.collectionScroll:GetComponent("OptimizedScrollRect")

	self.collectionScrollCom:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:OnItemScrollRefresh(OptimizedParams, OptimizedViewsHolder)
	end)

	self.memoryScrollCom = self.memoryScroll:GetComponent("ScrollAreaList")

	function self.memoryScrollCom.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	self.collectionRewardView = CollectionRewardClass.New(self.collectionRewardRoot, self)
	self.collectionDetailMainView = CollectionDetailMainClass.New(self.collectionDetailRootMain)
	self.collectionDetailSecondView = CollectionDetailSecondClass.New(self.collectionDetailRootSecond)
	self.commonReturnBtn = CommonReturnBtn.New(self.commonReturnBtn, self)

	self.commonReturnBtn:RegisterReturnEvent(function()
		self:Hide()
	end)
end

function MazeActivityCollectionView:InitDelegate()
	function self.delegateOnTaskNotifyFinishEvent()
		self:OnTaskNotifyFinishEvent()
	end

	function self.delegateOnTabClickHandler(seasonId)
		self:OnTabClickHandler(seasonId)
	end
end

function MazeActivityCollectionView:AddListener()
	EventDispatcher.AddEventListener(EventID.TaskNotifyFinish, self.delegateOnTaskNotifyFinishEvent)
end

function MazeActivityCollectionView:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyFinish, self.delegateOnTaskNotifyFinishEvent)
end

function MazeActivityCollectionView:Show()
	self.collectionDetailMainView:Hide()
	self.collectionDetailSecondView:Hide()
	self.collectionRewardView:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
	self:AddListener()
end

function MazeActivityCollectionView:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
	self:RemoveListener()
end

function MazeActivityCollectionView:Refresh()
	self.LeftTabList:ChangeSelectIndex(1)
end

function MazeActivityCollectionView:RefreshTaskData()
	self.AllTaskDataList = TaskSystemModule.GetMazeTaskData()
end

function MazeActivityCollectionView:RefreshTaskScroll(seasonId)
	self.curTaskDataList = nil

	ForArray(self.AllTaskDataList, function(k, v)
		if v.seasonId == seasonId then
			self.curTaskDataList = v

			return true
		end
	end)

	if self.curTaskDataList == nil then
		return
	end

	self.collectionScrollCom:RefreshByItemCount(#self.curTaskDataList.Data)
end

function MazeActivityCollectionView:RefreshMemoryData()
	self.memoryDataList = MazeModule.GetCurSeasonMemoryDataList(self.curSeasonID)
end

function MazeActivityCollectionView:RefreshMemoryScroll()
	self.memoryScrollCom:Refresh(#self.memoryDataList)
end

function MazeActivityCollectionView:OnItemScrollRefresh(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.curTaskDataList.Data[index + 1]

	if not self.itemCellList[instanceID] then
		self.itemCellList[instanceID] = collectionItemClass.New(viewGameObject, self)
	end

	self.itemCellList[instanceID]:Refresh(data)
end

function MazeActivityCollectionView:OnRenderItem(cell)
	local instanceId = cell.gameObject:GetInstanceID()
	local itemCell = self.MemoryItemList[instanceId]
	local data = self.memoryDataList[cell.index + 1]

	if itemCell == nil then
		self.MemoryItemList[instanceId] = memoryItemClass.New(cell.gameObject)
		itemCell = self.MemoryItemList[instanceId]
	end

	itemCell:Refresh(data)
end

function MazeActivityCollectionView:RefreshDetailMainInfoView(data)
	self.collectionDetailMainView:Show()
	self.collectionDetailMainView:Refresh(data)
end

function MazeActivityCollectionView:RefreshDetailSecondInfoView(data)
	self.collectionDetailSecondView:Show()
	self.collectionDetailSecondView:Refresh(data)
end

function MazeActivityCollectionView:RefreshRewardView(mainTaskData)
	self.collectionRewardView:Show()
	self.collectionRewardView:Refresh(mainTaskData)
end

function MazeActivityCollectionView:UpdateTopTabsScroll(cell)
	local insID = cell.gameObject:GetInstanceID()
	local tabItem = self.tabItemList[insID]

	if tabItem == nil then
		tabItem = TabItemCell.New(cell.gameObject, self.delegateOnTabClickHandler)
		self.tabItemList[insID] = tabItem
	end

	local seasonId = self.tabTaskList[cell.index + 1].seasonId

	tabItem:Show(seasonId)

	if cell.index + 1 == 1 then
		self.fiestTabItem = tabItem
	end
end

function MazeActivityCollectionView:OnRenderTopTabEnd()
	if self.fiestTabItem ~= nil then
		self.fiestTabItem:Select()
	end
end

function MazeActivityCollectionView:OnTaskNotifyFinishEvent()
	self:RefreshTaskData()
	self:RefreshTaskScroll(self.curSeasonID)
	self.collectionRewardView:Hide()
end

function MazeActivityCollectionView:OnDestroy()
	for k, v in pairs(self.tabItemList) do
		v:Dispose()
	end

	for k, v in pairs(self.itemCellList) do
		v:OnDestroy()
	end

	for k, v in pairs(self.MemoryItemList) do
		v:OnDestroy()
	end

	self.LeftTabList:Dispose()
	self.collectionRewardView:OnDestroy()
	self.collectionDetailMainView:OnDestroy()
	self.collectionDetailSecondView:OnDestroy()
	self.commonReturnBtn:Dispose()
end

function MazeActivityCollectionView:InitLeftTabList()
	self.LeftTabList = UITabList.Create()

	self.LeftTabList:AddTableItem(self.collectionTabItem, nil, function(_isOn, _view)
		if _isOn then
			self:__OnToggleValueChange(self.leftTabType.collection)
		end
	end)
	self.LeftTabList:AddTableItem(self.memoryTabItem, nil, function(_isOn, _view)
		if _isOn then
			self:__OnToggleValueChange(self.leftTabType.memory)
		end
	end)
end

function MazeActivityCollectionView:__OnToggleValueChange(type)
	if type == self.leftTabType.collection then
		self.leftTabSelectType = self.leftTabType.collection

		LuaUtility.SetGameObjectShow(self.collectionScroll, true)
		LuaUtility.SetGameObjectShow(self.memoryScroll, false)
		self:RefreshTaskData()
	elseif type == self.leftTabType.memory then
		self.leftTabSelectType = self.leftTabType.memory

		LuaUtility.SetGameObjectShow(self.collectionScroll, false)
		LuaUtility.SetGameObjectShow(self.memoryScroll, true)
		self:RefreshMemoryData()
	end

	self:RefreshSeasonTab()
end

function MazeActivityCollectionView:RefreshSeasonTab()
	self.tabTaskList = {}

	ForArray(self.AllTaskDataList, function(a, b)
		table.insert(self.tabTaskList, b)
	end)
	table.sort(self.tabTaskList, function(a, b)
		return a.seasonId < b.seasonId
	end)
	self.topTabScroll:Refresh(#self.tabTaskList)
end

function MazeActivityCollectionView:OnTabClickHandler(seasonId)
	for k, v in pairs(self.tabItemList) do
		if v.seasonId ~= seasonId then
			v:UnSelect()
		end
	end

	self:RefreshInfo(seasonId)
end

function MazeActivityCollectionView:RefreshInfo(seasonId)
	self.curSeasonID = seasonId

	if self.leftTabSelectType == self.leftTabType.collection then
		self:RefreshTaskScroll(self.curSeasonID)
	elseif self.leftTabSelectType == self.leftTabType.memory then
		self:RefreshMemoryScroll(self.curSeasonID)
	end
end

return MazeActivityCollectionView
