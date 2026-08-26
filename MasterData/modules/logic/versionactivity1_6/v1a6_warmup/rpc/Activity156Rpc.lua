-- chunkname: @modules/logic/versionactivity1_6/v1a6_warmup/rpc/Activity156Rpc.lua

module("modules.logic.versionactivity1_6.v1a6_warmup.rpc.Activity156Rpc", package.seeall)

local Activity156Rpc = class("Activity156Rpc", BaseRpc)

function Activity156Rpc:sendGetAct125InfosRequest(actId)
	local req = Activity125Module_pb.GetAct125InfosRequest()

	req.activityId = actId

	self:sendMsg(req)
end

function Activity156Rpc:onReceiveGetAct125InfosReply(resultCode, msg)
	if resultCode == 0 then
		Activity156Model.instance:setActivityInfo(msg.act125Episodes)
		Activity156Controller.instance:dispatchEvent(Activity156Event.DataUpdate)
	end
end

function Activity156Rpc:sendFinishAct125EpisodeRequest(actId, episodeId)
	local req = Activity125Module_pb.FinishAct125EpisodeRequest()

	req.activityId = actId
	req.episodeId = episodeId
	req.targetFrequency = 0

	self:sendMsg(req)
end

function Activity156Rpc:onReceiveFinishAct125EpisodeReply(resultCode, msg)
	if resultCode == 0 then
		Activity156Model.instance:setActivityInfo(msg.updateAct125Episodes)
		Activity156Controller.instance:dispatchEvent(Activity156Event.DataUpdate)
		Activity156Controller.instance:dispatchEvent(Activity156Event.EpisodeFinished, msg.episodeId)
	end
end

Activity156Rpc.instance = Activity156Rpc.New()

return Activity156Rpc
