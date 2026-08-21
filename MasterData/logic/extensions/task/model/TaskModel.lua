-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/model/TaskModel.lua

module("logic.extensions.task.model.TaskModel", package.seeall)

local M = class("StoreModel", BaseModel)

function M:ctor()
	self._taskTabList = false
	self._allTaskList = false
	self._allPointList = false
	self._curPoint = false
end

function M:onReset()
	self._allPointList = false
	self._allTaskList = false
	self._curPoint = false
end

function M:clearCache()
	table.clear(self._allPointList)
	table.clear(self._allTaskList)

	self._allPointList = false
	self._allTaskList = false
	self._curPoint = false
end

function M:initTaskTabData(taskTabCfgList)
	if not self._taskTabList then
		self._taskTabList = {}
		self._taskTabList[TaskEnum.TaskType.Daily] = false
		self._taskTabList[TaskEnum.TaskType.Weekly] = false
		self._taskTabList[TaskEnum.TaskType.Challenge] = false
		self._taskTabList[TaskEnum.TaskType.Limited] = false
		self._taskTabList[TaskEnum.TaskType.RogueWeekly] = false
		self._taskTabList[TaskEnum.TaskType.RogueMonthly] = false
		self._taskTabList[TaskEnum.TaskType.RogueFixed] = false
	end

	local list = self._taskTabList

	for type, data in pairs(list) do
		local tempList = {}
		local tempType = type

		for index, tabCo in ipairs(taskTabCfgList) do
			if tabCo.type == tempType then
				table.insert(tempList, tabCo)
			end
		end

		local len = #tempList

		if len > 0 then
			table.sort(tempList, function(item1, item2)
				if not item1 or not item2 then
					return false
				end

				local id1 = item1.id
				local id2 = item2.id

				return id1 < id2
			end)

			self._taskTabList[tempType] = tempList[1]
		end
	end
end

function M:initTaskData(taskId, count, isFinish)
	if not self._allTaskList then
		self._allTaskList = {}
	end

	local taskCO = TaskConfig.instance:getTaskCO(taskId)

	if not taskCO then
		return
	end

	local tabId = taskCO.label

	if not self._allTaskList[tabId] then
		self._allTaskList[tabId] = {}
	end

	local isUpdate, dataMo = self:_hasTaskData(tabId, taskId)

	if isUpdate then
		dataMo:updateData(count, isFinish)

		return
	end

	local taskMo = TaskMo.New()

	taskMo:initData(taskId, count, isFinish, taskCO)
	table.insert(self._allTaskList[tabId], taskMo)
end

function M:initPointDatByCfg()
	if self._taskTabList then
		for tabType, tabCO in pairs(self._taskTabList) do
			if tabCO and tabCO.pointIds then
				local tabId = tabCO.id
				local pointLength = #tabCO.pointIds

				for i = 1, pointLength do
					self:initPointData(tabId, 0, false, tabCO.pointIds[i])
				end
			end
		end
	end
end

function M:initPointData(label, point, isFinish, pointId)
	if not self._allPointList then
		self._allPointList = {}
	end

	if not self._allPointList[label] then
		self._allPointList[label] = {}
	end

	if not self._curPoint then
		self._curPoint = {}
	end

	self._curPoint[label] = point

	local isUpdate, dataMo = self:_hasPointData(label, pointId)

	if isUpdate then
		dataMo:updateData(point, isFinish)

		return
	end

	local taskPointMo = TaskPointMo.New()

	taskPointMo:initAgentData(label, point, isFinish, pointId)
	table.insert(self._allPointList[label], taskPointMo)
end

function M:getTaskList(tabId)
	if not self._allTaskList then
		return false
	end

	local list = {}
	local tasklist = self._allTaskList[tabId]

	if tasklist then
		for index, taskMo in ipairs(tasklist) do
			if taskMo:canShow() and not taskMo:isExpired() then
				if taskMo:getPreTask() and taskMo:getPreTask() > 0 then
					local preTaskMo = self:getTaskMoById(taskMo:getPreTask())

					if preTaskMo:getIsFinish() then
						table.insert(list, taskMo)
					end
				else
					table.insert(list, taskMo)
				end
			end
		end
	end

	self:_sortTaskList(list)

	return list
end

function M:getTaskMoById(taskId)
	for tabId, taskList in pairs(self._allTaskList) do
		for index, taskMo in ipairs(taskList) do
			if taskMo:getTaskId() == taskId then
				return taskMo
			end
		end
	end

	return false
end

function M:getTabIdByType(selectType)
	if self._taskTabList then
		for type, tabCO in pairs(self._taskTabList) do
			if selectType == type and tabCO then
				return tabCO.id
			end
		end
	end

	return false
end

function M:getPointList(tabId)
	if not self._allPointList then
		return false
	end

	local list = self._allPointList[tabId]

	return list
end

function M:_sortTaskList(list)
	table.sort(list, function(item1, item2)
		if not item1 or not item2 then
			return false
		end

		local isFinish1 = self:bool2Number(item1:getIsFinish())
		local isFinish2 = self:bool2Number(item2:getIsFinish())
		local isCanGetReward1 = self:bool2Number(item1:canGetReward())
		local isCanGetReward2 = self:bool2Number(item2:canGetReward())
		local limitTask1 = self:bool2Number(item1:getIsLimitTask())
		local limitTask2 = self:bool2Number(item2:getIsLimitTask())
		local id1 = item1:getTaskId()
		local id2 = item2:getTaskId()
		local sortIndex1 = item1:getSortIndex()
		local sortIndex2 = item2:getSortIndex()

		if isFinish1 == isFinish2 then
			if isCanGetReward1 == isCanGetReward2 then
				if limitTask1 == limitTask2 then
					if sortIndex1 == sortIndex2 then
						return id1 < id2
					end

					return sortIndex2 < sortIndex1
				end

				return limitTask2 < limitTask1
			end

			return isCanGetReward2 < isCanGetReward1
		end

		return isFinish1 < isFinish2
	end)
end

function M:bool2Number(value)
	return value and 1 or 0
end

function M:_hasTaskData(tabId, taskId)
	local list = self._allTaskList[tabId]

	for index, taskMo in pairs(list) do
		if taskMo:getTaskId() == taskId then
			return true, taskMo
		end
	end

	return false, nil
end

function M:_hasPointData(tabId, pointId)
	local list = self._allPointList[tabId]

	for index, pointMo in pairs(list) do
		if pointMo:getPointId() == pointId then
			return true, pointMo
		end
	end

	return false, nil
end

function M:getCurPoint(tabId)
	return self._curPoint and self._curPoint[tabId] or 0
end

M.instance = M.New()

return M
