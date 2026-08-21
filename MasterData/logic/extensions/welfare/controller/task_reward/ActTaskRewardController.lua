-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/controller/task_reward/ActTaskRewardController.lua

module("logic.extensions.welfare.controller.task_reward.ActTaskRewardController", package.seeall)

local M = class("ActTaskRewardController", BaseController)

M.TaskRewardLabel = {
	TaskEnum.TaskLabel.ChapterReward,
	TaskEnum.TaskLabel.LevelReward
}

function M:onInit()
	self:_addEvent()
end

function M:onReset()
	return
end

function M:_addEvent()
	GlobalDispatcher:addEventListener(EventType.TASK_GET_TASKNOLIST, self._onGetTaskList, self)
	GlobalDispatcher:addEventListener(EventType.TASK_REFRESH_BOOL, self._onRefreshTaskList, self)
	GlobalDispatcher:addEventListener(EventType.TASK_RECEIVE_SUCCESS, self._onRecevieTaskReward, self)
	GlobalDispatcher:addEventListener(EventType.TASK_SCHEDULE_CHANGE, self._onTaskChange, self)
end

function M:isTaskReward(label)
	return table.indexof(M.TaskRewardLabel, label) and true or false
end

function M:_onGetTaskList(_, msg)
	if self:isTaskReward(msg.label) then
		ActTaskRewardModel.instance:setTaskList(msg.tasks)
		GlobalDispatcher:dispatchEvent(EventType.ACT_REWARD_TASK_REFRESH, msg.label)
	end
end

function M:_onRefreshTaskList(_, msg)
	local isRefresh = msg.refresh and self:isTaskReward(msg.label)

	if isRefresh then
		TaskAgent.instance:sendListTaskRequest(msg.label)
	end
end

function M:_onRecevieTaskReward(_, taskIdList)
	local label

	for _, taskId in ipairs(taskIdList) do
		label = ActTaskRewardModel.instance:receiveReward(taskId)
	end

	if label then
		GlobalDispatcher:dispatchEvent(EventType.ACT_REWARD_TASK_REFRESH, label)
	end
end

function M:_onTaskChange(_, msg)
	local label = ActTaskRewardModel.instance:onTaskChange(msg.task)

	if label then
		GlobalDispatcher:dispatchEvent(EventType.ACT_REWARD_TASK_REFRESH, label)
	end
end

M.instance = M.New()

return M
