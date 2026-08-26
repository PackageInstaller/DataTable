-- chunkname: @modules/logic/versionactivity2_2/tianshinana/rpc/Activity167Rpc.lua

module("modules.logic.versionactivity2_2.tianshinana.rpc.Activity167Rpc", package.seeall)

local Activity167Rpc = class("Activity167Rpc", BaseRpc)

function Activity167Rpc:sendGetAct167InfoRequest(activityId, callback, callbackobj)
	local msg = Activity167Module_pb.GetAct167InfoRequest()

	msg.activityId = activityId

	self:sendMsg(msg, callback, callbackobj)
end

function Activity167Rpc:onReceiveGetAct167InfoReply(resultCode, msg)
	if resultCode == 0 then
		TianShiNaNaModel.instance.currEpisodeId = msg.currEpisodeId

		TianShiNaNaModel.instance:initInfo(msg.episodes)
	end
end

function Activity167Rpc:sendAct167StartEpisodeRequest(activityId, episodeId, callback, callbackobj)
	local msg = Activity167Module_pb.Act167StartEpisodeRequest()

	msg.activityId = activityId
	msg.episodeId = episodeId

	self:sendMsg(msg, callback, callbackobj)
end

function Activity167Rpc:onReceiveAct167StartEpisodeReply(resultCode, msg)
	if resultCode == 0 then
		TianShiNaNaModel.instance:initDatas(msg.episodeId, msg.scene)
	end
end

function Activity167Rpc:sendAct167ReStartEpisodeRequest(activityId, episodeId, callback, callbackobj)
	local msg = Activity167Module_pb.Act167ReStartEpisodeRequest()

	msg.activityId = activityId
	msg.episodeId = episodeId
	TianShiNaNaModel.instance.sceneLevelLoadFinish = false

	self:sendMsg(msg, callback, callbackobj)
end

function Activity167Rpc:onReceiveAct167ReStartEpisodeReply(resultCode, msg)
	if resultCode == 0 then
		TianShiNaNaModel.instance.sceneLevelLoadFinish = true

		TianShiNaNaModel.instance:resetScene(msg.scene, true)
		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.ResetScene)
	else
		TianShiNaNaModel.instance.waitStartFlow = false
	end
end

function Activity167Rpc:sendAct167BeginRoundRequest(activityId, episodeId, operations)
	local msg = Activity167Module_pb.Act167BeginRoundRequest()

	msg.activityId = activityId
	msg.episodeId = episodeId

	for _, oper in ipairs(operations) do
		table.insert(msg.operations, oper)
	end

	self:sendMsg(msg)
end

function Activity167Rpc:onReceiveAct167BeginRoundReply(resultCode, msg)
	if resultCode ~= 0 then
		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.RoundFail)
	end
end

function Activity167Rpc:sendAct167AbortRequest(activityId, episodeId, callback, callbackobj)
	local msg = Activity167Module_pb.Act167AbortRequest()

	msg.activityId = activityId
	msg.episodeId = episodeId

	self:sendMsg(msg, callback, callbackobj)
end

function Activity167Rpc:onReceiveAct167AbortReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function Activity167Rpc:sendAct167RollbackRequest(activityId, episodeId, callback, callbackobj)
	local msg = Activity167Module_pb.Act167RollbackRequest()

	msg.activityId = activityId
	msg.episodeId = episodeId

	self:sendMsg(msg, callback, callbackobj)
end

function Activity167Rpc:onReceiveAct167RollbackReply(resultCode, msg)
	if resultCode == 0 then
		TianShiNaNaModel.instance:resetScene(msg.scene)
		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.ResetScene)
	end
end

function Activity167Rpc:onReceiveAct167StepPush(resultCode, msg)
	if resultCode == 0 then
		TianShiNaNaController.instance:buildFlow(msg.steps)
	end
end

Activity167Rpc.instance = Activity167Rpc.New()

return Activity167Rpc
