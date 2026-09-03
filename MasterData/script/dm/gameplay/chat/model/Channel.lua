-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/chat/model/Channel.lua

BaseChannel = class("BaseChannel", objectlua.Object, _M)

BaseChannel:has("_id", {
	is = "rw"
})
BaseChannel:has("_type", {
	is = "rw"
})
BaseChannel:has("_capacity", {
	is = "rw"
})
BaseChannel:has("_messages", {
	is = "rw"
})
BaseChannel:has("_isDirty", {
	is = "rw"
})
BaseChannel:has("_newMessageCnt", {
	is = "rw"
})

ChannelType = {
	kPrivate = "PRIVATE",
	kFlow = "FLOW",
	kChatRoom = "CHATROOM",
	kChat = "CHAT",
	kFilter = "FILTER",
	kBase = "BASE"
}
ChannelId = {
	kUnionFlow = "FLOW-UNION",
	kWorld = "CHAT-WORLD",
	kBattleFlow = "FLOW-BATTLE",
	kWordPeace = "CHATROOM-WORDPEACE",
	kWordPeaceSwear = "CHATROOM-WORDPEACESWEAR",
	kSystemFilter = "FILTER-SYSTEM_FILTER",
	kUnion = "CHAT-UNION",
	kHomeFlow = "FLOW-HOME",
	kSystem = "BASE-SYSTEM",
	kTeam = "CHAT-TEAM",
	kArenaFlow = "FLOW-ARENA",
	kSelf = "BASE-SELF",
	kStageFlow = "FLOW-STAGE"
}
ChatTabType = {
	kUnion = 3,
	kSystem = 1,
	kTeam = 4,
	kWordPeace = 6,
	kWordPeaceSwear = 7,
	kWorld = 2
}
TabTypeToChannelId = {
	[ChatTabType.kSystem] = ChannelId.kSystemFilter,
	[ChatTabType.kWorld] = ChannelId.kWorld,
	[ChatTabType.kUnion] = ChannelId.kUnion,
	[ChatTabType.kTeam] = ChannelId.kTeam,
	[ChatTabType.kWordPeace] = ChannelId.kWordPeace,
	[ChatTabType.kWordPeaceSwear] = ChannelId.kWordPeaceSwear
}
FilterRulesMap = {
	[ChannelId.kSystemFilter] = {
		[ChannelId.kSystem] = true,
		[ChannelId.kSelf] = true
	}
}

local function sortMessages(messages)
	table.sort(messages, function(a, b)
		local aTime = a:getTime()
		local bTime = b:getTime()

		if aTime == bTime then
			local aId = a:getId()
			local bId = b:getId()

			if aId == nil then
				return false
			elseif bId == nil then
				return true
			else
				return aId < bId
			end
		else
			return aTime < bTime
		end
	end)
end

function BaseChannel:initialize(id)
	super.initialize(self)

	self._id = id
	self._capacity = 100
	self._type = ChannelType.kBase
	self._messages = {}
	self._newMessageCnt = 0
	self._isDirty = false
end

function BaseChannel:getMessages()
	if self._isDirty then
		self:refresh()
	end

	return self._messages
end

