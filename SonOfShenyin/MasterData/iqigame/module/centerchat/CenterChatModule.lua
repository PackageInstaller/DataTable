-- chunkname: @IQIGame\\Module\\CenterChat\\CenterChatModule.lua

CenterChatModule = {}

function CenterChatModule.OnNotifyChat(chat)
	if chat.channel ~= Constant.CenterChatChannelType.CHAT_CHANNEL_SYS_ROLL then
		return
	end

	EventDispatcher.Dispatch(EventID.ShowRollNotice, chat)
end
