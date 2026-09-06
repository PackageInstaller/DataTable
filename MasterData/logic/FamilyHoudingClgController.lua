-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyhoundingclg/controller/FamilyHoudingClgController.lua

module("logic.extensions.familyhoundingclg.controller.FamilyHoudingClgController", package.seeall)

local FamilyHoudingClgController = class("FamilyHoudingClgController", BaseController)

function FamilyHoudingClgController:ctor()
	return
end

function FamilyHoudingClgController:onInit()
	return
end

function FamilyHoudingClgController:onReset()
	return
end

function FamilyHoudingClgController:sendPM_FamilyHounding_GetInfoReq()
	FamilyHoundingAgent.instance:sendPM_FamilyHounding_GetInfoReq()
end

function FamilyHoudingClgController:handlePM_FamilyHounding_GetInfoRes(msg)
	FamilyHoudingClgModel.instance:handlePM_FamilyHounding_GetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_FamilyHounding_GetInfoRes)
end

function FamilyHoudingClgController:sendPM_FamilyHounding_ViewFamilyRankReq()
	FamilyHoundingAgent.instance:sendPM_FamilyHounding_ViewFamilyRankReq()
end

function FamilyHoudingClgController:handlePM_FamilyHounding_ViewFamilyRankRes(msg)
	FamilyHoudingClgModel.instance:handlePM_FamilyHounding_ViewFamilyRankRes(msg)

	local rankData = GameUtil.pbToTable(msg)
	local value = checknumber(rankData.myRank)

	if value <= 0 then
		value = checknumber(rankData.myFamilyRank)
	end

	rankData.myRank = value

	RankModel.instance:setRankData(rankData, GameEnum.RankType.FamilyTeamPlay, 0)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_FamilyHounding_ViewFamilyRankRes)
	GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
end

function FamilyHoudingClgController:sendPM_FamilyHounding_ViewPersonRankReq()
	FamilyHoundingAgent.instance:sendPM_FamilyHounding_ViewPersonRankReq()
end

function FamilyHoudingClgController:handlePM_FamilyHounding_ViewPersonRankRes(msg)
	FamilyHoudingClgModel.instance:handlePM_FamilyHounding_ViewPersonRankRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_FamilyHounding_ViewPersonRankRes)
end

function FamilyHoudingClgController:sendPM_FamilyHounding_FightReq(fhId, dayIndex, form)
	BattleFacade.instance:startFamilyHoudingClgBattle(fhId, dayIndex)
	FamilyHoundingAgent.instance:sendPM_FamilyHounding_FightReq(dayIndex, form)
end

function FamilyHoudingClgController:handlePM_FamilyHounding_FightRes(status, msg)
	if status == 0 then
		FamilyHoudingClgModel.instance:handlePM_FamilyHounding_FightRes(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_FamilyHounding_FightRes)
end

function FamilyHoudingClgController:sendPM_FamilyHounding_PracticeReq(fhId, dayIndex, form)
	BattleFacade.instance:startFamilyHoudingClgBattle(fhId, dayIndex)
	FamilyHoundingAgent.instance:sendPM_FamilyHounding_PracticeReq(dayIndex, form)
end

function FamilyHoudingClgController:handlePM_FamilyHounding_PracticeRes(status, msg)
	if status == 0 then
		FamilyHoudingClgModel.instance:handlePM_FamilyHounding_PracticeRes(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_FamilyHounding_PracticeRes)
end

