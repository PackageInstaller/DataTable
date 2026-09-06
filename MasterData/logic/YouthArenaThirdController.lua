-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/controller/YouthArenaThirdController.lua

module("logic.extensions.youtharenathird.controller.YouthArenaThirdController", package.seeall)

local YouthArenaThirdController = class("YouthArenaThirdController", BaseController)
local USE_SYSTEM_PROPERTY_KEY = "YouthArenaThirdUseSystemProperty_%s"
local DEFENSE_NOT_READY_TIP = "尚未布阵，先布置好精灵再来挑战吧"
local DEFENSE_STEP_CHANGED_TIP = "当前阶段已变化，无法保存守阵"
local MATCH_SETTLEMENT_TIP = "赛事即将结算，当前阶段已停止挑战"
local MATCH_CLOSED_TIME_TIP = "不在挑战时间内"
local SCORE_MATCH_NO_SCORE_TIP = "当前积分为0，无法继续挑战"
local CHAMPION_ROUND_TYPE_MAP = {
	[YouthArenaThirdEnum.RoundType.CommonKnockout] = true,
	[YouthArenaThirdEnum.RoundType.Top16Knockout] = true,
	[YouthArenaThirdEnum.RoundType.Top8ScoreMatch1v1] = true,
	[YouthArenaThirdEnum.RoundType.Top8ScoreMatch3v3] = true
}

local function _hasPetInSimpleForm(simpleForm)
	for _, petId in ipairs((simpleForm or nil) and (simpleForm.pos or {})) do
		if checknumber(petId) > 0 then
			return true
		end
	end

	return false
end

local function _isDefenseReady(mode, formList)
	local formCount = mode == YouthArenaThirdEnum.BattleMode.Three and 3 or 1

	for i = 1, formCount do
		local formInfo = formList and formList[i]

		if formInfo == nil or not _hasPetInSimpleForm(formInfo.form) then
			return false
		end
	end

	return true
end

function YouthArenaThirdController:onInit()
	GlobalDispatcher:addListener("openyoutharenathirdview", self._openYouthArenaThirdViewByNotify, self)
	self:onReset()
end

function YouthArenaThirdController:onReset()
	removetimer(self._ensureStepChangeGetInfo, self)

	self._ensureGetInfoParam = nil
	self._stepChangeGetInfoKey = nil
	self._pendingDefenseOpenParam = nil
	self._pendingDefenseSaveParam = nil
	self._pendingVideoLeftUserId = nil

	if YouthArenaThirdReportBaseView and YouthArenaThirdReportBaseView.resetReportStateCache then
		YouthArenaThirdReportBaseView.resetReportStateCache()
	end

	YouthArenaThirdModel.instance:clearAllDefenseReadyStates()
end

function YouthArenaThirdController:sendPM_YoungArenaKingS3GetInfoReq(activityId)
	YouthArenaThirdAgent.instance:sendPM_YoungArenaKingS3GetInfoReq(activityId)
end

function YouthArenaThirdController:requestGetInfoForStepChange(activityId, stepId)
	activityId = checknumber(activityId)
	stepId = checknumber(stepId)

	if activityId <= 0 or stepId <= 0 or activityId ~= self:getActivityId() then
		return false
	end

	local mo = self:getSubMo(activityId)

	if mo == nil or mo:getCurStepId() ~= stepId then
		return false
	end

	local requestKey = string.format("%s_%s", activityId, stepId)

	if self._stepChangeGetInfoKey == requestKey then
		return false
	end

	self._stepChangeGetInfoKey = requestKey

	self:sendPM_YoungArenaKingS3GetInfoReq(activityId)

	return true
end

function YouthArenaThirdController:handlePM_YoungArenaKingS3GetInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)
	local oldStepId = mo:getCurStepId()

	mo:handlePM_YoungArenaKingS3GetInfoRes(msg)

	if oldStepId > 0 and oldStepId ~= mo:getCurStepId() then
		self:_invalidateDefenseReadyState(msg.activityId)
	end

	self:_refreshMyScheduleRedPoint(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_YoungArenaKingS3GetInfoRes)
end

function YouthArenaThirdController:handlePM_YoungArenaKingS3NotifyStepChangeRes(msg)
	local mo = self:getSubMo(msg.activityId)
	local oldStepId = mo:getCurStepId()
	local oldStepCfg = YouthArenaThirdConfig.instance:getStepData(msg.activityId, oldStepId)

	mo:handlePM_YoungArenaKingS3NotifyStepChangeRes(msg)

	local newStepId = mo:getCurStepId()
	local newStepCfg = YouthArenaThirdConfig.instance:getStepData(msg.activityId, newStepId)
	local shouldPull = self:_shouldPullMyScheduleInfo(msg.activityId, oldStepCfg, newStepCfg)

	removetimer(self._ensureStepChangeGetInfo, self)

	self._ensureGetInfoParam = nil

	local newRequestKey = string.format("%s_%s", checknumber(msg.activityId), newStepId)

	if self._stepChangeGetInfoKey ~= newRequestKey then
		self._stepChangeGetInfoKey = nil
	end

	self:_invalidateDefenseReadyState(msg.activityId)
	self:_refreshMyScheduleRedPoint(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_YoungArenaKingS3NotifyStepChangeRes, msg.activityId, newStepId)

	if shouldPull then
		self._ensureGetInfoParam = {
			activityId = checknumber(msg.activityId),
			stepId = newStepId
		}

		settimer(1, self._ensureStepChangeGetInfo, self, false)
	end
end

function YouthArenaThirdController:sendPM_YoungArenaKingS3GetVideoReq(battleIds, leftUserId)
	if not battleIds or #battleIds <= 0 then
		self._pendingVideoLeftUserId = nil

		FloatWordMgr.instance:show("暂无回放")

		return
	end

	self._pendingVideoLeftUserId = checknumber(leftUserId)

	YouthArenaThirdAgent.instance:sendPM_YoungArenaKingS3GetVideoReq(battleIds)
end

