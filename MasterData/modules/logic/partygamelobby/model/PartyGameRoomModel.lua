-- chunkname: @modules/logic/partygamelobby/model/PartyGameRoomModel.lua

module("modules.logic.partygamelobby.model.PartyGameRoomModel", package.seeall)

local PartyGameRoomModel = class("PartyGameRoomModel", BaseModel)

function PartyGameRoomModel:onReceivePartyServerListReply(msg)
	if tabletool.len(self._partyServers) > 0 then
		return
	end

	self._partyServers = {}

	local partyServers = msg.partyServers

	if partyServers then
		for _, info in ipairs(partyServers) do
			local mo = ProcessInfoMO.New()

			mo:init(info)

			self._partyServers[info.id] = mo
		end

		self:pingServerList()
	end
end

function PartyGameRoomModel:pingServerList(pingCompletedCb, pingCompletedObj)
	if pingCompletedCb then
		self._pingCompletedCb = pingCompletedCb
		self._pingCompletedObj = pingCompletedObj
		self._runningPingObjList = {}
	end

	if self._pingCompletedCb then
		callWithCatch(self._pingCompletedCb, self._pingCompletedObj)

		self._pingCompletedCb = nil
		self._pingCompletedObj = nil
	end
end

function PartyGameRoomModel:onOnePingObjCompleted(pingObj)
	if not self._pingCompletedCb then
		return
	end

	local key = pingObj:ip()

	if not self._runningPingObjList[key] then
		return
	end

	self._runningPingObjList[key] = nil

	if not next(self._runningPingObjList) and self._pingCompletedCb then
		callWithCatch(self._pingCompletedCb, self._pingCompletedObj)

		self._pingCompletedCb = nil
		self._pingCompletedObj = nil
	end
end

function PartyGameRoomModel:_clearPingObjList()
	GameUtil.onDestroyViewMemberList(self, "_pingObjList")

	self._pingObjList = {}
	self._runningPingObjList = {}
	self._pingCompletedCb = nil
	self._pingCompletedObj = nil
end

function PartyGameRoomModel:getFastestPartyServerMO()
	local fastestMO

	for _, mo in pairs(self._partyServers) do
		local ms = mo:getMs()

		if ms ~= -1 then
			if not fastestMO then
				fastestMO = mo
			elseif ms < fastestMO:getMs() then
				fastestMO = mo
			end
		end
	end

	return fastestMO
end

function PartyGameRoomModel:getFastestAreaId()
	local allIdList = {}
	local count = tabletool.len(self._partyServers)

	for i, _ in pairs(self._partyServers) do
		table.insert(allIdList, i)
	end

	local areaId = allIdList[math.random(1, count)]

	areaId = math.floor(areaId / 10000)

	return areaId
end

function PartyGameRoomModel:onInit()
	self:reInit()
end

function PartyGameRoomModel:reInit()
	self._partyServers = {}

	self:_clearPingObjList()

	self._playerInfoUpdateTime = nil
	self._matchTime = nil
	self._matchInfo = nil
	self._matchStatus = nil
	self._roomId = nil
	self._friendModel = nil
	self._playerInfos = ListScrollModel.New()
	self._friendInfos = {}
	self._diffMap = {}
	self._inviteCDMap = {}
	self._mainPlayerPos = {}
	self._refuseInfos = {}
end

function PartyGameRoomModel:clearRoom()
	self._playerInfoUpdateTime = nil
	self._matchTime = nil
	self._matchInfo = nil
	self._matchStatus = nil
	self._roomId = 0

	self._playerInfos:clear()
	tabletool.clear(self._friendInfos)
	tabletool.clear(self._inviteCDMap)
	tabletool.clear(self._mainPlayerPos)
end

function PartyGameRoomModel:addRefuseInfo(roomId, fromUserId, refuseType)
	if not self._refuseInfos[roomId] then
		local roomInfo = {}

		if not roomInfo[fromUserId] then
			local userInfo = {}

			if userInfo.refuseType == PartyGameLobbyEnum.RefuseType.Active then
				return
			end

			if userInfo.refuseType ~= refuseType then
				userInfo.refuseType = refuseType
				userInfo.refuseNum = 1
				userInfo.refuseTime = ServerTime.now()
			else
				userInfo.refuseNum = userInfo.refuseNum + 1
				userInfo.refuseTime = ServerTime.now()
			end

			self._refuseInfos[roomId] = roomInfo
			roomInfo[fromUserId] = userInfo
		end
	end
end

function PartyGameRoomModel:getRefuseInfo(roomId, fromUserId)
	local roomInfo = self._refuseInfos[roomId]

	if roomInfo then
		return roomInfo[fromUserId]
	end
end

