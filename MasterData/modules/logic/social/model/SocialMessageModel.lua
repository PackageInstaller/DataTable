-- chunkname: @modules/logic/social/model/SocialMessageModel.lua

module("modules.logic.social.model.SocialMessageModel", package.seeall)

local SocialMessageModel = class("SocialMessageModel", BaseModel)

function SocialMessageModel:onInit()
	self._socialMessageMOListDict = {}
	self._socialMessageMOListDict[SocialEnum.ChannelType.Friend] = {}
	self._messageUnreadDict = nil
end

function SocialMessageModel:reInit()
	self._socialMessageMOListDict = {}
	self._socialMessageMOListDict[SocialEnum.ChannelType.Friend] = {}
	self._messageUnreadDict = nil
end

function SocialMessageModel:loadSocialMessages(channelType, id, socialMessagesList)
	if not self._socialMessageMOListDict[channelType][id] then
		local socialMessageMOList = {}

		for i, socialMessage in ipairs(socialMessagesList) do
			local socialMessageMO = SocialMessageMO.New()

			socialMessageMO:init(socialMessage)
			table.insert(socialMessageMOList, socialMessageMO)
		end

		self._socialMessageMOListDict[channelType][id] = socialMessageMOList
	end
end

function SocialMessageModel:saveSocialMessages(channelType, id)
	if self._socialMessageMOListDict[channelType][id] then
		SocialMessageController.instance:writeSocialMessages(channelType, id, self._socialMessageMOListDict[channelType][id])
	end
end

function SocialMessageModel:getSocialMessageMOList(channelType, id)
	if not channelType or not id then
		return
	end

	if not self._socialMessageMOListDict[channelType][id] then
		SocialMessageController.instance:readSocialMessages(channelType, id)
	end

	return self._socialMessageMOListDict[channelType][id]
end

function SocialMessageModel:loadMessageUnread(messageUnreadDict)
	self._messageUnreadDict = messageUnreadDict
end

function SocialMessageModel:saveMessageUnread()
	if self._messageUnreadDict then
		SocialMessageController.instance:writeMessageUnread(self._messageUnreadDict)
	end
end

function SocialMessageModel:getMessageUnread()
	if not self._messageUnreadDict then
		SocialMessageController.instance:readMessageUnread()
	end

	return self._messageUnreadDict
end

function SocialMessageModel:getUnReadLastMsgTime(id)
	self._messageUnreadDict = self._messageUnreadDict or self:getMessageUnread()
	self._messageUnreadDict[SocialEnum.ChannelType.Friend] = self._messageUnreadDict[SocialEnum.ChannelType.Friend] or {}

	if not self._messageUnreadDict[SocialEnum.ChannelType.Friend][id] then
		return 0
	end

	return self._messageUnreadDict[SocialEnum.ChannelType.Friend][id].lastTime
end

function SocialMessageModel:addMessageUnread(channelType, id, count, sendTime)
	self._messageUnreadDict = self._messageUnreadDict or self:getMessageUnread()
	self._messageUnreadDict[channelType] = self._messageUnreadDict[channelType] or {}
	self._messageUnreadDict[channelType][id] = self._messageUnreadDict[channelType][id] or {
		count = 0,
		lastTime = 0
	}
	self._messageUnreadDict[channelType][id].count = self._messageUnreadDict[channelType][id].count + count

	if sendTime then
		local time = tonumber(sendTime)
		local lastTime = self._messageUnreadDict[channelType][id].lastTime

		if lastTime < time then
			self._messageUnreadDict[channelType][id].lastTime = time
		end
	end

	if count ~= 0 then
		self:updateRedDotGroup()
	end

	self:saveMessageUnread()
end

function SocialMessageModel:clearMessageUnread(channelType, id, clear)
	self._messageUnreadDict = self._messageUnreadDict or self:getMessageUnread()
	self._messageUnreadDict[channelType] = self._messageUnreadDict[channelType] or {}

	if clear then
		self._messageUnreadDict[channelType][id] = nil
	elseif self._messageUnreadDict[channelType][id] then
		self._messageUnreadDict[channelType][id].count = 0
		self._messageUnreadDict[channelType][id].lastTime = 0
	end

	self:updateRedDotGroup()
	self:saveMessageUnread()