function YouthArenaThirdController:handlePM_YoungArenaKingS3GetVideoRes(status, msg)
	local leftUserId = checknumber(self._pendingVideoLeftUserId)

	self._pendingVideoLeftUserId = nil

	if status ~= 0 then
		return
	end

	local btlResults = msg and msg.btlResults

	if not btlResults or btlResults[1] == nil then
		FloatWordMgr.instance:show("回放数据异常")

		return
	end

	local battleResult = btlResults[1]

	if battleResult.originalStates then
		if not battleResult.originalStates.teams then
			local teams = {}
			local teamId = GameEnum.BattleTeam.Left
			local hasLeftTeam = false

			for _, v in ipairs(teams) do
				if leftUserId > 0 then
					if leftUserId == checknumber(v.playerView and v.playerView.id) then
						teamId = v.teamId
						hasLeftTeam = true

						break
					end
				end
			end

			if not hasLeftTeam then
				printError(string.format("少年竞技王S3录像左方玩家缺失( leftUserId=%s )", leftUserId))
			end

			BattleModel.instance:setLeftTeamId(teamId)
			self:_saveStackAndCloseReportViews()
			BattleController.instance:viewUserFightMonsterBtlResultWithList(btlResults)
		end
	end
end

function YouthArenaThirdController:_saveStackAndCloseReportViews()
	UIJumper.instance:saveCurStack()
	UIStateManager.instance:popByName(ViewName.YouthArenaThirdQualifierReportView)
	UIStateManager.instance:popByName(ViewName.YouthArenaThirdChampionMyReportView)
	UIStateManager.instance:popByName(ViewName.YouthArenaThirdChampionScheduleReportView)
end

function YouthArenaThirdController:sendPM_YoungArenaKingS3GetDefenseForamtionReq(isFun, mode)
	YouthArenaThirdAgent.instance:sendPM_YoungArenaKingS3GetDefenseForamtionReq(isFun, mode)
end

function YouthArenaThirdController:handlePM_YoungArenaKingS3GetDefenseForamtionRes(status, msg)
	local param = self._pendingDefenseOpenParam

	if status ~= 0 then
		self._pendingDefenseOpenParam = nil

		return
	end

	if param == nil then
		return
	end

	if msg == nil or param.isFun ~= checkbool(msg.isFun) or param.mode ~= checknumber(msg.mode) then
		self._pendingDefenseOpenParam = nil

		return
	end

	self._pendingDefenseOpenParam = nil

	if param.invalidated then
		return
	end

	if param.reason == "fight" and not self:checkMatchChallengeAvailable(param.activityId, param.stepId, param.mode, true) then
		return
	end

	local isReady = _isDefenseReady(param.mode, msg.formList)

	YouthArenaThirdModel.instance:setDefenseReadyState(param.activityId, param.isFun, param.mode, isReady)

	if param.reason == "fight" then
		if not isReady then
			self:_showDefenseNotReadyTip(param.activityId, param.isFun, param.mode)

			return
		end

		self:_openMatchAttackFormationView(param.activityId, param.stepId, param.mode)

		return
	end

	if param.reason == "switch" and param.fmtMo then
		param.fmtMo:applyModeData(param.mode, msg.formList)
		param.fmtMo:switchMode(param.mode)

		return
	end

	local fmtMo = YouthArenaThirdModel.instance:getDefenseFmtMo(param.activityId)

	fmtMo:initParams(param.activityId, param.isFun, param.mode, param.stepId, msg.formList)
	UIStateManager.instance:push(ViewName.YouthArenaThirdDefenseFormationView, fmtMo)
end

function YouthArenaThirdController:sendPM_YoungArenaKingS3SetDefenseForamtionReq(isFun, mode, formList, stepId)
	YouthArenaThirdAgent.instance:sendPM_YoungArenaKingS3SetDefenseForamtionReq(isFun, mode, formList, stepId)
end

function YouthArenaThirdController:checkDefenseFormationSaveAvailable(fmtMo, showTips)
	local isAvailable = fmtMo ~= nil

	if isAvailable then
		local activityId = checknumber(fmtMo:getActivityId())
		local stepId = checknumber(fmtMo:getStepId())
		local isFun = fmtMo:getIsFun()
		local subMo = activityId > 0 and self:getSubMo(activityId) or nil

		isAvailable = activityId > 0 and activityId == self:getActivityId() and ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) and stepId > 0 and subMo ~= nil and subMo:getCurStepId() == stepId

		if isAvailable and not isFun then
			local stepCfg = YouthArenaThirdConfig.instance:getStepData(activityId, stepId)

			isAvailable = stepCfg ~= nil and checkbool(stepCfg.canSetForm)
		end

		if isAvailable and not isFun then
			local nextStepCfg = YouthArenaThirdConfig.instance:getStepData(activityId, stepId + 1)

			if nextStepCfg and not string.nilorempty(nextStepCfg.startTime) then
				local nextStartStamp = GameUtil.string2time(nextStepCfg.startTime)

				isAvailable = nextStartStamp > 0 and nextStartStamp > ServerTime.now()
			end
		end
	end

	if not isAvailable and showTips ~= false then
		FloatWordMgr.instance:show(DEFENSE_STEP_CHANGED_TIP)
		UIStateManager.instance:popByName(ViewName.YouthArenaThirdDefenseFormationView)
	end

	return isAvailable
end

function YouthArenaThirdController:saveDefenseFormation(fmtMo, onSaved)
	if fmtMo == nil or self._pendingDefenseSaveParam ~= nil then
		return false
	end

	if not self:checkDefenseFormationSaveAvailable(fmtMo, true) then
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

		return false
	end

	local mode = fmtMo:getMode()

	self._pendingDefenseSaveParam = {
		fmtMo = fmtMo,
		mode = mode,
		onSaved = onSaved
	}

	self:sendPM_YoungArenaKingS3SetDefenseForamtionReq(fmtMo:getIsFun(), mode, fmtMo:getCurModeFormList(), fmtMo:getStepId())

	return true
end

