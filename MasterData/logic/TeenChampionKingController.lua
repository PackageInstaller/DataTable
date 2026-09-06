-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/controller/TeenChampionKingController.lua

module("logic.extensions.teenchampionking.controller.TeenChampionKingController", package.seeall)

local TeenChampionKingController = class("TeenChampionKingController", BaseController)

TeenChampionKingController.RoundType = {
	DISPLAY = "DISPLAY",
	SCORE = "SCORE_MATCH",
	QUALIFY = "QUALIFY",
	KNOCKOUT = "COMMON_KNOCKOUT",
	CHAMPION = "CHAMPION_SCORE_MATCH"
}
TeenChampionKingController.EntertainmentStartStepId = 2
TeenChampionKingController.PRELIMINARY = 1
TeenChampionKingController.POINTS_RACE = 2
TeenChampionKingController.ROUND_KNOCKOUT_MIN = 3
TeenChampionKingController.ROUND_KNOCKOUT_MAX = 5
TeenChampionKingController.ROUND_QUARTERFINALS = 6
TeenChampionKingController.ROUND_CHAMPIONSHIP_MIN = 7
TeenChampionKingController.ROUND_CHAMPIONSHIP_MAX = 13
TeenChampionKingController.EntertainmentStepId = 9999999

function TeenChampionKingController:onInit()
	GlobalDispatcher:addListener("enterTeenChampionKing", self.enterGameModule, self)
	GlobalDispatcher:addListener("Enter_Teen_Champion_King_Schedule", self.enterRoomFormRd, self)
	self:onReset()
end

function TeenChampionKingController:onReset()
	self._curActivityId = nil
	self.msgMap = {}
	self._fmtMoMap = {}
	self._roundFmtMoMap = {}
	self._isRoomLock = false
end

function TeenChampionKingController:enterGameModule(param)
	local activityId = checknumber(param[1])

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		printError("少年竞技王2活动未开启：" .. activityId)

		return
	end

	self._curActivityId = activityId

	local stepId = self:getCurStepIdByClent(self._curActivityId)
	local curRoundCfg = TeenChampionKingConfig.instance:getRoundCfgByStepId(activityId, stepId)

	if curRoundCfg then
		local roundType = curRoundCfg.roundType

		if roundType == TeenChampionKingController.RoundType.DISPLAY then
			UIStateManager.instance:push(ViewName.TCKDisplayView, activityId)
		else
			UIStateManager.instance:push(ViewName.TeenChampionKingMainView, activityId)
		end
	end
end

function TeenChampionKingController:enterRoomFormRd(param)
	local activityId = checknumber(param[1])

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		printError("少年竞技王2活动未开启：" .. activityId)

		return
	end

	local stepId = self:getCurStepIdByClent(activityId)
	local roundId = TeenChampionKingConfig.instance:getRoundIdByStepId(activityId, stepId)

	if roundId >= TeenChampionKingController.ROUND_KNOCKOUT_MIN and roundId <= TeenChampionKingController.ROUND_QUARTERFINALS then
		UIStateManager.instance:push(ViewName.TCKKnockoutMainView, activityId)
	elseif roundId >= TeenChampionKingController.ROUND_CHAMPIONSHIP_MIN and roundId <= TeenChampionKingController.ROUND_CHAMPIONSHIP_MAX then
		UIStateManager.instance:push(ViewName.TCKChampionshipView, activityId)
	end
end

function TeenChampionKingController:loadKnockoutInfo()
	local activityId = 501001

	self._PrepareToSync = false

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_TEEN_CHAMPION_KING_SCHEDULE, false, true)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_TEEN_CHAMPION_KING_MY_SCHEDULE, false, true)

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		return
	end

	local stepId = self:getCurStepIdByClent(activityId)
	local roundId = TeenChampionKingConfig.instance:getRoundIdByStepId(activityId, stepId)

	if roundId >= TeenChampionKingController.ROUND_KNOCKOUT_MIN and roundId <= TeenChampionKingController.ROUND_CHAMPIONSHIP_MAX then
		self._PrepareToSync = true
	end

	self:getGlobalInfo(activityId)
end

