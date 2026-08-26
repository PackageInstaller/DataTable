-- chunkname: @modules/logic/versionactivity1_3/act125/rpc/Activity125Rpc.lua

module("modules.logic.versionactivity1_3.act125.rpc.Activity125Rpc", package.seeall)

local Activity125Rpc = class("Activity125Rpc", BaseRpc)

function Activity125Rpc:sendGetAct125InfosRequest(actId, callback, callbackObj)
	local req = Activity125Module_pb.GetAct125InfosRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity125Rpc:onReceiveGetAct125InfosReply(resultCode, msg)
	if resultCode == 0 then
		Activity125Model.instance:setActivityInfo(msg)
		Activity125Controller.instance:dispatchEvent(Activity125Event.DataUpdate, msg)
	end
end

function Activity125Rpc:sendFinishAct125EpisodeRequest(actId, episodeId, targetFrequency)
	local req = Activity125Module_pb.FinishAct125EpisodeRequest()

	req.activityId = actId
	req.episodeId = episodeId
	req.targetFrequency = targetFrequency

	self:sendMsg(req)
end

function Activity125Rpc:onReceiveFinishAct125EpisodeReply(resultCode, msg)
	if resultCode == 0 then
		Activity125Model.instance:refreshActivityInfo(msg)
		Activity125Controller.instance:dispatchEvent(Activity125Event.DataUpdate, msg)
		Activity125Controller.instance:dispatchEvent(Activity125Event.EpisodeFinished, msg.episodeId)
	end
end

Activity125Rpc.instance = Activity125Rpc.New()

return Activity125Rpc
