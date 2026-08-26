-- chunkname: @modules/logic/pushbox/model/PushBoxModel.lua

module("modules.logic.pushbox.model.PushBoxModel", package.seeall)

local PushBoxModel = class("PushBoxModel", BaseModel)

function PushBoxModel:onInit()
	return
end

function PushBoxModel:reInit()
	return
end

function PushBoxModel:getCurActivityID()
	return self._activity_id
end

function PushBoxModel:onReceiveGet111InfosReply(proto)
	self._activity_id = proto.activityId
	self._pass_data = {}

	for i, v in ipairs(proto.infos) do
		local data = {}

		data.id = v.id
		data.state = v.state
		data.unlock = v.unlock
		self._pass_data[v.id] = data
	end

	self._stage_ids = {}

	for i, v in ipairs(proto.stageIds) do
		self._stage_ids[v] = true
	end

	self:refreshTaskData(proto.pushBoxTasks)
	PushBoxController.instance:dispatchEvent(PushBoxEvent.DataEvent.RefreshActivityData)
end

function PushBoxModel:onReceiveAct111InfoPush(proto)
	self._activity_id = proto.activityId

	for i, v in ipairs(proto.act111Info) do
		local data = {}

		data.id = v.id
		data.state = v.state
		data.unlock = v.unlock
		self._pass_data[v.id] = data
	end
end

function PushBoxModel:getPassData(id)
	return self._pass_data and self._pass_data[id]
end

function PushBoxModel:getStageOpened(id)
	return self._stage_ids[PushBoxEpisodeConfig.instance:getStageIDByEpisodeID(id)]
end

function PushBoxModel:getEpisodeOpenTime(id)
	local stage_config = PushBoxEpisodeConfig.instance:getStageConfig(PushBoxEpisodeConfig.instance:getStageIDByEpisodeID(id))

	return ActivityModel.instance:getActivityInfo()[PushBoxModel.instance:getCurActivityID()]:getRealStartTimeStamp() + (stage_config.openDay - 1) * 24 * 60 * 60
end

function PushBoxModel:refreshTaskData(proto)
	self._task_data = {}

	self:setTaskData(proto)
end

function PushBoxModel:setTaskData(proto)
	for i, v in ipairs(proto) do
		local data = {}

		data.taskId = v.taskId
		data.progress = v.progress
		data.hasGetBonus = v.hasGetBonus
		self._task_data[v.taskId] = data
	end
end

function PushBoxModel:delTaskData(proto)
	for i, v in ipairs(proto) do
		self._task_data[v.taskId] = nil
	end
end

function PushBoxModel:getTaskData(task_id)
	return self._task_data and self._task_data[task_id]
end

function PushBoxModel:onReceiveFinishEpisodeReply(resultCode, proto)
	PushBoxController.instance:dispatchEvent(PushBoxEvent.DataEvent.FinishEpisodeReply, resultCode, proto.episodeId)
end

function PushBoxModel:onReceivePushBoxTaskPush(proto)
	self:setTaskData(proto.pushBoxTasks)
	self:delTaskData(proto.deleteTasks)
end

function PushBoxModel:onReceiveReceiveTaskRewardReply(proto)
	PushBoxController.instance:dispatchEvent(PushBoxEvent.DataEvent.ReceiveTaskRewardReply, proto.taskId)
end

PushBoxModel.instance = PushBoxModel.New()

return PushBoxModel
