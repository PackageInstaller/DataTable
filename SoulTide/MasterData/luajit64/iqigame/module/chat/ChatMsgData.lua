-- chunkname: @IQIGame\\Module\\Chat\\ChatMsgData.lua

local ChatMsgData = {
	voiceFileId = "",
	isRead = false,
	time = 0,
	type = 0,
	isNeedShowTime = false,
	voiceFilePath = "",
	channel = 0,
	content = ""
}

function ChatMsgData.New(SChatPOD)
	local chatData = Clone(ChatMsgData)

	for k, v in pairs(SChatPOD) do
		chatData[k] = v
	end

	chatData.isRead = false

	return chatData
end

function ChatMsgData.CreateClientChatPOD(channel, content)
	local chatPOD = {}

	chatPOD.channel = channel
	chatPOD.type = 1
	chatPOD.content = content
	chatPOD.time = PlayerModule.GetServerTime()
	chatPOD.isNeedShowTime = true

	return chatPOD
end

return ChatMsgData
