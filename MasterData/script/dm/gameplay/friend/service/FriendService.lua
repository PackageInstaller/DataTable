-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/friend/service/FriendService.lua

EVT_FRIEND_GETFRIENDSLIST_SUCC = "EVT_FRIEND_GETFRIENDSLIST_SUCC"
EVT_FRIEND_GETRECOMMENDLIST_SUCC = "EVT_FRIEND_GETRECOMMENDLIST_SUCC"
EVT_FRIEND_ADD_SUCC = "EVT_FRIEND_ADD_SUCC"
EVT_FRIEND_GETAPPLYLIST_SUCC = "EVT_FRIEND_GETAPPLYLIST_SUCC"
EVT_FRIEND_AGREEORREFUSE_SUCC = "EVT_FRIEND_AGREEORREFUSE_SUCC"
EVT_FRIEND_GERPOWER_SUCC = "EVT_FRIEND_GERPOWER_SUCC"
EVT_FRIEND_SENDPOWER_SUCC = "EVT_FRIEND_SENDPOWER_SUCC"
EVT_FRIEND_DELECT_SUCC = "EVT_FRIEND_DELECT_SUCC"
FriendService = class("FriendService", Service, _M)

function FriendService:initialize()
	super.initialize(self)
end

function FriendService:dispose()
	super.dispose(self)
end

function FriendService:requestFriendsMainInfo(params, blockUI, callback)
	local request = self:newRequest(11401, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendService:requestFriendsList(params, blockUI, callback)
	local request = self:newRequest(11402, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendService:requestGetPower(params, blockUI, callback)
	local request = self:newRequest(11404, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendService:requestSendPower(params, blockUI, callback)
	local request = self:newRequest(11403, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendService:requestRecommendList(params, blockUI, callback)
	local request = self:newRequest(11408, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendService:requestFindFriend(params, blockUI, callback)
	local request = self:newRequest(11405, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendService:requestAgreeFriend(params, blockUI, callback)
	local request = self:newRequest(11409, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendService:requestRefuseFriend(params, blockUI, callback)
	local request = self:newRequest(11410, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendService:requestDeleteFriend(params, blockUI, callback)
	local request = self:newRequest(11407, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendService:requestAddFriend(params, blockUI, callback)
	local request = self:newRequest(11406, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendService:requestApplyList(params, blockUI, callback)
	local request = self:newRequest(11411, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendService:requestSimpleFriendInfo(params, blockUI, callback)
	local request = self:newRequest(11412, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendService:requestOneKeyFriends(params, blockUI, callback)
	local request = self:newRequest(11413, params, callback)

	self:sendRequest(request, blockUI)
end
