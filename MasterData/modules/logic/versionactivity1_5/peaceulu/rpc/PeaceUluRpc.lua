-- chunkname: @modules/logic/versionactivity1_5/peaceulu/rpc/PeaceUluRpc.lua

module("modules.logic.versionactivity1_5.peaceulu.rpc.PeaceUluRpc", package.seeall)

local PeaceUluRpc = class("PeaceUluRpc", BaseRpc)

function PeaceUluRpc:sendGet145InfosRequest(actId, callback, callbackObj)
	local req = Activity145Module_pb.Get145InfosRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function PeaceUluRpc:onReceiveGet145InfosReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PeaceUluModel.instance:setActivityInfo(msg.act145Info)
	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.OnUpdateInfo)
end

function PeaceUluRpc:onReceiveAct145InfoUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PeaceUluModel.instance:setActivityInfo(msg.act145Info)
	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.OnUpdateInfo)
end

function PeaceUluRpc:sendAct145RemoveTaskRequest(actId, taskId)
	local req = Activity145Module_pb.Act145RemoveTaskRequest()

	req.activityId = actId
	req.taskId = taskId

	self:sendMsg(req)
end

function PeaceUluRpc:onReceiveAct145RemoveTaskReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PeaceUluModel.instance:onGetRemoveTask(msg)
end

function PeaceUluRpc:sendAct145GameRequest(actId, content)
	local req = Activity145Module_pb.Act145GameRequest()

	req.activityId = actId
	req.content = content

	self:sendMsg(req)
end

function PeaceUluRpc:onReceiveAct145GameReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PeaceUluModel.instance:onGetGameResult(msg)
end

function PeaceUluRpc:sendAct145GetRewardsRequest(actId)
	local req = Activity145Module_pb.Act145GetRewardsRequest()

	req.activityId = actId

	self:sendMsg(req)
end

function PeaceUluRpc:onReceiveAct145GetRewardsReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PeaceUluModel.instance:onUpdateReward(msg)
	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.OnUpdateInfo)
end

function PeaceUluRpc:sendAct145ClearGameRecordRequest(actId)
	local req = Activity145Module_pb.Act145ClearGameRecordRequest()

	req.activityId = actId

	self:sendMsg(req)
end

function PeaceUluRpc:onReceiveAct145ClearGameRecordReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PeaceUluModel.instance:setActivityInfo(msg.act145Info)
	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.OnUpdateInfo)
end

PeaceUluRpc.instance = PeaceUluRpc.New()

return PeaceUluRpc
