-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/controller/PeakTournamentController.lua

module("logic.extensions.peaktournament.controller.PeakTournamentController", package.seeall)

local PeakTournamentController = class("PeakTournamentController", BaseController)

PeakTournamentController.FightType = {
	FightVieo = 3,
	QuaFight = 1,
	EliFight = 2
}

function PeakTournamentController:ctor()
	return
end

function PeakTournamentController:onInit()
	self:onReset()
end

function PeakTournamentController:onReset()
	GlobalDispatcher:addListener("openpeaktournamentview", self.openPeakTournamentViewByNotify, self)
end

function PeakTournamentController:loadPeakTournament()
	self:updateTopFirstRed()
	self:updateQuaRewardFirstRed()
	self:updateDailyOpenRed(true)
end

function PeakTournamentController:sendPM_PeakTournamentGetQualifierInfoReq(actId)
	PeakTournamentAgent.instance:sendPM_PeakTournamentGetQualifierInfoReq(actId)
end

function PeakTournamentController:handlePM_PeakTournamentGetQualifierInfoRes(msg)
	PeakTournamentModel.instance:handlePM_PeakTournamentGetQualifierInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PeakTournamentGetQualifierInfoRes)
end

function PeakTournamentController:sendPM_PeakTournamentQualifierFightReq(actId)
	PeakTournamentAgent.instance:sendPM_PeakTournamentQualifierFightReq(actId)
end

function PeakTournamentController:handlePM_PeakTournamentQualifierFightRes(msg)
	PeakTournamentModel.instance:handlePM_PeakTournamentQualifierFightRes(msg)
	self:handleBattleResultsAsPT(msg.battleResult, nil, self.FightType.QuaFight)
	GlobalDispatcher:dispatch(GlobalNotify.PeakTournamentQualifierFightRes)
end

function PeakTournamentController:sendPM_PeakTournamentQualifierRecordsReq(actId)
	PeakTournamentAgent.instance:sendPM_PeakTournamentQualifierRecordsReq(actId)
end

function PeakTournamentController:handlePM_PeakTournamentQualifierRecordsRes(msg)
	PeakTournamentModel.instance:handlePM_PeakTournamentQualifierRecordsRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PeakTournamentQualifierRecordsRes)
end

function PeakTournamentController:sendPM_PeakTournamentQualifierRankInfoReq(actId, zoneId)
	PeakTournamentAgent.instance:sendPM_PeakTournamentQualifierRankInfoReq(actId, zoneId)
end

function PeakTournamentController:handlePM_PeakTournamentQualifierRankInfoRes(msg)
	PeakTournamentModel.instance:handlePM_PeakTournamentQualifierRankInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PeakTournamentQualifierRankInfoRes)
end

function PeakTournamentController:sendPM_PeakTournamentQualifierTaskInfoReq(actId)
	PeakTournamentAgent.instance:sendPM_PeakTournamentQualifierTaskInfoReq(actId)
end

function PeakTournamentController:handlePM_PeakTournamentQualifierTaskInfoRes(msg)
	PeakTournamentModel.instance:handlePM_PeakTournamentQualifierTaskInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PeakTournamentQualifierTaskInfoRes)
end

function PeakTournamentController:sendPM_PeakTournamentGainQualifierTaskPrizeReq(actId, taskIdList)
	PeakTournamentAgent.instance:sendPM_PeakTournamentGainQualifierTaskPrizeReq(actId, taskIdList)
end

function PeakTournamentController:handlePM_PeakTournamentGainQualifierTaskPrizeRes(msg)
	PeakTournamentModel.instance:handlePM_PeakTournamentGainQualifierTaskPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PeakTournamentGainQualifierTaskPrizeRes)
end

function PeakTournamentController:sendPM_PeakTournamentQualifierVideoReq(battleId)
	PeakTournamentAgent.instance:sendPM_PeakTournamentQualifierVideoReq(battleId)
end

function PeakTournamentController:handlePM_PeakTournamentQualifierVideoRes(msg)
	PeakTournamentModel.instance:handlePM_PeakTournamentQualifierVideoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PeakTournamentQualifierVideoRes)
end

function PeakTournamentController:sendPM_PeakTournamentKnockoutGetParticipationInfoReq(actId)
	PeakTournamentAgent.instance:sendPM_PeakTournamentKnockoutGetParticipationInfoReq(actId)
end

function PeakTournamentController:handlePM_PeakTournamentKnockoutGetParticipationInfoRes(msg)
	PeakTournamentModel.instance:handlePM_PeakTournamentKnockoutGetParticipationInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PeakTournamentKnockoutGetParticipationInfoRes)
	self:popPartInfoWin(msg.actId)
