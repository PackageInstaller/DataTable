-- chunkname: @modules/logic/versionactivity3_1/yeshumei/rpc/YeShuMeiRpc.lua

module("modules.logic.versionactivity3_1.yeshumei.rpc.YeShuMeiRpc", package.seeall)

local YeShuMeiRpc = class("YeShuMeiRpc", BaseRpc)

YeShuMeiRpc.instance = YeShuMeiRpc.New()

function YeShuMeiRpc:sendGetAct211InfoRequest(activityId, callback, callbackObj)
	local req = Activity211Module_pb.GetAct211InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function YeShuMeiRpc:onReceiveGetAct211InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	YeShuMeiModel.instance:initInfos(msg.episodes)
end

function YeShuMeiRpc:sendGetAct211FinishEpisodeRequest(activityId, episodeId, callback, callbackObj)
	local req = Activity211Module_pb.Act211FinishEpisodeRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.progress = ""

	self:sendMsg(req, callback, callbackObj)
end

function YeShuMeiRpc:onReceiveAct211FinishEpisodeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	YeShuMeiModel.instance:updateInfoFinish(msg.episodeId)
end

function YeShuMeiRpc:onReceiveAct211EpisodePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	YeShuMeiModel.instance:updateInfos(msg.episodes)
end

function YeShuMeiRpc:sendAct211SaveEpisodeProgressRequest(activityId, episodeId, callback, callbackObj)
	local req = Activity211Module_pb.Act211SaveEpisodeProgressRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.progress = "1"

	self:sendMsg(req, callback, callbackObj)
end

function YeShuMeiRpc:onReceiveAct211SaveEpisodeProgressReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	YeShuMeiModel.instance:updateInfoFinishGame(msg)
end

return YeShuMeiRpc
