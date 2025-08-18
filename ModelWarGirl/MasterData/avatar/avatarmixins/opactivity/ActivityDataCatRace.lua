-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataCatRace.lua

local ResOpActivityCatRaceMisc = require("ClientData/ResOpActivityCatRaceMisc")
local ResOpActivityCatRaceTask = require("ClientData/ResOpActivityCatRaceTask")
local ResOpActivityCatRaceCatDetail = require("ClientData/ResOpActivityCatRaceCatDetail")
local CatRaceConfig = require("UI/OpActivity/CatRace/CatRaceConfig")
local UserData = require("Helper/UserData")
local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local strClassName = "ActivityDataCatRace"
local ActivityDataCatRace = Class(strClassName, ActivityDataBase)

function ActivityDataCatRace:ctor()
	self.cachedPlayerData = {}
	self.cachedCatRaceData = {}
end

function ActivityDataCatRace:updateClientData(actID)
	self.actID = actID
	self.catRaceData = {}
	self.catRaceDataDaily = {}
	self.mainDlgName = "activityCatRaceMainDlg"
	self.miscData = ResOpActivityCatRaceMisc[actID]
	self.taskResData = ResOpActivityCatRaceTask[actID]
	self.mileAchieveActID = self.miscData.mile_achieve_id
	self.curMile = 0
	self.relateDlgNames = {
		"activityCatRaceTaskDlg",
		"activityCatRaceFriendDlg",
		"activityCatRaceMileAwardDlg",
		"activityCatRaceTaskChooseDlg"
	}

	for _, itemID in pairs(self.miscData.item_id) do
		CurAvatar:registerItemChangedCallBack(itemID, Slot(self.refreshData, self))
	end

	self.taskAchieveIDs = {
		self.miscData.fixed_task_achieve_id,
		self.miscData.friend_task_achieve_id,
		self.miscData.optional_task_achieve_id
	}
	self.relatedAchieveIDs = {
		self.miscData.mile_achieve_id,
		self.miscData.fixed_task_achieve_id,
		self.miscData.friend_task_achieve_id,
		self.miscData.optional_task_achieve_id
	}

	for _, achieveActID in ipairs(self.relatedAchieveIDs) do
		CurAvatar:addActivityRelated(achieveActID, self.mainDlgName, self.actID)
	end

	self.depositTimer = Timer.New(Slot(self._depositRefresh, self), 1, -1)

	self.depositTimer:Start()
	self:refreshGiftData()
end

function ActivityDataCatRace:updateRoleData(roleData, fromDataUpdate)
	self.opID = self.actObject.opId
	self.catRaceData = roleData.cat_race or {}
	self.catRaceDataDaily = {
		day_task_record = self.catRaceData.day_task_record,
		last_task_fiend_uid = self.catRaceData.last_task_fiend_uid,
		gift_get_cnt = self.catRaceData.gift_get_cnt,
		friend_task = self.catRaceData.friend_task,
		self_task = self.catRaceData.self_task,
		send_record = self.catRaceData.send_record
	}

	if self.opDeposit and self.prevDepositTime and self:getLastDepositRefreshTime() ~= self.prevDepositTime then
		self.curMile = self.catRaceData.progress or 0

		local distance = self.curMile - self.opPrevMile

		if distance > 0 then
			self.depositDistance = distance

			local mainUI = UIManager.tryGetUI(self.mainDlgName)

			if mainUI then
				mainUI:showDepositDis(self.depositDistance, false)
			end
		else
			self.depositDistance = nil
		end

		self.opDeposit = false
	else
		self.curMile = self.catRaceData.progress or 0
		self.depositDistance = nil
	end

	self.otherPlayerCatRaceData = {}

	if not ClientUtils.isTickToday(self.catRaceData.last_refresh_time) then
		self:forceDailyRefresh()
	end

	self.dailyRefreshTimer = Timer.New(Slot(self.forceDailyRefresh, self), ClientUtils.getServerTimeNextDay() - ClientUtils.getServerTime())

	self:refreshData()
end

function ActivityDataCatRace:getDepositDistance()
	return self.depositDistance
end

function ActivityDataCatRace:clearDepositNotice()
	self.opPrevMile = nil
	self.depositDistance = nil
end

function ActivityDataCatRace:forceDailyRefresh()
	self.catRaceDataDaily = {}
	self.friendSentDic = {}

	self:refreshData()
end

