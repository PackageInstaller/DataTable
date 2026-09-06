-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/controller/MartialContestController.lua

module("logic.extensions.martialcontest.controller.MartialContestController", package.seeall)

local MartialContestController = class("MartialContestController", BaseController)

function MartialContestController:onInit()
	MartialContestController.super.onInit(self)
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self._onStartEnterGame, self)
	GlobalDispatcher:addListener(GlobalNotify.MCFinalsInfoRes, self._onMCFinalsInfoRes, self)

	self._cacheStepTimeStamps = {}

	self:onReset()
end

function MartialContestController:onReset()
	self.openingList = {}
	self.openIndexPool = {}
	self.index = 0
	self._cacheFinalsStepId = 0
	self._blockGetFinalsInfo = false
end

function MartialContestController:_onStartEnterGame()
	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.MartialContest)

	if activityId > 0 then
		local stepId = MartialContestController.instance:getStepIdByNowTime(activityId)

		if self:_isInFinalStep(activityId, stepId) then
			MartialContestAgent.instance:sendPM_MCFinalsInfoReq(activityId)
		end
	end
end

function MartialContestController:_onMCFinalsInfoRes()
	local redId = RedPointModel.ID_Martialcontestfinal
	local msg = MartialContestModel.instance:getFinalsInfoMsg()

	if msg then
		local activityId = msg.activityId
		local info = msg.info
		local stepCfg = MartialContestConfig.instance:getStepCfg(activityId, info.curStepId)

		if stepCfg and stepCfg.processorTarget ~= MartialContestEnum.FINALS_BATTLE then
			local nextStepCfg = MartialContestConfig.instance:getStepCfg(activityId, info.curStepId + 1)

			if nextStepCfg and nextStepCfg.processorTarget == MartialContestEnum.FINALS_BATTLE then
				local isActive = false

				if not info.allPlayers then
					local myUId = tostring(RoleModel.instance:getUserId())

					for i, v in ipairs(info.allPlayers) do
						if v.headInfo.headInfo.userId == myUId then
							isActive = true

							break
						end
					end

					if isActive then
						local endTime = GameUtil.string2time(nextStepCfg.startTime)

						if endTime - ServerTime.now() <= 900 then
							RedPointController.instance:setRedPointInfo(redId, true, true, 0, endTime)

							return
						end
					end
				end
			end
		end
	end

	RedPointController.instance:setRedPointInfo(redId, false)
end

function MartialContestController:handlePM_MCNotifyFinalsResultRes(msg)
	return
end

function MartialContestController:getStepIdByNowTime(activityId)
	if #self._cacheStepTimeStamps <= 0 then
		local stepCfgs = MartialContestConfig.instance:getStepCfgs(activityId)

		for i, v in ipairs(stepCfgs) do
			local data = {
				timeStamp = GameUtil.string2time(v.startTime),
				stepCfg = v
			}

			table.insert(self._cacheStepTimeStamps, data)
		end

		table.sort(self._cacheStepTimeStamps, function(a, b)
			return a.timeStamp < b.timeStamp
		end)
	end

	local nowTime = ServerTime.now()

	for i = #self._cacheStepTimeStamps, 2, -1 do
		local data = self._cacheStepTimeStamps[i]
		local preData = self._cacheStepTimeStamps[i - 1]

		if nowTime < data.timeStamp and nowTime >= preData.timeStamp then
			return preData.stepCfg.stepId
		end
	end

	return -1
end

function MartialContestController:getRoundIdByNowTime(activityId)
	if #self._cacheStepTimeStamps <= 0 then
		local stepCfgs = MartialContestConfig.instance:getStepCfgs(activityId)

		for i, v in ipairs(stepCfgs) do
			local data = {
				timeStamp = GameUtil.string2time(v.startTime),
				stepCfg = v
			}

			table.insert(self._cacheStepTimeStamps, data)
		end

		table.sort(self._cacheStepTimeStamps, function(a, b)
			return a.timeStamp < b.timeStamp
		end)
	end

	local nowTime = ServerTime.now()

	for i = #self._cacheStepTimeStamps, 2, -1 do
		local data = self._cacheStepTimeStamps[i]
		local preData = self._cacheStepTimeStamps[i - 1]

		if nowTime < data.timeStamp and nowTime >= preData.timeStamp then
			return preData.stepCfg.roundId
		end
	end

	return -1
