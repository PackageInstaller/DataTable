-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/model/ChatMsgMO.lua

module("logic.extensions.chat.model.ChatMsgMO", package.seeall)

local ChatMsgMO = class("ChatMsgMO")

function ChatMsgMO:ctor(MessageReplyNO)
	self._senderId = false
	self._targetId = false
	self._content = ""
	self._messageType = 0
	self._channelType = 0
	self._time = -1

	if MessageReplyNO then
		self:updateMsg(MessageReplyNO)
	end
end

function ChatMsgMO:setSenderId(senderId)
	self._senderId = tonumber(senderId)
end

function ChatMsgMO:getSenderId()
	return self._senderId
end

function ChatMsgMO:setContent(content)
	self._content = content
end

function ChatMsgMO:getContent()
	return self._content
end

function ChatMsgMO:setMessageType(messageType)
	self._messageType = messageType
end

function ChatMsgMO:getMessageType()
	return self._messageType
end

function ChatMsgMO:setChannelType(channelType)
	self._channelType = channelType
end

function ChatMsgMO:getChannelType()
	return self._channelType
end

function ChatMsgMO:setTargetId(targetId)
	self._targetId = tonumber(targetId)
end

function ChatMsgMO:getTargetId()
	return self._targetId
end

function ChatMsgMO:setTime(time)
	self._time = time
end

function ChatMsgMO:getTime()
	return tonumber(self._time)
end

function ChatMsgMO:isSendByMe()
	local myUserId = tonumber(PlayerModel.instance:getId())

	return self._senderId and self._senderId == myUserId or false
end

function ChatMsgMO:getShowAlias()
	if not self:isSendByMe() then
		local targetId = self:getSenderId()
		local relationType = GameEnum.RelationTypeEnum.Friend
		local friendMo = FriendModel.instance:getUser(relationType, targetId)

		if friendMo then
			return friendMo:getAlias()
		end
	end
end

function ChatMsgMO:getShowNickName()
	if not self:isSendByMe() then
		local targetId = self:getSenderId()
		local relationType = GameEnum.RelationTypeEnum.Friend
		local friendMo = FriendModel.instance:getUser(relationType, targetId)

		if friendMo then
			return friendMo:getNickName()
		else
			return targetId
		end
	else
		return PlayerModel.instance:getNickName()
	end
end

function ChatMsgMO:getPortrait()
	if not self:isSendByMe() then
		local targetId = self:getSenderId()
		local relationType = GameEnum.RelationTypeEnum.Friend
		local friendMo = FriendModel.instance:getUser(relationType, targetId)

		if friendMo then
			return friendMo:getPortrait()
		else
			local portraitId = ConstConfig.instance:getNumValueByKey("DefaultPortrait")

			return portraitId
		end
	else
		local playerInfo = PlayerModel.instance:getPlayerCardInfo()

		return playerInfo.portrait
	end
end

function ChatMsgMO:updateMsg(MessageReplyNO)
	self:setSenderId(MessageReplyNO.senderId)
	self:setTargetId(MessageReplyNO.targetId)
	self:setChannelType(MessageReplyNO.channelType)
	self:setMessageType(MessageReplyNO.messageType)
	self:setContent(MessageReplyNO.content)
	self:setTime(MessageReplyNO.time)
end

return ChatMsgMO
