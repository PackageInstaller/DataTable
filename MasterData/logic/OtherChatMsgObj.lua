-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/model/OtherChatMsgObj.lua

module("logic.extensions.chat.model.OtherChatMsgObj", package.seeall)

local OtherChatMsgObj = class("OtherChatMsgObj", ChatMsgObj)

function OtherChatMsgObj:ctor()
	return
end

function OtherChatMsgObj:Init(data)
	OtherChatMsgObj.super.Init(self, data)

	self._senderId = tonumber(data.senderId)

	if self._channel == GameEnum.ChatChannel.Private then
		self._senderName = OtherRoleModel.instance:GetData(self._senderId):Get("name") or data.senderName
	end

	self._isRead = data.isRead == true

	return self
end

function OtherChatMsgObj:GetSenderId()
	return self._senderId
end

function OtherChatMsgObj:GetSenderName()
	return self._senderName
end

function OtherChatMsgObj:IsRead()
	return self._isRead
end

function OtherChatMsgObj:Read()
	self._isRead = true
end

function OtherChatMsgObj:ToTable()
	local t = OtherChatMsgObj.super.ToTable(self)

	t.type = 2
	t.senderId = self._senderId
	t.senderName = self._senderName
	t.isRead = self._isRead

	return t
end

return OtherChatMsgObj
