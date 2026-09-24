-- chunkname: @modules/logic/versionactivity4_0/concertlimit/rpc/Activity245Rpc.lua

module("modules.logic.versionactivity4_0.concertlimit.rpc.Activity245Rpc", package.seeall)

local Activity245Rpc = class("Activity245Rpc", BaseRpc)

function Activity245Rpc:sendAct245GetInfoRequest(activityId, callback, callbackObj)
	local req = Activity245Module_pb.Act245GetInfoRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity245Rpc:onReceiveAct245GetInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	CandyRoomModel.instance:setAct245Infos(msg)
	CandyRoomController.instance:dispatchEvent(CandyRoomEvent.OnGetAct245Info)
end

function Activity245Rpc:sendAct245SummonRequest(activityId, count, callback, callbackObj)
	local req = Activity245Module_pb.Act245SummonRequest()

	req.activityId = activityId
	req.count = count

	return self:sendMsg(req, callback, callbackObj)
end

function Activity245Rpc:onReceiveAct245SummonReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	CandyRoomModel.instance:updateSummonedCounts(msg.rewardIds, msg.activityId)
	CandyRoomController.instance:dispatchEvent(CandyRoomEvent.OnAct245Summon)
end

Activity245Rpc.instance = Activity245Rpc.New()

return Activity245Rpc