end

function PeakTournamentController:sendPM_PeakTournamentKnockoutGetMyScheduleInfoReq(actId)
	PeakTournamentAgent.instance:sendPM_PeakTournamentKnockoutGetMyScheduleInfoReq(actId)
end

function PeakTournamentController:handlePM_PeakTournamentKnockoutGetMyScheduleInfoRes(msg)
	PeakTournamentModel.instance:handlePM_PeakTournamentKnockoutGetMyScheduleInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PeakTournamentKnockoutGetMyScheduleInfoRes)
end

function PeakTournamentController:sendPM_PeakTournamentKnockoutGetMyBattleRecordsReq(actId)
	PeakTournamentAgent.instance:sendPM_PeakTournamentKnockoutGetMyBattleRecordsReq(actId)
end

function PeakTournamentController:handlePM_PeakTournamentKnockoutGetMyBattleRecordsRes(msg)
	PeakTournamentModel.instance:handlePM_PeakTournamentKnockoutGetMyBattleRecordsRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PeakTournamentKnockoutGetMyBattleRecordsRes, msg)
end

function PeakTournamentController:sendPM_PeakTournamentKnockoutGetBattleVideoReq(battleIds, teamIds, fightType)
	PeakTournamentAgent.instance:sendPM_PeakTournamentKnockoutGetBattleVideoReq(battleIds)

	self._teamIdsInBV = teamIds
	self._fightTypeInBV = fightType
end

function PeakTournamentController:handlePM_PeakTournamentKnockoutGetBattleVideoRes(msg)
	PeakTournamentModel.instance:handlePM_PeakTournamentKnockoutGetBattleVideoRes(msg)
	self:handleBattleResultsAsPT(msg.btlResult, self._teamIdsInBV, self._fightTypeInBV)

	self._teamIdsInBV = nil
	self._fightTypeInBV = nil

	GlobalDispatcher:dispatch(GlobalNotify.PeakTournamentKnockoutGetBattleVideoRes, msg)
end

function PeakTournamentController:sendPM_PeakTournamentSetFormReq(actId, simpleFormList, defenseForm)
	PeakTournamentAgent.instance:sendPM_PeakTournamentSetFormReq(actId, simpleFormList, defenseForm)
end

function PeakTournamentController:handlePM_PeakTournamentSetFormRes(msg)
	PeakTournamentModel.instance:handlePM_PeakTournamentSetFormRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PeakTournamentSetFormRes)
end

function PeakTournamentController:sendPM_PeakTournamentGetFormReq(actId, defenseForm)
	PeakTournamentAgent.instance:sendPM_PeakTournamentGetFormReq(actId, defenseForm)
end

function PeakTournamentController:handlePM_PeakTournamentFormRes(status, msg)
	if status == 0 then
		PeakTournamentModel.instance:handlePM_PeakTournamentFormRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PeakTournamentFormRes, status, msg)
end

function PeakTournamentController:sendPM_PeakTournamentKnockoutGetGuessInfoReq(actId)
	PeakTournamentAgent.instance:sendPM_PeakTournamentKnockoutGetGuessInfoReq(actId)
end

function PeakTournamentController:handlePM_PeakTournamentKnockoutGetGuessInfoRes(msg)
	PeakTournamentModel.instance:handlePM_PeakTournamentKnockoutGetGuessInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PeakTournamentKnockoutGetGuessInfoRes)
end

function PeakTournamentController:sendPM_PeakTournamentKnockoutGuessReq(actId, targetUserId, guessNums)
	targetUserId = checknumber(targetUserId)

	PeakTournamentAgent.instance:sendPM_PeakTournamentKnockoutGuessReq(actId, targetUserId, guessNums)
end

function PeakTournamentController:handlePM_PeakTournamentKnockoutGuessRes(status, msg)
	PeakTournamentModel.instance:handlePM_PeakTournamentKnockoutGuessRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PeakTournamentKnockoutGuessRes)
end

function PeakTournamentController:sendPM_PeakTournamentKnockoutGainGuessCoinReq(actId)
	PeakTournamentAgent.instance:sendPM_PeakTournamentKnockoutGainGuessCoinReq(actId)
end

function PeakTournamentController:handlePM_PeakTournamentKnockoutGainGuessCoinRes(msg)
	PeakTournamentModel.instance:handlePM_PeakTournamentKnockoutGainGuessCoinRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PeakTournamentKnockoutGainGuessCoinRes)
end

