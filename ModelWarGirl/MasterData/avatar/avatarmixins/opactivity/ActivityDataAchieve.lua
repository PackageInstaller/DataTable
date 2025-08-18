-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataAchieve.lua

local UserData = require("Helper/UserData")
local ResOpActivityAchieveDetail = require("ClientData/ResOpActivityAchieveDetail")
local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResOpActivityAchieveMisc = require("ClientData/ResOpActivityAchieveMisc")
local ResOpActivityAchieveDetailMisc = require("ClientData/ResOpActivityAchieveDetailMisc")
local ResOpActivityAchieveFakeRound = require("ClientData/ResOpActivityAchieveFakeRound")
local ResOpActivityConditionLimit = require("ClientData/ResOpActivityConditionLimit")
local ResOpActivityDetail = require("ClientData/ResOpActivityDetail")
local ResOpActivityTemplate = require("ClientData/ResOpActivityTemplate")
local ResOpActivityAchieveGroup = require("ClientData/ResOpActivityAchieveGroup")
local ActivityDataAchieve = Class("ActivityDataAchieve", ActivityDataBase)
local ACHIEVE_TYPE = {
	SeasonBPPoint = 125,
	tick = 27
}
local BITS_ACHIEVE_TYPE = {
	[95] = 1,
	[Const.ACTIVITY_TYPE_PLAY_NODE] = 1
}
local FULL_SERVER_ACHIEVE_TYPE = {
	[Const.ACT_ACHIEVE_TYPE_WORLD_GET_ITEM] = 1
}

function ActivityDataAchieve:ctor()
	self.serverData = {}
	self.inLockIndex = {}
	self.resetTimer = {}
end

function ActivityDataAchieve:updateMgrData(opActivityMgrItem)
	self.specFullServerData = opActivityMgrItem.specdata.achieve.item

	if opActivityMgrItem.time then
		self.freezeTime = opActivityMgrItem.time.freezetime
	end
end

