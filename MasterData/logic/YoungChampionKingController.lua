-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/controller/YoungChampionKingController.lua

module("logic.extensions.youngchampionking.controller.YoungChampionKingController", package.seeall)

local YoungChampionKingController = class("YoungChampionKingController", BaseController)

function YoungChampionKingController:ctor()
	return
end

function YoungChampionKingController:onReset()
	self.msgMap = {}
end

function YoungChampionKingController:onInit()
	GlobalDispatcher:addListener("enterYoungChampionKing", self.enterGameModule, self)
	GlobalDispatcher:addListener("Enter_Young_Champion_King_Room", self.enterRoomFormRd, self)
	GlobalDispatcher:addListener("test_Young_Champion_King_Knock_out_Fmt", self.testFmt, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_YCKStepChange, self._onStepChange, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_YCKMyKnockoutInfoRes, self._updateMyScheduleInfo, self)
	self:onReset()
end

function YoungChampionKingController:testFmt(param)
	local activityId = checknumber(param[1])
	local roundId = checknumber(param[2])

	if roundId == 1 then
		local fmtMo = YoungChampionKingModel.instance:getKnockoutFmtMo()

		fmtMo:initParams(activityId, 1)
		CustomFmtController.instance:showMissionView(fmtMo)
	else
		local fmtMo = YoungChampionKingModel.instance:getKnockoutRoundFmtMo()

		fmtMo:initParams(activityId, roundId)
		UIStateManager.instance:popByName(ViewName.FmtFeatureView)
		UIStateManager.instance:popByName(ViewName.CustomSummonPopView)
		UIStateManager.instance:popByName(ViewName.CustomMissionView)
		UIStateManager.instance:push(ViewName.CustomMissionView, fmtMo)
	end
end

function YoungChampionKingController:enterGameModule(param)
	local activityId = checknumber(param[1])

	if not ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.YoungChampionKing, activityId) then
		printError("少年竞技王活动未开启：" .. activityId)

		return
	end

	YoungChampionKingModel.instance:setCurActMo(activityId)

	local fakeStepId = self:getCurStepIdByTime()
	local fakeRoundId = self:getRoundIdByStepId(fakeStepId)

	if fakeRoundId == YoungChampionKingEnum.Display_Round_Id then
		UIStateManager.instance:push(ViewName.YoungchampionkingfinalshowView, activityId)
	else
		UIStateManager.instance:push(ViewName.YoungChampionKingMainView, activityId)
	end
end

function YoungChampionKingController:enterRoomFormRd()
	local curActId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.YoungChampionKing)

	YoungChampionKingModel.instance:setCurActMo(curActId)

	local fakeStepId = self:getCurStepIdByTime()
	local fakeRoundId = self:getRoundIdByStepId(fakeStepId)

	if fakeRoundId >= YoungChampionKingEnum.War_Zone_Start_Round_Id and fakeRoundId <= YoungChampionKingEnum.War_Zone_End_Round_Id then
		UIStateManager.instance:push(ViewName.YoungChampionKingKnockoutMainView, curActId, YoungChampionKingEnum.War_Zone_Start_Round_Id)
	else
		UIStateManager.instance:push(ViewName.YoungChampionKingKnockoutMainView, curActId, YoungChampionKingEnum.Champion_Start_Round_Id)
	end
end

function YoungChampionKingController:sendPM_YCKGetInfoReq(activityId)
	YoungChampionKingAgent.instance:sendPM_YCKGetInfoReq(activityId)
end

function YoungChampionKingController:handlePM_YCKGetInfoRes(msg)
	YoungChampionKingModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_YCKGetInfoRes)
end

function YoungChampionKingController:handlePM_YCKNotifyStepChangeRes(msg)
	local info = GameUtil.pbToTable(msg)

	GlobalDispatcher:dispatch(GlobalNotify.PM_YCKStepChange, info.curStepId)
end

function YoungChampionKingController:sendPM_YCKGetVideoReq(battleId)
	local trueBattleId = checknumber(battleId)

	YoungChampionKingAgent.instance:sendPM_YCKGetVideoReq(trueBattleId)
end

function YoungChampionKingController:handlePM_YCKGetVideoRes(msg)
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

	GlobalDispatcher:dispatch(GlobalNotify.PM_YCKGetVideoRes, callBack)