function YouthArenaThirdController:handlePM_YoungArenaKingS3SetDefenseForamtionRes(status, msg)
	local param = self._pendingDefenseSaveParam

	self._pendingDefenseSaveParam = nil

	if status ~= 0 then
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)

		if param and param.fmtMo then
			self:checkDefenseFormationSaveAvailable(param.fmtMo, true)
		end

		return
	end

	if param and param.fmtMo then
		param.fmtMo:markModeSaved(param.mode)
		YouthArenaThirdModel.instance:setDefenseReadyState(param.fmtMo:getActivityId(), param.fmtMo:getIsFun(), param.mode, true)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_YoungArenaKingS3SetDefenseForamtionRes, msg)
	FloatWordMgr.instance:show("保存成功")

	if param and param.fmtMo and self:checkDefenseFormationSaveAvailable(param.fmtMo, true) and param.onSaved then
		param.onSaved()
	end
end

function YouthArenaThirdController:sendPM_YoungArenaKingS3GetQualifierInfoReq(activityId, stepId, mode)
	YouthArenaThirdAgent.instance:sendPM_YoungArenaKingS3GetQualifierInfoReq(activityId, stepId, mode)
end

function YouthArenaThirdController:handlePM_YoungArenaKingS3GetQualifierInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_YoungArenaKingS3GetQualifierInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_YoungArenaKingS3GetQualifierInfoRes, msg.activityId, msg.stepId, msg.mode)
end

function YouthArenaThirdController:sendPM_YoungArenaKingS3QualifierGetNewOpponentReq(activityId, stepId, mode)
	YouthArenaThirdAgent.instance:sendPM_YoungArenaKingS3QualifierGetNewOpponentReq(activityId, stepId, mode)
end

function YouthArenaThirdController:handlePM_YoungArenaKingS3QualifierGetNewOpponentRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_YoungArenaKingS3QualifierGetNewOpponentRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_YoungArenaKingS3QualifierGetNewOpponentRes, msg.activityId, msg.stepId, msg.mode)
end

function YouthArenaThirdController:sendPM_YoungArenaKingS3QualifierFightReq(activityId, stepId, mode, formList, useSystemProperty)
	YouthArenaThirdAgent.instance:sendPM_YoungArenaKingS3QualifierFightReq(activityId, stepId, mode, formList, useSystemProperty)
end

function YouthArenaThirdController:handlePM_YoungArenaKingS3QualifierFightRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_YoungArenaKingS3QualifierFightRes(msg)

	if not msg.battleResult or msg.battleResult[1] == nil then
		UIJumper.instance:clear()
		TipsFacade.instance:openTipWindowNoX("提示", "对面为空阵，恭喜您获得本场战斗的胜利", function()
			UIStateManager.instance:popByName(ViewName.CustomMissionView)
		end, "确定")

		return
	end

	local petStates = {}

	local function recordPetStates(battleIndex)
		if battleIndex <= 0 or petStates[battleIndex] then
			return
		end

		local battleStates = {
			[GameEnum.BattleTeam.Left] = {},
			[GameEnum.BattleTeam.Right] = {}
		}

		petStates[battleIndex] = battleStates

		for _, unit in ipairs(BattleModel.instance:getUnits()) do
			local var_25_0 = checknumber(unit.id)
			local var_25_1 = {}

			var_25_1.isDead = unit:isDead() or unit.attrs:getCurHp() == 0
			battleStates[GameEnum.BattleTeam.Left][var_25_0] = var_25_1
		end

		for _, unit in ipairs(BattleModel.instance:getEnemyUnits()) do
			local var_25_2 = checknumber(unit.id)
			local var_25_3 = {}

			var_25_3.isDead = unit:isDead() or unit.attrs:getCurHp() == 0
			battleStates[GameEnum.BattleTeam.Right][var_25_2] = var_25_3
		end
	end

	BattleFacade.instance:registerResultHandler(function()
		recordPetStates(#msg.battleResult)

		local results = {}

		for _, isWin in ipairs(msg.isWinList or {}) do
			table.insert(results, (isWin or nil) and (GameEnum.BattleResult.Success or GameEnum.BattleResult.Failed))
		end

		local settlementParam = {
			results = results,
			petStates = petStates
		}
		local isScoreMatch = msg.stepId == YouthArenaThirdEnum.MatchStepId.ScoreMatch

		if msg.stepId == YouthArenaThirdEnum.MatchStepId.Qualifier or isScoreMatch then
			if isScoreMatch then
				settlementParam.scoreText = string.format("积分：%+d", checknumber(msg.scoreChange))
			else
				settlementParam.scoreItems = {
					{
						title = "积分：",
						oldValue = msg.oldScore,
						newValue = msg.newScore
					}
				}
			end

			settlementParam.totalScores = {
				left = msg.myTotalScore,
				right = msg.opTotalScore
			}
		end

		BattleFacade.instance:registerResultHandler(nil, nil)
		UIStateManager.instance:open(ViewName.CommonScrollerBattleSettlementView, msg.battleResult, GameEnum.BattleTeam.Left, settlementParam)

		return true
	end)
	BattleController.instance:viewUserFightMonsterBtlResultWithList(msg.battleResult, function(nextIndex)
		if nextIndex > 1 then
			recordPetStates(nextIndex - 1)
		end
	end)
end

function YouthArenaThirdController:sendPM_YoungArenaKingS3QualifierRecordsReq(activityId, isFun, mode)
	YouthArenaThirdAgent.instance:sendPM_YoungArenaKingS3QualifierRecordsReq(activityId, isFun, mode)
end

function YouthArenaThirdController:handlePM_YoungArenaKingS3QualifierRecordsRes(status, msg)
	if checknumber(status) == 0 and msg then
		local mo = self:getSubMo(msg.activityId)

		mo:handlePM_YoungArenaKingS3QualifierRecordsRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_YoungArenaKingS3QualifierRecordsRes, status, msg)
end

function YouthArenaThirdController:sendPM_YoungArenaKingS3QualifierRankInfoReq(activityId, zoneId, stepId)
	YouthArenaThirdAgent.instance:sendPM_YoungArenaKingS3QualifierRankInfoReq(activityId, zoneId, stepId)
end

