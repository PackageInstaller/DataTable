-- chunkname: @modules/logic/versionactivity3_2/cruise/rpc/Activity218Rpc.lua

module("modules.logic.versionactivity3_2.cruise.rpc.Activity218Rpc", package.seeall)

local Activity218Rpc = class("Activity218Rpc", BaseRpc)

Activity218Rpc.instance = Activity218Rpc.New()

function Activity218Rpc:sendGet218InfoRequest(activityId, callback, callbackObj)
	local req = Activity218Module_pb.Get218InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity218Rpc:onReceiveGet218InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity218Model.instance:setAct218Info(msg)
	Activity218Controller.instance:dispatchEvent(Activity218Event.OnMsgInfoChange)
end

function Activity218Rpc:sendAct218FinishGameRequest(activityId, result, gameRecord, callback, callbackObj)
	local req = Activity218Module_pb.Act218FinishGameRequest()

	req.activityId = activityId
	req.result = result
	req.gameRecord = gameRecord

	self:sendMsg(req, callback, callbackObj)
end

function Activity218Rpc:onReceiveAct218FinishGameReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity218Model.instance:updateFinishGameCount(msg.finishGameCount, msg.activityId)
	Activity218Model.instance:updateTotalCoinNum(msg.totalCoinNum, msg.activityId)
	Activity218Model.instance:refreshRedPoint()
	Activity218Controller.instance:dispatchEvent(Activity218Event.OnMsgInfoChange)
end

function Activity218Rpc:sendAct218AcceptRewardRequest(activityId, callback, callbackObj)
	local req = Activity218Module_pb.Act218AcceptRewardRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity218Rpc:onReceiveAct218AcceptRewardReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local msgRewardId = Activity218Model.instance:convertAcceptedRewardId(msg.acceptedRewardId)

	Activity218Controller.instance:showReceiveCommonPropView(Activity218Model.instance:getAcceptedRewardId() + 1, msgRewardId)
	Activity218Model.instance:updateAcceptedRewardId(msg.acceptedRewardId, msg.activityId)
	Activity218Model.instance:refreshRedPoint()
	Activity218Controller.instance:dispatchEvent(Activity218Event.OnReceiveAcceptRewardReply)
end

return Activity218Rpc