end

function YoungChampionKingController:sendPM_YCKGetQualifierInfoReq(activityId, stepId)
	YoungChampionKingAgent.instance:sendPM_YCKGetQualifierInfoReq(activityId, stepId)
end

function YoungChampionKingController:handlePM_YCKGetQualifierInfoRes(msg)
	YoungChampionKingModel.instance:onGetQualifierInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_YCKQualifierGetInfoRes)
end

function YoungChampionKingController:sendPM_YCKGetDefenseForamtionReq(activityId)
	YoungChampionKingAgent.instance:sendPM_YCKGetDefenseForamtionReq(activityId)
end

function YoungChampionKingController:handlePM_YCKGetDefenseForamtionRes(msg)
	YoungChampionKingModel.instance:onGetDefenseForamtion(msg)
end

function YoungChampionKingController:sendPM_YCKSetDefenseForamtionReq(simpleForm)
	YoungChampionKingAgent.instance:sendPM_YCKSetDefenseForamtionReq(simpleForm)
end

function YoungChampionKingController:handlePM_YCKSetDefenseForamtionRes(msg)
	YoungChampionKingModel.instance:onSetDefenseForamtion(msg)
	TipsFacade.instance:openCommonTips("保存成功")
end

function YoungChampionKingController:sendPM_YCKQualifierGetNewOpponentReq(activityId, stepId)
	YoungChampionKingAgent.instance:sendPM_YCKQualifierGetNewOpponentReq(activityId, stepId)
end

function YoungChampionKingController:handlePM_YCKQualifierGetNewOpponentRes(msg)
	YoungChampionKingModel.instance:onQualifierGetNewOpponent(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_YCKQualifierGetNewOpponentRes)
end

function YoungChampionKingController:sendPM_YCKQualifierFightReq(activityId, stepId, simpleForm)
	YoungChampionKingAgent.instance:sendPM_YCKQualifierFightReq(activityId, stepId, simpleForm)
end

function YoungChampionKingController:handlePM_YCKQualifierFightRes(msg)
	local info = GameUtil.pbToTable(msg)
	local qualifierInfo = YoungChampionKingModel.instance:getQualifierInfo(info.activityId, info.stepId)

	if not qualifierInfo.rankScore then
		local lastScore = 0

		YoungChampionKingModel.instance:onQualifierFight(msg)
		UIJumper.instance:clear()
		UIJumper.instance:pushOneStack(ViewName.YoungChampionKingMainView, nil)
		UIJumper.instance:pushOneStack(ViewName.YoungChampionKingQualifyView, nil, info.activityId, info.stepId)

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

		local isWin = info.isWin

		if isWin then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
		end

		BattleModel.instance:setLeftTeamId(teamId)

		local params = {
			oldScore = lastScore,
			newScore = info.score,
			stepId = info.stepId
		}

		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.YoungChampionKingQualifier, params)
		BattleFacade.instance:registerResultHandler(nil, nil)
		BattleFacade.instance:registerResultHandler(function()
			BattleFacade.instance:registerResultHandler(nil, nil)

			if isWin then
				ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
			else
				ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
			end

			return true
		end, self)
		BattleController.instance:viewUserFightMonsterBtlResult(battleResult, false)
	end
end

function YoungChampionKingController:sendPM_YCKQualifierRecordsReq(activityId)
	YoungChampionKingAgent.instance:sendPM_YCKQualifierRecordsReq(activityId)
end

function YoungChampionKingController:handlePM_YCKQualifierRecordsRes(msg)
	YoungChampionKingModel.instance:onQualifierRecords(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_YCKQualifierRecords)
end

function YoungChampionKingController:sendPM_YCKQualifierRankInfoReq(activityId, zoneId, stepId)
	YoungChampionKingAgent.instance:sendPM_YCKQualifierRankInfoReq(activityId, zoneId, stepId)
end

function YoungChampionKingController:handlePM_YCKQualifierRankInfoRes(msg)
	YoungChampionKingModel.instance:onQualifierRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_YCKQualifierRankRes)
end

function YoungChampionKingController:sendPM_YCKQualifierPetRaceRankReq(activityId, stepId, winRank)
	YoungChampionKingAgent.instance:sendPM_YCKQualifierPetRaceRankReq(activityId, stepId, winRank)
