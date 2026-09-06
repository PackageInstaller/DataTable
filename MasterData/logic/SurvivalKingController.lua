-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/controller/SurvivalKingController.lua

module("logic.extensions.survivalking.controller.SurvivalKingController", package.seeall)

local SurvivalKingController = class("SurvivalKingController", BaseController)

SurvivalKingController.TimeStatus = {
	SignUp = 2,
	AllEnded = 6,
	InProgress = 4,
	Ended = 5,
	NotOpen = 1,
	RegistrationClosed = 3
}
SurvivalKingController.BuffMode = {
	Level = 2,
	Inventory = 1
}

function SurvivalKingController:onInit()
	self:onReset()
end

function SurvivalKingController:onReset()
	self._fmtMoMap = {}
	self._levelBuffRoundIds = {}
	self._formMap = {}
end

function SurvivalKingController:_getFmtMo(activityId, groupId)
	local key = string.format("%s_%s", activityId, groupId)
	local fmtMo = self._fmtMoMap[key]

	if not fmtMo then
		fmtMo = SurvivalKingFmtMo.New()
		self._fmtMoMap[key] = fmtMo
	end

	return fmtMo
end

function SurvivalKingController:_getLevelBuffRoundIds(activityId)
	if self._levelBuffRoundIds[activityId] then
		return self._levelBuffRoundIds[activityId]
	end

	local allRoundCfgs = SurvivalKingConfig.instance:getAllRoundCfgs(activityId) or {}
	local roundIdList = {}

	for cfgRoundId, _ in pairs(allRoundCfgs) do
		if SurvivalKingConfig.instance:canSetLevelBuff(activityId, cfgRoundId) then
			table.insert(roundIdList, cfgRoundId)
		end
	end

	table.sort(roundIdList)

	self._levelBuffRoundIds[activityId] = roundIdList

	return roundIdList
end

function SurvivalKingController:_getFormStr(activityId, groupId)
	local key = string.format("%s_%s", activityId, groupId)

	if self._formMap[key] then
		return self._formMap[key]
	end

	local fmtMo = self:_getFmtMo(activityId, groupId)

	fmtMo:initParams(activityId, groupId)

	local simpleForm = fmtMo:getCurSimpleForm()

	self._formMap[key] = simpleForm:SerializeToString()

	return self._formMap[key]
end

function SurvivalKingController:saveFmtInfo(activityId, groupId, simpleForm)
	self._formMap[string.format("%s_%s", activityId, groupId)] = nil

	local groupInfoList = {}
	local groupInfo = SurvivalKingExtension_pb.SurvivalKingGroupPreset()

	groupInfo.groupId = groupId

	groupInfo.simpleForm:ParseFromString(simpleForm:SerializeToString())

	local roundCfgs = SurvivalKingConfig.instance:getRoundGroupCfgs(activityId, groupId) or {}

	if SurvivalKingConfig.instance:isBuffMode(activityId, SurvivalKingController.BuffMode.Inventory) then
		local buffIdMap = SurvivalKingModel.instance:getDefBuffs(activityId)

		for _, v in pairs(roundCfgs) do
			buffIdMap[v.roundId] = buffIdMap[v.roundId] or 0

			local info = {}

			info.roundId = v.roundId
			info.buffId = buffIdMap[v.roundId] or 0

			if info.buffId > 0 then
				local buffIdPb = groupInfo.buffId:add()
				local pairPb = CommonStructDef_pb.PM_PairInt()

				pairPb.left = info.roundId
				pairPb.right = info.buffId

				buffIdPb:ParseFromString(pairPb:SerializeToString())
			end
		end
	end

	table.insert(groupInfoList, groupInfo)
	self:sendSetPresetInfo(activityId, groupInfoList)
end

