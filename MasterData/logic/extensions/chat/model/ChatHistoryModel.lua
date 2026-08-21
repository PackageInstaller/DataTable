-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/model/ChatHistoryModel.lua

module("logic.extensions.chat.model.ChatHistoryModel", package.seeall)

local M = class("ChatHistoryModel", BaseModel)
local INDEX_KEY_FORMAT = "CHAT_INDEX_%d_%d"
local CONTENT_KEY_FORMAT = "CHAT_CONTENT_%d_%d_%d"
local MAX_COUNT_PER_DATA = 30
local json = require("cjson")

function M:ctor()
	self._indexLists = {}
end

function M:onInit()
	return
end

function M:onReset()
	table.clear(self._indexLists)
end

local function _genIndexKey(channelType, targetId)
	local myUserId = tonumber(PlayerModel.instance:getId())
	local key = string.format(INDEX_KEY_FORMAT, myUserId, targetId or channelType)

	return key
end

local function _delIndexKey(channelType, targetId)
	local myUserId = tonumber(PlayerModel.instance:getId())
	local key = string.format(INDEX_KEY_FORMAT, myUserId, targetId or channelType)

	Astral.LocalStorage.Instance:DeleteKey(key)
	Astral.LocalStorage.Instance:Save()

	return key
end

local function _genContentKey(channelType, targetId, curIndex)
	local myUserId = tonumber(PlayerModel.instance:getId())
	local contentKey = string.format(CONTENT_KEY_FORMAT, myUserId, targetId or channelType, curIndex)

	return contentKey
end

function M:getCurIndex(channelType, targetId)
	if not channelType then
		printError("channelType should not be nil!")

		return 0
	end

	if targetId then
		self._indexLists[channelType] = self._indexLists[channelType] or {}

		if not self._indexLists[channelType][targetId] then
			local indexKey = _genIndexKey(channelType, targetId)
			local indexValue = Astral.LocalStorage.Instance:GetInt(indexKey, -1)

			if indexValue == -1 then
				indexValue = 1
			end

			self._indexLists[channelType][targetId] = indexValue
		end

		return self._indexLists[channelType][targetId]
	else
		if not self._indexLists[channelType] then
			local indexKey = _genIndexKey(channelType)
			local indexValue = Astral.LocalStorage.Instance:GetInt(indexKey, -1)

			if indexValue == -1 then
				indexValue = 1
			end

			self._indexLists[channelType] = indexValue
		end

		return self._indexLists[channelType]
	end
end

function M:saveIndexKey(channelType, targetId, curIndex)
	local indexKey = _genIndexKey(channelType, targetId)

	Astral.LocalStorage.Instance:SetInt(indexKey, curIndex)
	Astral.LocalStorage.Instance:Save()
end

function M:trySaveHistory(channelType, targetId)
	local msgMoList = ChatModel.instance:getMsgMoList(channelType, targetId)
	local curIndex = self:getCurIndex(channelType, targetId)

	if channelType == GameEnum.ChannelTypeEnum.Friend then
		self:saveLocally(channelType, targetId, msgMoList, curIndex)

		if #msgMoList >= curIndex * MAX_COUNT_PER_DATA then
			curIndex = curIndex + 1
			self._indexLists[channelType][targetId] = curIndex

			self:saveIndexKey(channelType, targetId, curIndex)
		end
	elseif #msgMoList >= curIndex * MAX_COUNT_PER_DATA then
		self:saveLocally(channelType, targetId, msgMoList, curIndex)

		curIndex = curIndex + 1

		if targetId then
			self._indexLists[channelType][targetId] = curIndex
		else
			self._indexLists[channelType] = curIndex
		end

		self:saveIndexKey(channelType, targetId, curIndex)
	end
end

function M:saveLocally(channelType, targetId, msgMoList, curIndex)
	msgMoList = msgMoList or {}

	local beginIndex = MAX_COUNT_PER_DATA * (curIndex - 1) + 1
	local endIndex = MAX_COUNT_PER_DATA * curIndex
	local temp = {}

	for index = beginIndex, endIndex do
		if not msgMoList[index] then
			break
		end

		local data = {
			senderId = msgMoList[index]:getSenderId(),
			targetId = msgMoList[index]:getTargetId(),
			content = msgMoList[index]:getContent(),
			messageType = msgMoList[index]:getMessageType(),
			channelType = msgMoList[index]:getChannelType(),
			time = msgMoList[index]:getTime()
		}

		table.insert(temp, data)
	end

	local contentValue = json.encode(temp)
	local contentKey = _genContentKey(channelType, targetId, curIndex)

	Astral.LocalStorage.Instance:SetString(contentKey, contentValue)
	Astral.LocalStorage.Instance:Save()
end

function M:saveCurrent()
	local moList = ChatModel.instance:getMoList()

	for channelType, list in pairs(moList) do
		if channelType == GameEnum.ChannelTypeEnum.Friend then
			for targetId, _ in pairs(list) do
				local msgMoList = ChatModel.instance:getMsgMoList(channelType, targetId)
				local curIndex = self:getCurIndex(channelType, targetId)

				self:saveLocally(channelType, targetId, msgMoList, curIndex)
				self:saveIndexKey(channelType, targetId, curIndex)
			end
		else
			local msgMoList = ChatModel.instance:getMsgMoList(channelType, nil)
			local curIndex = self:getCurIndex(channelType, nil)

			self:saveLocally(channelType, nil, msgMoList, curIndex)
			self:saveIndexKey(channelType, nil, curIndex)
		end
	end
end

function M:loadHistory(channelType, targetId)
	local endIndex = self:getCurIndex(channelType, targetId)
	local isLost = false

	for index = 1, endIndex do
		local contentKey = _genContentKey(channelType, targetId, index)
		local contentValue = Astral.LocalStorage.Instance:GetString(contentKey)

		if not string.nilorempty(contentValue) then
			local temp = json.decode(contentValue)

			for _, data in ipairs(temp) do
				local msgMo = ChatMsgMO.New(data)

				ChatModel.instance:addMsg(msgMo, false)
			end
		else
			isLost = true
		end
	end

	if isLost then
		local msgMoList = ChatModel.instance:getMsgMoList(channelType, targetId)
		local curIndex = math.floor(#msgMoList / MAX_COUNT_PER_DATA) + 1

		self:saveIndexKey(channelType, targetId, curIndex)
	end
end

M.instance = M.New()

return M