end

function YoungChampionKingController:handlePM_YCKQualifierPetRaceRankRes(msg)
	YoungChampionKingModel.instance:onQualifierPetRaceRank(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_YCKQualifierRankRes)
end

function YoungChampionKingController:sendPM_YCKMyKnockoutInfoReq(activityId)
	YoungChampionKingAgent.instance:sendPM_YCKMyKnockoutInfoReq(activityId)
end

function YoungChampionKingController:handlePM_YCKMyKnockoutInfoRes(msg)
	YoungChampionKingModel.instance:onMyKnockoutInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_YCKMyKnockoutInfoRes)
end

function YoungChampionKingController:sendPM_YCKGetKnockoutScheduleReq(activityId, viewGroupId, roundId)
	YoungChampionKingAgent.instance:sendPM_YCKGetKnockoutScheduleReq(activityId, viewGroupId, roundId)
end

function YoungChampionKingController:handlePM_YCKGetKnockoutScheduleRes(msg)
	YoungChampionKingModel.instance:onGetKnockoutSchedule(msg)

	local info = GameUtil.pbToTable(msg)

	GlobalDispatcher:dispatch(GlobalNotify.PM_YCKGetKnockoutScheduleRes, info.viewGroupId)
end

function YoungChampionKingController:sendPM_YCKGetGuessRecordReq(activityId, roundId)
	YoungChampionKingAgent.instance:sendPM_YCKGetGuessRecordReq(activityId, roundId)
end

function YoungChampionKingController:handlePM_YCKGetGuessRecordRes(msg)
	YoungChampionKingModel.instance:onGetGuessRecord(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_YCKGetGuessRecordRes)
end

function YoungChampionKingController:sendPM_YCKGuessReq(activityId, targetPlayerId, guessNum, viewGroupId, roundId, index)
	self._guessViewGroupId = viewGroupId
	self._guessIndex = index
	self._guessRoundId = roundId

	YoungChampionKingAgent.instance:sendPM_YCKGuessReq(activityId, targetPlayerId, guessNum)
end

function YoungChampionKingController:handlePM_YCKGuessRes(msg)
	YoungChampionKingModel.instance:onGuess(msg, self._guessViewGroupId, self._guessRoundId, self._guessIndex)
	GlobalDispatcher:dispatch(GlobalNotify.PM_YCKGetGuessRes)
end

function YoungChampionKingController:sendPM_YCKGainGuessCoinReq(activityId)
	YoungChampionKingAgent.instance:sendPM_YCKGainGuessCoinReq(activityId)
end

function YoungChampionKingController:handlePM_YCKGainGuessCoinRes(msg)
	YoungChampionKingModel.instance:onGainGuessCoin(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_YCKGainGuessCoinRes)
end

function YoungChampionKingController:sendPM_YCKGetDisplayInfoReq(activityId)
	YoungChampionKingAgent.instance:sendPM_YCKGetDisplayInfoReq(activityId)
end

function YoungChampionKingController:handlePM_YCKGetDisplayInfoRes(msg)
	YoungChampionKingModel.instance:onGetDisplayInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_YCKGetDisplayInfoRes)
end

function YoungChampionKingController:sendPM_YCKKnockoutGetFormationReq()
	YoungChampionKingAgent.instance:sendPM_YCKKnockoutGetFormationReq()
end

function YoungChampionKingController:handlePM_YCKKnockoutGetFormationRes(msg)
	YoungChampionKingModel.instance:onKnockoutGetFormation(msg)
end

function YoungChampionKingController:sendPM_YCKKnockoutSetFormationReq(forms)
	YoungChampionKingAgent.instance:sendPM_YCKKnockoutSetFormationReq(forms)
end

function YoungChampionKingController:handlePM_YCKKnockoutSetFormationRes(msg)
	YoungChampionKingModel.instance:onKnockoutSetFormation(msg)
	TipsFacade.instance:openCommonTips("保存成功")
end

function YoungChampionKingController:sendPM_YCKKnockoutJoinRoomInfoReq(activityId, stepId, groupId)
	YoungChampionKingAgent.instance:sendPM_YCKKnockoutJoinRoomInfoReq(activityId, stepId, groupId)
