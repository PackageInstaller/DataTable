-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/friendPvp/model/FriendPvpRecord.lua

FriendPvpRecord = class("FriendPvpRecord", objectlua.Object, _M)

FriendPvpRecord:has("_rank", {
	is = "rw"
})
FriendPvpRecord:has("_rankType", {
	is = "rw"
})
FriendPvpRecord:has("_nickName", {
	is = "rw"
})
FriendPvpRecord:has("_heroes", {
	is = "rw"
})
FriendPvpRecord:has("_master", {
	is = "rw"
})
FriendPvpRecord:has("_headId", {
	is = "rw"
})
FriendPvpRecord:has("_headFrameId", {
	is = "rw"
})
FriendPvpRecord:has("_vipLevel", {
	is = "rw"
})
FriendPvpRecord:has("_level", {
	is = "rw"
})
FriendPvpRecord:has("_combat", {
	is = "rw"
})
FriendPvpRecord:has("_clubName", {
	is = "rw"
})
FriendPvpRecord:has("_rid", {
	is = "rw"
})
FriendPvpRecord:has("_slogan", {
	is = "rw"
})
FriendPvpRecord:has("_lastOfflineTime", {
	is = "rw"
})
FriendPvpRecord:has("_online", {
	is = "rw"
})
FriendPvpRecord:has("_isFriend", {
	is = "rw"
})
FriendPvpRecord:has("_lastInviteTime", {
	is = "rw"
})
FriendPvpRecord:has("_playerState", {
	is = "rw"
})
FriendPvpRecord:has("_familiarity", {
	is = "rw"
})
FriendPvpRecord:has("_clubPos", {
	is = "rw"
})
FriendPvpRecord:has("_teamName", {
	is = "rw"
})
FriendPvpRecord:has("_leadStageId", {
	is = "r"
})
FriendPvpRecord:has("_leadStageLevel", {
	is = "r"
})

FPVPPlayerStatus = {
	kBusy = 2,
	kOffline = 0,
	kOnline = 1
}

function FriendPvpRecord:initialize()
	super.initialize(self)

	self._rank = 0
	self._nickName = ""
	self._heroes = {}
	self._headId = 0
	self._headFrameId = ""
	self._vipLevel = 0
	self._combat = 0
	self._clubName = ""
	self._rid = ""
	self._level = 0
	self._slogan = ""
	self._retainsDay = 0
	self._changeNum = 0
	self._isFriend = 0
	self._lastOfflineTime = 0
	self._lastInviteTime = 0
	self._familiarity = 0
	self._clubPos = -1
	self._teamName = ""
	self._leadStageId = ""
	self._leadStageLevel = 0
end

function FriendPvpRecord:synchronize(data)
	if data then
		if data.rid then
			self._rid = data.rid
		end

		if data.rank then
			self._rank = data.rank
		end

		if data.vip then
			self._vipLevel = data.vip
		end

		if data.nickname then
			self._nickName = data.nickname
		end

		if data.level then
			self._level = data.level
		end

		if data.headImage then
			self._headId = data.headImage
		end

		if data.combat then
			self._combat = data.combat
		end

		if data.heroes then
			self._heroes = data.heroes
		end

		if data.master then
			self._master = data.master
		end

		if data.clubName then
			self._clubName = data.clubName
		end

		if data.slogan then
			self._slogan = Strings:get(data.slogan)
		end

		if data.lastOfflineTime or data.lastOffTime then
			self._lastOfflineTime = data.lastOfflineTime or data.lastOffTime
		end

		if data.online then
			self._online = data.online
		end

		if data.isFriend then
			self._isFriend = data.isFriend
		end

		if data.playerState then
			self._playerState = data.playerState
		end

		if data.clubPosition then
			self._clubPos = data.clubPosition
		end

		if data.teamName then
			self._teamName = data.teamName
		end

		if data.leadStageId then
			self._leadStageId = data.leadStageId
		end

		if data.leadStageLevel then
			self._leadStageLevel = data.leadStageLevel
		end
	end
end

function FriendPvpRecord:getStatus()
	if self._online == 0 then
		return FPVPPlayerStatus.kOffline
	elseif self._playerState == 0 then
		return FPVPPlayerStatus.kBusy
	else
		return FPVPPlayerStatus.kOnline
	end
end
