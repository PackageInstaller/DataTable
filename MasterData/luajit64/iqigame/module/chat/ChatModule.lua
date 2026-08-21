-- chunkname: @IQIGame\\Module\\Chat\\ChatModule.lua

ChatModule = {
	CHANNEL_GUILD = 5,
	isFillerSys = false,
	CHANNEL_WORLD = 3,
	CHANNEL_SYSTEM = 1,
	CurrentChatRoomNum = 0,
	CurrentChannelIndex = 0,
	PrivateChat_TargetPanel = 2,
	CHANNEL_LOOP_SYSTEM = 2,
	PrivateChat_ListPanel = 1,
	CurrentChatRoomPlayerNum = 0,
	CHANNEL_PRIVATE_CHAT = 4,
	ChatMsgTable = {}
}

local ChatMsgData = require("IQIGame.Module.Chat.ChatMsgData")

function ChatModule.Reload(ChatRoomPOD, unlockChatEmojis)
	ChatModule.unlockChatEmojis = unlockChatEmojis

	for i, v in pairsCfg(CfgChatEmoticonTable) do
		if not v.IsLock then
			ChatModule.unlockChatEmojis[#ChatModule.unlockChatEmojis + 1] = v.Id
		end
	end

	ChatModule.CurrentChatRoomNum = ChatRoomPOD.roomNumber
	ChatModule.CurrentChatRoomPlayerNum = ChatRoomPOD.onlineCount
	ChatModule.ChatMsgTable = {}

	local chatPODTab = ChatRoomPOD.msg

	if PlayerModule.PlayerInfo.guildId ~= 0 and PlayerModule.PlayerInfo.guildChatCaches then
		for i, v in pairs(PlayerModule.PlayerInfo.guildChatCaches) do
			table.insert(chatPODTab, v)
		end

		table.sort(chatPODTab, function(a, b)
			return a.time < b.time
		end)
	end

	for i = 1, #chatPODTab do
		local chatData = ChatMsgData.New(chatPODTab[i])

		ChatModule.SetMsgData(chatData)
	end

	ChatModule.privateChatCount = 0
	ChatModule.chatInterval = CfgDiscreteDataTable[6520050].Data[1]
	ChatModule.chatLv = CfgDiscreteDataTable[6520050].Data[2]
	ChatModule.chatTxtTimes = CfgDiscreteDataTable[6520051].Data[1]
	ChatModule.chatDisableTime = CfgDiscreteDataTable[6520051].Data[2]
	ChatModule.chatLastTime = 0
	ChatModule.chatLastChatTxt = nil
	ChatModule.chatSameTxtCounter = 0

	ChatModule.SaveRecentlyPerson("")
	ChatBubbleModule.Reload()
end

function ChatModule.SetMsgData(msg)
	if ChatModule.ChatMsgTable[msg.channel] == nil then
		ChatModule.ChatMsgTable[msg.channel] = {}
	end

	if msg.channel == ChatModule.CHANNEL_PRIVATE_CHAT then
		local chatMstKey = ""

		if PlayerModule.PlayerInfo.baseInfo.pName == msg.sender.pName then
			chatMstKey = msg.sender.pName .. "|" .. msg.target
		elseif PlayerModule.PlayerInfo.baseInfo.pName == msg.target then
			chatMstKey = msg.target .. "|" .. msg.sender.pName
		end

		local channel = ChatModule.ChatMsgTable[msg.channel]

		if channel[chatMstKey] == nil then
			channel[chatMstKey] = {}
		end

		table.insert(channel[chatMstKey], msg)

		if #channel[chatMstKey] >= 200 then
			table.remove(ChatModule.ChatMsgTable, 0)
		end
	else
		if ChatModule.ChatMsgTable[ChatModule.CHANNEL_WORLD] == nil then
			ChatModule.ChatMsgTable[ChatModule.CHANNEL_WORLD] = {}
		end

		table.insert(ChatModule.ChatMsgTable[ChatModule.CHANNEL_WORLD], msg)

		if #ChatModule.ChatMsgTable[ChatModule.CHANNEL_WORLD] >= 200 then
			table.remove(ChatModule.ChatMsgTable[ChatModule.CHANNEL_WORLD], 0)
		end

		if msg.channel == ChatModule.CHANNEL_GUILD and msg.sender.guildId == PlayerModule.PlayerInfo.guildId then
			table.insert(ChatModule.ChatMsgTable[ChatModule.CHANNEL_GUILD], msg)

			if #ChatModule.ChatMsgTable[ChatModule.CHANNEL_GUILD] >= 200 then
				table.remove(ChatModule.ChatMsgTable[ChatModule.CHANNEL_GUILD], 0)
			end
		end
	end
end

function ChatModule.GetChatMsgByChannelType(channelType)
	if channelType == ChatModule.CHANNEL_SYSTEM then
		channelType = ChatModule.CHANNEL_WORLD
	end

	if ChatModule.isFillerSys then
		local l = ChatModule.ChatMsgTable[channelType]
		local newList = {}
		local index = 1

		for i, v in pairs(l) do
			if v.sender == nil then
				newList[index] = v
				index = index + 1
			end
		end

		return newList
	else
		return ChatModule.ChatMsgTable[channelType]
	end
end

function ChatModule.GetChatMsgByChannelTypeLen(channelType)
	if channelType == ChatModule.CHANNEL_SYSTEM then
		channelType = ChatModule.CHANNEL_WORLD
	end

	local l = ChatModule.ChatMsgTable[channelType]

	if l == nil then
		l = {}
	end

	if ChatModule.isFillerSys then
		local newList = {}
		local index = 1

		for i, v in pairs(l) do
			if v.sender == nil then
				newList[index] = v
				index = index + 1
			end
		end

		return #newList
	end

	if l == nil then
		return 0
	end

	return #l
end

function ChatModule.GetPrivateChatMsgByKey(targetName)
	local playerMsgList = {}
	local chatKey = PlayerModule.PlayerInfo.baseInfo.pName .. "|" .. targetName
	local channel = ChatModule.ChatMsgTable[ChatModule.CHANNEL_PRIVATE_CHAT]

	if channel ~= nil and channel[chatKey] ~= nil then
		playerMsgList = channel[chatKey]
	end

	return playerMsgList
end

function ChatModule.GetLastSystemMsg()
	local msgs = ChatModule.ChatMsgTable[ChatModule.CHANNEL_SYSTEM]
	local msg

	if msgs ~= nil and #msgs > 0 then
		msg = msgs[#msgs]
	end

	return msg
end

function ChatModule.ClearRoomMsg(channel)
	if ChatModule.ChatMsgTable[channel] ~= nil then
		ChatModule.ChatMsgTable[channel] = {}
	end
end

function ChatModule.ShowClientMessage(channel, content)
	local chatPOD = ChatMsgData.CreateClientChatPOD(channel, content)

	ChatModule.notifyChatMsg(chatPOD)
end

function ChatModule.IsHavePrivateChatNewMsg()
	local isHaveNewMsg = false
	local privateChatMsgTable = ChatModule.ChatMsgTable[ChatModule.CHANNEL_PRIVATE_CHAT]

	if privateChatMsgTable ~= nil then
		for key, value in pairs(privateChatMsgTable) do
			for i = 1, #value do
				isHaveNewMsg = ChatModule.IsPlayerHavePrivateChatNewMsg(value[i].sender.pName)

				if isHaveNewMsg == true then
					break
				end
			end
		end
	end

	return isHaveNewMsg
end

function ChatModule.IsPlayerHavePrivateChatNewMsg(playerName)
	local isHaveNewMsg = false
	local key = PlayerModule.PlayerInfo.baseInfo.pName .. "|" .. playerName

	if ChatModule.ChatMsgTable[ChatModule.CHANNEL_PRIVATE_CHAT] ~= nil and ChatModule.ChatMsgTable[ChatModule.CHANNEL_PRIVATE_CHAT][key] ~= nil then
		local playerMsgList = ChatModule.ChatMsgTable[ChatModule.CHANNEL_PRIVATE_CHAT][key]

		for i = 1, #playerMsgList do
			if playerMsgList[i].isRead == false then
				isHaveNewMsg = true

				break
			end
		end
	end

	return isHaveNewMsg
end

function ChatModule.HasSetInPrivateChatPlayer()
	local isSetIn = false
	local playerListStr = ChatModule.GetRecentlyPerson()

	if playerListStr ~= "" then
		isSetIn = true
	end

	return isSetIn
end

function ChatModule.HasSetInByPlayerId(playerPid)
	local isSetIn = false
	local playerListStr = ChatModule.GetRecentlyPerson()

	if playerListStr ~= "" then
		local playerList = string.split(playerListStr, "|")

		for i = 1, #playerList do
			local playerData = string.split(playerList[i], ",")

			if playerData[1] == playerPid then
				isSetIn = true

				break
			end
		end
	end

	return isSetIn
end

function ChatModule.GetRecentlyPerson()
	local playerListStr = ""

	if PlayerModule.PlayerInfo.baseInfo.pid == nil then
		return playerListStr
	end

	return PlayerPrefsUtil.GetString(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.PrivateChat_key)
end

function ChatModule.SaveRecentlyPerson(playerListStr)
	PlayerPrefsUtil.SetString(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.PrivateChat_key, playerListStr)
end

function ChatModule.SetPlayerIn(PlayerData)
	local playerListStr = ChatModule.GetRecentlyPerson()

	if playerListStr == nil then
		playerListStr = ""
	end

	local friendData = FriendModule.GetFriendByPId(PlayerData.pid)
	local playerStr = PlayerData.pid .. "," .. PlayerData.pName .. "," .. PlayerData.headIcon .. "," .. PlayerData.vip .. "," .. PlayerData.pLv .. "," .. PlayerData.serverId

	if friendData ~= nil then
		playerStr = playerStr .. "," .. friendData.remark .. "," .. friendData.avatarFrame
	else
		playerStr = playerStr .. "," .. "" .. "," .. PlayerData.avatarFrame
	end

	if playerListStr ~= "" then
		local isExisted = false
		local newPlayerListStr = ""
		local playerList = string.split(playerListStr, "|")

		for i, v in ipairs(playerList) do
			local playerData = string.split(v, ",")

			if playerData[1] == PlayerData.pid then
				if newPlayerListStr == "" then
					newPlayerListStr = playerStr
				else
					newPlayerListStr = newPlayerListStr .. "|" .. playerStr
				end

				isExisted = true
			elseif newPlayerListStr == "" then
				newPlayerListStr = v
			else
				newPlayerListStr = newPlayerListStr .. "|" .. v
			end
		end

		if isExisted then
			playerListStr = newPlayerListStr
		else
			playerListStr = newPlayerListStr .. "|" .. playerStr
		end
	else
		playerListStr = playerStr
	end

	ChatModule.SaveRecentlyPerson(playerListStr)
end

function ChatModule.DeletePlayer(pid)
	local playerListStr = ChatModule.GetRecentlyPerson()
	local newListStr = ""

	if playerListStr ~= "" then
		local playerList = string.split(playerListStr, "|")

		for i = 1, #playerList do
			local playerData = string.split(playerList[i], ",")

			if playerData[1] ~= pid then
				if newListStr == "" then
					newListStr = playerList[i]
				else
					newListStr = newListStr .. "|" .. playerList[i]
				end
			end
		end
	end

	ChatModule.SaveRecentlyPerson(newListStr)
end

function ChatModule.GetPlayerListIn()
	local playerDataList = {}
	local playerListStr = ChatModule.GetRecentlyPerson()

	if playerListStr ~= "" and playerListStr ~= nil then
		local playerList = string.split(playerListStr, "|")

		for i = 1, #playerList do
			local data = string.split(playerList[i], ",")
			local playerData = {}

			playerData.pId = data[1]
			playerData.pName = data[2]
			playerData.headIcon = data[3]
			playerData.vip = data[4]
			playerData.pLv = data[5]
			playerData.serverId = data[6]
			playerData.avatarFrame = data[8]

			if #data == 6 then
				playerData.remark = ""
			elseif #data == 7 then
				playerData.remark = data[7]
			end

			if playerData.pId ~= PlayerModule.PlayerInfo.baseInfo.pid then
				table.insert(playerDataList, playerData)
			end
		end
	end

	return playerDataList
end

function ChatModule.CheckIsNeedShowTime(chatMsgData)
	local playerMsgList = {}

	if chatMsgData.channel == ChatModule.CHANNEL_PRIVATE_CHAT then
		if ChatModule.ChatMsgTable[ChatModule.CHANNEL_PRIVATE_CHAT] ~= nil then
			local chatKey = ""

			if PlayerModule.PlayerInfo.baseInfo.pName == chatMsgData.sender.pName then
				chatKey = chatMsgData.sender.pName .. "|" .. chatMsgData.target
			elseif PlayerModule.PlayerInfo.baseInfo.pName == chatMsgData.target then
				chatKey = chatMsgData.target .. "|" .. chatMsgData.sender.pName
			end

			if ChatModule.ChatMsgTable[ChatModule.CHANNEL_PRIVATE_CHAT][chatKey] ~= nil then
				playerMsgList = ChatModule.ChatMsgTable[ChatModule.CHANNEL_PRIVATE_CHAT][chatKey]
			end

			if #playerMsgList > 0 then
				if chatMsgData.time - playerMsgList[#playerMsgList].time > 300 then
					chatMsgData.isNeedShowTime = true
				end
			else
				chatMsgData.isNeedShowTime = true
			end
		else
			chatMsgData.isNeedShowTime = true
		end
	elseif ChatModule.ChatMsgTable[chatMsgData.channel] ~= nil then
		playerMsgList = ChatModule.ChatMsgTable[chatMsgData.channel]

		if #playerMsgList > 0 then
			if chatMsgData.time - playerMsgList[#playerMsgList].time > 300 then
				chatMsgData.isNeedShowTime = true
			end
		else
			chatMsgData.isNeedShowTime = true
		end
	else
		chatMsgData.isNeedShowTime = true
	end
end

function ChatModule.SaveEmoGroupSortDatum(cfgGroupDatum)
	if #cfgGroupDatum == 0 then
		return
	end

	local ret = tostring(cfgGroupDatum[1].Id)

	for i = 2, #cfgGroupDatum do
		ret = ret .. "|" .. tostring(cfgGroupDatum[i].Id)
	end

	PlayerPrefsUtil.SetString(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.ChatEmoGroup, ret)
end

function ChatModule.GetEmoGroupSortDatum()
	local ret = {}
	local saveStr = PlayerPrefsUtil.GetString(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.ChatEmoGroup)
	local unlockGroupID2CfgDataDic = ChatModule.GetUnlockEmoGroupID2CfgDataDic()

	if saveStr == "" or saveStr == nil then
		for i, v in pairs(unlockGroupID2CfgDataDic) do
			ret[#ret + 1] = v
		end

		table.sort(ret, function(a, b)
			return a.Id < b.Id
		end)
	else
		local strArr = string.split(saveStr, "|")
		local sortIDDic = {}

		for i, v in ipairs(strArr) do
			local id = tonumber(v)

			ret[#ret + 1] = CfgChatEmoticonGroupTable[id]
			sortIDDic[id] = id
		end

		local otherUnlockGroupID2CfgDatum = {}

		for i, v in pairs(unlockGroupID2CfgDataDic) do
			if sortIDDic[v.Id] == nil then
				otherUnlockGroupID2CfgDatum[#otherUnlockGroupID2CfgDatum + 1] = v
			end
		end

		table.sort(otherUnlockGroupID2CfgDatum, function(a, b)
			return a.Id < b.Id
		end)

		for i, v in ipairs(otherUnlockGroupID2CfgDatum) do
			ret[#ret + 1] = v
		end
	end

	return ret
end

function ChatModule.GetEmoGroupDefaultDatum()
	local ret = {}
	local unlockGroupID2CfgDataDic = ChatModule.GetUnlockEmoGroupID2CfgDataDic()

	for i, v in pairs(unlockGroupID2CfgDataDic) do
		ret[#ret + 1] = v
	end

	table.sort(ret, function(a, b)
		return a.Id < b.Id
	end)

	return ret
end

function ChatModule.GetUnlockEmoGroupID2CfgDataDic()
	local ret = {}

	for i, v in pairs(ChatModule.unlockChatEmojis) do
		local cfgEmoData = CfgChatEmoticonTable[v]

		ret[cfgEmoData.Group] = CfgChatEmoticonGroupTable[cfgEmoData.Group]
	end

	return ret
end

function ChatModule.SaveNormalEmoDatum(cfgEmoDatum)
	if #cfgEmoDatum == 0 then
		return
	end

	local cfgEmoDatum10 = {}

	for i = #cfgEmoDatum, 1, -1 do
		if #cfgEmoDatum10 == 10 then
			break
		end

		table.insert(cfgEmoDatum10, 1, cfgEmoDatum[i])
	end

	local ret = tostring(cfgEmoDatum10[1].Id)

	for i = 2, #cfgEmoDatum10 do
		ret = ret .. "|" .. tostring(cfgEmoDatum10[i].Id)
	end

	PlayerPrefsUtil.SetString(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.ChatNormalEmo, ret)
end

function ChatModule.GetNormalEmoDatum()
	local ret = {}
	local saveStr = PlayerPrefsUtil.GetString(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.ChatNormalEmo)

	if saveStr ~= "" and saveStr ~= nil then
		local strArr = string.split(saveStr, "|")

		for i, v in ipairs(strArr) do
			local id = tonumber(v)

			ret[#ret + 1] = CfgChatEmoticonTable[id]
		end
	end

	return ret
end

function ChatModule.CheckEmoIsUnlock(cid)
	for i, v in pairs(ChatModule.unlockChatEmojis) do
		if v == cid then
			return true
		end
	end

	return false
end

function ChatModule.SendMsg(CChatPOD, pid, ignoreTextLengthLimit)
	if CChatPOD.channel == ChatModule.CHANNEL_GUILD and PlayerModule.PlayerInfo.guildId == 0 then
		return
	end

	local maxLen = ignoreTextLengthLimit and Constant.Number.IntMaxValue or 60
	local width = ChatModule.WidthSingle(CChatPOD.content)

	if maxLen <= width then
		local startIndex, endIndex = string.find(CChatPOD.content, "(audio)")

		if startIndex == 3 and endIndex == 7 then
			-- block empty
		else
			local len = ChatModule.GetSubLen(CChatPOD.content, maxLen)

			CChatPOD.content = ChatModule.SubUTF8String(CChatPOD.content, len)
		end
	end

	ChatModule.isInChatDisable = false

	if string.find(CChatPOD.content, "/cmd OpenGuide ") then
		local id = string.sub(CChatPOD.content, 16, string.len(CChatPOD.content))

		GuideModule.CmdOpenGuide(tonumber(id))
	elseif string.find(CChatPOD.content, "/gm open") then
		SettingModule.SaveHarmoniousResources(1)
	elseif string.find(CChatPOD.content, "/gm close") then
		SettingModule.SaveHarmoniousResources(0)
	elseif string.find(CChatPOD.content, "/gm test") then
		SettingModule.SaveOpenDrawCard(1)
	elseif string.find(CChatPOD.content, "/gm normal") then
		SettingModule.SaveOpenDrawCard(0)
	elseif string.find(CChatPOD.content, "/cmd TestChat") then
		local content = string.sub(CChatPOD.content, 15, string.len(CChatPOD.content))

		CChatPOD.content = content .. "1"

		net_centerChat.sendChat(CChatPOD)

		CChatPOD.content = content .. "2"

		net_centerChat.sendChat(CChatPOD)

		CChatPOD.content = content .. "3"

		net_centerChat.sendChat(CChatPOD)

		CChatPOD.content = content .. "4"

		net_centerChat.sendChat(CChatPOD)

		CChatPOD.content = content .. "5"

		net_centerChat.sendChat(CChatPOD)
	elseif string.find(CChatPOD.content, "/cmd ClearGuide") then
		local id = string.sub(CChatPOD.content, 17, string.len(CChatPOD.content))

		GuideModule.finishGuide[id] = -1

		net_player.triggerGuide(id, -1, 3)
	elseif string.find(CChatPOD.content, "/cmd gc") then
		LuaCodeInterface.GC()
		LuaCodeInterface.LuaGC()
	elseif string.find(CChatPOD.content, "/cmd gc cs") then
		LuaCodeInterface.GC()
	elseif string.find(CChatPOD.content, "/cmd gc lua") then
		LuaCodeInterface.LuaGC()
	elseif string.find(CChatPOD.content, "/cmd printplayerparams") then
		warning("printplayerparams->" .. tableToString(PlayerModule.PlayerInfo.playerParams))
	elseif string.find(CChatPOD.content, "/cmd showcustomdebugui") then
		UIModule.Open(Constant.UIControllerName.CustomDebugUI, Constant.UILayer.UI)
	elseif string.find(CChatPOD.content, "/cmd") then
		net_centerChat.sendChat(CChatPOD)
	else
		if pid ~= nil then
			local friendData = FriendModule.GetFriendByPId(pid)

			if friendData ~= nil and friendData.online == false then
				NoticeModule.ShowNoticeNoCallback(21040068)

				return
			end
		end

		if PlayerModule.PlayerInfo.baseInfo.pLv < ChatModule.chatLv then
			NoticeModule.ShowNoticeNoCallback(21045019, tostring(ChatModule.chatLv))

			return
		end

		local serverTimeS = math.floor(PlayerModule.GetServerTime())

		if ChatModule.chatSameTxtCounter >= ChatModule.chatTxtTimes then
			if serverTimeS - ChatModule.chatLastTime > ChatModule.chatDisableTime then
				ChatModule.chatSameTxtCounter = 0
				ChatModule.chatLastChatTxt = nil
			else
				ChatModule.isInChatDisable = true

				NoticeModule.ShowNoticeNoCallback(21045020, tostring(ChatModule.chatLastTime + ChatModule.chatDisableTime - serverTimeS))

				return
			end
		end

		if serverTimeS - ChatModule.chatLastTime < ChatModule.chatInterval then
			ChatModule.isInChatDisable = true

			NoticeModule.ShowNoticeNoCallback(21045018, tostring(ChatModule.chatLastTime + ChatModule.chatInterval - serverTimeS))

			return
		end

		if ChatModule.chatLastChatTxt == CChatPOD.content then
			ChatModule.chatSameTxtCounter = ChatModule.chatSameTxtCounter + 1
		else
			ChatModule.chatSameTxtCounter = 1
		end

		ChatModule.chatLastChatTxt = CChatPOD.content
		ChatModule.chatLastTime = serverTimeS

		net_centerChat.sendChat(CChatPOD)
	end
end

function ChatModule.WidthSingle(inputstr)
	local lenInByte = #inputstr
	local width = 0
	local i = 1

	while i <= lenInByte do
		local curByte = string.byte(inputstr, i)
		local byteCount = 1

		if curByte > 0 and curByte <= 127 then
			byteCount = 1
		elseif curByte >= 192 and curByte < 223 then
			byteCount = 2
		elseif curByte >= 224 and curByte < 239 then
			byteCount = 3
		elseif curByte >= 240 and curByte <= 247 then
			byteCount = 4
		end

		i = i + byteCount
		width = width + 1
	end

	return width
end

function ChatModule.GetSubLen(inputstr, maxLen)
	local lenInByte = #inputstr
	local width = 0
	local i = 1
	local z = 1

	while i <= lenInByte do
		local curByte = string.byte(inputstr, i)
		local byteCount = 1

		if curByte > 0 and curByte <= 127 then
			byteCount = 1
		elseif curByte >= 192 and curByte < 223 then
			byteCount = 2
		elseif curByte >= 224 and curByte < 239 then
			byteCount = 3
		elseif curByte >= 240 and curByte <= 247 then
			byteCount = 4
		end

		z = z + 1
		i = i + byteCount
		width = width + byteCount

		if maxLen <= z then
			break
		end
	end

	return width
end

function ChatModule.SubUTF8String(s, n)
	local dropping = string.byte(s, n + 1)

	if not dropping then
		return s
	end

	if dropping >= 128 and dropping < 192 then
		return ChatModule.SubUTF8String(s, n - 1)
	end

	return string.sub(s, 1, n)
end

function ChatModule.ChangeRoom(roomId)
	net_centerChat.switchRoom(roomId)
end

function ChatModule.notifyChatRoom(chatRoom)
	if not PlayerModule.InGame then
		return
	end

	PlayerModule.PlayerInfo.chatRoom = chatRoom
	ChatModule.CurrentChatRoomNum = chatRoom.roomNumber
	ChatModule.CurrentChatRoomPlayerNum = chatRoom.onlineCount

	EventDispatcher.Dispatch(EventID.ChatRoomUpdate, chatRoom)
end

function ChatModule.notifyChatMsg(chat)
	if not PlayerModule.InGame then
		return
	end

	if chat.sender ~= nil then
		if chat.sender.guildId == PlayerModule.PlayerInfo.guildId then
			if PlayerModule.PlayerInfo.guildChatCaches == nil then
				PlayerModule.PlayerInfo.guildChatCaches = {}
			end

			table.insert(PlayerModule.PlayerInfo.guildChatCaches, chat)
		end

		local friendData = FriendModule.GetFriendByPId(chat.sender.pid)

		if friendData ~= nil and friendData.type == Constant.FriendType.TYPE_MUTE then
			return
		end
	end

	local chatData = ChatMsgData.New(chat)

	if chatData.channel == ChatModule.CHANNEL_LOOP_SYSTEM then
		NoticeModule.ShowNoticeByType(2, chatData.content)
	end

	ChatModule.CheckIsNeedShowTime(chatData)
	ChatModule.SetMsgData(chatData)

	if chat.sender ~= nil and chat.channel == ChatModule.CHANNEL_PRIVATE_CHAT then
		ChatModule.SetPlayerIn(chat.sender)

		if not UIModule.HasUI(Constant.UIControllerName.ChatUI) then
			local friendData = FriendModule.GetFriendByPId(chat.sender.pid)

			if friendData ~= nil then
				ChatModule.privateChatCount = ChatModule.privateChatCount + 1

				if ChatModule.privateChatCount == 1 then
					GameEntry.LuaEvent:Fire(nil, L2DJumpToStateEventArgs():Fill(Constant.L2D_CustomStateName.PrivateChat))
				end

				if ChatModule.privateChatCount >= CfgDiscreteDataTable[6520042].Data[1] then
					ChatModule.privateChatCount = 0

					GameEntry.LuaEvent:Fire(nil, L2DJumpToStateEventArgs():Fill(Constant.L2D_CustomStateName.PrivateChat))
				end
			end
		end
	end

	EventDispatcher.Dispatch(EventID.ResponseChatMsg, chatData)

	if chat.channel == ChatModule.CHANNEL_PRIVATE_CHAT then
		EventDispatcher.Dispatch(EventID.NoticeNewPrivateChatMsg)
	end
end

function ChatModule.ResponseChangeRoomMsg(chatRoom)
	PlayerModule.PlayerInfo.chatRoom = chatRoom

	ChatModule.ClearRoomMsg(ChatModule.CHANNEL_WORLD)

	ChatModule.CurrentChatRoomNum = chatRoom.roomNumber
	ChatModule.CurrentChatRoomPlayerNum = chatRoom.onlineCount

	ChatModule.ClearRoomMsg(ChatModule.CHANNEL_GUILD)

	local chatPODTab = chatRoom.msg

	if PlayerModule.PlayerInfo.guildId ~= 0 and PlayerModule.PlayerInfo.guildChatCaches then
		for i, v in pairs(PlayerModule.PlayerInfo.guildChatCaches) do
			if v.channel == ChatModule.CHANNEL_GUILD then
				table.insert(chatPODTab, v)
			end
		end

		table.sort(chatPODTab, function(a, b)
			return a.time < b.time
		end)
	end

	for i = 1, #chatPODTab do
		local chatData = ChatMsgData.New(chatPODTab[i])

		ChatModule.SetMsgData(chatData)
	end

	EventDispatcher.Dispatch(EventID.ChangeRoomSuccess, chatRoom)
end

function ChatModule.ReqReportPlayer(pid, type, text, reason, remark)
	net_centerChat.reportPlayer(pid, type, text, reason, remark)
end

function ChatModule.OnReqReportPlayer()
	NoticeModule.ShowNoticeNoCallback(21045021)
	UIModule.Close(Constant.UIControllerName.PlayerAccusationUI)
end

function ChatModule.UpdateChatEmojiUnlock(cid)
	if ChatModule.unlockChatEmojis == nil then
		ChatModule.unlockChatEmojis = {}
	end

	local exist = false

	for i, v in pairs(ChatModule.unlockChatEmojis) do
		if v == cid then
			exist = true

			break
		end
	end

	if not exist then
		ChatModule.unlockChatEmojis[#ChatModule.unlockChatEmojis + 1] = cid
	end
end