function YouthArenaThirdController:handlePM_YoungArenaKingS3QualifierRankInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_YoungArenaKingS3QualifierRankInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_YoungArenaKingS3QualifierRankInfoRes)
end

function YouthArenaThirdController:sendPM_YoungArenaKingS3QualifierPetRaceRankReq(activityId, stepId, winRank)
	YouthArenaThirdAgent.instance:sendPM_YoungArenaKingS3QualifierPetRaceRankReq(activityId, stepId, winRank)
end

function YouthArenaThirdController:handlePM_YoungArenaKingS3QualifierPetRaceRankRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_YoungArenaKingS3QualifierPetRaceRankRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_YoungArenaKingS3QualifierPetRaceRankRes)
end

function YouthArenaThirdController:sendPM_YoungArenaKingS3MyKnockoutInfoReq(activityId)
	YouthArenaThirdAgent.instance:sendPM_YoungArenaKingS3MyKnockoutInfoReq(activityId)
end

function YouthArenaThirdController:handlePM_YoungArenaKingS3MyKnockoutInfoRes(status, msg)
	if checknumber(status) == 0 and msg then
		local mo = self:getSubMo(msg.activityId)

		mo:handlePM_YoungArenaKingS3MyKnockoutInfoRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_YoungArenaKingS3MyKnockoutInfoRes, status, msg)
end

function YouthArenaThirdController:sendPM_YoungArenaKingS3GetKnockoutScheduleReq(activityId, viewGroupId, roundId)
	YouthArenaThirdAgent.instance:sendPM_YoungArenaKingS3GetKnockoutScheduleReq(activityId, viewGroupId, roundId)
end

function YouthArenaThirdController:handlePM_YoungArenaKingS3GetKnockoutScheduleRes(status, msg)
	if checknumber(status) == 0 and msg then
		local mo = self:getSubMo(msg.activityId)

		mo:handlePM_YoungArenaKingS3GetKnockoutScheduleRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_YoungArenaKingS3GetKnockoutScheduleRes, status, msg)
end

function YouthArenaThirdController:sendPM_YoungArenaKingS3GetDisplayInfoReq(activityId)
	YouthArenaThirdAgent.instance:sendPM_YoungArenaKingS3GetDisplayInfoReq(activityId)
end

function YouthArenaThirdController:handlePM_YoungArenaKingS3GetDisplayInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_YoungArenaKingS3GetDisplayInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_YoungArenaKingS3GetDisplayInfoRes)
end

function YouthArenaThirdController:getActivityType()
	return GameEnum.ActivityType.YouthArenaThird
end

function YouthArenaThirdController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function YouthArenaThirdController:loadMyScheduleRedPoint()
	self:_setMyScheduleRedPoint(false, 0)

	local activityId = self:getActivityId()

	if activityId <= 0 then
		return
	end

	self:sendPM_YoungArenaKingS3GetInfoReq(activityId)
end

function YouthArenaThirdController:_setMyScheduleRedPoint(isActive, endTime)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_YOUTH_ARENA_THIRD_MY_SCHEDULE, checkbool(isActive), true, 0, checknumber(endTime))
end

function YouthArenaThirdController:_isChampionRoundType(roundType)
	return CHAMPION_ROUND_TYPE_MAP[roundType] == true
end

function YouthArenaThirdController:_refreshMyScheduleRedPoint(activityId)
	activityId = checknumber(activityId)

	if activityId <= 0 or not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		self:_setMyScheduleRedPoint(false, 0)

		return
	end

	local mo = self:getSubMo(activityId)
	local curStepId = mo and mo:getCurStepId() or 0
	local playerRoundId = mo and mo:getPlayerRoundId() or 0
	local stepCfg = YouthArenaThirdConfig.instance:getStepData(activityId, curStepId)
	local roundId = checknumber(stepCfg and stepCfg.roundId)
	local roundCfg = YouthArenaThirdConfig.instance:getRoundData(activityId, roundId)
	local isActive = stepCfg ~= nil and roundCfg ~= nil and self:_isChampionRoundType(roundCfg.roundType) and checkbool(stepCfg.canSetForm) and roundId <= playerRoundId
	local endTime = 0

	if isActive then
		local nextStepCfg = YouthArenaThirdConfig.instance:getStepData(activityId, curStepId + 1)

		if nextStepCfg and not string.nilorempty(nextStepCfg.startTime) then
			endTime = checknumber(GameUtil.string2time(nextStepCfg.startTime))
		end
	end

	self:_setMyScheduleRedPoint(isActive, endTime)
end

function YouthArenaThirdController:_shouldPullMyScheduleInfo(activityId, oldStepCfg, newStepCfg)
	if newStepCfg == nil or not checkbool(newStepCfg.canSetForm) then
		return false
	end

	local newRoundId = checknumber(newStepCfg.roundId)
	local newRoundCfg = YouthArenaThirdConfig.instance:getRoundData(activityId, newRoundId)

	if newRoundCfg == nil or not self:_isChampionRoundType(newRoundCfg.roundType) then
		return false
	end

	local oldRoundId = checknumber(oldStepCfg and oldStepCfg.roundId)

	if oldRoundId <= 0 or newRoundId <= oldRoundId then
		return false
	end

	local mo = self:getSubMo(activityId)
	local playerRoundId = mo and mo:getPlayerRoundId() or 0

	if playerRoundId < oldRoundId or newRoundId <= playerRoundId then
		return false
	end

	return true
end

function YouthArenaThirdController:_ensureStepChangeGetInfo()
	removetimer(self._ensureStepChangeGetInfo, self)

	local param = self._ensureGetInfoParam

	self._ensureGetInfoParam = nil

	if param == nil then
		return
	end

	if param.activityId ~= self:getActivityId() then
		return
	end

	local mo = self:getSubMo(param.activityId)

	if mo == nil or mo:getCurStepId() ~= param.stepId then
		return
	end

	self:requestGetInfoForStepChange(param.activityId, param.stepId)
end

