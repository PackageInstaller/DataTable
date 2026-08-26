-- chunkname: @modules/logic/turnback/model/TurnbackTaskModel.lua

module("modules.logic.turnback.model.TurnbackTaskModel", package.seeall)

local TurnbackTaskModel = class("TurnbackTaskModel", ListScrollModel)

function TurnbackTaskModel:onInit()
	self.tempTaskModel = BaseModel.New()
	self.tempOnlineTaskModel = BaseModel.New()
	self.taskLoopTypeDotDict = {}
	self.taskSearchList = {}
	self.taskSearchDict = {}
end

function TurnbackTaskModel:reInit()
	self.tempTaskModel:clear()

	self.taskLoopTypeDotDict = {}
	self.taskSearchList = {}
	self.taskSearchDict = {}
end

function TurnbackTaskModel:setTaskInfoList(taskInfoList)
	local list = {}
	local onlineList = {}

	self.taskSearchList = {}

	local curDay = TurnbackModel.instance:getCurrentTurnbackDay()

	for _, info in ipairs(taskInfoList) do
		local config = TurnbackConfig.instance:getTurnbackTaskCo(info.id)

		if config and config.turnbackTaskType == 0 then
			local mo = TaskMo.New()

			mo:init(info, config)

			local canAdd = config.showDay <= 0 or curDay >= config.showDay

			if canAdd then
				if config.type ~= TurnbackEnum.TaskEnum.Online then
					table.insert(list, mo)
				else
					table.insert(onlineList, mo)
				end
			end

			if config.listenerType == "TodayOnlineSeconds" then
				table.insert(self.taskSearchList, mo)

				self.taskSearchDict[mo.id] = mo
			end
		end
	end

	table.sort(self.taskSearchList, SortUtil.keyLower("id"))
	self.tempTaskModel:setList(list)
	self.tempOnlineTaskModel:setList(onlineList)
	self:sortList()
	self:checkTaskLoopTypeDotState()
end

function TurnbackTaskModel:sortList()
	self.tempTaskModel:sort(function(a, b)
		local valueA = a.finishCount > 0 and 3 or a.progress >= a.config.maxProgress and 1 or 2
		local valueB = b.finishCount > 0 and 3 or b.progress >= b.config.maxProgress and 1 or 2

		if valueA == valueB then
			if a.config.sortId == b.config.sortId then
				return a.id < b.id
			else
				return a.config.sortId < b.config.sortId
			end
		else
			return valueA < valueB
		end
	end)
end

function TurnbackTaskModel:updateInfo(taskInfoList)
	local isChange = false

	for _, info in ipairs(taskInfoList) do
		if info.type == TaskEnum.TaskType.Turnback then
			local mo = self.tempTaskModel:getById(info.id)

			if not mo then
				local config = TurnbackConfig.instance:getTurnbackTaskCo(info.id)

				if config then
					mo = TaskMo.New()

					mo:init(info, config)
					self.tempTaskModel:addAtLast(mo)
				else
					logError("TurnbackTaskConfig by id is not exit: " .. tostring(info.id))
				end
			else
				mo:update(info)
			end

			isChange = true
		end
	end

	if isChange then
		self:sortList()
		self:checkTaskLoopTypeDotState()
	end

	return isChange
end

function TurnbackTaskModel:checkTaskLoopTypeDotState()
	for index, redDotState in pairs(self.taskLoopTypeDotDict) do
		self.taskLoopTypeDotDict[index] = false
	end

	for _, taskMO in ipairs(self.tempTaskModel:getList()) do
		if taskMO.progress >= taskMO.config.maxProgress and taskMO.finishCount == 0 and taskMO.config.turnbackTaskType == 0 then
			self.taskLoopTypeDotDict[taskMO.config.loopType] = true
		end
	end
end

function TurnbackTaskModel:getTaskLoopTypeDotState()
	return self.taskLoopTypeDotDict
end

function TurnbackTaskModel:refreshListNewTaskList()
	local list = {}

	for _, taskMo in ipairs(self.tempTaskModel:getList()) do
		if taskMo.config and taskMo.config.turnbackId == TurnbackModel.instance:getCurTurnbackId() and taskMo.config.turnbackTaskType == 0 then
			local mo = TurnbackModel.instance:getCurTurnbackMo()
			local currenttime = ServerTime.now()
			local unlocktime = mo.startTime + (taskMo.config.unlockDay - 1) * TimeUtil.OneDaySecond

			if unlocktime <= currenttime then
				table.insert(list, taskMo)
			end
		end
	end

	list = self:checkAndRemoveTask(list)

	self:setList(list)
