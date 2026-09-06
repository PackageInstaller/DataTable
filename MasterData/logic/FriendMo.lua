-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/model/FriendMo.lua

module("logic.extensions.friend.model.FriendMo", package.seeall)

local FriendMo = class("FriendMo")

function FriendMo:ctor()
	self._groupType = nil
	self._onlineZoneId = nil
	self._onlineZoneName = nil
	self._lastOpTime = nil
	self._id = 0
	self._unreadMsgCnt = 0
	self._regressEndTime = nil
	self.areaName = nil
	self._curFetter = 0
	self._enableChatWordEffect = false
end

function FriendMo:init(msg)
	self._groupType = msg.groupType
	self._onlineZoneId = msg.onlineZoneId
	self._onlineZoneName = msg.onlineZoneName or ""
	self._lastOpTime = checknumber(msg.lastOpTime)
	self._curFetter = checknumber(msg.fetter)

	self:initSimpleInfo(msg.simpleInfo)
end

function FriendMo:initSimpleInfo(simpleInfo)
	self.simpleInfo = simpleInfo
	self.headInfo = simpleInfo.headInfo

	local changed = false

	if simpleInfo then
		changed = self:_setProperty("_id", simpleInfo.headInfo.userId) or changed
		changed = self:_setProperty("_name", simpleInfo.headInfo.userName) or changed
		changed = self:_setProperty("headIconId", simpleInfo.headInfo.headIconId) or changed
		changed = self:_setProperty("headFrameId", simpleInfo.headInfo.headFrameId) or changed
		changed = self:_setProperty("areaName", simpleInfo.headInfo.areaName) or changed
		changed = self:_setProperty("vipLv", simpleInfo.headInfo.vipLv) or changed
		changed = self:_setProperty("playerLv", simpleInfo.headInfo.playerLv) or changed
		changed = self:_setProperty("_cloths", simpleInfo.cloths) or changed
		changed = self:_setProperty("_zdl", simpleInfo.maxZdl) or changed
		changed = self:_setProperty("_playerExp", simpleInfo.playerExp) or changed
		changed = self:_setProperty("_moralVal", simpleInfo.moralVal) or changed
		changed = self:_setProperty("_bubbleId", simpleInfo.bubbleId) or changed
		changed = self:_setProperty("_regressEndTime", checknumber(simpleInfo.regressEndTime) / 1000) or changed
		changed = self:_setProperty("_enableChatWordEffect", checkbool(simpleInfo.enableChatWordEffect)) or changed
	end

	return changed
end

function FriendMo:_setProperty(key, newValue)
	local oldValue = self[key]

	if oldValue == nil and newValue == nil then
		return false
	end

	if oldValue ~= nil and oldValue == newValue then
		return false
	end

	self[key] = newValue

	return true
end

function FriendMo:getLevel()
	return MofangModel.instance:getCurLv(self._playerExp)
end

function FriendMo:getValue(key)
	return self["_" .. key]
end

function FriendMo:setValue(key, value)
	self["_" .. key] = value
end

function FriendMo:getIsOnline()
	return self._onlineZoneId and self._onlineZoneId > 0
end

function FriendMo:GetId()
	return self._id
end

function FriendMo:GetPower()
	return checknumber(self._zdl)
end

function FriendMo:Group()
	return self._groupType
end

function FriendMo:ChangeGroup(newGroup)
	self._groupType = newGroup

	if newGroup == GameEnum.FriendGroup.Stranger or newGroup == GameEnum.FriendGroup.Blacklist then
		self._lastOpTime = ServerTime.now()
	end
end

function FriendMo:IsFriend()
	return self._groupType == GameEnum.FriendGroup.Friend
end

function FriendMo:IsStranger()
	return self._groupType == GameEnum.FriendGroup.Stranger
end

function FriendMo:IsBlacklist()
	return self._groupType == GameEnum.FriendGroup.Blacklist
end

function FriendMo:ResetZoneInfo(data)
	self._onlineZoneId = data.onlineZoneId or 0
	self._onlineZoneName = data.onlineZoneName or ""

	if data.onlineZoneId ~= nil then
		self._zoneId = data.onlineZoneId or 0
	end

	self._isOnline = self._zoneId > 0

	if data.onlineZoneName ~= nil then
		self._zoneName = data.onlineZoneName or ""
	end

	self._lastOpTime = ServerTime.now() * 1000
end

function FriendMo:Online()
	return self._isOnline
end

function FriendMo:ZoneId()
	return self._zoneId
end

function FriendMo:ZoneName()
	return self._zoneName
end

function FriendMo:HasSendHeart()
	return self._hasSendHeart
end

function FriendMo:SetSendHeart(hasSend)
	self._hasSendHeart = hasSend

	GlobalDispatcher:dispatch(GlobalNotify.HeartSendChanged, self._id)
end

function FriendMo:CanGainHeart()
	return self._canGainHeart
end

function FriendMo:SetCanGainHeart(isCan)
	self._canGainHeart = isCan

	GlobalDispatcher:dispatch(GlobalNotify.HeartGainChanged, self._id)
end

function FriendMo:getCurFetter()
	return checkint(self._curFetter)
end

function FriendMo:setCurFetter(fetter)
	self._curFetter = checkint(fetter)
end

function FriendMo:lastOpTime()
	return self._lastOpTime
end

function FriendMo:getRegressEndTime()
	return checknumber(self._regressEndTime)
end

function FriendMo:getEnableChatWordEffect()
	return checkbool(self._enableChatWordEffect)
end

return FriendMo
