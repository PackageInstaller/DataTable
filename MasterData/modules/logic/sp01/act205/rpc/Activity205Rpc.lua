-- chunkname: @modules/logic/sp01/act205/rpc/Activity205Rpc.lua

module("modules.logic.sp01.act205.rpc.Activity205Rpc", package.seeall)

local Activity205Rpc = class("Activity205Rpc", BaseRpc)

function Activity205Rpc:onInit()
	return
end

function Activity205Rpc:reInit()
	return
end

function Activity205Rpc:sendAct205GetInfoRequest(activityId, callback, callbackObj)
	local req = Activity205Module_pb.Act205GetInfoRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity205Rpc:onReceiveAct205GetInfoReply(resultCode, msg)
	if resultCode == 0 then
		Act205Model.instance:setAct205Info(msg)
	end

	Act205Controller.instance:dispatchEvent(Act205Event.OnInfoUpdate)
end

function Activity205Rpc:sendAct205GetGameInfoRequest(activityId, callback, callbackObj)
	local req = Activity205Module_pb.Act205GetGameInfoRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity205Rpc:onReceiveAct205GetGameInfoReply(resultCode, msg)
	if resultCode == 0 then
		Act205Model.instance:setAct205GameInfo(msg)
	end
end

function Activity205Rpc:sendAct205FinishGameRequest(param, callback, callbackObj)
	local req = Activity205Module_pb.Act205FinishGameRequest()

	req.activityId = param.activityId
	req.gameType = param.gameType
	req.gameInfo = param.gameInfo
	req.rewardId = param.rewardId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity205Rpc:onReceiveAct205FinishGameReply(resultCode, msg)
	if resultCode == 0 then
		Act205Model.instance:updateGameInfo(msg)
		Act205Controller.instance:dispatchEvent(Act205Event.OnFinishGame, msg)
	end
end

function Activity205Rpc:onReceiveAct205InfoPush(resultCode, msg)
	if resultCode == 0 then
		Act205Model.instance:updateGameInfo(msg)
	end
end

Activity205Rpc.instance = Activity205Rpc.New()

return Activity205Rpc
