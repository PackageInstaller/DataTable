-- chunkname: @modules/logic/sp02/paomian/marcus/rpc/Activity239Rpc.lua

module("modules.logic.sp02.paomian.marcus.rpc.Activity239Rpc", package.seeall)

local Activity239Rpc = class("Activity239Rpc", BaseRpc)

function Activity239Rpc:sendGetAct239InfoRequest(activityId, callback, callbackObj)
	local req = Activity239Module_pb.GetAct239InfoRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity239Rpc:onReceiveGetAct239InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Sp02_MarcusModel.instance:initInfo(msg)
end

function Activity239Rpc:sendAct239BonusRequest(activityId, id, callback, callbackObj)
	local req = Activity239Module_pb.Act239BonusRequest()

	req.activityId = activityId
	req.id = id

	return self:sendMsg(req, callback, callbackObj)
end

function Activity239Rpc:onReceiveAct239BonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Sp02_MarcusModel.instance:initInfo(msg)
end

Activity239Rpc.instance = Activity239Rpc.New()

return Activity239Rpc
