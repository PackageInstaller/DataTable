-- chunkname: @modules/logic/versionactivity2_5/feilinshiduo/rpc/Activity185Rpc.lua

module("modules.logic.versionactivity2_5.feilinshiduo.rpc.Activity185Rpc", package.seeall)

local Activity185Rpc = class("Activity185Rpc", BaseRpc)

function Activity185Rpc:sendGetAct185InfoRequest(activityId, callback, callbackObj)
	local req = Activity185Module_pb.GetAct185InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity185Rpc:onReceiveGetAct185InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	FeiLinShiDuoModel.instance:initEpisodeFinishInfo(msg)
end

function Activity185Rpc:sendAct185FinishEpisodeRequest(activityId, episodeId, callback, callbackObj)
	local req = Activity185Module_pb.Act185FinishEpisodeRequest()

	req.activityId = activityId
	req.episodeId = episodeId

	self:sendMsg(req, callback, callbackObj)
end

function Activity185Rpc:onReceiveAct185FinishEpisodeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local episodeId = msg.episodeId

	FeiLinShiDuoModel.instance:setCurFinishEpisodeId(episodeId)
	FeiLinShiDuoModel.instance:updateEpisodeFinishState(episodeId, true)
end

function Activity185Rpc:onReceiveAct185EpisodePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	FeiLinShiDuoModel.instance:initEpisodeFinishInfo(msg)
	FeiLinShiDuoModel.instance:setNewUnlockEpisode(msg)
end

Activity185Rpc.instance = Activity185Rpc.New()

return Activity185Rpc
