-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/ActivityTaskMonthCard.lua

ActivityTaskMonthCard = class("ActivityTaskMonthCard", BaseActivity, _M)

ActivityTaskMonthCard:has("_taskList", {
	is = "r"
})

function ActivityTaskMonthCard:initialize()
	super.initialize(self)

	self._taskList = {}
end

function ActivityTaskMonthCard:dispose()
	super.dispose(self)
end

function ActivityTaskMonthCard:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)

	if data.taskList then
		for id, value in pairs(data.taskList) do
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

function ActivityTaskMonthCard:getTaskCountByStatus(status)
	local value = 0

	for i, task in pairs(self._taskList) do
		if task ~= nil and task:getStatus() == status then
			value = value + 1
		end
	end

	return value
end

function ActivityTaskMonthCard:hasRewardToGet()
	return self:getTaskCountByStatus(ActivityTaskStatus.kFinishNotGet) > 0
end

function ActivityTaskMonthCard:hasRedPoint()
	return self:hasRewardToGet()
end

function ActivityTaskMonthCard:getActivityTaskById(taskId)
	if self._taskList then
		for k, v in pairs(self._taskList) do
			if v:getId() == taskId then
				return v
			end
		end
	end
end

function ActivityTaskMonthCard:getSortActivityList()
	local list = {}

	for i, taskData in pairs(self._taskList) do
		list[#list + 1] = taskData
	end

	table.sort(list, function(a, b)
		return a:getOrderNum() < b:getOrderNum()
	end)

	return list
end

function ActivityTaskMonthCard:getForeverGotStatus(taskId)
	local list = self:getForeverGot()

	for key, _taskId in pairs(list) do
		if _taskId == taskId then
			return true
		end
	end

	return false
end