function PeakTournamentController:sendPM_PeakTournamentKnockoutGainGuessRecordReq(actId, roundId)
	PeakTournamentAgent.instance:sendPM_PeakTournamentKnockoutGainGuessRecordReq(actId, roundId)
end

function PeakTournamentController:handlePM_PeakTournamentKnockoutGainGuessRecordRes(msg)
	PeakTournamentModel.instance:handlePM_PeakTournamentKnockoutGainGuessRecordRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PeakTournamentKnockoutGainGuessRecordRes)
end

function PeakTournamentController:sendPM_PeakTournamentKnockoutGetGroupStageInfoReq(actId, roundGroupListPool)
	PeakTournamentAgent.instance:sendPM_PeakTournamentKnockoutGetGroupStageInfoReq(actId, roundGroupListPool)
end

function PeakTournamentController:handlePM_PeakTournamentKnockoutGetGroupStageInfoRes(msg)
	PeakTournamentModel.instance:handlePM_PeakTournamentKnockoutGetGroupStageInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PeakTournamentKnockoutGetGroupStageInfoRes)
end

function PeakTournamentController:sendPM_PeakTournamentKnockoutGetTopViewReq(actId)
	PeakTournamentAgent.instance:sendPM_PeakTournamentKnockoutGetTopViewReq(actId)
end

function PeakTournamentController:handlePM_PeakTournamentKnockoutGetTopViewRes(msg)
	PeakTournamentModel.instance:handlePM_PeakTournamentKnockoutGetTopViewRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PeakTournamentKnockoutGetTopViewRes, msg)
end

function PeakTournamentController:sendPM_PeakTournamentKudosReq(actId, isGlobal)
	self._isKudoGlobal = isGlobal

	PeakTournamentAgent.instance:sendPM_PeakTournamentKudosReq(actId, isGlobal)
end

function PeakTournamentController:handlePM_PeakTournamentKudosRes(msg)
	PeakTournamentModel.instance:handlePM_PeakTournamentKudosRes(msg, self._isKudoGlobal)
	GlobalDispatcher:dispatch(GlobalNotify.PeakTournamentKudosRes)
end

function PeakTournamentController:sendPM_PeakTournamentBanPetReq(actId, raceIds)
	PeakTournamentAgent.instance:sendPM_PeakTournamentBanPetReq(actId, raceIds)
end

function PeakTournamentController:handlePM_PeakTournamentBanPetRes(msg)
	PeakTournamentModel.instance:handlePM_PeakTournamentBanPetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PeakTournamentBanPetRes)
end

function PeakTournamentController:sendPM_PeakTournamentBanPetInfoReq(actId)
	PeakTournamentAgent.instance:sendPM_PeakTournamentBanPetInfoReq(actId)
end

function PeakTournamentController:handlePM_PeakTournamentBanPetInfoRes(msg)
	PeakTournamentModel.instance:handlePM_PeakTournamentBanPetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PeakTournamentBanPetInfoRes)
end

function PeakTournamentController:openPeakTournamentViewByNotify(params)
	self:openPeakTournamentView((params or nil) and checknumber(params[1]))
end

function PeakTournamentController:openPeakTournamentView(ptStep)
	local activityId = PeakTournamentController.instance:getCurActivityId()

	if activityId == 0 then
		FloatWordMgr.instance:show("不在巅峰赛日期内")

		return
	end

	if ptStep == 0 then
		for _, step in pairs(GameEnum.PeakTournamentStep) do
			if self:isInTimePeriodAsPT(activityId, step) then
				ptStep = step
			end
		end
	end

	if ptStep == 0 then
		FloatWordMgr.instance:show("不在巅峰赛日期内")

		return
	end

	local data = PeakTournamentConfig.instance:getPtBaseData(activityId)
	local jumpStr = ""

	if ptStep == GameEnum.PeakTournamentStep.Qualifier then
		jumpStr = data.qualifierJumpStr
	elseif ptStep == GameEnum.PeakTournamentStep.Eliminator then
		jumpStr = data.eliminatorJumpStr
	elseif ptStep == GameEnum.PeakTournamentStep.TopExhibition then
		jumpStr = data.topExhibitionJumpStr
	end

	if string.nilorempty(jumpStr) then
		printError(string.format("错误,对应跳转配置为空,无法进行跳转( d巅峰赛.xlsx | export_基础配置 | activityId=%s | step=%s )", activityId, ptStep))
	else
		GotoMgr.gotoByString(jumpStr)
	end
end

function PeakTournamentController:getCurActivityType()
	return GameEnum.ActivityType.PeakTournament
end