end

function SocialMessageModel:getFriendMessageUnread(friendUserId)
	self._messageUnreadDict = self._messageUnreadDict or self:getMessageUnread()
	self._messageUnreadDict[SocialEnum.ChannelType.Friend] = self._messageUnreadDict[SocialEnum.ChannelType.Friend] or {}

	local info = self._messageUnreadDict[SocialEnum.ChannelType.Friend][friendUserId]

	return (info or nil) and (info.count or 0)
end

function SocialMessageModel:getMessageUnreadRedDotGroup()
	local redDotGroup = {}

	redDotGroup.defineId = 1006

	local infos = {}
	local friendIdDict = SocialModel.instance:getFriendIdDict()

	for friendId, _ in pairs(friendIdDict) do
		local redDotInfo = {}

		redDotInfo.id = tonumber(friendId)
		redDotInfo.value = self:getFriendMessageUnread(friendId)
		redDotInfo.time = 0
		redDotInfo.ext = ""

		table.insert(infos, redDotInfo)
	end

	if #infos <= 0 then
		local info = {}

		info.id = 0
		info.value = 0
		info.time = 0

		table.insert(infos, info)
	end

	redDotGroup.infos = infos
	redDotGroup.replaceAll = true

	return redDotGroup
end

function SocialMessageModel:updateRedDotGroup()
	local fakeMsg = {}
	local redDotInfos = {}
	local redDotGroup = self:getMessageUnreadRedDotGroup()

	table.insert(redDotInfos, redDotGroup)

	fakeMsg.redDotInfos = redDotInfos
	fakeMsg.replaceAll = false

	RedDotModel.instance:updateRedDotInfo(fakeMsg.redDotInfos)
	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateFriendInfoDot, fakeMsg.redDotInfos)
end

function SocialMessageModel:addSocialMessage(socialMessage)
	local channelType = socialMessage.channelType
	local id = 0
	local myMessage = false

	if channelType == SocialEnum.ChannelType.Friend then
		local myUserId = PlayerModel.instance:getMyUserId()

		if myUserId == socialMessage.senderId then
			id = socialMessage.recipientId
			myMessage = true
		else
			id = socialMessage.senderId
		end
	end

	self._socialMessageMOListDict[channelType][id] = self._socialMessageMOListDict[channelType][id] or self:getSocialMessageMOList(channelType, id)

	local socialMessageMOList = self._socialMessageMOListDict[channelType][id]

	for i, messageMO in ipairs(socialMessageMOList) do
		if messageMO.msgId == socialMessage.msgId then
			return
		end
	end

	local socialMessageMO = SocialMessageMO.New()

	socialMessageMO:init(socialMessage)
	table.insert(socialMessageMOList, socialMessageMO)
	self:saveSocialMessages(channelType, id)

	if myMessage then
		self:addMessageUnread(channelType, id, 0)
	else
		self:addMessageUnread(channelType, id, 1, socialMessage.sendTime)
	end

	SocialController.instance:dispatchEvent(SocialEvent.MessageInfoChanged)
end

function SocialMessageModel:deleteSocialMessage(channelType, id)
	self._socialMessageMOListDict[channelType][id] = {}

	self:saveSocialMessages(channelType, id)
	self:clearMessageUnread(channelType, id, true)
	SocialController.instance:dispatchEvent(SocialEvent.MessageInfoChanged)
end

function SocialMessageModel:ensureDeleteSocialMessage()
	local messageUnreadDict = self:getMessageUnread()
	local friendMessageUnreadDict = messageUnreadDict[SocialEnum.ChannelType.Friend]

	if not friendMessageUnreadDict then
		return
	end

	for userId, messageUnread in pairs(friendMessageUnreadDict) do
		if not SocialModel.instance:isMyFriendByUserId(userId) then
			self:deleteSocialMessage(SocialEnum.ChannelType.Friend, userId)
		end
	end
end

SocialMessageModel.instance = SocialMessageModel.New()

return SocialMessageModel