function BaseChannel:getNewMessages()
	local newMessages = {}
	local newMessageCnt = self:getNewMessageCnt()

	if newMessageCnt > 0 then
		local messages = self:getMessages()
		local messageCnt = #messages

		for i = messageCnt - newMessageCnt + 1, messageCnt do
			newMessages[#newMessages + 1] = messages[i]
		end
	end

	return newMessages
end

function BaseChannel:addMessage(message, isOld)
	if message == nil then
		return
	end

	local messages = self._messages

	messages[#messages + 1] = message

	if not isOld then
		self._newMessageCnt = self._newMessageCnt + 1
	end

	self._isDirty = true
end

function BaseChannel:clear()
	self._messages = {}
	self._newMessageCnt = 0
	self._isDirty = false
end

function BaseChannel:isDirty()
	return self._isDirty
end

function BaseChannel:sort()
	sortMessages(self._messages)
end

function BaseChannel:cutSize()
	local size = #self._messages

	if size > self._capacity then
		local cutCount = size - self._capacity

		for k = 1, size do
			if k > self._capacity then
				self._messages[k] = nil
			else
				self._messages[k] = self._messages[k + cutCount]
			end
		end
	end
end

function BaseChannel:refresh()
	if not self._isDirty then
		return
	end

	self:sort()
	self:cutSize()

	self._isDirty = false
end

function BaseChannel:getRoomTypeAndId(injector)
	local channelId = self:getId()
	local strs = string.split(channelId, "-")
	local channelType = strs[1]

	if channelType == ChannelType.kPrivate then
		return ChatRoomType.kPrivate, channelId
	elseif channelType == ChannelType.kChatRoom then
		if channelId == ChannelId.kWordPeace or channelId == ChannelId.kWordPeaceSwear then
			local worldPeaceSystem = injector:getInstance("WorldPeaceSystem")
			local wordpeace = worldPeaceSystem:getWorldPeace()

			return ChatRoomType.kChatRoom, wordpeace:getBattleFieldId()
		else
			return ChatRoomType.kChatRoom, channelId
		end
	elseif channelId == ChannelId.kSystem or channelId == ChannelId.kWorld then
		return ChatRoomType.kWorld, "WORLD"
	elseif channelId == ChannelId.kSelf then
		local player = injector:getInstance("DevelopSystem"):getPlayer()
		local roomId = player:getRid()

		return ChatRoomType.kSelf, roomId
	elseif channelId == ChannelId.kUnion then
		local clubId
		local clubSystem = injector:getInstance("ClubSystem")

		return ChatRoomType.kUnion, (clubSystem:getHasJoinClub() or nil) and clubSystem:getClubId()
	elseif channelId == ChannelId.kTeam then
		return ChatRoomType.kTeam, nil
	elseif channelId == ChannelId.kCross then
		return ChatRoomType.kCross, "CROSS"
	end

	return nil, nil
end

ChatChannel = class("ChatChannel", BaseChannel, _M)

function ChatChannel:initialize(id)
	super.initialize(self, id)

	self._type = ChannelType.kChat
end

PrivateChannel = class("PrivateChannel", ChatChannel, _M)

function PrivateChannel:initialize(id)
	super.initialize(self, id)

	self._type = ChannelType.kPrivate
end

ChatRoomChannel = class("ChatRoomChannel", ChatChannel, _M)

function ChatRoomChannel:initialize(id)
	super.initialize(self, id)

	self._type = ChannelType.kChatRoom
end

FilterChannel = class("FilterChannel", BaseChannel, _M)

FilterChannel:has("_filterRules", {
	is = "rw"
})
FilterChannel:has("_owner", {
	is = "rw"
})

function FilterChannel:initialize(id, filterRules)
	super.initialize(self, id)

	self._type = ChannelType.kFilter
	self._filterRules = filterRules or {}
	self._channelsData = {}

	for channelId, state in pairs(self._filterRules) do
		self._channelsData[channelId] = {
			newMessageCnt = 0
		}
	end
end

function FilterChannel:addMessage(channelId, message)
	if self._filterRules[channelId] then
		local channelData = self._channelsData[channelId]

		channelData.newMessageCnt = channelData.newMessageCnt + 1
	end
end

function FilterChannel:refresh()
	self:sort()
	self:cutSize()
end

function FilterChannel:modifyFilterRule(key, value)
	for channelId, state in pairs(self._filterRules) do
		if channelId == key then
			self._filterRules[channelId] = value

			break
		end
	end
end

function FilterChannel:getNewMessageCnt()
	local newMessageCnt = 0

	for channelId, state in pairs(self._filterRules) do
		if state then
			newMessageCnt = newMessageCnt + self._channelsData[channelId].newMessageCnt
		end
	end

	return newMessageCnt
end

function FilterChannel:setNewMessageCnt(count)
	for channelId, channelData in pairs(self._channelsData) do
		channelData.newMessageCnt = 0
	end
end

function FilterChannel:getMessages()
	self._messages = {}

	for channelId, state in pairs(self._filterRules) do
		if state then
			local channel = self:getOwner():getChannel(channelId)

			if channel then
				local messages = channel:getMessages()

				for _, message in ipairs(messages) do
					self._messages[#self._messages + 1] = message
				end
			end
		end
	end

	self:refresh()

	return self._messages
end

function FilterChannel:getNewMessages()
	local newMessages = {}

	for channelId, state in pairs(self._filterRules) do
		if state then
			local newMessageCnt = self._channelsData[channelId].newMessageCnt

			if newMessageCnt > 0 then
				local channel = self:getOwner():getChannel(channelId)

				if channel then
					local messages = channel:getMessages()
					local messageCnt = #messages

					for i = messageCnt - newMessageCnt + 1, messageCnt do
						newMessages[#newMessages + 1] = messages[i]
					end
				end
			end
		end
	end

	if #newMessages > 1 then
		sortMessages(newMessages)
	end

	return newMessages
end

FlowChannel = class("FlowChannel", BaseChannel, _M)

function FlowChannel:initialize(id)
	super.initialize(self, id)

	self._type = ChannelType.kFlow
end

function FlowChannel:sort()
	table.sort(self._messages, function(a, b)
		local aPriority = a:getPriority()
		local bPriority = b:getPriority()

		if aPriority == bPriority then
			local aTime = a:getTime()
			local bTime = b:getTime()

			if aTime == bTime then
				local aId = a:getId()
				local bId = b:getId()

				if aId == nil then
					return false
				elseif bId == nil then
					return true
				else
					return aId < bId
				end
			else
				return aTime < bTime
			end
		else
			return aPriority < bPriority
		end
	end)
end
