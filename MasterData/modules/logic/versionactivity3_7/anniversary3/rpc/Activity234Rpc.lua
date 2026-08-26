-- chunkname: @modules/logic/versionactivity3_7/anniversary3/rpc/Activity234Rpc.lua

module("modules.logic.versionactivity3_7.anniversary3.rpc.Activity234Rpc", package.seeall)

local Activity234Rpc = class("Activity234Rpc", BaseRpc)

function Activity234Rpc:onInit()
	self:reInit()
end

function Activity234Rpc:reInit()
	return
end

function Activity234Rpc:sendGet234InfoRequest(activityId, callback, callbackObj)
	local req = Activity234Module_pb.Get234InfoRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity234Rpc:onReceiveGet234InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	GuessGameModel.instance:setAct234Info(msg)
	GuessGameController.instance:dispatchEvent(GuessGameEvent.OnGetInfo)
end

function Activity234Rpc:sendAct234FinishGameRequest(activityId, score, gameRecord, callback, callbackObj)
	local req = Activity234Module_pb.Act234FinishGameRequest()

	req.activityId = activityId
	req.score = score
	req.gameRecord = gameRecord

	return self:sendMsg(req, callback, callbackObj)
end

function Activity234Rpc:onReceiveAct234FinishGameReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	GuessGameModel.instance:updateFinishCount(msg.finishGameCount, msg.activityId)
	GuessGameModel.instance:updateTotalScore(msg.totalScore, msg.activityId)
	GuessGameController.instance:dispatchEvent(GuessGameEvent.OnFinishGame)
end

function Activity234Rpc:sendAct234AcceptRewardRequest(activityId, callback, callbackObj)
	local req = Activity234Module_pb.Act234AcceptRewardRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity234Rpc:onReceiveAct234AcceptRewardReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	GuessGameModel.instance:updateAcceptedRewardId(msg.acceptedRewardId, msg.activityId)
	GuessGameController.instance:dispatchEvent(GuessGameEvent.OnReceiveAcceptReward)
end

function Activity234Rpc:sendAct234ExploreRequest(activityId, callback, callbackObj)
	local req = Activity234Module_pb.Act234ExploreRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity234Rpc:onReceiveAct234ExploreReply(resultCode, msg)
	return
end

Activity234Rpc.instance = Activity234Rpc.New()

return Activity234Rpc
