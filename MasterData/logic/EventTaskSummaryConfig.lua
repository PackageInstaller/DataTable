-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/config/EventTaskSummaryConfig.lua

module("logic.extensions.eventtasksummary.config.EventTaskSummaryConfig", package.seeall)

local EventTaskSummaryConfig = class("EventTaskSummaryConfig", BaseConfig)

function EventTaskSummaryConfig:onInit()
	EventTaskSummaryConfig.super.onInit(self)
end

function EventTaskSummaryConfig:getNames()
	return {
		"event_task_summary_activity",
		"event_task_summary_task_plan",
		"event_task_summary_task_page"
	}
end

function EventTaskSummaryConfig:handleConfig(name, content)
	if name == "event_task_summary_activity" then
		self._planCfg = content
	elseif name == "event_task_summary_task_plan" then
		self._taskCfg = content

		self:handleTaskCfgs(content)
	elseif name == "event_task_summary_task_page" then
		self._taskPageCfgs = content
	end
end

function EventTaskSummaryConfig:getPlanCfg(actid)
	return self._planCfg[actid]
end

function EventTaskSummaryConfig:getActivityType(actid)
	local planCfg = self:getPlanCfg(actid)

	return (planCfg or nil) and (planCfg.activityType or 0)
end

function EventTaskSummaryConfig:getTaskCfgs(actid)
	local planid = self:getPlanCfg(actid).taskPlanId

	return self._taskCfg[planid]
end

function EventTaskSummaryConfig:getTaskData(actid, taskId)
	local taskCfg = self:getTaskCfgs(actid)

	return taskCfg[taskId]
end

function EventTaskSummaryConfig:getTaskDataById(taskPlanId, taskId)
	local taskCfg = self._taskCfg[taskPlanId]

	return taskCfg[taskId]
end

function EventTaskSummaryConfig:handleTaskCfgs(content)
	self._taskQueues = {}

	for taskPlanId, taskCfg in pairs(content) do
		if type(taskPlanId) == "number" then
			local queue = {}

			for _, data in ipairs(taskCfg) do
				local pageId = data.pageId

				queue[pageId] = queue[pageId] or {}

				table.insert(queue[pageId], data)
			end

			for _, list in ipairs(queue) do
				ArraySort.sortOn(list, "taskId")
			end

			self._taskQueues[taskPlanId] = queue
		end
	end
end

function EventTaskSummaryConfig:getTaskQueue(actid)
	local planid = self:getPlanCfg(actid).taskPlanId

	return self._taskQueues[planid]
end

function EventTaskSummaryConfig:getTaskQueueById(taskPlanId)
	return self._taskQueues[taskPlanId]
end

function EventTaskSummaryConfig:isTaskVisibleByPlayerTypeTag(taskData, playerTypeTag)
	if not taskData then
		return false
	end

	if string.nilorempty(taskData.playerTypeTag) then
		return true
	end

	return taskData.playerTypeTag == playerTypeTag
end

function EventTaskSummaryConfig:getVisibleTaskCfgs(actid, playerTypeTag)
	local taskCfgs = self:getTaskCfgs(actid)
	local visibleTaskCfgs = {}

	for _, taskData in ipairs(taskCfgs) do
		if self:isTaskVisibleByPlayerTypeTag(taskData, playerTypeTag) then
			table.insert(visibleTaskCfgs, taskData)
		end
	end

	return visibleTaskCfgs
end

function EventTaskSummaryConfig:getVisibleTaskQueue(actid, playerTypeTag)
	local visibleTaskCfgs = self:getVisibleTaskCfgs(actid, playerTypeTag)
	local queue = {}

	for _, data in ipairs(visibleTaskCfgs) do
		local pageId = data.pageId

		queue[pageId] = queue[pageId] or {}

		table.insert(queue[pageId], data)
	end

	for _, list in pairs(queue) do
		ArraySort.sortOn(list, "taskId")
	end

	return queue
end

function EventTaskSummaryConfig:getTaskIdx(taskPlanId, taskId)
	local taskData = self:getTaskDataById(taskPlanId, taskId)
	local taskList = self:getTaskQueueById(taskPlanId)[taskData.pageId]

	for idx, data in ipairs(taskList) do
		if taskId == data.taskId then
			return idx
		end
	end

	return 0
end

function EventTaskSummaryConfig:getTotalTaskIdx(taskPlanId, pageId)
	return #self:getTaskQueueById(taskPlanId)[pageId]
end

function EventTaskSummaryConfig:getTaskPageCfg(actid)
	local planid = self:getPlanCfg(actid).taskPlanId

	return self._taskPageCfgs[planid]
end

function EventTaskSummaryConfig:getTaskPageData(actid, pageId)
	local cfg = self:getTaskPageCfg(actid) or {}

	return cfg[pageId]
end

EventTaskSummaryConfig.instance = EventTaskSummaryConfig.New()

return EventTaskSummaryConfig
