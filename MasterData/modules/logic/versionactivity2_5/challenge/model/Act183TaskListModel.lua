-- chunkname: @modules/logic/versionactivity2_5/challenge/model/Act183TaskListModel.lua

module("modules.logic.versionactivity2_5.challenge.model.Act183TaskListModel", package.seeall)

local Act183TaskListModel = class("Act183TaskListModel", MixScrollModel)

function Act183TaskListModel:init(activityId, taskType)
	self._activityId = activityId
	self._taskType = taskType

	self:_buildTaskMap()
	self:refresh()
end

function Act183TaskListModel:_buildTaskMap()
	self._taskTypeMap = {}

	local allTasks = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity183, self._activityId)

	if allTasks then
		for _, taskMo in ipairs(allTasks) do
			local taskCo = taskMo.config
			local taskType = taskCo and taskCo.type

			self._taskTypeMap[taskType] = self._taskTypeMap[taskType] or {}

			table.insert(self._taskTypeMap[taskType], taskMo)
		end
	end

	for _, taskMoList in pairs(self._taskTypeMap) do
		table.sort(taskMoList, self._taskMoListSortFunc)
	end
end

function Act183TaskListModel:getTaskMosByType(taskType)
	return self._taskTypeMap and self._taskTypeMap[taskType]
end

function Act183TaskListModel._taskMoListSortFunc(aTaskMo, bTaskMo)
	local aTaskCo = aTaskMo.config
	local bTaskCo = bTaskMo.config
	local aGroupId = aTaskCo.groupId
	local bGroupId = bTaskCo.groupId

	if aGroupId ~= bGroupId then
		return aGroupId < bGroupId
	end

	return aTaskMo.id < bTaskMo.id
end

function Act183TaskListModel:refresh()
	if self._taskTypeMap then
		local taskMoList = self._taskTypeMap[self._taskType]

		taskMoList = taskMoList or {}

		local taskItemList = self:_createTaskItemMoList(taskMoList)

		self:setList(taskItemList)
	end
end

function Act183TaskListModel:getInfoList(scrollGO)
	self._mixCellInfo = {}

	local list = self:getList()

	for i, mo in ipairs(list) do
		local itemType = mo.type
		local height = Act183Enum.TaskItemHeightMap[itemType]

		if height then
			local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(itemType, height, i)

			table.insert(self._mixCellInfo, mixCellInfo)
		else
			logError(string.format("任务条缺少高度配置(Act183Enum.TaskItemHeightMap) dataType = %s", itemType))
		end
	end

	return self._mixCellInfo
end

function Act183TaskListModel:_createTaskItemMoList(taskMoList)
	local preGroupId
	local taskItemList = {}
	local groupItemList = {}
	local canGetRewardTaskList = {}

	for _, taskMo in ipairs(taskMoList) do
		local taskCo = taskMo.config
		local groupId = taskCo.groupId
		local taskId = taskMo.id

		if preGroupId ~= groupId then
			self:_addGroupItemToList(groupItemList, taskItemList)
			table.insert(taskItemList, self:_createItemMo(Act183Enum.TaskListItemType.Head, taskMo))
		end

		if taskMo then
			table.insert(groupItemList, self:_createItemMo(Act183Enum.TaskListItemType.Task, taskMo))

			local canGetReward = Act183Helper.isTaskCanGetReward(taskId)

			if canGetReward then
				table.insert(canGetRewardTaskList, taskMo)
			end

			preGroupId = groupId
		else
			logError(string.format("缺少任务数据 taskId = %s", taskId))
		end
	end

	self:_addGroupItemToList(groupItemList, taskItemList)
	self:_addOneKeyItemToList(canGetRewardTaskList, taskItemList)

	return taskItemList
end

function Act183TaskListModel:_addOneKeyItemToList(canGetRewardTaskList, taskItemList)
	if not canGetRewardTaskList or #canGetRewardTaskList <= 1 then
		self._oneKeyTaskItem = nil

		return
	end

	self._oneKeyTaskItem = self:_createItemMo(Act183Enum.TaskListItemType.OneKey, canGetRewardTaskList)
end

function Act183TaskListModel:getOneKeyTaskItem()
	return self._oneKeyTaskItem
end

function Act183TaskListModel:_addGroupItemToList(groupItemList, taskItemList)
	if groupItemList and #groupItemList > 0 then
		table.sort(groupItemList, self._taskItemListSortFunc)
		tabletool.addValues(taskItemList, groupItemList)

		groupItemList = {}
	end
end

function Act183TaskListModel:_createItemMo(moType, data)
	return {
		type = moType,
		data = data
	}
end

function Act183TaskListModel._taskItemListSortFunc(aTaskItem, bTaskItem)
	local aTaskCo = aTaskItem.data.config
	local bTaskCo = bTaskItem.data.config
	local aGroupId = aTaskCo.groupId
	local bGroupId = bTaskCo.groupId

	if aGroupId ~= bGroupId then
		return aGroupId < bGroupId
	end

	local aTaskId = aTaskItem.data.id
	local bTaskId = bTaskItem.data.id
	local aTaskCanGet = Act183Helper.isTaskCanGetReward(aTaskId)
	local aTaskHasGet = Act183Helper.isTaskHasGetReward(aTaskId)
	local bTaskCanGet = Act183Helper.isTaskCanGetReward(bTaskId)
	local bTaskHasGet = Act183Helper.isTaskHasGetReward(bTaskId)

	if aTaskCanGet ~= bTaskCanGet then
		return aTaskCanGet
	end

	if aTaskHasGet ~= bTaskHasGet then
		return not aTaskHasGet
	end

	return aTaskId < bTaskId
end

Act183TaskListModel.instance = Act183TaskListModel.New()

return Act183TaskListModel
