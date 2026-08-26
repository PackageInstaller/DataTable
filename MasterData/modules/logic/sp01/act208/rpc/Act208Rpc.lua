-- chunkname: @modules/logic/sp01/act208/rpc/Act208Rpc.lua

module("modules.logic.sp01.act208.rpc.Act208Rpc", package.seeall)

local Act208Rpc = class("Act208Rpc", BaseRpc)

function Act208Rpc:sendGetAct208InfoRequest(activityId, id, callback, callbackObj)
	local req = Activity208Module_pb.GetAct208InfoRequest()

	req.activityId = activityId
	req.id = id

	self:sendMsg(req, callback, callbackObj)
end

function Act208Rpc:onReceiveGetAct208InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local bonus = msg.bonus

	Act208Model.instance:onGetInfo(activityId, bonus)
end

function Act208Rpc:sendAct208ReceiveBonusRequest(activityId, id, callback, callbackObj)
	local req = Activity208Module_pb.Act208ReceiveBonusRequest()

	req.activityId = activityId
	req.id = id

	self:sendMsg(req, callback, callbackObj)
end

function Act208Rpc:onReceiveAct208ReceiveBonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local id = msg.id

	Act208Model.instance:onGetBonus(activityId, id)
end

Act208Rpc.instance = Act208Rpc.New()

return Act208Rpc
