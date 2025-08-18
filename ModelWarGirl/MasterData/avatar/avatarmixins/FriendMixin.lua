-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\FriendMixin.lua

local OtherPlayer = require("Common/Object/OtherPlayer")
local EventConst = require("EventConst")
local FriendMixin = {}

function FriendMixin:initFriendMixin()
	self.friendList = {}
	self.inviteList = {}
	self.blackList = {}
	self.recommendList = {}
	self.onlineInfoList = {}
	self.friendSend = 0
	self.friendReceive = 0

	self:checkInviteHint()
	self:checkFriendGiftHint()
end

function FriendMixin:_getFriendDataByServerData(baseData, oldData)
	if baseData.simple.comm.uid == self.uid then
		return nil
	end

	if oldData then
		oldData:updateFriendData(baseData)

		return oldData
	else
		local buddyInfo = OtherPlayer()

		buddyInfo:initFriendData(baseData)

		return buddyInfo
	end
end

function FriendMixin:newDayFriendData()
	for _, friend in pairs(self.friendList) do
		friend:newDayFriendData()
	end

	self.friendSend = 0
	self.friendReceive = 0

	self:_refreshFriendPage()
end

function FriendMixin:onBuddyInfoNotify(buddies, giftInfo)
	for i, buddyItem in ipairs(buddies) do
		local uid = buddyItem.base.simple.comm.uid

		self.friendList[uid] = self:_getFriendDataByServerData(buddyItem.base)
	end

	for gName, gValue in pairs(giftInfo) do
		if gName == "given" then
			self.friendSend = gValue
		elseif gName == "got" then
			self.friendReceive = gValue
		end
	end

	self:checkFriendGiftHint()
end

function FriendMixin:onBuddyAddNotify(buddy)
	if not buddy.base then
		return
	end

	local uid = buddy.base.simple.comm.uid

	self.friendList[uid] = self:_getFriendDataByServerData(buddy.base)

	if self.inviteList[uid] then
		self.inviteList[uid] = nil

		self:checkInviteHint()
	end

	local name = self.friendList[uid].name or ""

	MsgManager.notice(string.format(Lang.get(1839), name))
	self:_resetFriendPage()
end

function FriendMixin:checkInviteHint()
	if next(self.inviteList) ~= nil then
		RedDotManager.setKeyState(UIConst.RD_HINT_FRIEND_REQUEST, true)
	else
		RedDotManager.setKeyState(UIConst.RD_HINT_FRIEND_REQUEST, false)
	end

	local friendRequestListDlg = UIManager.getUI("friendRequestListDlg", nil, false)

	if friendRequestListDlg then
		friendRequestListDlg:refreshData()
	end

	local friendMainDlg = UIManager.getUI("friendMainDlg", nil, false)

	if friendMainDlg then
		friendMainDlg:refreshInviteState()
	end
end

function FriendMixin:checkFriendGiftHint()
	local players = self:getSortedFriends()
	local getCount = CurAvatar:getFriendGetCount()
	local getIds = {}

	for index, player in ipairs(players) do
		if player.giftGet and not player.giftReceive then
			table.insert(getIds, player.uid)
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_FRIEND_GIFT, #getIds > 0 and getCount > 0)
end

function FriendMixin:onBuddyDelNotify(uid)
	if self.friendList[uid] then
		self.friendList[uid] = nil
	end

	self:_resetFriendPage()
	self:checkFriendGiftHint()

	local ui = UIManager.getUI("roleInfoOtherDlg", nil, false)

	if ui then
		ui:setVisible(false)
	end
end

function FriendMixin:onBuddyInviteOpResp(uid, optype, fail, has_more)
	for index, failInfo in ipairs(fail) do
		if failInfo.reason == "kCSErrorBuddyTargetIsFull" then
			MsgManager.notice(Lang.get(1842))
		end
	end

	if has_more ~= 0 or optype == "kBuddyInviteAccept" then
		-- block empty
	elseif optype == "kBuddyInviteRefuse" then
		MsgManager.notice(Lang.get(1843))
	elseif optype == "kBuddyInviteAcceptAll" then
		if #fail == 0 then
			MsgManager.notice(Lang.get(1844))
		elseif next(self.inviteList) and self:getFriendCount() >= Const.MAX_FRIEND_NUM then
			MsgManager.notice(Lang.get(1845))
		end
	elseif optype == "kBuddyInviteRefuseAll" then
		MsgManager.notice(Lang.get(1846))

		self.inviteList = {}

		self:checkInviteHint()
	end