function TeenChampionKingController:_sysnRedPoint(activityId)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_TEEN_CHAMPION_KING_SCHEDULE, false, true)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_TEEN_CHAMPION_KING_MY_SCHEDULE, false, true)

	local isKnockout = true
	local curStepId = -1
	local globalInfo = TeenChampionKingModel.instance:getGlobalInfo(activityId)

	if globalInfo then
		curStepId = globalInfo.curStepId
	end

	local curRoundId = TeenChampionKingConfig.instance:getRoundIdByStepId(activityId, curStepId)
	local curStepCfg = TeenChampionKingConfig.instance:getStepCfgByStepId(activityId, curStepId)
	local myKnockoutInfo = TeenChampionKingModel.instance:getMyKnockoutInfo(activityId)

	if myKnockoutInfo then
		local myInfo = myKnockoutInfo.knockoutInfo
		local battleRoundId = checknumber(myInfo and myInfo.roundId)

		if battleRoundId > 0 then
			isKnockout = battleRoundId < curRoundId
		end
	end

	if curRoundId >= TeenChampionKingController.ROUND_KNOCKOUT_MIN and curRoundId <= TeenChampionKingController.ROUND_CHAMPIONSHIP_MAX and curStepCfg.needKnockoutRoom then
		local showEndTime = self:getStartTimeAndEndTimeByStepId(activityId, curStepId + 1)

		RedPointController.instance:setRedPointInfo(RedPointModel.ID_TEEN_CHAMPION_KING_SCHEDULE, true, true, 0, showEndTime)

		if not isKnockout then
			RedPointController.instance:setRedPointInfo(RedPointModel.ID_TEEN_CHAMPION_KING_MY_SCHEDULE, true, true, 0, showEndTime)
		end
	end
end

function TeenChampionKingController:_sysnGuessItemRedPoint(activityId)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_TEEN_CHAMPION_KING_GUESS_ITEM, false, true)

	local curStepId = -1
	local gainDailyCoin = false
	local globalInfo = TeenChampionKingModel.instance:getGlobalInfo(activityId)

	if globalInfo then
		curStepId = globalInfo.curStepId
		gainDailyCoin = globalInfo.gainDailyCoin
	end

	local curRoundCfg = TeenChampionKingConfig.instance:getRoundCfgByStepId(activityId, curStepId)

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_TEEN_CHAMPION_KING_GUESS_ITEM, (curRoundCfg and curRoundCfg.roundGuessCoin > 0 or nil) and not gainDailyCoin, true)
end

function TeenChampionKingController:tryShowMission(activityId, statTime)
	local fmtMo = self._fmtMoMap[activityId]

	if not fmtMo then
		fmtMo = TCKKnockoutFmtMo.New()
		self._fmtMoMap[activityId] = fmtMo
	end

	fmtMo:initParams(activityId, statTime)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function TeenChampionKingController:getCurActivityId()
	return self._curActivityId
end

function TeenChampionKingController:getStartTimeAndEndTimeByStepId(activityId, stepId)
	local activityType = ActivityDefineController.instance:getActTypeByActId(activityId)
	local actStartTime, actEndTime = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, activityId)
	local startTimeStamp, endTimeStamp = actStartTime, actEndTime

	if stepId == TeenChampionKingController.EntertainmentStepId then
		local startStepCfg = TeenChampionKingConfig.instance:getStepCfgByStepId(activityId, TeenChampionKingController.EntertainmentStartStepId)

		if startStepCfg then
			startTimeStamp = GameUtil.string2time(startStepCfg.startTime)
		end
	else
		local curStepCfg = TeenChampionKingConfig.instance:getStepCfgByStepId(activityId, stepId)
		local nextStepCfg = TeenChampionKingConfig.instance:getStepCfgByStepId(activityId, stepId + 1)

		if curStepCfg then
			startTimeStamp = GameUtil.string2time(curStepCfg.startTime)
		end

		if nextStepCfg then
			endTimeStamp = GameUtil.string2time(nextStepCfg.startTime)
		end
	end

	return startTimeStamp, endTimeStamp
end