function ActivityDataCatRace:mileAchieveHasNew()
	local actObj = CurAvatar:getActivityObj(self.miscData.mile_achieve_id)

	if actObj then
		local achieveActData = actObj.actData

		if achieveActData and achieveActData:checkNew() then
			return true
		end
	end
end

function ActivityDataCatRace:taskAchieveHasNew()
	for _, relateAchieveID in ipairs(self.taskAchieveIDs) do
		local achieveActObj = CurAvatar:getActivityObj(relateAchieveID)

		if achieveActObj then
			local achieveActData = achieveActObj.actData

			if achieveActData then
				if relateAchieveID == self.miscData.fixed_task_achieve_id then
					for achieveType, typeData in pairs(achieveActData.clientData) do
						for achieveIndex, achieveData in ipairs(typeData) do
							if self:checkTaskAwardCanGet(achieveActData, achieveType, achieveIndex) then
								return true
							end
						end
					end
				elseif relateAchieveID == self.miscData.friend_task_achieve_id then
					local friendTaskID, friendTaskType = self:getFriendTask()

					if friendTaskID and friendTaskID ~= 0 and self:checkTaskAwardCanGet(achieveActData, friendTaskType, 1) then
						return true
					end
				elseif relateAchieveID == self.miscData.optional_task_achieve_id then
					local optionalTaskID, optionalTaskType = self:getOptionalTask()

					if optionalTaskID and optionalTaskID ~= 0 and self:isSelOptionalTask() and self:checkTaskAwardCanGet(achieveActData, optionalTaskType, 1) then
						return true
					end
				end
			end
		end
	end

	return false
end

function ActivityDataCatRace:checkTaskAwardCanGet(achieveData, achieveType, achieveIndex)
	local state = achieveData:getAchieveState(achieveType, achieveIndex)

	if state == Const.ACT_ACHIEVE_STATE_ENOUGH then
		return true
	end

	return false
end

function ActivityDataCatRace:relateAchieveHasNew()
	for _, relateAchieveID in ipairs(self.relatedAchieveIDs) do
		local achieveActData = CurAvatar:getActivityObj(relateAchieveID).actData

		if achieveActData and achieveActData:checkNew() then
			return true
		end
	end

	return false
end

function ActivityDataCatRace:isNeedGetFriendTask()
	if self:getRemainFriendTaskNum() <= 0 then
		return false
	end

	if not self.catRaceDataDaily.friend_task then
		return true
	end

	local task_id = self.catRaceDataDaily.friend_task.task_id

	if not task_id or task_id == 0 then
		return true
	end

	return false
end

function ActivityDataCatRace:checkNew()
	if self:mileAchieveHasNew() then
		return true
	end

	if self:hasItemToUse() then
		return true
	end

	if self.actObject:inFreeze() then
		return false
	end

	if self:isOptionalTaskAwardAvaliable() then
		return true
	end

	if self:taskAchieveHasNew() then
		return true
	end

	if not self:isSelOptionalTask() then
		return true
	end

	if self:getRemainFriendTaskNum() > 0 and self:isNeedGetFriendTask() then
		local flag = self:hasAvailableFriendTask()

		if not flag and self:isTodayFirst() then
			return true
		else
			return flag
		end
	end

	if self:hasGiftToReceive() then
		return true
	end

	return false
end

function ActivityDataCatRace:hasItemToUse()
	for _, itemID in ipairs(self.miscData.item_id) do
		local itemNum = CurAvatar:getItemNumById(itemID)

		if itemNum > 0 then
			return true
		end
	end
end

function ActivityDataCatRace:refreshData()
	self:refreshGiftData()

	local ui = UIManager.tryGetUI(self.mainDlgName)

	if ui then
		ui:refreshData()
	end

	self.actObject:checkNew()
end

function ActivityDataCatRace:forceResetFriendData()
	self.lastFriendRefreshTime = nil
end

function ActivityDataCatRace:forceResetMemberData()
	return
end

function ActivityDataCatRace:getAllFriendCatRaceData(callback)
	self.friendDataCallback = callback

	self:checkFriendCatRaceData()

	if not self.lastFriendRefreshTime or self.lastFriendRefreshTime + CatRaceConfig.FRIEND_REFRESH_CD > ClientUtils.getServerTime() then
		local friendList = CurAvatar:getSortedFriends()
		local uidList = {}

		for _, friend in pairs(friendList) do
			table.insert(uidList, friend.uid)
		end

		self:getCatRaceSimpleData(uidList)

		return
	end
