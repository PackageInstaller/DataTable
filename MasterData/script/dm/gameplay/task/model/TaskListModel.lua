-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/task/model/TaskListModel.lua

require("dm.gameplay.task.model.TaskModel")
require("dm.gameplay.task.model.AchievementModel")

TaskListModel = class("TaskListModel", objectlua.Object, _M)

TaskListModel:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
TaskListModel:has("_boxStatusMap", {
	is = "rw"
})
TaskListModel:has("_weekBoxStatusMap", {
	is = "rw"
})
TaskListModel:has("_taskListMap", {
	is = "rw"
})
TaskListModel:has("_taskDailyList", {
	is = "rw"
})
TaskListModel:has("_redPonitNum", {
	is = "rw"
})
TaskListModel:has("_dayLiveness", {
	is = "rw"
})
TaskListModel:has("_weekLiveness", {
	is = "rw"
})
TaskListModel:has("_hasSync", {
	is = "rw"
})
TaskListModel:has("_nextTaskMap", {
	is = "rw"
})
TaskListModel:has("_achieveTaskMap", {
	is = "rw"
})
TaskListModel:has("_achieveTaskList", {
	is = "rw"
})
TaskListModel:has("_activityLevel", {
	is = "rw"
})
TaskListModel:has("_messageTaskList", {
	is = "rw"
})

TaskType = {
	kURMap = 9,
	kDaily = 1,
	kStage = 5,
	kMapMain = 7,
	kMapDaily = 6,
	kStageArena = 8,
	kBranch = 4,
	kMessage = 11,
	kLevel = 3,
	kOffer = 2
}

local statusPriorityMap = {
	[TaskStatus.kFinishNotGet] = 1,
	[TaskStatus.kUnfinish] = 2,
	[TaskStatus.kGet] = 3
}
local s_TaskListModel

function TaskListModel.class:getInstance()
	if s_TaskListModel == nil then
		s_TaskListModel = TaskListModel:new()
	end

	return s_TaskListModel
end

function TaskListModel:initialize()
	super.initialize(self)

	self._taskListMap = {}
	self._taskDailyList = nil
	self._messageTaskList = nil
	self._boxStatusMap = nil
	self._weekBoxStatusMap = nil
	self._redPonitNum = 0
	self._weekLiveness = 0
	self._dayLiveness = 0
	self._hasSync = false
	self._showMapTasks = {}
	self._nextTaskMap = {}
	self._achieveTaskMap = {}
	self._achieveTaskList = {}

	self:initDailyTask()
	self:initAchieveTask()
end

function TaskListModel:initDailyTask()
	local data = ConfigReader:getDataTable("Task")

	for k, value in pairs(data) do
		if value.TaskType == TaskType.kDaily or value.TaskType == TaskType.kMessage then
			local task = {}
			local taskModel = TaskModel:new()

			task.taskId = value.Id

			taskModel:synchronizeModel(task)

			local conditionList = taskModel:getCondition()
			local taskValues = {}

			for i, condition in pairs(conditionList) do
				taskValues[tostring(i - 1)] = {}
				taskValues[tostring(i - 1)].currentValue = 0
				taskValues[tostring(i - 1)].targetValue = condition.factor1[1]
			end

			taskModel:updateTaskValue(taskValues)
			self:insertList(taskModel)
		end
	end
end

function TaskListModel:initAchieveTask()
	local data = ConfigReader:getDataTable("AchievementBase")

	self._achieveTaskMap = {}
	self._achieveTaskList = {}

	for k, value in pairs(data) do
		local achievePoint = 0

		for index = 1, #value.AchievementList do
			local taskId = value.AchievementList[index]
			local task = {}
			local taskModel = AchievementModel:new()

			task.taskId = taskId

			taskModel:synchronizeModel(task)

			local conditionList = taskModel:getCondition()
			local taskValues = {}

			for i, condition in pairs(conditionList) do
				taskValues[tostring(i - 1)] = {}
				taskValues[tostring(i - 1)].currentValue = 0
				taskValues[tostring(i - 1)].targetValue = condition.factor1[1]
			end

			taskModel:updateTaskValue(taskValues)

			achievePoint = achievePoint + taskModel:getAchievePoint()

			if not self._achieveTaskList[taskId] then
				self._achieveTaskList[task.taskId] = taskModel

				if taskModel:getNextTaskId() and #taskModel:getNextTaskId() > 0 then
					local nextTaskId = taskModel:getNextTaskId()

					for i = 1, #nextTaskId do
						self._nextTaskMap[nextTaskId[i]] = self._nextTaskMap[nextTaskId[i]] or taskModel:getId()
					end
				end
			end
		end

		self._achieveTaskMap[value.Id] = self._achieveTaskMap[value.Id] or {}
		self._achieveTaskMap[value.Id] = {
			curAchievePoint = 0,
			name = Strings:get(value.TabName),
			name1 = Strings:get(value.TabENName),
			taskIdList = value.AchievementList,
			order = value.OrderNum,
			achievePoint = achievePoint
		}
	end