function TeenChampionKingController:getCurStepIdByClent(activityId)
	local timeNow = ServerTime.now()
	local stepCfgs = TeenChampionKingConfig.instance:getStepCfgsByActId(activityId)
	local curStepId = 1

	for stepId, cfg in ipairs(stepCfgs) do
		local startTimeStamp, endTimeStamp = self:getStartTimeAndEndTimeByStepId(activityId, stepId)

		if startTimeStamp < timeNow then
			curStepId = stepId
		else
			break
		end
	end

	return curStepId
end

function TeenChampionKingController:getCurRoundIdByClent(activityId)
	local curStepId = self:getCurStepIdByClent(activityId)
	local roundCfg = TeenChampionKingConfig.instance:getRoundCfgByStepId(activityId, curStepId)

	if roundCfg then
		return roundCfg.roundId
	end
end

function TeenChampionKingController:getRoundNameByStepId(activityId, stepId)
	if stepId == TeenChampionKingController.EntertainmentStepId then
		return "娱乐赛"
	else
		local roundCfg = TeenChampionKingConfig.instance:getRoundCfgByStepId(activityId, stepId)

		return roundCfg and roundCfg.roundName
	end
end

function TeenChampionKingController:getZoneCfgByActId(activityId)
	local areaId = RoleModel.instance:getAreaId()
	local zoneCfgs = TeenChampionKingConfig.instance:getZoneCfgs(activityId) or {}

	for i, cfg in pairs(zoneCfgs) do
		if areaId >= cfg.areaIds[1] and areaId <= cfg.areaIds[2] then
			return cfg
		end
	end
end

function TeenChampionKingController:getGlobalInfo(activityId)
	TeenChampionKingAgent.instance:sendPM_TeenCKGlobalInfoReq(activityId)
end

function TeenChampionKingController:handleGetGlobalInfo(msg)
	TeenChampionKingModel.instance:onGetGlobalInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKGetInfoRes)

	if self._PrepareToSync then
		self._PrepareToSync = false

		self:getMyKnockoutInfo(msg.activityId)
	end

	self:_sysnGuessItemRedPoint(msg.activityId)
end

function TeenChampionKingController:handleNotifyStepChange(msg)
	TeenChampionKingModel.instance:onNotifyStepChange(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKStepChange, msg.curStepId)

	local roundId = TeenChampionKingConfig.instance:getRoundIdByStepId(msg.activityId, msg.curStepId)

	if roundId >= TeenChampionKingController.ROUND_KNOCKOUT_MIN and roundId <= TeenChampionKingController.ROUND_CHAMPIONSHIP_MAX then
		self:getMyKnockoutInfo(msg.activityId)
	end
end

function TeenChampionKingController:getBattleRecord(activityId)
	TeenChampionKingAgent.instance:sendPM_TeenCKBattleRecordReq(activityId)
end

function TeenChampionKingController:handleGetBattleRecord(msg)
	TeenChampionKingModel.instance:onGetBattleRecord(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKGetBattleRecord)
end

function TeenChampionKingController:playBattleVideo(battleId)
	TeenChampionKingAgent.instance:sendPM_TeenCKBattleVideoReq(battleId)
end

function TeenChampionKingController:handlePlayBattleVideo(msg)
	local battleResult = msg.btlResult
	local teams = battleResult.originalStates.teams
	local teamId = 0
	local userId = checknumber(RoleModel.instance:getUserId())

	for _, v in ipairs(teams) do
		if userId == checknumber(v.playerView.id) then
			teamId = v.teamId

			break
		end
	end

	local function callBack()
		BattleModel.instance:setLeftTeamId(teamId)
		BattleController.instance:viewUserFightMonsterBtlResult(battleResult, false)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKGetVideoRes, callBack)
end

function TeenChampionKingController:selectPets(activityId, selectPetIds, useSysProperty)
	useSysProperty = checkbool(useSysProperty)

	TeenChampionKingAgent.instance:sendPM_TeenCKSelectPetReq(activityId, selectPetIds, useSysProperty)
end

function TeenChampionKingController:handleSelectPets(msg)
	TeenChampionKingModel.instance:onSelectPets(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKSelectPets)
end

