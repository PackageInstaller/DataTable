-- chunkname: @modules/logic/versionactivity1_4/act129/rpc/Activity129Rpc.lua

module("modules.logic.versionactivity1_4.act129.rpc.Activity129Rpc", package.seeall)

local Activity129Rpc = class("Activity129Rpc", BaseRpc)

function Activity129Rpc:sendGet129InfosRequest(activityId, callback, callbackObj)
	local req = Activity129Module_pb.Get129InfosRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity129Rpc:onReceiveGet129InfosReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity129Model.instance:setInfo(msg)
	Activity129Controller.instance:dispatchEvent(Activity129Event.OnGetInfoSuccess)
end

function Activity129Rpc:sendAct129LotteryRequest(activityId, poolId, num)
	local req = Activity129Module_pb.Act129LotteryRequest()

	req.activityId = activityId
	req.poolId = poolId
	req.num = num

	return self:sendMsg(req)
end

function Activity129Rpc:onReceiveAct129LotteryReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity129Model.instance:onLotterySuccess(msg)
	Activity129Controller.instance:dispatchEvent(Activity129Event.OnLotterySuccess, msg)
end

Activity129Rpc.instance = Activity129Rpc.New()

return Activity129Rpc
