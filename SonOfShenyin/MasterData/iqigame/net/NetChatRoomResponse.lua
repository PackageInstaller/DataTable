-- chunkname: @IQIGame\\Net\\NetChatRoomResponse.lua

function net_centerChat.sendChatResult_delegate(code)
	NetCommController.Responded()
end

function net_centerChat.notifyChat(pod)
	if pod.channel == 1 then
		if pod.type == 2 then
			NoticeModule.ShowNoticeByType(4, pod.content, function()
				return
			end)
		elseif pod.type == 3 then
			NoticeModule.ShowNoticeByType(4, pod.content, function()
				LoginModule.Logout(SceneTransferModule.ReturnLogin)
			end)
		else
			NoticeModule.ShowNoticeByType(1, pod.content)
		end
	elseif pod.channel == 2 then
		CenterChatModule.OnNotifyChat(pod)
	end
end