end

function YoungChampionKingController:handlePM_YCKKnockoutJoinRoomInfoRes(msg)
	YoungChampionKingModel.instance:onGetKnockoutJoinRoomInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_YCKKnockoutRoomStausUpdate)
end

function YoungChampionKingController:sendPM_YCKKnockoutJoinRoomReq(activityId, stepId, groupId)
	YoungChampionKingAgent.instance:sendPM_YCKKnockoutJoinRoomReq(activityId, stepId, groupId)
end

function YoungChampionKingController:handlePM_YCKKnockoutJoinRoomRes(msg)
	YoungChampionKingModel.instance:onKnockoutJoinRoom(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_YCKKnockoutRoomStausUpdate)
end

function YoungChampionKingController:sendPM_YCKKnockoutLeaveRoomReq()
	YoungChampionKingAgent.instance:sendPM_YCKKnockoutLeaveRoomReq()
end

function YoungChampionKingController:handlePM_YCKKnockoutLeaveRoomRes(msg)
	YoungChampionKingModel.instance:onKnockoutLeaveRoom(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_YCKKnockoutRoomStausUpdate)
end

function YoungChampionKingController:handlePM_NotifyYCKKnockoutOpJoinRoomRes(msg)
	YoungChampionKingModel.instance:onNotifyYCKKnockoutOpJoinRoom(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_YCKKnockoutRoomStausUpdate)
end

function YoungChampionKingController:handlePM_NotifyYCKKnockoutFightStartRes(msg)
	YoungChampionKingModel.instance:onNotifyYCKKnockoutFightStart(msg)

	local fmtMo = YoungChampionKingModel.instance:getKnockoutFmtMo()

	fmtMo:initParams(msg.activityId, msg.gameRoundId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function YoungChampionKingController:sendPM_YCKKnockoutSetGameFormationReq(activityId, simpleForm)
	YoungChampionKingAgent.instance:sendPM_YCKKnockoutSetGameFormationReq(activityId, simpleForm)
end

function YoungChampionKingController:handlePM_YCKKnockoutSetGameFormationRes(msg)
	YoungChampionKingModel.instance:onKnockoutSetGameFormation(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_YCKKnockoutSetGameFormation)
end

function YoungChampionKingController:handlePM_NotifyYCKKnockoutOpSetFormationFinishRes(msg)
	YoungChampionKingModel.instance:onNotifyYCKKnockoutOpSetFormationFinish(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_YCKKnockoutOpSetFormationFinish)
end

function YoungChampionKingController:handlePM_NotifyYCKKnockoutTurnToNextGameRoundRes(msg)
	YoungChampionKingModel.instance:onNotifyYCKKnockoutTurnToNextGameRound(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_YCKKnockoutTurnToNextGameRound)

	local fmtMo = YoungChampionKingModel.instance:getKnockoutRoundFmtMo()
	local activityId = YoungChampionKingModel.instance:getCurActId()

	fmtMo:initParams(activityId, msg.gameRoundId, msg.myForm, msg.opForm)
	UIStateManager.instance:popByName(ViewName.FmtFeatureView)
	UIStateManager.instance:popByName(ViewName.CustomSummonPopView)
	UIStateManager.instance:popByName(ViewName.CustomMissionView)
	UIStateManager.instance:push(ViewName.CustomMissionView, fmtMo)
end

function YoungChampionKingController:sendPM_YCKKnockoutSyncRoomInfoReq(activityId)
	YoungChampionKingAgent.instance:sendPM_YCKKnockoutSyncRoomInfoReq(activityId)
end

function YoungChampionKingController:handlePM_YCKKnockoutSyncRoomInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_YCKKnockoutSyncRoomInfo, msg)
end

function YoungChampionKingController:handlePM_NotifyYCKKnockoutGameEndRes(msg)
	UIJumper.instance:clear()
	UIJumper.instance:pushOneStack(ViewName.YoungChampionKingMainView, nil)

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
end

function YoungChampionKingController:handlePM_NotifyYCKKnockoutOpInvitedRes(msg)
	YoungChampionKingModel.instance:onNotifyYCKKnockoutOpInvited(msg)
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

