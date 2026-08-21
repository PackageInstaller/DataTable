-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/MasterTrainingTask/model/MasterTrainingTaskModel.lua

module("logic.extensions.MasterTrainingTask.model.MasterTrainingTaskModel", package.seeall)

local M = class("MasterTrainingTaskModel", BaseModel)
local TaskState = {
	Doing = 2,
	CanReceive = 3,
	IsReceived = 1
}

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._taskMoLst = {}
end

function M:isTaskViable()
	return TableUtil.getLen(self._taskMoLst) > 0
end

function M:getTaskMo(id)
	return self._taskMoLst[id]
end

function M:updateTaskLst(taskLst)
	if taskLst and #taskLst > 0 then
		for _, taskNo in ipairs(taskLst) do
			self:updateTask(taskNo)
		end
	end

	GlobalDispatcher:dispatchEvent(EventType.MASTER_TRAINING_TASK)
	self:updateRedDotActive()
end

function M:updateRedDotActive()
	local today = ServerTime.formatNow("%x")
	local record = Astral.LocalStorage.Instance:GetString("training_task_data")

	if self:getAllFinished() then
		GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
			isActive = false,
			key = RedDotType.ERedDotKey.MASTERTRAINING_TASK
		})
	elseif today ~= record or self:getCanReceive() then
		GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
			isActive = true,
			key = RedDotType.ERedDotKey.MASTERTRAINING_TASK
		})
	else
		GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
			isActive = false,
			key = RedDotType.ERedDotKey.MASTERTRAINING_TASK
		})
	end
end

function M:updateTask(taskNo)
	local taskId = taskNo.id

	if not self._taskMoLst[taskId] then
		self._taskMoLst[taskId] = MasterTrainingTaskMo.New()
	end

	local theMo = self:getTaskMo(taskId)

	theMo:updateFromServer(taskNo)
end

function M:getStatus(id)
	local taskMo = self:getTaskMo(id)

	if taskMo:getIsFinish() then
		return MasterTrainingTaskConfig.TaskState.IsReceived
	elseif taskMo:canGetReward() then
		return MasterTrainingTaskConfig.TaskState.CanReceive
	else
		return MasterTrainingTaskConfig.TaskState.Doing
	end
end

function M:getAllFinished()
	local count = 0

	for taskId, _ in pairs(self._taskMoLst) do
		if self:getTaskMo(taskId):getIsFinish() then
			count = count + 1
		end
	end

	return count == TableUtil.getLen(self._taskMoLst)
end

function M:getCanReceive()
	for taskId, _ in pairs(self._taskMoLst) do
		local taskMo = self:getTaskMo(taskId)

		if not taskMo:getIsFinish() and taskMo:canGetReward() then
			return true
		end
	end

	return false
end

M.instance = M.New()

return M
