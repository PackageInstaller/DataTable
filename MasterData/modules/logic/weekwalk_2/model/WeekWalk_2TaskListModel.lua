-- chunkname: @modules/logic/weekwalk_2/model/WeekWalk_2TaskListModel.lua

module("modules.logic.weekwalk_2.model.WeekWalk_2TaskListModel", package.seeall)

local WeekWalk_2TaskListModel = class("WeekWalk_2TaskListModel", ListScrollModel)

function WeekWalk_2TaskListModel:setTaskRewardList(value)
	self._rewardList = value
end

function WeekWalk_2TaskListModel:getTaskRewardList()
	return self._rewardList
end

function WeekWalk_2TaskListModel:getLayerTaskMapId()
	return self._layerTaskMapId
end

function WeekWalk_2TaskListModel:getSortIndex(mo)
	return self._sortMap[mo] or 0
end

function WeekWalk_2TaskListModel:_canGet(id)
	local taskMo = WeekWalk_2TaskListModel.instance:getTaskMo(id)

	if taskMo then
		local config = lua_task_weekwalk_ver2.configDict[id]
		local isGet = taskMo.finishCount >= config.maxFinishCount
		local isFinish = taskMo.hasFinished

		if isFinish and not isGet then
			return true
		end
	end
end

function WeekWalk_2TaskListModel:getCanGetList()
	local list = {}

	for i, v in ipairs(self:getList()) do
		if v.id and self:_canGet(v.id) then
			table.insert(list, v.id)
		end
	end

	return list
end

function WeekWalk_2TaskListModel:checkPeriods(mo)
	if string.nilorempty(mo.periods) then
		return true
	end

	local list = string.splitToNumber(mo.periods, "#")

	if not list[1] then
		if not list[2] then
			local maxId = 0
			local info = WeekWalk_2Model.instance:getInfo()

			return info and list[1] <= info.issueId and maxId >= info.issueId
		end
	end
end

function WeekWalk_2TaskListModel:showLayerTaskList(type, mapId)
	self._layerTaskMapId = mapId

	local result = {}

	self._sortMap = {}

	local index = 1
	local num = 0
	local mapConfig = lua_weekwalk_ver2.configDict[mapId]

	if mapConfig then
		if not mapConfig.layer then
			local layerId = 0
			local list = WeekWalk_2Config.instance:getWeekWalkTaskList(type)

			for i, mo in ipairs(list) do
				local check = mo.layerId == layerId

				if check and self:checkPeriods(mo) then
					table.insert(result, mo)

					self._sortMap[mo] = index
					index = index + 1

					if self:_canGet(mo.id) then
						num = num + 1
					end
				end
			end

			table.sort(result, self._sort)

			if num > 1 then
				table.insert(result, 1, {
					id = 0,
					isGetAll = true,
					minTypeId = type
				})
			end

			local fakeItem = {
				isDirtyData = true
			}

			table.insert(result, fakeItem)
			self:setList(result)
		end
	end
end

function WeekWalk_2TaskListModel:showTaskList(type, mapId)
	WeekWalk_2TaskListModel._mapId = tostring(mapId)

	local list = WeekWalk_2Config.instance:getWeekWalkTaskList(type)

	table.sort(list, self._sort)

	local result = {}
	local num = self:canGetRewardNum(type)

	if num > 1 then
		table.insert(result, 1, {
			id = 0,
			isGetAll = true,
			minTypeId = type
		})
	end

	for i, v in ipairs(list) do
		table.insert(result, v)
	end

	local fakeItem = {
		isDirtyData = true
	}

	table.insert(result, fakeItem)
	self:setList(result)
end

function WeekWalk_2TaskListModel:canGetRewardNum(type, mapId)
	local list = WeekWalk_2Config.instance:getWeekWalkTaskList(type)
	local num = 0
	local unFinishNum = 0
	local layerId

	if mapId then
		local mapConfig = lua_weekwalk_ver2.configDict[mapId]

		layerId = mapConfig.layer
	end

	if not list then
		return num, unFinishNum
	end

	for i, mo in ipairs(list) do
		local taskMo = WeekWalk_2TaskListModel.instance:getTaskMo(mo.id)

		if taskMo then
			local config = lua_task_weekwalk_ver2.configDict[mo.id]
			local isGet = taskMo.finishCount >= config.maxFinishCount
			local isFinish = taskMo.hasFinished
			local check = not layerId or mo.layerId == layerId

			if check and self:checkPeriods(mo) then
				if not isGet then
					unFinishNum = unFinishNum + 1
				end

				if isFinish and not isGet then
					num = num + 1
				end
			end
		end
	end

	return num, unFinishNum
end

