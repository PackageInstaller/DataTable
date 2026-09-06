-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/controller/GodStatuesWarController.lua

module("logic.extensions.godstatueswar.controller.GodStatuesWarController", package.seeall)

local GodStatuesWarController = class("GodStatuesWarController", BaseController)

function GodStatuesWarController:ctor()
	self._gswStepMgrs = {}
	self._gswStepMgrDeltas = {}
end

function GodStatuesWarController:onInit()
	self:onReset()
end

function GodStatuesWarController:onReset()
	self:allGswStepMgrOnDestroy()
	GlobalDispatcher:addListener("entergodstatueswar", self.enterGodStatuesWar, self)
end

function GodStatuesWarController:sendPM_NewFamilyBattleGetRegistrationReq()
	NewFamilyBattleAgent.instance:sendPM_NewFamilyBattleGetRegistrationReq()
end

function GodStatuesWarController:handlePM_NewFamilyBattleGetRegistrationRes(status, msg)
	if status == 0 then
		for i, v in ipairs(msg.seasonInfoList) do
			self:getGswMo(v.seasonId):handlePM_NewFamilyBattleGetRegistrationRes(v)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NewFamilyBattleGetRegistrationRes, status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataFamilyActivityItem, GameEnum.FamilyActivityType.GodStatuesWar)
end

function GodStatuesWarController:sendPM_NewFamilyBattleRegisteringReq(seasonId)
	NewFamilyBattleAgent.instance:sendPM_NewFamilyBattleRegisteringReq(seasonId)
end

function GodStatuesWarController:handlePM_NewFamilyBattleRegisteringRes(status, msg)
	if status == 0 then
		self:getGswMo(msg.seasonId):handlePM_NewFamilyBattleRegisteringRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NewFamilyBattleRegisteringRes, status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataFamilyActivityItem, GameEnum.FamilyActivityType.GodStatuesWar)
end

function GodStatuesWarController:sendPM_NewFamilyBattleGetFormReq(seasonId)
	NewFamilyBattleAgent.instance:sendPM_NewFamilyBattleGetFormReq(seasonId)
end

function GodStatuesWarController:handlePM_NewFamilyBattleGetFormRes(status, msg)
	if status == 0 then
		self:getGswMo(msg.seasonId):handlePM_NewFamilyBattleGetFormRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NewFamilyBattleGetFormRes, status, msg)
end

function GodStatuesWarController:sendPM_NewFamilyBattleSetFormReq(seasonId, simpleFormList)
	NewFamilyBattleAgent.instance:sendPM_NewFamilyBattleSetFormReq(seasonId, simpleFormList)
end

function GodStatuesWarController:handlePM_NewFamilyBattleSetFormRes(status, msg)
	if status == 0 then
		self:getGswMo(msg.seasonId):handlePM_NewFamilyBattleSetFormRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NewFamilyBattleSetFormRes, status, msg)
end

function GodStatuesWarController:sendPM_NewFamilyBattleGetDivinePillarFormReq(seasonId)
	NewFamilyBattleAgent.instance:sendPM_NewFamilyBattleGetDivinePillarFormReq(seasonId)
end

function GodStatuesWarController:handlePM_NewFamilyBattleGetDivinePillarFormRes(msg)
	self:getGswMo(msg.seasonId):handlePM_NewFamilyBattleGetDivinePillarFormRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NewFamilyBattleGetDivinePillarFormRes)
end

function GodStatuesWarController:sendPM_NewFamilyBattleGetFormDetailReq(seasonId, targetFamilyId, playerId, formId)
	NewFamilyBattleAgent.instance:sendPM_NewFamilyBattleGetFormDetailReq(seasonId, targetFamilyId, playerId, formId)
end

function GodStatuesWarController:handlePM_NewFamilyBattleGetFormDetailRes(msg)
	self:getGswMo(msg.seasonId):handlePM_NewFamilyBattleGetFormDetailRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NewFamilyBattleGetFormDetailRes)
end

function GodStatuesWarController:sendPM_NewFamilyBattleAdjustReq(seasonId, req)
	NewFamilyBattleAgent.instance:sendPM_NewFamilyBattleAdjustReq(seasonId, req)
end

function GodStatuesWarController:handlePM_NewFamilyBattleAdjustRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NewFamilyBattleAdjustRes)
end

function GodStatuesWarController:sendPM_NewFamilyBattleGetDivinePillarMapReq(seasonId)
	NewFamilyBattleAgent.instance:sendPM_NewFamilyBattleGetDivinePillarMapReq(seasonId)
end

function GodStatuesWarController:handlePM_NewFamilyBattleGetDivinePillarMapRes(msg)
	self:getGswMo(msg.seasonId):handlePM_NewFamilyBattleGetDivinePillarMapRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NewFamilyBattleGetDivinePillarMapRes)
end

function GodStatuesWarController:sendPM_NewFamilyBattleGetDivinePillarInfoReq(seasonId, familyId)
	NewFamilyBattleAgent.instance:sendPM_NewFamilyBattleGetDivinePillarInfoReq(seasonId, familyId)
end

function GodStatuesWarController:handlePM_NewFamilyBattleGetDivinePillarInfoRes(msg)
	self:getGswMo(msg.seasonId):handlePM_NewFamilyBattleGetDivinePillarInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NewFamilyBattleGetDivinePillarInfoRes)
end

function GodStatuesWarController:sendPM_NewFamilyBattleFightDivinePillarReq(seasonId, familyId, tier, simpleFormList)
	NewFamilyBattleAgent.instance:sendPM_NewFamilyBattleFightDivinePillarReq(seasonId, familyId, tier, simpleFormList)
end

function GodStatuesWarController:handlePM_NewFamilyBattleFightDivinePillarRes(status, msg)
	if status == 0 then
		self:getGswMo(msg.seasonId):handlePM_NewFamilyBattleFightDivinePillarRes(msg)
		self:playBattleResultsAsGsw(msg.battleResult, nil, GswEnum.FightType_Normal, msg.seasonId)
	else
		if status == -2 then
			FloatWordMgr.instance:show("敌阵已被击败，请退出布阵重新开始挑战")
		end

		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NewFamilyBattleFightDivinePillarRes, status, msg)
end

function GodStatuesWarController:sendPM_NewFamilyBattleReportReq(seasonId)
	NewFamilyBattleAgent.instance:sendPM_NewFamilyBattleReportReq(seasonId)
end

function GodStatuesWarController:handlePM_NewFamilyBattleReportRes(msg)
	self:getGswMo(msg.seasonId):handlePM_NewFamilyBattleReportRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NewFamilyBattleReportRes)
end

function GodStatuesWarController:sendPM_NewFamilyBattleVideoReq(battleId, teamId)
	self._teamIdInVideo = teamId

	NewFamilyBattleAgent.instance:sendPM_NewFamilyBattleVideoReq(battleId)