function PeakTournamentController:getCurActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getCurActivityType())
end

function PeakTournamentController:getWhatSeason(activityId)
	local activityId = activityId or self:getCurActivityId()
	local activityType = self:getCurActivityType()

	return checkint(activityId % (activityType * 1000))
end

function PeakTournamentController:isInTimePeriodAsPT(activityId, step)
	activityId = checknumber(activityId)

	if activityId == 0 then
		return false
	end

	return self:getTimePeriodAsPT(activityId, step) == GameUtil.inTimePeriod
end

function PeakTournamentController:getTimePeriodAsPT(activityId, step)
	local startTime, endTime = self:getStartAndEndTimeStrAsPT(activityId, step)

	return GameUtil.getTimePeriod(startTime, endTime)
end

function PeakTournamentController:getStartAndEndTimeStrAsPT(activityId, step)
	local data = PeakTournamentConfig.instance:getPtBaseData(activityId)
	local startTime, endTime = "", ""

	if step == GameEnum.PeakTournamentStep.Qualifier then
		timeLimit = data.qualifierTimeLimit

		local quaArray = string.split(data.qualifierTimeLimit, "#")
		local eliArray = string.split(data.eliminatorTimeLimit, "#")

		endTime = eliArray[1]
		startTime = quaArray[1]
	elseif step == GameEnum.PeakTournamentStep.Eliminator then
		local array = string.split(data.eliminatorTimeLimit, "#")

		endTime = array[2]
		startTime = array[1]
	elseif step == GameEnum.PeakTournamentStep.TopExhibition then
		local array = string.split(data.topExhibitionTimeLimit, "#")

		endTime = array[2]
		startTime = array[1]
	end

	return startTime, endTime
end

function PeakTournamentController:getTimePeriodAsPTBanPet(activityId)
	local startTime, endTime = self:getStartAndEndTimeStrAsPTBanPet(activityId)

	return GameUtil.getTimePeriod(startTime, endTime)
end

function PeakTournamentController:getStartAndEndTimeStrAsPTBanPet(activityId)
	local data = PeakTournamentConfig.instance:getPtBaseData(activityId)
	local startTime, endTime = "", ""
	local array = string.split(data.banPetTimeLimit, "#")

	return array[1], array[2]
end

function PeakTournamentController:isTheSeasonHaveBanPet(activityId, step)
	local result = false
	local baseData = PeakTournamentConfig.instance:getPtBaseData(activityId)

	if baseData then
		result = self:isTheSeasonHaveBanPetVoteView(baseData.lastActId)
	end

	if result == true then
		local data = PeakTournamentConfig.instance:getPtBanPetData(activityId)

		result = step == GameEnum.PeakTournamentStep.Qualifier and data.qualifyUseBanPet or data.knockoutUseBanPet
	end

	return result
end

function PeakTournamentController:isTheSeasonHaveBanPetVoteView(activityId)
	local data = PeakTournamentConfig.instance:getPtBanPetData(activityId)

	return data ~= nil
end

function PeakTournamentController:getMyZoneId(activityId)
	local zoneData = PeakTournamentConfig.instance:getPtZoneDataByAreaId(activityId, RoleModel.instance:getAreaId())

	return (zoneData or nil) and (zoneData.zoneId or nil)
end

