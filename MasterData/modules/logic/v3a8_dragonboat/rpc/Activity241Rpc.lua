-- chunkname: @modules/logic/v3a8_dragonboat/rpc/Activity241Rpc.lua

module("modules.logic.v3a8_dragonboat.rpc.Activity241Rpc", package.seeall)

local Activity241Rpc = class("Activity241Rpc", BaseRpc)

function Activity241Rpc:ctor(...)
	Activity241Rpc.super.ctor(self, ...)
	LuaEventSystem.addEventMechanism(self)
end

function Activity241Rpc:sendAct241GetInfo(activityId, callback, callobj)
	local req = Activity241Module_pb.Act241GetInfoRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callobj)
end

function Activity241Rpc:onReceiveAct241GetInfoReply(resultCode, msg)
	Activity241Rpc.instance:dispatchEvent(Activity241Event.onReceiveAct241GetInfoReply, resultCode, msg)
end

function Activity241Rpc:sendAct241Vote(activityId, voteNum, optionId, callback, callobj)
	local req = Activity241Module_pb.Act241VoteRequest()

	req.activityId = activityId
	req.voteNum = voteNum
	req.optionId = optionId

	return self:sendMsg(req, callback, callobj)
end

function Activity241Rpc:onReceiveAct241VoteReply(resultCode, msg)
	Activity241Rpc.instance:dispatchEvent(Activity241Event.onReceiveAct241VoteReply, resultCode, msg)
end

function Activity241Rpc:sendAct241GetBonus(activityId, callback, callobj)
	local req = Activity241Module_pb.Act241GetBonusRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callobj)
end

function Activity241Rpc:onReceiveAct241GetBonusReply(resultCode, msg)
	Activity241Rpc.instance:dispatchEvent(Activity241Event.onReceiveAct241GetBonusReply, resultCode, msg)
end

Activity241Rpc.instance = Activity241Rpc.New()

return Activity241Rpc
