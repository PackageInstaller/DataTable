-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/chat/ChatSystem.lua

EVT_CHAT_NEW_MESSAGE = "EVT_CHAT_NEW_MESSAGE"
EVT_CHAT_NEW_PRIVATEMESSAGE = "EVT_CHAT_NEW_PRIVATEMESSAGE"
EVT_CHAT_SEND_MESSAGE_SUCC = "EVT_CHAT_SEND_MESSAGE_SUCC"
EVT_CHAT_REMOVE_MESSAGE_SUCC = "EVT_CHAT_REMOVE_MESSAGE_SUCC"
EVT_CHAT_SHIELD_MESSAGE_SUCC = "EVT_CHAT_SHIELD_MESSAGE_SUCC"
EVT_CHANGECHATBUBBLE_SUCC = "EVT_CHANGECHATBUBBLE_SUCC"
EVT_CHAT_MESSAGE_REFRESH = "EVT_CHAT_MESSAGE_REFRESH"
EVT_CHAT_HISTORY_MESSAGE = "EVT_CHAT_HISTORY_MESSAGE"
ChatSystem = class("ChatSystem", Facade, _M)

ChatSystem:has("_service", {
	is = "r"
}):injectWith("ChatService")
ChatSystem:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ChatSystem:has("_friendSystem", {
	is = "r"
}):injectWith("FriendSystem")
ChatSystem:has("_wordPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")
ChatSystem:has("_chat", {
	is = "r"
})
ChatSystem:has("_isOnlyShowSelf", {
	is = "rwb"
})
ChatSystem:has("_shieldList", {
	is = "rw"
})
ChatSystem:has("_shieldFriendList", {
	is = "rw"
})

function ChatSystem:initialize()
	super.initialize(self)

	self._isOnlyShowSelf = false
	self._shieldList = {}
	self._shieldFriendList = {}

	self:getEmotionData()
end

function ChatSystem:userInject(injector)
	self:initSystem()
end

function ChatSystem:initChannels()
	for _, channelId in pairs(ChannelId) do
		self._chat:createChannel(channelId)
	end
end

function ChatSystem:initSystem()
	self._chat = Chat:new()

	self:listenPushMessage()
	self:requestGetBlockList()
	self:initChannels()

	local roomTypes

	self:requestHistory(self:isWordPeaceChatActive() and {
		ChatRoomType.kWorld,
		ChatRoomType.kUnion,
		ChatRoomType.kPrivate,
		ChatRoomType.kChatRoom
	} or {
		ChatRoomType.kWorld,
		ChatRoomType.kUnion,
		ChatRoomType.kPrivate
	}, true)
end