function PeakTournamentController:getTotalRoundCount(activityId)
	local activityId = activityId or self:getCurActivityId()
	local cfg = PeakTournamentConfig.instance:getPtEliRoundCfgById(activityId)

	return (cfg or nil) and (#cfg or 0)
end

function PeakTournamentController:getTotalRoundNotSpaceKnockoutCount(activityId)
	local activityId = activityId or self:getCurActivityId()
	local cfg = PeakTournamentConfig.instance:getPtEliRoundCfgById(activityId)
	local count = 0

	for i, v in ipairs(cfg or {}) do
		if v.spaceKnockout == false then
			count = count + 1
		end
	end

	return cfg and count or 0
end

function PeakTournamentController:getGoldBarList(activityId)
	local list = {}
	local baseData = PeakTournamentConfig.instance:getPtBaseData(activityId)

	if not string.nilorempty(baseData.goldStr) then
		local itemsStrArray = string.split(baseData.goldStr, "#")

		for _, itemStr in ipairs(itemsStrArray) do
			t = {
				showAdd = true,
				id = itemStr
			}

			table.insert(list, t)
		end
	end

	return list
end

function PeakTournamentController:getFormatUserName(userName, areaId)
	areaId = areaId and string.format("%.03d", areaId)

	return string.format("S%s-%s", areaId or "?", userName or "???")
end

function PeakTournamentController:updateTopFirstRed()
	local activityId = self:getCurActivityId()

	if activityId == 0 then
		return
	end

	if not self:isInTimePeriodAsPT(activityId, GameEnum.PeakTournamentStep.TopExhibition) then
		return
	end

	local key = self:getTopOnceRedKey(activityId)
	local redId = PeakTournamentConfig.instance:getPtCommonValue("PT_RED_TOP_FIRST")

	self:regOnceRedAsPT(key, redId)
end

function PeakTournamentController:getTopOnceRedKey(activityId)
	return "OnceRedTop" .. activityId
end

function PeakTournamentController:updateQuaRewardFirstRed()
	local activityId = self:getCurActivityId()

	if activityId == 0 then
		return
	end

	if not self:isInTimePeriodAsPT(activityId, GameEnum.PeakTournamentStep.Qualifier) then
		return
	end

	local key = self:getQuaRewardFirstRedKey(activityId)
	local redId = PeakTournamentConfig.instance:getPtCommonValue("PT_RED_QUA_REWARD_ONCE")

	self:regOnceRedAsPT(key, redId)
end

function PeakTournamentController:getQuaRewardFirstRedKey(activityId)
	return "QuaRewardFirst" .. activityId
end

function PeakTournamentController:regOnceRedAsPT(key, redId)
	if string.nilorempty(redId) then
		return
	end

	local function handle(value)
		local funcId = PeakTournamentConfig.instance:getPtCommonValue("PT_FUNCID")

		funcId = checknumber(funcId)

		if funcId > 0 then
			RedPointController.instance:setRedPointInfo(redId, checknumber(value) == 0, true, nil, nil, {
				funcId
			})
		else
			RedPointController.instance:setRedPointInfo(redId, checknumber(value) == 0)
		end
	end

	GameUtil.getUserData(key, handle)
end

function PeakTournamentController:saveOnceRedAsPT(key, redId, isHasActivated)
	if string.nilorempty(redId) then
		return
	end

	local value = isHasActivated and 1 or 0

	GameUtil.saveUserData(key, value)
	self:regOnceRedAsPT(key, redId)
end

function PeakTournamentController:updateDailyOpenRed(isTryReg)
	local activityId = self:getCurActivityId()

	if activityId == 0 then
		return
	end

	local isInPTTime = true
	local isInEliTime = true

	if not self:isInTimePeriodAsPT(activityId, GameEnum.PeakTournamentStep.Eliminator) then
		isInPTTime = false
	end

	local str = PeakTournamentConfig.instance:getPtCommonValue("PT_RED_DAILY_OPEN_TIME")
	local startTime, endTime

	if not string.nilorempty(str) then
		local arr = string.split(str, "#")

		endTime = arr[2]
		startTime = arr[1]
	end

	if GameUtil.getTimePeriod(startTime, endTime) ~= GameUtil.inTimePeriod then
		isInEliTime = false
	end

	local key = self:getDailyEliOpenRedKey(activityId)
	local redId = PeakTournamentConfig.instance:getPtCommonValue("PT_RED_DAILY_OPEN")

	if isTryReg then
		if isInPTTime then
			local startStamp = startTime and GameUtil.string2time(startTime)
			local endStamp = endTime and GameUtil.string2time(endTime)

			self:regDailyRedAsPT(key, redId, startStamp, endStamp)
		end
	elseif isInPTTime then
		self:saveDailyRedAsPT(key, redId, true)
	end
end

function PeakTournamentController:getDailyEliOpenRedKey(activityId)
	return "dailyeliopenred" .. activityId
end

function PeakTournamentController:regDailyRedAsPT(key, redId, startStamp, endStamp)
	if string.nilorempty(redId) then
		return
	end

	local function handle(value)
		local funcId = PeakTournamentConfig.instance:getPtCommonValue("PT_FUNCID")

		funcId = checknumber(funcId)

		if funcId > 0 then
			RedPointController.instance:setRedPointInfo(redId, checknumber(value) == 0, true, startStamp, endStamp, {
				funcId
			})
		else
			RedPointController.instance:setRedPointInfo(redId, checknumber(value) == 0, true, startStamp, endStamp)
		end
	end

	GameUtil.getUserDayData(key, handle)
end

function PeakTournamentController:saveDailyRedAsPT(key, redId, isHasActivated)
	if string.nilorempty(redId) then
		return
	end

	local value = isHasActivated and 1 or 0

	GameUtil.saveUserDayData(key, value)
	self:regDailyRedAsPT(key, redId)
end

function PeakTournamentController:enterFormationAsPT(activityId, isDefense)
	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentFormRes, self.handleEnterFormationAsPT, self)
	self:sendPM_PeakTournamentGetFormReq(activityId, isDefense)
