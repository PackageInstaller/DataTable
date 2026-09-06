-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/model/FriendModel.lua

module("logic.extensions.friend.model.FriendModel", package.seeall)

local FriendModel = class("FriendModel", BaseModel)

function FriendModel:onInit()
	self:onReset()
end

function FriendModel:onReset()
	self._datas = {}
	self._requests = {}
	self._recommends = {}
	self._recommendsRes = {}
	self._searchs = {}
	self._myApplyList = {}
	self._gainedHeartCount = 0
	self._canGainHearts = {}
	self._sendedHearts = {}
	self._chatTimePool = {}
end

function FriendModel:SetMyApply(id)
	self._myApplyList[id] = true
end

function FriendModel:RmMyApplyById(id)
	self._myApplyList[id] = nil
end

function FriendModel:GetIsInMyApplyList(id)
	return self._myApplyList[id] == true
end

function FriendModel:getRequests()
	return self._requests
end

function FriendModel:getSearchs()
	return self._searchs
end

function FriendModel:getFriendMo(id)
	id = tostring(id)

	if self._datas then
		return self._datas[id]
	end

	return nil
end

function FriendModel:getGroupTypeById(userId)
	local mo = self:getFriendMo(userId)

	if not mo then
		return GameEnum.FriendGroup.None
	else
		return mo:getValue("groupType")
	end
end

function FriendModel:getIsGroupFull(group)
	local num = self:getGroupCellNums(group)

	return num >= FriendConfig.instance:GetMaxCount(group)
end

function FriendModel:getGroupCellNums(group)
	local t = self:getGroupDatas(group)

	return #t
end

function FriendModel:getGroupDatas(group)
	local t = {}

	for _, v in pairs(self._datas) do
		local curGroup = v:getValue("groupType")

		if group == GameEnum.FriendGroup.Msg and (curGroup == GameEnum.FriendGroup.Friend or curGroup == GameEnum.FriendGroup.Stranger) then
			table.insert(t, v)
		elseif v:getValue("groupType") == group then
			table.insert(t, v)
		end
	end

	return t
end

function FriendModel:getShareFriendsList()
	local t = {}

	for _, v in pairs(self._datas) do
		if v:getValue("groupType") == GameEnum.FriendGroup.Friend and not ShareTaskModel.instance:GetFriendIsHelpMyBoss(v:GetId()) then
			table.insert(t, v)
		end
	end

	if #t > 1 then
		table.sort(t, function(a, b)
			return a:GetPower() < b:GetPower()
		end)
	end

	return t
end

function FriendModel:getGroupUnreadMsgCnt(group)
	local t = self:getGroupDatas(group)
	local cnt = 0

	for id, v in pairs(t) do
		cnt = cnt + NewChatModel.instance:getNotReadMsgCount(GameEnum.ChatChannel.Private, id)
	end

	return cnt
end

function FriendModel:getSortFunc(group)
	if group == GameEnum.FriendGroup.Blacklist then
		return FriendModel.sortBlackLists
	elseif group == GameEnum.FriendGroup.Stranger then
		return FriendModel.sortStangers
	else
		return FriendModel.sortFriends
	end
end

function FriendModel:updateChatTime(id)
	local now = ServerTime.now()

	if id then
		self._chatTimePool[id] = -now
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdateFriendChatTime)
end

function FriendModel:getChatTime(id)
	return checknumber(self._chatTimePool[id])
end

function FriendModel:clearChatTime()
	self._chatTimePool = {}
end

function FriendModel:getChatTimePool()
	return self._chatTimePool
end

function FriendModel.sortStangers(a, b)
	return checknumber(a:lastOpTime()) > checknumber(b:lastOpTime())
end

