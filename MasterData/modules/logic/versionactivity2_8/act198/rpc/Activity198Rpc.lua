-- chunkname: @modules/logic/versionactivity2_8/act198/rpc/Activity198Rpc.lua

module("modules.logic.versionactivity2_8.act198.rpc.Activity198Rpc", package.seeall)

local Activity198Rpc = class("Activity198Rpc", BaseRpc)

function Activity198Rpc:sendAct198GainRequest(activityId, callback, callbackObj)
	local req = Activity198Module_pb.Act198GainRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity198Rpc:onReceiveAct198GainReply(activityId, callback, callbackObj)
	return
end

function Activity198Rpc:onReceiveAct198CanGetPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self._actId = msg.activityId

	self:sendAct198GainRequest(self._actId)
end

Activity198Rpc.instance = Activity198Rpc.New()

return Activity198Rpc
