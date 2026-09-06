-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/model/ChatMsgObj.lua

module("logic.extensions.chat.model.ChatMsgObj", package.seeall)

local ChatMsgObj = class("ChatMsgObj")

function ChatMsgObj:ctor()
	return
end

function ChatMsgObj:Init(data)
	self._id = tonumber(data.msgId)
	self._channel = data.channelType
	self._msgType = data.msgType
	self._sendTime = data.sendTime and tonumber(data.sendTime) / 1000 or ServerTime.now()
	self._content = data.content

	return self
end

function ChatMsgObj:GetId()
	return self._id
end

function ChatMsgObj:GetChannel()
	return self._channel
end

function ChatMsgObj:GetTimestamp()
	return self._sendTime
end

function ChatMsgObj:GetMsgType()
	return self._msgType
end

function ChatMsgObj:GetContent()
	return self._content
end

function ChatMsgObj:ToTable()
	local t = {}

	t.msgId = self._id
	t.channelType = self._channel
	t.msgType = self._msgType
	t.sendTime = self._sendTime
	t.content = self._content

	return t
end

return ChatMsgObj