function FamilyHoudingClgController:handlePM_FamilyHounding_NotifyFightResultRes(msg)
	FamilyHoudingClgModel.instance:handlePM_FamilyHounding_NotifyFightResultRes(msg)

	local fhcParams = BattleModel.instance.FamilyHoudingClgParams
	local fhId = checknumber(fhcParams[1])
	local dayIndex = checknumber(fhcParams[2])

	if fhId > 0 and dayIndex > 0 and msg ~= nil then
		local planTimeData = FamilyHoudingClgConfig.instance:getFhPlanTimeData(fhId)
		local bossData = FamilyHoudingClgConfig.instance:getFhBossData(fhId, dayIndex)
		local params = {}

		params.bossDmageParams = {}

		if params.bossDmageParams then
			local curDmage = checknumber(msg.damage)
			local maxDmage = 0
			local prizeLevel = 0
			local prizeCfg = FamilyHoudingClgConfig.instance:getFhDamagePrizeCfg(bossData.damagePrizePlanId)

			for prizeGearId, prizeData in ipairs(prizeCfg) do
				local min, max = prizeData.damageRange[1], prizeData.damageRange[2]

				if min <= curDmage then
					maxDmage = max
					prizeLevel = prizeGearId
				else
					maxDmage = min

					break
				end
			end

			params.bossDmageParams[1] = curDmage
			params.bossDmageParams[2] = maxDmage
			params.bossDmageParams[3] = prizeLevel
		end

		params.bossRewardParams = {}

		if msg.changeSetId then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
		end

		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.FamilyHoudingClg, params)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_FamilyHounding_NotifyFightResultRes)
end

function FamilyHoudingClgController:handlePM_FamilyHounding_NotifyPracticeResultRes(msg)
	FamilyHoudingClgModel.instance:handlePM_FamilyHounding_NotifyPracticeResultRes(msg)

	local fhcParams = BattleModel.instance.FamilyHoudingClgParams
	local fhId = checknumber(fhcParams[1])
	local dayIndex = checknumber(fhcParams[2])

	if fhId > 0 and dayIndex > 0 and msg ~= nil then
		local planTimeData = FamilyHoudingClgConfig.instance:getFhPlanTimeData(fhId)
		local bossData = FamilyHoudingClgConfig.instance:getFhBossData(fhId, dayIndex)
		local params = {}

		params.bossDmageParams = {}

		if params.bossDmageParams then
			local curDmage = checknumber(msg.damage)
			local maxDmage = 0
			local prizeLevel = 0
			local prizeCfg = FamilyHoudingClgConfig.instance:getFhDamagePrizeCfg(bossData.damagePrizePlanId)

			for prizeGearId, prizeData in ipairs(prizeCfg) do
				local min, max = prizeData.damageRange[1], prizeData.damageRange[2]

				if min <= curDmage then
					maxDmage = max
					prizeLevel = prizeGearId
				else
					maxDmage = min

					break
				end
			end

			params.bossDmageParams[1] = curDmage
			params.bossDmageParams[2] = maxDmage
			params.bossDmageParams[3] = prizeLevel
		end

		params.bossRewardParams = {}

		if msg.changeSetId then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
		end

		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.FamilyHoudingClg, params)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_FamilyHounding_NotifyPracticeResultRes)
end

function FamilyHoudingClgController:getCurPlanId()
	return FamilyHoudingClgModel.instance:getCurPlanId()
end

function FamilyHoudingClgController:getFhId()
	local result = 0
	local dataList = FamilyHoudingClgConfig.instance:getFhPlanTimeDataList()

	for i = #dataList, 1, -1 do
		local data = dataList[i]

		if self:isInTime(data.id) then
			result = data.id

			break
		end
	end

	return result
end

function FamilyHoudingClgController:isInTime(fhId)
	return self:getTimePeriodOfFh(fhId) == GameUtil.inTimePeriod
end

function FamilyHoudingClgController:getTimePeriodOfFh(fhId)
	local data = FamilyHoudingClgConfig.instance:getFhPlanTimeData(fhId)

	return GameUtil.getTimePeriod(data.startTime, nil)
end

function FamilyHoudingClgController:enterBattle(fhId, dayIndex, isPractice)
	local customFmtMo = FamilyHoudingClgModel.instance:getFhcCustomFmtMo()

	customFmtMo:updateCfg(fhId, dayIndex, isPractice)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function FamilyHoudingClgController:openBattleResultViewOfFhc()
	ViewMgr.instance:open(ViewName.FamilyHoudingClgSettlementSuccessView)
end

