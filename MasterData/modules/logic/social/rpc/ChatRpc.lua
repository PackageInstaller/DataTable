-- chunkname: @modules/logic/social/rpc/ChatRpc.lua

module("modules.logic.social.rpc.ChatRpc", package.seeall)

local ChatRpc = class("ChatRpc", BaseRpc)

function ChatRpc:sendSendMsgRequest(channelType, recipientId, content, msgType, extData, callback, callbackObj)
	local req = ChatModule_pb.SendMsgRequest()

	req.channelType = channelType
	req.recipientId = recipientId
	req.content = content
	req.msgType = msgType or 0
	req.extData = extData or ""

	self:sendMsg(req, callback, callbackObj)
end

function ChatRpc:onReceiveSendMsgReply(resultCode, msg)
	if resultCode == 0 and not string.nilorempty(msg.message) then
		GameFacade.showMessageBox(MessageBoxIdDefine.ForbidSendMessage, MsgBoxEnum.BoxType.Yes, nil, nil, nil, nil, nil, nil, msg.message)
	end
end

function ChatRpc:sendDeleteOfflineMsgRequest()
	local req = ChatModule_pb.DeleteOfflineMsgRequest()

	self:sendMsg(req)
end

function ChatRpc:onReceiveDeleteOfflineMsgReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function ChatRpc:onReceiveChatMsgPush(resultCode, msg)
	if resultCode == 0 then
		local messages = msg.msg

		if messages and #messages > 0 then
			local myUserId = PlayerModel.instance:getMyUserId()
			local existOthersMessage = false

			for i, message in ipairs(messages) do
				if message.senderId ~= myUserId then
					existOthersMessage = true
				end

				SocialMessageModel.instance:addSocialMessage(message)
			end

			if existOthersMessage then
				self:sendDeleteOfflineMsgRequest()
			end
		end
	end
end

function ChatRpc:sendGetReportTypeRequest(callback, callbackObj)
	local req = ChatModule_pb.GetReportTypeRequest()

	self:sendMsg(req, callback, callbackObj)
end

function ChatRpc:onReceiveGetReportTypeReply()
	return
end

function ChatRpc:sendReportRequest(reportedUserId, reportTypeId, content)
	local req = ChatModule_pb.ReportRequest()

	req.reportedUserId = reportedUserId
	req.reportTypeId = reportTypeId
	req.content = content

	self:sendMsg(req)
end

function ChatRpc:onReceiveReportReply(resultCode, msg)
	if resultCode == 0 then
		SocialController.instance:dispatchEvent(SocialEvent.InformSuccessReply)
	else
		SocialController.instance:dispatchEvent(SocialEvent.InformFailReply)
	end
end

function ChatRpc:sendWordTestRequest(contentStr, callback, callbackObj)
	local req = ChatModule_pb.WordTestRequest()

	req.content = contentStr

	self:sendMsg(req, callback, callbackObj)
end

function ChatRpc:onReceiveWordTestReply(resultCode, msg)
	return
end

ChatRpc.instance = ChatRpc.New()

return ChatRpc