function FriendModel.sortFriends(a, b)
	local channel = GameEnum.ChatChannel.Private
	local aId = a:GetId()
	local bId = b:GetId()
	local val1 = NewChatModel.instance:getNotReadMsgCount(channel, aId)
	local val2 = NewChatModel.instance:getNotReadMsgCount(channel, bId)

	if val1 ~= val2 then
		return val2 < val1
	end

	if val1 > 0 then
		local time1 = NewChatModel.instance:getLastMsgSendTime(channel, aId)
		local time2 = NewChatModel.instance:getLastMsgSendTime(channel, bId)

		if time1 ~= time2 then
			return time2 < time1
		end
	end

	local isOnlineA = checknumber(a._onlineZoneId) > 0
	local isOnlineB = checknumber(b._onlineZoneId) > 0

	if isOnlineA == isOnlineB then
		local atime = FriendModel.instance:getChatTime(aId)
		local btime = FriendModel.instance:getChatTime(bId)

		if atime ~= btime then
			return atime < btime
		end

		if isOnlineA then
			if a._zdl ~= b._zdl then
				return checknumber(a._zdl) > checknumber(b._zdl)
			end

			if a:getLevel() ~= b:getLevel() then
				return checknumber(a:getLevel()) > checknumber(b:getLevel())
			else
				return checknumber(aId) < checknumber(bId)
			end
		else
			return checknumber(a:lastOpTime()) > checknumber(b:lastOpTime())
		end
	else
		return isOnlineA
	end
end

function FriendModel.sortBlackLists(a, b)
	return checknumber(a:lastOpTime()) > checknumber(b:lastOpTime())
end

function FriendModel:onGetBuddyInfoRes(msg)
	local buddies = msg.buddies

	self._gainedHeartCount = msg.gainedHeartCount
	self._sendedHearts = {}

	for _, v in ipairs(msg.sendedHearts) do
		self._sendedHearts[v] = true
	end

	self._canGainHearts = {}

	for _, v in ipairs(msg.canGainHearts) do
		self._canGainHearts[v] = true
	end

	self._datas = {}

	for _, v in ipairs(buddies) do
		self:_addBuddyMsg(v)
	end

	GlobalDispatcher:dispatch(GlobalNotify.FriendInfoGeted)
end

function FriendModel:getSendedHeartNum()
	local count = 0

	for k, v in pairs(self._sendedHearts) do
		if v == true then
			count = count + 1
		end
	end

	return count
end

function FriendModel:getGainedHeartNum()
	return self._gainedHeartCount
end

function FriendModel:getCanSendState(friendId, isTip)
	friendId = tostring(friendId)

	if self:getSendedHeartNum() >= self:getMaxSendHeartOneDay() then
		if isTip then
			FloatWordMgr.instance:show("今日赠送友情点已达上限")
		end

		return 0
	elseif self._sendedHearts[friendId] == true then
		if isTip then
			FloatWordMgr.instance:show("今日已给该好友送过友情点了")
		end

		return 0
	end

	return 1
end

function FriendModel:getSendedHearts()
	return self._sendedHearts or {}
end

function FriendModel:getCanGainHearts()
	return self._canGainHearts or {}
end

function FriendModel:handleGetBuddyRelationshipRes(msg)
	self._buddyRelMsg = msg

	local relTypeList = msg.type

	if table.indexof(relTypeList, 0) ~= false then
		for _, relType in pairs(GameEnum.RelTypeByFriend) do
			self:handleGetBuddyRelResByType(relType)
		end
	else
		for _, relType in ipairs(relTypeList) do
			self:handleGetBuddyRelResByType(relType)
		end
	end
end

function FriendModel:handleGetBuddyRelResByType(relType)
	if relType == 0 then
		-- block empty
	elseif relType == GameEnum.RelTypeByFriend.Tutor then
		self._tutorInfo = self._buddyRelMsg.tutorInfo
	else
		printError(string.format("未确认的relType, %s", relType))
	end
end

function FriendModel:getTutorTeacherUserId()
	return (self._tutorInfo or nil) and (self._tutorInfo.tutorTeacherUserId or nil)
end

function FriendModel:getTutorStudentUserIdList()
	return (self._tutorInfo or nil) and (self._tutorInfo.tutorStudentUserId or {})
end

function FriendModel:getRelTypeList(userId)
	local relTypeList = {}

	if self:isTutorRelByFriend(userId) then
		table.insert(relTypeList, GameEnum.RelTypeByFriend.Tutor)
	end

	return relTypeList
end

function FriendModel:isTutorRelByFriend(userId)
	return self:getRelIdByTutor(userId) ~= GameEnum.RelIdByTutor.None