function PartyGameRoomModel:setMainPlayerPos(x, y)
	self._mainPlayerPos.x = x
	self._mainPlayerPos.y = y
end

function PartyGameRoomModel:getMainPlayerPos()
	return self._mainPlayerPos.x, self._mainPlayerPos.y
end

function PartyGameRoomModel:setMatchTime(time)
	self._matchTime = time
end

function PartyGameRoomModel:getMatchTime()
	return self._matchTime
end

function PartyGameRoomModel:setMatchStatus(status)
	local oldStatus = self._matchStatus

	self._matchStatus = status

	PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.MatchStatusChange, status, oldStatus)
end

function PartyGameRoomModel:getMatchStatus()
	return self._matchStatus
end

function PartyGameRoomModel:inGameMatch()
	return self._matchStatus and self._matchStatus ~= PartyGameLobbyEnum.MatchStatus.NoMatch
end

function PartyGameRoomModel:setInviteCD(id)
	if not self:inGameRoom() then
		return
	end

	local roomId = self:getRoomId()

	self._inviteCDMap[roomId] = self._inviteCDMap[roomId] or {}
	self._inviteCDMap[roomId][id] = ServerTime.now()
end

function PartyGameRoomModel:getInviteCD(id)
	if not self:inGameRoom() then
		return ServerTime.now()
	end

	local roomId = self:getRoomId()
	local roomInfo = self._inviteCDMap[roomId]

	return (roomInfo or nil) and (roomInfo[id] or 0)
end

function PartyGameRoomModel:isRoomOwner()
	local uid = PlayerModel.instance:getMyUserId()
	local playerInfoMo = self._playerInfos:getById(uid)

	return playerInfoMo and playerInfoMo.isRoomOwner
end

function PartyGameRoomModel:getMyPlayerInfo()
	local uid = PlayerModel.instance:getMyUserId()

	return self:getPlayerInfo(uid)
end

function PartyGameRoomModel:getPlayerInfo(id)
	return self._playerInfos:getById(id)
end

function PartyGameRoomModel:createRoom(roomId, version)
	self:setRoomId(roomId)

	local playerInfo = PlayerModel.instance:getPlayinfo()
	local mo = PartyPlayerInfoMO.New()

	mo.userId = PlayerModel.instance:getMyUserId()
	mo.id = mo.userId
	mo.status = PartyGameLobbyEnum.RoomOperateState.NotReady
	mo.isRoomOwner = true
	mo.name = playerInfo.name
	mo.portrait = playerInfo.portrait
	mo.wearClothIds = {}
	mo.version = version

	self:setPlayerInfos({
		mo
	})
end

function PartyGameRoomModel.getResVersion()
	if isDebugBuild and PartyGameRoomModel._fakeResVersion then
		local paramList = string.splitToNumber(PartyGameRoomModel._fakeResVersion, ".")
		local first = paramList[1]
		local second = paramList[2]
		local third = paramList[3]

		return (PartyGameRoomModel.getVersion(first, second, third))
	end

	local versionData = SLFramework.GameUpdate.HotUpdateInfoMgr.LocalVersionData
	local first = versionData.first
	local second = versionData.second
	local third = versionData.third

	return (PartyGameRoomModel.getVersion(first, second, third))
end

function PartyGameRoomModel.getVersion(first, second, third)
	local correct = true

	if first <= 0 or second > 0 or third >= 10000 then
		logError(string.format("PartyGameRoomModel.getVersion overflow1 error: %d.%d.%d", first, second, third))

		correct = false
	end

	local version = first * 1000000 + second * 10000 + third

	if version > 2147483647 then
		logError(string.format("PartyGameRoomModel.getVersion overflow2 error: %d.%d.%d,version:%s", first, second, third, version))

		correct = false
	end

	return version, correct
end

function PartyGameRoomModel:setRoomId(id)
	self._roomId = id
end

function PartyGameRoomModel:getRoomId()
	return self._roomId
end

function PartyGameRoomModel:inGameRoom()
	return self._roomId and tonumber(self._roomId) > 0
end

function PartyGameRoomModel:setFriendInfos(list)
	self._friendInfos = GameUtil.rpcInfosToMap(list, FriendInfoMO, "userId")

	PartyGameStatHelper.instance:logPartyFriendsInfo(self._friendInfos)
end

function PartyGameRoomModel:updateFriendInfo(info)
	if not self._friendInfos[info.userId] then
		local mo = FriendInfoMO.New()

		self._friendInfos[info.userId]:init(info)

		self._friendInfos[info.userId] = self._friendInfos[info.userId]
	end
end

function PartyGameRoomModel:getFriendInfo(id)
	return self._friendInfos[id]
end

function PartyGameRoomModel:KickOutPlayer(kickOutUserId)
	local mo = self._playerInfos:getById(kickOutUserId)

	if mo then
		self._playerInfos:remove(mo)
	end