function SurvivalKingController:saveBuffId(activityId, buffId, roundId)
	local roundCfg = SurvivalKingConfig.instance:getRoundCfgByRoundId(activityId, roundId)

	if not roundCfg then
		return
	end

	local groupId = roundCfg.groupId
	local groupInfoList = {}
	local groupInfo = SurvivalKingExtension_pb.SurvivalKingGroupPreset()

	groupInfo.groupId = groupId

	local fmtMo = self:_getFmtMo(activityId, groupId)

	fmtMo:initParams(activityId, groupId)

	local simpleForm = fmtMo:getCurSimpleForm()

	groupInfo.simpleForm:ParseFromString(simpleForm:SerializeToString())

	local roundCfgs = SurvivalKingConfig.instance:getRoundGroupCfgs(activityId, groupId) or {}
	local buffIdMap = SurvivalKingModel.instance:getDefBuffs(activityId)

	for _, v in pairs(roundCfgs) do
		buffIdMap[v.roundId] = buffIdMap[v.roundId] or 0

		local info = {}

		info.roundId = v.roundId
		info.buffId = v.roundId == roundId and buffId or buffIdMap[v.roundId] or 0

		if info.buffId > 0 then
			local buffIdPb = groupInfo.buffId:add()
			local pairPb = CommonStructDef_pb.PM_PairInt()

			pairPb.left = info.roundId
			pairPb.right = info.buffId

			buffIdPb:ParseFromString(pairPb:SerializeToString())
		end
	end

	table.insert(groupInfoList, groupInfo)
	self:sendSetPresetInfo(activityId, groupInfoList)
end

function SurvivalKingController:saveLevelBuffId(activityId, buffId, roundId)
	local roundCfg = SurvivalKingConfig.instance:getRoundCfgByRoundId(activityId, roundId)

	if not roundCfg then
		return
	end

	local groupId = roundCfg.groupId
	local groupInfoList = {}
	local groupInfo = SurvivalKingExtension_pb.SurvivalKingGroupPreset()

	groupInfo.groupId = groupId

	groupInfo.simpleForm:ParseFromString(self:_getFormStr(activityId, groupId))
	table.insert(groupInfoList, groupInfo)

	local levelBuffIds = {}
	local levelBuffSelectionMap = SurvivalKingModel.instance:getLevelBuffSelections(activityId)
	local roundIdList = self:_getLevelBuffRoundIds(activityId)

	for _, cfgRoundId in ipairs(roundIdList) do
		if not levelBuffSelectionMap[cfgRoundId] then
			local levelBuffId = 0

			if cfgRoundId == roundId then
				levelBuffId = buffId or 0
			end

			if levelBuffSelectionMap[cfgRoundId] > 0 then
				local pairPb = CommonStructDef_pb.PM_PairInt()

				pairPb.left = cfgRoundId
				pairPb.right = levelBuffSelectionMap[cfgRoundId]

				table.insert(levelBuffIds, pairPb)
			end
		end
	end

	self:sendSetPresetInfo(activityId, groupInfoList, levelBuffIds)
end

function SurvivalKingController:sendGetPresetInfo(activityId)
	SurvivalKingAgent.instance:sendPM_SurvivalKingGetPresetReq(activityId)
end

function SurvivalKingController:handleGetPresetInfo(msg)
	SurvivalKingModel.instance:onGetPresetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SurvivalKingUpdatePresetInfo, msg)
end

function SurvivalKingController:sendSetPresetInfo(activityId, groups_pb_Ary, levelBuffId_pb_Ary)
	SurvivalKingAgent.instance:sendPM_SurvivalKingSetPresetReq(activityId, groups_pb_Ary, levelBuffId_pb_Ary)
end

function SurvivalKingController:handleSetPresetInfo(msg)
	self:sendGetPresetInfo(msg.activityId)
	TipsFacade.instance:openCommonTips("修改成功！")
end

function SurvivalKingController:getBaseInfo(activityId)
	SurvivalKingAgent.instance:sendPM_SurvivalKingInfoReq(activityId)
end

function SurvivalKingController:handleGetBaseInfo(msg)
	SurvivalKingModel.instance:onGetBaseInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SurvivalKingGetBaseInfo)
end

function SurvivalKingController:getRankInfo(activityId)
	SurvivalKingAgent.instance:sendPM_SurvivalKingRankInfoReq(activityId)
end

function SurvivalKingController:handleGetRankInfo(msg)
	SurvivalKingModel.instance:onGetRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SurvivalKingRankInfo)
end

function SurvivalKingController:getPrizeInfo(activityId)
	SurvivalKingAgent.instance:sendPM_SurvivalKingPrizeInfoReq(activityId)
end

function SurvivalKingController:handleGetPrizeInfo(msg)
	SurvivalKingModel.instance:onGetPrizeInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SurvivalKingGetPrizeInfo)
end

function SurvivalKingController:sendGainPrizeReq(activityId)
	SurvivalKingAgent.instance:sendPM_SurvivalKingGainPrizeReq(activityId)
end

function SurvivalKingController:handleGainPrize(msg)
	SurvivalKingModel.instance:onGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SurvivalKingGainPrize)
