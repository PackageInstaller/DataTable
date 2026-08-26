-- chunkname: @modules/logic/weekwalk/model/WeekWalkTaskListModel.lua

module("modules.logic.weekwalk.model.WeekWalkTaskListModel", package.seeall)

local WeekWalkTaskListModel = class("WeekWalkTaskListModel", ListScrollModel)

function WeekWalkTaskListModel:setTaskRewardList(value)
	self._rewardList = value
end

function WeekWalkTaskListModel:getTaskRewardList()
	return self._rewardList
end

function WeekWalkTaskListModel:getLayerTaskMapId()
	return self._layerTaskMapId
end

function WeekWalkTaskListModel:getSortIndex(mo)
	return self._sortMap[mo] or 0
end

function WeekWalkTaskListModel:_canGet(id)
	local taskMo = WeekWalkTaskListModel.instance:getTaskMo(id)

	if taskMo then
		local config = lua_task_weekwalk.configDict[id]
		local isGet = taskMo.finishCount >= config.maxFinishCount
		local isFinish = taskMo.hasFinished

		if isFinish and not isGet then
			return true
		end
	end
end

function WeekWalkTaskListModel:getCanGetList()
	local list = {}

	for i, v in ipairs(self:getList()) do
		if v.id and self:_canGet(v.id) then
			table.insert(list, v.id)
		end
	end

	return list
end

function WeekWalkTaskListModel:checkPeriods(mo)
	if string.nilorempty(mo.periods) then
		return true
	end

	local list = string.splitToNumber(mo.periods, "#")

	if not list[1] then
		if not list[2] then
			local maxId = 0
			local info = WeekWalkModel.instance:getInfo()

			return info and list[1] <= info.issueId and maxId >= info.issueId
		end
	end
end

function WeekWalkTaskListModel:showLayerTaskList(type, mapId)
	self._layerTaskMapId = mapId

	local result = {}

	self._sortMap = {}

	local index = 1
	local num = 0
	local mapConfig = lua_weekwalk.configDict[mapId]
	local layerStr = tostring(mapConfig.layer)
	local list = TaskConfig.instance:getWeekWalkTaskList(type)

	for i, mo in ipairs(list) do
		local check = mo.listenerParam == layerStr or mo.listenerType == "WeekwalkBattle" and string.find(mo.listenerParam, layerStr)

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

function WeekWalkTaskListModel:showTaskList(type, mapId)
	WeekWalkTaskListModel._mapId = tostring(mapId)

	local list = TaskConfig.instance:getWeekWalkTaskList(type)

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

function WeekWalkTaskListModel:canGetRewardNum(type, mapId)
	local list = TaskConfig.instance:getWeekWalkTaskList(type)
	local num = 0
	local unFinishNum = 0
	local layerIdStr

	if mapId then
		local mapConfig = lua_weekwalk.configDict[mapId]

		layerIdStr = tostring(mapConfig.layer)
	end

	for i, mo in ipairs(list) do
		local taskMo = WeekWalkTaskListModel.instance:getTaskMo(mo.id)

		if taskMo then
			local config = lua_task_weekwalk.configDict[mo.id]
			local isGet = taskMo.finishCount >= config.maxFinishCount
			local isFinish = taskMo.hasFinished
			local check = not layerIdStr or mo.listenerParam == layerIdStr or mo.listenerType == "WeekwalkBattle" and string.find(mo.listenerParam, layerIdStr)

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

function WeekWalkTaskListModel:getAllDeepTaskInfo()
	local cur = 0
	local total = 0
	local canGetList = {}
	local firstLayer, firstFinishLayer
	local isVerifing = VersionValidator.instance:isInReviewing()
	local info = WeekWalkModel.instance:getInfo()
	local deepLayerList = WeekWalkConfig.instance:getDeepLayer(info.issueId)
	local maxLayer = ResSplitConfig.instance:getMaxWeekWalkLayer()

	if not deepLayerList then
		return cur, total, canGetList, firstFinishLayer or firstLayer
	end

	for i, v in ipairs(deepLayerList) do
		if not isVerifing or maxLayer >= v.layer then
			local rewardList = TaskConfig.instance:getWeekWalkRewardList(v.layer)

			if rewardList then
				firstLayer = firstLayer or v.id

				for taskId, num in pairs(rewardList) do
					local taskConfig = lua_task_weekwalk.configDict[taskId]

					if taskConfig and WeekWalkTaskListModel.instance:checkPeriods(taskConfig) then
						total = total + num

						local taskMo = WeekWalkTaskListModel.instance:getTaskMo(taskId)
						local config = lua_task_weekwalk.configDict[taskId]
						local isGet = taskMo and taskMo.finishCount >= config.maxFinishCount

						if isGet then
							cur = cur + num
						elseif taskMo and taskMo.hasFinished then
							table.insert(canGetList, taskId)

							firstFinishLayer = firstFinishLayer or v.id
						end
					end
				end
			end
		end
	end

	return cur, total, canGetList, firstFinishLayer or firstLayer
end

function WeekWalkTaskListModel:canGetReward(type)
	local list = TaskConfig.instance:getWeekWalkTaskList(type)

	for i, mo in ipairs(list) do
		local taskMo = WeekWalkTaskListModel.instance:getTaskMo(mo.id)

		if not taskMo then
			return false
		end

		local config = lua_task_weekwalk.configDict[mo.id]
		local isGet = taskMo.finishCount >= config.maxFinishCount
		local isFinish = taskMo.hasFinished

		if isFinish and not isGet then
			return true
		end
	end
end

function WeekWalkTaskListModel._sort(a, b)
	local statusA = WeekWalkTaskListModel.instance:_taskStatus(a)
	local statusB = WeekWalkTaskListModel.instance:_taskStatus(b)
	local sameA = a.listenerParam == WeekWalkTaskListModel._mapId
	local sameB = b.listenerParam == WeekWalkTaskListModel._mapId

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

function WeekWalkTaskListModel:_taskStatus(mo)
	local taskMo = WeekWalkTaskListModel.instance:getTaskMo(mo.id)
	local config = lua_task_weekwalk.configDict[mo.id]

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

function WeekWalkTaskListModel:hasFinished()
	local list = self:getList()

	for i, mo in ipairs(list) do
		local taskMo = WeekWalkTaskListModel.instance:getTaskMo(mo.id)

		if taskMo and taskMo.hasFinished then
			return true
		end
	end
end

function WeekWalkTaskListModel:updateTaskList()
	self._taskList = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.WeekWalk)
end

function WeekWalkTaskListModel:hasTaskList()
	return self._taskList
end

function WeekWalkTaskListModel:getTaskMo(id)
	return self._taskList and self._taskList[id]
end

WeekWalkTaskListModel.instance = WeekWalkTaskListModel.New()

return WeekWalkTaskListModel