end

function FriendMixin:onBuddyInviteNotify(invite)
	self.inviteList = {}

	for i, inviteItem in ipairs(invite) do
		local uid = inviteItem.base.simple.comm.uid

		self.inviteList[uid] = self:_getFriendDataByServerData(inviteItem.base)
	end

	self:checkInviteHint()
end

function FriendMixin:onBuddyInviteAddNotify(invite)
	if not invite.base then
		return
	end

	local uid = invite.base.simple.comm.uid

	self.inviteList[uid] = self:_getFriendDataByServerData(invite.base)

	self:checkInviteHint()
end

function FriendMixin:onBuddyInviteDelNotify(uid)
	if self.inviteList[uid] then
		self.inviteList[uid] = nil
	end

	self:checkInviteHint()
end

function FriendMixin:onBuddyBlackListNotify(item)
	for i, buddyItem in ipairs(item) do
		local uid = buddyItem.base.simple.comm.uid

		if uid then
			self.blackList[uid] = self:_getFriendDataByServerData(buddyItem.base)
		end
	end

	self:_refreshFriendPage()
	self:_refreshBlackListDlg()
end

function FriendMixin:onBuddyBlackListAddResp(item)
	local uid = item.base.simple.comm.uid

	if uid then
		self.blackList[uid] = self:_getFriendDataByServerData(item.base)

		MsgManager.notice(string.format(Lang.get(1840), self.blackList[uid].name))

		for index, containers in ipairs({
			self.friendList,
			self.inviteList
		}) do
			containers[uid] = nil
		end

		self:_refreshFriendPage()
		self:_refreshBlackListDlg()
	end

	self:checkFriendGiftHint()
end

function FriendMixin:onBuddyBlackListDelResp(uid)
	if self.blackList[uid] then
		local name = self.blackList[uid].name

		self.blackList[uid] = nil

		MsgManager.notice(string.format(Lang.get(1841), name))
		self:_refreshFriendPage()
		self:_refreshBlackListDlg()
	end

	self:checkFriendGiftHint()
end

function FriendMixin:onBuddySearchResp(result, respCode)
	local friendAddDlg = UIManager.getUI("friendAddDlg", nil, false)

	if friendAddDlg then
		friendAddDlg:showSearchResult(result, respCode)
	end
end

function FriendMixin:onBuddyRecommendResp(items)
	local recommendList = {}

	for i, recItem in ipairs(items) do
		local newPlayer = OtherPlayer()

		newPlayer:initFriendData(recItem.base)
		table.insert(recommendList, newPlayer)
	end

	local friendAddDlg = UIManager.getUI("friendAddDlg", nil, false)

	if friendAddDlg then
		friendAddDlg:showRecommendResult(recommendList)
	end
end

function FriendMixin:onBuddyBondSetResp(uid, bond)
	if self.friendList[uid] then
		self.friendList[uid]:updateConfidant(bond)
		self:_refreshFriendPage()
	end
end

function FriendMixin:getBlackProcess()
	local nowCount = 0

	for k, v in pairs(self.blackList) do
		nowCount = nowCount + 1
	end

	return nowCount, Const.MAX_BUDDY_BLACKLISTNUM
end

local function FriendSortFunc(friendA, friendB)
	if friendA.online and friendB.online then
		return friendA.level > friendB.level
	elseif friendA.online then
		return true
	elseif friendB.online then
		return false
	else
		return friendA.logout_tick > friendB.logout_tick
	end
end

function FriendMixin:getSortedFriends()
	local curPlayers = {}

	for _, player in pairs(self.friendList) do
		table.insert(curPlayers, player)
	end

	table.sort(curPlayers, FriendSortFunc)

	return curPlayers
end

function FriendMixin:getFriendCount()
	local nowCount = 0

	for k, v in pairs(self.friendList) do
		nowCount = nowCount + 1
	end

	return nowCount
end

function FriendMixin:getFriendSendCount()
	return Const.MAX_FRIEND_GIFT_SEND_NUM - self.friendSend
end

function FriendMixin:getFriendGetCount()
	return Const.MAX_FRIEND_GIFT_GET_NUM - self.friendReceive
end

function FriendMixin:getFriendInviteCount()
	local nowCount = 0

	for k, v in pairs(self.inviteList) do
		nowCount = nowCount + 1
	end

	return nowCount
end

function FriendMixin:isMyFriend(uid)
	if self.friendList and self.friendList[uid] then
		return true
	else
		return false
	end
end

