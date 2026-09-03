-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/mazeTower/model/MazeTower.lua

require("dm.gameplay.mazeTower.model.MazeTowerGrid")

MazeTower = class("MazeTower", objectlua.Object, _M)

MazeTower:has("_curPointId", {
	is = "rw"
})
MazeTower:has("_totalPointNum", {
	is = "rw"
})
MazeTower:has("_fightTime", {
	is = "rw"
})
MazeTower:has("_map", {
	is = "rw"
})
MazeTower:has("_posX", {
	is = "rw"
})
MazeTower:has("_posY", {
	is = "rw"
})
MazeTower:has("_taskList", {
	is = "rw"
})
MazeTower:has("_oldPointId", {
	is = "rw"
})

function MazeTower:initialize()
	super.initialize(self)

	self._curPointId = ""
	self._totalPointNum = 0
	self._fightTime = 0
	self._map = {}
	self._posX = 1
	self._posY = 1
	self._taskList = {}
end

function MazeTower:synchronize(data)
	dump(data, "data-_____MazeTower")

	if not data then
		return
	end

	if data.curPointId then
		self._curPointId = data.curPointId
		self._oldPointId = self._oldPointId or self._curPointId
	end

	if data.totalPointNum then
		self._totalPointNum = data.totalPointNum
	end

	if data.fightTime then
		self._fightTime = data.fightTime.value
	end

	if data.map then
		self:syncMapInfo(data.map)
	end

	if data.x then
		self._posX = data.x
	end

	if data.y then
		self._posY = data.y
	end

	if data.tasks then
		for id, value in pairs(data.tasks) do
			value.taskId = value.taskId or id

			local task = self:getTaskById(id)

			if task then
				task:updateModel(value)
			else
				local taskConfig = ConfigReader:getRecordById("Task", id)

				if taskConfig ~= nil and taskConfig.Id ~= nil then
					task = TaskModel:new()

					task:synchronizeModel(value)

					self._taskList[#self._taskList + 1] = task
				end
			end
		end
	end
end

function MazeTower:syncMapInfo(data)
	if self._curPointId ~= self._oldPointId then
		self._map = {}
		self._oldPointId = self._curPointId
	end

	for i, v in pairs(data) do
		self._map[tonumber(i) + 1] = self._map[tonumber(i) + 1] or {}

		for j, value in pairs(v) do
			local grid = self._map[tonumber(i) + 1][tonumber(j) + 1]

			if not grid then
				grid = MazeTowerGrid:new()
				self._map[tonumber(i) + 1][tonumber(j) + 1] = grid
			end

			grid:synchronize(value)
		end
	end
end

function MazeTower:getTaskById(taskId)
	if self._taskList then
		for k, v in pairs(self._taskList) do
			if v:getId() == taskId then
				return v
			end
		end
	end
end

function MazeTower:getTaskCountByStatus(status)
	local value = 0

	for i, task in pairs(self._taskList) do
		if task ~= nil and task:getStatus() == status then
			value = value + 1
		end
	end

	return value
end

function MazeTower:getSortTaskList()
	local list = {}

	for i, taskData in pairs(self._taskList) do
		list[#list + 1] = taskData
	end

	table.sort(list, function(a, b)
		if a:getStatus() ~= b:getStatus() then
			return kTaskStatusPriorityMap[a:getStatus()] < kTaskStatusPriorityMap[b:getStatus()]
		else
			return a:getSortId() < b:getSortId()
		end
	end)

	return list
end

function MazeTower:hasTaskReward()
	for i, task in pairs(self._taskList) do
		if task:getStatus() == TaskStatus.kFinishNotGet then
			return true
		end
	end

	return false
end

function MazeTower:hasRedPoint()
	if self:hasTaskReward() then
		return true
	end

	if self._fightTime > 0 then
		return true
	end

	return false
end
