-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/rpc/Activity180Rpc.lua

module("modules.logic.versionactivity2_4.wuerlixi.rpc.Activity180Rpc", package.seeall)

local Activity180Rpc = class("Activity180Rpc", BaseRpc)

function Activity180Rpc:sendGet180InfosRequest(activityId, callback, callbackobj)
	local msg = Activity180Module_pb.Get180InfosRequest()

	msg.activityId = activityId

	self:sendMsg(msg, callback, callbackobj)
end

function Activity180Rpc:onReceiveGet180InfosReply(resultCode, msg)
	return
end

function Activity180Rpc:sendAct180EnterEpisodeRequest(activityId, episodeId, callback, callbackobj)
	local msg = Activity180Module_pb.Act180EnterEpisodeRequest()

	msg.activityId = activityId
	msg.episodeId = episodeId

	self:sendMsg(msg, callback, callbackobj)
end

function Activity180Rpc:onReceiveAct180EnterEpisodeReply(resultCode, msg)
	return
end

function Activity180Rpc:sendAct180StoryRequest(activityId, episodeId, callback, callbackobj)
	local msg = Activity180Module_pb.Act180StoryRequest()

	msg.activityId = activityId
	msg.episodeId = episodeId

	self:sendMsg(msg, callback, callbackobj)
end

function Activity180Rpc:onReceiveAct180StoryReply(resultCode, msg)
	return
end

function Activity180Rpc:sendAct180GameFinishRequest(activityId, episodeId, callback, callbackobj)
	local msg = Activity180Module_pb.Act180GameFinishRequest()

	msg.activityId = activityId
	msg.episodeId = episodeId

	self:sendMsg(msg, callback, callbackobj)
end

function Activity180Rpc:onReceiveAct180GameFinishReply(resultCode, msg)
	return
end

function Activity180Rpc:sendAct180SaveGameRequest(activityId, episodeId, gameString, callback, callbackobj)
	local msg = Activity180Module_pb.Act180SaveGameRequest()

	msg.activityId = activityId
	msg.episodeId = episodeId
	msg.gameData = gameString

	self:sendMsg(msg, callback, callbackobj)
end

function Activity180Rpc:onReceiveAct180SaveGameReply(resultCode, msg)
	return
end

function Activity180Rpc:onReceiveAct180EpisodePush(resultCode, msg)
	if resultCode == 0 then
		if msg.activityId == VersionActivity2_4Enum.ActivityId.WuErLiXi then
			WuErLiXiModel.instance:updateInfos(msg.act180Episodes)
		elseif msg.activityId == VersionActivity2_8Enum.ActivityId.NuoDiKa then
			NuoDiKaModel.instance:updateInfos(msg.act180Episodes)
		end
	end
end

Activity180Rpc.instance = Activity180Rpc.New()

return Activity180Rpc
