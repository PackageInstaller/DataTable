-- chunkname: @modules/logic/toughbattle/rpc/Activity158Rpc.lua

module("modules.logic.toughbattle.rpc.Activity158Rpc", package.seeall)

local Activity158Rpc = class("Activity158Rpc", BaseRpc)

function Activity158Rpc:sendGet158InfosRequest(activityId, callback, callbackobj)
	local req = Activity158Module_pb.Get158InfosRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackobj)
end

function Activity158Rpc:onReceiveGet158InfosReply(resultCode, msg)
	if resultCode == 0 then
		ToughBattleModel.instance:onGetActInfo(msg.info)
	end
end

function Activity158Rpc:sendAct158StartChallengeRequest(activityId, difficulty, callback, callbackobj)
	local req = Activity158Module_pb.Act158StartChallengeRequest()

	req.activityId = activityId
	req.difficulty = difficulty

	return self:sendMsg(req, callback, callbackobj)
end

function Activity158Rpc:onReceiveAct158StartChallengeReply(resultCode, msg)
	if resultCode == 0 then
		ToughBattleModel.instance:onGetActInfo(msg.info)
	end
end

function Activity158Rpc:sendAct158AbandonChallengeRequest(activityId, callback, callbackobj)
	local req = Activity158Module_pb.Act158AbandonChallengeRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackobj)
end

function Activity158Rpc:onReceiveAct158AbandonChallengeReply(resultCode, msg)
	if resultCode == 0 then
		ToughBattleModel.instance:onGetActInfo(msg.info)
	end
end

Activity158Rpc.instance = Activity158Rpc.New()

return Activity158Rpc
