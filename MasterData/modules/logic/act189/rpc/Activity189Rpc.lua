-- chunkname: @modules/logic/act189/rpc/Activity189Rpc.lua

module("modules.logic.act189.rpc.Activity189Rpc", package.seeall)

local Activity189Rpc = class("Activity189Rpc", BaseRpc)

function Activity189Rpc:sendGetAct189InfoRequest(activityId, cb, cbObj)
	local req = Activity189Module_pb.GetAct189InfoRequest()

	req.activityId = activityId

	return self:sendMsg(req, cb, cbObj)
end

function Activity189Rpc:onReceiveGetAct189InfoReply(resultCode, msg)
	if resultCode == 0 then
		Activity189Model.instance:onReceiveGetAct189InfoReply(msg)
		Activity189Controller.instance:dispatchEvent(Activity189Event.onReceiveGetAct189InfoReply, msg)
	end
end

function Activity189Rpc:sendGetAct189OnceBonusRequest(activityId, cb, cbObj)
	local req = Activity189Module_pb.GetAct189OnceBonusRequest()

	req.activityId = activityId

	return self:sendMsg(req, cb, cbObj)
end

function Activity189Rpc:onReceiveGetAct189OnceBonusReply(resultCode, msg)
	if resultCode == 0 then
		Activity189Model.instance:onReceiveGetAct189OnceBonusReply(msg)
		Activity189Controller.instance:dispatchEvent(Activity189Event.onReceiveGetAct189OnceBonusReply, msg)
	end
end

Activity189Rpc.instance = Activity189Rpc.New()

return Activity189Rpc
