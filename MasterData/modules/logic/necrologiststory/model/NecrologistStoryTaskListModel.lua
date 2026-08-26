-- chunkname: @modules/logic/necrologiststory/model/NecrologistStoryTaskListModel.lua

module("modules.logic.necrologiststory.model.NecrologistStoryTaskListModel", package.seeall)

local NecrologistStoryTaskListModel = class("NecrologistStoryTaskListModel", ListScrollModel)

function NecrologistStoryTaskListModel:refreshList(storyId)
	local tasks = self:getTaskList(storyId)
	local list = {}
	local finishCount = 0

	for i, v in ipairs(tasks) do
		list[i] = v

		if v.hasFinished then
			finishCount = finishCount + 1
		end
	end

	if finishCount > 1 then
		table.insert(list, 1, {
			isTotalGet = true,
			storyId = storyId
		})
	end

	self:setList(list)
end

function NecrologistStoryTaskListModel:getTaskList(storyId)
	local config = RoleStoryConfig.instance:getStoryById(storyId)
	local activityId = config.activityId

	if not ActivityModel.instance:isActOnLine(activityId) then
		activityId = nil
	end

	local list = {}
	local unlockTasks = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.NecrologistStory)

	for _, v in pairs(unlockTasks) do
		if v.config and v.config.storyId == storyId and (v.config.activityId == activityId or v.config.activityId == 0) then
			table.insert(list, v)
		end
	end

	table.sort(list, function(a, b)
		local aValue = a:isClaimed() and 3 or a.hasFinished and 1 or 2
		local bValue = b:isClaimed() and 3 or b.hasFinished and 1 or 2

		if aValue ~= bValue then
			return aValue < bValue
		else
			return a.config.id < b.config.id
		end
	end)

	return list
end

function NecrologistStoryTaskListModel:sendFinishAllTaskRequest(storyId)
	local list = {}
	local unlockTasks = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.NecrologistStory)

	for _, v in pairs(unlockTasks) do
		if v.config and v.config.storyId == storyId and v:isClaimable() then
			table.insert(list, v.id)
		end
	end

	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.NecrologistStory, nil, list)
end

function NecrologistStoryTaskListModel:hasLimitTaskNotFinish(storyId)
	local tasks = self:getTaskList(storyId)

	for _, v in ipairs(tasks) do
		if not v:isClaimed() and v.config.activityId ~= 0 then
			return true
		end
	end

	return false
end

NecrologistStoryTaskListModel.instance = NecrologistStoryTaskListModel.New()

return NecrologistStoryTaskListModel