function TeenChampionKingController:gainGuessCoin(activityId)
	TeenChampionKingAgent.instance:sendPM_TeenCKGainGuessCoinReq(activityId)
end

function TeenChampionKingController:handleGainGuessCoin(msg)
	TeenChampionKingModel.instance:onGainGuessCoin(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKGainGuessCoin)
	self:_sysnGuessItemRedPoint(msg.activityId)
end

function TeenChampionKingController:getQualifierInfo(activityId, stepId)
	TeenChampionKingAgent.instance:sendPM_TeenCKQualifierInfoReq(activityId, stepId)
end

function TeenChampionKingController:handleGetQualifierInfo(msg)
	TeenChampionKingModel.instance:onGetQualifierInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKGetQualifierInfo)
end

function TeenChampionKingController:startMatch(activityId, stepId)
	TeenChampionKingAgent.instance:sendPM_TeenCKMatchReq(activityId, stepId)
end

function TeenChampionKingController:handleStartMatch(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKStartMatch)
end

function TeenChampionKingController:cancelMatch()
	TeenChampionKingAgent.instance:sendPM_TeenCKCancelMatchReq()
end

function TeenChampionKingController:handleCancelMatch(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKCancelMatch)
end

function TeenChampionKingController:handleNotifyMatchFail(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKMatchFail, msg.reason)
end

function TeenChampionKingController:updateRankView(activityId, zoneId, stepId)
	TeenChampionKingAgent.instance:sendPM_TeenCKQualifierRankViewReq(activityId, zoneId, stepId)
end

function TeenChampionKingController:handleUpdateRankView(msg)
	TeenChampionKingModel.instance:onUpdateRankView(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKUpdateRank)
end

function TeenChampionKingController:updatePetRankView(activityId, stepId, winRank)
	TeenChampionKingAgent.instance:sendPM_TeenCKQualifierPetRankReq(activityId, stepId, winRank)
end

function TeenChampionKingController:handleUpdatePetView(msg)
	TeenChampionKingModel.instance:onUpdatePetRankView(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKUpdateRank)
end

function TeenChampionKingController:getMyKnockoutInfo(activityId)
	TeenChampionKingAgent.instance:sendPM_TeenCKMyKnockoutInfoReq(activityId)
end

function TeenChampionKingController:handleGetMyKnockoutInfo(msg)
	TeenChampionKingModel.instance:onGetMyKnockoutInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKGetMyKnockoutInfo)
	self:_sysnRedPoint(msg.activityId)
end

function TeenChampionKingController:getKnockoutSchedule(activityId, viewGroupId, roundId)
	TeenChampionKingAgent.instance:sendPM_TeenCKGetKnockoutScheduleReq(activityId, viewGroupId, roundId)
end

function TeenChampionKingController:handleGetKnockoutSchedule(msg)
	TeenChampionKingModel.instance:onGetKnockoutSchedule(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKKnockoutSchedule, msg.viewGroupId)
end

function TeenChampionKingController:getKnockoutGuessRecord(activityId, roundId)
	TeenChampionKingAgent.instance:sendPM_TeenCKKnockoutGuessRecordReq(activityId, roundId)
end

function TeenChampionKingController:handleGetKnockoutGuessRecord(msg)
	TeenChampionKingModel.instance:onGetKnockoutGuessRecord(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKGetKnockoutGuessRecord)
end

function TeenChampionKingController:guessKnockout(activityId, targetPlayerId, guessNum)
	TeenChampionKingAgent.instance:sendPM_TeenCKGuessKnockoutReq(activityId, targetPlayerId, guessNum)
end

function TeenChampionKingController:handleGuessKnockout(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKGuessKnockout)
end

function TeenChampionKingController:guessChampionship(activityId, guessNum)
	TeenChampionKingAgent.instance:sendPM_TeenCKGuessChampionshipReq(activityId, guessNum)
end

function TeenChampionKingController:handleGuessChampionship(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKGuessChampionship)
end

function TeenChampionKingController:changeGuessRank(activityId, guessPlayerIds)
	TeenChampionKingAgent.instance:sendPM_TeenCKChangeGuessRankReq(activityId, guessPlayerIds)
end

