-- chunkname: @modules/logic/versionactivity1_6/act152/rpc/Activity152Rpc.lua

module("modules.logic.versionactivity1_6.act152.rpc.Activity152Rpc", package.seeall)

local Activity152Rpc = class("Activity152Rpc", BaseRpc)

function Activity152Rpc:sendGet152InfoRequest(activityId)
	local req = Activity152Module_pb.Get152InfoRequest()

	req.activityId = activityId

	self:sendMsg(req)
end

function Activity152Rpc:onReceiveGet152InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity152Model.instance:setActivity152Infos(msg.presentIds)
end

function Activity152Rpc:sendAct152AcceptPresentRequest(activityId, presentId, callback, callbackObj)
	local req = Activity152Module_pb.Act152AcceptPresentRequest()

	req.activityId = activityId
	req.presentId = presentId

	self:sendMsg(req, callback, callbackObj)
end

function Activity152Rpc:onReceiveAct152AcceptPresentReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

Activity152Rpc.instance = Activity152Rpc.New()

return Activity152Rpc