function YoungChampionKingController:_tryAcceptInvite(params)
	local info = params.info
	local headInfo = info.headInfo
	local stepId = info.stepId
	local activityId = info.activityId

	YoungChampionKingModel.instance:setCurActMo(activityId)

	local roundId = self:getRoundIdByStepId(stepId)

	if roundId >= YoungChampionKingEnum.War_Zone_Start_Round_Id and roundId <= YoungChampionKingEnum.War_Zone_End_Round_Id then
		UIStateManager.instance:push(ViewName.YoungChampionKingKnockoutMainView, activityId, YoungChampionKingEnum.War_Zone_Start_Round_Id)
	elseif roundId >= YoungChampionKingEnum.Champion_Start_Round_Id and roundId <= YoungChampionKingEnum.Champion_End_Round_Id then
		UIStateManager.instance:push(ViewName.YoungChampionKingKnockoutMainView, activityId, YoungChampionKingEnum.Champion_Start_Round_Id)
	end

	self:_tryUnregPopupMsg(headInfo.userId)
end

function YoungChampionKingController:_tryUnregPopupMsg(userId)
	local key = self.msgMap[userId]

	MainUIPopupMsgController.instance:removePopMsg(key)

	self.msgMap[userId] = nil
end

function YoungChampionKingController:getRoundCfgByStepId(stepId)
	local activityId = YoungChampionKingModel.instance:getCurActId()
	local stepCfg = YoungChampionKingConfig.instance:getStepCfg(activityId, stepId)

	return YoungChampionKingConfig.instance:getRoundCfg(activityId, stepCfg.roundId)
end

function YoungChampionKingController:getRoundIdByStepId(stepId)
	if stepId == YoungChampionKingEnum.Entertainment_Step_Id then
		print("娱乐赛没有轮次ID")

		return "战区预选赛-娱乐"
	end

	local cfg = self:getRoundCfgByStepId(stepId)

	return (cfg or nil) and (cfg.roundId or 1)
end

function YoungChampionKingController:getCurRoundNameByStepId(stepId)
	if stepId == YoungChampionKingEnum.Entertainment_Step_Id then
		return "娱乐赛"
	end

	local cfg = self:getRoundCfgByStepId(stepId)

	return (cfg or nil) and (cfg.roundName or "")
end

function YoungChampionKingController:getIsOpEntertainmentStepId(stepId)
	local startStepId = YoungChampionKingEnum.Entertainment_Start_Step_Id

	return startStepId <= stepId
end

function YoungChampionKingController:getStartTimeByStepId(stepId)
	local activityId = YoungChampionKingModel.instance:getCurActId()
	local startTimeStr = ""

	if stepId == YoungChampionKingEnum.Entertainment_Step_Id then
		local startStepId = YoungChampionKingEnum.Entertainment_Start_Step_Id
		local stepCfg = YoungChampionKingConfig.instance:getStepCfg(activityId, startStepId)

		startTimeStr = stepCfg.startTime
	else
		local stepCfg = YoungChampionKingConfig.instance:getStepCfg(activityId, stepId)

		startTimeStr = stepCfg.startTime
	end

	return GameUtil.string2time(startTimeStr)
end

function YoungChampionKingController:getEndTimeByStepId(stepId)
	local activityId = YoungChampionKingModel.instance:getCurActId()
	local actStartTime, actEndTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.YoungChampionKing, activityId)
	local endTime = actEndTime

	if stepId == YoungChampionKingEnum.Entertainment_Step_Id then
		-- block empty
	else
		local roundId = self:getRoundIdByStepId(stepId)

		if roundId == YoungChampionKingEnum.Display_Round_Id then
			-- block empty
		else
			local nextStepCfg = YoungChampionKingConfig.instance:getStepCfg(activityId, stepId + 1)

			endTime = GameUtil.string2time(nextStepCfg.startTime)
		end
	end

	return endTime
end

function YoungChampionKingController:getStartTimeAndEndTimeByStepId(stepId)
	local startTime = self:getStartTimeByStepId(stepId)
	local endTime = self:getEndTimeByStepId(stepId)

	return startTime, endTime
end