function TeenChampionKingController:handleChangeGuessRank(msg)
	TeenChampionKingModel.instance:onChangeGuessRank(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKChangeChampionshipGuess)
end

function TeenChampionKingController:getChampionshipGuessRecord(activityId)
	TeenChampionKingAgent.instance:sendPM_TeenCKChampionshipGuessRecordReq(activityId)
end

function TeenChampionKingController:handleGetChampionshipGuessRecord(msg)
	TeenChampionKingModel.instance:onGetChampionshipGuessRecord(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKGetChampionshipGuessRecord)
end

function TeenChampionKingController:getDisplayInfo(activityId)
	TeenChampionKingAgent.instance:sendPM_TeenCKDisplayInfoReq(activityId)
end

function TeenChampionKingController:handleGetDisplayInfo(msg)
	TeenChampionKingModel.instance:onGetDisplayInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKGetDisplayInfo)
end

function TeenChampionKingController:getKnockoutJoinRoomInfo(activityId, stepId, groupId)
	TeenChampionKingAgent.instance:sendPM_TeenCKKnockoutJoinRoomInfoReq(activityId, stepId, groupId)
end

function TeenChampionKingController:handleGetKnockoutJoinRoomInfo(msg)
	TeenChampionKingModel.instance:onGetKnockoutJoinRoomInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKKnockoutRoomStausUpdate)
end

function TeenChampionKingController:knockoutInviteOp(activityId, stepId, groupId)
	TeenChampionKingAgent.instance:sendPM_TeenCKKnockoutInviteOpReq(activityId, stepId, groupId)
end

function TeenChampionKingController:handleknockoutInviteOp(msg)
	return
end

function TeenChampionKingController:handleNotifyTeenCKKnockoutOpInvited(msg)
	self._curActivityId = activityId

	self:_tryUnregPopupMsg(msg.opHeadInfo.userId)

	self.msgMap[msg.opHeadInfo.userId] = MainUIPopupMsgController.instance:regPopMsg({
		showInitCD = 30,
		bTimeOutReject = true,
		desc = "奥奇竞技大赛-邀请",
		acceptFunc = self._tryAcceptInvite,
		rejectFunc = function()
			return
		end,
		thisArg = self,
		headInfo = msg.opHeadInfo,
		stepId = msg.stepId,
		activityId = msg.activityId
	})
end

function TeenChampionKingController:_tryAcceptInvite(params)
	local info = params.info
	local headInfo = info.headInfo
	local stepId = info.stepId
	local activityId = info.activityId
	local roundId = TeenChampionKingConfig.instance:getRoundIdByStepId(activityId, stepId)

	if roundId >= TeenChampionKingController.ROUND_KNOCKOUT_MIN and roundId <= TeenChampionKingController.ROUND_QUARTERFINALS then
		UIStateManager.instance:push(ViewName.TCKKnockoutMainView, activityId)
	elseif roundId >= TeenChampionKingController.ROUND_CHAMPIONSHIP_MIN and roundId <= TeenChampionKingController.ROUND_CHAMPIONSHIP_MAX then
		UIStateManager.instance:push(ViewName.TCKChampionshipView, activityId)
	end

	self:_tryUnregPopupMsg(headInfo.userId)
end

function TeenChampionKingController:_tryUnregPopupMsg(userId)
	local key = self.msgMap[userId]

	MainUIPopupMsgController.instance:removePopMsg(key)

	self.msgMap[userId] = nil
end

function TeenChampionKingController:knockoutJoinRoom(activityId, stepId, groupId)
	TeenChampionKingAgent.instance:sendPM_TeenCKKnockoutJoinRoomReq(activityId, stepId, groupId)
end

function TeenChampionKingController:handleknockoutJoinRoom(msg)
	TeenChampionKingModel.instance:onknockoutJoinRoom(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKKnockoutRoomStausUpdate)
end

function TeenChampionKingController:knockoutLeaveRoom(activityId, stepId, groupId)
	if self._isRoomLock then
		return
	end

	TeenChampionKingAgent.instance:sendPM_TeenCKKnockoutLeaveRoomReq(activityId, stepId, groupId)
end

