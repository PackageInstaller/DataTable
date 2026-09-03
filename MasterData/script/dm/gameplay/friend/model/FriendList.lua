-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/friend/model/FriendList.lua

kFriendType = {
	kFind = 3,
	kGame = 1,
	kApply = 4,
	kBlack = 5,
	kRecent = 2
}

require("dm.gameplay.friend.model.Friend")

FriendList = class("FriendList", objectlua.Object, _M)

FriendList:has("_friendListMap", {
	is = "rw"
})
FriendList:has("_friendCountMap", {
	is = "rw"
})
FriendList:has("_receiveTimes", {
	is = "rw"
})
FriendList:has("_sendTimes", {
	is = "rw"
})
FriendList:has("_recentData", {
	is = "rw"
})
FriendList:has("_friendApplyCount", {
	is = "rw"
})
FriendList:has("_addTimes", {
	is = "rw"
})

function FriendList:initialize()
	super.initialize(self)

	self._friendListMap = {}
	self._friendCountMap = {}

	for k, v in pairs(kFriendType) do
		self._friendListMap[v] = {}
		self._friendCountMap[v] = 0
	end

	self._friendApplyCount = 0
end

function FriendList:synchronize(data, friendType, isClean)
	if not data then
		return
	end

	if isClean then
		self._friendListMap[friendType] = {}
	end

	if data.friendsList then
		for i, value in pairs(data.friendsList) do
			local friend = self:getFriendByRid(friendType, value.rid)

			if not friend then
				friend = Friend:new()

				friend:synchronize(value)

				self._friendListMap[friendType][#self._friendListMap[friendType] + 1] = friend
			else
				friend:synchronize(value)
			end
		end
	end

	if data.friendsCount then
		self._friendCountMap[friendType] = data.friendsCount
	end
end

function FriendList:syncFriendInfo(data)
	if data.receiveTimes then
		self._receiveTimes = data.receiveTimes.value
	end

	if data.sendTimes then
		self._sendTimes = data.sendTimes.value
	end

	if data.addTimes then
		self._addTimes = data.addTimes.value
	end
end

function FriendList:getFriendByRid(friendType, rid)
	for i, value in pairs(self._friendListMap[friendType]) do
		if value:getRid() == rid then
			return value
		end
	end

	return nil
end

function FriendList:getFriendList(friendType)
	return self._friendListMap[friendType]
end

function FriendList:getOnlineFriendList(friendType)
	local friends = {}

	for i = 1, #self._friendListMap[friendType] do
		local friendData = self._friendListMap[friendType][i]

		if friendData:getOnline() == false or friendData:getOnline() == 0 then
			-- block empty
		else
			table.insert(friends, friendData)
		end
	end

	return friends
end

function FriendList:getFriendCount(friendType)
	return self._friendCountMap[friendType]
end

function FriendList:getMaxFriendsCount()
	return ConfigReader:getDataByNameIdAndKey("ConfigValue", "Friend_MaxAmount", "content")
end

function FriendList:getMaxApplyFriendsCount()
	local config = ConfigReader:getDataByNameIdAndKey("Reset", "Friend_add", "ResetSystem")

	return config and config.setValue
end

function FriendList:getMaxFindFriendsCount()
	return ConfigReader:getDataByNameIdAndKey("ConfigValue", "Friend_Apply_MaxAmount", "content")
end

function FriendList:getBlockFriendsCount()
	return ConfigReader:getDataByNameIdAndKey("ConfigValue", "Blacklist_MaxAmount", "content")
end

function FriendList:updateFriendCount(friendType, changeCount)
	self._friendCountMap[friendType] = self._friendCountMap[friendType] + changeCount
end

function FriendList:removeFriend(friendType, ridList)
	for _, rid in pairs(ridList) do
		for i, value in pairs(self._friendListMap[friendType]) do
			if rid == value:getRid() then
				table.remove(self._friendListMap[friendType], i)
			end
		end
	end
end

function FriendList:syncFriendfamiliarity(ridList)
	for rid, value in pairs(ridList) do
		local friend = self:getFriendByRid(kFriendType.kGame, rid)

		if friend then
			friend:setFamiliarity(value)
		end
	end
end

function FriendList:syncSendStatus(ridList)
	for i, rid in pairs(ridList) do
		local friend = self:getFriendByRid(kFriendType.kGame, rid)

		if friend then
			friend:setCanSend(false)
		end
	end
end

function FriendList:syncReceiveStatus(ridList)
	for i, rid in pairs(ridList) do
		local friend = self:getFriendByRid(kFriendType.kGame, rid)

		if friend then
			friend:setCanReceive(false)
		end
	end
end

function FriendList:getMaxRecentCount()
	return ConfigReader:getDataByNameIdAndKey("ConfigValue", "Friend_RecentAmount", "content")
end

function FriendList:getRequestCountPerTime()
	return ConfigReader:getDataByNameIdAndKey("ConfigValue", "Friend_PageCount", "content")
end

function FriendList:addRecentFriend(data, time)
	self._recentData = Friend:new()

	self._recentData:synchronize(data)

	self._recentData.time = time
end

function FriendList:clearRecentData()
	self._recentData = nil
end