function ChatSystem:tryEnter(data)
	local view = self:getInjector():getInstance("chatMainView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data))
end

function ChatSystem:updateActiveMember()
	local player = self:getDevelopSystem():getPlayer()
	local activeMembers = self._chat:getActiveMembers()
	local rid = player:getRid()
	local clubSystem = self:getInjector():getInstance(ClubSystem)
	local masterId = self:getDevelopSystem():getTeamByType(StageTeamType.STAGE_NORMAL):getMasterId()
	local masterSystem = self:getDevelopSystem():getMasterSystem()
	local id, level = masterSystem:getMasterLeadStatgeLevel(masterId)
	local var_6_0 = {
		id = rid,
		nickname = player:getNickName(),
		level = player:getLevel(),
		vipLevel = player:getVipLevel(),
		slogan = player:getSlogan()
	}

	var_6_0.combat = self:getDevelopSystem():getTeamByType(StageTeamType.STAGE_NORMAL):getCombat()
	var_6_0.headImg = player:getHeadId()
	var_6_0.clubName = clubSystem:getName()
	var_6_0.heroes = self:getHeroes()
	var_6_0.master = {
		masterId
	}
	var_6_0.gender = player:getGender()
	var_6_0.city = player:getCity()
	var_6_0.birthday = player:getBirthday()
	var_6_0.tags = player:getTags()
	var_6_0.headFrame = player:getCurHeadFrame()
	var_6_0.leadStageId = id
	var_6_0.leadStageLevel = level
	var_6_0.chatBubble = player:getCurChatBubbleId()
	var_6_0.title = player:getCurTitleId()
	activeMembers[rid] = var_6_0
end

function ChatSystem:getHeroes(...)
	local heroes = {}
	local teamHeroes = self._developSystem:getTeamByType(StageTeamType.STAGE_NORMAL):getHeroes()
	local heroSystem = self._developSystem:getHeroSystem()

	for i = 1, #teamHeroes do
		local hero = heroSystem:getHeroById(teamHeroes[i])

		if hero then
			local data = {}

			data[1] = hero:getId()
			data[2] = hero:getLevel()
			data[3] = hero:getStar()
			data[4] = hero:getQuality()
			data[5] = hero:getRarity()
			heroes[#heroes + 1] = data
		end
	end

	return heroes
end

function ChatSystem:isMySend(message)
	local messageType = message:getType()

	if messageType == MessageType.kPlayer then
		local player = self:getDevelopSystem():getPlayer()

		return message:getSenderId() == player:getRid()
	end

	return false
end

function ChatSystem:isWordPeaceChatActive()
	local battlefeildId = self._wordPeaceSystem:getWorldPeace():getBattleFieldId()
	local isMatch = self._wordPeaceSystem:getWorldPeace():getMatchGroupChat()

	isMatch = isMatch and #isMatch > 0

	if battlefeildId and battlefeildId ~= "" and self._wordPeaceSystem:getStatus() ~= WPStatus.kApply and isMatch then
		return true
	end

	return false
end

function ChatSystem:getWordPeaceCampIndex()
	return self._wordPeaceSystem:getOwnCamp()
end

function ChatSystem:syncTrans(event)
	if event and event:getData() then
		local errorCode = event:getData().errorCode
		local message = event:getData().message

		if errorCode == "transFailure" then
			local msg = self._chat:getTransMsg()

			msg.message:setTranState(MessageTransStatus.kFailed)
			self:getEventDispatcher():dispatchEvent(Event:new(EVT_CHAT_MESSAGE_REFRESH, msg))
		elseif errorCode == "transSuccess" then
			local msg = self._chat:getTransMsg()

			msg.message:setTranState(MessageTransStatus.kSuccess)
			msg.message:setTranStr(message.eventValues)
			self:getEventDispatcher():dispatchEvent(Event:new(EVT_CHAT_MESSAGE_REFRESH, msg))
		end
	end
end

function ChatSystem:requestHistory(roomTypes, notShowWaiting, callback)
	local params = {
		channels = roomTypes
	}

	self:getService():requestHistory(params, function(response)
		if response.resCode == GS_SUCCESS then
			self._chat:syncHistory(response.data)

			if callback then
				callback()
			end
		end
	end, notShowWaiting)
end

function ChatSystem:getHistoryByChannel(channelId)
	local retMessages = self._chat:getChannel(channelId):getMessages()

	self:getEventDispatcher():dispatchEvent(Event:new(EVT_CHAT_HISTORY_MESSAGE, {
		message = retMessages
	}))
end

function ChatSystem:requestSendMessage(roomType, roomId, message, callback)
	local params = {
		channel = roomType,
		groupId = roomId,
		content = message
	}

	self:getService():requestSendMessage(params, function(response)
		if response.resCode == GS_SUCCESS then
			local playerData = response.data.playerInfo

			if playerData then
				self._chat:syncActiveMembers(playerData)
			end

			if callback then
				callback(response.data)
			end

			self:dispatch(Event:new(EVT_CHAT_SEND_MESSAGE_SUCC, {
				message = message
			}))
			self:dispatch(Event:new(EVT_REDPOINT_REFRESH))
		end
	end, true)
end

function ChatSystem:requestReadMessage(roomType, roomId, messageId, callback)
	local params = {
		channel = roomType,
		groupId = roomId,
		msgId = messageId
	}

	self:getService():requestReadMessage(params, function(response)
		if response.resCode == GS_SUCCESS then
			self._chat:syncReadMessageId(roomType, roomId, messageId)
			self:dispatch(Event:new(EVT_REDPOINT_REFRESH))

			if callback then
				callback()
			end
		end
	end, true)
end

function ChatSystem:listenPushMessage()
	self:getService():listenPushMessage(function(response)
		if response then
			if response.playerInfo then
				local senderData = response.playerInfo
				local data = {}

				data[senderData.id] = senderData

				self._chat:syncActiveMembers(data)
			end

			if response.configId == "Announce_Club_Join" then
				local roleId = response.params.rid
				local player = self:getInjector():getInstance(DevelopSystem):getPlayer()

				if player:getRid() == roleId then
					self:dispatch(Event:new(EVT_HOMEVIEW_REDPOINT_REF, {
						showRedPoint = 1,
						type = 4
					}))
				end
			end

			if response.configId == "Announce_Club_JobChange1" then
				self:dispatch(Event:new(EVT_CLUB_PUSHPOSITIONCHANGE_SUCC))
			end

			local message = self._chat:syncMessage(response)

			if not message then
				return
			end

			local channelIds = message:getChannelIds()

			for _, v in pairs(channelIds) do
				local strs = string.split(v, "-")
				local channelType = strs[1]

				if channelType == ChannelType.kPrivate then
					self:dispatch(Event:new(EVT_CHAT_NEW_PRIVATEMESSAGE, {
						message = message,
						channelId = v
					}))

					break
				end
			end

			self:dispatch(Event:new(EVT_CHAT_NEW_MESSAGE, {
				message = message
			}))
		end
	end)
end

function ChatSystem:requestBlockUser(block, unblock, callback)
	local params = {
		block = block,
		unblock = unblock
	}

	self:getService():requestBlockUser(params, function(response)
		if response.resCode == GS_SUCCESS then
			if response.data then
				self._shieldList = response.data.blockList or {}
				self._shieldFriendList = response.data.friendBlockList or {}
			end

			if callback then
				callback(response.data)
			end

			self:dispatch(Event:new(EVT_CHAT_SHIELD_MESSAGE_SUCC, {
				data = response.data
			}))
		end
	end, true)
end

function ChatSystem:getShieldList()
	local list = {}

	for key, value in pairs(self._shieldList) do
		list[#list + 1] = value
	end

	return list
end

function ChatSystem:getBlockUserStatus(senderId)
	return self._shieldList[senderId]
end

function ChatSystem:getBlockUserFriendStatus(senderId)
	return table.indexof(self._shieldFriendList, senderId)
end

function ChatSystem:requestGetBlockList()
	local params = {}

	self:getService():requestGetBlockList(params, function(response)
		if response.resCode == GS_SUCCESS and response.data then
			self._shieldList = response.data.blockList or {}
			self._shieldFriendList = response.data.friendBlockList or {}
		end
	end, true)
end

function ChatSystem:getEmotionData()
	self._emotionData = self._emotionData or ConfigReader:getDataTable("ChatEmoji")

	return self._emotionData
end

function ChatSystem:getEmotionList()
	local list = {}

	for Id, data in pairs(self._emotionData) do
		list[data.Type] = list[data.Type] or {}
		list[data.Type][#list[data.Type] + 1] = data
	end

	for Id, data in pairs(list) do
		table.sort(data, function(a, b)
			return a.Sort < b.Sort
		end)
	end

	return list
end

function ChatSystem:getEmotionDataById(id)
	return self._emotionData[id]
end

function ChatSystem:requestRemoveMessage(channelId, playerId, callback)
	local params = {
		friendRid = playerId
	}

	self:getService():requestRemoveMessage(params, function(response)
		if response.resCode == GS_SUCCESS then
			self._chat:delMessage(channelId)

			if callback then
				callback(response.data)
			end

			self:dispatch(Event:new(EVT_CHAT_REMOVE_MESSAGE_SUCC, {
				channelId = channelId,
				playerId = playerId
			}))
		end
	end, true)
end

function ChatSystem:requestChangeBubble(id)
	local params = {
		id = id
	}

	self:getService():requestChangeBubble(params, function(response)
		if response.resCode == GS_SUCCESS then
			self:updateActiveMember()
			self:dispatch(Event:new(EVT_CHANGECHATBUBBLE_SUCC))
		end
	end, false)
end

function ChatSystem:getShowBubbleList()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local db = ConfigReader:getDataTable("ChatBubble")
	local player = developSystem:getPlayer()
	local bubbles = player:getChatBubble()
	local list = {}

	for k, v in pairs(db) do
		if (v.Unlook == 0 and bubbles[k] == nil or nil) and false then
			local data = {}

			data.id = k
			data.config = v
			data.unlock = bubbles[k] and 1 or 0
			list[#list + 1] = data

			if bubbles[k] then
				data.getTime = bubbles[k]

				self:setLimitBubbleData(k, data)

				data.unlock = data.isLimit and data.isExpire and 0 or 1
			end
		end
	end

	table.sort(list, function(a, b)
		if a.unlock == b.unlock then
			return a.config.Sort < b.config.Sort
		else
			return a.unlock > b.unlock
		end
	end)

	return list
end

function ChatSystem:checkBubbleExpire(id, data)
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local player = developSystem:getPlayer()
	local bubbles = player:getChatBubble()

	data = data or {}
	data.isExpire = false

	local getDate = bubbles[id]
	local config = ConfigReader:getRecordById("ChatBubble", id)

	if config.CondiType == "TIME" then
		data.isLimit = true

		local gameServerAgent = self:getInjector():getInstance(GameServerAgent)
		local curTime = gameServerAgent:remoteTimeMillis()

		data.expireTime = getDate + config.TypeNum.time * 3600 * 1000

		if curTime > data.expireTime then
			data.isExpire = true
		end
	end

	if config.CondiType == "RTPK" then
		data.isLimit = true

		local rtpk = self:getInjector():getInstance(RTPKSystem):getRtpk()
		local rank = rtpk:getHistoryRank()

		if rank < config.TypeNum.value[1] or rank > config.TypeNum.value[2] then
			data.isExpire = true
		end
	end

	if config.CondiType == "StageArena" then
		data.isLimit = true

		local leadStageArena = self:getInjector():getInstance(LeadStageArenaSystem):getLeadStageArena()
		local rank = leadStageArena:getHistoryRank()

		if rank < config.TypeNum.value[1] or rank > config.TypeNum.value[2] then
			data.isExpire = true
		end
	end

	local settingSystem = self:getInjector():getInstance(SettingSystem)
	local actFrameInfo = settingSystem:getSettingModel():getActFrameInfo()
	local value = actFrameInfo[config.CondiType]

	if value then
		data.isLimit = true

		if value < config.TypeNum.value[1] or value > config.TypeNum.value[2] then
			data.isExpire = true
		end
	end

	return data
end

function ChatSystem:setLimitBubbleData(id, data)
	data.isLimit = false

	self:checkBubbleExpire(id, data)
end