end

function FriendModel:getRelIdByTutor(userId)
	local relId = GameEnum.RelIdByTutor.None

	userId = tostring(userId)

	if string.nilorempty(userId) then
		return relId
	end

	if self:isMyTeacherByRelationship(userId) then
		relId = GameEnum.RelIdByTutor.Teacher
	elseif self:isMyStudentByRelationship(userId) then
		relId = GameEnum.RelIdByTutor.Student
	end

	return relId
end

function FriendModel:isMyTeacherByRelationship(userId)
	local teaUserId = self:getTutorTeacherUserId()

	if teaUserId then
		return tostring(teaUserId) == tostring(userId)
	else
		return false
	end
end

function FriendModel:isMyStudentByRelationship(userId)
	userId = tostring(userId)

	if string.nilorempty(userId) then
		return false
	end

	for _, stuUserId in ipairs(self:getTutorStudentUserIdList()) do
		if tostring(stuUserId) == userId then
			return true
		end
	end

	return false
end

function FriendModel:getCanGainState(friendId, isTip)
	friendId = tostring(friendId)

	if self._canGainHearts[friendId] ~= true then
		return -1
	elseif self:getGainedHeartNum() >= self:getMaxGainHeartOneDay() then
		if isTip then
			FloatWordMgr.instance:show("今日收取友情点已达上限")
		end

		return 0
	else
		return 1
	end
end

function FriendModel:getMaxGainHeartOneDay()
	if self._maxGainHeartOneDay == nil then
		self._maxGainHeartOneDay = FriendConfig.instance:getCommonValue("MAX_DAILY_GAIN_HEART_COUNT", true)
	end

	return self._maxGainHeartOneDay
end

function FriendModel:getMaxSendHeartOneDay()
	if self._maxSendHeartOneDay == nil then
		self._maxSendHeartOneDay = FriendConfig.instance:getCommonValue("MAX_DAILY_SEND_HEART_COUNT", true)
	end

	return self._maxSendHeartOneDay
end

function FriendModel:onNewHeart(friendId)
	self._canGainHearts[friendId] = true
end

function FriendModel:onGainHeart(friendIds)
	if friendIds then
		for _, v in ipairs(friendIds) do
			self._canGainHearts[v] = false
			self._gainedHeartCount = self._gainedHeartCount + 1
		end
	end
end

function FriendModel:onSendHeart(friendIds)
	if friendIds then
		for _, v in ipairs(friendIds) do
			self._sendedHearts[v] = true
		end
	end
end

function FriendModel:_addBuddyMsg(budddyNo)
	local mo = FriendMo.New()

	mo:init(budddyNo)
	self:_addMo(mo)
end

function FriendModel:_addMo(mo)
	if mo then
		self._datas = self._datas or {}

		local id = mo:getValue("id")
		local groupType = mo:getValue("groupType")

		self._datas[id] = mo

		if groupType == GameEnum.FriendGroup.Stranger then
			local t = self:getGroupDatas(groupType)
			local maxCount = FriendConfig.instance:GetMaxCount(groupType)

			table.sort(t, self:getSortFunc(groupType))

			local len = #t

			if maxCount < len then
				for i = maxCount + 1, len do
					local curMo = t[i]

					self._datas[curMo:getValue("id")] = nil
				end
			end
		end
	end
end

function FriendModel:_delMo(mo, id)
	table.remove(self._datas, id)
end

function FriendModel:_ChangeGroup(id, newGroup)
	local mo = self:getFriendMo(id)

	if mo then
		mo:ChangeGroup(newGroup)

		if id == FriendController.instance:getCurSelectedId() then
			FriendController.instance:onClickItemFriend(-2)
		end
	end

	if newGroup == GameEnum.FriendGroup.None or newGroup == GameEnum.FriendGroup.Blacklist then
		self._canGainHearts[id] = false
	end
end

function FriendModel:onGetBuddyRequestInfoRes(msg)
	self._requests = {}

	if msg.requests and #msg.requests > 0 then
		self._requests = msg.requests
	end

	if not msg.recommends then
		local recommends = {}

		self:addRecommendsToPool(recommends)
	end
