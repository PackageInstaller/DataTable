-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/model/ChatModel.lua

module("logic.extensions.chat.model.ChatModel", package.seeall)

local TimestampOffset = 300
local ChatModel = class("ChatModel", BaseModel)

function ChatModel:ctor()
	self._data = {}
	self._channels = {}
end

function ChatModel:onInit()
	GlobalDispatcher:addListener(GlobalNotify.FriendRemove, self._OnFriendRemove, self)
end

function ChatModel:onReset()
	self._data = {}
	self._channels = {}
end

function ChatModel:GetDatas()
	return self._data
end

function ChatModel:AddOfflineMsgs(msgs)
	for _, msg in ipairs(msgs) do
		self:AddOtherMsg(msg, false)
	end

	GlobalDispatcher:dispatch(GlobalNotify.OfflineMsgsAdd)
end

function ChatModel:AddMyMsg(msg, sendEvent)
	local obj = MyChatMsgObj.New():Init(msg)
	local msgId = obj:GetId()
	local channelId = obj:GetChannel()
	local receiveId = obj:GetReceiveId()
	local timestamp = obj:GetTimestamp()

	self._data[msgId] = obj
	self._channels[channelId] = self._channels[channelId] or {}

	local channel = self._channels[channelId]

	if channelId == GameEnum.ChatChannel.Private then
		channel[receiveId] = channel[receiveId] or {}
		channel = channel[receiveId]
	end

	local timeObj

	if channel.timestamp then
		if timestamp - channel.timestamp >= TimestampOffset then
			table.insert(channel, (ChatTimeObj.New(timestamp)))

			channel.timestamp = timestamp
		end
	end

	table.insert(channel, obj)

	if sendEvent then
		GlobalDispatcher:dispatch(GlobalNotify.MyMsgAdd, channelId, #channel, receiveId)
	end
end

function ChatModel:AddOtherMsg(msg, sendEvent)
	local obj = OtherChatMsgObj.New():Init(msg)
	local msgId = obj:GetId()
	local channelId = obj:GetChannel()
	local senderId = obj:GetSenderId()
	local timestamp = obj:GetTimestamp()

	OtherRoleModel.instance:AddData(senderId, msg, OtherRoleModel.Src.Chat)

	self._data[msgId] = obj
	self._channels[channelId] = self._channels[channelId] or {}

	local channel = self._channels[channelId]

	if channelId == GameEnum.ChatChannel.Private then
		channel[senderId] = channel[senderId] or {}
		channel = channel[senderId]
	end

	local timeObj

	if not channel.timestamp or timestamp - channel.timestamp >= TimestampOffset then
		local timeObj = ChatTimeObj.New(timestamp)

		table.insert(channel, timeObj)

		channel.timestamp = timestamp
	end

	table.insert(channel, obj)

	if sendEvent then
		GlobalDispatcher:dispatch(GlobalNotify.OtherMsgAdd, channelId, #channel, senderId)
	end
end

function ChatModel:GetChannelMsg(channelId)
	return self._channels[channelId] or {}
end

function ChatModel:_OnFriendRemove(id)
	local channel = self:GetChannelMsg(GameEnum.ChatChannel.Private)

	if channel[id] then
		channel[id] = nil
	end
end

function ChatModel:ReadAllMsg(channelId, id)
	local msgs = self:GetChannelMsg(channelId)

	if channelId == GameEnum.ChatChannel.Private then
		msgs = msgs[id]
	end

	for _, msgObj in ipairs(msgs) do
		if msgObj.__cname == "OtherChatMsgObj" then
			msgObj:Read()
		end
	end
end

function ChatModel:IsAllRead(channelId, id)
	local msgs = self:GetChannelMsg(channelId)

	if channelId == GameEnum.ChatChannel.Private then
		msgs = msgs[id]
	end

	msgs = msgs or {}

	return TableUtil.All(msgs, function(_, msgObj)
		return msgObj.__cname ~= "OtherChatMsgObj" and true or msgObj:IsRead()
	end)
end

function ChatModel:GetLastMsg(channelId, id)
	local msgs = self:GetChannelMsg(channelId)

	if channelId == GameEnum.ChatChannel.Private then
		msgs = msgs[id]
	end

	msgs = msgs or {}

	return (#msgs > 0 or nil) and (msgs[#msgs] or nil)
end

ChatModel.instance = ChatModel.New()

return ChatModel
