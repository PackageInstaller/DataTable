-- chunkname: @modules/logic/versionactivity2_5/liangyue/rpc/LiangYueRpc.lua

module("modules.logic.versionactivity2_5.liangyue.rpc.LiangYueRpc", package.seeall)

local LiangYueRpc = class("LiangYueRpc", BaseRpc)

function LiangYueRpc:sendGetAct184InfoRequest(activityId, callback, callbackObj)
	local req = Activity184Module_pb.GetAct184InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function LiangYueRpc:onReceiveGetAct184InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	LiangYueModel.instance:onGetActInfo(msg)
	LiangYueController.instance:dispatchEvent(LiangYueEvent.OnReceiveEpisodeInfo)
end

function LiangYueRpc:sendAct184FinishEpisodeRequest(activityId, episodeId, puzzle, callback, callbackObj)
	local req = Activity184Module_pb.Act184FinishEpisodeRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.puzzle = puzzle or ""

	self:sendMsg(req, callback, callbackObj)
end

function LiangYueRpc:onReceiveAct184FinishEpisodeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local episodeId = msg.episodeId

	LiangYueModel.instance:setEpisodeInfo(msg)
	LiangYueController.instance:dispatchEvent(LiangYueEvent.OnFinishEpisode, activityId, episodeId)
end

function LiangYueRpc:onReceiveAct184EpisodePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	LiangYueModel.instance:onActInfoPush(msg)
	LiangYueController.instance:dispatchEvent(LiangYueEvent.OnEpisodeInfoPush)
end

LiangYueRpc.instance = LiangYueRpc.New()

return LiangYueRpc