end

function FriendModel:removeRequest(id)
	if self._requests then
		for k, v in ipairs(self._requests) do
			if v.headInfo.userId == id then
				table.remove(self._requests, k)

				break
			end
		end
	end
end

function FriendModel:onRefreshRecommendBuddiesRes(msg)
	if not msg.recommends then
		self:addRecommendsToPool(msg.recommends)
	end
end

function FriendModel:addRecommendsToPool(recommends)
	if recommends then
		local len = table.nums(self._recommends or {})

		if len >= 50 then
			self._recommends = {}
		end

		for i, no in ipairs(recommends) do
			local info = no.headInfo
			local userId = info.userId

			self._recommends[userId] = no
		end

		self:randRecommends()
		FriendController.instance:localNotify("RefreshRecomend")
	end
end

function FriendModel:randRecommends()
	local list = {}

	for k, v in pairs(self._recommends or {}) do
		local info = v.headInfo
		local userId = info.userId
		local obj = {}

		obj.mo = v
		obj.value = not self:GetIsInMyApplyList(userId) and math.random() or -math.random()

		table.insert(list, obj)
	end

	table.sort(list, function(a, b)
		return a.value > b.value
	end)

	local res = {}

	for i = 1, 10 do
		local obj = list[i]

		if obj then
			table.insert(res, obj.mo)
		end
	end

	self._recommendsRes = res
end

function FriendModel:getRecommends()
	self._recommendsRes = self._recommendsRes or {}

	local list = {}

	for _, v in ipairs(self._recommendsRes) do
		local friendMo = self:getFriendMo(v.headInfo.userId)
		local isInsert = true

		if friendMo ~= nil then
			local groupType = friendMo:Group()

			if groupType == GameEnum.FriendGroup.Friend or groupType == GameEnum.FriendGroup.Blacklist then
				isInsert = false
			end
		end

		if isInsert then
			table.insert(list, v)
		end
	end

	return list
end

function FriendModel:onRequestAddBuddyRes(msg)
	return
end

function FriendModel:onHandleBuddyRequestRes(msg)
	local key = -1

	for k, v in ipairs(self._requests) do
		if v.headInfo.userId == msg.requestUserId then
			key = k
		end
	end

	if key > 0 then
		table.remove(self._requests, key)
	end

	FriendController.instance:localNotify("FriendApplyUpdate")
	GlobalDispatcher:dispatch(GlobalNotify.FriendAdd)
end

function FriendModel:onBatchHandleBuddyRequestRes(userIds)
	local userIdMap = {}

	for _, v in ipairs(userIds) do
		userIdMap[v] = true
	end

	local requests = {}

	for _, v in ipairs(self._requests) do
		if userIdMap[v.headInfo.userId] ~= true then
			table.insert(requests, v)
		end
	end

	self._requests = requests

	FriendController.instance:localNotify("FriendApplyUpdate")
end

function FriendModel:onSearchUserRes(msg)
	self._searchs = msg.searchInfo or {}

	local changed = false

	for _, v in ipairs(self._searchs) do
		local friendMo = self:getFriendMo(v.headInfo.userId)

		changed = friendMo ~= nil and friendMo:initSimpleInfo(v) or changed
	end

	if changed then
		GlobalDispatcher:dispatch(GlobalNotify.FriendAdd)
	end
end

function FriendModel:onHandleNotifyNewBuddyRes(msg)
	self:_addBuddyMsg(msg.newBuddy)
end

function FriendModel:ctor()
	FriendModel.super.ctor(self)

	self._hasGainToday = 0
	self._applies = {}
	self._recommends = {}
	self._searchs = {}
end

function FriendModel:SetApplies(datas)
	self._applies = {}

	for _, data in ipairs(datas) do
		self:AddApply(data, false)
	end

	GlobalDispatcher:dispatch(GlobalNotify.FriendApplyUpdate)
end

function FriendModel:GetApplies()
	return self._applies
end

function FriendModel:GetApplyCount()
	return #self._applies
end

function FriendModel:RemoveApplies(ids)
	for _, id in ipairs(ids) do
		id = tonumber(id)

		self:RemoveApply(id, false)
	end

	GlobalDispatcher:dispatch(GlobalNotify.FriendApplyUpdate)