end

function SurvivalKingController:sendSignUpReq(activityId, signUps_pb_Ary)
	SurvivalKingAgent.instance:sendPM_SurvivalKingSignUpReq(activityId, signUps_pb_Ary)
end

function SurvivalKingController:handleSignUp(msg)
	SurvivalKingModel.instance:onSignUp(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SurvivalKingSignUp)
	TipsFacade.instance:openCommonTips("报名成功！")
end

function SurvivalKingController:buyBuffs(activityId, buffId, num)
	SurvivalKingAgent.instance:sendPM_SurvivalKingBuyBuffReq(activityId, buffId, num)
end

function SurvivalKingController:handleBuyBuff(msg)
	SurvivalKingModel.instance:onBuyBuff(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SurvivalKingBuyBuff)
	TipsFacade.instance:openCommonTips("购买成功！")
end

function SurvivalKingController:upgradeLevelBuff(activityId)
	SurvivalKingAgent.instance:sendPM_SurvivalKingUpgradeLevelBuffReq(activityId)
end

function SurvivalKingController:getLevelBuffUpgradeInfo(activityId)
	local levelBuffCfgs = SurvivalKingConfig.instance:getAllLevelBuffCfgs(activityId) or {}
	local curLevel = SurvivalKingModel.instance:getLevelBuffLevel(activityId)
	local maxLevel = 0

	for buffId, _ in pairs(levelBuffCfgs) do
		maxLevel = math.max(maxLevel, SurvivalKingConfig.instance:getLevelBuffMaxLevel(activityId, buffId))
	end

	local info = {}

	info.curLevel = curLevel
	info.maxLevel = maxLevel
	info.canUpgrade = false
	info.isMaxLevel = maxLevel > 0 and maxLevel <= curLevel
	info.costMatType = nil
	info.costMatId = nil
	info.costMatNum = 0
	info.costHasNum = 0

	if info.isMaxLevel then
		return info
	end

	local nextLevel = curLevel + 1
	local costCfg = SurvivalKingConfig.instance:getLevelBuffCostCfg(activityId, nextLevel)

	if costCfg then
		if not costCfg.cost then
			local cost = ""

			if string.nilorempty(cost) then
				return info
			end

			info.costMatType, info.costMatId, info.costMatNum = MaterialMgr.getMatParams(cost)
			info.costHasNum = MaterialModel.instance:getMaterialsNumber(info.costMatType, info.costMatId)

			local timeStatus = self:getCurStatusByTime(activityId)

			info.canUpgrade = timeStatus == SurvivalKingController.TimeStatus.SignUp and info.costHasNum >= info.costMatNum

			return info
		end
	end
end

function SurvivalKingController:handleUpgradeLevelBuff(msg)
	self:getBaseInfo(msg.activityId)
	TipsFacade.instance:openCommonTips(lang("升级成功！"))
end

function SurvivalKingController:getBattleRecord(activityId)
	SurvivalKingAgent.instance:sendPM_SurvivalKingRecordLogReq(activityId)
end

function SurvivalKingController:handleGetBattleRecord(msg)
	SurvivalKingModel.instance:onGetBattleRecord(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SurvivalKingGetBattleRecord)
end

function SurvivalKingController:getRoomInfo(activityId, sessionId)
	SurvivalKingAgent.instance:sendPM_SurvivalKingRoomInfoReq(activityId, sessionId)
end

function SurvivalKingController:handleGetRoomInfo(msg)
	SurvivalKingModel.instance:onGetRoomInfo(msg)

	if not msg.sessionId then
		GlobalDispatcher:dispatch(GlobalNotify.SurvivalKingGetRoomInfo, msg.sessionId)
	end
end

function SurvivalKingController:getBattleDetail(activityId, recordId)
	SurvivalKingAgent.instance:sendPM_SurvivalKingRoomRecordReq(activityId, recordId)
end

function SurvivalKingController:handleGetBattleDetail(msg)
	UIStateManager.instance:push(ViewName.SurvivalKingDetailView, msg)
end

