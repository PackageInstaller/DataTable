-- chunkname: @modules/logic/sp01/assassinChase/rpc/AssassinChaseRpc.lua

module("modules.logic.sp01.assassinChase.rpc.AssassinChaseRpc", package.seeall)

local AssassinChaseRpc = class("AssassinChaseRpc", BaseRpc)

function AssassinChaseRpc:sendAct206GetInfoRequest(activityId, callback, callbackObj)
	local req = Activity206Module_pb.Act206GetInfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function AssassinChaseRpc:onReceiveAct206GetInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AssassinChaseModel.instance:setActInfo(msg)
end

function AssassinChaseRpc:sendAct206ChooseDirectionRequest(activityId, directionId, callback, callbackObj)
	local req = Activity206Module_pb.Act206ChooseDirectionRequest()

	req.activityId = activityId
	req.directionId = directionId

	self:sendMsg(req, callback, callbackObj)
end

function AssassinChaseRpc:onReceiveAct206ChooseDirectionReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local chosenInfo = msg.chosenInfo

	AssassinChaseModel.instance:onSelectDirection(activityId, chosenInfo)
end

function AssassinChaseRpc:sendAct206GetBonusRequest(activityId, callback, callbackObj)
	local req = Activity206Module_pb.Act206GetBonusRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function AssassinChaseRpc:onReceiveAct206GetBonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId

	AssassinChaseController.instance:dispatchEvent(AssassinChaseEvent.OnGetReward, activityId)
end

function AssassinChaseRpc:onReceiveAct206InfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AssassinChaseModel.instance:setActInfo(msg)
end

AssassinChaseRpc.instance = AssassinChaseRpc.New()

return AssassinChaseRpc
