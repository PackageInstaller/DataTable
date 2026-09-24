-- chunkname: @modules/logic/assist/rpc/AssistRecordRpc.lua

module("modules.logic.assist.rpc.AssistRecordRpc", package.seeall)

local AssistRecordRpc = class("AssistRecordRpc", BaseRpc)

function AssistRecordRpc:sendAssistRecordGetInfoRequest(callback, callbackObj)
	local req = AssistRecordModule_pb.AssistRecordGetInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function AssistRecordRpc:onReceiveAssistRecordGetInfoReply(resultCode, msg)
	if resultCode == 0 then
		AssistRecordModel.instance:setRecordInfo(msg.recordInfo)
	end
end

function AssistRecordRpc:sendAssistRecordGetDungeonRecordRequest()
	local req = AssistRecordModule_pb.AssistRecordGetDungeonRecordRequest()

	return self:sendMsg(req)
end

function AssistRecordRpc:onReceiveAssistRecordGetDungeonRecordReply(resultCode, msg)
	if resultCode == 0 and #msg.records ~= 0 then
		ViewMgr.instance:openView(ViewName.AssistAddFriendView, msg.records)
	end
end

AssistRecordRpc.instance = AssistRecordRpc.New()

return AssistRecordRpc