end

function ActivityDataCatRace:checkFriendCatRaceData()
	local friendList = CurAvatar:getSortedFriends()

	for _, friend in pairs(friendList) do
		local uid = friend.uid

		if self.cachedCatRaceData[uid] then
			friend.opActSimpleItem = self.cachedCatRaceData[uid]
		end
	end

	if self.friendDataCallback then
		if #friendList <= 0 then
			self.friendDataCallback()
		else
			self.friendDataCallback(friendList)
		end

		self.lastFriendRefreshTime = ClientUtils.getServerTime()
	end
end

local function _sortRank(a, b)
	if a.data.score ~= b.data.score then
		return a.data.score > b.data.score
	elseif a.data.tick ~= b.data.tick then
		return a.data.tick < b.data.tick
	else
		return a.data.comm.uid > b.data.comm.uid
	end
end

function ActivityDataCatRace:getCatRaceRankData(dataList, callback)
	local rankData = {}
	local rankDataList = {}
	local selfData = {}
	local rankMainDlg = UIManager.tryGetUI("rankMainDlg")
	local isFriendType = false

	if rankMainDlg and Const.CAT_RACE_RANK_FRIEND == rankMainDlg.selectIdx then
		isFriendType = true
	end

	if dataList and #dataList > 0 then
		for index, member in ipairs(dataList) do
			if member.uid == CurAvatar.uid then
				table.remove(dataList, index)
			end
		end

		local newMemberData = CurAvatar:getMyRoleSimpleComm()

		if self.curMile and self.curMile > 0 then
			newMemberData.opActSimpleItem = {}
			newMemberData.opActSimpleItem.specdata = {}
			newMemberData.opActSimpleItem.specdata.cat_race = {}
			newMemberData.opActSimpleItem.specdata.cat_race.progress = self.curMile
			newMemberData.opActSimpleItem.specdata.cat_race.last_refresh_time = self.catRaceData.last_refresh_time or ClientUtils.getServerTime()

			table.insert(dataList, newMemberData)
		end

		for _, member in pairs(dataList) do
			if member.opActSimpleItem and member.opActSimpleItem.specdata.cat_race.progress > 0 then
				local _rankData = {}
				local rankCommonData = {}

				rankCommonData.score = member.opActSimpleItem.specdata.cat_race.progress

				if isFriendType and member.uid ~= CurAvatar.uid then
					rankCommonData.comm = utils.copyTable(member)

					if rankCommonData.comm.serverId then
						rankCommonData.comm.name = rankCommonData.comm.serverId .. "-" .. rankCommonData.comm.name
					end
				else
					rankCommonData.comm = member
				end

				rankCommonData.tick = member.opActSimpleItem.specdata.cat_race.last_refresh_time
				_rankData.data = rankCommonData

				if rankCommonData.comm.uid == CurAvatar.uid then
					selfData = _rankData
				end

				table.insert(rankDataList, _rankData)
			end
		end

		table.sort(rankDataList, _sortRank)
	end

	for i, rankData in ipairs(rankDataList) do
		rankData.rank = i
		rankData.rankType = Const.RANK_TYPE_CAT_RACE

		if rankData.data.comm.uid == CurAvatar.uid then
			selfData.rank = i
		end
	end

	if not selfData.data then
		selfData.data = {}

		local rankCommonData = {}

		rankCommonData.score = 0

		local comm = CurAvatar:getMyCommInfo()

		rankCommonData.comm = utils.copyTable(comm)
		rankCommonData.tick = 0
		selfData.data = rankCommonData
		selfData.rank = -1
		selfData.rankType = Const.RANK_TYPE_CAT_RACE
	end

	rankData.dataList = rankDataList
	rankData.selfData = selfData

	callback(rankData)
end

function ActivityDataCatRace:requestFriendRankData(rankDlgCallBack)
	self:getAllFriendCatRaceData(Functor(self.analyDataListToRankData, self, rankDlgCallBack, Const.CAT_RACE_RANK_FRIEND))
end

function ActivityDataCatRace:analyDataListToRankData(rankDlgCallBack, dataType, dataList)
	local rankMainDlg = UIManager.tryGetUI("rankMainDlg")

	if rankMainDlg and dataType == rankMainDlg.selectIdx then
		self:getCatRaceRankData(dataList, rankDlgCallBack)
	end
end

