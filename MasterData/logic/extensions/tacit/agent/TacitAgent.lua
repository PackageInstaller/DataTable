-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tacit/agent/TacitAgent.lua

module("logic.extensions.tacit.agent.TacitAgent", package.seeall)

local M = class("TacitAgent", BaseAgent)

function M:ctor()
	M.super.ctor(self)
end

function M:sendGetTaskInfoRequest(heroId, isUpgrade)
	local req = TacitExtension_pb.GetTaskInfoRequest()

	req.hero = heroId

	self:invoke({
		funcName = "handleGetTaskInfoReply",
		sendData = req,
		handleCall = function(status, msg)
			if status == 0 then
				TacitModel.instance:initTacitTaskData(heroId, msg, msg.primary)

				local rewardingTaskId = TacitModel.instance:getRewardingTask()
				local markPrimaryTask

				GlobalDispatcher:dispatchEvent(EventType.TACIT_REFRESH_TASK_VIEW, rewardingTaskId, markPrimaryTask, isUpgrade)
			end

			TacitModel.instance:setRewardingTask(nil)
		end
	})
end

function M:sendTakeTaskRewardRequest(taskId, heroId)
	TacitModel.instance:setRewardingTask(taskId)

	local req = TacitExtension_pb.TakeTaskRewardRequest()

	req.taskId = taskId

	self:invoke({
		funcName = "handleTakeTaskRewardReply",
		sendData = req,
		handleCall = function(status, msg)
			if status == 0 then
				self:sendGetTaskInfoRequest(heroId)
			end
		end
	})
end

function M:sendMarkPrimaryTaskRequest(taskId)
	local req = TacitExtension_pb.MarkPrimaryTaskRequest()

	req.taskId = taskId

	self:invoke({
		funcName = "handleMarkPrimaryTaskReply",
		sendData = req,
		handleCall = function(status, msg)
			if status == 0 then
				TacitModel.instance:updateTargetTask(taskId)
				GlobalDispatcher:dispatchEvent(EventType.TACIT_REFRESH_TASK_VIEW, false, taskId, false)
			end
		end
	})
end

function M:sendGetPrimaryTaskInfoRequest(heroIds)
	local req = TacitExtension_pb.GetPrimaryTaskInfoRequest()

	self:invoke({
		funcName = "handleGetPrimaryTaskInfoReply",
		sendData = req,
		handleCall = function(status, msg)
			if status == 0 then
				TacitModel.instance:initTargetTaskData(msg.tasks, heroIds)
			end
		end
	})
end

function M:handleNotifyTaskProgressPush(status, msg)
	if status == 0 then
		TacitModel.instance:updateStageTips(msg.taskId, msg.progress)
	end
end

function M:sendWakeupRequest(heroId)
	local req = TacitExtension_pb.WakeupRequest()

	req.heroId = heroId

	self:sendMsg(req)
end

function M:handleWakeupReply(status, msg)
	local success = status == 0

	GlobalDispatcher:dispatchEvent(EventType.TACIT_ANCHOR_WAKE_UP_SUC, success)
end

M.instance = M.New()

return M
