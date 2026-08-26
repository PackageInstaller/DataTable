-- chunkname: @modules/logic/social/model/SocialPlayerMO.lua

module("modules.logic.social.model.SocialPlayerMO", package.seeall)

local SocialPlayerMO = pureTable("SocialPlayerMO")

function SocialPlayerMO:init(info, type)
	self.id = info.userId
	self.userId = info.userId
	self.name = info.name
	self.level = info.level
	self.portrait = info.portrait
	self.time = info.time
	self.desc = info.desc
	self.infos = info.infos
	self.bg = info.bg or 0
	self.type = type
end

function SocialPlayerMO:initWithPlayCard(info, type)
	if info and info.friendInfo then
		self:init(info.friendInfo, type)
	else
		self:init(info, type)
	end

	if info and info.playerCardExtInfo then
		self:_initPlayerCardExtInfo(info.playerCardExtInfo)
	end
end

function SocialPlayerMO:_initPlayerCardExtInfo(playerCardExtInfo)
	self.playercardMo = PlayerCardMO.New()

	self.playercardMo:init(self.id)
	self.playercardMo:updateInfo(playerCardExtInfo.playerCardInfo, playerCardExtInfo.playerInfo)
end

function SocialPlayerMO:isSendAddFriend()
	return self._isAdded or false
end

function SocialPlayerMO:setAddedFriend()
	self._isAdded = true
end

function SocialPlayerMO:isMyFriend()
	return SocialModel.instance:isMyFriendByUserId(self.userId)
end

function SocialPlayerMO:isMyBlackList()
	return SocialModel.instance:isMyBlackListByUserId(self.userId)
end

function SocialPlayerMO:getPlayerCardInfo()
	return self.playercardMo
end

return SocialPlayerMO