function YouthArenaThirdController:getMatchFightDeadlineStamp(activityId, stepId)
	activityId = checknumber(activityId)
	stepId = checknumber(stepId)

	local matchCfg = YouthArenaThirdConfig.instance:getMatchData(activityId, stepId)

	if not matchCfg then
		printError(string.format("少年竞技王S3赛事配置缺失( activityId=%s, stepId=%s )", activityId, stepId))

		return 0
	end

	local endTime, endTimeStepId

	if stepId == YouthArenaThirdEnum.MatchStepId.Qualifier then
		endTimeStepId = YouthArenaThirdEnum.TimeStepId.ScoreMatchStart
	elseif stepId == YouthArenaThirdEnum.MatchStepId.ScoreMatch then
		endTimeStepId = YouthArenaThirdEnum.TimeStepId.KnockoutStart
	elseif stepId == YouthArenaThirdEnum.MatchStepId.Fun then
		local actDefineCfg = ActivityDefineConfig.instance:getCfgByActivitYId(activityId)

		endTime = actDefineCfg and actDefineCfg.endTime
	else
		printError(string.format("少年竞技王S3赛事阶段不支持截止时间计算( activityId=%s, stepId=%s )", activityId, stepId))

		return 0
	end

	if endTimeStepId then
		local stepCfg = YouthArenaThirdConfig.instance:getStepData(activityId, endTimeStepId)

		endTime = stepCfg and stepCfg.startTime
	end

	if string.nilorempty(endTime) then
		printError(string.format("少年竞技王S3赛事结束时间配置缺失( activityId=%s, stepId=%s )", activityId, stepId))

		return 0
	end

	local endStamp = GameUtil.string2time(endTime)

	if endStamp <= 0 then
		printError(string.format("少年竞技王S3赛事结束时间配置错误( activityId=%s, stepId=%s, endTime=%s )", activityId, stepId, endTime))

		return 0
	end

	local endEarly = math.max(checknumber(matchCfg.endEarly), 0)

	return endStamp - endEarly * 60
end

function YouthArenaThirdController:isMatchFightStopped(activityId, stepId, nowStamp)
	local deadlineStamp = self:getMatchFightDeadlineStamp(activityId, stepId)

	if deadlineStamp <= 0 then
		return false
	end

	local now = nowStamp ~= nil and checknumber(nowStamp) or ServerTime.now()

	return deadlineStamp <= now
end

function YouthArenaThirdController:checkMatchFightAvailable(activityId, stepId, showTips)
	if not self:isMatchFightStopped(activityId, stepId) then
		return true
	end

	if showTips then
		FloatWordMgr.instance:show(MATCH_SETTLEMENT_TIP)
	end

	return false
end

function YouthArenaThirdController:isInMatchClosedTimeRange(activityId, stepId)
	local matchCfg = YouthArenaThirdConfig.instance:getMatchData(checknumber(activityId), checknumber(stepId))

	if matchCfg then
		if not matchCfg.closedTimeRange then
			local closedTimeRange = ""

			if string.nilorempty(closedTimeRange) then
				return false
			end

			local arr = string.split(closedTimeRange, "-")
			local closeStart = arr[1]
			local closeEnd = arr[2]

			if string.nilorempty(closeStart) or string.nilorempty(closeEnd) then
				return false
			end

			local serverDate = GameUtil.time2date(ServerTime.now())
			local datePrefix = string.format("%04d-%02d-%02d ", serverDate.year, serverDate.month, serverDate.day)

			return GameUtil.checkIsInTimePeriod(datePrefix .. closeStart, datePrefix .. closeEnd)
		end
	end
end

function YouthArenaThirdController:checkMatchDailyTimeAvailable(activityId, stepId, showTips)
	if not self:isInMatchClosedTimeRange(activityId, stepId) then
		return true
	end

	if showTips then
		FloatWordMgr.instance:show(MATCH_CLOSED_TIME_TIP)
	end

	return false
end

function YouthArenaThirdController:checkScoreMatchChallengeAvailable(activityId, stepId, mode, showTips)
	stepId = checknumber(stepId)

	if stepId ~= YouthArenaThirdEnum.MatchStepId.ScoreMatch then
		return true
	end

	local subMo = self:getSubMo(checknumber(activityId))
	local qualifierInfo = subMo and subMo:getQualifierInfo(stepId, checknumber(mode))

	if qualifierInfo and checknumber(qualifierInfo.rankScore) > 0 then
		return true
	end

	if showTips then
		FloatWordMgr.instance:show(SCORE_MATCH_NO_SCORE_TIP)
	end

	return false
end

function YouthArenaThirdController:checkMatchChallengeAvailable(activityId, stepId, mode, showTips)
	if not self:checkMatchFightAvailable(activityId, stepId, showTips) then
		return false
	end

	if not self:checkMatchDailyTimeAvailable(activityId, stepId, showTips) then
		return false
	end

	return self:checkScoreMatchChallengeAvailable(activityId, stepId, mode, showTips)
end

function YouthArenaThirdController:_openYouthArenaThirdViewByNotify(params)
	self:openYouthArenaThirdView((params or nil) and checknumber(params[1]))
end

function YouthArenaThirdController:openYouthArenaThirdView(activityId)
	activityId = checknumber(activityId)

	if activityId <= 0 then
		activityId = self:getActivityId()
	end

	if activityId <= 0 then
		FloatWordMgr.instance:show("不在少年竞技王S3日期内")

		return
	end

	local inDisplay = self:isInDisplayStage(activityId)

	if inDisplay == nil then
		return
	end

	if inDisplay then
		self:openYouthArenaThirdDisplayView(activityId)
	else
		UIStateManager.instance:push(ViewName.YouthArenaThirdMainView, activityId)
	end
end

function YouthArenaThirdController:openYouthArenaThirdDisplayView(activityId)
	activityId = checknumber(activityId)

	if activityId <= 0 then
		return
	end

	if UIStateManager.instance:getTopName() == ViewName.YouthArenaThirdChampionShowView then
		return
	end

	UIStateManager.instance:closeAllModalViews()
	UIStateManager.instance:popByName(ViewName.YouthArenaThirdMainView)
	UIStateManager.instance:push(ViewName.YouthArenaThirdChampionShowView, activityId)
end

