-- chunkname: @modules/logic/versionactivity2_4/act181/rpc/Activity181Rpc.lua

module("modules.logic.versionactivity2_4.act181.rpc.Activity181Rpc", package.seeall)

local Activity181Rpc = class("Activity181Rpc", BaseRpc)

function Activity181Rpc:SendGet181InfosRequest(activityId, callback, callbackObj)
	local req = Activity181Module_pb.Get181InfosRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity181Rpc:onReceiveGet181InfosReply(resultCode, msg)
	if resultCode == 0 then
		Activity181Model.instance:setActInfo(msg.activityId, msg)
		Activity181Controller.instance:dispatchEvent(Activity181Event.OnGetInfo)
	end
end

function Activity181Rpc:SendGet181BonusRequest(activityId, pos, callback, callbackObj)
	local req = Activity181Module_pb.Get181BonusRequest()

	req.activityId = activityId
	req.pos = pos

	self:sendMsg(req, callback, callbackObj)
end

function Activity181Rpc:onReceiveGet181BonusReply(resultCode, msg)
	if resultCode == 0 then
		Activity181Model.instance:setBonusInfo(msg.activityId, msg)
		Activity181Controller.instance:dispatchEvent(Activity181Event.OnGetBonus, msg.activityId, msg.id, msg.pos)
	end
end

function Activity181Rpc:SendGet181SpBonusRequest(activityId, callback, callbackObj)
	local req = Activity181Module_pb.Get181SpBonusRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity181Rpc:onReceiveGet181SpBonusReply(resultCode, msg)
	if resultCode == 0 then
		Activity181Model.instance:setSPBonusInfo(msg.activityId, msg)
		Activity181Controller.instance:dispatchEvent(Activity181Event.OnGetSPBonus, msg.activityId)
	end
end

Activity181Rpc.instance = Activity181Rpc.New()

return Activity181Rpc
