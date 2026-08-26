-- chunkname: @modules/logic/versionactivity1_3/armpipe/rpc/Activity124Rpc.lua

module("modules.logic.versionactivity1_3.armpipe.rpc.Activity124Rpc", package.seeall)

local Activity124Rpc = class("Activity124Rpc", BaseRpc)

function Activity124Rpc:sendGetAct124InfosRequest(actId, callback, callbackObj)
	local req = Activity124Module_pb.GetAct124InfosRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity124Rpc:onReceiveGetAct124InfosReply(resultCode, msg)
	if resultCode == 0 then
		Activity124Model.instance:onReceiveGetAct120InfoReply(msg)
		Activity124Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.RefreshMapData)
	end
end

function Activity124Rpc:sendFinishAct124EpisodeRequest(actId, episodeId, timestamp, sign)
	local req = Activity124Module_pb.FinishAct124EpisodeRequest()

	req.activityId = actId
	req.episodeId = episodeId
	req.timestamp = timestamp or ""
	req.sign = sign or ""

	self:sendMsg(req)
end

function Activity124Rpc:onReceiveFinishAct124EpisodeReply(resultCode, msg)
	if resultCode == 0 then
		Activity124Model.instance:onReceiveFinishAct124EpisodeReply(msg)
		Activity124Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.RefreshEpisode, msg.episodeId)
	end
end

function Activity124Rpc:sendReceiveAct124RewardRequest(actId, episodeId)
	local req = Activity124Module_pb.ReceiveAct124RewardRequest()

	req.activityId = actId
	req.episodeId = episodeId

	self:sendMsg(req)
end

function Activity124Rpc:onReceiveReceiveAct124RewardReply(resultCode, msg)
	if resultCode == 0 then
		Activity124Model.instance:onReceiveReceiveAct124RewardReply(msg)
		Activity124Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.RefreshReceiveReward, msg.episodeId)
	end
end

Activity124Rpc.instance = Activity124Rpc.New()

return Activity124Rpc
