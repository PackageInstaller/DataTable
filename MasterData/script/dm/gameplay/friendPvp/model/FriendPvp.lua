-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/friendPvp/model/FriendPvp.lua

require("dm.gameplay.friendPvp.model.FriendPvpRecord")

FriendPvp = class("FriendPvp", objectlua.Object, _M)

FriendPvp:has("_roomId", {
	is = "rw"
})
FriendPvp:has("_hostId", {
	is = "rw"
})
FriendPvp:has("_guestState", {
	is = "rw"
})
FriendPvp:has("_guestId", {
	is = "rw"
})
FriendPvp:has("_state", {
	is = "rw"
})
FriendPvp:has("_hostInfo", {
	is = "rw"
})
FriendPvp:has("_guestInfo", {
	is = "rw"
})
FriendPvp:has("_inviteMap", {
	is = "rw"
})
FriendPvp:has("_inviteCountMap", {
	is = "rw"
})

FriendPvpState = {
	kEnter = 1001,
	kPVPFaild = 4002,
	kBattle = 1003,
	kGuestCancelReady = 2003,
	kHostKickOut = 1004,
	kGuestReady = 2002,
	kHostLeave = 3003,
	kGuestEnter = 2001,
	kGuestLeave = 3002
}
GuestState = {
	kEnter = 2001,
	kRequest = 3001,
	kBattle = 3002,
	kReady = 2002
}
InviteType = {
	kFriend = 1,
	kClub = 2
}
RequestType = {
	[InviteType.kFriend] = "friend",
	[InviteType.kClub] = "club"
}

function FriendPvp:initialize()
	super.initialize(self)

	self._inviteMap = {}
	self._inviteCountMap = {}

	for k, v in pairs(InviteType) do
		self._inviteMap[v] = {}
		self._inviteCountMap[v] = {}
		self._inviteCountMap[v].total = 0
		self._inviteCountMap[v].online = 0
	end
end

function FriendPvp:synchronize(data)
	if not data then
		return
	end

	if data.roomId then
		self._roomId = data.roomId
	end

	if data.op then
		self._state = data.op
	end

	if data.playerInfo then
		for k, value in pairs(data.playerInfo) do
			if value.host then
				self._hostInfo = value
				self._hostId = value.id
			else
				self._guestInfo = value
				self._guestId = value.id
			end
		end
	end
end

function FriendPvp:syncInviteList(data, inviteType)
	if not data then
		return
	end

	for i, value in pairs(data) do
		if inviteType == InviteType.kFriend then
			value.isFriend = 1
		end

		local record = self:getRecordByRid(inviteType, value.rid)

		if not record then
			record = FriendPvpRecord:new()
			self._inviteMap[inviteType][#self._inviteMap[inviteType] + 1] = record
		end

		record:synchronize(value)
	end
end

function FriendPvp:syncInviteListCount(data, inviteType)
	if not data then
		return
	end

	if data.total then
		self._inviteCountMap[inviteType].total = data.total
	end

	if data.online then
		self._inviteCountMap[inviteType].online = data.online
	end
end

function FriendPvp:getRecordByRid(inviteType, rid)
	for i, value in pairs(self._inviteMap[inviteType]) do
		if value:getRid() == rid then
			return value
		end
	end

	return nil
end

function FriendPvp:getInviteListByType(inviteType)
	return self._inviteMap[inviteType] or {}
end

function FriendPvp:getInviteCountByType(inviteType)
	return self._inviteCountMap[inviteType] or {}
end

function FriendPvp:clearInviteList()
	for k, v in pairs(InviteType) do
		self._inviteMap[v] = {}
	end
end

function FriendPvp:clearData()
	self._roomId = nil
	self._guestId = nil
	self._hostId = nil
	self._hostInfo = nil
	self._guestInfo = nil
	self._guestState = nil
end