function YoungChampionKingController:getCurStepIdByTime()
	local timeNow = ServerTime.now()
	local activityId = YoungChampionKingModel.instance:getCurActId()
	local stepCfgs = YoungChampionKingConfig.instance:getStepCfgs(activityId)
	local curStepId = 1

	for stepId, cfg in ipairs(stepCfgs) do
		local startTime = self:getStartTimeByStepId(stepId)

		if startTime < timeNow then
			curStepId = stepId
		else
			break
		end
	end

	return curStepId
end

function YoungChampionKingController:getCurLeftChanllegeTimes(stepId)
	local activityId = YoungChampionKingModel.instance:getCurActId()
	local matchCfgs = YoungChampionKingConfig.instance:getQualifyMatchCfgs(activityId, stepId)

	return (matchCfgs or nil) and #matchCfgs - YoungChampionKingModel.instance:getCurFightTimes(stepId)
end

function YoungChampionKingController:getCurLeftQualifierChanllegeTimes(stepId)
	local activityId = YoungChampionKingModel.instance:getCurActId()
	local matchCfgs = YoungChampionKingConfig.instance:getQualifyMatchCfgs(activityId, stepId)
	local info = YoungChampionKingModel.instance:getQualifierInfo(activityId, stepId)

	return (matchCfgs or nil) and #matchCfgs - info.dailyFightTimes
end

function YoungChampionKingController:getCurZoneId()
	local activityId = YoungChampionKingModel.instance:getCurActId()
	local areaId = RoleModel.instance:getAreaId()
	local zoneCfg = YoungChampionKingConfig.instance:getWarZoneCfg(activityId, areaId)

	return (zoneCfg or nil) and (zoneCfg.zoneId or -1)
end

function YoungChampionKingController:getCurZoneName()
	local activityId = YoungChampionKingModel.instance:getCurActId()
	local areaId = RoleModel.instance:getAreaId()
	local zoneCfg = YoungChampionKingConfig.instance:getWarZoneCfg(activityId, areaId)

	return (zoneCfg or nil) and (zoneCfg.name or "")
end

function YoungChampionKingController:getIsAbleEnterQualifyFight(stepId)
	local activityId = YoungChampionKingModel.instance:getCurActId()
	local tips = {
		[0] = "正常进入",
		[-3] = "不在阶段时间",
		[-1] = "不存在预赛配置",
		[-2] = "今日挑战次数已耗尽",
		[-4] = "进入结算阶段"
	}
	local baseCfg = YoungChampionKingConfig.instance:getQualifyBaseCfg(activityId, stepId)
	local resultCode = 0

	if baseCfg then
		local leftTimes = self:getCurLeftQualifierChanllegeTimes(stepId)

		if leftTimes <= 0 then
			-- block empty
		else
			local timeNow = ServerTime.now()
			local startTime, endTime = self:getStartTimeAndEndTimeByStepId(stepId)

			if startTime <= timeNow and timeNow <= endTime then
				local trueEndTime = endTime - baseCfg.endEarly * 60

				resultCode = timeNow <= trueEndTime and 0 or -4
			else
				resultCode = -3
			end
		end
	else
		resultCode = -1
	end

	return resultCode == 0, resultCode, tips[resultCode]
end

function YoungChampionKingController:getKnockoutScheduleMatchInfo(roundId, groupId, matchId)
	local activityId = YoungChampionKingModel.instance:getCurActId()
	local startRoundId = roundId

	if roundId <= YoungChampionKingEnum.Common_Knockout_32To16_Id and roundId >= YoungChampionKingEnum.Common_Knockout_128To64_Id then
		startRoundId = YoungChampionKingEnum.Common_Knockout_128To64_Id
	elseif roundId <= YoungChampionKingEnum.Common_Knockout_8To4_Id and roundId >= YoungChampionKingEnum.Common_Knockout_16To8_Id then
		startRoundId = YoungChampionKingEnum.Common_Knockout_16To8_Id
	end

	local info = YoungChampionKingModel.instance:getKnockoutScheduleInfo(activityId, startRoundId, groupId)

	if not info then
		return
	end

	return info.matchInfoMap[roundId] and info.matchInfoMap[roundId][matchId]
end