function SurvivalKingController:getCurStatusByTime(activityId)
	local timeStatus = SurvivalKingController.TimeStatus.NotOpen
	local freshTime = 0
	local actCfg = SurvivalKingConfig.instance:getActivityCfg(activityId)

	if not actCfg then
		return timeStatus
	end

	local signUpAdvanceTime = checknumber(SurvivalKingConfig.instance:getCommonValue("SIGN_UP_PROTECT_TIME")) or 10
	local signUpAdvanceTimeInSeconds = signUpAdvanceTime * 60

	if not actCfg.signUpEndTime then
		local curTime = ServerTime.now()

		if not actCfg.openTime then
			local openTimeStr = ""

			if not actCfg.endTime then
				local endTimeStr = ""
				local openTime = self:string2timeIsIgnoreDay(openTimeStr)
				local endTime = self:string2timeIsIgnoreDay(endTimeStr)
				local timePeriodType = GameUtil.getTimePeriodType(openTimeStr, endTimeStr, true)

				if timePeriodType == GameUtil.beforeTimePeriod then
					timeStatus = SurvivalKingController.TimeStatus.NotOpen
					freshTime = openTime
				elseif timePeriodType == GameUtil.inTimePeriod then
					local curSessionCfg, isInProgress = self:getCurSessionCfg(activityId)

					if curSessionCfg then
						if isInProgress then
							timeStatus = SurvivalKingController.TimeStatus.InProgress
							freshTime = self:string2timeIsIgnoreDay(curSessionCfg.endTime)
						else
							local nextSessionOpenTime = self:string2timeIsIgnoreDay(curSessionCfg.openTime)
							local signUpEndTime = nextSessionOpenTime - signUpAdvanceTimeInSeconds

							if curTime < signUpEndTime then
								timeStatus = SurvivalKingController.TimeStatus.SignUp
								freshTime = signUpEndTime
							else
								timeStatus = SurvivalKingController.TimeStatus.RegistrationClosed
								freshTime = nextSessionOpenTime
							end
						end
					else
						timeStatus = SurvivalKingController.TimeStatus.Ended
						freshTime = endTime
					end
				elseif timePeriodType == GameUtil.afterTimePeriod then
					timeStatus = SurvivalKingController.TimeStatus.AllEnded
				end

				return timeStatus, freshTime
			end
		end
	end
end

function SurvivalKingController:string2timeIsIgnoreDay(timeStr)
	local time = 0

	if timeStr and timeStr ~= "" then
		local dateStr = "0-0-0 " .. timeStr

		time = GameUtil.string2time(dateStr)
	end

	return time
end

function SurvivalKingController:getCurSessionCfg(activityId)
	local isInProgress = false
	local curSessionCfg
	local cfgs = SurvivalKingConfig.instance:getAllSessionCfg(activityId) or {}

	for i, v in ipairs(cfgs) do
		if not v.openTime then
			local openTime = ""

			if not v.endTime then
				local endTime = ""
				local timePeriodType = GameUtil.getTimePeriodType(openTime, endTime, true)

				if timePeriodType == GameUtil.inTimePeriod then
					isInProgress = true
					curSessionCfg = v

					break
				elseif timePeriodType == GameUtil.beforeTimePeriod then
					curSessionCfg = curSessionCfg or v

					break
				elseif timePeriodType == GameUtil.afterTimePeriod then
					-- block empty
				end
			end
		end
	end

	return curSessionCfg, isInProgress
end

function SurvivalKingController:showDefMissionFormation(activityId, groupId)
	local fmtMo = self:_getFmtMo(activityId, groupId)

	if fmtMo then
		fmtMo:initParams(activityId, groupId)
		CustomFmtController.instance:showMissionFormationView(fmtMo)
	end
end

SurvivalKingController.SIGN_UP_RED_ID = -507

function SurvivalKingController:getActivityType()
	return GameEnum.ActivityType.SurvivalKing
end

function SurvivalKingController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function SurvivalKingController:loadSignUpRedPoint()
	self:_setSignUpRedPoint(false, 0)

	local activityId = self:getActivityId()

	if activityId <= 0 then
		return
	end

	self:_refreshSignUpRedPoint(activityId)
end

function SurvivalKingController:_refreshSignUpRedPoint(activityId)
	local timeStatus, freshTime = self:getCurStatusByTime(activityId)
	local isActive = timeStatus == SurvivalKingController.TimeStatus.SignUp

	self:_setSignUpRedPoint(isActive, isActive and freshTime or 0)
end

function SurvivalKingController:_setSignUpRedPoint(isActive, endTime)
	RedPointController.instance:setRedPointInfo(self.SIGN_UP_RED_ID, checkbool(isActive), true, 0, checknumber(endTime))
end

SurvivalKingController.instance = SurvivalKingController.New()

return SurvivalKingController
