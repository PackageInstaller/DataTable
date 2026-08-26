-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/rpc/Activity203Rpc.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.rpc.Activity203Rpc", package.seeall)

local Activity203Rpc = class("Activity203Rpc", BaseRpc)

Activity203Rpc.instance = Activity203Rpc.New()

function Activity203Rpc:sendGetAct203InfoRequest(activityId, callback, callbackObj)
	local req = Activity203Module_pb.GetAct203InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity203Rpc:onReceiveGetAct203InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity201MaLiAnNaModel.instance:initInfos(msg.episodes)
end

function Activity203Rpc:sendGetAct203FinishEpisodeRequest(activityId, episodeId, callback, callbackObj)
	local req = Activity203Module_pb.Act203FinishEpisodeRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.progress = ""

	self:sendMsg(req, callback, callbackObj)
end

function Activity203Rpc:onReceiveAct203FinishEpisodeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity201MaLiAnNaModel.instance:updateInfoFinish(msg.episodeId)
end

function Activity203Rpc:onReceiveAct203EpisodePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity201MaLiAnNaModel.instance:updateInfos(msg.episodes)
end

function Activity203Rpc:sendAct203SaveEpisodeProgressRequest(activityId, episodeId, callback, callbackObj)
	local req = Activity203Module_pb.Act203SaveEpisodeProgressRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.progress = "1"

	self:sendMsg(req, callback, callbackObj)
end

function Activity203Rpc:onReceiveAct203SaveEpisodeProgressReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity201MaLiAnNaModel.instance:updateInfoFinishGame(msg)
end

return Activity203Rpc
