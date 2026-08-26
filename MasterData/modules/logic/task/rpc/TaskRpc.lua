-- chunkname: @modules/logic/task/rpc/TaskRpc.lua

module("modules.logic.task.rpc.TaskRpc", package.seeall)

local TaskRpc = class("TaskRpc", BaseRpc)

function TaskRpc:onInit()
	self._sendTypeDict = nil
end

function TaskRpc:reInit()
	self._sendTypeDict = nil

	TaskDispatcher.cancelTask(self._delaySendGetTask, self)
end

function TaskRpc:sendGetTaskInfoRequest(typeIds, callback, callbackObj)
	if not callback then
		if not self._sendTypeDict then
			self._sendTypeDict = {}

			TaskDispatcher.runDelay(self._delaySendGetTask, self, 0.5)
		end

		for _, v in pairs(typeIds) do
			self._sendTypeDict[v] = true
		end

		return
	end

	logNormal("send Get TaskInfo Request" .. typeIds[1])

	local req = TaskModule_pb.GetTaskInfoRequest()

	for _, v in pairs(typeIds) do
		table.insert(req.typeIds, v)
	end

	return self:sendMsg(req, callback, callbackObj)
end

function TaskRpc:_delaySendGetTask()
	if self._sendTypeDict then
		local req = TaskModule_pb.GetTaskInfoRequest()

		for v in pairs(self._sendTypeDict) do
			table.insert(req.typeIds, v)
		end

		self:sendMsg(req)

		self._sendTypeDict = nil
	end
end

function TaskRpc:onReceiveGetTaskInfoReply(resultCode, msg)
	logNormal("Receive Get TaskInfo Reply" .. resultCode)

	if resultCode == 0 then
		TaskModel.instance:setTaskMOList(msg.taskInfo, msg.typeIds)
		TaskModel.instance:setTaskActivityMOList(msg.activityInfo)
		TaskController.instance:dispatchEvent(TaskEvent.SetTaskList, msg.typeIds)
	end
end

function TaskRpc:sendFinishTaskRequest(id, callback, callbackObj)
	logNormal("send Finish Task Request" .. id)

	local req = TaskModule_pb.FinishTaskRequest()

	req.id = id

	self:sendMsg(req, callback, callbackObj)
end

function TaskRpc:onReceiveFinishTaskReply(resultCode, msg)
	logNormal("Receive Finish Task Reply" .. resultCode)

	if resultCode == 0 then
		TaskController.instance:dispatchEvent(TaskEvent.OnFinishTask, msg.id)
	end
end

function TaskRpc:sendGetTaskActivityBonusRequest(typeId, defineId)
	logNormal("send Get TaskActivityBonus Request" .. defineId)

	local req = TaskModule_pb.GetTaskActivityBonusRequest()

	req.typeId = typeId
	req.defineId = defineId

	self:sendMsg(req)
end

function TaskRpc:onReceiveGetTaskActivityBonusReply(resultCode, msg)
	logNormal("Receive Get TaskActivityBonus Reply" .. resultCode)

	if resultCode == 0 then
		TaskController.instance:dispatchEvent(TaskEvent.SuccessGetBonus)
	end
end

function TaskRpc:onReceiveUpdateTaskPush(resultCode, msg)
	logNormal("Receive Update Task Push" .. resultCode)

	if resultCode == 0 then
		TaskModel.instance:onTaskMOChange(msg.taskInfo)
		TaskModel.instance:onTaskActivityMOChange(msg.activityInfo)
		TaskController.instance:dispatchEvent(TaskEvent.UpdateTaskList, msg)
	end
end

function TaskRpc:onReceiveDeleteTaskPush(resultCode, msg)
	logNormal("Receive Delete Task Push" .. resultCode)

	if resultCode == 0 then
		TaskModel.instance:deleteTask(msg.taskIds)
		TaskController.instance:dispatchEvent(TaskEvent.OnDeleteTask, msg)
	end
end

function TaskRpc:sendFinishAllTaskRequest(typeId, minTypeId, taskIds, callback, callbackObj, activityId)
	local req = TaskModule_pb.FinishAllTaskRequest()

	req.typeId = typeId

	if minTypeId then
		req.minTypeId = minTypeId
	end

	if activityId then
		req.activityId = activityId
	end

	if taskIds then
		for _, taskId in ipairs(taskIds) do
			table.insert(req.taskIds, taskId)
		end
	end

	self:sendMsg(req, callback, callbackObj)
end

function TaskRpc:onReceiveFinishAllTaskReply(resultCode, msg)
	if resultCode == 0 then
		logNormal("一键领取任务奖励成功")
		TaskController.instance:dispatchEvent(TaskEvent.SuccessGetBonus)
	end
end

function TaskRpc:sendFinishReadTaskRequest(taskId, cb, cbObj)
	local req = TaskModule_pb.FinishReadTaskRequest()

	req.taskId = taskId

	return self:sendMsg(req, cb, cbObj)
end

function TaskRpc:onReceiveFinishReadTaskReply(resultCode, msg)
	if resultCode == 0 then
		TaskController.instance:dispatchEvent(TaskEvent.onReceiveFinishReadTaskReply, msg.taskId)
		SportsNewsController.instance:dispatchEvent(SportsNewsEvent.OnReadEnd, msg.taskId)
	end
end

TaskRpc.instance = TaskRpc.New()

return TaskRpc
