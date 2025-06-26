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

function net_centerFriend.dealWithApplyResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		if code == 29004 then
			NoticeModule.ShowNotice(21040034)
		elseif code == 29005 then
			NoticeModule.ShowNotice(21040035)
		else
			NoticeModule.ShowServerError(code)
		end
	end

	net_centerFriend.dealWithApplyResult(code)
end

function net_centerFriend.dealWithApplyResult(code)
	return
end

function net_centerFriend.addBlacklistResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		if code == 29003 then
			NoticeModule.ShowNotice(21045083)
		else
			NoticeModule.ShowServerError(code)
		end

		return
	end

	net_centerFriend.addBlacklistResult(code)
end

function net_centerFriend.addBlacklistResult(code)
	NoticeModule.ShowNotice(21045082)
end

function net_centerFriend.removeBlacklistResult(code)
	return
end

function net_centerFriend.searchPlayerResult(code, friend)
	FriendModule.SearchPlayerResult(friend)
end

function net_centerFriend.setRemarkResult(code, friend)
	return
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
