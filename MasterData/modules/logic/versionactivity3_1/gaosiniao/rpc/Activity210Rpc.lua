-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/rpc/Activity210Rpc.lua

module("modules.logic.versionactivity3_1.gaosiniao.rpc.Activity210Rpc", package.seeall)

local Activity210Rpc = class("Activity210Rpc", BaseRpc)

function Activity210Rpc:sendGetAct210InfoRequest(activityId, callback, cbObj)
	local req = Activity210Module_pb.GetAct210InfoRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, cbObj)
end

function Activity210Rpc:onReceiveGetAct210InfoReply(resultCode, msg)
	self:_onReceiveGetAct210InfoReply(resultCode, msg)
end

function Activity210Rpc:sendAct210SaveEpisodeProgressRequest(activityId, episodeId, progress, callback, cbObj)
	local req = Activity210Module_pb.Act210SaveEpisodeProgressRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.progress = progress or ""

	return self:sendMsg(req, callback, cbObj)
end

function Activity210Rpc:onReceiveAct210SaveEpisodeProgressReply(resultCode, msg)
	self:_onReceiveAct210SaveEpisodeProgressReply(resultCode, msg)
end

function Activity210Rpc:sendAct210FinishEpisodeRequest(activityId, episodeId, progress, callback, cbObj)
	local req = Activity210Module_pb.Act210FinishEpisodeRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.progress = progress or ""

	return self:sendMsg(req, callback, cbObj)
end

function Activity210Rpc:onReceiveAct210FinishEpisodeReply(resultCode, msg)
	self:_onReceiveAct210FinishEpisodeReply(resultCode, msg)
end

function Activity210Rpc:sendAct210ChooseEpisodeBranchRequest(activityId, episodeId, branchId, callback, cbObj)
	local req = Activity210Module_pb.Act210ChooseEpisodeBranchRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.branchId = branchId

	return self:sendMsg(req, callback, cbObj)
end

function Activity210Rpc:onReceiveAct210ChooseEpisodeBranchReply(resultCode, msg)
	self:_onReceiveAct210ChooseEpisodeBranchReply(resultCode, msg)
end

function Activity210Rpc:onReceiveAct210EpisodePush(resultCode, msg)
	self:_onReceiveAct210EpisodePush(resultCode, msg)
end

return Activity210Rpc
