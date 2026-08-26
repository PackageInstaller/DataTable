-- chunkname: @modules/logic/activity/rpc/Activity113Rpc.lua

module("modules.logic.activity.rpc.Activity113Rpc", package.seeall)

local Activity113Rpc = class("Activity113Rpc", BaseRpc)

function Activity113Rpc:sendGetAct113InfoRequest(activityId, cb, cbObj)
	local req = Activity113Module_pb.GetAct113InfoRequest()

	req.activityId = activityId

	return self:sendMsg(req, cb, cbObj)
end

function Activity113Rpc:onReceiveGetAct113InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function Activity113Rpc:sendGetAct113MilestoneBonusRequest(activityId, cb, cbObj)
	local req = Activity113Module_pb.GetAct113MilestoneBonusRequest()

	req.activityId = activityId

	self:sendMsg(req, cb, cbObj)
end

function Activity113Rpc:onReceiveGetAct113MilestoneBonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

Activity113Rpc.instance = Activity113Rpc.New()

return Activity113Rpc
