-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/friendPvp/controller/FriendPvpSystem.lua

PVP_FINISH_WINNER = "PVP_FINISH_WINNER"
EVT_FRIENDPVP_ERROR_QUIT_ROOM = "EVT_FRIENDPVP_ERROR_QUIT_ROOM"

require("dm.gameplay.friendPvp.model.FriendPvp")

FriendPvpSystem = class("FriendPvpSystem", legs.Actor)

FriendPvpSystem:has("_friendPvpService", {
	is = "r"
}):injectWith("FriendPvpService")
FriendPvpSystem:has("_rtpvpController", {
	is = "r"
}):injectWith("RTPVPController")
FriendPvpSystem:has("_friendPvp", {
	is = "r"
})

function FriendPvpSystem:initialize()
	super.initialize(self)

	self._friendPvp = FriendPvp:new()
	self._receiveInviteMap = {}
	self._inviteTimeMap = {}
	self._screenMap = {}
	self._battleData = nil
	self._forbidFriendInvitePop = false
end

function FriendPvpSystem:listen()
	self:listenRoomBroadcast()
	self:listenReceiveInvitation()
	self:listenReceiveRefruse()
	self:listenKickOut()
	self:listenOpError()
end

function FriendPvpSystem:getReceiveInviteMap()
	return self._receiveInviteMap
end

function FriendPvpSystem:getInviteTimeMap()
	return self._inviteTimeMap
end

function FriendPvpSystem:getBattleData()
	return self._battleData
end

function FriendPvpSystem:setForbidFriendInvitePop(isForbid)
	self._forbidFriendInvitePop = isForbid
end

function FriendPvpSystem:tryEnter(data, gotoView)
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local unlock, tips = systemKeeper:isUnlock("Friend_PK")

	if unlock then
		gotoView = gotoView or function(data)
			local view = self:getInjector():getInstance("FriendPvpView")

			self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))
		end

		self:requestCreateRoom(function()
			gotoView(data)
		end)
	else
		self:dispatch(ShowTipEvent({
			tip = tips
		}))
	end
end

function FriendPvpSystem:showResultView(data)
	local function showResult()
		local developSystem = self:getInjector():getInstance(DevelopSystem)
		local result = developSystem:getPlayer():getRid() == data.result.winner
		local viewName
		local view = self:getInjector():getInstance(result and "FriendPvpWinView" or "FriendPvpLoseView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}, data))
	end

	local developSystem = self:getInjector():getInstance(DevelopSystem)

	if data.result then
		if data.result.winner == developSystem:getPlayer():getRid() then
			if data.result.reason == nil or data.result.reason == "" then
				showResult()

				return
			end

			do
				local tips = ""

				if data.result.detail == "disconnect" or data.result.reason == "disconnect" then
					tips = Strings:get("Friend_Pvp_Tips5")
				elseif data.result.detail == "surrender" or data.result.reason == "surrender" then
					tips = Strings:get("Friend_Pvp_Tips6")
				end

				local outSelf, delegate = self, {}

				function delegate:willClose(popupMediator, data)
					showResult()
				end

				local data = {
					closeTime = 5,
					title = Strings:get("Tip_Remind"),
					content = tips,
					sureBtn = {}
				}
				local view = self:getInjector():getInstance("AlertView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
				}, data, delegate))
			end

			goto label_10_0
		end
	end

	showResult()

	::label_10_0::
end

function FriendPvpSystem:gotoFriendPvpView()
	local hostId = self._friendPvp:getHostId()

	if hostId ~= nil then
		local isHost = false
		local developSystem = self:getInjector():getInstance(DevelopSystem)

		if developSystem:getPlayer():getRid() == hostId then
			isHost = true
		end

		if isHost then
			local systemKeeper = self:getInjector():getInstance("SystemKeeper")
			local unlock, tips = systemKeeper:isUnlock("RTPK_System")

			if unlock then
				self:dispatch(SceneEvent:new(EVT_SWITCH_SCENE, "mainScene", nil, {
					viewName = "RTPvpEntranceView",
					notCreateRoom = true,
					tabType = 2
				}))
			else
				self:dispatch(SceneEvent:new(EVT_SWITCH_SCENE, "mainScene", nil, {
					viewName = "RTPvpEntranceView",
					notCreateRoom = true
				}))
			end
		else
			self:dispatch(SceneEvent:new(EVT_SWITCH_SCENE, "mainScene", nil, {
				viewName = "FriendPvpView",
				isBackEntrance = true
			}))
		end
	else
		local systemKeeper = self:getInjector():getInstance("SystemKeeper")
		local unlock, tips = systemKeeper:isUnlock("RTPK_System")

		if unlock then
			local ladderMatchSystem = self:getInjector():getInstance(LadderMatchSystem)

			ladderMatchSystem:enterLadderMainView(true)
		else
			self:gotoHomeView()
		end
	end