function ActivityDataAchieve:updateClientData(actId)
	self.actId = actId
	self.clientData = ResOpActivityAchieveDetail[actId] or {}
	self.clientFakeRound = ResOpActivityAchieveFakeRound[actId]
	self.clientAchieveGroup = ResOpActivityAchieveGroup[actId]
	self.roundMaxInfo = {}

	for achieveType, typeData in pairs(self.clientData) do
		if typeData[#typeData] and typeData[#typeData].param then
			self.roundMaxInfo[achieveType] = typeData[#typeData].param
		end

		if achieveType == Const.RESKET_ACHIEVE_TYPE_TICK and not self.tickTimer then
			self:getTickProgress()
		end

		if achieveType == Const.RESKET_ACHIEVE_TYPE_SEASONBP_TOTAL_POINT then
			self.isSeasonMain = true
		end
	end

	self.miscData = ResOpActivityAchieveDetailMisc[actId]

	if self.miscData then
		self.totalMaxRound = self.miscData.max_award_count
		self.finalBonus = self.miscData.final_bonus
		self.oneRoundPro = self.miscData.one_round_num

		if self.miscData.recharge_id and self.miscData.recharge_id > 0 then
			self.connectRechargeId = self.miscData.recharge_id
		end

		if self.miscData.multiple_recharge_id and self.miscData.multiple_recharge_id > 0 then
			self.connectMultipleRechargeId = self.miscData.multiple_recharge_id
		end

		if self.miscData.has_recharge_extra and self.miscData.has_recharge_extra == 1 then
			self.hasRechargeExtra = true
		end
	end

	self.typeMiscData = ResOpActivityAchieveMisc[actId]

	if self:isGroupAchieve() then
		self.groupAchieveInfo = {}

		for achieveType, aInfo in pairs(self.clientData) do
			for index, aData in ipairs(aInfo) do
				if aData.group_id then
					if not self.groupAchieveInfo[aData.group_id] then
						self.groupAchieveInfo[aData.group_id] = {}
					end

					table.insert(self.groupAchieveInfo[aData.group_id], aData)
				end
			end
		end
	end

	self:initNewUnlockGroupGift()

	self.groupShowAchieveList = {}
	self.groupShowFocusDict = {}

	for achieveType, typeData in pairs(self.clientData) do
		if not self.groupShowAchieveList[achieveType] then
			self.groupShowAchieveList[achieveType] = {}
		end

		for achieveIndex, achieveData in ipairs(typeData) do
			local group_type = achieveData.group_type

			if group_type then
				if not self.groupShowAchieveList[achieveType][group_type] then
					self.groupShowAchieveList[achieveType][group_type] = {}
				end

				table.insert(self.groupShowAchieveList[achieveType][group_type], achieveData)
			end
		end
	end
end

function ActivityDataAchieve:isGroupAchieve()
	return self.clientAchieveGroup ~= nil
end

function ActivityDataAchieve:getGroupAchieveDataList()
	local resAchieveGroupList = {}

	if self:isGroupAchieve() then
		for _, resAchieveGroup in ipairs(self.clientAchieveGroup) do
			local notShow = false

			if resAchieveGroup.condition_id and ResOpActivityConditionLimit[resAchieveGroup.condition_id] and ResOpActivityConditionLimit[resAchieveGroup.condition_id].param3 then
				notShow = ConditionLimitManager.inLimitState(ResOpActivityConditionLimit[resAchieveGroup.condition_id].param3)
			end

			if not notShow then
				table.insert(resAchieveGroupList, resAchieveGroup)
			end
		end
	end

	return resAchieveGroupList
end

function ActivityDataAchieve:getLastUnlockGroup()
	local unlockGroup = 0
	local unlockIdx = 0
	local groupAchieveDataList = self:getGroupAchieveDataList()

	for idx, resAchieveGroup in ipairs(groupAchieveDataList) do
		local isUnlock, lockDesc = CurAvatar:checkActivityConditionLimit(resAchieveGroup.condition_id)

		if isUnlock then
			unlockGroup = resAchieveGroup.group_id
			unlockIdx = idx
		end
	end

	return unlockGroup, unlockIdx
end

function ActivityDataAchieve:getGiftAchieveDataList()
	local giftAchieveDataList = {}
	local tempData = ResOpActivityTemplate[self.actId]
	local relateId

	if tempData then
		relateId = tempData.relate_act and tempData.relate_act[1]

		local giftDatas = ResOpActivityDetail[relateId]

		if relateId and giftDatas then
			for i, giftData in ipairs(giftDatas) do
				local notShow = false
				local conditionData = giftData.act_limit_id and ResOpActivityConditionLimit[giftData.act_limit_id] or nil

				if conditionData and conditionData.param3 then
					notShow = ConditionLimitManager.inLimitState(conditionData.param3)
				end

				if not notShow and conditionData and conditionData.param1 and conditionData.param2 and self.clientData[conditionData.param1] and self.clientData[conditionData.param1][conditionData.param2] then
					table.insert(giftAchieveDataList, self.clientData[conditionData.param1][conditionData.param2])
				end
			end
		end
	end

	return giftAchieveDataList
end

function ActivityDataAchieve:getAchieveDataListByGroup(groupId)
	if self.groupAchieveInfo[groupId] then
		return self.groupAchieveInfo[groupId]
	end
end

function ActivityDataAchieve:getGroupAwardAchieveData(groupId)
	for achieveType, aInfo in pairs(self.clientData) do
		for index, aData in ipairs(aInfo) do
			if aData.type and aData.type == Const.ACT_ACHIEVE_TYPE_GROUP_AWARD and aData.index and aData.index == groupId then
				return aData
			end
		end
	end
end

function ActivityDataAchieve:getGroupUnlockAchieveData(groupId)
	local resAchieveGroup = self.clientAchieveGroup[groupId]

	if resAchieveGroup and resAchieveGroup.condition_id and ResOpActivityConditionLimit[resAchieveGroup.condition_id] then
		local conditionData = ResOpActivityConditionLimit[resAchieveGroup.condition_id]
		local detailId = conditionData.templ_id
		local achieveType = conditionData.param1
		local achieveIndex = conditionData.param2

		if detailId and achieveType and achieveIndex and self.clientData[achieveType] and self.clientData[achieveType][achieveIndex] then
			return self.clientData[achieveType][achieveIndex]
		end
	end
end

function ActivityDataAchieve:isAllCompleteFromGroup(groupId)
	local actObj = CurAvatar:getActivityObj(self.actId)
	local achieveList = self:getAchieveDataListByGroup(groupId)
	local isUnlock, lockDesc = CurAvatar:checkActivityConditionLimit(self.clientAchieveGroup[groupId].condition_id)

	if not isUnlock then
		return false
	end

	for _, achieveData in ipairs(achieveList) do
		local achieveState = self:getAchieveState(achieveData.type, achieveData.index)

		if achieveState == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
			return false
		end
	end

	return true
end

function ActivityDataAchieve:updateRoleData(roleData)
	if self.actObject and self.actObject.roleCommonData and self.actObject.roleCommonData.relate_season_actid and self.actObject.roleCommonData.relate_season_actid ~= 0 then
		CurAvatar:recordActivityRelate(self.actObject.roleCommonData.relate_season_actid, self.actObject.opId)

		self.isSeasonBP = true
	end

	local beforeUnlockGroup = self:getLastUnlockGroup()

	for _, aInfo in ipairs(roleData.achieve.data) do
		local newInfo = {}

		newInfo.progress = aInfo.progress or 0

		if aInfo.type == Const.RESKET_ACHIEVE_TYPE_TICK then
			newInfo.progress = self:getTickProgress()
		end

		newInfo.round = aInfo.round

		if aInfo.awarded then
			newInfo.got = ClientUtils.getBitsDictFromByteString(aInfo.awarded)
		else
			newInfo.got = aInfo.got
		end

		newInfo.next_reset_time = aInfo.next_reset_time

		if self.connectRechargeId or self.hasRechargeExtra then
			newInfo.rechargeGot = ClientUtils.getBitsDictFromByteString(aInfo.recharge_awarded)
		end

		if self.connectMultipleRechargeId then
			newInfo.multipleRechargeGot = ClientUtils.getBitsDictFromByteString(aInfo.recharge_awarded)
		end

		if self.resetTimer[aInfo.type] then
			self.resetTimer[aInfo.type]:Stop()
		end

		if aInfo.recharge_extra_lock then
			newInfo.rechargeExtraLock = ClientUtils.getBitsDictFromByteString(aInfo.recharge_extra_lock)
		end

		if newInfo.next_reset_time > 0 then
			if newInfo.next_reset_time <= ClientUtils.getServerTime() then
				newInfo.progress = 0
				newInfo.got = {}
				newInfo.rechargeGot = {}
			else
				if not self.resetTimer[aInfo.type] then
					self.resetTimer[aInfo.type] = Timer.New(Functor(self.timerRefreshAchieveData, self, aInfo.type), 5, 1)
				end

				self.resetTimer[aInfo.type].duration = newInfo.next_reset_time - ClientUtils.getServerTime()

				self.resetTimer[aInfo.type]:Restart()
			end
		end

		if BITS_ACHIEVE_TYPE[aInfo.type] and aInfo.force_completed then
			newInfo.force_completed = ClientUtils.getBitsDictFromByteString(aInfo.force_completed)
		else
			newInfo.force_completed = {}
		end

		self.serverData[aInfo.type] = newInfo
	end

	for achieveType, typeData in pairs(self.clientData) do
		if achieveType == Const.RESKET_ACHIEVE_TYPE_TICK and not self.serverData[achieveType] then
			local newInfo = {}

			newInfo.progress = self:getTickProgress()
			newInfo.got = {}
			self.serverData[achieveType] = newInfo
		end
	end

	self.totalRound = roleData.achieve.award_count
	self.gotFinalAward = roleData.achieve.final_awarded

	if self.connectRechargeId or self.hasRechargeExtra then
		self.hasRecharged = roleData.achieve.recharged
	end

	local unlockGroup, unlockIdx = self:getLastUnlockGroup()

	if unlockGroup ~= beforeUnlockGroup then
		self:setNewUnlockGroup(unlockGroup)
		self:setNewUnlockGift(unlockIdx)
	end

	local relatedActCOnfig = UIConst.ACTIVITY_RELATED_CONFIG[self.actId]

	if relatedActCOnfig and relatedActCOnfig[2] then
		local obj = CurAvatar:getActivityObj(relatedActCOnfig[2])

		if obj then
			obj:checkNew()
		end
	end

	local mutiAchi_related = UIConst.ACTIVITY_MUTIACHIEVE_RELATE_CONFIG[self.actId]

	if mutiAchi_related and mutiAchi_related[2] then
		local actObj = CurAvatar:getActivityObj(mutiAchi_related[2])

		if actObj then
			actObj:checkNew()
		end
	end
end

function ActivityDataAchieve:setNewUnlockGroup(unlockGroup)
	if unlockGroup then
		UserData.saveCommonData(CurAvatar.uid .. "newUnlockAchieveGroup" .. self.actId, unlockGroup)
	else
		UserData.clearCommonData(CurAvatar.uid .. "newUnlockAchieveGroup" .. self.actId)
	end

	self.cacheNewUnlockGroup = unlockGroup
end

function ActivityDataAchieve:setNewUnlockGift(unlockGift)
	if unlockGift then
		UserData.saveCommonData(CurAvatar.uid .. "newUnlockAchieveGift" .. self.actId, unlockGift)
	else
		UserData.clearCommonData(CurAvatar.uid .. "newUnlockAchieveGift" .. self.actId)
	end

	self.cacheNewUnlockGift = unlockGift
end

function ActivityDataAchieve:initNewUnlockGroupGift()
	local unlockGroup = UserData.loadCommonData(CurAvatar.uid .. "newUnlockAchieveGroup" .. self.actId)

	if unlockGroup then
		self.cacheNewUnlockGroup = tonumber(unlockGroup)
	end

	local unlockGift = UserData.loadCommonData(CurAvatar.uid .. "newUnlockAchieveGift" .. self.actId)

	if unlockGift then
		self.cacheNewUnlockGift = tonumber(unlockGift)
	end
end

function ActivityDataAchieve:getTickProgress()
	local curProgress = 0
	local achieveData = self.clientData[Const.RESKET_ACHIEVE_TYPE_TICK]

	if achieveData then
		for id, data in ipairs(achieveData) do
			local curTick = ClientUtils.getServerTime()

			if curTick >= data.param then
				curProgress = data.param
			else
				local leftTime = data.param - curTick

				if self.tickTimer then
					self.tickTimer:Stop()

					self.tickTimer = nil
				end

				self.tickTimer = Timer.New(Slot(self.tickTimerOver, self), leftTime)

				self.tickTimer:Start()

				break
			end
		end
	end

	if not self.serverData[Const.RESKET_ACHIEVE_TYPE_TICK] then
		self.serverData[Const.RESKET_ACHIEVE_TYPE_TICK] = {
			progress = curProgress,
			got = {}
		}
	end

	return curProgress
end

function ActivityDataAchieve:tickTimerOver()
	self.tickTimer = nil

	if self.serverData[Const.RESKET_ACHIEVE_TYPE_TICK] then
		self.serverData[Const.RESKET_ACHIEVE_TYPE_TICK].progress = self:getTickProgress()
	end

	local obj = CurAvatar:getActivityObj(self.actId)

	if obj then
		obj:checkNew()
		obj:refreshUI()
	end
end

function ActivityDataAchieve:timerRefreshAchieveData(aType)
	local newInfo = self.serverData[aType] or {}

	newInfo.progress = 0
	newInfo.got = {}
	newInfo.rechargeGot = {}
	self.serverData[aType] = newInfo

	if self.resetTimer[aType] then
		self.resetTimer[aType]:Stop()
	end

	local obj = CurAvatar:getActivityObj(self.actId)

	if obj then
		obj:checkNew()
		obj:refreshUI()
	end
end

function ActivityDataAchieve:checkInlockIndex()
	self.inLockIndex = {}
	self.limitIdGroup = {}

	local tempData = ResOpActivityTemplate[self.actId]
	local relateId

	if tempData then
		relateId = tempData.relate_act and tempData.relate_act[1]

		local giftData = ResOpActivityDetail[relateId]

		if relateId and giftData then
			local startLockIndex, lockAchieveData

			for index, data in ipairs(giftData) do
				if data.act_limit_id then
					local limitData = ResOpActivityConditionLimit[data.act_limit_id]

					if limitData then
						local limitCondId = limitData.param3

						if limitCondId then
							self.limitIdGroup[limitCondId] = true

							if ConditionLimitManager.inLimitState(limitCondId) then
								startLockIndex = limitData.param2
								lockAchieveData = self.clientData[limitData.param1]

								break
							end
						end
					end
				end
			end

			if startLockIndex and lockAchieveData then
				for aIndex = startLockIndex, #lockAchieveData do
					self.inLockIndex[aIndex] = true
				end
			end
		end
	end
end

function ActivityDataAchieve:getlimitIdGroup()
	if not self.limitIdGroup then
		self:checkInlockIndex()
	end

	return self.limitIdGroup or {}
end

function ActivityDataAchieve:checkNew()
	if self.isSeasonBP or self.isSeasonMain then
		CurAvatar:refreshSeasonPlayUIs()
	end

	if self.cacheNewUnlockGift and UIConst.NEED_HINT_NEW_UNLOCK_GIFT[self.actId] then
		return true
	end

	self:checkInlockIndex()

	if self.totalMaxRound and (self.totalRound or 0) >= self.totalMaxRound then
		if self.gotFinalAward ~= 1 then
			return true
		else
			return false
		end
	end

	for achieveType, typeData in pairs(self.clientData) do
		if BITS_ACHIEVE_TYPE[achieveType] then
			local force_completed = {}
			local got = {}

			if self.serverData and self.serverData[achieveType] then
				force_completed = self.serverData[achieveType].force_completed
				got = self.serverData[achieveType].got
			end

			for achieveIndex, achieveData in ipairs(typeData) do
				if force_completed[achieveIndex] and not got[achieveIndex] then
					return true
				end
			end
		else
			local nowProgress = 0
			local gotState = {}
			local rechargeGot = {}
			local rechargeUnLock = {}

			if self.serverData and self.serverData[achieveType] then
				nowProgress = self.serverData[achieveType].progress
				gotState = self.serverData[achieveType].got
				rechargeGot = self.serverData[achieveType].rechargeGot
				rechargeUnLock = self.serverData[achieveType].rechargeExtraLock
			end

			for achieveIndex, achieveData in ipairs(typeData) do
				if not self.inLockIndex[achieveData.index] and nowProgress >= achieveData.param then
					local canGot = true

					if achieveData.limit_id and not CurAvatar:checkActivityConditionLimit(achieveData.limit_id) then
						canGot = false
					end

					if canGot then
						if not gotState[achieveIndex] and achieveData.award then
							return true
						end

						if self.hasRecharged == 1 and achieveData.recharge_award and (not rechargeGot or not rechargeGot[achieveIndex]) then
							return true
						end

						if self.hasRechargeExtra == true and rechargeUnLock and rechargeUnLock[achieveIndex] and (not rechargeGot or not rechargeGot[achieveIndex]) then
							return true
						end
					end
				end
			end
		end
	end
end

function ActivityDataAchieve:getAchieveProgress(achieveType, includeRound)
	if achieveType == nil then
		for nowType, typeData in pairs(self.clientData) do
			achieveType = nowType

			break
		end
	end

	if FULL_SERVER_ACHIEVE_TYPE[achieveType] then
		for i, v in pairs(self.specFullServerData or {}) do
			if v.type == achieveType then
				return v.world_count
			end
		end

		return 0
	elseif self.serverData and self.serverData[achieveType] then
		if includeRound and self.roundMaxInfo[achieveType] then
			return self.serverData[achieveType].progress + self.serverData[achieveType].round * self.roundMaxInfo[achieveType]
		else
			return self.serverData[achieveType].progress
		end
	else
		return 0
	end
end

local FINISH_ONLY_TYPE = {}

function ActivityDataAchieve:getAchieveShowProgress(data)
	local achieveType = data.type
	local needPro = data.param
	local nowPro = self:getAchieveProgress(achieveType)

	if achieveType == 30 then
		return nowPro / 100, needPro / 100
	elseif achieveType == 88 then
		return math.floor(nowPro / 3600), math.floor(needPro / 3600)
	elseif needPro == 0 and data.limit_id then
		local unlock, desc, needProgress = CurAvatar:checkActivityConditionLimit(data.limit_id)

		if needProgress then
			return nowPro, needProgress
		elseif unlock then
			return 0, 1
		else
			return 1, 1
		end
	elseif BITS_ACHIEVE_TYPE[achieveType] then
		if self.serverData[achieveType] and self.serverData[achieveType].force_completed and self.serverData[achieveType].force_completed[data.index] then
			return 1, 1
		else
			return 0, 1
		end
	elseif FINISH_ONLY_TYPE[achieveType] then
		if needPro <= nowPro then
			return 1, 1
		else
			return 0, 1
		end
	else
		return nowPro, needPro
	end
end

function ActivityDataAchieve:getAchieveState(achieveType, achieveIndex, isRechargeState)
	if BITS_ACHIEVE_TYPE[achieveType] then
		local force_completed = {}
		local got = {}

		if self.serverData and self.serverData[achieveType] then
			force_completed = self.serverData[achieveType].force_completed
			got = self.serverData[achieveType].got
		end

		if force_completed[achieveIndex] then
			if got[achieveIndex] then
				return Const.ACT_ACHIEVE_STATE_GOT
			else
				return Const.ACT_ACHIEVE_STATE_ENOUGH
			end
		end

		return Const.ACT_ACHIEVE_STATE_NOT_ENOUGH
	else
		if isRechargeState and self.hasRecharged ~= 1 then
			return Const.ACT_ACHIEVE_STATE_LOCK
		end

		local nowProgress = 0

		if self.serverData and self.serverData[achieveType] then
			nowProgress = self.serverData[achieveType].progress
		end

		if isRechargeState and self.serverData[achieveType] and self.serverData[achieveType].rechargeGot and self.serverData[achieveType].rechargeGot[achieveIndex] then
			return Const.ACT_ACHIEVE_STATE_GOT
		elseif not isRechargeState and self.serverData[achieveType] and self.serverData[achieveType].got[achieveIndex] then
			return Const.ACT_ACHIEVE_STATE_GOT
		else
			local achData = self:getAchieveOneData(achieveType, achieveIndex)

			if achData and nowProgress >= achData.param then
				if achData.param == 0 and achData.limit_id then
					if CurAvatar:checkActivityConditionLimit(achData.limit_id) then
						return Const.ACT_ACHIEVE_STATE_ENOUGH
					end
				else
					return Const.ACT_ACHIEVE_STATE_ENOUGH
				end
			end
		end

		return Const.ACT_ACHIEVE_STATE_NOT_ENOUGH
	end
end

function ActivityDataAchieve:getAchieveOneData(achieveType, achieveIndex)
	if self.clientData and self.clientData[achieveType] then
		return self.clientData[achieveType][achieveIndex]
	end
end

function ActivityDataAchieve:getNextAchieveInfo(notEnough)
	local lastData
	local lastPro = 0
	local rate = 0
	local preRoundProgress = 0
	local preProgress = 0

	for achieveType, aInfo in pairs(self.clientData) do
		preProgress = 0

		local nowProgress = 0

		if self.serverData and self.serverData[achieveType] then
			nowProgress = self.serverData[achieveType].progress
		end

		if self.clientFakeRound then
			for round, roundInfo in ipairs(self.clientFakeRound) do
				local eIndex = roundInfo.detail_index
				local indexData = aInfo[eIndex]

				if indexData and indexData.param and nowProgress >= indexData.param and round ~= #self.clientFakeRound then
					preRoundProgress = indexData.param
				else
					break
				end
			end
		end

		for index, aData in ipairs(aInfo) do
			rate = (nowProgress - preProgress) / (aData.param - preProgress)

			local state = self:getAchieveState(achieveType, index)

			if state ~= Const.ACT_ACHIEVE_STATE_GOT and (not notEnough or notEnough and state ~= Const.ACT_ACHIEVE_STATE_ENOUGH) then
				return aData, nowProgress - preRoundProgress, rate, preRoundProgress, preProgress
			else
				lastData = aData
				lastPro = nowProgress
			end

			preProgress = aData.param
		end
	end

	return lastData, lastPro - preRoundProgress, rate, preRoundProgress, preProgress
end

function ActivityDataAchieve:getAchieveStageAward(stageInfo, bonuIds)
	if self.miscData and self.miscData.hide_bonus == 1 then
		return
	end

	if self.clientData and self.clientData[Const.ACT_ACHIEVE_TYPE_STAGE] then
		local chapter = stageInfo.chapter
		local level = stageInfo.level
		local shortId = 10000 + chapter * 100 + level

		for index, info in ipairs(self.clientData[Const.ACT_ACHIEVE_TYPE_STAGE]) do
			if info.param == shortId and info.award then
				table.insert(bonuIds, {
					info.award,
					self.actId
				})

				break
			end
		end
	end
end

function ActivityDataAchieve:hasStageAchieveAward()
	if self.clientData and self.clientData[Const.ACT_ACHIEVE_TYPE_STAGE] then
		return true
	end
end

function ActivityDataAchieve:getAchieveMiscDataByType(achieveType)
	if ResOpActivityAchieveMisc[self.actId] and ResOpActivityAchieveMisc[self.actId][achieveType] then
		return ResOpActivityAchieveMisc[self.actId][achieveType]
	end
end

function ActivityDataAchieve:isOver()
	if self.totalMaxRound then
		if (self.totalRound or 0) < self.totalMaxRound then
			return false
		end

		if self.finalBonus and self.gotFinalAward ~= 1 then
			return false
		end

		return true
	end

	local miscData = ResOpActivityAchieveMisc[self.actId] or {}

	for achieType, typeData in pairs(self.clientData) do
		if miscData[achieType] and miscData[achieType].max_round then
			local serverData = self.serverData[achieType] or {}
			local nowRound = serverData.round or 0

			if nowRound < miscData[achieType].max_round - 1 then
				return false
			end
		end

		if self.serverData and self.serverData[achieType] then
			local nowProgress = self.serverData[achieType].progress
			local gotState = self.serverData[achieType].got
			local rechargeGot = self.serverData[achieType].rechargeGot

			for achieveIndex, achieveData in ipairs(typeData) do
				if achieveData.is_sub_achieve and achieveData.is_sub_achieve == 1 then
					if nowProgress < achieveData.param then
						return false
					end
				elseif not gotState[achieveIndex] then
					return false
				elseif self.connectRechargeId and (not rechargeGot or not rechargeGot[achieveIndex]) then
					return false
				end
			end
		else
			return false
		end
	end

	return true
end

function ActivityDataAchieve:getNextResetTime(achieveType)
	if self.serverData and self.serverData[achieveType] then
		if self.serverData[achieveType].next_reset_time then
			return self.serverData[achieveType].next_reset_time
		else
			return nil
		end
	else
		return nil
	end
end

function ActivityDataAchieve:resetDaily(achieveType)
	if self.serverData and self.serverData[achieveType] then
		self.serverData[achieveType] = nil
	end
end

function ActivityDataAchieve:getAchieveParam(achieveType, achieveIndex)
	if self.clientData and self.clientData[achieveType] then
		return self.clientData[achieveType][achieveIndex].param
	end
end

function ActivityDataAchieve:getSelectCount(achieveType, achieveIndex)
	local progress = self:getAchieveProgress(achieveType)
	local param = self:getAchieveParam(achieveType, achieveIndex)
	local selCount = math.floor(progress / param)
	local miscData = ResOpActivityAchieveMisc[self.actId] or {}
	local miscDetail = miscData[achieveType]
	local maxRound = miscDetail.max_round or 0

	selCount = math.min(maxRound, selCount)

	return selCount, maxRound
end

function ActivityDataAchieve:getDesc()
	return ResOpActivityAchieveMisc[self.actId] or {}
end

function ActivityDataAchieve:isDataValid()
	if self.miscData and self.miscData.timeout_disable == 1 and self.connectRechargeId and self.hasRecharged ~= 1 then
		local RechargeManager = require("System/Recharge/RechargeManager")
		local remainTime = RechargeManager.getProductRemainTime(self.connectRechargeId)

		if remainTime and remainTime > 0 then
			return true
		else
			return false
		end
	end

	return true
end

function ActivityDataAchieve:_calcGroupNow(achieveType, groupType)
	local returnIndex = 0

	for _, achieveData in ipairs(self.groupShowAchieveList[achieveType][groupType]) do
		local state = self:getAchieveState(achieveType, achieveData.index)

		if state == Const.ACT_ACHIEVE_STATE_ENOUGH or state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
			return achieveData.index
		end

		returnIndex = achieveData.index
	end

	return returnIndex
end

function ActivityDataAchieve:_calcGroupNowAchieve(achieveType, groupType)
	if not achieveType and not groupType then
		for achiType, groupData in pairs(self.groupShowAchieveList) do
			if not self.groupShowFocusDict[achiType] then
				self.groupShowFocusDict[achiType] = {}
			end

			for groupId, achiData in pairs(groupData) do
				self.groupShowFocusDict[achiType][groupId] = self:_calcGroupNow(achiType, groupId)
			end
		end
	else
		local achieveInfo = self.groupShowAchieveList[achieveType][groupType]

		if not achieveInfo or not achieveInfo.group_type then
			return
		end

		local groupId = achieveInfo.group_type

		if not self.groupShowFocusDict[achieveType] then
			self.groupShowFocusDict[achieveType] = {}
		end

		self.groupShowFocusDict[achieveType][groupType] = self:_calcGroupNow(achieveType, groupType)
	end
end

function ActivityDataAchieve:getGroupShowAchieveDataList()
	self:_calcGroupNowAchieve()

	local showList = {}

	for achieveType, typeData in pairs(self.clientData) do
		for achieveIndex, achieveData in ipairs(typeData) do
			local group_type = achieveData.group_type

			if not group_type or achieveIndex == self.groupShowFocusDict[achieveType][group_type] then
				table.insert(showList, achieveData)
			end
		end
	end

	return showList
end

local function SortPrior(a, b)
	if a.show_priority and b.show_priority and a.show_priority ~= b.show_priority then
		return a.show_priority < b.show_priority
	end

	return a.type < b.type
end

function ActivityDataAchieve:getSortedData()
	local finishData = {}
	local enoughData = {}
	local nmlData = {}

	for achType, cData in pairs(self.clientData) do
		for index, data in pairs(cData) do
			local state = self:getAchieveState(achType, index)

			if state == Const.ACT_ACHIEVE_STATE_ENOUGH then
				table.insert(enoughData, data)
			elseif state == Const.ACT_ACHIEVE_STATE_GOT then
				table.insert(finishData, data)
			else
				table.insert(nmlData, data)
			end
		end
	end

	table.sort(finishData, SortPrior)
	table.sort(enoughData, SortPrior)
	table.sort(nmlData, SortPrior)

	local outData = {}

	for _, data in ipairs(enoughData) do
		table.insert(outData, data)
	end

	for _, data in ipairs(nmlData) do
		table.insert(outData, data)
	end

	for _, data in ipairs(finishData) do
		table.insert(outData, data)
	end

	return outData
end

function ActivityDataAchieve:getAchieveProgressAndRound(achieveType)
	if self.serverData and self.serverData[achieveType] then
		return self.serverData[achieveType].progress, self.serverData[achieveType].round
	end

	return 0, 0
end

function ActivityDataAchieve:getActivityClientShowData()
	local groupClientData = {}

	for _, v in pairs(self.clientData) do
		for _, cell in pairs(v) do
			local limitData = ResOpActivityConditionLimit[cell.limit_id]

			if limitData and limitData.type == Const.ACT_CONDITION_TYPE_GROUP_ACHIEVE_RETURN then
				local group = limitData.param1

				if not group or group == CurAvatar.rebackGroup then
					table.insert(groupClientData, cell)
				end
			elseif limitData and limitData.type == Const.ACT_CONDITION_TYPE_GROUP_RETURN_AREA then
				local minGroup = limitData.param1
				local maxGroup = limitData.param2

				if minGroup and maxGroup and minGroup <= CurAvatar.rebackGroup and maxGroup >= CurAvatar.rebackGroup then
					table.insert(groupClientData, cell)
				end
			else
				table.insert(groupClientData, cell)
			end
		end
	end

	table.sort(groupClientData, function(a, b)
		if a.type < b.type then
			return true
		elseif a.type == b.type then
			return a.index < b.index
		end
	end)

	return groupClientData
end

function ActivityDataAchieve:canGetBonus(achieveType)
	if not achieveType then
		for achieveType, typeData in pairs(self.clientData) do
			if self:canGetBonus(achieveType) then
				return true
			end
		end

		return false
	end

	local typeData = self.clientData[achieveType]

	if BITS_ACHIEVE_TYPE[achieveType] then
		local force_completed = {}
		local got = {}

		if self.serverData and self.serverData[achieveType] then
			force_completed = self.serverData[achieveType].force_completed
			got = self.serverData[achieveType].got
		end

		for achieveIndex, achieveData in ipairs(typeData) do
			if force_completed[achieveIndex] and not got[achieveIndex] then
				return true
			end
		end
	else
		local nowProgress = 0
		local gotState = {}
		local rechargeGot = {}
		local rechargeUnLock = {}

		if self.serverData and self.serverData[achieveType] then
			nowProgress = self.serverData[achieveType].progress
			gotState = self.serverData[achieveType].got
			rechargeGot = self.serverData[achieveType].rechargeGot
			rechargeUnLock = self.serverData[achieveType].rechargeExtraLock
		end

		for achieveIndex, achieveData in ipairs(typeData) do
			if not self.inLockIndex[achieveData.index] and nowProgress >= achieveData.param then
				local canGot = true

				if achieveData.limit_id and not CurAvatar:checkActivityConditionLimit(achieveData.limit_id) then
					canGot = false
				end

				if canGot then
					if not gotState[achieveIndex] and achieveData.award then
						return true
					end

					if self.hasRecharged == 1 and achieveData.recharge_award and (not rechargeGot or not rechargeGot[achieveIndex]) then
						return true
					end

					if self.hasRechargeExtra == true and rechargeUnLock and rechargeUnLock[achieveIndex] and (not rechargeGot or not rechargeGot[achieveIndex]) then
						return true
					end
				end
			end
		end
	end

	return false
end

function ActivityDataAchieve:checkRemainAward(achieveType)
	if not achieveType then
		for achieveType, typeData in pairs(self.clientData) do
			if self:checkRemainAward(achieveType) then
				return true
			end
		end

		return false
	end

	local typeData = self.clientData[achieveType]

	if BITS_ACHIEVE_TYPE[achieveType] then
		-- block empty
	else
		local got = {}

		if self.serverData and self.serverData[achieveType] then
			got = self.serverData[achieveType].got
		end

		for achieveIndex, achieveData in ipairs(typeData) do
			if not got[achieveIndex] then
				return true
			end
		end

		local rechargeGot = {}

		if self.serverData and self.serverData[achieveType] then
			rechargeGot = self.serverData[achieveType].rechargeGot
		end

		for achieveIndex, achieveData in ipairs(typeData) do
			if not rechargeGot[achieveIndex] then
				return true
			end
		end
	end

	return false
end

function ActivityDataAchieve:checkActivityExtraOpen(...)
	if self.miscData and self.miscData.check_close and self.miscData.check_close == 1 then
		if self.miscData.multiple_recharge_id and self.miscData.multiple_recharge_id > 0 then
			if self.hasRecharged and self.hasRecharged ~= 0 then
				return self:checkRemainAward()
			else
				return ClientUtils.getServerTime() < self.actObject.endTime
			end
		else
			return ClientUtils.getServerTime() < self.actObject.endTime
		end
	else
		return ClientUtils.getServerTime() < self.actObject.endTime
	end
end

function ActivityDataAchieve:getLeftTimeToFreeze(...)
	if self.actObject.curState == Const.OPACT_STATE_CLOSE or self.actObject.curState == Const.OPACT_STATE_FREEZE then
		return -1
	end

	if self.freezeTime then
		return self.freezeTime - ClientUtils.getServerTime()
	end

	return -1
end

return ActivityDataAchieve