function TeenChampionKingController:handleknockoutLeaveRoom(msg)
	TeenChampionKingModel.instance:onKnockoutLeaveRoom(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKKnockoutRoomStausUpdate)
end

function TeenChampionKingController:handleNotifyKnockoutOpRoomInfo(msg)
	TeenChampionKingModel.instance:onNotifyYCKKnockoutOpJoinRoom(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKKnockoutRoomStausUpdate)
end

function TeenChampionKingController:handleNotifyFightStart(msg)
	self._isRoomLock = true

	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKNotifyFightStart, msg)

	local info = GameUtil.pbToTable(msg)

	if not info.gameStartTime then
		if not info.stepId then
			local stepId = 0

			if not info.activityId then
				local activityId = 501001

				if stepId == TeenChampionKingController.PRELIMINARY or stepId == TeenChampionKingController.POINTS_RACE or stepId == TeenChampionKingController.EntertainmentStepId then
					UIStateManager.instance:popByName(ViewName.TCKMatchView)
					UIStateManager.instance:push(ViewName.TCKMatchView, activityId, stepId, msg)
					print("少年竞技王进入布阵")
				else
					self:tryShowMission(activityId, info.gameStartTime / 1000)
				end
			end
		end
	end
end

function TeenChampionKingController:setGameForm(activityId, simpleForm, gameRoundId)
	TeenChampionKingAgent.instance:sendPM_TeenCKSetGameFormReq(activityId, simpleForm, gameRoundId)
end

function TeenChampionKingController:handleSetGameForm(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKKnockoutSetGameFormation)
end

function TeenChampionKingController:handleNotifySetGameFormFail(msg)
	return
end

function TeenChampionKingController:handleNotifyOpSetFormFinish(msg)
	return
end

function TeenChampionKingController:handleNotifyTurnToNextGameRound(msg)
	local activityId = msg.activityId
	local gameRoundId = msg.gameRoundId
	local myForm = msg.myForm
	local opForm = msg.opForm

	if not msg.roundStartTimeMillis then
		local roundStartTimeMillis = 0
		local startTime = roundStartTimeMillis / 1000
		local opUseSysProperty = msg.opUseSysProperty
		local fmtMo = self._roundFmtMoMap[activityId]

		if not fmtMo then
			fmtMo = TCKKnockoutRoundFmtMo.New()
			self._roundFmtMoMap[activityId] = fmtMo
		end

		fmtMo:initParams(activityId, gameRoundId, myForm, opForm, startTime, opUseSysProperty)
		self:exitMission()
		UIStateManager.instance:push(ViewName.CustomMissionView, fmtMo)
	end
end

function TeenChampionKingController:handleNotifyGameEnd(msg)
	TeenChampionKingModel.instance:resetInRoomUserIds()

	local info = GameUtil.pbToTable(msg)
	local state = -1

	if info then
		state = info.state
	end

	local result = info.result

	if state == 1 then
		local activityId = msg.activityId
		local stepId = msg.stepId
		local roundId = TeenChampionKingConfig.instance:getRoundIdByStepId(activityId, stepId)

		UIJumper.instance:clear()

		if roundId >= TeenChampionKingController.ROUND_KNOCKOUT_MIN and roundId <= TeenChampionKingController.ROUND_QUARTERFINALS then
			UIJumper.instance:pushOneStack(ViewName.TCKKnockoutMainView, nil, activityId)
		elseif roundId >= TeenChampionKingController.ROUND_CHAMPIONSHIP_MIN and roundId <= TeenChampionKingController.ROUND_CHAMPIONSHIP_MAX then
			UIJumper.instance:pushOneStack(ViewName.TCKChampionshipView, nil, activityId)
		else
			UIJumper.instance:pushOneStack(ViewName.TCKQualifyView, nil, activityId, stepId)
		end

		local battleResult = msg.battleResult
		local teams = battleResult.originalStates.teams
		local teamId = 0
		local userId = checknumber(RoleModel.instance:getUserId())

		for _, v in ipairs(teams) do
			if userId == checknumber(v.playerView.id) then
				teamId = v.teamId

				break
			end
		end

		BattleModel.instance:setLeftTeamId(teamId)
		BattleController.instance:viewUserFightMonsterBtlResult(battleResult, false)
	elseif state == 2 then
		local showTips = result == -1 and "已退出，战斗失败" or "对方退出，战斗胜利"

		TipsFacade:openTipWindowNoX("提示", showTips, function()
			self:exitMission()
		end, "确定")
	elseif state == 3 then
		local showTips = result == -1 and "己方为空阵，战斗失败" or "敌方为空阵，战斗胜利"

		TipsFacade:openTipWindowNoX("提示", showTips, function()
			self:exitMission()
		end, "确定")
	elseif state == 4 then
		local showTips = result == -1 and "双方空阵，敌方战力较高，我方失败" or "双方空阵，我方战力较高，我方获胜"

		TipsFacade:openTipWindowNoX("提示", showTips, function()
			self:exitMission()
		end, "确定")
	else
		TipsFacade:openTipWindowNoX("提示", string.format("未能进入战斗，state：%s", state), function()
			self:exitMission()
		end, "确定")
	end

	self._isRoomLock = false