end

function GodStatuesWarController:handlePM_NewFamilyBattleVideoRes(msg)
	local firstTeamId = self._teamIdInVideo

	self._teamIdInVideo = nil

	self:playBattleResultsAsGsw({
		msg.btlResult
	}, {
		firstTeamId
	}, GswEnum.FightType_Vieo)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NewFamilyBattleVideoRes)
end

function GodStatuesWarController:sendPM_NewFamilyBattleChallengeNestReq(seasonId, form, nestPlanId, nestId)
	BattleFacade.instance:startGodStatuesWarNest(seasonId, nestPlanId, nestId)
	NewFamilyBattleAgent.instance:sendPM_NewFamilyBattleChallengeNestReq(seasonId, form, nestId)
end

function GodStatuesWarController:handlePM_NewFamilyBattleChallengeNestRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NewFamilyBattleChallengeNestRes)
end

function GodStatuesWarController:sendPM_NewFamilyBattleSetFlagReq(seasonId, attackFlagFamilyId, noAttackFlagFamilyId)
	NewFamilyBattleAgent.instance:sendPM_NewFamilyBattleSetFlagReq(seasonId, attackFlagFamilyId, noAttackFlagFamilyId)
end

function GodStatuesWarController:handlePM_NewFamilyBattleSetFlagRes(msg)
	self:getGswMo(msg.seasonId):handlePM_NewFamilyBattleSetFlagRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NewFamilyBattleSetFlagRes)
end

function GodStatuesWarController:sendPM_NewFamilyBattleRankViewReq(seasonId)
	NewFamilyBattleAgent.instance:sendPM_NewFamilyBattleRankViewReq(seasonId)
end

function GodStatuesWarController:handlePM_NewFamilyBattleRankViewRes(msg)
	self:getGswMo(msg.seasonId):handlePM_NewFamilyBattleRankViewRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NewFamilyBattleRankViewRes, msg)
end

function GodStatuesWarController:sendPM_NewFamilyBattleGetSpaceGroupInfoReq(seasonId)
	NewFamilyBattleAgent.instance:sendPM_NewFamilyBattleGetSpaceGroupInfoReq(seasonId)
end

function GodStatuesWarController:handlePM_NewFamilyBattleGetSpaceGroupInfoRes(msg)
	self:getGswMo(msg.seasonId):handlePM_NewFamilyBattleGetSpaceGroupInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NewFamilyBattleGetSpaceGroupInfoRes)
end

function GodStatuesWarController:handlePM_NewFamilyBattleChallengeNestResult(msg)
	self:getGswMo(msg.seasonId):handlePM_NewFamilyBattleChallengeNestResult(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NewFamilyBattleChallengeNestResult)
end