end

function TaskListModel:synchronizeModel(data)
	if data == nil then
		return
	end

	if data.showTasks then
		for id, task in pairs(data.showTasks) do
			if task.taskStatus ~= TaskStatus.kInvalid then
				local taskModel = self:getTaskById(id)

				if taskModel then
					taskModel:updateModel(task)
				else
					local taskConfig = ConfigReader:getRecordById("Task", id)

					if taskConfig ~= nil and taskConfig.Id ~= nil then
						task.taskId = id

						local taskModel = TaskModel:new()

						taskModel:synchronizeModel(task)
						self:insertList(taskModel)
					end
				end
			end
		end
	end

	if data.activityRewards then
		self:setBoxStatusMap(data.activityRewards)
	end

	if data.weeklyAcRewards then
		self:setWeekBoxStatusMap(data.weeklyAcRewards)
	end

	if data.weeklyAcPoint then
		self._weekLiveness = data.weeklyAcPoint
	end

	if data.dailyAcPoint then
		self._dayLiveness = data.dailyAcPoint
	end

	self._hasSync = true
end

function TaskListModel:updateTasks(data)
	if data == nil then
		return
	end

	if data.workingTasks then
		for id, task in pairs(data.workingTasks) do
			local taskModel = self:getTaskById(id)

			if taskModel then
				taskModel:updateModel(task)

				if taskModel:getTaskType() == TaskType.kMapMain then
					self._showMapTasks[id] = taskModel
				end
			else
				local taskConfig = ConfigReader:getRecordById("Task", id)

				if taskConfig and taskConfig.TaskType ~= TaskType.kStage and taskConfig.TaskType ~= TaskType.kBranch then
					task.taskId = id

					local taskModel = TaskModel:new()

					taskModel:synchronizeModel(task)
					self:insertList(taskModel)

					if taskModel:getTaskType() == TaskType.kMapMain then
						self._showMapTasks[id] = taskModel
					end
				end
			end
		end
	end

	if data.activityRewards then
		self:updateBoxStatusMap(data.activityRewards)
	end

	if data.weeklyAcRewards then
		self:updateWeekBoxStatusMap(data.weeklyAcRewards)
	end

	if data.weeklyAcPoint then
		self._weekLiveness = data.weeklyAcPoint
	end

	if data.dailyAcPoint then
		self._dayLiveness = data.dailyAcPoint
	end

	if data.activityLevel then
		self._activityLevel = data.activityLevel
	end

	self._hasSync = true
end

function TaskListModel:updateBoxStatusMap(data)
	for k, v in pairs(data) do
		if self._boxStatusMap and self._boxStatusMap[k] ~= nil then
			self._boxStatusMap[k] = v
		end
	end
end

function TaskListModel:updateWeekBoxStatusMap(data)
	for k, v in pairs(data) do
		if self._weekBoxStatusMap and self._weekBoxStatusMap[k] ~= nil then
			self._weekBoxStatusMap[k] = v
		end
	end
end

function TaskListModel:compare(a, b)
	if a:getStatus() == b:getStatus() then
		return a:getSortId() < b:getSortId()
	else
		return statusPriorityMap[a:getStatus()] < statusPriorityMap[b:getStatus()]
	end
end