end

function FriendPvpSystem:gotoHomeView(tips)
	self:dispatch(ShowTipEvent({
		tip = tips
	}))
	self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, {
		viewName = "homeView"
	}))
end

function FriendPvpSystem:checkInvitePop(data)
	if not self._receiveInviteMap[data.id] then
		self._receiveInviteMap[data.id] = 1

		return true
	end

	return false
end

function FriendPvpSystem:delReceiveDataByRid(rid)
	if self._receiveInviteMap[rid] then
		self._receiveInviteMap[rid] = nil
	end
end

function FriendPvpSystem:requestInviteFriend(guestId)
	local params = {}

	params.guestId = guestId

	self._friendPvpService:requestInviteFriend(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Friend_Pvp_Tips3")
			}))
		elseif response.resCode == 12304 then
			self:dispatch(Event:new(EVT_FRIENDPVP_ERROR_QUIT_ROOM))
		end
	end)
end

function FriendPvpSystem:requestAcceptInvitation(hostId, callback)
	local params = {}

	params.hostId = hostId

	self._friendPvpService:requestAcceptInvitation(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			-- block empty
		end

		if callback then
			callback(response)
		end
	end)
end

function FriendPvpSystem:requestBattleReady()
	local params = {}

	self._friendPvpService:requestBattleReady(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			-- block empty
		end
	end)
end

function FriendPvpSystem:requestCancelReady()
	local params = {}

	self._friendPvpService:requestCancelReady(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			-- block empty
		end
	end)
end

function FriendPvpSystem:requestBattleStart()
	local params = {}

	self._friendPvpService:requestBattleStart(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			-- block empty
		elseif response.resCode == 12304 then
			self:dispatch(Event:new(EVT_FRIENDPVP_ENTERBATTLE_FAIL, {}))
		end
	end)
end

function FriendPvpSystem:requestRefuseInvitation(hostId, screen, callback)
	local params = {}

	params.hostId = hostId
	params.screen = screen

	self._friendPvpService:requestRefuseInvitation(params, false, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback()
		end
	end)
end

function FriendPvpSystem:requestKickOut()
	local params = {}

	self._friendPvpService:requestKickOut(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_FRIENDPVP_DATAUODATA, {}))
		end
	end)
end

function FriendPvpSystem:requestLeaveRoom()
	local params = {}

	self._friendPvpService:requestLeaveRoom(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self._friendPvp:clearData()
		end
	end)
end

function FriendPvpSystem:requestCreateRoom(callback)
	local params = {}

	params.roomId = roomId

	self._friendPvpService:requestCreateRoom(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self._friendPvp:clearData()
			self._friendPvp:synchronize(response.data)

			if callback then
				callback()
			end
		end
	end)
end

function FriendPvpSystem:requestInvitingList(requestType, requestStart, requestEnd, callback)
	local params = {
		type = requestType,
		start = requestStart,
		["end"] = requestEnd
	}

	self._friendPvpService:requestInvitingList(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			if requestStart == 1 then
				self._friendPvp:clearInviteList()
			end

			if requestType == "friend" then
				self._friendPvp:syncInviteList(response.data.friend, InviteType.kFriend)
				self._friendPvp:syncInviteListCount(response.data, InviteType.kFriend)
			elseif requestType == "club" then
				self._friendPvp:syncInviteList(response.data.club, InviteType.kClub)
				self._friendPvp:syncInviteListCount(response.data, InviteType.kClub)
			end

			self:dispatch(Event:new(EVT_FRIENDPVP_INVITELIST_SUCC, {}))

			if callback then
				callback()
			end
		end
	end)
end

function FriendPvpSystem:requestFinishBattle(roomId, resultData)
	local params = {}

	params.roomId = roomId

	self._friendPvpService:requestFinishBattle(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			if response.data.op == -1 then
				self:gotoHomeView()

				return
			end

			local data = {
				playerInfo = response.data.battleInfo,
				result = resultData
			}

			self:showResultView(data)

			if response.data.state == FriendPvpState.kHostKickOut then
				self._friendPvp:clearData()
			end

			self._friendPvp:synchronize(response.data)
			self:dispatch(Event:new(EVT_FRIENDPVP_DATAUODATA, {}))
		end
	end)