end

function MartialContestController:getStepCfgByNowTime(activityId)
	if #self._cacheStepTimeStamps <= 0 then
		local stepCfgs = MartialContestConfig.instance:getStepCfgs(activityId)

		for i, v in ipairs(stepCfgs) do
			local data = {
				timeStamp = GameUtil.string2time(v.startTime),
				stepCfg = v
			}

			table.insert(self._cacheStepTimeStamps, data)
		end

		table.sort(self._cacheStepTimeStamps, function(a, b)
			return a.timeStamp < b.timeStamp
		end)
	end

	local nowTime = ServerTime.now()

	for i = #self._cacheStepTimeStamps, 2, -1 do
		local data = self._cacheStepTimeStamps[i]
		local preData = self._cacheStepTimeStamps[i - 1]

		if nowTime < data.timeStamp and nowTime >= preData.timeStamp then
			return preData.stepCfg
		end
	end

	return nil
end

function MartialContestController:getFinalsRoundDesc(activityId, stepId, roundId)
	local roundCfg = MartialContestConfig.instance:getRoundCfg(activityId, roundId)
	local stepCfgs = MartialContestConfig.instance:getStepCfgsByRoundId(activityId, roundId)
	local roundNum = 1
	local matchNum = 0

	if roundCfg.roundType == "FINALS_COMMON" then
		roundNum = 1
	elseif roundCfg.roundType == "FINALS_3V3" then
		roundNum = 2
	elseif roundCfg.roundType == "FINALS_BUFF" then
		roundNum = 3
	end

	for i, v in ipairs(stepCfgs) do
		if v.finalsScore <= 0 then
			matchNum = matchNum + 1
		end

		if v.stepId == stepId then
			break
		end
	end

	return string.format("第%s场 第%s轮", roundNum, matchNum)
end

function MartialContestController:getFinalRoundDescByRoundId(activityId, stepId, roundId)
	local roundCfg = MartialContestConfig.instance:getRoundCfg(activityId, roundId)
	local stepCfgs = MartialContestConfig.instance:getStepCfgs(activityId)
	local battleCount = 1
	local lastIsBattle = false

	for i, v in ipairs(stepCfgs) do
		if stepId >= v.stepId and v.roundId == roundId then
			lastIsBattle = false

			if v.processorTarget == "FINALS_BATTLE" then
				battleCount = battleCount + 1
				lastIsBattle = true
			end
		end
	end

	if lastIsBattle then
		battleCount = battleCount - 1
	end

	return string.format("第%s轮", battleCount)
end

function MartialContestController:getFinalsBuffPointLeft(activityId, stepId)
	local stepCfg = MartialContestConfig.instance:getStepCfg(activityId, stepId)
	local buffIds = MartialContestModel.instance:getFinalsBuffIds(activityId) or {}

	return math.max(0, stepCfg.finalsBuffNum - #buffIds)
end

function MartialContestController:getFinalsFmtBuffMap(activityId)
	local buffIds = MartialContestModel.instance:getFinalsBuffIds(activityId) or {}
	local fmtBuffMap = {}

	for i, v in ipairs(buffIds) do
		fmtBuffMap[v] = v
	end

	return fmtBuffMap
end

function MartialContestController:handlePM_MCGetInfoRes(msg)
	MartialContestModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MCGetInfoRes)
end

function MartialContestController:getCurZoneId(activityId)
	local areaId = RoleModel.instance:getAreaId()
	local zoneCfg = MartialContestConfig.instance:getWarZoneCfg(activityId, areaId)

	return (zoneCfg or nil) and (zoneCfg.zoneId or -1)
end

function MartialContestController:getCurZoneName(activityId)
	local areaId = RoleModel.instance:getAreaId()
	local zoneCfg = MartialContestConfig.instance:getWarZoneCfg(activityId, areaId)

	return (zoneCfg or nil) and (zoneCfg.name or "")
