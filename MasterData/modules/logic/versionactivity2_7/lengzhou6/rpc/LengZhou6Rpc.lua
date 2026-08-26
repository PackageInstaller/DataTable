-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/rpc/LengZhou6Rpc.lua

module("modules.logic.versionactivity2_7.lengzhou6.rpc.LengZhou6Rpc", package.seeall)

local LengZhou6Rpc = class("LengZhou6Rpc", BaseRpc)

function LengZhou6Rpc:sendGetAct190InfoRequest(activityId, callback, callbackObj)
	local req = Activity190Module_pb.GetAct190InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function LengZhou6Rpc:onReceiveGetAct190InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	LengZhou6Model.instance:onGetActInfo(msg)
	LengZhou6Controller.instance:openLengZhou6LevelView()
end

function LengZhou6Rpc:sendAct190FinishEpisodeRequest(episodeId, progress, callback, callbackObj)
	local req = Activity190Module_pb.Act190FinishEpisodeRequest()

	req.activityId = LengZhou6Model.instance:getCurActId()
	req.episodeId = episodeId
	req.progress = progress or ""

	self:sendMsg(req, callback, callbackObj)
end

function LengZhou6Rpc:onReceiveAct190FinishEpisodeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	LengZhou6Controller.instance:onFinishEpisode(msg)
end

function LengZhou6Rpc:onReceiveAct190EpisodePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	LengZhou6Model.instance:onPushActInfo(msg)
end

LengZhou6Rpc.instance = LengZhou6Rpc.New()

return LengZhou6Rpc