function YouthArenaThirdController:openRankView(activityId, defaultRankStage, defaultRankType)
	activityId = checknumber(activityId)

	if activityId <= 0 then
		activityId = self:getActivityId()
	end

	if activityId <= 0 then
		FloatWordMgr.instance:show("不在少年竞技王S3日期内")

		return
	end

	defaultRankStage = self:_normalizeRankStage(defaultRankStage)
	defaultRankType = self:_normalizeRankType(defaultRankType)

	local params = CommonTabRankListParams.New()
	local defaultKey
	local championScoreRoundId = self:getRankChampionScoreRoundId(activityId)

	local function addRoot(headTabId, tabKey, tabName)
		params:addTabData(headTabId, 0, tabKey, nil, tabName)
	end

	local function addLeaf(headTabId, secTabId, stage, rankType, tabName)
		local tabKey = self:_getRankTabKey(stage, rankType)

		if stage == YouthArenaThirdEnum.RankStage.ChampionScore then
			if not championScoreRoundId then
				local roundId = 0

				params:addTabData(headTabId, secTabId, tabKey, (rankType == YouthArenaThirdEnum.RankType.PetWinRate or rankType == YouthArenaThirdEnum.RankType.PetUse or nil) and ViewName.YouthArenaThirdPetChildRankView, tabName, {
					activityId,
					stage,
					rankType,
					roundId
				})

				if stage == defaultRankStage and rankType == defaultRankType then
					defaultKey = tabKey
				end
			end
		end
	end

	addRoot(YouthArenaThirdEnum.RankStage.Qualifier, "YouthArenaThirdRank_Qualifier", "战区预选赛")
	addLeaf(YouthArenaThirdEnum.RankStage.Qualifier, 1, YouthArenaThirdEnum.RankStage.Qualifier, YouthArenaThirdEnum.RankType.PlayerScore, "个人积分")
	addLeaf(YouthArenaThirdEnum.RankStage.Qualifier, 2, YouthArenaThirdEnum.RankStage.Qualifier, YouthArenaThirdEnum.RankType.PetWinRate, "精灵胜率")
	addLeaf(YouthArenaThirdEnum.RankStage.Qualifier, 3, YouthArenaThirdEnum.RankStage.Qualifier, YouthArenaThirdEnum.RankType.PetUse, "精灵上阵")
	addRoot(YouthArenaThirdEnum.RankStage.ScoreMatch, "YouthArenaThirdRank_ScoreMatch", "战区积分赛")
	addLeaf(YouthArenaThirdEnum.RankStage.ScoreMatch, 1, YouthArenaThirdEnum.RankStage.ScoreMatch, YouthArenaThirdEnum.RankType.PlayerScore, "个人积分")
	addLeaf(YouthArenaThirdEnum.RankStage.ScoreMatch, 2, YouthArenaThirdEnum.RankStage.ScoreMatch, YouthArenaThirdEnum.RankType.PetWinRate, "精灵胜率")
	addLeaf(YouthArenaThirdEnum.RankStage.ScoreMatch, 3, YouthArenaThirdEnum.RankStage.ScoreMatch, YouthArenaThirdEnum.RankType.PetUse, "精灵上阵")
	addRoot(YouthArenaThirdEnum.RankStage.ChampionScore, "YouthArenaThirdRank_ChampionScore", "冠军积分赛")
	addLeaf(YouthArenaThirdEnum.RankStage.ChampionScore, 1, YouthArenaThirdEnum.RankStage.ChampionScore, YouthArenaThirdEnum.RankType.PlayerScore, "个人积分")
	params:setDafaultOpenTab(defaultKey or self:_getRankTabKey(YouthArenaThirdEnum.RankStage.Qualifier, YouthArenaThirdEnum.RankType.PlayerScore))
	UIStateManager.instance:push(ViewName.YouthArenaThirdRankFatherListView, params)
end

function YouthArenaThirdController:getRankStageByTabKey(tabKey)
	if tabKey == YouthArenaThirdEnum.TabKey.ScoreMatch then
		return YouthArenaThirdEnum.RankStage.ScoreMatch
	end

	if tabKey == YouthArenaThirdEnum.TabKey.ChampionScoreMatch or tabKey == YouthArenaThirdEnum.TabKey.ChampionKnockout then
		return YouthArenaThirdEnum.RankStage.ChampionScore
	end

	return YouthArenaThirdEnum.RankStage.Qualifier
end

function YouthArenaThirdController:getRankChampionScoreRoundId(activityId)
	local now = ServerTime.now()
	local startedRoundId = 0
	local startedStepId = 0
	local lastRoundId = 0

	for _, roundData in pairs(YouthArenaThirdConfig.instance:getRoundDatas(activityId) or {}) do
		if self:isChampionScoreRoundType(roundData.roundType) then
			lastRoundId = math.max(lastRoundId, checknumber(roundData.roundId))
		end
	end

	for _, stepData in pairs(YouthArenaThirdConfig.instance:getStepDatas(activityId) or {}) do
		local roundId = checknumber(stepData.roundId)
		local roundData = YouthArenaThirdConfig.instance:getRoundData(activityId, roundId)

		if roundData and self:isChampionScoreRoundType(roundData.roundType) then
			local startStamp = GameUtil.string2time(stepData.startTime)
			local stepId = checknumber(stepData.stepId)

			if startStamp > 0 and startStamp <= now and startedStepId <= stepId then
				startedRoundId = roundId
				startedStepId = stepId
			end
		end
	end

	return startedRoundId > 0 and startedRoundId or lastRoundId
end

function YouthArenaThirdController:getRankStageStartStepId(activityId, rankStage)
	rankStage = self:_normalizeRankStage(rankStage)

	if rankStage == YouthArenaThirdEnum.RankStage.Qualifier then
		return YouthArenaThirdEnum.TimeStepId.QualifierStart
	end

	if rankStage == YouthArenaThirdEnum.RankStage.ScoreMatch then
		return YouthArenaThirdEnum.TimeStepId.ScoreMatchStart
	end

	if rankStage == YouthArenaThirdEnum.RankStage.ChampionScore then
		return self:getChampionScoreMatchStartStepId(activityId)
	end

	return 0
