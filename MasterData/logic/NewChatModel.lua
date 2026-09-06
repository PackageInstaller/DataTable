-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/model/NewChatModel.lua

module("logic.extensions.chat.model.NewChatModel", package.seeall)

local NewChatModel = class("NewChatModel", BaseModel)
local json = require("cjson")
local TimestampOffset = 300
local LocalStorageKeyOfPrivateChat = "PrivateChat"
local PetStepSecToSave = 1
local DelaySecToSave = 10

function NewChatModel:ctor()
	self._msgs = {}
	self._mainUIMsgs = {}
	self._redPoints = {}
end

function NewChatModel:onInit()
	self:onReset()
end

function NewChatModel:onReset()
	self:stopCountDownToSaveChat()

	self._maskChatOpen = false
	self._isPrivateChatUpdate = false
	self._msgs = {}
	self._mainUIMsgs = {}

	local t = {}

	for i = 1, 1 do
		local msg = {}

		msg.msgId = -9999999 + i
		msg.senderId = 0
		msg.headInfo = {}
		msg.headInfo.userName = ""
		msg.msgType = 999
		msg.channelType = GameEnum.ChatChannel.System
		msg.content = "欢迎来到奥奇世界，请开始愉快聊天吧！"
		msg.sendTime = ServerTime.now() * 1000

		table.insert(t, msg)
	end

	self:OnNotifyNewMsg(t)
	GlobalDispatcher:addListener(GlobalNotify.ApplicationPause, self._save, self)
	GlobalDispatcher:addListener(GlobalNotify.ApplicationQuit, self._save, self)
	GlobalDispatcher:addListener(GlobalNotify.FriendInfoGeted, self._loadPrivate, self)

	self._redPoints = {}
	self._usedWorldChatFreeTimes = 0
	self._allChatFreeTimes = 0
end

function NewChatModel:reStartCountDownToSaveChat()
	self._curSecToSaveChat = 0

	if not self._isCountDownToSaveChat then
		self:stopCountDownToSaveChat()

		self._isCountDownToSaveChat = true

		settimer(PetStepSecToSave, self._tickingToSaveChat, self, true)
	end
end

function NewChatModel:stopCountDownToSaveChat()
	removetimer(self._tickingToSaveChat, self)

	self._isCountDownToSaveChat = false
end

function NewChatModel:_tickingToSaveChat()
	self._curSecToSaveChat = self._curSecToSaveChat + PetStepSecToSave

	if self._curSecToSaveChat >= DelaySecToSave then
		self:stopCountDownToSaveChat()

		if self._isPrivateChatUpdate then
			self:saveLocalStore()
		end
	end
end

function NewChatModel:saveLocalStore()
	self:_save()
end

function NewChatModel:OnNotifyNewMsg(msg)
	local count = {}
	local isMe = false

	for _, v in ipairs(msg) do
		local info = ChatMsgMo.New()

		info:InitWithChatMsgNo(v)

		local channel = info:getChannel()
		local friendId = info:getFriendId()

		if self:_addChatMsg(info) then
			if channel == GameEnum.ChatChannel.Private and checknumber(friendId) > 0 then
				count[channel] = count[channel] or {}

				if count[channel][friendId] then
					count[channel][friendId] = count[channel][friendId] + 1 or 1
				end

				if not info:getIsMe() then
					self:addMainUIMsg(info)
				end
			else
				self:addMainUIMsg(info)

				if count[channel] then
					count[channel] = count[channel] + 1 or 1
				end
			end

			isMe = isMe or info:getIsMe()
		end

		if channel == GameEnum.ChatChannel.System and info:isSystemMsg() and not v.isCustom and string.find(v.content, "\"tpId\":10", 1, true) then
			GlobalDispatcher:dispatch(GlobalNotify.FlyNuoSystemMsg, info:toTable())
		end
	end

	for channel, v in pairs(count) do
		if channel == GameEnum.ChatChannel.Private then
			for friendId, count in pairs(v) do
				GlobalDispatcher:dispatch(GlobalNotify.OnMsgAdd, channel, friendId, count, isMe)
			end
		else
			GlobalDispatcher:dispatch(GlobalNotify.OnMsgAdd, channel, -1, v, isMe)
		end
	end
end

function NewChatModel:setRedPointCount(channel, friendId, value, notify)
	if channel == GameEnum.ChatChannel.Private then
		local needClear = false
		local friendMo = FriendModel.instance:getFriendMo(friendId)

		if friendMo == nil then
			needClear = true
		elseif friendMo._groupType ~= GameEnum.FriendGroup.Friend and friendMo._groupType ~= GameEnum.FriendGroup.Stranger then
			needClear = true
		end

		if (checknumber(friendId) <= 0 or nil) and true then
			self._msgs[channel] = self._msgs[channel] or {}
			self._msgs[channel][friendId] = {}
			value = 0
		end
	end

	local curCount = self:getRedPointCount(channel, friendId)

	if curCount == value then
		return
	end

	local key = self:getRedPointKey(channel, friendId)

	self._redPoints[key] = checknumber(value)

	if channel == GameEnum.ChatChannel.Private then
		local parentKey = tostring(channel)

		self._redPoints[parentKey] = checknumber(self._redPoints[parentKey]) + value - curCount
	end

	if notify == true or notify == nil then
		GlobalDispatcher:dispatch(GlobalNotify.ChatRedPointUpdate, channel, friendId)
	end
