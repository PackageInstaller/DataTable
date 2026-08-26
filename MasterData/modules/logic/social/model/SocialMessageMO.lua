-- chunkname: @modules/logic/social/model/SocialMessageMO.lua

module("modules.logic.social.model.SocialMessageMO", package.seeall)

local SocialMessageMO = pureTable("SocialMessageMO")

function SocialMessageMO:init(info)
	self.id = info.msgId
	self.msgId = info.msgId
	self.channelType = info.channelType
	self.senderId = info.senderId
	self.senderName = info.senderName
	self.portrait = info.portrait
	self.content = info.content
	self.sendTime = info.sendTime
	self.level = info.level
	self.recipientId = info.recipientId
	self.msgType = info.msgType
	self.extData = info.extData
end

function SocialMessageMO:getSenderName()
	local playerMO = SocialModel.instance:getPlayerMO(self.senderId)

	return (playerMO or nil) and (playerMO.name or self.senderName)
end

function SocialMessageMO:getPortrait()
	local playerMO = SocialModel.instance:getPlayerMO(self.senderId)

	return (playerMO or nil) and (playerMO.portrait or self.portrait)
end

function SocialMessageMO:getLevel()
	local playerMO = SocialModel.instance:getPlayerMO(self.senderId)

	return (playerMO or nil) and (playerMO.level or self.level)
end

function SocialMessageMO:isHasOp()
	if ChatEnum.MsgType.RoomSeekShare == self.msgType then
		return self.recipientId == PlayerModel.instance:getMyUserId()
	elseif ChatEnum.MsgType.RoomShareCode == self.msgType then
		return true
	end

	return false
end

return SocialMessageMO
