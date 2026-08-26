-- chunkname: @modules/logic/sp02/paomian/guessme/rpc/Activity238Rpc.lua

module("modules.logic.sp02.paomian.guessme.rpc.Activity238Rpc", package.seeall)

local Activity238Rpc = class("Activity238Rpc", BaseRpc)

function Activity238Rpc:sendGetAct238InfoRequest(activityId, callback, callbackObj)
	local req = Activity238Module_pb.GetAct238InfoRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity238Rpc:onReceiveGetAct238InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Sp02_GuessMeModel.instance:initInfo(msg)
end

function Activity238Rpc:sendAct238AnswerRequest(activityId, id, callback, callbackObj)
	local req = Activity238Module_pb.Act238AnswerRequest()

	req.activityId = activityId
	req.id = id

	return self:sendMsg(req, callback, callbackObj)
end

function Activity238Rpc:onReceiveAct238AnswerReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Sp02_GuessMeModel.instance:onGetSingleSignInfo(msg.activityId, msg.sign)
end

function Activity238Rpc:sendAct238BonusRequest(activityId, id, callback, callbackObj)
	local req = Activity238Module_pb.Act238BonusRequest()

	req.activityId = activityId
	req.id = id

	return self:sendMsg(req, callback, callbackObj)
end

function Activity238Rpc:onReceiveAct238BonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Sp02_GuessMeModel.instance:onGetSingleSignInfo(msg.activityId, msg.sign)
end

Activity238Rpc.instance = Activity238Rpc.New()

return Activity238Rpc