end

function NewChatModel:getRedPointCount(channel, friendId)
	local key = self:getRedPointKey(channel, friendId)

	return checknumber(self._redPoints[key])
end

function NewChatModel:getRedPointKey(channel, friendId)
	local key = tostring(channel)

	if channel == GameEnum.ChatChannel.Private and checknumber(friendId) > 0 then
		key = key .. "_" .. friendId
	end

	return key
end

function NewChatModel:addMainUIMsg(info)
	if ChatSettingModel.instance:GetMainShow(info:getChannel()) then
		if #self._mainUIMsgs >= 8 then
			table.remove(self._mainUIMsgs, 1)
		end

		table.insert(self._mainUIMsgs, info)
	end
end

function NewChatModel:OnGetOfflineMsgs(msgs)
	local info

	table.sort(msgs, function(a, b)
		return a.sendTime < b.sendTime
	end)

	for _, v in ipairs(msgs) do
		info = ChatMsgMo.New()

		info:InitWithChatMsgNo(v)
		self:_addChatMsg(info, false)
	end
end

function NewChatModel:OnGetChatBubbleId(chatBubbleId)
	self._chatBubbleId = chatBubbleId
end

function NewChatModel:getChatBubbleId()
	return self._chatBubbleId
end

function NewChatModel:_addChatMsg(info, notify)
	local channel = info:getChannel()

	if channel == nil then
		return
	end

	local sendTime = info:getSendTime()
	local friendId = info:getFriendId()

	if self._msgs[channel] then
		self._msgs[channel] = self._msgs[channel] or {}
	end

	local t = self._msgs[channel]

	if channel == GameEnum.ChatChannel.Private then
		if t[friendId] then
			t[friendId] = t[friendId] or {}
		end

		t = t[friendId]
	end

	for _, v in ipairs(t) do
		if v._msgId == info._msgId then
			return false
		end
	end

	table.insert(t, #t + 1, info)

	local msgLimit = ChatConfig.instance:getMsgCountLimit()

	if msgLimit < #t then
		table.remove(t, 1)
	end

	if not info:getIsMe() and info._isRead ~= true then
		local curCount = self:getRedPointCount(channel, friendId)

		self:setRedPointCount(channel, friendId, checknumber(curCount) + 1, notify)

		local friendMo = FriendModel.instance:getFriendMo(friendId)

		if channel == GameEnum.ChatChannel.Private and checknumber(friendId) > 0 and friendMo then
			local tempTime = checknumber(sendTime)

			if tempTime > 0 then
				FriendController.instance:changeFriendSortTimeIfIsTop(friendId, tempTime)
			end
		end
	end

	if channel == GameEnum.ChatChannel.Private then
		self._isPrivateChatUpdate = true

		self:reStartCountDownToSaveChat()
	end

	return true
end

function NewChatModel:GetMsgsByChannel(channel, friendId, insertTimeStamp)
	if not self._msgs[channel] then
		local t = {}

		if channel == GameEnum.ChatChannel.Private then
			t = self._msgs[channel][friendId] or {}
		end

		return insertTimeStamp and self:_insertTimeStamp(self._msgs[channel], channel) or self._msgs[channel]
	end
end

function NewChatModel:_insertTimeStamp(msgs, channel)
	if channel == GameEnum.ChatChannel.Battle then
		return msgs
	end

	local timestamp
	local t = {}

	for _, msg in ipairs(msgs) do
		if not timestamp or msg:getSendTime() - timestamp >= TimestampOffset then
			local timeObj = ChatTimeObj.New(msg:getSendTime())

			timestamp = msg:getSendTime()

			table.insert(t, timeObj)
		end

		table.insert(t, msg)
	end

	return t
end

function NewChatModel:ClearChannelMsg(channel, friendId)
	if channel == GameEnum.ChatChannel.Private and self._msgs[channel] then
		if friendId == nil then
			return
		end

		self._msgs[channel][friendId] = {}
	else
		self._msgs[channel] = {}
	end

	self:setRedPointCount(channel, friendId, 0)
end

function NewChatModel:GetMainUIShowMsg()
	return self._mainUIMsgs
end

function NewChatModel:SetMsgAllRead(channel, friendId)
	local t = self:GetMsgsByChannel(channel, friendId)
	local i = #t

	while i > 0 do
		t[i]._isRead = true
		i = i - 1
	end

	GlobalDispatcher:dispatch(GlobalNotify.MsgRead, channel, tostring(friendId))
	self:setRedPointCount(channel, friendId, 0)
end

function NewChatModel:_save()
	if string.nilorempty(tostring(LoginModel.instance.userId)) then
		return
	end

	self:stopCountDownToSaveChat()
	self:_savePrivate()
end

function NewChatModel:_savePrivate()
	local userId = tostring(RoleModel.instance:getUserId())

	if checknumber(userId) <= 0 then
		return
	end

	local key = self:_getLocalStorageKeyOfPrivateChat(userId)

	if not self._msgs[GameEnum.ChatChannel.Private] then
		local list = {}

		for id, msgs in pairs(self._msgs[GameEnum.ChatChannel.Private]) do
			list[id] = {}

			for i, msg in ipairs(msgs) do
				list[id][i] = msg:toTable()
			end
		end

		Framework.LocalStorage.Instance:SetString(key, GameUtil.jsonToString(list))
		Framework.LocalStorage.Instance:Save()

		self._isPrivateChatUpdate = false
	end
end

function NewChatModel:_loadPrivate()
	local userId = tostring(RoleModel.instance:getUserId())

	if checknumber(userId) <= 0 then
		return
	end

	local keyOfFrined = string.format("UserId=%s", userId)
	local friendIds = Framework.LocalStorage.Instance:GetString(keyOfFrined, "")

	if not string.nilorempty(friendIds) then
		Framework.LocalStorage.Instance:DeleteKey(keyOfFrined)

		local t = json.decode(friendIds)

		for _, id in ipairs(t) do
			local key = string.format("UserId=%sFriendId=%s", userId, id)
			local msgs = Framework.LocalStorage.Instance:GetString(key, "")

			Framework.LocalStorage.Instance:DeleteKey(key)

			if not string.nilorempty(msgs) then
				msgs = json.decode(msgs)

				self:_addChatMsgsByMsg(msgs)
			end
		end
	else
		local key = self:_getLocalStorageKeyOfPrivateChat(userId)
		local jsonStr = Framework.LocalStorage.Instance:GetString(key, "")

		if not string.nilorempty(jsonStr) then
			local msgsList = GameUtil.jsonToTable(jsonStr)

			for _, msgs in pairs(msgsList) do
				self:_addChatMsgsByMsg(msgs)
			end
		end
	end
end

function NewChatModel:_addChatMsgsByMsg(msgs)
	for _, msg in ipairs(msgs) do
		local info = ChatMsgMo.New()

		info:InitWithLocalStore(msg)
		self:_addChatMsg(info)
	end
end

function NewChatModel:_getLocalStorageKeyOfPrivateChat(userId)
	return string.format("%s_%s", LocalStorageKeyOfPrivateChat, userId)
end

function NewChatModel:getNotReadMsgCount(channel, friendId)
	return self:getRedPointCount(channel, friendId)
end

function NewChatModel:getHasNotReadMsg()
	if not self._msgs[GameEnum.ChatChannel.Private] then
		local val = false

		for friendId, v in pairs(self._msgs[GameEnum.ChatChannel.Private]) do
			if checknumber(friendId) > 0 then
				for _, msg in ipairs(v) do
					if not msg._isRead then
						val = true

						break
					end
				end
			end

			if val then
				break
			end
		end

		return val
	end
end

function NewChatModel:getLastMsgSendTime(channel, friendId)
	if not self._msgs[channel] then
		local t = {}

		if channel == GameEnum.ChatChannel.Private then
			t = self._msgs[channel][friendId] or {}
		end

		return #self._msgs[channel] > 0 and checknumber(self._msgs[channel][#self._msgs[channel]]:getSendTime()) or 0
	end
end

function NewChatModel:setUsedWorldChatFreeTimes(times)
	self._usedWorldChatFreeTimes = times

	GlobalDispatcher:dispatch(GlobalNotify.UsedWorldChatFreeTimes, times)
end

function NewChatModel:getUsedWorldChatFreeTimes()
	return self._usedWorldChatFreeTimes
end

function NewChatModel:setUnlockedEmoticonGroupIds(unlockedEmoticonGroupIds)
	self._unlockedEmoticonGroupIds = {}

	for i, v in ipairs(unlockedEmoticonGroupIds) do
		self._unlockedEmoticonGroupIds[v] = true
	end
end

function NewChatModel:getUnlockedEmoticonGroupIds()
	return self._unlockedEmoticonGroupIds
end

function NewChatModel:isEmoticonGroupUnlocked(groupId)
	return (self._unlockedEmoticonGroupIds or nil) and (self._unlockedEmoticonGroupIds[groupId] or false)
end

function NewChatModel:setExitId(id)
	self._exitId = id
end

function NewChatModel:getExitId()
	if self._unlockedEmoticonGroupIds[self._exitId] then
		return self._exitId
	else
		self._exitId = nil

		return nil
	end
end

function NewChatModel:setAllChatFreeTimes(times)
	self._allChatFreeTimes = times or 0
end

function NewChatModel:getAllChatFreeUseTimes()
	return self._allChatFreeTimes
end

function NewChatModel:useAllChatFreeTimes()
	self._allChatFreeTimes = self._allChatFreeTimes + 1
end

function NewChatModel:isMaskChatOpen()
	return self._maskChatOpen
end

function NewChatModel:setMaskChatOpen(val)
	self._maskChatOpen = val
end

NewChatModel.instance = NewChatModel.New()

return NewChatModel