end

function MartialContestController:openEquipTips(go, activityId, equipId, lv)
	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(go)
	local viewName = ViewName.MartialContestEquipTipView
	local viewMgr = ViewMgr.instance

	if viewMgr:isOpen(viewName) then
		self.openingList[viewName] = nil
		self.openIndexPool[viewName] = nil

		UIStateManager.instance:popByName(viewName)
	end

	viewMgr:registerNotifyView(viewName)

	self.openingList[viewName] = true
	self.index = self.index + 1
	self.openIndexPool[viewName] = self.index

	local data = {
		activityId = activityId,
		id = equipId,
		lv = lv
	}

	viewMgr:open(viewName, data, pos, sizeDelta)
end

function MartialContestController:getIsAbleEnterQualifyFight(activityId, stepId)
	local tips = {
		[0] = "正常进入",
		[-3] = "不在阶段时间",
		[-1] = "不存在预赛配置",
		[-2] = "今日挑战次数已耗尽",
		[-4] = "进入结算阶段"
	}
	local baseCfg = MartialContestConfig.instance:getQualifierCfg(activityId, stepId)
	local resultCode = 0

	if baseCfg then
		local leftTimes = self:getCurLeftQualifierChanllegeTimes(activityId, stepId)

		if leftTimes <= 0 then
			-- block empty
		else
			local timeNow = ServerTime.now()
			local startTime, endTime = self:getStartTimeAndEndTimeByStepId(activityId, stepId)

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

function MartialContestController:getCurLeftQualifierChanllegeTimes(activityId, stepId)
	local qualifierCfg = MartialContestConfig.instance:getQualifierCfg(activityId, stepId)

	if not qualifierCfg then
		return 0
	end

	local matchCfgs = MartialContestConfig.instance:getQualifierMatchCfgs(qualifierCfg.quaMatchingPlanId)
	local fightTime = MartialContestModel.instance:getQualifierFightTime(activityId, stepId)

	return (matchCfgs or nil) and math.max(#matchCfgs - fightTime, 0)
end

function MartialContestController:getEndTimeByStepId(activityId, stepId)
	local actStartTime, actEndTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.MartialContest, activityId)
	local endTime = actEndTime

	if stepId == MartialContestEnum.Entertainment_Step_Id then
		-- block empty
	else
		local nextStepCfg = MartialContestConfig.instance:getStepCfg(activityId, stepId + 1)

		if nextStepCfg then
			endTime = GameUtil.string2time(nextStepCfg.startTime)
		end
	end

	return endTime
end

function MartialContestController:getStartTimeByStepId(activityId, stepId)
	local startTimeStr = ""

	if stepId == MartialContestEnum.Entertainment_Step_Id then
		local startStepId = MartialContestEnum.Entertainment_Start_Step_Id
		local stepCfg = MartialContestConfig.instance:getStepCfg(activityId, startStepId)

		startTimeStr = stepCfg.startTime
	else
		local stepCfg = MartialContestConfig.instance:getStepCfg(activityId, stepId)

		startTimeStr = stepCfg.startTime
	end

	return GameUtil.string2time(startTimeStr)
end

function MartialContestController:getStartTimeAndEndTimeByStepId(activityId, stepId)
	local startTime = self:getStartTimeByStepId(activityId, stepId)
	local endTime = self:getEndTimeByStepId(activityId, stepId)

	return startTime, endTime
end

function MartialContestController:sendPM_MCSetQualifierDefenseForamtionReq(activityId, simpleForm, equipList)
	local form = MartialContestExtension_pb.MCFinalsSetFormNO()

	form.formId = 1

	form.simpleForm:ParseFromString(simpleForm:SerializeToString())

	for i, v in ipairs(equipList) do
		local equip = MartialContestExtension_pb.MCFormEquip()

		equip.petId = v.petId
		equip.equipId = v.equipId

		local equipAdd = form.equips:add()

		equipAdd:ParseFromString(equip:SerializeToString())
	end

	MartialContestAgent.instance:sendPM_MCSetDefenseForamtionReq(activityId, form)