function GodStatuesWarController:enterGodStatuesWar()
	local seasonId = self:getSeasonId()
	local result, tips = self:getTryEnterGodStatuesWarResultAndTips(seasonId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local key = string.format("GodStatuesWar_%s", seasonId)

	local function firstCallback()
		GlobalDispatcher:addListener(GlobalNotify.handlePM_NewFamilyBattleGetRegistrationRes, self._handleEnterGodStatuesWar, self)
		self:sendPM_NewFamilyBattleGetRegistrationReq(seasonId)
	end

	local function nextCallBack()
		GlobalDispatcher:addListener(GlobalNotify.handlePM_NewFamilyBattleGetRegistrationRes, self._handleEnterGodStatuesWar, self)
		self:sendPM_NewFamilyBattleGetRegistrationReq(seasonId)
	end

	GameUtil.doCallbackWhenFirst(key, firstCallback, nextCallBack)
end

function GodStatuesWarController:_handleEnterGodStatuesWar(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_NewFamilyBattleGetRegistrationRes, self._handleEnterGodStatuesWar, self)

	if status ~= 0 then
		return
	end

	local function registerFunc(seasonId)
		if self:isFamilyChief() then
			local step = self:getCurStepOfGsw(seasonId)
			local stepData = GodStatuesWarConfig.instance:getNfbStepData(seasonId, step)
			local fields = self:getStepIntervalTimeFields(seasonId, step, GswEnum.StepInterval_Bat)
			local tipsContent = string.format("当前家族未报名，是否报名参加神柱之战?\n开战时间：%s", (fields or nil) and GameUtil.getFormatTimeByStamp(GameUtil.string2time(stepData[fields[1]]), nil))

			local function okFunc()
				GlobalDispatcher:addListener(GlobalNotify.handlePM_NewFamilyBattleRegisteringRes, self._handleRegisteringAfter, self)
				GodStatuesWarController.instance:sendPM_NewFamilyBattleRegisteringReq(seasonId)
			end

			local function cencelFunc()
				return
			end

			TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
		else
			local text = "当前家族未报名。请告知族长或副族长报名参加神柱之战"

			TipsFacade.instance:openTipWindowNoX("提示", text, nil, "确定", UnityEngine.TextAnchor.MiddleCenter)
		end
	end

	local function regPreFunc(seasonId)
		local step = self:getCurStepOfGsw(seasonId)
		local stepData = GodStatuesWarConfig.instance:getNfbStepData(seasonId, step)
		local startTime = GameUtil.getFormatTimeByStamp(GameUtil.string2time(stepData.registrationStartTime), nil)
		local text = string.format("报名未开始。\n报名开放时间：%s", startTime)

		local function func()
			return
		end

		TipsFacade.instance:openTipWindowNoX("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)
	end

	local function regSuccessButNotStartFunc(seasonId)
		local step = self:getCurStepOfGsw(seasonId)
		local stepData = GodStatuesWarConfig.instance:getNfbStepData(seasonId, step)
		local fields = self:getStepIntervalTimeFields(seasonId, step, GswEnum.StepInterval_Bat)
		local leftTime = GameUtil.FormatTimeSymbol(((fields or nil) and GameUtil.string2time(stepData[fields[1]])) - ServerTime.now())
		local text = string.format("您家族已报名成功。\n距离开战剩余时间：%s", leftTime)

		TipsFacade.instance:openTipWindowNoX("提示", text, nil, "确定", UnityEngine.TextAnchor.MiddleCenter)
	end

	local curSeasonId = self:getSeasonId()
	local isInTimeOfCur = self:isInSeasonTime(curSeasonId)
	local stepInCur = self:getCurStepOfGsw(curSeasonId)
	local stepIntervalInCur = self:getStepInterval(curSeasonId, stepInCur)
	local isRegisteredInCur = self:isRegisteredOfGsw(curSeasonId)
	local familyStepInCur = self:getMyFamilyStep(curSeasonId)
	local isCanParticipateInCur = self:isCanParticipateOfGsw(curSeasonId)
	local isCanFightInCur = self:isCanFight(curSeasonId)
	local nextSeasonId = self:getNextOpenSeasonId()
	local isInTimeOfNext = self:isInSeasonTime(nextSeasonId)
	local stepInNext = self:getCurStepOfGsw(nextSeasonId)
	local isRegisteredInNext = self:isRegisteredOfGsw(nextSeasonId)
	local stepIntervalInNext = self:getStepInterval(nextSeasonId, stepInNext)
	local familyStepInNext = self:getMyFamilyStep(nextSeasonId)
	local isCanParticipateInNext = self:isCanParticipateOfGsw(nextSeasonId)
	local isCanFightInNext = self:isCanFight(nextSeasonId)
	local isFamilyChief = self:isFamilyChief()

	if isInTimeOfCur and not isRegisteredInCur and stepIntervalInCur == GswEnum.StepInterval_Reg then
		registerFunc(curSeasonId)

		return
	end

	if isInTimeOfCur and isRegisteredInCur and isCanParticipateInCur and isCanFightInCur and stepIntervalInCur > GswEnum.StepInterval_Reg then
		UIStateManager.instance:push(ViewName.GodStatuesWarMainView, curSeasonId)

		return
	end

	if isInTimeOfNext and not isRegisteredInNext and stepIntervalInNext == GswEnum.StepInterval_Reg then
		registerFunc(nextSeasonId)

		return
	end

	if isInTimeOfNext and isRegisteredInNext and isCanParticipateInNext and isCanFightInNext and stepIntervalInNext > GswEnum.StepInterval_Reg then
		UIStateManager.instance:push(ViewName.GodStatuesWarMainView, nextSeasonId)

		return
	end

	if isInTimeOfCur and not isInTimeOfNext then
		if stepIntervalInCur == GswEnum.StepInterval_RegPre then
			regPreFunc(curSeasonId)
		elseif stepIntervalInCur == GswEnum.StepInterval_Reg then
			if isRegisteredInCur then
				regSuccessButNotStartFunc(curSeasonId)
			else
				TipsFacade.instance:openTipWindowNoX("提示", "报名阶段未报名，不能参与", nil, "确定", UnityEngine.TextAnchor.MiddleCenter)
			end
		elseif isRegisteredInCur then
			if isCanParticipateInCur then
				if not isCanFightInCur then
					local stepData = GodStatuesWarConfig.instance:getNfbStepData(curSeasonId, familyStepInCur)

					if stepData then
						FloatWordMgr.instance:show(string.format("你的家族止步于%s", stepData.desc))
					end
				end
			else
				FloatWordMgr.instance:show("报名阶段后加入的族员不可参加比赛")
			end
		else
			TipsFacade.instance:openTipWindowNoX("提示", "报名阶段未报名，不能参与", nil, "确定", UnityEngine.TextAnchor.MiddleCenter)
		end
	elseif isInTimeOfNext then
		if stepIntervalInNext == GswEnum.StepInterval_RegPre then
			regPreFunc(nextSeasonId)
		elseif stepIntervalInNext == GswEnum.StepInterval_Reg then
			if isRegisteredInNext then
				regSuccessButNotStartFunc(nextSeasonId)
			else
				TipsFacade.instance:openTipWindowNoX("提示", "报名阶段未报名，不能参与", nil, "确定", UnityEngine.TextAnchor.MiddleCenter)
			end
		elseif isRegisteredInNext then
			if isCanParticipateInNext then
				if not isCanFightInNext then
					local stepData = GodStatuesWarConfig.instance:getNfbStepData(nextSeasonId, familyStepInNext)

					if stepData then
						FloatWordMgr.instance:show(string.format("你的家族止步于%s", stepData.desc))
					end
				end
			else
				FloatWordMgr.instance:show("报名阶段后加入的族员不可参加比赛")
			end
		else
			TipsFacade.instance:openTipWindowNoX("提示", "报名阶段未报名，不能参与", nil, "确定", UnityEngine.TextAnchor.MiddleCenter)
		end
	else
		FloatWordMgr.instance:show("活动未开启")
	end
end

function GodStatuesWarController:_handleRegisteringAfter(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_NewFamilyBattleRegisteringRes, self._handleRegisteringAfter, self)

	if status ~= 0 then
		return
	end

	local seasonId = msg.seasonId
	local step = self:getCurStepOfGsw(seasonId)
	local stepData = GodStatuesWarConfig.instance:getNfbStepData(seasonId, step)
	local fields = self:getStepIntervalTimeFields(seasonId, step, GswEnum.StepInterval_Bat)
	local leftTime = GameUtil.FormatTimeSymbol(((fields or nil) and GameUtil.string2time(stepData[fields[1]])) - ServerTime.now())
	local text = string.format("报名成功。\n距离开战剩余时间：%s", leftTime)

	TipsFacade.instance:openTipWindowNoX("提示", text, nil, "确定", UnityEngine.TextAnchor.MiddleCenter)
end

function GodStatuesWarController:openCommonTabRankView(_seasonId)
	local seasonId = checknumber(_seasonId)

	if seasonId <= 0 then
		seasonId = self:getSeasonId()
	end

	local params = CommonTabRankParams.New()

	params:addTabData(1, ViewName.GodStatuesWarAreaEnergyRankChildView, "战区赛", {
		seasonId
	})
	params:addTabData(2, ViewName.GodStatuesWarSeasonScheduleRankTabChildView, "全服赛", {
		seasonId
	})
	UIStateManager.instance:push(ViewName.CommonTabRankFatherView, params)
end

function GodStatuesWarController:enterGodStatuesWarAdvanceFmt(seasonId)
	GlobalDispatcher:addListener(GlobalNotify.handlePM_NewFamilyBattleGetFormRes, self._handleEnterGodStatuesWarAdvanceFmt, self)
	self:sendPM_NewFamilyBattleGetFormReq(seasonId)
end

function GodStatuesWarController:_handleEnterGodStatuesWarAdvanceFmt(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_NewFamilyBattleGetFormRes, self._handleEnterGodStatuesWarAdvanceFmt, self)

	if status ~= 0 then
		return
	end

	local customFmtMo = GodStatuesWarModel.instance:getGswAdvanceCustomFmtMo()

	customFmtMo:updateCfg(msg.seasonId)
	CustomFmtController.instance:showMissionFormationView(customFmtMo)
end

function GodStatuesWarController:enterGodStatuesWarFightPillarFmt(seasonId, pillarId, familyId, tierId, step)
	local customFmtMo = GodStatuesWarModel.instance:getGswFightPillarCustomFmtMo()

	customFmtMo:updateCfg(seasonId, pillarId, familyId, tierId, step)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function GodStatuesWarController:playBattleResultsAsGsw(battleResultList, teamIdList, fightType, seasonId)
	self._curBtlResultIdx = 1
	self._btlResultList = battleResultList

	local btlResult = self._btlResultList[self._curBtlResultIdx]

	self._btlTeamIdList = teamIdList

	local teamId = self:getTeamIdByIdx(self._curBtlResultIdx)

	self._btlFightType = fightType

	if btlResult == nil then
		FloatWordMgr.instance:show("后端返回战斗结果为空")
	else
		BattleFacade.instance:startGodStatuesWar(self._btlFightType, #self._btlResultList > 1, seasonId)
		BattleController.instance:viewUserFightMonsterBtlResult(btlResult, false)

		if teamId >= 0 then
			BattleModel.instance:setLeftTeamId(teamId)
		end

		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.GodStatuesWar)
	end
end

function GodStatuesWarController:tryNextBattle()
	local idx = self._curBtlResultIdx + 1
	local btlResult = self._btlResultList[idx]

	if btlResult == nil then
		return false
	end

	self._curBtlResultIdx = idx

	local teamId = self:getTeamIdByIdx(self._curBtlResultIdx)
	local seasonId = BattleModel.instance.StartGodStatuesWarSeasonId

	BattleFacade.instance:startGodStatuesWar(self._btlFightType, #self._btlResultList > 1, seasonId)
	BattleController.instance:onBattleContinue(btlResult)

	if teamId >= 0 then
		BattleModel.instance:setLeftTeamId(teamId)
	end

	return true
end

function GodStatuesWarController:getCurBattleResultIdx()
	return self._curBtlResultIdx - 1
end

function GodStatuesWarController:getTeamIdByIdx(idx)
	return (self._btlTeamIdList or nil) and (self._btlTeamIdList[idx] or -1)
end

function GodStatuesWarController:openBattleResultViewAsGsw()
	local fightType = BattleModel.instance.StartGodStatuesWarFightType

	if fightType == GswEnum.FightType_Normal then
		local seasonId = checknumber(BattleModel.instance.StartGodStatuesWarSeasonId)

		if seasonId > 0 then
			local msg = self:getFightDivinePillarResMsg(seasonId)

			if msg and msg.changeSetId then
				MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
				BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
			end
		end

		ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
	elseif fightType == GswEnum.FightType_Vieo then
		BattleController.instance:openSettlementView()
	end
end

function GodStatuesWarController:enterGodStatuesWarFightNestFmt(seasonId, nestPlanId, nestId)
	local customFmtMo = GodStatuesWarModel.instance:getGswFightNestCustomFmtMo()

	customFmtMo:updateCfg(seasonId, nestPlanId, nestId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function GodStatuesWarController:enterGodStatuesWarFightNestResultView(seasonId, nestPlanId, nestId)
	UIStateManager.instance:push(ViewName.GodStatuesWarNestBattleResultView, seasonId, nestPlanId, nestId)
end

function GodStatuesWarController:getTryEnterGodStatuesWarResultAndTips(seasonId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInSeasonTime(seasonId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在开启期限内"
	elseif not self:isEnoughFamilyLevelOfGsw() then
		result = GameEnum.ResultCode.ErrorLevel

		local limLv = self:getFamilyLevelLimitOfGsw()

		tips = string.format("家族等级%s级开启！", limLv)
	end

	return result, tips
end

function GodStatuesWarController:getTryEnterPillarInGswResultAndTips(seasonId, pillarId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local step = self:getCurStepOfGsw(seasonId)
	local stepInterval = self:getStepInterval(seasonId, step)

	if stepInterval == GswEnum.StepInterval_RegPre then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_Reg then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_FmtPre then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_Fmt then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_AdjPre then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_Adj then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_BatPre then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_Bat then
		-- block empty
	elseif stepInterval == GswEnum.StepInterval_BatEnd then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段已结束"
	end

	if result == GameEnum.ResultCode.Success and self:isEmptyPillar(seasonId, pillarId) then
		result = GameEnum.ResultCode.Error
		tips = "对应神柱没有家族驻守"
	end

	return result, tips
end

function GodStatuesWarController:getTryEnterNestInGswResultAndTips(seasonId, nestId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local step = self:getCurStepOfGsw(seasonId)
	local stepInterval = self:getStepInterval(seasonId, step)

	if stepInterval == GswEnum.StepInterval_RegPre then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_Reg then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_FmtPre then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_Fmt then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_AdjPre then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_Adj then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_BatPre then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_Bat then
		-- block empty
	elseif stepInterval == GswEnum.StepInterval_BatEnd then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段已结束"
	end

	return result, tips
end

function GodStatuesWarController:getTryOpenRankViewInGswResultAndTips(seasonId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local step = self:getCurStepOfGsw(seasonId)
	local stepInterval = self:getStepInterval(seasonId, step)

	if stepInterval == GswEnum.StepInterval_RegPre then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_Reg then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_FmtPre then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_Fmt then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_AdjPre then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_Adj then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_BatPre then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_Bat then
		-- block empty
	elseif stepInterval == GswEnum.StepInterval_BatEnd then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段已结束"
	end

	return result, tips
end

function GodStatuesWarController:getTryOpenReportViewInGswResultAndTips(seasonId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local step = self:getCurStepOfGsw(seasonId)
	local stepInterval = self:getStepInterval(seasonId, step)

	if stepInterval == GswEnum.StepInterval_RegPre then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_Reg then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_FmtPre then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_Fmt then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_AdjPre then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_Adj then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_BatPre then
		result = GameEnum.ResultCode.Error
		tips = "对抗阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_Bat then
		-- block empty
	elseif stepInterval == GswEnum.StepInterval_BatEnd then
		-- block empty
	end

	return result, tips
end

function GodStatuesWarController:getTryOpenFmtViewInGswResultAndTips(seasonId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local step = self:getCurStepOfGsw(seasonId)
	local stepInterval = self:getStepInterval(seasonId, step)

	if stepInterval == GswEnum.StepInterval_RegPre then
		result = GameEnum.ResultCode.BeforeTime
		tips = "布阵阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_Reg then
		result = GameEnum.ResultCode.BeforeTime
		tips = "布阵阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_FmtPre then
		result = GameEnum.ResultCode.BeforeTime
		tips = "布阵阶段即将开始，敬请期待！"
	elseif stepInterval == GswEnum.StepInterval_Fmt then
		-- block empty
	elseif stepInterval == GswEnum.StepInterval_AdjPre then
		result = GameEnum.ResultCode.AfterTime
		tips = "布阵阶段已结束"
	elseif stepInterval == GswEnum.StepInterval_Adj then
		result = GameEnum.ResultCode.AfterTime
		tips = "布阵阶段已结束"
	elseif stepInterval == GswEnum.StepInterval_BatPre then
		result = GameEnum.ResultCode.AfterTime
		tips = "布阵阶段已结束"
	elseif stepInterval == GswEnum.StepInterval_Bat then
		result = GameEnum.ResultCode.AfterTime
		tips = "布阵阶段已结束"
	elseif stepInterval == GswEnum.StepInterval_BatEnd then
		result = GameEnum.ResultCode.AfterTime
		tips = "布阵阶段已结束"
	end

	return result, tips
end

function GodStatuesWarController:getTryOpenAdjustViewInGswResultAndTips(seasonId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if self:isFamilyChief() then
		local step = self:getCurStepOfGsw(seasonId)
		local stepInterval = self:getStepInterval(seasonId, step)

		if stepInterval == GswEnum.StepInterval_RegPre then
			result = GameEnum.ResultCode.BeforeTime
			tips = "调整阶段即将开始，敬请期待！"
		elseif stepInterval == GswEnum.StepInterval_Reg then
			result = GameEnum.ResultCode.BeforeTime
			tips = "调整阶段即将开始，敬请期待！"
		elseif stepInterval == GswEnum.StepInterval_FmtPre then
			result = GameEnum.ResultCode.BeforeTime
			tips = "调整阶段即将开始，敬请期待！"
		elseif stepInterval == GswEnum.StepInterval_Fmt then
			result = GameEnum.ResultCode.BeforeTime
			tips = "调整阶段即将开始，敬请期待！"
		elseif stepInterval == GswEnum.StepInterval_AdjPre then
			result = GameEnum.ResultCode.BeforeTime
			tips = "调整阶段即将开始，敬请期待！"
		elseif stepInterval == GswEnum.StepInterval_Adj then
			-- block empty
		elseif stepInterval == GswEnum.StepInterval_BatPre then
			result = GameEnum.ResultCode.AfterTime
			tips = "调整阶段已结束"
		elseif stepInterval == GswEnum.StepInterval_Bat then
			result = GameEnum.ResultCode.AfterTime
			tips = "调整阶段已结束"
		elseif stepInterval == GswEnum.StepInterval_BatEnd then
			result = GameEnum.ResultCode.AfterTime
			tips = "调整阶段已结束"
		end
	else
		result = GameEnum.ResultCode.Error
		tips = "家族族长才可调配神柱防守位置"
	end

	return result, tips
end

function GodStatuesWarController:getTryOpenSignViewInGswResultAndTips(seasonId, pillarId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local step = self:getCurStepOfGsw(seasonId)
	local stepInterval = self:getStepInterval(seasonId, step)

	if not self:isFamilyChief() then
		result = GameEnum.ResultCode.Error
		tips = "家族族长才可进行标记"
	elseif stepInterval ~= GswEnum.StepInterval_Bat then
		result = GameEnum.ResultCode.Error
		tips = "不在战斗阶段内"
	end

	return result, tips
end

function GodStatuesWarController:getTryEnterFightPillarInGswResultAndTips(seasonId, pillarId, tierId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local step = self:getCurStepOfGsw(seasonId)
	local stepInterval = self:getStepInterval(seasonId, step)

	if stepInterval ~= GswEnum.StepInterval_Bat then
		result = GameEnum.ResultCode.Error
		tips = "不在战斗阶段内"
	elseif self:isMyPillar(seasonId, pillarId) then
		result = GameEnum.ResultCode.Error
		tips = "不能挑战自己所在家族"
	elseif self:isNotFightTime(seasonId) then
		result = GameEnum.ResultCode.Error
		tips = "休战时间内禁止挑战"
	elseif self:isPassPillar(seasonId, pillarId) then
		result = GameEnum.ResultCode.Error
		tips = "该神柱已被击破"
	elseif self:getTierCurHp(seasonId, pillarId, tierId) <= 0 then
		result = GameEnum.ResultCode.Error
		tips = "该层已通关"
	elseif self:getLeftDivinePillarFightTime(seasonId, step) <= 0 then
		result = GameEnum.ResultCode.Error
		tips = "剩余挑战次数不足"
	end

	return result, tips
end

function GodStatuesWarController:getTryEnterFightNestInGswResultAndTips(seasonId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local step = self:getCurStepOfGsw(seasonId)
	local stepInterval = self:getStepInterval(seasonId, step)

	if stepInterval ~= GswEnum.StepInterval_Bat then
		result = GameEnum.ResultCode.Error
		tips = "非战斗阶段不能挑战"
	elseif self:isNotFightTime(seasonId) then
		result = GameEnum.ResultCode.Error
		tips = "休战时间内禁止挑战"
	elseif self:getNestLeftFightTime(seasonId) <= 0 then
		result = GameEnum.ResultCode.Error
		tips = "剩余挑战次数不足"
	end

	return result, tips
end

function GodStatuesWarController:getTryOpenAreaEnergyRankResultAndTips(seasonId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success then
		local isInTime = GodStatuesWarController.instance:isInSeasonTime(seasonId)

		if not isInTime then
			result = GameEnum.ResultCode.Error
			tips = "新赛季战区赛的对抗阶段未开始"
		end
	end

	if result == GameEnum.ResultCode.Success then
		local stepInCur = GodStatuesWarController.instance:getCurStepOfGsw(seasonId)
		local stepIntervalInCur = GodStatuesWarController.instance:getStepInterval(seasonId, stepInCur)
		local isAreaEnergyRankOpen = stepIntervalInCur >= GswEnum.StepInterval_Bat

		if not isAreaEnergyRankOpen then
			result = GameEnum.ResultCode.Error
			tips = "战区赛暂未开始"
		end
	end

	if result == GameEnum.ResultCode.Success then
		local isRegistered = GodStatuesWarController.instance:isRegisteredOfGsw(seasonId)

		if not isRegistered then
			result = GameEnum.ResultCode.Error
			tips = "家族没有报名，无法查看"
		end
	end

	return result, tips
end

function GodStatuesWarController:getGswStepMgr(seasonId)
	return self._gswStepMgrs[seasonId]
end

function GodStatuesWarController:gswStepMgrOnEnter(seasonId)
	local stepMgr = self._gswStepMgrs[seasonId]

	if stepMgr == nil then
		self._gswStepMgrs[seasonId] = GodStatuesWarStepMgr.New(seasonId)
		self._gswStepMgrDeltas[seasonId] = 0
		stepMgr = self._gswStepMgrs[seasonId]
	end

	if not self._gswStepMgrDeltas[seasonId] then
		local curDelta = 0

		if curDelta == 0 then
			stepMgr:onEnter()
		end

		self._gswStepMgrDeltas[seasonId] = curDelta + 1

		return stepMgr
	end
end

function GodStatuesWarController:gswStepMgrOnExit(seasonId)
	local stepMgr = self._gswStepMgrs[seasonId]

	if stepMgr then
		self._gswStepMgrDeltas[seasonId] = Mathf.Max(checknumber(self._gswStepMgrDeltas[seasonId]) - 1, 0)

		if self._gswStepMgrDeltas[seasonId] <= 0 then
			stepMgr:onExit()
		end
	end
end

function GodStatuesWarController:gswStepMgrOnDestroy(seasonId)
	local stepMgr = self._gswStepMgrs[seasonId]

	if stepMgr then
		stepMgr:onDestroy()

		self._gswStepMgrDeltas[seasonId] = 0
	end
end

function GodStatuesWarController:allGswStepMgrOnDestroy()
	for seasonId, gswStepMgr in pairs(self._gswStepMgrs) do
		self:gswStepMgrOnDestroy(seasonId)
	end
end

function GodStatuesWarController:getSeasonId()
	local result = 0
	local dataList = GodStatuesWarConfig.instance:getNfbSeasonDataList()

	for i = 1, #dataList do
		local data = dataList[i]

		if self:isInSeasonTime(data.seasonId) then
			result = data.seasonId

			break
		end
	end

	return result
end

function GodStatuesWarController:getNextOpenSeasonId()
	local curSeasonId = self:getSeasonId()
	local nextSeasonId = 0
	local dataList = GodStatuesWarConfig.instance:getNfbSeasonDataList()

	for seasonId = curSeasonId + 1, #dataList do
		local data = dataList[seasonId]

		if data then
			local timePeriod = self:getSeasonTimePeriod(data.seasonId)

			if timePeriod == GameUtil.beforeTimePeriod or timePeriod == GameUtil.inTimePeriod then
				nextSeasonId = data.seasonId

				break
			end
		end
	end

	return nextSeasonId
end

function GodStatuesWarController:isInSeasonTime(seasonId)
	return self:getSeasonTimePeriod(seasonId) == GameUtil.inTimePeriod
end

function GodStatuesWarController:getSeasonTimePeriod(seasonId)
	local data = GodStatuesWarConfig.instance:getNfbSeasonData(seasonId)

	return (data or nil) and GameUtil.getTimePeriod(data.seasonStartTime, data.seasonEndTime)
end

function GodStatuesWarController:isFamilyChief()
	return FamilyModel.instance:isFamilyChief()
end

function GodStatuesWarController:getMyFamilyId()
	return FamilyModel.instance:getFamilyId()
end

function GodStatuesWarController:isMyFamilyId(familyId)
	return familyId > 0 and self:getMyFamilyId() == familyId
end

function GodStatuesWarController:getMyZoneId(seasonId)
	local areaId = RoleModel.instance:getAreaId()
	local zoneData = GodStatuesWarConfig.instance:getNfbZoneDataByAreaId(seasonId, areaId)

	return (zoneData or nil) and (zoneData.zoneId or nil)
end

function GodStatuesWarController:getGswMo(seasonId)
	return GodStatuesWarModel.instance:getGswMo(seasonId)
end

function GodStatuesWarController:getOnlyIdByFmtInfoMo(playerId, formId)
	return string.format("%s_%s", playerId, formId)
end

function GodStatuesWarController:getCurStepOfGsw(seasonId)
	return self:getCurStepByTimeStampOfGsw(seasonId, ServerTime.now())
end

function GodStatuesWarController:getStepInterval(seasonId, step)
	return self:getStepIntervalByTimeOfGsw(seasonId, step, ServerTime.now())
end

function GodStatuesWarController:getCurStepByTimeStampOfGsw(seasonId, otherTimeStamp)
	local result = 1
	local stepCfg = GodStatuesWarConfig.instance:getNfbStepCfg(seasonId)

	if stepCfg then
		for step, stepData in ipairs(stepCfg) do
			result = step

			if self:getStepIntervalByTimeOfGsw(seasonId, step, otherTimeStamp) < self:getLastStepInterval(seasonId, step) then
				break
			end
		end
	end

	return result
end

function GodStatuesWarController:getStepIntervalByTimeOfGsw(seasonId, step, otherTimeStamp)
	local stepData = GodStatuesWarConfig.instance:getNfbStepData(seasonId, step)
	local stepType = self:getStepTypeOfGsw(seasonId, step)
	local index = 1

	if stepData then
		for idx, fields in ipairs(GswEnum.StepIntervalTimeFields[stepType]) do
			index = idx * 2

			local timePeriod = GameUtil.errorTimePeriod

			if not stepData[fields[2]] then
				local startTime, endTime = stepData[fields[1]] or "", ""

				if string.nilorempty(startTime) and string.nilorempty(endTime) then
					timePeriod = GameUtil.inTimePeriod
				elseif not string.nilorempty(startTime) and not string.nilorempty(endTime) then
					timePeriod = GameUtil.getTimePeriodType(startTime, endTime)
				elseif string.nilorempty(startTime) and not string.nilorempty(endTime) then
					local timeNow = otherTimeStamp
					local timeEnd = GameUtil.string2time(endTime)

					timePeriod = timeEnd <= timeNow and GameUtil.afterTimePeriod or GameUtil.getTimePeriodTypeBySec(timeNow, timeEnd)
				elseif not string.nilorempty(startTime) and string.nilorempty(endTime) then
					local timeStart = GameUtil.string2time(startTime)
					local timeNow = otherTimeStamp

					timePeriod = timeNow < timeStart and GameUtil.beforeTimePeriod or GameUtil.getTimePeriodTypeBySec(timeStart, timeNow + 1)
				end

				if timePeriod == GameUtil.beforeTimePeriod then
					index = index - 1

					break
				elseif timePeriod == GameUtil.inTimePeriod then
					break
				elseif timePeriod == GameUtil.afterTimePeriod then
					index = index + 1
				end
			end
		end
	end

	return GswEnum.StepIntervalList[stepType][index]
end

function GodStatuesWarController:getFirstStepInterval(seasonId, step)
	local stepType = self:getStepTypeOfGsw(seasonId, step)

	return GswEnum.StepIntervalList[stepType][1]
end

function GodStatuesWarController:getLastStepInterval(seasonId, step)
	local stepType = self:getStepTypeOfGsw(seasonId, step)
	local length = #GswEnum.StepIntervalList[stepType]

	return GswEnum.StepIntervalList[stepType][length]
end

function GodStatuesWarController:getStepTypeOfGsw(seasonId, step)
	local stepData = GodStatuesWarConfig.instance:getNfbStepData(seasonId, step)

	return (stepData or nil) and (stepData.isSpace and GswEnum.StepType_Space or GswEnum.StepType_Zone)
end

function GodStatuesWarController:getStepIntervalTimeFields(seasonId, step, stepInterval)
	local stepType = self:getStepTypeOfGsw(seasonId, step)
	local list = GswEnum.StepIntervalList[stepType]
	local index = 0

	for idx, v in ipairs(list) do
		index = idx

		if v == stepInterval then
			break
		end
	end

	if index % 2 == 1 then
		index = index + 1
	end

	index = math.floor(index / 2)

	return GswEnum.StepIntervalTimeFields[stepType][index]
end

function GodStatuesWarController:isNotFightTime(seasonId)
	local data = GodStatuesWarConfig.instance:getNfbSeasonData(seasonId)
	local array = string.split(data.cannotFightTime, "#")

	return GameUtil.getTimePeriodType(array[1], array[2], true) == GameUtil.inTimePeriod
end

function GodStatuesWarController:isRegisteredOfGsw(seasonId)
	return self:getGswMo(seasonId):isRegistered()
end

function GodStatuesWarController:isCanParticipateOfGsw(seasonId)
	local code = self:getCanParticipateCode(seasonId)

	return code == GswEnum.ParticipateCode_success
end

function GodStatuesWarController:isCanFight(seasonId)
	local myFamilyStep = self:getMyFamilyStep(seasonId)
	local curStep = self:getCurStepOfGsw(seasonId)

	return myFamilyStep == curStep
end

function GodStatuesWarController:getMyFamilyStep(seasonId)
	return self:getGswMo(seasonId):getMyFamilyStep()
end

function GodStatuesWarController:getCanParticipateCode(seasonId)
	return self:getGswMo(seasonId):getCanParticipateCode()
end

function GodStatuesWarController:isEnoughFamilyLevelOfGsw()
	local limLv = self:getFamilyLevelLimitOfGsw()
	local nowLv = FamilyController.instance:getFamilyLv()

	return limLv <= nowLv
end

function GodStatuesWarController:getFamilyLevelLimitOfGsw()
	return GodStatuesWarConfig.instance:getNfbParamsValue("FAMILY_LEVEL_LIMIT", true)
end

function GodStatuesWarController:getFormInfoListOfMy(seasonId)
	return self:getGswMo(seasonId):getFormInfoListOfMy()
end

function GodStatuesWarController:getFormInfoOfMy(seasonId, id)
	return self:getGswMo(seasonId):getFormInfoOfMy(id)
end

function GodStatuesWarController:isMyPillar(seasonId, pillarId)
	local familyId = self:getFamilyIdInGroup(seasonId, pillarId)

	return self:isMyFamilyId(familyId)
end

function GodStatuesWarController:isEmptyPillar(seasonId, pillarId)
	local familyId = self:getFamilyIdInGroup(seasonId, pillarId)

	return familyId <= 0
end

function GodStatuesWarController:getFamilyIdInGroup(seasonId, pillarId)
	return self:getGswMo(seasonId):getPillarMapMo():getFamilyIdInGroup(pillarId)
end

function GodStatuesWarController:getPillarIdInGroup(seasonId, familyId)
	return self:getGswMo(seasonId):getPillarMapMo():getPillarIdInGroup(familyId)
end

function GodStatuesWarController:getEnergyInGroup(seasonId, pillarId)
	return self:getGswMo(seasonId):getPillarMapMo():getEnergyInGroup(pillarId)
end

function GodStatuesWarController:getLeftDivinePillarFightTime(seasonId, step)
	local max = self:getMaxDivinePillarFightTime(seasonId, step)
	local cur = self:getTodayDivinePillarFightTime(seasonId)

	return Mathf.Max(max - cur, 0)
end

function GodStatuesWarController:getTodayDivinePillarFightTime(seasonId)
	return self:getGswMo(seasonId):getPillarMapMo():getTodayDivinePillarFightTime()
end

function GodStatuesWarController:getMaxDivinePillarFightTime(seasonId, step)
	local stepData = GodStatuesWarConfig.instance:getNfbStepData(seasonId, step)

	return (stepData or nil) and stepData.divinePillarDailyTimes
end

function GodStatuesWarController:getNestLeftFightTime(seasonId)
	return self:getGswMo(seasonId):getPillarMapMo():getNestLeftFightTime()
end

function GodStatuesWarController:getNestMaxFightTime(seasonId, step)
	local stepData = GodStatuesWarConfig.instance:getNfbStepData(seasonId, step)

	return (stepData or nil) and stepData.maxNestFightTimes
end

function GodStatuesWarController:getFamilyNameInGroup(seasonId, pillarId)
	return self:getGswMo(seasonId):getPillarMapMo():getFamilyNameInGroup(pillarId)
end

function GodStatuesWarController:getTotalZdlInGroup(seasonId, pillarId)
	return self:getGswMo(seasonId):getPillarMapMo():getTotalZdlInGroup(pillarId)
end

function GodStatuesWarController:getFamilyEnergy(seasonId)
	return self:getGswMo(seasonId):getPillarMapMo():getFamilyEnergy()
end

function GodStatuesWarController:isAttackFlagOfFamily(seasonId, familyId)
	return familyId > 0 and familyId == self:getAttackFlagFamilyId(seasonId)
end

function GodStatuesWarController:isNoAttackFlagOfFamily(seasonId, familyId)
	return familyId > 0 and familyId == self:getNoAttackFlagFamilyId(seasonId)
end

function GodStatuesWarController:getAttackFlagFamilyId(seasonId)
	return self:getGswMo(seasonId):getPillarMapMo():getAttackFlagFamilyId()
end

function GodStatuesWarController:setAttackFlagFamilyId(seasonId, familyId)
	self:getGswMo(seasonId):getPillarMapMo():setAttackFlagFamilyId(familyId)
end

function GodStatuesWarController:getNoAttackFlagFamilyId(seasonId)
	return self:getGswMo(seasonId):getPillarMapMo():getNoAttackFlagFamilyId()
end

function GodStatuesWarController:setNoAttackFlagFamilyId(seasonId, familyId)
	self:getGswMo(seasonId):getPillarMapMo():setNoAttackFlagFamilyId(familyId)
end

function GodStatuesWarController:getMyFamilyCurTierInMap(seasonId)
	return self:getGswMo(seasonId):getPillarMapMo():getMyFamilyCurTierInMap()
end

function GodStatuesWarController:getTierCount(seasonId)
	local step = self:getCurStepOfGsw(seasonId)
	local stepData = GodStatuesWarConfig.instance:getNfbStepData(seasonId, step)
	local pillarCfg = GodStatuesWarConfig.instance:getNfbDivinePillarCfg(stepData.divinePillarPlanId)

	return (pillarCfg or nil) and (#pillarCfg or 0)
end

function GodStatuesWarController:getSeatCountInTier(seasonId, tierId)
	local step = self:getCurStepOfGsw(seasonId)
	local stepData = GodStatuesWarConfig.instance:getNfbStepData(seasonId, step)
	local pillarData = GodStatuesWarConfig.instance:getNfbDivinePillarData(stepData.divinePillarPlanId, tierId)

	return (pillarData and pillarData.creepsMasterIds or nil) and #pillarData.creepsMasterIds
end

function GodStatuesWarController:getSpInfoCtrlOfSimple(seasonId)
	return self:getGswMo(seasonId):getSpInfoCtrl()
end

function GodStatuesWarController:getOnlyIdListOfSimple(seasonId)
	return self:getGswMo(seasonId):getSpInfoCtrl():getOnlyIdList()
end

function GodStatuesWarController:getOnlyIdListInTierOfSimple(seasonId, tierId)
	return self:getGswMo(seasonId):getSpInfoCtrl():getOnlyIdListInTier(tierId)
end

function GodStatuesWarController:getOnlyIdInTierOfSimple(seasonId, tierId, seatIdx)
	return self:getGswMo(seasonId):getSpInfoCtrl():getOnlyIdInTier(tierId, seatIdx)
end

function GodStatuesWarController:getTierFmtInfoMoOfSimple(seasonId, tierId, seatIdx)
	return self:getGswMo(seasonId):getSpInfoCtrl():getTierFmtInfoMo(tierId, seatIdx)
end

function GodStatuesWarController:getTierFmtInfoMoByOnlyIdOfSimple(seasonId, onlyId)
	return self:getGswMo(seasonId):getSpInfoCtrl():getTierFmtInfoMoByOnlyId(onlyId)
end

function GodStatuesWarController:getTierIdOfSimple(seasonId, onlyId)
	return self:getGswMo(seasonId):getSpInfoCtrl():getTierId(onlyId)
end

function GodStatuesWarController:getSeatIdxOfSimple(seasonId, onlyId)
	return self:getGswMo(seasonId):getSpInfoCtrl():getSeatIdx(onlyId)
end

function GodStatuesWarController:changeTierSeatOfSimple(seasonId, onlyIdB, tierIdA, seatIdxA)
	local tierIdB, seatIdxB = self:getTierIdOfSimple(seasonId, onlyIdB), self:getSeatIdxOfSimple(seasonId, onlyIdB)
	local onlyIdA = self:getOnlyIdInTierOfSimple(seasonId, tierIdA, seatIdxA)

	self:getGswMo(seasonId):getSpInfoCtrl():setOnlyIdToTier(onlyIdA, tierIdB, seatIdxB)
	self:getGswMo(seasonId):getSpInfoCtrl():setOnlyIdToTier(onlyIdB, tierIdA, seatIdxA)
end

function GodStatuesWarController:creatMsgToReqAdjustOfSimple(seasonId)
	local req = NewFamilyBattleExtension_pb.PM_NewFamilyBattleAdjustReq()

	req.seasonId = seasonId

	local onlyIdList = self:getOnlyIdListOfSimple(seasonId)

	for _, onlyId in ipairs(onlyIdList) do
		local fmtInfoMo = self:getTierFmtInfoMoByOnlyIdOfSimple(seasonId, onlyId)

		if fmtInfoMo and fmtInfoMo:getFmtType() ~= GswEnum.FmtType_Empty then
			local mo = NewFamilyBattleExtension_pb.PM_NewFamilyBattleDivinePillarSimpleFormation()

			mo.playerId = fmtInfoMo:getPlayerId()
			mo.playerFormId = fmtInfoMo:getPlayerFormId()
			mo.playerFormId = fmtInfoMo:getPlayerFormId()
			mo.tier = self:getTierIdOfSimple(seasonId, onlyId)
			mo.formId = self:getSeatIdxOfSimple(seasonId, onlyId)

			req.formList:add():ParseFromString(mo:SerializeToString())
		end
	end

	return req
end

function GodStatuesWarController:getEnergyIncreaseInPillar(seasonId, pillarId)
	local left = self:getLeftTierCount(seasonId, pillarId)
	local rate = GodStatuesWarConfig.instance:getNfbParamsValue("ENERGY_INCREASE_RATE", true)

	return left * rate
end

function GodStatuesWarController:isPassPillar(seasonId, pillarId)
	return self:getLeftTierCount(seasonId, pillarId) <= 0
end

function GodStatuesWarController:getLeftTierCount(seasonId, pillarId)
	local left = self:getPassTierCount(seasonId, pillarId)
	local max = self:getTierCount(seasonId)

	return Mathf.Max(max - left, 0)
end

function GodStatuesWarController:getPassTierCount(seasonId, pillarId)
	local tierCount = self:getTierCount(seasonId)

	if self:isPassTier(seasonId, pillarId, tierCount) then
		return tierCount
	else
		local curTier = self:getCurFightingTier(seasonId, pillarId)

		return Mathf.Max(curTier - 1, 0)
	end
end

function GodStatuesWarController:getTierFmtInfoMo(seasonId, pillarId, tierId, seatIdx)
	local familyId = self:getFamilyIdInGroup(seasonId, pillarId)
	local pillarInfoMo = self:getGswMo(seasonId):getCpInfoCtrl():getPillarInfoMo(familyId)

	if pillarInfoMo then
		return pillarInfoMo:getTierFmtInfoMo(tierId, seatIdx)
	end
end

function GodStatuesWarController:isPassTier(seasonId, pillarId, tierId)
	local isPass = false
	local curTier = self:getCurFightingTier(seasonId, pillarId)

	if tierId <= curTier then
		local curHp = self:getTierCurHp(seasonId, pillarId, tierId)

		isPass = curHp <= 0
	end

	return isPass
end

function GodStatuesWarController:getCurFightingTier(seasonId, pillarId)
	local curTier = 0
	local tierCount = self:getTierCount(seasonId)

	for tierId = 1, tierCount do
		curTier = tierId

		local hp = self:getTierCurHp(seasonId, pillarId, tierId)

		if hp > 0 then
			break
		end
	end

	return curTier
end

function GodStatuesWarController:getTierCurHp(seasonId, pillarId, tierId)
	local familyId = self:getFamilyIdInGroup(seasonId, pillarId)
	local pillarInfoMo = self:getGswMo(seasonId):getCpInfoCtrl():getPillarInfoMo(familyId)

	return (pillarInfoMo or nil) and pillarInfoMo:getTotalCurHp(tierId)
end

function GodStatuesWarController:getTierReportInfoMoList(seasonId)
	return self:getGswMo(seasonId):getTierReportInfoMoList()
end

function GodStatuesWarController:getRankViewResMsg(seasonId)
	return self:getGswMo(seasonId):getRankViewResMsg()
end

function GodStatuesWarController:getNestResultMsg(seasonId)
	return self:getGswMo(seasonId):getNestResultMsg()
end

function GodStatuesWarController:getFightDivinePillarResMsg(seasonId)
	return self:getGswMo(seasonId):getFightDivinePillarResMsg()
end

GodStatuesWarController.instance = GodStatuesWarController.New()

return GodStatuesWarController
