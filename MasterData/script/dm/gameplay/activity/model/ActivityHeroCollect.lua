-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/model/ActivityHeroCollect.lua

ActivityHeroCollect = class("ActivityHeroCollect", BaseActivity, _M)

ActivityHeroCollect:has("_taskList", {
	is = "r"
})

function ActivityHeroCollect:initialize()
	super.initialize(self)

	self._endTime = 0
	self._taskList = {}
end

function ActivityHeroCollect:dispose()
	super.dispose(self)
end

function ActivityHeroCollect:synchronize(data)
	if not data then
		return
	end

	if data.timeStamp and data.timeStamp.finishTs then
		self._endTime = data.timeStamp.finishTs
	end

	if data.taskList then
		self:updateTaskList(data.taskList)
	end

	super.synchronize(self, data)
end

function ActivityHeroCollect:updateTaskList(data)
	for key, value in pairs(data) do
		if self._taskList[key] then
			if value.taskStatus then
				self._taskList[key].taskStatus = value.taskStatus
			end

			if value.taskValues and value.taskValues["0"] then
				local data = value.taskValues["0"]

				if data.currentValue then
					self._taskList[key].taskValues["0"].currentValue = data.currentValue
				end
			end
		else
			self._taskList[key] = value
		end
	end
end

function ActivityHeroCollect:getTaskList()
	local list = {}
	local num = 1

	for k, v in pairs(self._taskList) do
		if v.taskStatus == 2 then
			num = num + 1
		end

		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		local orderNumA = ConfigReader:getDataByNameIdAndKey("ActivityTask", a.taskId, "OrderNum")
		local orderNumB = ConfigReader:getDataByNameIdAndKey("ActivityTask", b.taskId, "OrderNum")

		return orderNumA < orderNumB
	end)

	local tasks = {}

	for i = 1, num do
		table.insert(tasks, list[i])
	end

	return tasks
end

function ActivityHeroCollect:getActivityEndTime()
	return self._endTime
end

function ActivityHeroCollect:getTaskTargerNum(taskId)
	for key, value in pairs(self._taskList) do
		if value.taskId == taskId then
			return value.taskValues["0"].targetValue
		end
	end

	return 0
end

function ActivityHeroCollect:getTaskProgressNum(taskId)
	for key, value in pairs(self._taskList) do
		if value.taskId == taskId then
			return value.taskValues["0"].currentValue
		end
	end

	return 0
end

function ActivityHeroCollect:getReward(taskId)
	local config = ConfigReader:getRecordById("ActivityTask", taskId)
	local rewardConfig = ConfigReader:getRecordById("Reward", tostring(config.Reward))

	return rewardConfig.Content[1]
end

function ActivityHeroCollect:getTaskURL(taskId)
	local config = ConfigReader:getRecordById("ActivityTask", taskId)

	return config.Destination
end

function ActivityHeroCollect:getRewardState(taskId)
	for key, value in pairs(self._taskList) do
		if taskId == value.taskId then
			return value.taskStatus
		end
	end

	return 0
end

function ActivityHeroCollect:hasRedPoint()
	local openTask = self:getTaskList()

	for i = 1, #openTask do
		if openTask[i].taskStatus == 1 then
			return true
		end
	end

	return false
end