end

function YouthArenaThirdController:getRankStageStartStamp(activityId, rankStage)
	activityId = checknumber(activityId)

	if activityId <= 0 then
		return 0
	end

	local stepId = self:getRankStageStartStepId(activityId, rankStage)
	local stepData = YouthArenaThirdConfig.instance:getStepData(activityId, stepId)

	return stepData and GameUtil.string2time(stepData.startTime) or 0
end

function YouthArenaThirdController:isRankStageOpen(activityId, rankStage)
	local startStamp = self:getRankStageStartStamp(activityId, rankStage)

	return startStamp > 0 and startStamp <= ServerTime.now()
end

function YouthArenaThirdController:_normalizeRankStage(rankStage)
	rankStage = checknumber(rankStage)

	if rankStage == YouthArenaThirdEnum.MatchStepId.ScoreMatch then
		return YouthArenaThirdEnum.RankStage.ScoreMatch
	end

	if rankStage == YouthArenaThirdEnum.RankStage.ChampionScore then
		return YouthArenaThirdEnum.RankStage.ChampionScore
	end

	return YouthArenaThirdEnum.RankStage.Qualifier
end

function YouthArenaThirdController:_normalizeRankType(rankType)
	rankType = checknumber(rankType)

	if rankType == YouthArenaThirdEnum.RankType.PetWinRate or rankType == YouthArenaThirdEnum.RankType.PetUse then
		return rankType
	end

	return YouthArenaThirdEnum.RankType.PlayerScore
end

function YouthArenaThirdController:_getRankTabKey(rankStage, rankType)
	return string.format("YouthArenaThirdRank_%s_%s", checknumber(rankStage), checknumber(rankType))
end

function YouthArenaThirdController:trySwitchToDisplayViewFromMain(activityId)
	local inDisplay = self:isInDisplayStage(activityId)

	if inDisplay ~= true then
		return false
	end

	self:openYouthArenaThirdDisplayView(activityId)

	return true
end

function YouthArenaThirdController:getCurZoneCfg(activityId)
	local areaId = RoleModel.instance:getAreaId()
	local zoneDatas = YouthArenaThirdConfig.instance:getZoneDatas(activityId)

	for _, cfg in pairs(zoneDatas or {}) do
		if not cfg.areaIds then
			if areaId >= checknumber(cfg.areaIds[1]) and areaId <= checknumber(cfg.areaIds[2]) then
				return cfg
			end
		end
	end
end

function YouthArenaThirdController:getCurZoneId(activityId)
	local zoneCfg = self:getCurZoneCfg(activityId)

	return (zoneCfg or nil) and (zoneCfg.zoneId or 0)
end

function YouthArenaThirdController:getCurZoneName(activityId)
	local zoneCfg = self:getCurZoneCfg(activityId)

	return (zoneCfg or nil) and (zoneCfg.name or "")
end

function YouthArenaThirdController:isChampionScoreRoundType(roundType)
	return YouthArenaThirdEnum.ChampionScoreRoundTypeMap[roundType] == true
end

function YouthArenaThirdController:isChampionScoreRound(activityId, roundId)
	local roundData = YouthArenaThirdConfig.instance:getRoundData(activityId, roundId)

	return roundData ~= nil and self:isChampionScoreRoundType(roundData.roundType)
end

function YouthArenaThirdController:getChampionScheduleViewGroupId(activityId, roundId, matchIndex)
	activityId = checknumber(activityId)
	roundId = checknumber(roundId)
	matchIndex = checknumber(matchIndex)

	if activityId <= 0 or roundId <= 0 then
		return 0
	end

	if self:isChampionScoreRound(activityId, roundId) then
		return 1
	end

	local startRoundId = YouthArenaThirdEnum.ChampionRoundId.KnockoutStart
	local endRoundId = YouthArenaThirdEnum.ChampionRoundId.KnockoutEnd

	if roundId < startRoundId or endRoundId < roundId then
		return 0
	end

	if roundId == endRoundId then
		return 1
	end

	if matchIndex <= 0 then
		return 0
	end

	local matchCount = 2^(endRoundId - roundId - 1)

	return math.ceil(matchIndex / matchCount)
end

function YouthArenaThirdController:getFirstStepIdByRoundTypeMap(activityId, roundTypeMap)
	local minStepId = 0
	local validRoundTypeMap = roundTypeMap or {}

	for _, stepData in pairs(YouthArenaThirdConfig.instance:getStepDatas(activityId) or {}) do
		local roundData = YouthArenaThirdConfig.instance:getRoundData(activityId, stepData.roundId)

		if roundData and validRoundTypeMap[roundData.roundType] == true then
			local stepId = checknumber(stepData.stepId)

			if stepId > 0 and (minStepId <= 0 or stepId < minStepId) then
				minStepId = stepId
			end
		end
	end

	return minStepId
end

function YouthArenaThirdController:getChampionScoreMatchStartStepId(activityId)
	return self:getFirstStepIdByRoundTypeMap(activityId, YouthArenaThirdEnum.ChampionScoreRoundTypeMap)
end

function YouthArenaThirdController:getDisplayStartStepId(activityId)
	return self:getFirstStepIdByRoundTypeMap(activityId, {
		[YouthArenaThirdEnum.RoundType.Display] = true
	})
end

function YouthArenaThirdController:isInDisplayStage(activityId)
	activityId = checknumber(activityId)

	if activityId <= 0 then
		return false
	end

	local displayStartStepId = self:getDisplayStartStepId(activityId)

	if displayStartStepId <= 0 then
		printError(string.format("少年竞技王S3 DISPLAY 阶段配置缺失( activityId=%s )", activityId))

		return nil
	end

	local stepData = YouthArenaThirdConfig.instance:getStepData(activityId, displayStartStepId)

	if not stepData or string.nilorempty(stepData.startTime) then
		printError(string.format("少年竞技王S3 DISPLAY 阶段开始时间配置缺失( activityId=%s, stepId=%s )", activityId, displayStartStepId))

		return nil
	end

	local displayStartStamp = GameUtil.string2time(stepData.startTime)

	if displayStartStamp <= 0 then
		printError(string.format("少年竞技王S3 DISPLAY 阶段开始时间配置错误( activityId=%s, stepId=%s, startTime=%s )", activityId, displayStartStepId, stepData.startTime))

		return nil
	end

	return displayStartStamp <= ServerTime.now()