function ActivityDataCatRace:requestCircleRankData(rankDlgCallBack)
	self:getAllCircleMemeberCatRaceData(Functor(self.analyDataListToRankData, self, rankDlgCallBack, Const.CAT_RACE_RANK_CIRCLE))
end

function ActivityDataCatRace:getAllCircleMemeberCatRaceData(callback)
	self.opCircleMember = true
	self.circleMemberDataCallback = callback

	self:checkCircleMemberCatRaceData()

	if not self.lastCircleMemberRefreshTime or self.lastCircleMemberRefreshTime + CatRaceConfig.CIRCLE_MEMBER_REFRESH_CD > ClientUtils.getServerTime() then
		if CurAvatar:isInCircle() and CurAvatar.myCircle then
			local oriMemberList = CurAvatar.myCircle:getCircleMembersList()
			local uidList = {}

			for _, member in pairs(oriMemberList) do
				table.insert(uidList, member.base.uid)
			end

			self:getCatRaceSimpleData(uidList)
		end

		return
	end
end

function ActivityDataCatRace:checkCircleMemberCatRaceData()
	local oriMemberList = {}

	if CurAvatar:isInCircle() and CurAvatar.myCircle then
		oriMemberList = CurAvatar.myCircle:getCircleMembersList()
	end

	local circleMemberList

	if oriMemberList then
		circleMemberList = {}

		for _, data in ipairs(oriMemberList) do
			table.insert(circleMemberList, data.base)
		end
	end

	if circleMemberList then
		for _, member in pairs(circleMemberList) do
			local uid = member.uid

			if self.cachedCatRaceData[uid] then
				member.opActSimpleItem = self.cachedCatRaceData[uid]
			end
		end
	end

	if self.circleMemberDataCallback then
		self.circleMemberDataCallback(circleMemberList)

		self.lastCircleMemberRefreshTime = ClientUtils.getServerTime()
	end
end

function ActivityDataCatRace:getOtherPlayerCatRaceData(playerList, callback)
	self.otherPlayerCatRaceCallback = callback
	self.otherPlayerList = playerList

	self:checkOtherPlayerCatRaceData()

	if not self.lastOtherPlayerDataRefreshTime or self.lastOtherPlayerDataRefreshTime + CatRaceConfig.FRIEND_REFRESH_CD < ClientUtils.getServerTime() then
		local uidList = {}

		for _, player in pairs(self.otherPlayerList) do
			table.insert(uidList, player.uid)
		end

		self:getCatRaceSimpleData(uidList)
	end
end

function ActivityDataCatRace:checkOtherPlayerCatRaceData()
	if self.otherPlayerList then
		for _, player in pairs(self.otherPlayerList) do
			local uid = player.uid

			if self.cachedCatRaceData[uid] then
				player.opActSimpleItem = self.cachedCatRaceData[uid]
			end
		end

		if self.otherPlayerCatRaceCallback then
			self.otherPlayerCatRaceCallback(self.otherPlayerList)

			self.lastOtherPlayerDataRefreshTime = ClientUtils.getServerTime()
		end
	end
end

function ActivityDataCatRace:getCatRaceSimpleData(uidList)
	RPC.roleOpActSimpleGet(uidList, self.actObject.opId)
end

function ActivityDataCatRace:onRoleOpActSimpleGet(simple_data)
	for _, data in pairs(simple_data) do
		self.cachedCatRaceData[data.uid] = data
	end

	self:checkFriendCatRaceData()
	self:checkCircleMemberCatRaceData()
	self:checkOtherPlayerCatRaceData()
end

function ActivityDataCatRace:getCompPlayer(usedPlayer)
	local compPlayer

	if self.catRaceData and self.catRaceData.fiend_uid ~= "0" then
		local uid = self.catRaceData.fiend_uid

		compPlayer = CurAvatar.friendList[uid]
	end

	if not compPlayer then
		return self:getRandomPlayer()
	end

	return compPlayer
end

