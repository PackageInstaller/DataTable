-- chunkname: @modules/logic/versionactivity220/rpc/Activity220Rpc.lua

module("modules.logic.versionactivity220.rpc.Activity220Rpc", package.seeall)

local Activity220Rpc = class("Activity220Rpc", BaseRpc)

function Activity220Rpc:sendGetAct220InfoRequest(activityId, callback, callbackObj)
	local req = Activity220Module_pb.GetAct220InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity220Rpc:onReceiveGetAct220InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity220Model.instance:updateInfo(msg)
	Activity220Controller.instance:dispatchEvent(Activity220Event.GetAct220InfoReply, msg)
end

function Activity220Rpc:sendAct220SaveEpisodeProgressRequest(activityId, episodeId, progress, callback, callbackObj)
	local req = Activity220Module_pb.Act220SaveEpisodeProgressRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.progress = progress or ""

	self:sendMsg(req, callback, callbackObj)
end

function Activity220Rpc:onReceiveAct220SaveEpisodeProgressReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity220Model.instance:updateEpisodeInfo(msg)
	Activity220Controller.instance:dispatchEvent(Activity220Event.SaveEpisodeProgressReply, msg)
end

function Activity220Rpc:sendAct220FinishEpisodeRequest(activityId, episodeId, progress, callback, callbackObj)
	local req = Activity220Module_pb.Act220FinishEpisodeRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.progress = progress or ""

	self:sendMsg(req, callback, callbackObj)
end

function Activity220Rpc:onReceiveAct220FinishEpisodeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity220Model.instance:finishEpisode(msg)
	Activity220Controller.instance:dispatchEvent(Activity220Event.FinishEpisodeReply, msg)
end

function Activity220Rpc:sendAct220ChooseEpisodeBranchRequest(activityId, episodeId, branchId, callback, callbackObj)
	local req = Activity220Module_pb.Act220ChooseEpisodeBranchRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.branchId = branchId or 0

	self:sendMsg(req, callback, callbackObj)
end

function Activity220Rpc:onReceiveAct220ChooseEpisodeBranchReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity220Model.instance:unlockEpisodeBranch(msg)
	Activity220Controller.instance:dispatchEvent(Activity220Event.ChooseEpisodeBranchReply, msg)
end

function Activity220Rpc:onReceiveAct220EpisodePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity220Model.instance:pushEpisodes(msg)
	Activity220Controller.instance:dispatchEvent(Activity220Event.EpisodePush, msg)
end

Activity220Rpc.instance = Activity220Rpc.New()

return Activity220Rpc
