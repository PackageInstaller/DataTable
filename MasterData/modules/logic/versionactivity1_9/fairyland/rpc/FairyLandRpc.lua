-- chunkname: @modules/logic/versionactivity1_9/fairyland/rpc/FairyLandRpc.lua

module("modules.logic.versionactivity1_9.fairyland.rpc.FairyLandRpc", package.seeall)

local FairyLandRpc = class("FairyLandRpc", BaseRpc)

function FairyLandRpc:sendGetFairylandInfoRequest(callback, callbackObj)
	local req = FairylandModule_pb.GetFairylandInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function FairyLandRpc:onReceiveGetFairylandInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	FairyLandModel.instance:onGetFairylandInfoReply(msg)
	FairyLandController.instance:dispatchEvent(FairyLandEvent.UpdateInfo)
end

function FairyLandRpc:sendResolvePuzzleRequest(id, answer, callback, callbackObj)
	local req = FairylandModule_pb.ResolvePuzzleRequest()

	req.passPuzzleId = id
	req.answer = answer

	return self:sendMsg(req, callback, callbackObj)
end

function FairyLandRpc:onReceiveResolvePuzzleReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	FairyLandModel.instance:onResolvePuzzleReply(msg)
	FairyLandController.instance:dispatchEvent(FairyLandEvent.ResolveSuccess)
end

function FairyLandRpc:sendRecordDialogRequest(dialogId, callback, callbackObj)
	local req = FairylandModule_pb.RecordDialogRequest()

	req.dialogId = dialogId

	FairyLandModel.instance:setFinishDialog(dialogId)

	return self:sendMsg(req, callback, callbackObj)
end

function FairyLandRpc:onReceiveRecordDialogReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	FairyLandModel.instance:onRecordDialogReply(msg)
	FairyLandController.instance:dispatchEvent(FairyLandEvent.DialogFinish)
end

function FairyLandRpc:sendRecordElementRequest(elementId, callback, callbackObj)
	local req = FairylandModule_pb.RecordElementRequest()

	req.elementId = elementId

	return self:sendMsg(req, callback, callbackObj)
end

function FairyLandRpc:onReceiveRecordElementReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	FairyLandModel.instance:onRecordElementReply(msg)
	FairyLandController.instance:dispatchEvent(FairyLandEvent.ElementFinish)
end

FairyLandRpc.instance = FairyLandRpc.New()

return FairyLandRpc