function FriendMixin:inMyBlackList(uid)
	if self.blackList and self.blackList[uid] then
		return true
	else
		return false
	end
end

function FriendMixin:getConfidantCount()
	local count = 0

	for uid, friend in pairs(self.friendList) do
		if friend.isMyConfidant then
			count = count + 1
		end
	end

	return count
end

function FriendMixin:isMyConfidant(uid)
	local friend = self.friendList[uid]

	if friend and friend.isMyConfidant then
		return true
	else
		return false
	end
end

function FriendMixin:setConfidantOnMe(uid)
	local friend = self.friendList[uid]

	if friend and friend.confidantOnMe then
		return true
	else
		return false
	end
end

function FriendMixin:getRecommendList()
	if self.recommendList and #self.recommendList > 0 then
		return self.recommendList
	end
end

function FriendMixin:onlineRequest(uidList, callback)
	if not self.onlineRequestCallback then
		self.onlineRequestCallback = {}
	end

	if not self.lastGetRoleOnlineCd then
		self.lastGetRoleOnlineCd = 0
	end

	if ClientUtils.getServerTime() - self.lastGetRoleOnlineCd > Const.GET_ROLE_ONLINE_CD then
		if callback then
			table.insert(self.onlineRequestCallback, callback)
		end

		RPC.infoGetRoleOnline(uidList)

		self.lastGetRoleOnlineCd = ClientUtils.getServerTime()
	end
end

function FriendMixin:roleOnlineReq()
	local requestList = {}
	local recordDict = {}

	for index, containers in pairs({
		self.friendList
	}) do
		for uid, _ in pairs(containers) do
			if not recordDict[uid] then
				table.insert(requestList, uid)

				recordDict[uid] = true
			end
		end
	end
end

function FriendMixin:addFriend(uid)
	if self:isMyFriend(uid) then
		MsgManager.notice(Lang.get(1847))
	elseif self:getFriendCount() >= Const.MAX_FRIEND_NUM then
		MsgManager.notice(Lang.get(1848))
	elseif self:inMyBlackList(uid) then
		MsgManager.notice(Lang.get(1849))
	else
		MsgManager.notice(Lang.get(1850))
		RPC.buddyAdd(uid)

		return true
	end
end

function FriendMixin:onBuddyUpdateNotify(buddys)
	for _, buddy in ipairs(buddys) do
		if not buddy.base then
			return
		end

		local uid = buddy.base.simple.comm.uid

		if self.friendList[uid] then
			self.friendList[uid] = self:_getFriendDataByServerData(buddy.base, self.friendList[uid])
		end
	end

	self:_refreshFriendPage()
	self:checkFriendGiftHint()
end

function FriendMixin:onBuddySocialNotify(buddies, giftInfo)
	for i, buddyItem in ipairs(buddies) do
		local uid = buddyItem.uid

		if self.friendList[uid] then
			self.friendList[uid]:updateFriendData(buddyItem)
		end
	end

	for gName, gValue in pairs(giftInfo) do
		if gName == "given" then
			self.friendSend = gValue
		elseif gName == "got" then
			self.friendReceive = gValue
		end
	end

	self:_refreshFriendPage()
	self:checkFriendGiftHint()
end

function FriendMixin:_refreshBlackListDlg()
	local friendBlackListDlg = UIManager.getUI("friendBlackListDlg", nil, false)

	if friendBlackListDlg then
		friendBlackListDlg:refreshData()
	end
end

function FriendMixin:_refreshFriendPage()
	EventCenter.sendEvent(EventConst.FRIEND_DATA_CHANGE)

	local friendMainDlg = UIManager.getUI("friendMainDlg", nil, false)

	if friendMainDlg then
		friendMainDlg:refreshPlayer()
	end

	local ui = UIManager.getUI("roleInfoOtherDlg", nil, false)

	if ui then
		ui:refreshUI()
	end

	ui = UIManager.getUI("chatDlg", nil, false)

	if ui then
		ui:refreshFriendList()
	end

	local catRaceMainDlg = UIManager.tryGetUI("activityCatRaceMainDlg")

	if catRaceMainDlg then
		catRaceMainDlg:forceResetFriend()
	end
end

function FriendMixin:_resetFriendPage()
	local friendMainDlg = UIManager.getUI("friendMainDlg", nil, false)

	if friendMainDlg then
		friendMainDlg:resetPlayer()
	end

	local ui = UIManager.getUI("roleInfoOtherDlg", nil, false)

	if ui then
		ui:refreshUI()
	end
end

return FriendMixin
