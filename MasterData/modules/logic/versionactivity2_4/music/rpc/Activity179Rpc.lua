-- chunkname: @modules/logic/versionactivity2_4/music/rpc/Activity179Rpc.lua

module("modules.logic.versionactivity2_4.music.rpc.Activity179Rpc", package.seeall)

local Activity179Rpc = class("Activity179Rpc", BaseRpc)

function Activity179Rpc:sendGet179InfosRequest(activityId, callback, callbackObj)
	local req = Activity179Module_pb.Get179InfosRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity179Rpc:onReceiveGet179InfosReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local act179EpisodeNO = msg.act179EpisodeNO

	Activity179Model.instance:initEpisodeList(act179EpisodeNO)
end

function Activity179Rpc:sendSet179ScoreRequest(activityId, episodeId, score, callback, callbackObj)
	local req = Activity179Module_pb.Set179ScoreRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.score = score

	self:sendMsg(req, callback, callbackObj)
end

function Activity179Rpc:onReceiveSet179ScoreReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local act179EpisodeNO = msg.act179EpisodeNO

	Activity179Model.instance:updateEpisode(act179EpisodeNO)
end

Activity179Rpc.instance = Activity179Rpc.New()

return Activity179Rpc