end

function MartialContestController:sendPM_MCScoreSetFormationReq(activityId, simpleForms)
	local forms = {}

	for i, v in ipairs(simpleForms) do
		local form = MartialContestExtension_pb.MCFinalsSetFormNO()

		form.formId = v.formId

		form.simpleForm:ParseFromString(v.simpleForm:SerializeToString())

		for i, equipInfo in ipairs(v.equipList) do
			local equip = MartialContestExtension_pb.MCFormEquip()

			equip.petId = equipInfo.petId
			equip.equipId = equipInfo.equipId

			local equipAdd = form.equips:add()

			equipAdd:ParseFromString(equip:SerializeToString())
		end

		table.insert(forms, form)
	end

	MartialContestAgent.instance:sendPM_MCFinalsSetFormationReq(activityId, forms)
	FloatWordMgr.instance:show("保存成功")
end

function MartialContestController:sendPM_MCFinalsSetDefenseForamtionReq(activityId, simpleForms, buffIds)
	local forms = {}

	for i, v in ipairs(simpleForms) do
		local form = MartialContestExtension_pb.MCFinalsSetFormNO()

		form.formId = v.formId

		form.simpleForm:ParseFromString(v.simpleForm:SerializeToString())

		for i, equipInfo in ipairs(v.equipList) do
			local equip = MartialContestExtension_pb.MCFormEquip()

			equip.petId = equipInfo.petId
			equip.equipId = equipInfo.equipId

			local equipAdd = form.equips:add()

			equipAdd:ParseFromString(equip:SerializeToString())
		end

		table.insert(forms, form)
	end

	MartialContestAgent.instance:sendPM_MCFinalsSetFormationReq(activityId, forms, buffIds)
	FloatWordMgr.instance:show("新的阵型将在下一轮战斗阶段生效")
end

function MartialContestController:sendPM_MCFinalsSetBuffReq(activityId, buffIds)
	local finalForm = MartialContestModel.instance:getFinalFormation(activityId)

	if finalForm then
		local forms = {}

		for i, v in ipairs(finalForm.forms or {}) do
			local fmt = FormationMO.New()

			fmt:SetData(v.simpleForm)

			local form = MartialContestExtension_pb.MCFinalsSetFormNO()

			form.formId = v.formId

			form.simpleForm:ParseFromString(fmt:createFormPb():SerializeToString())

			for i, equipInfo in ipairs(v.equips or {}) do
				local equip = MartialContestExtension_pb.MCFormEquip()

				equip.petId = equipInfo.petId
				equip.equipId = equipInfo.equipId

				local equipAdd = form.equips:add()

				equipAdd:ParseFromString(equip:SerializeToString())
			end

			table.insert(forms, form)
		end

		MartialContestAgent.instance:sendPM_MCFinalsSetFormationReq(activityId, forms, buffIds)
		FloatWordMgr.instance:show("新的阵型将在下一轮战斗阶段生效")
	end
end

function MartialContestController:sendPM_MCQualifierFightReq(activityId, stepId, formNos)
	local forms = {}

	for i, v in ipairs(formNos) do
		local form = MartialContestExtension_pb.MCFinalsSetFormNO()

		form.formId = v.formId

		form.simpleForm:ParseFromString(v.simpleForm:SerializeToString())

		for i, equipInfo in ipairs(v.equipList) do
			local equip = MartialContestExtension_pb.MCFormEquip()

			equip.petId = equipInfo.petId
			equip.equipId = equipInfo.equipId

			local equipAdd = form.equips:add()

			equipAdd:ParseFromString(equip:SerializeToString())
		end

		table.insert(forms, form)
	end

	MartialContestAgent.instance:sendPM_MCQualifierFightReq(activityId, stepId, forms)
end

