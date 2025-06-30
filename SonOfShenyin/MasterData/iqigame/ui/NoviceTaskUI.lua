-- chunkname: @IQIGame\\UI\\NoviceTaskUI.lua

local NoviceTaskUI = {
	currentDayTag = 1,
	toggleDatas = {},
	dayTaskCalls = {},
	dayTagCalls = {},
	activeCalls = {},
	taskDatas = {}
}

NoviceTaskUI = Base:Extend("NoviceTaskUI", "IQIGame.Onigao.UI.NoviceTaskUI", NoviceTaskUI)

local taskAwardShowTipsPanel = require("IQIGame.UI.TaskSystem.TaskAwardShowTipsPanel")
local dayBtnCall = require("IQIGame.UI.NoviceTaskUI.DayBtnCall")
local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local dayTaskCall = require("IQIGame.UI.NoviceTaskUI.DayTaskCall")
local activeBtnCall = require("IQIGame.UI.NoviceTaskUI.activeBtnCall")
local constant_RefreshActivityLeftTimeIntervalSec = 1

function NoviceTaskUI:OnInit()
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
	self.dayTabGroup = self.toggleGrid:GetComponent("ToggleGroup")
	self.progressImg = self.expImg:GetComponent("Image")
	self.activeTabObjectPool = UIViewObjectPool.New(self.rewardPrefab, self.rewardGrid.transform, function(_view)
		return activeBtnCall.New(_view, self)
	end)
	self.taskScroll = self.taskScroll:GetComponent("OptimizedScrollRect")

	self.taskScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateTaskScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	self.dayScroll = self.dayScroll:GetComponent("OptimizedScrollRect")

	self.dayScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateDayScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	function self.DelegateOnDayTabClick(isOn, index)
		self:OnDayTabClick(isOn, index)
	end

	function self.DelegateOnTaskNotifyTask(tasks)
		self:OnTaskNotifyTask(tasks)
	end

	function self.DelegateOnTaskNotifyFinish(tasks)
		self:OnTaskNotifyFinish(tasks)
	end

	self.taskAwardShowTipsPanel = taskAwardShowTipsPanel.New(self.awardShowTipsPanel)

	self.taskAwardShowTipsPanel:Show(false)
end

function NoviceTaskUI:GetPreloadAssetPaths()
	return nil
end

function NoviceTaskUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function NoviceTaskUI:IsManualShowOnOpen(userData)
	return false
end

function NoviceTaskUI:GetBGM(userData)
	return nil
end

function NoviceTaskUI:OnOpen(userData)
	self.currentDayTag = 1

	self:InitData()
	self:ShowTag(true)
	self:ShowTask()
	self:ShowActive()
end

function NoviceTaskUI:InitData()
	local list = TaskSystemModule.GetTaskListByConfig(Constant.MainTaskType.Novice_7_DAY_TASK)

	self.taskDatas = {}

	for k, task in pairs(list) do
		local cfg = task.cfgTaskConfig
		local subType = cfg.TypeExtend[1]

		if subType > 0 then
			local types = table.computeIfAbsent(self.taskDatas, subType, {})

			table.insert(types, task)
		end
	end
end

