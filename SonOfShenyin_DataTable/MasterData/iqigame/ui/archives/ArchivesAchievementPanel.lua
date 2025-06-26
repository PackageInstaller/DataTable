-- chunkname: @IQIGame\\UI\\Archives\\ArchivesAchievementPanel.lua

local ArchivesAchievementPanel = class(nil, BaseChildrenPanel)
local AchievementTaskParentClass = require("IQIGame.UI.Achievement.AchievementTaskParent")
local AchievementTaskDetailItemClass = require("IQIGame.UI.Achievement.AchievementTaskDetailItem")
local AchievementBadgeDetailItemClass = require("IQIGame.UI.Achievement.AchievementBadgeDetailItem")

function ArchivesAchievementPanel.New(go, mainView)
	local o = Clone(ArchivesAchievementPanel)

	o:Initialize(go, mainView)

	return o
end

function ArchivesAchievementPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function ArchivesAchievementPanel:InitMembers()
	self.taskViewList = {}
	self.badgeViewList = {}
	self.taskDatas = {}
	self.parentTaskIndex = {}
	self.badgeTaskIndex = {}
	self.toggleType = 1
	self.filType = 1
end

function ArchivesAchievementPanel:InitComponent()
	self.allToggle = self.allToggle:GetComponent("Toggle")
	self.haveToggle = self.haveToggle:GetComponent("Toggle")
	self.unHaveToggle = self.unHaveToggle:GetComponent("Toggle")
	self.achievementToggle = self.achievementToggle:GetComponent("Toggle")
	self.badgeToggle = self.badgeToggle:GetComponent("Toggle")
	self.achievementTaskParent = AchievementTaskParentClass.New(self.achievementParent, self)
	self.achievementScroll = self.achievementScroll:GetComponent("OptimizedScrollRect")

	self.achievementScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:AchievementScroll(OptimizedParams, OptimizedViewsHolder)
	end)
	self.achievementScroll:RegisterOnDrag(function()
		self:OnAchievementScroll()
	end)

	self.badgeScroll = self.badgeScroll:GetComponent("OptimizedScrollRect")

	self.badgeScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:BadgeScroll(OptimizedParams, OptimizedViewsHolder)
	end)
	self.badgeScroll:RegisterOnDrag(function()
		self:OnBadgeScroll()
	end)
end

function ArchivesAchievementPanel:InitDelegate()
	function self.achievementAllToggleDelegate()
		self:OnAchievementAllToggleClick()
	end

	function self.achievementHaveToggleDelegate()
		self:OnAchievementHaveToggleClick()
	end

	function self.achievementUnHaveToggleDelegate()
		self:OnAchievementUnHaveToggleClick()
	end

	function self.achievementToggleDelegate()
		self:OnAchievementToggleClick()
	end

	function self.badgeToggleDelegate()
		self:OnBadgeToggleClick()
	end

	function self.achievementScrollToDelegate(ParentId)
		self:OnScrollTo(ParentId)
	end

	function self.achievementCollectRefreshDelegate()
		self:OnAchievementCollectRefresh()
	end
end

function ArchivesAchievementPanel:AddListener()
	self.allToggle.onValueChanged:AddListener(self.achievementAllToggleDelegate)
	self.haveToggle.onValueChanged:AddListener(self.achievementHaveToggleDelegate)
	self.unHaveToggle.onValueChanged:AddListener(self.achievementUnHaveToggleDelegate)
	self.achievementToggle.onValueChanged:AddListener(self.achievementToggleDelegate)
	self.badgeToggle.onValueChanged:AddListener(self.badgeToggleDelegate)
	EventDispatcher.AddEventListener(EventID.AchievementScrollTo, self.achievementScrollToDelegate)
	EventDispatcher.AddEventListener(EventID.AchievementCollectRefresh, self.achievementCollectRefreshDelegate)
end

