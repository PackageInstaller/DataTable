-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/friendPvp/service/FriendPvpService.lua

EVT_FRIENDPVP_DATAUODATA = "EVT_FRIENDPVP_DATAUODATA"
EVT_FRIENDPVP_INVITELIST_SUCC = "EVT_FRIENDPVP_INVITELIST_SUCC"
EVT_FRIENDPVP_KICKOUT = "EVT_FRIENDPVP_KICKOUT"
EVT_FRIENDPVP_ENTERBATTLE = "EVT_FRIENDPVP_ENTERBATTLE"
EVT_FRIENDPVP_FINISHBATTLE = "EVT_FRIENDPVP_FINISHBATTLE"
EVT_FRIENDPVP_RECEIVEINVITATION = "EVT_FRIENDPVP_RECEIVEINVITATION"
EVT_FRIENDPVP_ENTERBATTLE_FAIL = "EVT_FRIENDPVP_ENTERBATTLE_FAIL"
FriendPvpService = class("FriendPvpService", Service, _M)

function FriendPvpService:initialize()
	super.initialize(self)
end

function FriendPvpService:dispose()
	super.dispose(self)
end

function FriendPvpService:requestCreateRoom(params, blockUI, callback)
	local request = self:newRequest(12601, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendPvpService:requestInviteFriend(params, blockUI, callback)
	local request = self:newRequest(12602, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendPvpService:requestAcceptInvitation(params, blockUI, callback)
	local request = self:newRequest(12603, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendPvpService:requestRefuseInvitation(params, blockUI, callback)
	local request = self:newRequest(12604, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendPvpService:requestBattleReady(params, blockUI, callback)
	local request = self:newRequest(12605, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendPvpService:requestCancelReady(params, blockUI, callback)
	local request = self:newRequest(12609, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendPvpService:requestBattleStart(params, blockUI, callback)
	local request = self:newRequest(12606, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendPvpService:requestKickOut(params, blockUI, callback)
	local request = self:newRequest(12608, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendPvpService:requestLeaveRoom(params, blockUI, callback)
	local request = self:newRequest(12607, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendPvpService:requestInvitingList(params, blockUI, callback)
	local request = self:newRequest(12610, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendPvpService:requestFinishBattle(params, blockUI, callback)
	local request = self:newRequest(12611, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendPvpService:requestAckEnterBattle(params, blockUI, callback)
	local request = self:newRequest(12612, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendPvpService:requestPvpConnection(params, blockUI, callback)
	local request = self:newRequest(12614, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendPvpService:requestRefreshRoom(params, blockUI, callback)
	local request = self:newRequest(12615, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendPvpService:requestHeartBeat(params, blockUI, callback)
	local request = self:newRequest(12616, params, callback)

	self:sendRequest(request, blockUI)
end

function FriendPvpService:listenRoomBroadcast(callback)
	self:addPushHandler(1101, function(op, response)
		callback(response)
	end)
end

function FriendPvpService:listenReceiveInvitation(callback)
	self:addPushHandler(1102, function(op, response)
		callback(response)
	end)
end

function FriendPvpService:listenReceiveRefruse(callback)
	self:addPushHandler(1103, function(op, response)
		callback(response)
	end)
end

function FriendPvpService:listenKickOut(callback)
	self:addPushHandler(1104, function(op, response)
		callback(response)
	end)
end

function FriendPvpService:listenOpError(callback)
	self:addPushHandler(1105, function(op, response)
		callback(response)
	end)
end
