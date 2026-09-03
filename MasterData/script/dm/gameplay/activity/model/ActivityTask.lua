-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/ActivityTask.lua

ActivityTask = class("ActivityTask", objectlua.Object, _M)

ActivityTask:has("_id", {
	is = "rw"
})
ActivityTask:has("_status", {
	is = "rw"
})
ActivityTask:has("_config", {
	is = "rw"
})
ActivityTask:has("_taskValueList", {
	is = "rw"
})
ActivityTask:has("_activityId", {
	is = "rw"
})
ActivityTask:has("_type", {
	is = "rw"
})

function ActivityTask:initialize()
	super.initialize(self)

	self._type = "ActivityTask"
	self._id = ""
	self._status = ActivityTaskStatus.kUnfinish
	self._config = {}
	self._taskValueList = {}
	self._activityId = ""
end

function ActivityTask:synchronizeModel(data)
	if not data then
		return
	end

	if data.taskId then
		self._id = data.taskId
		self._config = ConfigReader:getRecordById("ActivityTask", self._id)

		assert(self._config ~= nil, "error:cannot find config id =_" .. tostring(self._id) .. "_")
	end

	if data.activityId then
		self._activityId = data.activityId
	end

	if data.taskValues then
		self:updateTaskValue(data.taskValues)
	end

	if data.taskStatus then
		self:setStatus(tonumber(data.taskStatus))
	end
end

function ActivityTask:updateModel(data)
	if not data then
		return
	end

	if data.activityId then
		self._activityId = data.activityId
	end

	if data.taskStatus then
		self._status = tonumber(data.taskStatus)
	end

	if data.taskValues then
		self:updateTaskValue(data.taskValues)
	end
end

function ActivityTask:updateTaskValue(data)
	if data then
		for k, value in pairs(data) do
			self._taskValueList[tonumber(k) + 1] = self._taskValueList[tonumber(k) + 1] or value

			if value.currentValue then
				self._taskValueList[tonumber(k) + 1].currentValue = value.currentValue
			end

			if value.targetValue then
				self._taskValueList[tonumber(k) + 1].targetValue = value.targetValue
			end

			if value.targetList then
				self._taskValueList[tonumber(k) + 1].targetList = value.targetList
			end
		end
	end
end

function ActivityTask:isProgressTask()
	local taskValue = self._taskValueList[1]

	return taskValue.targetValue ~= 0
end

function ActivityTask:getDestUrl()
	return self:getConfig().Destination
end

function ActivityTask:getName()
	return self:getConfig().Name
end

function ActivityTask:getDesc()
	return self:getConfig().Desc
end

function ActivityTask:getTaskIcon()
	return self:getConfig().TaskIcon
end

function ActivityTask:getReward()
	return ConfigReader:getRecordById("Reward", tostring(self:getConfig().Reward))
end

function ActivityTask:getExtraReward()
	return ConfigReader:getRecordById("Reward", tostring(self:getConfig().ExtraReward))
end

function ActivityTask:getCondition()
	return self:getConfig().Condition
end

function ActivityTask:getOrderNum()
	return self:getConfig().OrderNum
end

function ActivityTask:getOrderStatusNum()
	return self._status == ActivityTaskStatus.kUnfinish and 20 or self._status == ActivityTaskStatus.kGet and 10 or 30
end

function ActivityTask:getTaskUnFinishNum()
	local num = 0

	for _, v in pairs(self._taskValueList[1].targetList) do
		num = num + 1
	end

	return num
end

function ActivityTask:getTaskTotalhNum()
	return #self._config.Condition[1].factorStr1
end