function YoungChampionKingController:loadKnockoutInfo()
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_YOUNG_CHAMPION_KING_SCHEDULE, false, true)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_YOUNG_CHAMPION_KING_MY_SCHEDULE, false, true)

	local curActId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.YoungChampionKing)

	if curActId > 0 then
		YoungChampionKingModel.instance:setCurActMo(curActId)

		local fakeStepId = self:getCurStepIdByTime()
		local fakeRoundId = self:getRoundIdByStepId(fakeStepId)

		if fakeRoundId >= YoungChampionKingEnum.Common_Knockout_128To64_Id and fakeRoundId <= YoungChampionKingEnum.Final_Match_Round_Id then
			YoungChampionKingController.instance:sendPM_YCKMyKnockoutInfoReq(curActId)

			local curStepCfg = YoungChampionKingConfig.instance:getStepCfg(curActId, fakeStepId)

			if not curStepCfg.canGuss then
				local nextRoundStartStepId = fakeStepId + 1

				if fakeRoundId == YoungChampionKingEnum.Third_Place_Match_Round_Id then
					nextRoundStartStepId = 19
				elseif fakeRoundId == YoungChampionKingEnum.Final_Match_Round_Id then
					nextRoundStartStepId = 23
				end

				local showEndTime = self:getStartTimeByStepId(nextRoundStartStepId)

				RedPointController.instance:setRedPointInfo(RedPointModel.ID_YOUNG_CHAMPION_KING_SCHEDULE, true, true, 0, showEndTime)
			end
		end
	end
end

function YoungChampionKingController:_onStepChange(stepId)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_YOUNG_CHAMPION_KING_SCHEDULE, false, true)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_YOUNG_CHAMPION_KING_MY_SCHEDULE, false, true)

	local curActId = YoungChampionKingModel.instance:getCurActId()
	local curRoundId = self:getRoundIdByStepId(stepId)

	if curRoundId >= YoungChampionKingEnum.Common_Knockout_128To64_Id and curRoundId <= YoungChampionKingEnum.Final_Match_Round_Id then
		YoungChampionKingController.instance:sendPM_YCKMyKnockoutInfoReq(curActId)

		local curStepCfg = YoungChampionKingConfig.instance:getStepCfg(curActId, stepId)

		if not curStepCfg.canGuss then
			local nextRoundStartStepId = stepId + 1

			if curRoundId == YoungChampionKingEnum.Third_Place_Match_Round_Id then
				nextRoundStartStepId = 19
			elseif curRoundId == YoungChampionKingEnum.Final_Match_Round_Id then
				nextRoundStartStepId = 23
			end

			local showEndTime = self:getStartTimeByStepId(nextRoundStartStepId)

			RedPointController.instance:setRedPointInfo(RedPointModel.ID_YOUNG_CHAMPION_KING_SCHEDULE, true, true, 0, showEndTime)
		end
	end

	YoungChampionKingController.instance:sendPM_YCKMyKnockoutInfoReq(curActId)
end

function YoungChampionKingController:_updateMyScheduleInfo()
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_YOUNG_CHAMPION_KING_MY_SCHEDULE, false, true)

	local curActId = YoungChampionKingModel.instance:getCurActId()
	local curStepId = YoungChampionKingModel.instance:getCurStepId()

	if curStepId <= 1 then
		curStepId = self:getCurStepIdByTime()
	end

	local curRoundId = YoungChampionKingController.instance:getRoundIdByStepId(curStepId)
	local myInfo = YoungChampionKingModel.instance:getCurKnockoutInfo()
	local myRoundId = myInfo and myInfo.roundId

	if curRoundId <= checknumber(myRoundId) then
		local curStepCfg = YoungChampionKingConfig.instance:getStepCfg(curActId, curStepId)

		if not curStepCfg.canGuss then
			local nextRoundStartStepId = curStepId + 1

			if curRoundId == YoungChampionKingEnum.Third_Place_Match_Round_Id then
				nextRoundStartStepId = 19
			elseif curRoundId == YoungChampionKingEnum.Final_Match_Round_Id then
				nextRoundStartStepId = 23
			end

			local showEndTime = self:getStartTimeByStepId(nextRoundStartStepId)

			RedPointController.instance:setRedPointInfo(RedPointModel.ID_YOUNG_CHAMPION_KING_MY_SCHEDULE, true, true, 0, showEndTime)
		end
	end
end

YoungChampionKingController.instance = YoungChampionKingController.New()

return YoungChampionKingController
