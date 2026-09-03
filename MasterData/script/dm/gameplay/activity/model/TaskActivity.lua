-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/TaskActivity.lua

TaskActivity = class("TaskActivity", BaseActivity, _M)

TaskActivity:has("_taskList", {
	is = "r"
})
TaskActivity:has("_isTodayOpen", {
	is = "r"
})

function TaskActivity:initialize()
	super.initialize(self)

	self._taskList = {}
	self._isTodayOpen = false
end

function TaskActivity:dispose()
	super.dispose(self)
end

function TaskActivity:initAllAchieveTask()
	if self._config then
		local actConfig = self:getActivityConfig()

		if actConfig.Allachieve and not self._allAchieveTaskList then
			self._allAchieveTaskList = {}

			for i, v in pairs(actConfig.Allachieve) do
				local task = ActivityNumTask:new()
				local data = {}

				data.targetValue = v.num
				data.reward = v.reward
				data.descId = v.translate
				data.activityId = self._id
				data.orderNum = 10000 + i

				task:synchronize(data)

				self._allAchieveTaskList[tostring(v.num)] = task
			end
		end
	end
end

function TaskActivity:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)
	self:initAllAchieveTask()

	if data.taskList then
		for id, value in pairs(data.taskList) do
			value.taskId = value.taskId or id
			value.activityId = value.activityId or data.activityId

			local task = self:getActivityTaskById(id)

			if task then
				task:updateModel(value)
			else
				local taskConfig = ConfigReader:getRecordById("ActivityTask", id)

				if taskConfig ~= nil and taskConfig.Id ~= nil then
					task = ActivityTask:new()

					task:synchronizeModel(value)

					self._taskList[#self._taskList + 1] = task
				end
			end
		end

		if self._allAchieveTaskList then
			local unfinishCount = self:getTaskCountByStatus(ActivityTaskStatus.kUnfinish)

			for k, task in pairs(self._allAchieveTaskList) do
				task:synchronize({
					currentValue = #self._taskList - unfinishCount
				})
			end
		end
	end

	if data.isTodayOpen then
		self._isTodayOpen = data.isTodayOpen
	end

	if data.rewards then
		for k, status in pairs(data.rewards) do
			dump(type(k))
			self._allAchieveTaskList[k]:setGetStatus(status)
			self._allAchieveTaskList[k]:updateStatus()
		end
	end
end

function TaskActivity:getTaskCountByStatus(status)
	local value = 0

	for i, task in pairs(self._taskList) do
		if task ~= nil and task:getStatus() == status then
			value = value + 1
		end
	end

	return value
end

function TaskActivity:hasRewardToGet()
	return self:getTaskCountByStatus(ActivityTaskStatus.kFinishNotGet) > 0
end

function TaskActivity:hasRedPoint()
	return self:hasRewardToGet()
end

function TaskActivity:getActivityTaskById(taskId)
	if self._taskList then
		for k, v in pairs(self._taskList) do
			if v:getId() == taskId then
				return v
			end
		end
	end
end

function TaskActivity:getActivityTaskIndexById(taskId)
	if self._taskList then
		for k, v in pairs(self._taskList) do
			if v:getId() == taskId then
				return k
			end
		end
	end
end

function TaskActivity:getSortActivityList()
	local list = {}

	for i, taskData in pairs(self._taskList) do
		list[#list + 1] = taskData
	end

	if self._allAchieveTaskList then
		for i, taskData in pairs(self._allAchieveTaskList) do
			list[#list + 1] = taskData
		end
	end

	table.sort(list, function(a, b)
		if a:getStatus() ~= b:getStatus() then
			return kTaskStatusPriorityMap[a:getStatus()] < kTaskStatusPriorityMap[b:getStatus()]
		else
			return a:getOrderNum() < b:getOrderNum()
		end
	end)

	return list
end

function TaskActivity:getTimeStr()
	if self._timeStr then
		return self._timeStr
	end

	local timeStr = self:getLocalTimeFactor()
	local start = ""
	local end_ = ""

	if timeStr.start then
		start = type(timeStr.start) == "table" and string.split(timeStr.start[1], " ")[1] or string.split(timeStr.start, " ")[1]

		local startTemp = string.split(start, "-")

		start = string.format("%s.%s.%s", startTemp[1], tonumber(startTemp[2]), tonumber(startTemp[3]))
	end

	if timeStr["end"] then
		end_ = string.split(timeStr["end"], " ")[1]

		local endTemp = string.split(end_, "-")

		end_ = string.format("%s.%s.%s", endTemp[1], tonumber(endTemp[2]), tonumber(endTemp[3]))
	end

	self._timeStr = string.format("%s~%s", start, end_)

	return self._timeStr
end

function TaskActivity:delete(data)
	if data.taskList then
		for id, v in pairs(data.taskList) do
			local index = self:getActivityTaskIndexById(id)

			if index then
				if v == 1 then
					table.remove(self._taskList, index)
				else
					local task = self._taskList[index]

					if task.delete then
						task:delete(v)
					end
				end
			end
		end
	end
end
