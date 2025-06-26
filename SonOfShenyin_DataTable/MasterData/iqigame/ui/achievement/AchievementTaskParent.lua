-- chunkname: @IQIGame\\UI\\Achievement\\AchievementTaskParent.lua

local AchievementTaskParent = {}
local AchievementTaskParentItemClass = require("IQIGame.UI.Achievement.AchievementTaskParentItem")

function AchievementTaskParent.New(go, mainView)
	local o = Clone(AchievementTaskParent)

	o:Initialize(go, mainView)

	return o
end

function AchievementTaskParent:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
	self:RefreshCollect()
end

function AchievementTaskParent:InitMembers()
	self.achievementTabItemList = {}
	self.currentSelectTab = nil
	self.taskViewList = {}
	self.drag = false
end

function AchievementTaskParent:InitComponent()
	return
end

function AchievementTaskParent:InitDelegate()
	function self.achievementParentTabDelegate(taskType)
		self:OnAchievementParentTabClick(taskType)
	end

	function self.achievementScrollDragDelegate(Drag)
		self:OnAchievementScrollDragClick(Drag)
	end
end

function AchievementTaskParent:AddListener()
	EventDispatcher.AddEventListener(EventID.AchievementParentTab, self.achievementParentTabDelegate)
	EventDispatcher.AddEventListener(EventID.AchievementScrollDrag, self.achievementScrollDragDelegate)
end

function AchievementTaskParent:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.AchievementParentTab, self.achievementParentTabDelegate)
	EventDispatcher.AddEventListener(EventID.AchievementScrollDrag, self.achievementScrollDragDelegate)
end

function AchievementTaskParent:RefreshCollect()
	local sum, finishNum = AchievementModule.GetAchievementFinishCount()

	LuaUtility.SetText(self.presentCollectNumText, finishNum)
	LuaUtility.SetText(self.allCollectNumText, sum)
	LuaUtility.SetText(self.collectPercentText, Mathf.Ceil(finishNum * 100 / sum))
end

function AchievementTaskParent:OnOpen()
	self:RefreshParent()

	if self.achievementTabItemList[1] then
		self.achievementTabItemList[1]:OnButtonClick()
	end

	LuaUtility.SetGameObjectShow(self.achievementBtnScroll, true)
end

function AchievementTaskParent:OnClose()
	self.currentSelectTab = nil
	self.achievementTabItemList = {}

	for i = LuaUtility.GetChildCount(self.achievementBtnGrid.transform), 1, -1 do
		UnityEngine.Object.Destroy(LuaUtility.GetChild(self.achievementBtnGrid.transform, i - 1).gameObject)
	end

	LuaUtility.SetGameObjectShow(self.achievementBtnScroll, false)
end

function AchievementTaskParent:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
end

function AchievementTaskParent:RefreshParent()
	local data = AchievementModule.GetAchievementParentList()
	local index = 1

	for i = 1, getTableLength(data) do
		if i > getTableLength(self.achievementTabItemList) then
			local parentObject = GameObject.Instantiate(self.mainView.achievementTabPrefab, self.achievementBtnGrid.transform)
			local parentItem = AchievementTaskParentItemClass.New(parentObject, self)

			table.insert(self.achievementTabItemList, parentItem)
		end

		self.achievementTabItemList[i]:Refresh(data[i])
		self.achievementTabItemList[i]:Show()

		index = i + 1
	end

	for i = index, getCfgTableLength(self.achievementTabItemList) do
		self.achievementTabItemList[i]:Hide()
	end
end

function AchievementTaskParent:OnParentTabClick(taskParentItem)
	LuaUtility.SetGameObjectShow(self.achievementBtnGrid, false)
	LuaUtility.SetGameObjectShow(self.achievementBtnGrid, true)

	if self.currentSelectTab then
		self.currentSelectTab:ResetStatus()
	end

	self.currentSelectTab = taskParentItem

	if not self.drag then
		EventDispatcher.Dispatch(EventID.AchievementScrollTo, self.currentSelectTab)
	end
end

function AchievementTaskParent:OnAchievementParentTabClick(taskType)
	if self.currentSelectTab and CfgUtil.GetTaskCfgWithID(self.currentSelectTab.Data.cid).TypeExtend[1] == taskType then
		return
	end

	for i = 1, #self.achievementTabItemList do
		local cfgTask = CfgUtil.GetTaskCfgWithID(self.achievementTabItemList[i].Data.cid)

		if cfgTask.TypeExtend[1] == taskType then
			self.achievementTabItemList[i]:OnButtonClick()
		end
	end
end

function AchievementTaskParent:OnAchievementScrollDragClick(Drag)
	self.drag = Drag
end

function AchievementTaskParent:RefreshAchievementBtnScroll(data)
	self.achievementBtnScroll:RefreshByItemCount(#data)
end

function AchievementTaskParent:AchievementBtnScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.archievesTaskList[index + 1]
	local viewsHolder = self.achievementScroll:GetItemViewsHolder(0)
	local temp = self.archievesTaskList[viewsHolder.ItemIndex + 1]

	EventDispatcher.Dispatch(EventID.AchievementScrollDrag, true)

	if viewsHolder.ItemIndex == 0 then
		EventDispatcher.Dispatch(EventID.AchievementParentTab, 1)
	elseif temp.type == 1 then
		EventDispatcher.Dispatch(EventID.AchievementParentTab, data.tabIndex)
	end

	if not self.taskViewList[instanceID] then
		self.taskViewList[instanceID] = AchievementTaskDetailItemClass.New(viewGameObject)
	end

	self.taskViewList[instanceID]:Refresh(data, OptimizedViewsHolder)
	EventDispatcher.Dispatch(EventID.AchievementScrollDrag, false)
end

function AchievementTaskParent:InitAchievementBtn()
	return
end

return AchievementTaskParent
