-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/task/model/TaskModel.lua

TaskModel = class("TaskModel", objectlua.Object, _M)

TaskModel:has("_id", {
	is = "rw"
})
TaskModel:has("_status", {
	is = "rw"
})
TaskModel:has("_config", {
	is = "rw"
})
TaskModel:has("_sortId", {
	is = "rw"
})
TaskModel:has("_taskValueList", {
	is = "rw"
})

TaskFinishDeal = {
	kRemain,
	kRemove
}

function TaskModel:initialize()
	super.initialize(self)

	self._id = ""
	self._status = TaskStatus.kUnfinish
	self._config = {}
	self._sortId = 0
	self._taskValueList = {}
end

function TaskModel:synchronizeModel(data)
	if data == nil then
		return
	end

	self._id = data.taskId

	if data.taskValues then
		self:updateTaskValue(data.taskValues)
	end

	if data.taskStatus then
		self:setStatus(tonumber(data.taskStatus))
	end

	self._config = ConfigReader:getRecordById("Task", self._id)

	assert(self._config ~= nil, "error:cannot find config id =_" .. tostring(self._id) .. "_")

	self._sortId = self._config.OrderNum
end

function TaskModel:updateModel(data)
	if data then
		if data.taskStatus then
			self:setStatus(tonumber(data.taskStatus))
		end

		if data.taskValues then
			self:updateTaskValue(data.taskValues)
		end
	end
end

function TaskModel:updateTaskValue(data)
	if data then
		for k, value in pairs(data) do
			self._taskValueList[tonumber(k) + 1] = self._taskValueList[tonumber(k) + 1] or value

			if value.currentValue then
				self._taskValueList[tonumber(k) + 1].currentValue = value.currentValue
			end

			if value.targetValue then
				self._taskValueList[tonumber(k) + 1].targetValue = value.targetValue
			end
		end
	end
end

function TaskModel:isVipTask()
	return self:getVipLevel() > 0
end

function TaskModel:isProgressTask()
	local taskValue = self._taskValueList[1]

	return taskValue.targetValue ~= 0
end

function TaskModel:getDestUrl()
	return self:getConfig().Destination
end

function TaskModel:getName()
	return Strings:get(self:getConfig().Name)
end

function TaskModel:getDesc()
	return Strings:get(self:getConfig().Desc)
end

function TaskModel:getTaskIcon()
	return self:getConfig().TaskIcon
end

function TaskModel:getOpenLevel()
	return self:getConfig().OpenLevel
end

function TaskModel:getVipLevel()
	return self:getConfig().VipLevel
end

function TaskModel:getReward()
	return RewardSystem:getRewardsById(self:getConfig().Reward)
end

function TaskModel:getTaskType()
	return self:getConfig().TaskType
end

function TaskModel:getAfterFinish()
	return self:getConfig().AfterFinish or TaskFinishDeal.kRemove
end

function TaskModel:getCondition()
	return self:getConfig().Condition
end

function TaskModel:getShowCondition()
	return self:getConfig().ClientCondition
end

function TaskModel:getHomeBubbleTips()
	return self:getConfig().TaskBubble
end

function TaskModel:getNextTaskId()
	return self:getConfig().Next or {}
end

function TaskModel:getIsStartTask()
	return self:getConfig().IsStartTask
end
