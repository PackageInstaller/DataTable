-- chunkname: @modules/logic/versionactivity2_7/coopergarland/rpc/Activity192Rpc.lua

module("modules.logic.versionactivity2_7.coopergarland.rpc.Activity192Rpc", package.seeall)

local Activity192Rpc = class("Activity192Rpc", BaseRpc)

function Activity192Rpc:sendGetAct192InfoRequest(actId, cb, cbObj)
	local req = Activity192Module_pb.GetAct192InfoRequest()

	req.activityId = actId

	self:sendMsg(req, cb, cbObj)
end

function Activity192Rpc:onReceiveGetAct192InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	CooperGarlandController.instance:onGetAct192Info(msg)
end

function Activity192Rpc:sendAct192FinishEpisodeRequest(actId, episodeId, progress, cb, cbObj)
	local req = Activity192Module_pb.Act192FinishEpisodeRequest()

	req.activityId = actId
	req.episodeId = episodeId

	if not progress then
		local hasGame = CooperGarlandConfig.instance:isGameEpisode(actId, episodeId)

		progress = hasGame and CooperGarlandEnum.Const.DefaultGameProgress or ""
	end

	req.progress = progress

	self:sendMsg(req, cb, cbObj)
end

function Activity192Rpc:onReceiveAct192FinishEpisodeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function Activity192Rpc:onReceiveAct192EpisodePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	CooperGarlandController.instance:onGetAct192Info(msg)
end

Activity192Rpc.instance = Activity192Rpc.New()

return Activity192Rpc