function ArchivesAchievementPanel:RemoveListener()
	self.allToggle.onValueChanged:RemoveListener(self.achievementAllToggleDelegate)
	self.haveToggle.onValueChanged:RemoveListener(self.achievementHaveToggleDelegate)
	self.unHaveToggle.onValueChanged:RemoveListener(self.achievementUnHaveToggleDelegate)
	self.achievementToggle.onValueChanged:RemoveListener(self.achievementToggleDelegate)
	self.badgeToggle.onValueChanged:RemoveListener(self.badgeToggleDelegate)
	EventDispatcher.RemoveEventListener(EventID.AchievementScrollTo, self.achievementScrollToDelegate)
	EventDispatcher.RemoveEventListener(EventID.AchievementCollectRefresh, self.achievementCollectRefreshDelegate)
end

function ArchivesAchievementPanel:OnAchievementScroll()
	if #self.archievesTaskList <= 0 then
		return
	end

	local viewsHolder = self.achievementScroll:GetItemViewsHolder(0)
	local temp = self.archievesTaskList[viewsHolder.ItemIndex + 1]

	if temp.type == 1 then
		return
	end

	EventDispatcher.Dispatch(EventID.AchievementScrollDrag, true)
	EventDispatcher.Dispatch(EventID.AchievementParentTab, CfgUtil.GetTaskCfgWithID(temp.data.cid).TypeExtend[1])
	EventDispatcher.Dispatch(EventID.AchievementScrollDrag, false)
end

function ArchivesAchievementPanel:OnBadgeScroll()
	if #self.badgeTaskList <= 0 then
		return
	end

	local viewsHolder = self.badgeScroll:GetItemViewsHolder(0)
	local temp = self.badgeTaskList[viewsHolder.ItemIndex + 1]

	if temp.type == 1 then
		return
	end

	EventDispatcher.Dispatch(EventID.AchievementScrollDrag, true)
	EventDispatcher.Dispatch(EventID.AchievementParentTab, temp.extendType[1])
	EventDispatcher.Dispatch(EventID.AchievementScrollDrag, false)
end

function ArchivesAchievementPanel:OnOpen()
	self.achievementScroll:SetEnableSizeControl(true)
	self.badgeScroll:SetEnableSizeControl(true)
	self.achievementTaskParent:OnOpen()

	self.allToggle:GetComponent("Toggle").isOn = true
	self.achievementToggle:GetComponent("Toggle").isOn = true

	self:OnAchievementToggleClick()
	self.mainView:RegisterCloseEvent(function()
		self:Close()
		self.mainView.MainPanel:Open()
	end)
end

function ArchivesAchievementPanel:InitArchievesTask()
	LuaUtility.SetGameObjectShow(self.badgeScroll.gameObject, false)
	LuaUtility.SetGameObjectShow(self.achievementScroll.gameObject, true)

	self.archievesTaskList = {}
	self.parentTaskIndex = {}

	local index = 0

	for i = 1, #self.achievementTaskParent.achievementTabItemList do
		local firstItem = true
		local firstIndex = 0
		local taskParent = self.achievementTaskParent.achievementTabItemList[i]
		local Separator = false

		if self:CheckAddTask(taskParent.Data.cid) then
			local parentTaskPOD = {}

			parentTaskPOD.type = 0
			parentTaskPOD.tabIndex = i
			parentTaskPOD.data = taskParent.Data

			table.insert(self.archievesTaskList, parentTaskPOD)

			index = index + 1
			Separator = true

			if firstItem then
				firstIndex = index
				firstItem = false
			end
		end

		local data = AchievementModule.GetSortTaskList(taskParent.Data.cid)

		if #data > 0 then
			for n = 1, #data do
				if self:CheckAddTask(data[n].cid) then
					local tempTaskPOD = {}

					tempTaskPOD.type = 0
					tempTaskPOD.tabIndex = i
					tempTaskPOD.data = data[n]

					table.insert(self.archievesTaskList, tempTaskPOD)

					index = index + 1
					Separator = Separator or true

					if firstItem then
						firstIndex = index
						firstItem = false
					end
				end
			end
		end

		if i < #self.achievementTaskParent.achievementTabItemList and Separator then
			local tempTaskPOD = {}

			tempTaskPOD.type = 1
			tempTaskPOD.tabIndex = i + 1
			tempTaskPOD.data = {}

			table.insert(self.archievesTaskList, tempTaskPOD)

			index = index + 1
			Separator = false
		end

		local TaskParentIndexPOD = {}

		TaskParentIndexPOD.cid = taskParent.Data.cid
		TaskParentIndexPOD.index = firstIndex

		table.insert(self.parentTaskIndex, TaskParentIndexPOD)
	end

	self:RefreshAchievementTaskScroll(self.archievesTaskList)
