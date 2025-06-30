-- chunkname: @IQIGame\\Module\\Friend\\FriendModule.lua

FriendModule = {}
FriendModule.FriendDatas = nil
FriendModule.CachedRecommendFriendDatas = nil
FriendModule.LastApplyFriends = nil
FriendModule.LastRequestRecommendTime = 0
FriendModule.TypeEnum = {
	RecommendFriend = 3,
	AddFriend = 2,
	RequestFriend = 4,
	FriendList = 1
}

local FriendData = require("IQIGame.Module.Friend.FriendData")

function FriendModule.Reload(friends)
	FriendModule.FriendDatas = {}
	FriendModule.FriendDatas[Constant.FriendType.TYPE_FRIEND] = {}
	FriendModule.FriendDatas[Constant.FriendType.TYPE_APPLICATION] = {}
	FriendModule.FriendDatas[Constant.FriendType.TYPE_MUTE] = {}
	FriendModule.FriendDatas[Constant.FriendType.TYPE_MY_APPLICATION] = {}

	if friends == nil then
		return
	end

	for i = 1, #friends do
		local friendData = FriendData.New(friends[i])

		table.insert(FriendModule.FriendDatas[friendData.type], friendData)
	end
end

function FriendModule.GetFriends(type)
	return FriendModule.FriendDatas[type]
end

function FriendModule.IsApplied(pId)
	local myApplications = FriendModule.GetFriends(Constant.FriendType.TYPE_MY_APPLICATION)

	for i = 1, #myApplications do
		if myApplications[i].pId == pId then
			return true
		end
	end

	return false
end

function FriendModule.GetMutePlayerByPId(pId)
	local mutedPlayerList = FriendModule.GetFriends(Constant.FriendType.TYPE_MUTE)

	for i = 1, #mutedPlayerList do
		if mutedPlayerList[i].pId == pId then
			return mutedPlayerList[i]
		end
	end

	return nil
end

function FriendModule.GetFriendByPId(pid)
	local friendData
	local friends = FriendModule.FriendDatas[Constant.FriendType.TYPE_FRIEND]

	for i = 1, #friends do
		if friends[i].pId == pid then
			friendData = friends[i]

			break
		end
	end

	return friendData
end

function FriendModule.SendMute(pId)
	net_centerFriend.addBlacklist(pId)
end

function FriendModule.SendClearMute(friendId)
	net_centerFriend.removeBlacklist({
		friendId
	})
end

function FriendModule.GetRecommendFriends()
	if FriendModule.LastRequestRecommendTime > 0 and PlayerModule.GetServerTime() - FriendModule.LastRequestRecommendTime < 3600 then
		EventDispatcher.Dispatch(EventID.GetRecommendFriends, FriendModule.CachedRecommendFriendDatas)
	else
		net_centerFriend.recommend()
	end
end

function FriendModule.SearchPlayerByGUID(guid)
	if guid == PlayerModule.PlayerInfo.baseInfo.guid then
		NoticeModule.ShowNotice(47008)

		return
	end

	net_centerFriend.searchPlayer(guid)
end

function FriendModule.SendSetAlias(friendId, aliasText)
	net_centerFriend.setRemark(friendId, aliasText)
end

function FriendModule.SendDeleteFriend(friendId)
	net_centerFriend.removeFriends({
		friendId
	})
end

function FriendModule.SendDeleteFriends(friendIds)
	net_centerFriend.removeFriends(friendIds)
end

function FriendModule.SendDealWithApplication(friendIds, agree)
	net_centerFriend.dealWithApply(friendIds, agree)
end

function FriendModule.SendApplyFriend(pId)
	FriendModule.LastApplyFriends = {
		pId
	}

	net_centerFriend.applyFriends({
		pId
	})
end

function FriendModule.SendApplyFriends(pIds)
	FriendModule.LastApplyFriends = pIds

	net_centerFriend.applyFriends(pIds)
end

function FriendModule.SearchPlayerResult(friend)
	local friendData

	if friend ~= nil then
		friendData = FriendData.New(friend)
	else
		NoticeModule.ShowNotice(20030)

		return
	end

	EventDispatcher.Dispatch(EventID.SearchPlayerResult, friendData)
end

function FriendModule.GetRecommendFriendsResult(friends)
	local results = {}

	for i = 1, #friends do
		local friendData = FriendData.New(friends[i])

		table.insert(results, friendData)
	end

	FriendModule.CachedRecommendFriendDatas = results
	FriendModule.LastRequestRecommendTime = PlayerModule.GetServerTime()

	EventDispatcher.Dispatch(EventID.GetRecommendFriends, results)
end

function FriendModule.ApplyFriendResult()
	if FriendModule.CachedRecommendFriendDatas ~= nil then
		local isRecommendedPlayer = false

		for i = 1, #FriendModule.LastApplyFriends do
			for j = 1, #FriendModule.CachedRecommendFriendDatas do
				if FriendModule.LastApplyFriends[i] == FriendModule.CachedRecommendFriendDatas[j].pId then
					table.remove(FriendModule.CachedRecommendFriendDatas, j)

					isRecommendedPlayer = true

					break
				end
			end
		end

		if isRecommendedPlayer then
			EventDispatcher.Dispatch(EventID.GetRecommendFriends, FriendModule.CachedRecommendFriendDatas)
		end
	end

	NoticeModule.ShowNotice(20029)
end

function FriendModule.AddFriend(friends)
	local newFriends = {}

	for i = 1, #friends do
		local friendData = FriendData.New(friends[i])

		table.insert(FriendModule.FriendDatas[friendData.type], friendData)
		table.insert(newFriends, friendData)
	end

	EventDispatcher.Dispatch(EventID.AddFriend, newFriends)
	EventDispatcher.Dispatch(EventID.UpdateFriend)
end

function FriendModule.DeleteFriend(ids)
	for i = 1, #ids do
		FriendModule.__RemoveFriendFromCache(ids[i])
	end

	logColorInfo("删除好友成功!", colorCode.Yellow)
	EventDispatcher.Dispatch(EventID.UpdateFriend)
end

function FriendModule.UpdateFriend(friends)
	for i = 1, #friends do
		local friendPOD = friends[i]
		local friendDatas = FriendModule.FriendDatas[friendPOD.type]

		for j = 1, #friendDatas do
			if friendDatas[j].id == friendPOD.id then
				friendDatas[j]:Update(friendPOD)

				break
			end
		end
	end

	EventDispatcher.Dispatch(EventID.UpdateFriend)
end

function FriendModule.__RemoveFriendFromCache(id)
	for type, friendDatas in pairs(FriendModule.FriendDatas) do
		for i = 1, #friendDatas do
			if friendDatas[i].id == id then
				table.remove(friendDatas, i)

				return
			end
		end
	end
end

function FriendModule.SetRemarkResult(friend)
	EventDispatcher.Dispatch(EventID.SetRemarkResult)
end

function FriendModule.GetFriendMaxCount()
	return CfgDiscreteDataTable[9].Data[1]
end

function FriendModule.IsFriend(pId)
	local friendList = FriendModule.FriendDatas[Constant.FriendType.TYPE_FRIEND]

	for i = 1, #friendList do
		if friendList[i].pId == pId then
			return true
		end
	end

	return false
end