function MartialContestController:handlePM_MCQualifierFightRes(msg)
	local battleResult = msg.battleResult[1]
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
	BattleController.instance:viewUserFightMonsterBtlResultWithList(msg.battleResult)

	local qualifierInfo = MartialContestModel.instance:getQualifierInfo(msg.activityId, msg.stepId)

	MartialContestModel.instance:saveBattleScoreWithOldAndNew(msg, qualifierInfo.rankScore)

	if msg.stepId == MartialContestEnum.Score_Match_Step_Id then
		BattleFacade.instance:registerResultHandler(function()
			self:openScoreBattleResultView(msg.battleResult)

			return true
		end, self)
	elseif msg.stepId == MartialContestEnum.Qualify_Step_Id then
		local params = {
			oldScore = qualifierInfo.rankScore,
			newScore = msg.score,
			stepId = msg.stepId
		}

		BattleFacade.instance:registerResultHandler(nil, nil)
		BattleFacade.instance:registerResultHandler(function()
			BattleFacade.instance:registerResultHandler(nil, nil)

			if msg.isWin == true then
				local content = langPara("积分变化：<color=#eb4624>%s</color>-><color=#20b376>%s</color>", params.oldScore, params.newScore)

				BattleSettlementController.instance:addConditionElement(content, nil)
				ViewMgr.instance:open(ViewName.MartialContestSettlementView)
			else
				BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.YoungChampionKingQualifier, params)
				ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
			end

			return true
		end, self)
	end

	MartialContestModel.instance:saveQualifierBattleInfo(msg)
end

function MartialContestController:handlePM_MCGetQualifierInfoRes(msg)
	MartialContestModel.instance:saveQualifierInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MCGetInfoRes)
end

function MartialContestController:handlePM_MCGetFinalsEquipInfoRes(msg)
	MartialContestModel.instance:saveEquipInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MCGetInfoRes)
end

function MartialContestController:handlePM_MCUpgradeFinalsEquipRes(msg)
	MartialContestModel.instance:saveEquipUpgrade(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MCGetInfoRes)
end

function MartialContestController:handlePM_MCGetDefenseForamtionRes(msg)
	MartialContestModel.instance:saveDefenseForamtion(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MCGetDefenseForamtionRes)
end

function MartialContestController:handlePM_MCQualifierGetNewOpponentRes(msg)
	MartialContestModel.instance:saveOpponent(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MCQualifierGetNewOpponentRes)
end

function MartialContestController:handlePM_MCFinalsGetFormationRes(msg)
	MartialContestModel.instance:saveFinalFormation(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MCFinalsGetFormationRes)
end

function MartialContestController:openScoreBattleResultView(battleResults)
	local twoFormMoList = {}
	local twoPlayerInfo = {}
	local resultCount = #battleResults

	for idx = 1, resultCount do
		local btlResult = battleResults[idx]
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
		twoFormMo.challengeZdl = twoPlayerView[1].fightPower
		twoFormMo.beChallengeZdl = twoPlayerView[2].fightPower
		twoFormMo.challengePets = twoPetLists[1]
		twoFormMo.beChallengePets = twoPetLists[2]

		table.insert(twoFormMoList, twoFormMo)
	end

	UIStateManager.instance:open(ViewName.MartialContestScoreResultView, twoPlayerInfo[1], twoPlayerInfo[2], twoFormMoList)
end

function MartialContestController:handlePM_MCQualifierRecordsRes(msg)
	MartialContestModel.instance:saveRecordInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MCQualifierRecordsRes)
end

function MartialContestController:handlePM_MCGetBattleVideoRes(msg)
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

	GlobalDispatcher:dispatch(GlobalNotify.PM_MCGetBattleVideoRes, callBack)
end

function MartialContestController:cacheFinalsStepId(stepId)
	self._cacheFinalsStepId = stepId
end

function MartialContestController:getCacheFinalsStepId()
	return self._cacheFinalsStepId
end

function MartialContestController:sendPM_MCFinalsInfoReq(activityId, needPopResultView)
	self._needPopResultView = needPopResultView

	MartialContestAgent.instance:sendPM_MCFinalsInfoReq(activityId)
end