function WeekWalk_2TaskListModel:getAllTaskInfo()
	local cur = 0
	local total = 0
	local canGetList = {}
	local firstLayer, firstFinishLayer
	local info = WeekWalk_2Model.instance:getInfo()

	for i = 1, WeekWalk_2Enum.MaxLayer do
		local layerInfo = info:getLayerInfoByLayerIndex(i)
		local rewardList = WeekWalk_2Config.instance:getWeekWalkRewardList(layerInfo.config.layer)

		if rewardList then
			firstLayer = firstLayer or layerInfo.id

			for taskId, num in pairs(rewardList) do
				local taskConfig = lua_task_weekwalk_ver2.configDict[taskId]

				if taskConfig and WeekWalk_2TaskListModel.instance:checkPeriods(taskConfig) then
					total = total + num

					local taskMo = WeekWalk_2TaskListModel.instance:getTaskMo(taskId)
					local config = lua_task_weekwalk_ver2.configDict[taskId]
					local isGet = taskMo and taskMo.finishCount >= config.maxFinishCount

					if isGet then
						cur = cur + num
					elseif taskMo and taskMo.hasFinished then
						table.insert(canGetList, taskId)

						firstFinishLayer = firstFinishLayer or layerInfo.id
					end
				end
			end
		end
	end

	return cur, total, canGetList, firstFinishLayer or firstLayer
end

function WeekWalk_2TaskListModel:getOnceAllTaskInfo()
	local cur = 0
	local total = 0
	local canGetList = {}
	local rewardList = WeekWalk_2Config.instance:getWeekWalkTaskList(WeekWalk_2Enum.TaskType.Once)

	if rewardList then
		for _, v in pairs(rewardList) do
			local taskId = v.id
			local taskConfig = lua_task_weekwalk_ver2.configDict[taskId]

			if taskConfig and WeekWalk_2TaskListModel.instance:checkPeriods(taskConfig) then
				local taskMo = WeekWalk_2TaskListModel.instance:getTaskMo(taskId)
				local config = lua_task_weekwalk_ver2.configDict[taskId]
				local isGet = taskMo and taskMo.finishCount >= config.maxFinishCount

				if isGet then
					-- block empty
				elseif taskMo and taskMo.hasFinished then
					table.insert(canGetList, taskId)
				end
			end
		end
	end

	return cur, total, canGetList
end

function WeekWalk_2TaskListModel:canGetReward(type)
	local list = WeekWalk_2Config.instance:getWeekWalkTaskList(type)

	for i, mo in ipairs(list) do
		local taskMo = WeekWalk_2TaskListModel.instance:getTaskMo(mo.id)

		if not taskMo then
			return false
		end

		local config = lua_task_weekwalk_ver2.configDict[mo.id]
		local isGet = taskMo.finishCount >= config.maxFinishCount
		local isFinish = taskMo.hasFinished

		if isFinish and not isGet then
			return true
		end
	end
end

function WeekWalk_2TaskListModel._sort(a, b)
	local statusA = WeekWalk_2TaskListModel.instance:_taskStatus(a)
	local statusB = WeekWalk_2TaskListModel.instance:_taskStatus(b)
	local sameA = a.listenerParam == WeekWalk_2TaskListModel._mapId
	local sameB = b.listenerParam == WeekWalk_2TaskListModel._mapId

	if sameA and not sameB and statusA ~= 3 then
		return true
	end

	if not sameA and sameB and statusB ~= 3 then
		return false
	end

	if statusA ~= statusB then
		return statusA < statusB
	end

	return a.id < b.id
end

function WeekWalk_2TaskListModel:_taskStatus(mo)
	local taskMo = WeekWalk_2TaskListModel.instance:getTaskMo(mo.id)
	local config = lua_task_weekwalk_ver2.configDict[mo.id]

	if not taskMo or not config then
		return 2
	end

	local isGet = taskMo.finishCount >= config.maxFinishCount
	local isFinish = taskMo.hasFinished

	if isGet then
		return 3
	elseif isFinish then
		return 1
	end

	return 2
end

function WeekWalk_2TaskListModel:hasFinished()
	local list = self:getList()

	for i, mo in ipairs(list) do
		local taskMo = WeekWalk_2TaskListModel.instance:getTaskMo(mo.id)

		if taskMo and taskMo.hasFinished then
			return true
		end
	end
end

function WeekWalk_2TaskListModel:updateTaskList()
	self._taskList = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.WeekWalk_2)
end

function WeekWalk_2TaskListModel:hasTaskList()
	return self._taskList
end

function WeekWalk_2TaskListModel:getTaskMo(id)
	return self._taskList and self._taskList[id]
end

WeekWalk_2TaskListModel.instance = WeekWalk_2TaskListModel.New()

return WeekWalk_2TaskListModel
