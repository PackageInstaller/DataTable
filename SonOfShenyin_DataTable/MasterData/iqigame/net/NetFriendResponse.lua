-- chunkname: @IQIGame\\Net\\NetFriendResponse.lua

function net_centerFriend.removeFriendsResult(code)
	return
end

function net_centerFriend.applyFriendsResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		if code == 29005 then
			NoticeModule.ShowNoticeByType(1, getErrorMsg(29005))
		else
			NoticeModule.ShowServerError(code)
		end

		return
	end

	FriendModule.ApplyFriendResult()
end

function net_centerFriend.dealWithApplyResult(code)
	return
end

function net_centerFriend.addBlacklistResult(code)
	return
end

function net_centerFriend.removeBlacklistResult(code)
	return
end

function net_centerFriend.searchPlayerResult(code, friend)
	FriendModule.SearchPlayerResult(friend)
end

function net_centerFriend.setRemarkResult(code, friend)
	FriendModule.SetRemarkResult(friend)
end

function net_centerFriend.recommendResult(code, friends)
	FriendModule.GetRecommendFriendsResult(friends)
end

function net_centerFriend.notifyAddFriend(friends)
	FriendModule.AddFriend(friends)
end

function net_centerFriend.notifyDeleteFriend(ids)
	FriendModule.DeleteFriend(ids)
end

function net_centerFriend.notifyUpdateFriend(friends)
	FriendModule.UpdateFriend(friends)
end

function net_centerFriend.recommendHelpHerosResult(code, helpHeros)
	AssistInFightingModule.RecommendHelpHerosResult(code, helpHeros)
end