end

function ArchivesAchievementPanel:InitBadgeTask()
	LuaUtility.SetGameObjectShow(self.badgeScroll.gameObject, true)
	LuaUtility.SetGameObjectShow(self.achievementScroll.gameObject, false)

	self.badgeTaskList = {}
	self.badgeTaskIndex = {}

	local index = 0

	for i = 1, #self.achievementTaskParent.achievementTabItemList do
		local firstItem = true
		local firstIndex = 0
		local taskParent = self.achievementTaskParent.achievementTabItemList[i]
		local data = AchievementModule.GetSortTaskList(taskParent.Data.cid)

		self.childBadgePOD = {}

		local Separator = false

		if self:CheckAddTask(taskParent.Data.cid) then
			local parentTaskPOD = {
				taskParent.Data.cid
			}

			parentTaskPOD.type = 0
			parentTaskPOD.tabIndex = i
			parentTaskPOD.data = taskParent.Data

			table.insert(self.childBadgePOD, taskParent.Data)

			Separator = true
		end

		if #data > 0 then
			for n = 1, #data do
				if #self.childBadgePOD ~= 5 and self:CheckAddTask(data[n].cid) then
					table.insert(self.childBadgePOD, data[n])

					Separator = true
				end

				if #self.childBadgePOD == 5 or #self.childBadgePOD > 0 and n == #data then
					local tempTaskPOD = {}

					tempTaskPOD.type = 0
					tempTaskPOD.tabIndex = i
					tempTaskPOD.data = self.childBadgePOD
					tempTaskPOD.extendType = CfgUtil.GetTaskCfgWithID(data[n].cid).TypeExtend

					table.insert(self.badgeTaskList, tempTaskPOD)

					index = index + 1
					self.childBadgePOD = {}

					if firstItem then
						firstIndex = index
						firstItem = false
					end
				end
			end
		end

		if i < #self.achievementTaskParent.achievementTabItemList and Separator then
			local tempTaskPOD = {}

			tempTaskPOD.type = 1
			tempTaskPOD.tabIndex = i + 1
			tempTaskPOD.data = {}

			table.insert(self.badgeTaskList, tempTaskPOD)

			index = index + 1
			Separator = false
		end

		local TaskParentIndexPOD = {}

		TaskParentIndexPOD.cid = taskParent.Data.cid
		TaskParentIndexPOD.index = firstIndex

		table.insert(self.badgeTaskIndex, TaskParentIndexPOD)
	end

	self:RefreshBadgeTaskScroll(self.badgeTaskList)
end

function ArchivesAchievementPanel:CheckAddTask(cid)
	local result = false

	if self.filType == 1 then
		result = true
	elseif self.filType == 2 then
		if self:CheckTaskHave(cid) then
			result = true
		end
	elseif self.filType == 3 and not self:CheckTaskHave(cid) then
		result = true
	end

	return result
end

function ArchivesAchievementPanel:CheckTaskHave(cid)
	local result = false
	local taskPod = TaskSystemModule.taskSystemDataDic[cid]

	if taskPod == nil then
		if TaskSystemModule.GetFinishedTaskWithID(cid) then
			result = true
		end
	elseif TaskSystemModule.CheckTaskIsFinished(taskPod) then
		result = true
	end

	return result
end

