-- chunkname: @modules/logic/social/controller/SocialMessageController.lua

module("modules.logic.social.controller.SocialMessageController", package.seeall)

local SocialMessageController = class("SocialMessageController", BaseController)

function SocialMessageController:onInit()
	self._tempListDict = {}
	self._tempListDict[SocialEnum.ChannelType.Friend] = {}
end

function SocialMessageController:reInit()
	self._tempListDict = {}
	self._tempListDict[SocialEnum.ChannelType.Friend] = {}
end

function SocialMessageController:onInitFinish()
	return
end

function SocialMessageController:addConstEvents()
	return
end

function SocialMessageController:readSocialMessages(channelType, id)
	local key = SocialConfig.instance:getSocialMessagesKey(channelType, id)
	local socialMessagesPrefs = PlayerPrefsHelper.getString(key, nil)

	SocialMessageModel.instance:loadSocialMessages(channelType, id, (not string.nilorempty(socialMessagesPrefs) or nil) and self:_convertToList(channelType, id, socialMessagesPrefs))
end

function SocialMessageController:writeSocialMessages(channelType, id, socialMessageMOList)
	local key = SocialConfig.instance:getSocialMessagesKey(channelType, id)
	local socialMessagesPrefs = ""

	if socialMessageMOList and #socialMessageMOList > 0 then
		socialMessagesPrefs = self:_convertToPrefs(channelType, id, socialMessageMOList)
	end

	if not string.nilorempty(socialMessagesPrefs) then
		PlayerPrefsHelper.setString(key, socialMessagesPrefs)
	else
		PlayerPrefsHelper.deleteKey(key)
	end
end

function SocialMessageController:_convertToList(channelType, id, socialMessagesPrefs)
	local socialMessagesList = cjson.decode(socialMessagesPrefs)
	local fields = SocialConfig.instance:getSocialMessageFields()
	local metatable = {}

	function metatable.__index(t, key)
		local fieldIndex = fields[key]
		local value = rawget(t, fieldIndex)

		if value == cjson.null then
			value = nil
		end

		return value
	end

	for _, friendMessage in ipairs(socialMessagesList) do
		setmetatable(friendMessage, metatable)
	end

	self._tempListDict[channelType][id] = socialMessagesList

	return socialMessagesList
end

function SocialMessageController:_convertToPrefs(channelType, id, socialMessageMOList)
	local fields = SocialConfig.instance:getSocialMessageFields()
	local socialMessagesList = {}
	local start = 1

	if self._tempListDict[channelType][id] and #socialMessageMOList > #self._tempListDict[channelType][id] then
		start = #self._tempListDict[channelType][id] + 1
		socialMessagesList = self._tempListDict[channelType][id]
	end

	for i = start, #socialMessageMOList do
		local socialMessageMO = socialMessageMOList[i]
		local socialMessage = {}

		for key, value in pairs(socialMessageMO) do
			if fields[key] then
				local fieldIndex = fields[key]

				socialMessage[fieldIndex] = value
			end
		end

		table.insert(socialMessagesList, socialMessage)
	end

	local newMessagesList = {}
	local count = #socialMessagesList
	local maxsave = SocialEnum.MaxSaveMessageCount

	if maxsave < count then
		for i = 1, maxsave do
			newMessagesList[i] = socialMessagesList[count - maxsave + i]
		end
	else
		newMessagesList = socialMessagesList
	end

	self._tempListDict[channelType][id] = socialMessagesList

	return (cjson.encode(newMessagesList))
end

function SocialMessageController:readMessageUnread()
	local key = SocialConfig.instance:getMessageUnreadKey()
	local messageUnreadPrefs = PlayerPrefsHelper.getString(key, nil)
	local messageUnreadDict = {}

	if not string.nilorempty(messageUnreadPrefs) then
		local array = GameUtil.splitString2(messageUnreadPrefs, false, "|", "#")

		for i, params in ipairs(array) do
			if #params >= 4 then
				messageUnreadDict[tonumber(params[1])] = messageUnreadDict[tonumber(params[1])] or {}

				local var_10_0 = {}

				var_10_0.count = tonumber(params[3]) or 0
				var_10_0.lastTime = tonumber(params[4]) or 0
				messageUnreadDict[tonumber(params[1])][params[2]] = var_10_0
			end
		end
	end

	SocialMessageModel.instance:loadMessageUnread(messageUnreadDict)
end

function SocialMessageController:writeMessageUnread(messageUnreadDict)
	local key = SocialConfig.instance:getMessageUnreadKey()
	local messageUnreadPrefs = ""
	local first = true

	if messageUnreadDict then
		for channelType, ids in pairs(messageUnreadDict) do
			for id, info in pairs(ids) do
				if not first then
					messageUnreadPrefs = messageUnreadPrefs .. "|"
				end

				first = false
				messageUnreadPrefs = string.format("%s%s#%s#%s#%s", messageUnreadPrefs, channelType, id, info.count, info.lastTime)
			end
		end
	end

	PlayerPrefsHelper.setString(key, messageUnreadPrefs)
end

function SocialMessageController:opMessageOnClick(socialMessageMO)
	if not socialMessageMO then
		return
	end

	local func = self:_getOpFuncByMsgType(socialMessageMO.msgType)

	if func then
		func(socialMessageMO)
	end
end

function SocialMessageController:_getOpFuncByMsgType(msgType)
	self._opFuncMsgDict = self._opFuncMsgDict or {
		[ChatEnum.MsgType.RoomSeekShare] = function(socialMessageMO)
			RoomChatShareController.instance:chatSeekShare(socialMessageMO)
		end,
		[ChatEnum.MsgType.RoomShareCode] = function(socialMessageMO)
			RoomChatShareController.instance:chatShareCode(socialMessageMO)
		end
	}

	return self._opFuncMsgDict[msgType]
end

SocialMessageController.instance = SocialMessageController.New()

return SocialMessageController