end

function TurnbackTaskModel:refreshList(loopType)
	local list = {}

	for _, taskMo in ipairs(self.tempTaskModel:getList()) do
		if taskMo.config.loopType == loopType and taskMo.config.turnbackId == TurnbackModel.instance:getCurTurnbackId() and taskMo.config.turnbackTaskType == 0 then
			self.curTaskLoopType = loopType

			table.insert(list, taskMo)
		end
	end

	list = self:checkAndRemovePreposeTask(list)

	self:setList(list)
	self:checkTaskLoopTypeDotState()
end

function TurnbackTaskModel:getCurTaskLoopType()
	return self.curTaskLoopType or TurnbackEnum.TaskLoopType.Day
end

function TurnbackTaskModel:haveTaskItemReward()
	for _, taskMo in ipairs(self.tempTaskModel:getList()) do
		if taskMo.config.turnbackTaskType == 0 and taskMo.progress >= taskMo.config.maxProgress and taskMo.finishCount == 0 then
			return true
		end
	end

	return false
end

function TurnbackTaskModel:isTaskFinished(taskMo)
	return taskMo.finishCount > 0 and taskMo.progress >= taskMo.config.maxProgress
end

function TurnbackTaskModel:getSearchTaskMoList()
	return self.taskSearchList
end

function TurnbackTaskModel:getSearchTaskMoById(id)
	return self.taskSearchDict[id]
end

function TurnbackTaskModel:checkSearchTaskCanReceive()
	if not self.taskSearchList or #self.taskSearchList < 1 then
		return false
	end

	for index, taskMo in ipairs(self.taskSearchList) do
		if taskMo.config.turnbackTaskType == 0 and taskMo.progress >= taskMo.config.maxProgress and taskMo.finishCount == 0 then
			return true
		end
	end

	return false
end

function TurnbackTaskModel:checkAndRemovePreposeTask(taskList)
	local newTaskList = tabletool.copy(taskList)

	for index, taskMo in ipairs(newTaskList) do
		local preposTaskTab = string.split(taskMo.config.prepose, "#")

		if taskMo.config.turnbackTaskType == 0 then
			for _, preposTaskId in ipairs(preposTaskTab) do
				local preposTaskMo = self.tempTaskModel:getById(tonumber(preposTaskId))

				if preposTaskMo and not self:isTaskFinished(preposTaskMo) then
					table.remove(newTaskList, index)

					break
				end
			end
		end
	end

	return newTaskList
end

function TurnbackTaskModel:checkAndRemoveTask(taskList)
	local newTaskList = tabletool.copy(taskList)
	local count = #taskList

	for i = 1, count do
		local taskMo = taskList[i]

		if taskMo.config.turnbackTaskType == 0 then
			local preposTaskTab = string.split(taskMo.config.prepose, "#")

			for _, preposTaskId in ipairs(preposTaskTab) do
				local preposTaskMo = self.tempTaskModel:getById(tonumber(preposTaskId))

				if preposTaskMo and not self:isTaskFinished(preposTaskMo) then
					tabletool.removeValue(newTaskList, taskMo)
				end
			end

			if taskMo.config.isOnlineTimeTask then
				tabletool.removeValue(newTaskList, taskMo)
			end
		end
	end

	return newTaskList
end

function TurnbackTaskModel:checkOnlineTaskAllFinish()
	for _, taskMo in ipairs(self.taskSearchList) do
		if taskMo.finishCount <= 0 and taskMo.config.turnbackTaskType == 0 then
			return false
		end
	end

	return true
end

function TurnbackTaskModel:getCanGetTaskRewardId()
	local idList = {}
	local indexList = {}

	for index, taskMo in ipairs(self.tempTaskModel:getList()) do
		if taskMo.progress >= taskMo.config.maxProgress and taskMo.finishCount == 0 and taskMo.config.turnbackTaskType == 0 then
			table.insert(idList, taskMo.id)
			table.insert(indexList, index)
		end
	end

	return idList, indexList
end

TurnbackTaskModel.instance = TurnbackTaskModel.New()

return TurnbackTaskModel
