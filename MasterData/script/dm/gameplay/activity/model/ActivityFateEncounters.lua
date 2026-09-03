-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/ActivityFateEncounters.lua

ActivityFateEncounters = class("ActivityFateEncounters", BaseActivity, _M)

ActivityFateEncounters:has("_taskList", {
	is = "r"
})
ActivityFateEncounters:has("_taskActivity", {
	is = "r"
})
ActivityFateEncounters:has("_endTime", {
	is = "r"
})
ActivityFateEncounters:has("_id", {
	is = "r"
})
ActivityFateEncounters:has("_selectId", {
	is = "r"
})
ActivityFateEncounters:has("_config", {
	is = "r"
})

function ActivityFateEncounters:initialize()
	super.initialize(self)

	self._endTime = 0
	self._taskList = {}
end

function ActivityFateEncounters:dispose()
	super.dispose(self)
end

function ActivityFateEncounters:synchronize(data)
	if not data then
		return
	end

	if data.activityId then
		self._id = data.activityId
	end

	if data.selectId then
		self._selectId = data.selectId
	end

	self._config = ConfigReader:getRecordById("Activity", self._id)

	if data.timeStamp and data.timeStamp.finishTs then
		self._endTime = data.timeStamp.finishTs
	end

	if data.taskList then
		self:updataTaskList(data.taskList)
	end

	super.synchronize(self, data)
end

function ActivityFateEncounters:getModelIdList()
	local count = 0
	local list = {}
	local choice = self._config.ActivityConfig.Choice

	for index, value in pairs(choice) do
		count = count + 1
	end

	for i = 1, count do
		table.insert(list, choice[tostring(i)].ModelId)
	end

	return list
end

function ActivityFateEncounters:getSelectIndex(modelId)
	local choice = self._config.ActivityConfig.Choice

	for key, value in pairs(choice) do
		if modelId == value.ModelId then
			return key
		end
	end

	return 1
end

function ActivityFateEncounters:isChooseTask()
	return not self._selectId or self._selectId == ""
end

function ActivityFateEncounters:hasRedPoint()
	if self:isChooseTask() then
		return true
	end

	return self:hasRewardToGet()
end

function ActivityFateEncounters:getTaskCountByStatus(status)
	local value = 0

	for i, task in pairs(self._taskList) do
		if task ~= nil and task:getStatus() == status then
			value = value + 1
		end
	end

	return value
end

function ActivityFateEncounters:hasRewardToGet()
	return self:getTaskCountByStatus(ActivityTaskStatus.kFinishNotGet) > 0
end

function ActivityFateEncounters:updataTaskList(data)
	if data and table.nums(data) > 0 then
		for id, value in pairs(data) do
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
	end
end

function ActivityFateEncounters:getActivityTaskById(taskId)
	if self._taskList then
		for k, v in pairs(self._taskList) do
			if v:getId() == taskId then
				return v
			end
		end
	end
end

function ActivityFateEncounters:getActivityConfig()
	if self:isChooseTask() then
		return nil
	end

	local actConfig = ConfigReader:getRecordById("Activity", self._selectId)

	return actConfig.ActivityConfig
end

function ActivityFateEncounters:getSubTaskLeaveNum()
	local num = 0

	for _, value in pairs(myTable) do
		num = num + 1
	end

	return num
end