end

function PeakTournamentController:handleEnterFormationAsPT(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentFormRes, self.handleEnterFormationAsPT, self)

	if status ~= 0 then
		return
	end

	if msg.actId > 0 then
		local customFmtMo = PeakTournamentModel.instance:getPtFmtCustomFmtMo()

		customFmtMo:updateCfg(msg.actId)
		CustomFmtController.instance:showMissionFormationView(customFmtMo)
	end
end

function PeakTournamentController:isAllFmtNotEmptyByFmtMos(formationMoList)
	local fmtPetNumPool = {}

	for formIdx, formationMo in ipairs(formationMoList) do
		fmtPetNumPool[formIdx] = FormationFacade.instance:curFormationPetNum(formationMo)
	end

	return self:isAllFmtNotEmpty(fmtPetNumPool)
end

function PeakTournamentController:isAllFmtNotEmpty(fmtPetNumPool)
	local isAllFmtNotEmpty = true

	for _, petNum in pairs(fmtPetNumPool) do
		if petNum == 0 then
			isAllFmtNotEmpty = false

			break
		end
	end

	return isAllFmtNotEmpty
end

function PeakTournamentController:enterBattleAsPT(activityId)
	self:sendPM_PeakTournamentGetFormReq(activityId)
	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentFormRes, self.handleEnterBattleAsPT, self)
end

function PeakTournamentController:handleEnterBattleAsPT(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentFormRes, self.handleEnterBattleAsPT, self)

	if status ~= 0 then
		return
	end

	if msg.actId > 0 then
		local customFmtMo = PeakTournamentModel.instance:getPtBtlCustomFmtMo()

		customFmtMo:updateCfg(msg.actId)
		CustomFmtController.instance:showMissionView(customFmtMo)
	end
end

function PeakTournamentController:handleBattleResultsAsPT(battleResultList, teamIdList, fightType)
	self._curBtlResultIdx = 1
	self._btlResultList = battleResultList

	local btlResult = self._btlResultList[self._curBtlResultIdx]

	self._btlTeamIdList = teamIdList

	local teamId = self:getTeamIdByIdx(self._curBtlResultIdx)

	self._btlFightType = fightType

	if btlResult == nil then
		FloatWordMgr.instance:show("后端返回战斗结果为空")
	else
		BattleFacade.instance:startPeakTournamentFight(self._btlFightType, #self._btlResultList > 1)
		BattleController.instance:viewUserFightMonsterBtlResult(btlResult, false)

		if teamId >= 0 then
			BattleModel.instance:setLeftTeamId(teamId)
		end

		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.PeakTournamentFight)
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
	end
end

