-- chunkname: @modules/logic/versionactivity1_2/trade/rpc/Activity117Rpc.lua

module("modules.logic.versionactivity1_2.trade.rpc.Activity117Rpc", package.seeall)

local Activity117Rpc = class("Activity117Rpc", BaseRpc)

function Activity117Rpc:sendAct117InfoRequest(actId, callback, callbackObj)
	local req = Activity117Module_pb.Act117InfoRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity117Rpc:onReceiveAct117InfoReply(resultCode, msg)
	if resultCode == 0 then
		Activity117Model.instance:onReceiveInfos(msg)
		Activity117Controller.instance:dispatchEvent(Activity117Event.ReceiveInfos, msg.activityId)
	end
end

function Activity117Rpc:sendAct117NegotiateRequest(actId, orderId, price, callback, callbackObj)
	local req = Activity117Module_pb.Act117NegotiateRequest()

	req.activityId = actId
	req.orderId = orderId
	req.userDealScore = price

	self:sendMsg(req, callback, callbackObj)
end

function Activity117Rpc:onReceiveAct117NegotiateReply(resultCode, msg)
	if resultCode == 0 then
		Activity117Model.instance:onNegotiateResult(msg)
		Activity117Controller.instance:dispatchEvent(Activity117Event.ReceiveNegotiate, msg.activityId)
	end
end

function Activity117Rpc:sendAct117DealRequest(activityId, orderId, callback, callbackObj)
	local req = Activity117Module_pb.Act117DealRequest()

	req.activityId = activityId
	req.orderId = orderId

	self:sendMsg(req, callback, callbackObj)
end

function Activity117Rpc:onReceiveAct117DealReply(resultCode, msg)
	if resultCode == 0 then
		Activity117Model.instance:onDealSuccess(msg)
		Activity117Controller.instance:dispatchEvent(Activity117Event.ReceiveDeal, msg.activityId)
	end
end

function Activity117Rpc:sendAct117GetBonusRequest(activityId, bonusIds, callback, callbackObj)
	local req = Activity117Module_pb.Act117GetBonusRequest()

	req.activityId = activityId

	if bonusIds then
		for _, bonusId in ipairs(bonusIds) do
			table.insert(req.bonusIds, bonusId)
		end
	end

	self:sendMsg(req, callback, callbackObj)
end

function Activity117Rpc:onReceiveAct117GetBonusReply(resultCode, msg)
	if resultCode == 0 then
		Activity117Model.instance:updateRewardDatas(msg)
		Activity117Controller.instance:dispatchEvent(Activity117Event.ReceiveGetBonus, msg.activityId, msg.bonusIds)
	end
end

function Activity117Rpc:onReceiveAct117OrderPush(resultCode, msg)
	if resultCode == 0 then
		Activity117Model.instance:onOrderPush(msg)
		Activity117Controller.instance:dispatchEvent(Activity117Event.ReceiveOrderPush, msg.activityId)
	end
end

Activity117Rpc.instance = Activity117Rpc.New()

return Activity117Rpc