function NoviceTaskUI:ShowTask()
	self.taskScroll:RefreshByItemCount(#self.taskDatas[self.currentDayTag])
end

function NoviceTaskUI:ShowTag(scrollTo)
	self.toggleDatas = {}

	local toDay = 1
	local tagData = TaskSystemModule.GetTaskListByConfig(Constant.MainTaskType.Novice_7_DAY_TASK, {
		0
	})

	for k, task in pairs(tagData) do
		if task.cfgTaskConfig.TypeExtend[2] > 0 then
			local toggle = {}

			toggle.key = task.cfgTaskConfig.TypeExtend[2]
			toggle.isLock = task.status ~= Constant.TaskStatus.hadGot
			toggle.isRed = false

			if not toggle.isLock then
				for k, v in pairs(self.taskDatas[toggle.key]) do
					if v.status == Constant.TaskStatus.hasDone then
						toggle.isRed = true

						break
					end
				end

				toDay = math.max(toDay, toggle.key)
			end

			table.insert(self.toggleDatas, toggle)
		end
	end

	table.sort(self.toggleDatas, function(a, b)
		return a.key < b.key
	end)

	local count = table.len(self.toggleDatas)

	if scrollTo then
		self.currentDayTag = toDay
	end

	self.dayScroll:RefreshByItemCount(count)

	if scrollTo and toDay - 1 > 0 then
		self.dayScroll:ScrollTo(toDay - 1)
	end
end

function NoviceTaskUI:ShowActive()
	local activeTask = TaskSystemModule.GetTaskListByConfig(Constant.MainTaskType.Novice_7_DAY_TASK, {
		0,
		0
	})

	table.sort(activeTask, function(a, b)
		return a.needSchedule < b.needSchedule
	end)

	local min = self.GetCompletedActivityTotalSchedule()
	local max = self.GetActivityTotalSchedule()

	UGUIUtil.SetText(self.presentExpText, min)
	UGUIUtil.SetText(self.allExpText, max)

	self.progressImg.fillAmount = min / max

	local totalRect = self.expImg:GetComponent("RectTransform").rect
	local total_W = totalRect.w
	local total_X = totalRect.x
	local total_Y = totalRect.y

	for k, v in pairs(activeTask) do
		local item = self.activeCalls[k]
		local p = v.needSchedule / max

		if not self.activeCalls[k] then
			item = self.activeTabObjectPool:GetFree(function(_item)
				return not _item.gameObject.activeSelf
			end)
			self.activeCalls[k] = item

			local rect = item.gameObject:GetComponent("RectTransform")
			local new_X = total_X + total_W * p

			LuaUtility.SetAnchoredPositionWithRectTransform(rect, new_X, total_Y)
		end

		item:Show(v)
	end
end

function NoviceTaskUI:UpdateTaskScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex

	if not self.dayTaskCalls[instanceID] then
		self.dayTaskCalls[instanceID] = dayTaskCall.New(viewGameObject)
	end

	self.dayTaskCalls[instanceID]:Refresh(self.taskDatas[self.currentDayTag][index + 1])
end

function NoviceTaskUI:UpdateDayScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex

	if not self.dayTagCalls[instanceID] then
		self.dayTagCalls[instanceID] = dayBtnCall.New(viewGameObject, self, index + 1)
	end

	self.dayTagCalls[instanceID]:Refresh(self.toggleDatas[index + 1], index + 1)
end

function NoviceTaskUI:OnDayTabClick(isOn, index)
	if not isOn then
		return
	end

	self.currentDayTag = index

	self:ShowTask()
end

function NoviceTaskUI:OnClose(userData)
	return
end

function NoviceTaskUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.TaskNotifyTask, self.DelegateOnTaskNotifyTask)
	EventDispatcher.AddEventListener(EventID.TaskNotifyFinish, self.DelegateOnTaskNotifyFinish)
end

function NoviceTaskUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyTask, self.DelegateOnTaskNotifyTask)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyFinish, self.DelegateOnTaskNotifyFinish)
end

function NoviceTaskUI:OnPause()
	return
end

function NoviceTaskUI:OnResume()
	return
end

function NoviceTaskUI:OnCover()
	return
end

function NoviceTaskUI:OnReveal()
	return
end

function NoviceTaskUI:OnRefocus(userData)
	return
end

function NoviceTaskUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.isNeedRefresh then
		self:InitData()
		self:ShowTag(false)
		self:ShowTask()
		self:ShowActive()

		self.isNeedRefresh = false
	end
end

function NoviceTaskUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function NoviceTaskUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function NoviceTaskUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function NoviceTaskUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.commonReturnBtn:Dispose()
	self.taskAwardShowTipsPanel:Dispose()
	self.activeTabObjectPool:Dispose(function(_item)
		_item:Dispose()
	end)

	for i, v in pairs(self.dayTagCalls) do
		v:OnDestroy()
	end

	for _, v in ipairs(self.dayTaskCalls) do
		v:OnDestroy()
	end
end

function NoviceTaskUI.GetCompletedActivityTotalSchedule()
	return WarehouseModule.GetItemNumByCfgID(Constant.ItemCid.NoviceActivity)
end

function NoviceTaskUI.GetActivityTotalSchedule()
	local stageTasks = TaskSystemModule.GetTaskListByConfig(Constant.MainTaskType.Novice_7_DAY_TASK, {
		0
	})
	local needSchedule = 0

	for k, v in pairs(stageTasks) do
		needSchedule = math.max(needSchedule, v.cfgTaskConfig.NeedSchedule)
	end

	return needSchedule
end

function NoviceTaskUI:RefreshActivityLeftTime()
	local activityLeftSecondTime = tonumber(ActivityModule.GetActivityPodByID(Constant.ActivityID.Novice_7_TASK).closeDateTime) / 1000 - PlayerModule.GetServerTime()

	if activityLeftSecondTime < 0 then
		activityLeftSecondTime = 0

		return
	end

	UGUIUtil.SetText(self.timeText, NoviceTaskUIApi:GetTimeFormat(activityLeftSecondTime))
end

function NoviceTaskUI:OnTaskNotifyTask(tasks)
	self:OnTaskNotifyFinish(tasks)
end

function NoviceTaskUI:OnTaskNotifyFinish(tasks)
	self.isNeedRefresh = true
end

function NoviceTaskUI:OnTaskAwardShow(data)
	self.taskAwardShowTipsPanel:Show(true, data)
end

return NoviceTaskUI
