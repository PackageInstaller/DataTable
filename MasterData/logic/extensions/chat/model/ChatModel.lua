-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/model/ChatModel.lua

module("logic.extensions.chat.model.ChatModel", package.seeall)

local M = class("ChatModel", BaseModel)

function M:ctor()
	M.super.ctor(self)

	self._moLists = {}
	self._moQuene = false
end

function M:onInit()
	self._moQuene = Queue.create()
end

function M:onReset()
	table.clear(self._moLists)
	self._moQuene:clear()
end

function M:getMoList()
	return self._moLists
end

function M:getMsgMoList(channelType, targetId)
	if targetId then
		if not self._moLists[channelType] then
			self._moLists[channelType] = {}
		end

		if not self._moLists[channelType][targetId] then
			self._moLists[channelType][targetId] = {}

			ChatHistoryModel.instance:loadHistory(channelType, targetId)
		end

		return self._moLists[channelType][targetId]
	else
		if not self._moLists[channelType] then
			self._moLists[channelType] = {}

			ChatHistoryModel.instance:loadHistory(channelType, nil)
		end

		return self._moLists[channelType]
	end
end

function M:addMsg(msgMo, isFromServer)
	local channelType = msgMo:getChannelType()
	local sendByMe = msgMo:isSendByMe()
	local targetId = sendByMe and msgMo:getTargetId() or msgMo:getSenderId()

	if not channelType then
		return
	end

	local msgMoList = self:getMsgMoList(channelType, targetId)

	table.insert(msgMoList, msgMo)

	if isFromServer then
		ChatHistoryModel.instance:trySaveHistory(channelType, targetId)

		if not sendByMe then
			ChatMainFacade.instance:tryShowChatMsgTips(channelType, targetId)
		end
	end
end

function M:getLastMsg(channelType, targetId)
	local msgMoList = self:getMsgMoList(channelType, targetId)

	return msgMoList[#msgMoList]
end

function M:addBroadcastData(data)
	if not self._moQuene then
		self._moQuene = Queue.create()
	end

	self._moQuene:enqueue(data)
	GlobalDispatcher:dispatchEvent(EventType.SHOW_MARQUEE_EVENT)
end

function M:getBroadcastData()
	if self._moQuene:size() <= 0 then
		return false
	end

	local data = self._moQuene:dequeue()

	return data
end

M.instance = M.New()

return M
