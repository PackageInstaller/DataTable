-- chunkname: @modules/logic/versionactivity/rpc/Activity112Rpc.lua

module("modules.logic.versionactivity.rpc.Activity112Rpc", package.seeall)

local Activity112Rpc = class("Activity112Rpc", BaseRpc)

function Activity112Rpc:sendGet112InfosRequest(activityId, callback, callbackObj)
	local req = Activity112Module_pb.Get112InfosRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity112Rpc:onReceiveGet112InfosReply(resultCode, msg)
	if resultCode == 0 then
		VersionActivity112Model.instance:updateInfo(msg)
	end
end

function Activity112Rpc:sendExchange112Request(activityId, id, callback, callbackObj)
	local req = Activity112Module_pb.Exchange112Request()

	req.activityId = activityId
	req.id = id

	return self:sendMsg(req, callback, callbackObj)
end

function Activity112Rpc:onReceiveExchange112Reply(resultCode, msg)
	if resultCode == 0 then
		VersionActivity112Model.instance:updateRewardState(msg.activityId, msg.id)
	end
end

function Activity112Rpc:onReceiveAct112TaskPush(resultCode, msg)
	if resultCode == 0 then
		VersionActivity112TaskListModel.instance:updateTaskInfo(msg.activityId, msg.act112Tasks)
	end
end

function Activity112Rpc:sendReceiveAct112TaskRewardRequest(activityId, taskId, callback, callbackObj)
	local req = Activity112Module_pb.ReceiveAct112TaskRewardRequest()

	req.activityId = activityId
	req.taskId = taskId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity112Rpc:onReceiveReceiveAct112TaskRewardReply(resultCode, msg)
	if resultCode == 0 then
		VersionActivity112TaskListModel.instance:setGetBonus(msg.activityId, msg.taskId)
	end
end

Activity112Rpc.instance = Activity112Rpc.New()

return Activity112Rpc