function FamilyHoudingClgController:enterFamilyHoudingClg()
	local result, tips = self:getTryEnterFamilyHoudingClgViewResultAndTips()

	FloatWordMgr.instance:show(tips)

	if result == GameEnum.ResultCode.Success then
		UIStateManager.instance:push(ViewName.FamilyHoudingClgMainView)
	end
end

function FamilyHoudingClgController:getTryEnterFamilyHoudingClgViewResultAndTips()
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local fhId = self:getFhId()

	if not self:isInTime(fhId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在开放时间内"
	end

	return result, tips
end

function FamilyHoudingClgController:getTryEnterStageViewResultAndTips(fnId, dayIndex)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInTime(fnId) then
		result = GameEnum.ResultCode.Error
		tips = "不在开放时间内"
	elseif not self:isInDayIndex(dayIndex) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在开放时间内"
	end

	return result, tips
end

function FamilyHoudingClgController:getTryPracticeStageClgResultAndTips(fnId, dayIndex)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInTime(fnId) then
		result = GameEnum.ResultCode.Error
		tips = "不在开放时间内"
	elseif not self:isInDayIndex(dayIndex) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在开放时间内"
	end

	return result, tips
end

function FamilyHoudingClgController:getTryFightStageClgResultAndTips(fnId, dayIndex)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInTime(fnId) then
		result = GameEnum.ResultCode.Error
		tips = "不在开放时间内"
	elseif not self:isInDayIndex(dayIndex) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在开放时间内"
	elseif not self:isEnoughTimes() then
		result = GameEnum.ResultCode.NotEnoughNum
		tips = "剩余次数不足"
	end

	return result, tips
end

function FamilyHoudingClgController:isInDayIndex(dayIndex)
	local curDayIndex = self:getCurDayIndex()

	return curDayIndex == dayIndex
end

function FamilyHoudingClgController:isEnoughTimes()
	return self:getLeftChallengeTimes() > 0
end

function FamilyHoudingClgController:getCurDayIndex()
	return FamilyHoudingClgModel.instance:getCurDayIndex()
end

function FamilyHoudingClgController:getCurBuffId()
	return FamilyHoudingClgModel.instance:getCurBuffId()
end

function FamilyHoudingClgController:getLeftChallengeTimes()
	return FamilyHoudingClgModel.instance:getLeftChallengeTimes()
end

function FamilyHoudingClgController:getMaxChallengeTimes(fhId)
	local maxTimes = 0
	local data = FamilyHoudingClgConfig.instance:getFhPlanTimeData(fhId)

	if data then
		maxTimes = data.remainTimesLimit
	end

	local value = VipModel.instance:getVipPrivilegeParm(VipModel.privilegeType_FamilyHoudingClg)

	maxTimes = maxTimes + value

	return maxTimes
end

function FamilyHoudingClgController:getRankInfoListOfTopN(rankType)
	local list

	if rankType == FhcEnum.RankType_Family then
		list = FamilyHoudingClgModel.instance:getFamilyTopN()
	elseif rankType == FhcEnum.RankType_Persion then
		list = FamilyHoudingClgModel.instance:getPersonTopN()
	end

	return list or {}
end

function FamilyHoudingClgController:getRankInfoListOfFamily()
	return FamilyHoudingClgModel.instance:getRankInfoListOfFamily()
end

function FamilyHoudingClgController:getMyFamilyScoreOfFamily()
	return FamilyHoudingClgModel.instance:getMyFamilyScoreOfFamily()
end

function FamilyHoudingClgController:getMyFamilyRankOfFamily()
	return FamilyHoudingClgModel.instance:getMyFamilyRankOfFamily()
end

function FamilyHoudingClgController:getRankInfoListOfPerson()
	return FamilyHoudingClgModel.instance:getRankInfoListOfPerson()
end

function FamilyHoudingClgController:getMyFamilyScoreOfPerson()
	return FamilyHoudingClgModel.instance:getMyFamilyScoreOfPerson()
end

function FamilyHoudingClgController:getMyFamilyRankOfPerson()
	return FamilyHoudingClgModel.instance:getMyFamilyRankOfPerson()
end

FamilyHoudingClgController.instance = FamilyHoudingClgController.New()

return FamilyHoudingClgController
