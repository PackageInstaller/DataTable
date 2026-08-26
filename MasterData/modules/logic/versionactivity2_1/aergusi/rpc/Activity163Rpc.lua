-- chunkname: @modules/logic/versionactivity2_1/aergusi/rpc/Activity163Rpc.lua

module("modules.logic.versionactivity2_1.aergusi.rpc.Activity163Rpc", package.seeall)

local Activity163Rpc = class("Activity163Rpc", BaseRpc)

Activity163Rpc.instance = Activity163Rpc.New()

function Activity163Rpc:sendGet163InfosRequest(activityId, callback, callbackObj)
	local req = Activity163Module_pb.Get163InfosRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity163Rpc:onReceiveGet163InfosReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AergusiModel.instance:setEpisodeInfos(msg.actInfo.episodeInfo)
	AergusiModel.instance:setReadClueList(msg.actInfo.readClueIds)
	AergusiController.instance:dispatchEvent(AergusiEvent.ActInfoUpdate)
end

function Activity163Rpc:onReceiveAct163InfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AergusiModel.instance:setEpisodeInfos(msg.actInfo.episodeInfo)
	AergusiController.instance:dispatchEvent(AergusiEvent.ActInfoUpdate)
end

function Activity163Rpc:sendAct163StartEvidenceRequest(activityId, episodeId, callback, callbackObj)
	local req = Activity163Module_pb.Act163StartEvidenceRequest()

	req.activityId = activityId
	req.episodeId = episodeId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity163Rpc:onReceiveAct163StartEvidenceReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AergusiModel.instance:setEpisodeUnlockAutoTipProcess(msg.progress)
	AergusiModel.instance:setEvidenceInfo(msg.episodeId, msg.evidenceInfo)
	AergusiController.instance:dispatchEvent(AergusiEvent.StartEpisode)
end

function Activity163Rpc:sendAct163EvidenceOperationRequest(activityId, episodeId, operationType, params, callback, callbackObj)
	local req = Activity163Module_pb.Act163EvidenceOperationRequest()

	req.activityId = activityId
	req.episodeId = episodeId
	req.operationType = operationType
	req.params = params

	return self:sendMsg(req, callback, callbackObj)
end

function Activity163Rpc:onReceiveAct163EvidenceOperationReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AergusiModel.instance:setEvidenceInfo(msg.episodeId, msg.evidenceInfo)
	AergusiController.instance:dispatchEvent(AergusiEvent.StartOperation, msg.operationType, msg.operationResult)
end

function Activity163Rpc:sendAct163ReadClueRequest(activityId, clueId, callback, callbackObj)
	local req = Activity163Module_pb.Act163ReadClueRequest()

	req.activityId = activityId
	req.clueId = clueId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity163Rpc:onReceiveAct163ReadClueReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AergusiModel.instance:setClueReaded(msg.clueId)
	AergusiController.instance:dispatchEvent(AergusiEvent.OnClueReadUpdate, msg.clueId)
end

return Activity163Rpc