function ActivityDataCatRace:getRandomPlayer(usedPlayer)
	local randomPlayer
	local friendList = CurAvatar:getSortedFriends()

	if #friendList > 0 then
		local randomIndex = math.random(1, #friendList)

		if usedPlayer then
			while friendList[randomIndex].uid == usedPlayer.uid do
				if #friendList == 1 then
					randomIndex = nil

					break
				end

				randomIndex = math.random(1, #friendList)
			end
		end

		if randomIndex then
			randomPlayer = friendList[randomIndex]
		else
			randomPlayer = nil
		end
	else
		randomPlayer = nil
	end

	return randomPlayer
end

function ActivityDataCatRace:isTodayFirst()
	self.lastAccessTime = UserData.loadCommonDataInt(CurAvatar.uid .. CatRaceConfig.ACCESS_TIME_KEY)

	if not self.lastAccessTime or self.lastAccessTime < ClientUtils.getServerTimeTodayStart() then
		return true
	end

	return false
end

function ActivityDataCatRace:getCurMile()
	return self.curMile
end

function ActivityDataCatRace:getOptionalTask()
	if self.catRaceDataDaily.self_task then
		local optionalTaskID = self.catRaceDataDaily.self_task.task_id

		if optionalTaskID and self.taskResData[optionalTaskID] and ClientUtils.isTickToday(self.catRaceData.publish_send_time) then
			return optionalTaskID, self.taskResData[optionalTaskID].achieve_type
		end
	end
end

function ActivityDataCatRace:getFriendTask()
	if self.catRaceDataDaily.friend_task then
		local friendTaskID = self.catRaceDataDaily.friend_task.task_id

		if friendTaskID and self.taskResData[friendTaskID] then
			return friendTaskID, self.taskResData[friendTaskID].achieve_type
		end
	end
end

function ActivityDataCatRace:getRemainFriendTaskNum()
	return self.miscData.max_task_count - self:getSelectedFriendTaskNum()
end

function ActivityDataCatRace:getSelectedFriendTaskNum()
	local num = 0

	if self.catRaceDataDaily.day_task_record then
		return #self.catRaceDataDaily.day_task_record
	end

	return num
end

function ActivityDataCatRace:getTaskDetailFromID(id)
	local data = ResOpActivityCatRaceTask[self.actID][id]

	if data then
		local achieveType = data.achieve_type
		local achieveObj = CurAvatar:getActivityObj(self.miscData.friend_task_achieve_id)

		if achieveObj then
			local achieveActData = achieveObj.actData
			local achieveData = achieveActData:getAchieveOneData(achieveType, 1)

			return achieveData
		end
	end
end

function ActivityDataCatRace:getComPlayer()
	return self.catRaceData.fiend_uid
end

function ActivityDataCatRace:getItemID(index)
	return self.miscData.item_id[index]
end

function ActivityDataCatRace:getCurSelectedCatID()
	if self.catRaceData and self.catRaceData.cat_info and self.catRaceData.cat_info.color_id ~= 0 then
		return self.catRaceData.cat_info.color_id
	end

	return CatRaceConfig.CAT_DEFAULT_COLOR
end

function ActivityDataCatRace:getCatDetail()
	local id = self:getCurSelectedCatID()
	local catDetail = ResOpActivityCatRaceCatDetail[self.actID][id]

	return catDetail
end

function ActivityDataCatRace:getMaxMile()
	local mileAchieveID = self.miscData.mile_achieve_id
	local mileAchieveObj = CurAvatar:getActivityObj(mileAchieveID)
	local maxParam = 0

	if mileAchieveObj then
		local mileAchieveData = mileAchieveObj.actData

		for achieveType, typeData in pairs(mileAchieveData.clientData) do
			for achieveIndex, achieveData in ipairs(typeData) do
				if maxParam < achieveData.param then
					maxParam = achieveData.param
				end
			end
		end
	end

	return maxParam
end

function ActivityDataCatRace:getNextSpecialPoint()
	local mileAchieveID = self.miscData.mile_achieve_id
	local mileAchieveObj = CurAvatar:getActivityObj(mileAchieveID)
	local maxParam = 0
	local nextSpecialPoint
	local distance = 0

	if mileAchieveObj then
		local mileAchieveData = mileAchieveObj.actData

		for achieveType, typeData in pairs(mileAchieveData.clientData) do
			for achieveIndex, achieveData in ipairs(typeData) do
				if self.curMile and achieveData.param > self.curMile and achieveData.high_award then
					nextSpecialPoint = achieveData
					distance = achieveData.param - self.curMile

					break
				end
			end

			if nextSpecialPoint then
				break
			end
		end
	end

	return nextSpecialPoint, distance
end

function ActivityDataCatRace:refreshGiftData()
	self.friendSentDic = {}

	if self.catRaceDataDaily and self.catRaceDataDaily.send_record then
		for _, data in pairs(self.catRaceDataDaily.send_record) do
			self.friendSentDic[data.uid] = true
		end
	end

	self.friendReceiveDic = {}
	self.friendNeedReceiveDic = {}
	self.friendTotalGiftNumDic = {}

	if self.catRaceData and self.catRaceData.recive_record then
		for _, data in pairs(self.catRaceData.recive_record) do
			self.friendReceiveDic[data.uid] = true
			self.friendNeedReceiveDic[data.uid] = data.need_recive
			self.friendTotalGiftNumDic[data.uid] = data.total_count
		end
	end
end

function ActivityDataCatRace:checkFriendIsSent(uid)
	return self.friendSentDic[uid]
end

function ActivityDataCatRace:checkFriendIsReceived(uid)
	return self.friendReceiveDic[uid]
end

function ActivityDataCatRace:checkFriendCanReceived(uid)
	return self.friendReceiveDic[uid] and self.friendNeedReceiveDic[uid] ~= 0
end

function ActivityDataCatRace:getTotalGiftNum(uid)
	return self.friendTotalGiftNumDic[uid] or 0
end

function ActivityDataCatRace:getFriendReceiveNum(uid)
	return self.friendNeedReceiveDic[uid]
end

function ActivityDataCatRace:checkFriendIsComp(uid)
	if self.catRaceData.fiend_uid and self.catRaceData.fiend_uid == uid then
		return true
	end

	return false
end

function ActivityDataCatRace:hasTodayMaxGift()
	if self.miscData.recive_max_count <= self:getReceivedGiftNum() then
		return true
	end

	return false
end

function ActivityDataCatRace:hasGiftToReceive()
	if self:hasTodayMaxGift() then
		return false
	end

	if self.friendNeedReceiveDic then
		for uid, need_recive in pairs(self.friendNeedReceiveDic) do
			if need_recive > 0 then
				return true
			end
		end
	end

	return false
end

function ActivityDataCatRace:hasGiftToSend()
	local hasGift = false

	for uid, player in pairs(CurAvatar.friendList) do
		if not self:checkFriendIsSent(uid) then
			hasGift = true

			break
		end
	end

	return hasGift
end

function ActivityDataCatRace:isOptionalTaskAwardAvaliable()
	local publish_award_time = self.catRaceData.publish_award_time
	local publish_rcv_flag = self.catRaceData.publish_rcv_flag
	local publish_send_time = self.catRaceData.publish_send_time

	if not self.catRaceData.self_task or self.catRaceData.self_task.task_id == 0 then
		return false
	end

	if ClientUtils.isTickToday(publish_award_time) then
		return false
	end

	if publish_send_time ~= 0 and publish_award_time ~= 0 and publish_send_time < publish_award_time then
		return false
	end

	if publish_send_time and publish_send_time ~= 0 and not ClientUtils.isTickToday(publish_send_time) and (not publish_award_time or publish_award_time == 0 or publish_award_time < publish_send_time) then
		return true, true
	end

	if publish_rcv_flag ~= 0 and publish_award_time and publish_send_time and publish_send_time ~= 0 and publish_award_time < publish_send_time and not ClientUtils.isTickToday(publish_award_time) and ClientUtils.isTickToday(publish_send_time) then
		return true
	end

	return false
end

function ActivityDataCatRace:isSelOptionalTask()
	local sefl_task = self.catRaceData.self_task

	if sefl_task then
		local lastOptionalTaskTime = self.catRaceData.publish_send_time

		if lastOptionalTaskTime and ClientUtils.isTickToday(lastOptionalTaskTime) then
			return true
		else
			return false
		end
	else
		return false
	end
end

function ActivityDataCatRace:getLastDepositRefreshTime()
	local activityStartEndTime = self.actObject:getStartEndTime()

	if not self.actObject:isOpen() or not self.catRaceData or not self.catRaceData.deposit_time then
		return nil
	end

	local depositTime = self.catRaceData.deposit_time

	if not depositTime or depositTime == 0 then
		depositTime = math.max(depositTime, CurAvatar.roleCreateTick)

		local activityStartEndTime = self.actObject:getStartEndTime()

		if activityStartEndTime and activityStartEndTime[1] then
			local startTime = self.actObject:getStartEndTime()[1]

			depositTime = math.max(depositTime, startTime)
		end
	end

	return depositTime
end

function ActivityDataCatRace:checkIsFinishFriendTask(uid)
	if self.catRaceDataDaily.day_task_record then
		for _, record in pairs(self.catRaceData.day_task_record) do
			if record.uid == uid then
				return true
			end
		end
	end

	return false
end

function ActivityDataCatRace:checkIsProcessFriendTask(uid)
	if self.catRaceDataDaily.last_task_fiend_uid and self.catRaceData.last_task_fiend_uid == uid then
		return true
	end

	return false
end

function ActivityDataCatRace:checkIsFirstFriendTask()
	if self:getSelectedFriendTaskNum() < 1 then
		return true
	end

	return false
end

function ActivityDataCatRace:getReceivedGiftNum()
	return self.catRaceDataDaily.gift_get_cnt or 0
end

function ActivityDataCatRace:_depositRefresh()
	local lastDepositTime = self:getLastDepositRefreshTime()

	if lastDepositTime then
		local activityStartEndTime = self.actObject:getStartEndTime()
		local curTime = ClientUtils.getServerTime()

		if activityStartEndTime and activityStartEndTime[2] then
			curTime = math.min(curTime, activityStartEndTime[2])
		end

		if not (curTime - lastDepositTime > self.miscData.deposit_interval) or not self.opID then
			-- block empty
		else
			self.opDeposit = true
			self.prevDepositTime = lastDepositTime

			if not self.opPrevMile then
				self.opPrevMile = self.curMile
			end

			if self.actObject:inFreeze() or self.actObject:isOpen() then
				RPC.opActCatRaceGetAward(self.opID)
			end
		end
	end

	if self.actObject:inFreeze() and self.depositTimer then
		self.depositTimer:Stop()

		self.depositTimer = nil
	end
end

function ActivityDataCatRace:destroy()
	ActivityDataCatRace.super.destroy(self)

	if self.depositTimer then
		self.depositTimer:Stop()

		self.depositTimer = nil
	end
end

function ActivityDataCatRace:onStateChange(opActState)
	if self.actObject:inFreeze() then
		local mainDlg = UIManager.tryGetUI(self.mainDlgName)

		if mainDlg then
			mainDlg:refreshData()

			local freezeDisableDlgs = {
				"activityCatRaceTaskDlg",
				"activityCatRaceFriendDlg",
				"activityCatRaceTaskChooseDlg"
			}

			for _, name in pairs(freezeDisableDlgs) do
				local subUI = UIManager.tryGetUI(name)

				if subUI then
					subUI:setVisible(false)
				end
			end
		end
	elseif self.actObject.curState == Const.OPACT_STATE_CLOSE then
		local mainDlg = UIManager.tryGetUI(self.mainDlgName)

		if mainDlg then
			mainDlg:setVisible(false)

			local closeDisableDlgs = {
				"activityCatRaceTaskDlg",
				"activityCatRaceFriendDlg",
				"activityCatRaceMileAwardDlg",
				"activityCatRaceTaskChooseDlg",
				"rankMainDlg"
			}

			for _, name in pairs(closeDisableDlgs) do
				local subUI = UIManager.tryGetUI(name)

				if subUI then
					subUI:setVisible(false)
				end
			end
		end
	end
end

function ActivityDataCatRace:hasAvailableFriendTask()
	local friendList = CurAvatar:getSortedFriends()

	for _, friend in pairs(friendList) do
		local uid = friend.uid

		if self.cachedCatRaceData[uid] then
			friend.opActSimpleItem = self.cachedCatRaceData[uid]
		end
	end

	local flag = false

	if not friendList or #friendList <= 0 then
		flag = false
	else
		for _, friend in pairs(friendList) do
			if self:hasPublishFriendTaskToday(friend) then
				local uid = friend.uid

				if not self:checkIsFinishFriendTask(uid) and not self:checkIsProcessFriendTask(uid) then
					flag = true
				end
			end
		end
	end

	return flag
end

function ActivityDataCatRace:hasPublishFriendTaskToday(player)
	if player.opActSimpleItem and player.opActSimpleItem.specdata.cat_race and player.opActSimpleItem.specdata.cat_race.sel_task_id ~= 0 and ClientUtils.isTickToday(player.opActSimpleItem.specdata.cat_race.last_refresh_time) then
		return true
	end

	return false
end

function ActivityDataCatRace:clearCatRaceDataCallback()
	self.friendDataCallback = nil
	self.circleMemberDataCallback = nil
	self.otherPlayerCatRaceCallback = nil
end

return ActivityDataCatRace