end

function FriendModel:AddApply(data, sendEvent)
	sendEvent = sendEvent == true

	local id = data.userId
	local mo = OtherRoleModel.instance:AddData(id, data, OtherRoleModel.Src.Friend)

	table.insert(self._applies, mo:Get("id"))

	if sendEvent then
		GlobalDispatcher:dispatch(GlobalNotify.FriendApplyAdd)
	end
end

function FriendModel:RemoveApply(id, sendEvent)
	sendEvent = sendEvent == true

	table.removebyvalue(self._applies, id, true)

	if sendEvent then
		GlobalDispatcher:dispatch(GlobalNotify.FriendApplyRemove)
	end
end

function FriendModel:SetSearchs(datas)
	self._searchs = {}

	for _, data in ipairs(datas) do
		self:AddSearch(data)
	end

	GlobalDispatcher:dispatch(GlobalNotify.FriendSearchUpdate)
end

function FriendModel:GetSearchs()
	return self._searchs
end

function FriendModel:GetSearchCount()
	return #self._searchs
end

function FriendModel:AddSearch(data, sendEvent)
	sendEvent = sendEvent == true

	local id = data.userId
	local mo = OtherRoleModel.instance:AddData(id, data, OtherRoleModel.Src.Friend)

	table.insert(self._searchs, mo:Get("id"))

	if sendEvent then
		GlobalDispatcher:dispatch(GlobalNotify.FriendSearchAdd)
	end
end

function FriendModel:RemoveSearch(id, sendEvent)
	table.removebyvalue(self._searchs, id, true)

	if sendEvent then
		GlobalDispatcher:dispatch(GlobalNotify.FriendSearchRemove)
	end
end

function FriendModel:DelFriend(id)
	self:_ChangeGroup(id, GameEnum.FriendGroup.None)
	GlobalDispatcher:dispatch(GlobalNotify.FriendRemove, id)
	NewChatModel.instance:ClearChannelMsg(GameEnum.ChatChannel.Private, id)
end

function FriendModel:AddBlackList(id)
	self:_ChangeGroup(id, GameEnum.FriendGroup.Blacklist)
	GlobalDispatcher:dispatch(GlobalNotify.BlackListAdd, id)
	NewChatModel.instance:ClearChannelMsg(GameEnum.ChatChannel.Private, id)
end

function FriendModel:AddBlacklistByMo(mo)
	local userId = mo.headInfo.userId
	local friendMo = self:getFriendMo(mo.headInfo.userId)

	if friendMo and friendMo:getValue("groupType") == GameEnum.FriendGroup.Blacklist then
		return
	end

	local newMo = FriendMo.New()
	local msg = {}

	msg.simpleInfo = mo
	msg.groupType = GameEnum.FriendGroup.Blacklist
	msg.lastOpTime = ServerTime.now() * 1000

	newMo:init(msg)
	self:_addMo(newMo)
	NewChatModel.instance:ClearChannelMsg(GameEnum.ChatChannel.Private, userId)
end

function FriendModel:RemoveBlackList(id)
	self:_ChangeGroup(id, GameEnum.FriendGroup.None)
	GlobalDispatcher:dispatch(GlobalNotify.BlackListRemove, id)
end

function FriendModel:AddStrangerFromChat(mo)
	local newMo = FriendMo.New()
	local msg = {}

	msg.simpleInfo = mo
	msg.groupType = GameEnum.FriendGroup.Stranger
	msg.lastOpTime = ServerTime.now() * 1000

	newMo:init(msg)
	self:_addMo(newMo)
end

function FriendModel:AddStranger(id)
	self:_ChangeGroup(id, GameEnum.FriendGroup.Stranger)
	GlobalDispatcher:dispatch(GlobalNotify.StrangerAdd, id)
end

function FriendModel:RemoveStranger(id)
	self:_ChangeGroup(id, GameEnum.FriendGroup.None)
	GlobalDispatcher:dispatch(GlobalNotify.StrangerRemove, id)
end

FriendModel.instance = FriendModel.New()

return FriendModel