end

function YouthArenaThirdController:getSubMo(activityId)
	return YouthArenaThirdModel.instance:getSubMo(activityId)
end

function YouthArenaThirdController:_getUseSystemPropertyKey(activityId)
	return string.format(USE_SYSTEM_PROPERTY_KEY, checknumber(activityId))
end

function YouthArenaThirdController:getUseSystemProperty(activityId, stepId)
	activityId = checknumber(activityId)
	stepId = checknumber(stepId)

	if activityId <= 0 or stepId <= 0 then
		return false
	end

	local data = GameUtil.getUserData(self:_getUseSystemPropertyKey(activityId))

	if type(data) ~= "table" then
		return false
	end

	if checknumber(data.stepId) ~= stepId then
		return false
	end

	return checkbool(data.value)
end

function YouthArenaThirdController:setUseSystemProperty(activityId, stepId, isUse)
	activityId = checknumber(activityId)
	stepId = checknumber(stepId)

	if activityId <= 0 or stepId <= 0 then
		return
	end

	GameUtil.saveUserData(self:_getUseSystemPropertyKey(activityId), {
		stepId = stepId,
		value = checkbool(isUse)
	})
end

function YouthArenaThirdController:openMatchAttackFormationView(activityId, stepId, mode)
	activityId = checknumber(activityId)
	stepId = checknumber(stepId)
	mode = checknumber(mode)

	if not self:checkMatchFightAvailable(activityId, stepId, true) or not self:checkMatchDailyTimeAvailable(activityId, stepId, true) then
		return
	end

	local subMo = self:getSubMo(activityId)
	local opponent = subMo and subMo:getOpponent(stepId, mode)

	if not opponent then
		FloatWordMgr.instance:show("请先匹配对手")

		return
	end

	if not self:checkScoreMatchChallengeAvailable(activityId, stepId, mode, true) then
		return
	end

	if self._pendingDefenseOpenParam ~= nil then
		return
	end

	local isFun = stepId == YouthArenaThirdEnum.MatchStepId.Fun
	local readyState = YouthArenaThirdModel.instance:getDefenseReadyState(activityId, isFun, mode)

	if readyState == false then
		self:_showDefenseNotReadyTip(activityId, isFun, mode)

		return
	end

	if readyState == true then
		self:_openMatchAttackFormationView(activityId, stepId, mode)

		return
	end

	self:_requestDefenseFormation({
		reason = "fight",
		activityId = activityId,
		isFun = isFun,
		mode = mode,
		stepId = stepId
	})
end

function YouthArenaThirdController:_openMatchAttackFormationView(activityId, stepId, mode)
	if not self:checkMatchChallengeAvailable(activityId, stepId, mode, true) then
		return
	end

	local fmtMo = YouthArenaThirdModel.instance:getMatchAttackFmtMo(activityId)

	fmtMo:initParams(activityId, stepId, mode)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function YouthArenaThirdController:_showDefenseNotReadyTip(activityId, isFun, mode)
	TipsFacade.instance:openTipWindowNoX("提示", DEFENSE_NOT_READY_TIP, function()
		local subMo = self:getSubMo(activityId)
		local stepId = checknumber(subMo and subMo:getCurStepId())

		self:openDefenseFormationView(activityId, isFun, mode, stepId)
	end, "去布阵")
end

function YouthArenaThirdController:_requestDefenseFormation(param)
	if self._pendingDefenseOpenParam ~= nil then
		return false
	end

	self._pendingDefenseOpenParam = param

	self:sendPM_YoungArenaKingS3GetDefenseForamtionReq(param.isFun, param.mode)

	return true
end

function YouthArenaThirdController:_invalidateDefenseReadyState(activityId)
	activityId = checknumber(activityId)

	YouthArenaThirdModel.instance:clearDefenseReadyState(activityId)

	local param = self._pendingDefenseOpenParam

	if param and param.activityId == activityId then
		param.invalidated = true
	end
end

function YouthArenaThirdController:openDefenseFormationView(activityId, isFun, mode, stepId)
	activityId = checknumber(activityId)
	mode = checknumber(mode)
	stepId = checknumber(stepId)

	if activityId <= 0 or mode <= 0 or stepId <= 0 then
		return
	end

	self:_requestDefenseFormation({
		reason = "open",
		activityId = activityId,
		isFun = checkbool(isFun),
		mode = mode,
		stepId = stepId
	})
end

function YouthArenaThirdController:trySwitchDefenseFormationMode(fmtMo, targetMode)
	if fmtMo == nil then
		return
	end

	if self._pendingDefenseOpenParam ~= nil or self._pendingDefenseSaveParam ~= nil then
		return
	end

	targetMode = checknumber(targetMode)

	if targetMode ~= YouthArenaThirdEnum.BattleMode.One and targetMode ~= YouthArenaThirdEnum.BattleMode.Three then
		return
	end

	if targetMode == fmtMo:getMode() then
		return
	end

	if fmtMo:isCurModeDirty() then
		fmtMo:trySave(function()
			self:_switchDefenseFormationMode(fmtMo, targetMode)
		end)

		return
	end

	self:_switchDefenseFormationMode(fmtMo, targetMode)
end

function YouthArenaThirdController:_switchDefenseFormationMode(fmtMo, targetMode)
	if fmtMo:hasModeData(targetMode) then
		fmtMo:switchMode(targetMode)

		return
	end

	self:_requestDefenseFormation({
		reason = "switch",
		activityId = fmtMo:getActivityId(),
		isFun = fmtMo:getIsFun(),
		mode = targetMode,
		stepId = fmtMo:getStepId(),
		fmtMo = fmtMo
	})
end

YouthArenaThirdController.instance = YouthArenaThirdController.New()

return YouthArenaThirdController