function MartialContestController:handlePM_MCFinalsInfoRes(msg)
	if self._needPopResultView then
		self._needPopResultView = false

		local curStepId = msg.info.curStepId
		local curStepCfg = MartialContestConfig.instance:getStepCfg(msg.activityId, curStepId)
		local isCanPopView = false
		local myLastScore = 0
		local myCurScore = 0
		local battleCnt = 0
		local activeCnt = 0
		local myBattleResult
		local activityId = msg.activityId
		local info = msg.info
		local isFirstBattle = false

		if info and curStepCfg.processorTarget == MartialContestEnum.FINALS_BATTLE then
			local lastStepId = curStepId - 2
			local lastStepCfg = MartialContestConfig.instance:getStepCfg(activityId, lastStepId)

			if not lastStepCfg or lastStepCfg.processorTarget ~= "FINALS_BATTLE" then
				isFirstBattle = true
			end

			if isFirstBattle then
				battleCnt = 64
			else
				for i, v in ipairs(info.results) do
					if v.stepId == lastStepId then
						battleCnt = battleCnt + 1
					end
				end
			end

			local isMeInFinalBattle = false
			local userId = tostring(RoleModel.instance:getUserId())

			for i, v in ipairs(info.allPlayers or {}) do
				if v.headInfo.headInfo.userId == userId then
					isMeInFinalBattle = true
				end

				if v.isActive then
					activeCnt = activeCnt + 1
				end
			end

			if isMeInFinalBattle then
				local myBattleResults = {}

				for i, v in ipairs(info.results) do
					if v.playerUserIdA == userId or v.playerUserIdB == userId then
						table.insert(myBattleResults, v)
					end
				end

				if #myBattleResults > 0 then
					table.sort(myBattleResults, function(a, b)
						return a.stepId > b.stepId
					end)

					for i, v in ipairs(myBattleResults) do
						if v.stepId == curStepId then
							local curBattleResult = v
							local preBattleResult = myBattleResults[i + 1]

							myBattleResult = v
							myCurScore = self:_calFinalWinTotalScoreByStepId(activityId, curBattleResult.stepId)

							if preBattleResult then
								local isMyTeamA = preBattleResult.playerUserIdA == userId
								local isPreBattleWin = isMyTeamA == preBattleResult.isTeamAWin

								if isPreBattleWin then
									isCanPopView = true
									myLastScore = self:_calFinalWinTotalScoreByStepId(activityId, preBattleResult.stepId)

									local isMyCurrTeamA = curBattleResult.playerUserIdA == userId
									local isCurrBattleWin = isMyCurrTeamA == curBattleResult.isTeamAWin

									if not isCurrBattleWin then
										myCurScore = myLastScore
									end
								end
							end

							break
						end
					end
				end
			end
		end

		isCanPopView = isCanPopView or isFirstBattle

		if isCanPopView and myBattleResult then
			local viewData = {
				activityId = msg.activityId,
				stepId = curStepId,
				lastScore = myLastScore,
				curScore = myCurScore,
				deadCnt = battleCnt - activeCnt,
				activeCnt = activeCnt,
				battleCnt = battleCnt,
				myBattleResult = myBattleResult
			}

			UIStateManager.instance:push(ViewName.MartialcontestfinalrankresultView, viewData)
		end

		self:cacheFinalsStepId(0)
	end

	MartialContestModel.instance:onMCFinalsInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MCFinalsInfoRes)
end

function MartialContestController:_calFinalWinTotalScoreByStepId(activityId, stepId)
	local stepCfgs = MartialContestConfig.instance:getStepCfgs(activityId)
	local score = 0

	for i, v in ipairs(stepCfgs) do
		if stepId >= v.stepId then
			if v.processorTarget == "FINALS_BATTLE" then
				score = score + v.finalsScore
			end
		else
			break
		end
	end

	return score
end

function MartialContestController:blockGetFinalsInfo(block)
	self._blockGetFinalsInfo = block
end

function MartialContestController:getBlockGetFinalsInfo()
	return self._blockGetFinalsInfo
end

