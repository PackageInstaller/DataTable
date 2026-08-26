-- chunkname: @modules/logic/activity/rpc/Activity106Rpc.lua

module("modules.logic.activity.rpc.Activity106Rpc", package.seeall)

local Activity106Rpc = class("Activity106Rpc", BaseRpc)

function Activity106Rpc:sendGet106InfosRequest(actId)
	local req = Activity106Module_pb.Get106InfosRequest()

	req.activityId = actId

	self:sendMsg(req)
end

function Activity106Rpc:onReceiveGet106InfosReply(resultCode, msg)
	if resultCode == 0 then
		ActivityWarmUpController.instance:onReceiveInfos(msg.activityId, msg.orderInfos)
	end
end

function Activity106Rpc:sendGet106OrderBonusRequest(actId, orderId, orderCostTime, callback, callbackObj)
	local req = Activity106Module_pb.Get106OrderBonusRequest()

	req.activityId = actId
	req.orderId = orderId
	req.useSecond = orderCostTime

	self:sendMsg(req, callback, callbackObj)
end

function Activity106Rpc:onReceiveGet106OrderBonusReply(resultCode, msg)
	if resultCode == 0 then
		ActivityWarmUpController.instance:onUpdateSingleOrder(msg.activityId, msg.orderInfo)
	end
end

function Activity106Rpc:onReceiveUpdate106OrderPush(resultCode, msg)
	if resultCode == 0 then
		ActivityWarmUpController.instance:onOrderPush(msg.activityId, msg.orderInfo)
	end
end

Activity106Rpc.instance = Activity106Rpc.New()

return Activity106Rpc
