-- chunkname: @modules/logic/room/model/mainview/RoomTaskModel.lua

module("modules.logic.room.model.mainview.RoomTaskModel", package.seeall)

local RoomTaskModel = class("RoomTaskModel", BaseModel)

function RoomTaskModel:onInit()
	self:clear()
end

function RoomTaskModel:reInit()
	self:clear()
end

function RoomTaskModel:clear()
	RoomTaskModel.super.clear(self)

	self._taskDatas = nil
	self._taskMap = nil
	self._showList = nil
	self._taskFinishMap = nil
	self.hasTask = false
	self._isRunning = false
end

function RoomTaskModel:buildDatas()
	self._isRunning = true
	self.hasTask = false

	self:initData()
	self:initConfig()
end

function RoomTaskModel:handleTaskUpdate()
	if self._isRunning then
		self.hasTask = false

		return self:updateData()
	end
end

function RoomTaskModel:initData()
	local taskDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Room)
	local result = {}
	local taskIDDict = {}
	local taskFinishedIDDict = {}

	if taskDict then
		for taskId, mo in pairs(taskDict) do
			if mo.config ~= nil then
				local running = mo.finishCount <= 0

				if running then
					self.hasTask = true

					table.insert(result, mo)

					taskIDDict[mo.id] = mo
				else
					taskFinishedIDDict[mo.id] = mo
				end
			end
		end
	end

	table.sort(result, RoomSceneTaskController.sortTask)

	self._taskDatas = result
	self._taskMap = taskIDDict
	self._taskFinishMap = taskFinishedIDDict
end

function RoomTaskModel:initConfig()
	local cfgList = TaskConfig.instance:gettaskroomlist()
	local showList = {}
	local isStartFocus = false

	for _, taskCo in ipairs(cfgList) do
		local taskId = taskCo.id

		if not isStartFocus and (self._taskFinishMap[taskId] or self._taskMap[taskId]) and taskCo.isOnline == 1 then
			isStartFocus = true
		end

		local notFinish = self._taskFinishMap[taskId] == nil

		if isStartFocus and notFinish then
			table.insert(showList, taskCo)
		end
	end

	table.sort(showList, RoomSceneTaskController.sortTaskConfig)

	self._showList = showList
end

function RoomTaskModel:updateData()
	local taskDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Room)
	local deleteList

	if taskDict then
		local needSort = false

		for taskId, mo in pairs(taskDict) do
			if mo.config ~= nil then
				local running = mo.finishCount <= 0

				if not running then
					if self._taskMap[taskId] then
						deleteList = deleteList or {}

						table.insert(deleteList, mo)
						self:deleteTaskData(mo)
					end

					self._taskFinishMap[mo.id] = mo
				elseif running then
					if not self._taskMap[taskId] then
						self:addTaskData(mo)

						needSort = true
					else
						self:updateTaskData(mo)
					end
				end
			end
		end

		if needSort then
			table.sort(self._taskDatas, RoomSceneTaskController.sortTask)
			self:initConfig()
		end
	end

	return deleteList
end

function RoomTaskModel:deleteTaskData(taskMO)
	local taskId = taskMO.config.id

	for index, mo in pairs(self._taskDatas) do
		if mo.config.id == taskId then
			table.remove(self._taskDatas, index)
		end
	end

	for index, co in pairs(self._showList) do
		if taskId == co.id then
			table.remove(self._showList, index)
		end
	end

	self._taskMap[taskId] = nil
end

function RoomTaskModel:addTaskData(taskMO)
	table.insert(self._taskDatas, taskMO)

	self._taskMap[taskMO.id] = taskMO
end

function RoomTaskModel:updateTaskData(taskMO)
	local taskId = taskMO.config.id

	for index, mo in pairs(self._taskDatas) do
		if mo.config.id == taskId then
			self._taskDatas[index] = taskMO

			break
		end
	end

	self._taskMap[taskId] = taskMO
end

function RoomTaskModel:getTaskDatas()
	return self._taskDatas
end

function RoomTaskModel:getNextTaskConfig()
	for _, taskCo in ipairs(self._showList) do
		if not self._taskMap[taskCo.id] and not self._taskFinishMap[taskCo.id] then
			return taskCo
		end
	end

	return nil
end

function RoomTaskModel:tryGetTaskMO(taskId)
	return self._taskMap[taskId]
end

function RoomTaskModel:getShowList()
	return self._showList
end

RoomTaskModel.instance = RoomTaskModel.New()

return RoomTaskModel