end

function PartyGameRoomModel:updatePlayerPos(uid, x, z)
	local mo = self._playerInfos:getById(uid)

	if mo and x and z then
		mo.pos.x = x / PartyGameLobbyEnum.MovePosScale
		mo.pos.z = z / PartyGameLobbyEnum.MovePosScale
	end
end

function PartyGameRoomModel:getOtherPlayerList(ret)
	local list = self._playerInfos:getList()
	local myUserId = PlayerModel.instance:getMyUserId()

	for i, v in ipairs(list) do
		if v.id ~= myUserId and tonumber(v.id) > 0 then
			table.insert(ret, v.id)
		end
	end
end

function PartyGameRoomModel:getOtherPlayerInfoList()
	local ret = {}
	local list = self._playerInfos:getList()
	local myUserId = PlayerModel.instance:getMyUserId()

	for i, v in ipairs(list) do
		if v.id ~= myUserId and tonumber(v.id) > 0 then
			table.insert(ret, v)
		end
	end

	return ret
end

function PartyGameRoomModel:isAllReady()
	local list = self._playerInfos:getList()
	local myUserId = PlayerModel.instance:getMyUserId()

	for i, v in ipairs(list) do
		if v.id ~= myUserId and tonumber(v.id) > 0 and v.status == PartyGameLobbyEnum.RoomOperateState.NotReady then
			return
		end
	end

	return true
end

function PartyGameRoomModel:ChangeRoomOwner(newOwnerUserId)
	local list = self._playerInfos:getList()

	for i, v in ipairs(list) do
		v.isRoomOwner = v.uid == newOwnerUserId
	end
end

function PartyGameRoomModel:getDiffMap()
	return self._diffMap
end

function PartyGameRoomModel:clearDiffMap()
	tabletool.clear(self._diffMap)
end

function PartyGameRoomModel:getPlayerNum()
	local num = 0
	local list = self._playerInfos:getList()

	for i, v in ipairs(list) do
		if tonumber(v.id) > 0 then
			num = num + 1
		end
	end

	return num
end

function PartyGameRoomModel:setMatchInfo(matchInfo)
	self._matchInfo = matchInfo
end

function PartyGameRoomModel:getMatchInfo()
	return self._matchInfo
end

function PartyGameRoomModel:setPlayerInfos(infos, markDiff)
	local prevOwner

	if markDiff then
		prevOwner = self:isRoomOwner()

		self:clearDiffMap()
	end

	local list = {}

	for i, v in ipairs(infos) do
		local mo = PartyPlayerInfoMO.New()

		mo:init(v)
		table.insert(list, mo)

		if markDiff and not self._playerInfos:getById(mo.id) then
			self._diffMap[mo.id] = true
		end
	end

	while #list < PartyGameLobbyEnum.MaxPlayerCount do
		local mo = PartyPlayerInfoMO.New()

		mo.id = -#list - 100
		mo.userId = mo.id

		table.insert(list, mo)
	end

	self._playerInfoUpdateTime = Time.time

	self._playerInfos:setList(list)

	if markDiff and not prevOwner and self:isRoomOwner() then
		GameFacade.showToast(ToastEnum.ParyGameNewOwnerTip)
	end
end

function PartyGameRoomModel:getPlayerInfoUpdateTime()
	return self._playerInfoUpdateTime
end

function PartyGameRoomModel:getPlayerInfosModel()
	return self._playerInfos
end

function PartyGameRoomModel:changePlayerStatus(id, status)
	local mo = self._playerInfos:getById(id)

	if mo then
		mo.status = status
	end
end

function PartyGameRoomModel:changePlayerWearClothIds(id, wearClothIds)
	local mo = self._playerInfos:getById(id)

	if mo then
		mo:updateWearClothIds(wearClothIds)
	end
end

function PartyGameRoomModel:getFriendModel()
	self._friendModel = self._friendModel or ListScrollModel.New()

	return self._friendModel
end

function PartyGameRoomModel:initFriendList()
	local socialFriendModel = SocialListModel.instance:getModel(SocialEnum.Type.Friend)
	local list = socialFriendModel:getList()
	local result = {}

	for i, v in ipairs(list) do
		if self._friendInfos[v.id] then
			table.insert(result, v)
		end
	end

	table.sort(result, function(a, b)
		local aState = self._friendInfos[a.id].state
		local bState = self._friendInfos[b.id].state

		if aState ~= bState then
			return aState < bState
		end

		return a.id < b.id
	end)

	local friendModel = self:getFriendModel()

	friendModel:setList(result)
end

PartyGameRoomModel.instance = PartyGameRoomModel.New()

return PartyGameRoomModel