end

function FriendPvpSystem:requestAckEnterBattle(roomId, callback)
	local params = {}

	self._friendPvpService:requestAckEnterBattle(params, false, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end
		else
			self:dispatch(Event:new(EVT_FRIENDPVP_FINISHBATTLE, {}))
		end
	end)
end

function FriendPvpSystem:requestPvpConnection(succeed, callback)
	local params = {}

	params.succeed = succeed

	self._friendPvpService:requestPvpConnection(params, false, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback()
		end
	end)
end

function FriendPvpSystem:requestRefreshRoom(callback)
	local params = {}

	self._friendPvpService:requestRefreshRoom(params, false, function(response)
		if response.resCode == GS_SUCCESS then
			self._friendPvp:clearData()
			self._friendPvp:synchronize(response.data)

			if callback then
				callback()
			end
		end
	end)
end

function FriendPvpSystem:requestHeartBeat(callback)
	local params = {}

	self._friendPvpService:requestHeartBeat(params, false, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback()
		end
	end)
end

function FriendPvpSystem:listenRoomBroadcast()
	self._friendPvpService:listenRoomBroadcast(function(response)
		if response.op == FriendPvpState.kHostLeave or response.op == FriendPvpState.kHostKickOut or response.op == FriendPvpState.kGuestLeave then
			self._friendPvp:clearData()
		end

		self._friendPvp:synchronize(response)

		if response.op == FriendPvpState.kHostLeave then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Friend_Pvp_HostLeave")
			}))
			self:dispatch(Event:new(EVT_FRIENDPVP_KICKOUT, {}))

			return
		end

		self:dispatch(Event:new(EVT_FRIENDPVP_DATAUODATA, response))

		if response.op == FriendPvpState.kBattle then
			self._battleData = response

			self:dispatch(Event:new(EVT_FRIENDPVP_ENTERBATTLE, {}))
		end

		if response.op == FriendPvpState.kGuestEnter then
			local hostId = self._friendPvp:getHostId()
			local developSystem = self:getInjector():getInstance(DevelopSystem)
			local playerRid = developSystem:getPlayer():getRid()

			if response.type == "DateBattle" then
				if playerRid == hostId then
					self:dispatch(ShowTipEvent({
						tip = Strings:get("DateBattle_Tip3")
					}))
				else
					self:dispatch(ShowTipEvent({
						tip = Strings:get("DateBattle_Tip4")
					}))
				end

				delayCallByTime(1000, function()
					local data = {
						type = response.type
					}
					local view = self:getInjector():getInstance("FriendPvpView")

					self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))
				end)
			elseif playerRid ~= hostId then
				local view = self:getInjector():getInstance("FriendPvpView")

				self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {}))
			end
		end
	end)
end

function FriendPvpSystem:listenReceiveInvitation()
	self._friendPvpService:listenReceiveInvitation(function(response)
		self:dispatch(Event:new(EVT_FRIENDPVP_RECEIVEINVITATION, response))
	end)
end

function FriendPvpSystem:listenReceiveRefruse()
	self._friendPvpService:listenReceiveRefruse(function(response)
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Friend_Pvp_Invite_Tips4")
		}))
	end)
end

function FriendPvpSystem:listenKickOut()
	self._friendPvpService:listenKickOut(function(response)
		self._friendPvp:clearData()
		self:dispatch(ShowTipEvent({
			tip = Strings:get("FriendPvp_TIPS05")
		}))
		self:dispatch(Event:new(EVT_FRIENDPVP_KICKOUT, {}))
	end)
end

function FriendPvpSystem:listenOpError()
	self._friendPvpService:listenOpError(function(response)
		if response.code == 2001 then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("12306")
			}))
		end

		if response.code == 2002 then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Friend_Pvp_Error")
			}))
		end

		if response.code == 1001 then
			delayCallByTime(1000, function()
				self:dispatch(ShowTipEvent({
					tip = Strings:get("Friend_Pvp_Invite_Tips5")
				}))
			end)
		end
	end)
end

function FriendPvpSystem:enterBattle(battleServerIP, battleServerPort, roomId, battleData, type)
	self._rtpvpController:enterRTPVP(battleServerIP, battleServerPort, roomId, battleData, type)
end

function FriendPvpSystem:connectSucc()
	self._rtpvpController:connectSucc()
end