function MartialContestController:isFinalBattleStep(activityId, stepId)
	local stepCfg = MartialContestConfig.instance:getStepCfg(activityId, stepId)

	if not stepCfg then
		return false
	end

	local roundCfg = MartialContestConfig.instance:getRoundCfg(activityId, stepCfg.roundId)

	if not roundCfg then
		return false
	end

	return roundCfg.roundType == "FINALS_COMMON" or roundCfg.roundType == "FINALS_3V3" or roundCfg.roundType == "FINALS_BUFF"
end

function MartialContestController:getPetIdWithEquip(activityId, equipId)
	local stepId = MartialContestModel.instance:getCurStepId(activityId)

	if checknumber(stepId) == 0 then
		return nil
	end

	local activityInfo = MartialContestModel.instance:getInfo(activityId)

	if not activityInfo then
		return nil
	end

	local playerRoundId = activityInfo.playerRoundId
	local curStepCfg = MartialContestConfig.instance:getStepCfg(activityId, stepId)
	local forms = {}

	if playerRoundId == curStepCfg.roundId then
		if playerRoundId == MartialContestEnum.Qualify_Round_Id or playerRoundId == MartialContestEnum.Display_Round_Id or playerRoundId == MartialContestEnum.Finals_Day_One_Round_Id then
			local defenseInfo = MartialContestModel.instance:getDefenseForamtion(activityId)
			local form = defenseInfo and defenseInfo.simpleForm

			if form then
				table.insert(forms, form)
			end
		elseif playerRoundId == MartialContestEnum.Score_Match_Round_Id or playerRoundId == MartialContestEnum.Finals_Day_Two_Round_Id or playerRoundId == MartialContestEnum.Finals_Day_Three_Round_Id then
			local finalInfo = MartialContestModel.instance:getFinalFormation(activityId)

			forms = finalInfo and finalInfo.forms or {}
		end
	else
		local defenseInfo = MartialContestModel.instance:getDefenseForamtion(activityId)
		local form = defenseInfo and defenseInfo.simpleForm

		if form then
			table.insert(forms, form)
		end
	end

	for i, v in ipairs(forms) do
		for j, equipInfo in ipairs(v.equips or {}) do
			if equipId == equipInfo.equipId then
				return equipInfo.petId
			end
		end
	end

	return nil
end

function MartialContestController:isCanUpgradeEquip(activityId)
	local equipList = {}
	local equipCfgs = MartialContestConfig.instance:getEquipTypeCfgs(activityId)

	for i, v in ipairs(equipCfgs or {}) do
		table.insert(equipList, v[1].equipId)
	end

	for i, v in ipairs(equipList) do
		local curLv = MartialContestModel.instance:getEquipLevel(activityId, v)
		local nextCfg = MartialContestConfig.instance:getEquipCfg(activityId, v, curLv + 1)

		if nextCfg then
			local matType, matId, matNum = MaterialMgr.getMatParams(nextCfg.cost)

			if MaterialModel.instance:IsEnough(matType, matId, matNum) == true then
				return true
			end
		end
	end

	return false
end

function MartialContestController:_isInFinalStep(activityId, stepId)
	local stepCfg = MartialContestConfig.instance:getStepCfg(activityId, stepId)

	if stepCfg then
		local roundCfg = MartialContestConfig.instance:getRoundCfg(activityId, stepCfg.roundId)

		return roundCfg.roundType == "FINALS_COMMON" or roundCfg.roundType == "FINALS_3V3" or roundCfg.roundType == "FINALS_BUFF"
	end

	return false
end

function MartialContestController:getFinalMainUIJumpCellName()
	local msg = MartialContestModel.instance:getFinalsInfoMsg()

	if msg then
		local activityId = msg.activityId
		local stepId = msg.info.curStepId
		local stepCfg = MartialContestConfig.instance:getStepCfg(activityId, stepId)

		if stepCfg then
			local roundDesc = MartialContestController:getFinalsRoundDesc(activityId, stepId, stepCfg.roundId)

			return string.format("比武争锋 %s 剩余时间", roundDesc)
		end
	end

	return "未知"
end

MartialContestController.instance = MartialContestController.New()

return MartialContestController
