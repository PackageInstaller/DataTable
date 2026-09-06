-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/config/ChatConfig.lua

module("logic.extensions.chat.config.ChatConfig", package.seeall)

local ChatConfig = class("ChatConfig", BaseConfig)

function ChatConfig:onInit()
	self._sendCd = {}
	self._sendMat = {}
	self._sendConsume = {}
	self._systemTCfg = {}
	self._emojiCfgs = {}
end

function ChatConfig:getNames()
	return {
		"chat_channel_send_config",
		"chat_system_msg_template",
		"emoji",
		"chat_color",
		"emoji_group",
		"chat_bubble"
	}
end

function ChatConfig:handleConfig(name, content)
	if name == "chat_system_msg_template" then
		self._systemTCfg = content
	elseif name == "chat_color" then
		self._chatColorCfgs = content
	elseif name == "chat_bubble" then
		self._chatBubble = content
	elseif name == "emoji" then
		self._emojiCfgList = content
		self._emojiCfgs = {}

		for k, v in pairs(content) do
			if checknumber(k) > 0 then
				self._emojiCfgs[v.groupId] = self._emojiCfgs[v.groupId] or {}

				table.insert(self._emojiCfgs[v.groupId], v)
			end
		end
	elseif name == "emoji_group" then
		self._emojiGroupCfg = content
	elseif name == "chat_channel_send_config" then
		self._sendCfgs = content
		content = content.dataList

		for _, v in pairs(content) do
			local i = v.id
			local sendCd = (v.sendCd or 0) / 1000

			self._sendCd[i] = sendCd > 1 and sendCd or 0

			local sendMat = v.sendDecMaterial

			if not string.nilorempty(sendMat) then
				self._sendMat[i] = {}

				local lines = string.split(sendMat, "#")

				for _, line in ipairs(lines) do
					local values = string.split(line, ":")
					local t = {
						type = tonumber(values[1]),
						id = tonumber(values[2]),
						count = tonumber(values[3])
					}

					table.insert(self._sendMat[i], t)
				end
			end

			local sendConsume = v.directConsume

			if not string.nilorempty(sendConsume) then
				self._sendConsume[i] = {}

				local lines = string.split(sendConsume, "#")

				for _, line in ipairs(lines) do
					local values = string.split(line, ":")
					local type = tonumber(values[1])
					local t = {
						type = type == 105 and 104 or type,
						id = tonumber(values[2]),
						count = tonumber(values[3])
					}

					table.insert(self._sendConsume[i], t)
				end
			end
		end
	end
end

function ChatConfig:getSendCfg(channel)
	if self._sendCfgs then
		return self._sendCfgs[channel]
	end
end

function ChatConfig:getChatColorCfgs()
	return self._chatColorCfgs.dataList or {}
end

function ChatConfig:getChatBubbleCfgs()
	return self._chatBubble.dataList
end

function ChatConfig:getChatBubbleCfgById(id)
	return self._chatBubble[id]
end

function ChatConfig:GetSendCd(channelId)
	return self._sendCd[channelId] or 1
end

function ChatConfig:GetSendMat(channelId)
	return self._sendMat[channelId]
end

function ChatConfig:GetSendConsume(channelId)
	return self._sendConsume[channelId]
end

function ChatConfig:getMsgCountLimit(channel)
	return 40
end

function ChatConfig:getSystemMsgT(id)
	return self._systemTCfg[id]
end

function ChatConfig:getEmojiCfg(id)
	return self._emojiCfgList[id]
end

function ChatConfig:getEmojiCfgsByGroupId(groupId)
	return self._emojiCfgs[groupId] or {}
end

function ChatConfig:getEmojiGroupList()
	return self._emojiGroupCfg.dataList
end

function ChatConfig:getEmojiGroupCfg(groupId)
	return self._emojiGroupCfg[groupId]
end

ChatConfig.instance = ChatConfig.New()

return ChatConfig
