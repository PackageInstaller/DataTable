-- chunkname: @IQIGame\\Net\\NetCenterChatResponse.lua

function net_centerChat.switchRoomResult(code, chatRoom)
	ChatModule.ResponseChangeRoomMsg(chatRoom)
end

function net_centerChat.sendChatResult(code)
	GmListModule.OnSendCmdResult()
end

function net_centerChat.sendChatResult_delegate(code)
	NetCommController.Responded()

	if code == 14007 then
		NoticeModule.ShowNotice(21045015)

		return
	end

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerChat.sendChatResult(code)
end

function net_centerChat.notifyChat(chat)
	ChatModule.notifyChatMsg(chat)
end

function net_centerChat.notifyChatRoom(chatRoom)
	ChatModule.notifyChatRoom(chatRoom)
end

function net_centerChat.reportPlayerResult(code)
	ChatModule.OnReqReportPlayer()
end