function ArchivesAchievementPanel:RefreshAchievementTaskScroll(data)
	self.achievementScroll:RefreshByItemCount(#data)
end

function ArchivesAchievementPanel:AchievementScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.archievesTaskList[index + 1]

	if not self.taskViewList[instanceID] then
		self.taskViewList[instanceID] = AchievementTaskDetailItemClass.New(viewGameObject)
	end

	self.taskViewList[instanceID]:Refresh(data, OptimizedViewsHolder)
end

function ArchivesAchievementPanel:RefreshBadgeTaskScroll(data)
	self.badgeScroll:RefreshByItemCount(#data)
end

function ArchivesAchievementPanel:BadgeScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.badgeTaskList[index + 1]

	if not self.badgeViewList[instanceID] then
		self.badgeViewList[instanceID] = AchievementBadgeDetailItemClass.New(viewGameObject)
	end

	self.badgeViewList[instanceID]:Refresh(data, OptimizedViewsHolder)
end

function ArchivesAchievementPanel:OnClose()
	self.achievementTaskParent:OnClose()
	self.achievementTaskParent:OnClose()
	self.achievementScroll:SetEnableSizeControl(false)
	self.badgeScroll:SetEnableSizeControl(false)
end

function ArchivesAchievementPanel:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i = 1, #self.taskViewList do
		self.taskViewList[i]:OnDestroy()
	end

	for i = 1, #self.badgeViewList do
		self.badgeViewList[i]:OnDestroy()
	end

	self.taskDatas = {}
	self.parentTaskIndex = {}
	self.badgeTaskIndex = {}
end

function ArchivesAchievementPanel:Refresh()
	self:RefreshParent()
end

function ArchivesAchievementPanel:RefreshRedDot()
	return
end

function ArchivesAchievementPanel:OnButtonGetAllClick()
	return
end

function ArchivesAchievementPanel:RefreshAchievementBoxInfo(parentTaskID)
	return
end

function ArchivesAchievementPanel:OnRenderAchievementTaskScrollGridCell(gridCell)
	return
end

function ArchivesAchievementPanel:RefreshTaskDetails(type)
	return
end

function ArchivesAchievementPanel:CheckGetAllButtonShow()
	return
end

function ArchivesAchievementPanel:OnAchievementToggleClick()
	self.toggleType = 1

	if self.achievementToggle:GetComponent("Toggle").isOn then
		self:ScrollRefresh()
	end

	EventDispatcher.Dispatch(EventID.AchievementParentTab, 1)
end

function ArchivesAchievementPanel:OnBadgeToggleClick()
	self.toggleType = 2

	if self.badgeToggle:GetComponent("Toggle").isOn then
		self:ScrollRefresh()
	end

	EventDispatcher.Dispatch(EventID.AchievementParentTab, 1)
end

function ArchivesAchievementPanel:OnAchievementAllToggleClick()
	self.filType = 1

	if self.allToggle:GetComponent("Toggle").isOn then
		self:ScrollRefresh()
	end
end

function ArchivesAchievementPanel:OnAchievementHaveToggleClick()
	self.filType = 2

	if self.haveToggle:GetComponent("Toggle").isOn then
		self:ScrollRefresh()
	end
end

function ArchivesAchievementPanel:OnAchievementUnHaveToggleClick()
	self.filType = 3

	if self.unHaveToggle:GetComponent("Toggle").isOn then
		self:ScrollRefresh()
	end
end

function ArchivesAchievementPanel:ScrollRefresh()
	if self.toggleType == 1 then
		self:InitArchievesTask()
	elseif self.toggleType == 2 then
		self:InitBadgeTask()
	end
end

function ArchivesAchievementPanel:OnScrollTo(ParentId)
	if self.toggleType == 1 then
		for i = 1, #self.parentTaskIndex do
			if self.parentTaskIndex[i].cid == ParentId.Data.cid then
				if self.parentTaskIndex[i].index == 0 then
					break
				end

				self.achievementScroll:ScrollTo(self.parentTaskIndex[i].index - 1)

				break
			end
		end
	elseif self.toggleType == 2 then
		for i = 1, #self.badgeTaskIndex do
			if self.badgeTaskIndex[i].cid == ParentId.Data.cid then
				if self.badgeTaskIndex[i].index == 0 then
					break
				end

				self.badgeScroll:ScrollTo(self.badgeTaskIndex[i].index - 1)

				break
			end
		end
	end
end

function ArchivesAchievementPanel:OnAchievementCollectRefresh()
	self.achievementTaskParent:RefreshCollect()
end

return ArchivesAchievementPanel