end

function TeenChampionKingController:exitMission()
	UIStateManager.instance:popByName(ViewName.FmtFeatureView)
	UIStateManager.instance:popByName(ViewName.CustomSummonPopView)
	UIStateManager.instance:popByName(ViewName.CustomMissionView)
end

function TeenChampionKingController:syncRoomInfo(activityId)
	TeenChampionKingAgent.instance:sendPM_TeenCKSyncRoomInfoReq(activityId)
end

function TeenChampionKingController:handleSyncRoomInfo(msg)
	return
end

function TeenChampionKingController:handleNotifySyncRoomInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_TCKKnockoutSyncRoomInfo, msg)
end

function TeenChampionKingController:leaveGame(activityId)
	TeenChampionKingAgent.instance:sendPM_TeenCKLeaveGameReq(activityId)
end

function TeenChampionKingController:handleLeaveGame(msg)
	return
end

function TeenChampionKingController:getRoundFmtMo(activityId)
	local fmtMo = self._roundFmtMoMap[activityId]

	if not fmtMo then
		fmtMo = TCKKnockoutRoundFmtMo.New()
		self._roundFmtMoMap[activityId] = fmtMo
	end

	return fmtMo
end

function TeenChampionKingController:_testFmtMo(activityId)
	self:tryShowMission(activityId, 0)
end

function TeenChampionKingController:checkAdjustPets(activityId)
	local globalInfo = TeenChampionKingModel.instance:getGlobalInfo(activityId)
	local curRoundId = TeenChampionKingConfig.instance:getRoundIdByStepId(activityId, (globalInfo or nil) and globalInfo.curStepId)
	local key = string.format("TCK_checkAdjustPets_%s_%s", activityId, curRoundId)
	local isNeed = checknumber(GameUtil.getUserData(key)) <= 0

	if isNeed then
		GameUtil.saveUserData(key, 1)

		return true
	end

	return false
end

function TeenChampionKingController:checkTogSystem(activityId)
	local key = string.format("TCKK_TogSystem_%s", activityId)

	return checknumber(GameUtil.getUserDayData(key)) <= 0
end

function TeenChampionKingController:saveTogSystem(activityId)
	local key = string.format("TCKK_TogSystem_%s", activityId)

	GameUtil.saveUserDayData(key, 1)
end

function TeenChampionKingController:getSummonMasterId(activityId)
	local key = string.format("TCK_SummonMasterId_%s", activityId)

	return checknumber(GameUtil.getUserData(key))
end

function TeenChampionKingController:getSummonMonsterId(activityId)
	local key = string.format("TCK_SummonMosterId_%s", activityId)

	return checknumber(GameUtil.getUserData(key))
end

function TeenChampionKingController:setSummonMasterId(activityId, id)
	local key = string.format("TCK_SummonMasterId_%s", activityId)

	GameUtil.saveUserData(key, id)
end

function TeenChampionKingController:setSummonMonsterId(activityId, id)
	local key = string.format("TCK_SummonMosterId_%s", activityId)

	GameUtil.saveUserData(key, id)
end

TeenChampionKingController.instance = TeenChampionKingController.New()

return TeenChampionKingController
