-- chunkname: @modules/logic/versionactivity3_2/cruise/rpc/Activity216Rpc.lua

module("modules.logic.versionactivity3_2.cruise.rpc.Activity216Rpc", package.seeall)

local Activity216Rpc = class("Activity216Rpc", BaseRpc)

Activity216Rpc.instance = Activity216Rpc.New()

function Activity216Rpc:sendGetAct216InfoRequest(activityId, callback, callbackObj)
	local req = Activity216Module_pb.GetAct216InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity216Rpc:onReceiveGetAct216InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity216Model.instance:setAct216Info(msg)
	Activity216Controller.instance:dispatchEvent(Activity216Event.onGetInfo)
end

function Activity216Rpc:onReceiveAct216InfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity216Model.instance:setAct216Info(msg)
	Activity216Controller.instance:dispatchEvent(Activity216Event.onInfoChanged)
end

function Activity216Rpc:sendFinishAct216TaskRequest(activityId, taskId, callback, callbackObj)
	local req = Activity216Module_pb.FinishAct216TaskRequest()

	req.activityId = activityId
	req.taskId = taskId

	self:sendMsg(req, callback, callbackObj)
end

function Activity216Rpc:onReceiveFinishAct216TaskReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity216Controller.instance:dispatchEvent(Activity216Event.onFinishTask)
end

function Activity216Rpc:onReceiveAct216TaskPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity216Model.instance:updateTaskList(msg.act216Tasks, msg.activityId)
	Activity216Controller.instance:dispatchEvent(Activity216Event.onTaskInfoUpdate)
end

function Activity216Rpc:sendGetAct216OnceBonusRequest(activityId, callback, callbackObj)
	local req = Activity216Module_pb.GetAct216OnceBonusRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity216Rpc:onReceiveGetAct216OnceBonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity216Controller.instance:dispatchEvent(Activity216Event.onBonusStateChange)
end

return Activity216Rpc