function TaskListModel:insertList(taskModel)
	local taskType = taskModel:getTaskType()

	if self._taskListMap[taskType] == nil then
		self._taskListMap[taskType] = {}
	end

	if taskModel:getNextTaskId() and #taskModel:getNextTaskId() > 0 then
		for i = 1, #taskModel:getNextTaskId() do
			self._nextTaskMap[taskModel:getNextTaskId()[i]] = taskModel:getId()
		end
	end

	self._taskListMap[taskType][#self._taskListMap[taskType] + 1] = taskModel

	table.sort(self._taskListMap[taskType], function(a, b)
		return self:compare(a, b)
	end)
end

function TaskListModel:getTaskById(taskId)
	local taskModel
	local taskConfig = ConfigReader:getRecordById("Task", taskId)

	if taskConfig == nil then
		return
	end

	local taskType = taskConfig.TaskType
	local list = self._taskListMap[taskType]

	if list then
		for i, value in pairs(list) do
			if value:getId() == taskId then
				taskModel = value

				break
			end
		end
	end

	return taskModel
end

function TaskListModel:removeTaskById(taskId)
	local taskConfig = ConfigReader:getRecordById("Task", taskId)

	if taskConfig == nil then
		return
	end

	local taskType = taskConfig.TaskType
	local list = self._taskListMap[taskType]

	if list then
		for i, value in pairs(list) do
			if value:getId() == taskId then
				table.remove(list, i)

				break
			end
		end
	end
end

function TaskListModel:getTaskListByType(taskType)
	if self._taskListMap[taskType] ~= nil then
		if taskType == TaskType.kURMap then
			table.sort(self._taskListMap[taskType], function(a, b)
				return a:getSortId() < b:getSortId()
			end)
		else
			table.sort(self._taskListMap[taskType], function(a, b)
				return self:compare(a, b)
			end)
		end

		return self._taskListMap[taskType]
	end

	return {}
end

function TaskListModel:getAllDailyTaskList()
	if not self._taskDailyList or #self._taskDailyList == 0 then
		self._taskDailyList = self:getTaskListByType(TaskType.kDaily)

		local offerTaskList = self:getTaskListByType(TaskType.kOffer)

		if offerTaskList then
			for i = 1, #offerTaskList do
				offerTaskList[i]:setSortId(0)

				self._taskDailyList[#self._taskDailyList + 1] = offerTaskList[i]
			end
		end
	end

	return self._taskDailyList
end

function TaskListModel:getMessageTaskList()
	self._messageTaskList = self:getTaskListByType(TaskType.kMessage)

	return self._messageTaskList
end

function TaskListModel:clearDailyTaskData()
	self._taskListMap[TaskType.kDaily] = nil
	self._taskListMap[TaskType.kOffer] = nil
	self._taskDailyList = nil
end

function TaskListModel:updateDelTasks(data)
	data = data.taskCenter

	if data == nil then
		return
	end

	local delData

	if data.growTaskManager then
		delData = data.growTaskManager.workingTasks
	elseif data.dailyTaskManager then
		delData = data.dailyTaskManager.workingTasks
	elseif data.mainTaskManager then
		delData = data.mainTaskManager.workingTasks
	elseif data.mapTaskManager then
		delData = data.mapTaskManager.workingTasks
	end

	if delData then
		for k, value in pairs(delData) do
			self:removeTaskById(k)
		end
	end
end

function TaskListModel:hasUnreceivedDailyTask()
	local list = self:getTaskListByType(TaskType.kDaily)

	for id, task in pairs(list) do
		if task:getStatus() == TaskStatus.kFinishNotGet then
			return true
		end
	end

	return false
end

function TaskListModel:getUnFinishedDailyTaskCount()
	local count = 0
	local list = self:getAllDailyTaskList()

	for id, task in pairs(list) do
		if task:getStatus() == TaskStatus.kUnfinish then
			count = count + 1
		end
	end

	return count
end

function TaskListModel:hasUnreceivedTask(taskType)
	local list = self:getTaskListByType(taskType)

	for id, task in pairs(list) do
		if task:getStatus() == TaskStatus.kFinishNotGet then
			return true
		end
	end

	return false
end

function TaskListModel:getShowMapTask()
	local list = {}

	for id, taskModel in pairs(self._showMapTasks) do
		self:checkIsShowNextTask(taskModel, list)
	end

	table.sort(list, function(a, b)
		if a:getStatus() == b:getStatus() then
			return a:getSortId() > b:getSortId()
		else
			return statusPriorityMap[a:getStatus()] < statusPriorityMap[b:getStatus()]
		end
	end)

	return list
end

function TaskListModel:checkIsShowNextTask(taskModel, list)
	if taskModel:getStatus() == TaskStatus.kGet and #taskModel:getNextTaskId() > 0 then
		list[#list + 1] = taskModel

		for i = 1, #taskModel:getNextTaskId() do
			local nextTaskId = taskModel:getNextTaskId()[i]
			local nextTaskModel = self:getTaskById(nextTaskId)

			if nextTaskModel:getStatus() == TaskStatus.kGet and #nextTaskModel:getNextTaskId() == 0 or nextTaskModel:getStatus() ~= TaskStatus.kGet then
				list[#list + 1] = nextTaskModel
			end
		end
	elseif not self._nextTaskMap[taskModel:getId()] then
		list[#list + 1] = taskModel
	end
end

function TaskListModel:updateAchieveTask(data)
	for id, task in pairs(data) do
		local taskModel = self._achieveTaskList[id]

		if taskModel then
			taskModel:updateModel(task)
		else
			local taskConfig = ConfigReader:getRecordById("AchievementTask", id)

			if taskConfig ~= nil and taskConfig.Id ~= nil then
				task.taskId = id
				taskModel = AchievementModel:new()

				taskModel:synchronizeModel(task)

				self._achieveTaskList[id] = taskModel
			end
		end
	end
end

function TaskListModel:updateAchievePoint(data)
	for id, value in pairs(data) do
		if self._achieveTaskMap[id] then
			self._achieveTaskMap[id].curAchievePoint = value
		end
	end
end

function TaskListModel:getShowAchieveTask()
	local showTask = {}

	for id, value in pairs(self._achieveTaskMap) do
		local showTaskList = {}
		local taskIdList = value.taskIdList

		for i = 1, #taskIdList do
			local taskId = taskIdList[i]
			local taskModel = self._achieveTaskList[taskId]

			if taskModel then
				self:checkIsShowAchieveTask(taskId, taskModel, showTaskList)
			end
		end

		table.sort(showTaskList, function(a, b)
			return self:compareAchieveTask(a, b)
		end)

		showTask[#showTask + 1] = {
			name = value.name,
			name1 = value.name1,
			taskList = showTaskList,
			achievePoint = value.achievePoint,
			curAchievePoint = value.curAchievePoint,
			order = value.order
		}
	end

	table.sort(showTask, function(a, b)
		return a.order < b.order
	end)

	return showTask
end

function TaskListModel:compareAchieveTask(a, b)
	if a:getStatus() == b:getStatus() then
		local taskValueListA = a:getTaskValueList()
		local percentA = taskValueListA[1].currentValue / taskValueListA[1].targetValue * 100
		local taskValueListB = b:getTaskValueList()
		local percentB = taskValueListB[1].currentValue / taskValueListB[1].targetValue * 100

		if percentA == percentB then
			return a:getSortId() < b:getSortId()
		end

		return percentB < percentA
	end

	return statusPriorityMap[a:getStatus()] < statusPriorityMap[b:getStatus()]
end

function TaskListModel:checkIsShowAchieveTask(taskId, taskModel, showTaskList)
	if taskModel:getStatus() == TaskStatus.kGet and #taskModel:getNextTaskId() > 0 then
		showTaskList[#showTaskList + 1] = taskModel

		for i = 1, #taskModel:getNextTaskId() do
			local nextTaskId = taskModel:getNextTaskId()[i]
			local nextTaskModel = self._achieveTaskList[nextTaskId]

			if nextTaskModel:getStatus() == TaskStatus.kGet and #nextTaskModel:getNextTaskId() == 0 then
				showTaskList[#showTaskList + 1] = nextTaskModel
			elseif nextTaskModel:getStatus() ~= TaskStatus.kGet and (not nextTaskModel:getIsHide() or nextTaskModel:getIsHide() and nextTaskModel:getStatus() ~= TaskStatus.kUnfinish) then
				showTaskList[#showTaskList + 1] = nextTaskModel
			end
		end
	elseif not self._nextTaskMap[taskId] and (not taskModel:getIsHide() or taskModel:getIsHide() and taskModel:getStatus() ~= TaskStatus.kUnfinish) then
		showTaskList[#showTaskList + 1] = taskModel
	end
end

function TaskListModel:getStageMainTask()
	if not self._taskListMap[TaskType.kStage] then
		local tasks = {}

		for i = 1, #tasks do
			local task = tasks[i]

			if task:getStatus() ~= TaskStatus.kGet then
				return task
			end
		end

		return (tasks or nil) and (tasks[1] or nil)
	end
end

function TaskListModel:getStageBranchTask()
	if not self._taskListMap[TaskType.kBranch] then
		local tasks = {}
		local showTask = {}

		for i = 1, #tasks do
			local task = tasks[i]
			local condition = task:getShowCondition()
			local canShow = self._systemKeeper:isConditionReached(condition)

			if canShow and task:getStatus() ~= TaskStatus.kGet then
				table.insert(showTask, task)
			end
		end

		table.sort(showTask, function(a, b)
			return self:compare(a, b)
		end)

		return showTask
	end
end
