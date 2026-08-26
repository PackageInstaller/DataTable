-- chunkname: @modules/logic/dialogue/rpc/DialogueRpc.lua

module("modules.logic.dialogue.rpc.DialogueRpc", package.seeall)

local DialogueRpc = class("DialogueRpc", BaseRpc)

function DialogueRpc:sendGetDialogInfoRequest(callback, callbackObj)
	local req = DialogModule_pb.GetDialogInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function DialogueRpc:onReceiveGetDialogInfoReply(code, msg)
	if code ~= 0 then
		return
	end

	DialogueModel.instance:initDialogue(msg.dialogIds)
end

function DialogueRpc:sendRecordDialogInfoRequest(dialogueId, callback, callbackObj)
	local req = DialogModule_pb.RecordDialogInfoRequest()

	req.dialogId = dialogueId

	return self:sendMsg(req, callback, callbackObj)
end

function DialogueRpc:onReceiveRecordDialogInfoReplay(code, msg)
	if code ~= 0 then
		return
	end

	DialogueModel.instance:updateDialogueInfo(msg.dialogId)
end

DialogueRpc.instance = DialogueRpc.New()

return DialogueRpc