function PeakTournamentController:tryNextBattle()
	local idx = self._curBtlResultIdx + 1
	local btlResult = self._btlResultList[idx]

	if btlResult == nil then
		return false
	end

	self._curBtlResultIdx = idx

	local teamId = self:getTeamIdByIdx(self._curBtlResultIdx)

	BattleFacade.instance:startPeakTournamentFight(self._btlFightType, #self._btlResultList > 1)
	BattleController.instance:onBattleContinue(btlResult)

	if teamId >= 0 then
		BattleModel.instance:setLeftTeamId(teamId)
	end

	return true
end

function PeakTournamentController:getCurBattleResultIdx()
	return self._curBtlResultIdx - 1
end

function PeakTournamentController:getTeamIdByIdx(idx)
	return (self._btlTeamIdList or nil) and (self._btlTeamIdList[idx] or -1)
end

function PeakTournamentController:openBattleResultViewAsPT()
	local twoFormMoList = {}
	local twoPlayerInfo = {}

	for idx = 1, self._curBtlResultIdx do
		local btlResult = self._btlResultList[idx]
		local teamId = self:getTeamIdByIdx(self._curBtlResultIdx)
		local twoPlayerView = {}

		for i = 1, 2 do
			local teamId = i - 1

			for _, v in pairs(btlResult.originalStates.teams) do
				if v.teamId == teamId then
					twoPlayerView[i] = v.playerView
				end
			end
		end

		for i = 1, 2 do
			local playerView = twoPlayerView[i]

			twoPlayerInfo[i] = {}
			twoPlayerInfo[i].headInfo = {
				userId = playerView.id,
				userName = playerView.name,
				playerLv = playerView.playerLv,
				headIconId = playerView.headIcon,
				headFrameId = playerView.headFrame
			}
		end

		local twoPetLists = {}

		for i = 1, 2 do
			twoPetLists[i] = {}

			for _, v in ipairs(twoPlayerView[i].characterViews) do
				local t = {}

				t.skinId = v.curFaceId
				t.raceId = v.raceId
				t.level = v.lv
				t.awakenLv = v.awakenLv
				t.petMo = FightingPowerPetMo.createPetByLevel(t.raceId, t.level, t.awakenLv, t.skinId)
				t.petMo.hideZdl = true

				table.insert(twoPetLists[i], t)
			end
		end

		local twoFormMo = {}

		twoFormMo.formId = idx
		twoFormMo.isChallengerWin = btlResult.activityWinner == 0

		if teamId == 1 then
			twoFormMo.isChallengerWin = not twoFormMo.isChallengerWin
		end

		twoFormMo.challengeZdl = twoPlayerView[1].fightPower
		twoFormMo.beChallengeZdl = twoPlayerView[2].fightPower
		twoFormMo.challengePets = twoPetLists[1]
		twoFormMo.beChallengePets = twoPetLists[2]

		table.insert(twoFormMoList, twoFormMo)
	end

	UIStateManager.instance:open(ViewName.PTBattleSettlementView, twoPlayerInfo[1], twoPlayerInfo[2], twoFormMoList)
end

function PeakTournamentController:isCanStartChallengeAsQua(activityId)
	local result, tips = self:getStartFightResultAndTipsAsQua(activityId)

	return result == GameEnum.ResultCode.Success
end

function PeakTournamentController:getStartFightResultAndTipsAsQua(activityId)
	local tips = ""
	local result = GameEnum.ResultCode.Success

	if not self:isEnoughFightTImesAsQua(activityId) then
		result = GameEnum.ResultCode.NotEnoughTimes
		tips = lang("次数不足")
	elseif not self:isInChallengeOpenTimeAsQua(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = lang("不在开放时间内")
	end

	return result, tips
end

function PeakTournamentController:isEnoughFightTImesAsQua(activityId)
	return self:getRemainDailyFightTimesAsQua(activityId) > 0
end

function PeakTournamentController:getRemainDailyFightTimesAsQua(activityId)
	local maxTimes = self:getMaxDailyFightTimesAsQua(activityId)
	local curTimes = PeakTournamentModel.instance:getDailyFightTimesAsQua()

	return maxTimes - curTimes
end

function PeakTournamentController:getMaxDailyFightTimesAsQua(activityId)
	local cfg = PeakTournamentConfig.instance:getPtQuaMatchCfgById(activityId)

	return (cfg or nil) and (#cfg or 0)
end

function PeakTournamentController:isInChallengeOpenTimeAsQua(activityId)
	local baseData = PeakTournamentConfig.instance:getPtBaseData(activityId)
	local array = string.split(baseData.qualifierTimeLimit, "#")

	return GameUtil.getTimePeriod(array[1], array[2]) == GameUtil.inTimePeriod
end

function PeakTournamentController:isCanGetPrizeTaskAsQua(activityId, taskId)
	return not self:isHasGainPrizeTaskAsQua(taskId) and self:isEnoughGetPrizeTaskAsQua(activityId, taskId)
end

function PeakTournamentController:isEnoughGetPrizeTaskAsQua(activityId, taskId)
	local data = PeakTournamentConfig.instance:getPtQuaTaskDataById(activityId, taskId)
	local curProgress = PeakTournamentModel.instance:getTaskCurProgressAsQua(taskId)

	return curProgress >= data.maxProgress
end

function PeakTournamentController:isHasGainPrizeTaskAsQua(taskId)
	return PeakTournamentModel.instance:isHasGainPrizeTaskAsQua(taskId)
end

function PeakTournamentController:popPartInfoWin(activityId)
	activityId = checknumber(activityId)

	if activityId == 0 then
		printError("活动id为零,有误")

		return
	end

	if self:_isHasPopWin(activityId) then
		return
	end

	local tipsContent = self:getKnockoutTips(activityId)

	local function okFunc()
		return
	end

	if not string.nilorempty(tipsContent) then
		TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定")
		self:_savePopWinRecord(activityId, true)
	end
end

function PeakTournamentController:getKnockoutTips(activityId)
	local tipsContent = ""

	if not PeakTournamentModel.instance:isParticipateAsPartInfo() then
		tipsContent = lang("很遗憾，您止步于预选赛")
	else
		local isKnockout = PeakTournamentModel.instance:isKnockoutAsPartInfo()

		if isKnockout ~= nil then
			local roundId = PeakTournamentModel.instance:getPlayerOutRoundIdAsPartInfo()
			local rank = PeakTournamentModel.instance:getPlayerRankAsPartInfo()

			if roundId > 0 then
				local roundData = PeakTournamentConfig.instance:getPtEliRoundDataById(activityId, roundId)

				if roundData.spaceKnockout == true then
					if rank <= 4 then
						if rank == 1 then
							tipsContent = lang("恭喜您，获得本届巅峰赛冠军！")
						elseif rank > 1 then
							tipsContent = langPara("很遗憾，您在本次巅峰赛止步于第%s名", rank)
						end
					else
						tipsContent = langPara("很遗憾，您在本次巅峰赛止步于%s", roundData.processDesc)
					end
				elseif rank <= 4 then
					if rank == 1 then
						tipsContent = lang("恭喜您，获得本届巅峰赛冠军！")
					elseif rank > 1 then
						tipsContent = langPara("很遗憾，您在本次巅峰赛止步于第%s名，请再接再厉", rank)
					end
				else
					tipsContent = langPara("很遗憾，您在本次巅峰赛止步于%s，请再接再厉", roundData.processDesc)
				end
			end
		end
	end

	return tipsContent
end

function PeakTournamentController:_isHasPopWin(activityId)
	local key = self:_getPopWinKey(activityId)

	return GameUtil.getUserData(key)
end

function PeakTournamentController:_savePopWinRecord(activityId, isPop)
	local key = self:_getPopWinKey(activityId)

	GameUtil.saveUserData(key, isPop and 1 or 0)
end

function PeakTournamentController:_getPopWinKey(activityId)
	return "PT" .. "PopWin" .. activityId
end

function PeakTournamentController:getMyVoteCount()
	local matStr = PeakTournamentConfig.instance:getVoteMate()
	local matType, matId, matNum = MaterialMgr.getMatParams(matStr)

	return Mathf.Max(MaterialModel.instance:getMaterialsNumber(matType, matId), 0)
end

function PeakTournamentController:getMaxVoteScoreLimit(activityId, eliRoundId)
	local data = PeakTournamentConfig.instance:getPtEliVotePlateDataById(activityId, eliRoundId)

	return data.maxVoteScore
end

function PeakTournamentController:getHasVoteCount()
	return PeakTournamentModel.instance:getHasVoteCount()
end

function PeakTournamentController:getRemainVoteScoreLimit(activityId, eliRoundId)
	local hasVoteCount = self:getHasVoteCount()
	local MaxVoteScoreLimit = self:getMaxVoteScoreLimit(activityId, eliRoundId)

	return Mathf.Max(MaxVoteScoreLimit - hasVoteCount, 0)
end

function PeakTournamentController:getCanVoteCount(activityId, eliRoundId)
	local remainVoteScoreLimit = self:getRemainVoteScoreLimit(activityId, eliRoundId)
	local myVoteCount = self:getMyVoteCount()

	return Mathf.Min(remainVoteScoreLimit, myVoteCount)
end

function PeakTournamentController:isExceedVoteCountLimit(activityId, eliRoundId)
	return self:getRemainVoteScoreLimit(activityId, eliRoundId) <= 0
end

function PeakTournamentController:isCanVoteTheUser(stageIndex, targetUserId)
	local isHasGuessTheStage = PeakTournamentModel.instance:isHasGuessTheStage(stageIndex)
	local isHasGuessTheUser = PeakTournamentModel.instance:isHasGuessTheUser(targetUserId)
	local isCan = false

	if not isHasGuessTheStage then
		isCan = true
	elseif isHasGuessTheStage and isHasGuessTheUser then
		isCan = true
	end

	return isCan
end

function PeakTournamentController:eliminatorMgrOnEnter(activityId)
	activityId = checknumber(activityId)

	if activityId == 0 then
		printError("活动id为零,这是不允许的呢")

		return
	end

	if self._eliminatorMgr == nil then
		self._eliminatorMgr = EliminatorMgr.New()
	end

	self._eliminatorMgr:onEnter(activityId)

	return self._eliminatorMgr
end

function PeakTournamentController:eliminatorMgrOnExit()
	if self._eliminatorMgr then
		self._eliminatorMgr:onExit()
	end
end

function PeakTournamentController:eliminatorMgrOnDestory()
	if self._eliminatorMgr then
		self._eliminatorMgr:onDestroy()

		self._eliminatorMgr = nil
	end
end

function PeakTournamentController:getEliminatorMgr()
	return self._eliminatorMgr
end

PeakTournamentController.instance = PeakTournamentController.New()

return PeakTournamentController
