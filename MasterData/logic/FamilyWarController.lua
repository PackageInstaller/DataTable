-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/controller/FamilyWarController.lua

module("logic.extensions.newfamily.controller.FamilyWarController", package.seeall)

local FamilyWarController = class("FamilyWarController", BaseController)

FamilyWarController.SeasonRankType = {
	Season = 1,
	War = 2,
	Suppress = 3
}
FamilyWarController.PillarRankType = {
	Personal = 3,
	Family = 1,
	Award = 2
}
FamilyWarController.FuncStageType = {
	Adjustment = 3,
	Formation = 2,
	Apply = 1,
	Battle = 4,
	FormationEnd = -2,
	ApplyEnd = -1,
	AdjustmentEnd = -3,
	None = 0
}

function FamilyWarController:ctor()
	self._curRankType = nil
end

function FamilyWarController:onInit()
	FamilyWarController.super.onInit(self)
	self:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._tickDailyRefreshData, self)
end

function FamilyWarController:onReset()
	self._curRankType = nil
end

function FamilyWarController:_tickDailyRefreshData()
	local periodId = FamilyWarModel.instance:getFamilyWarPeriodId()
	local curId = FamilyWarConfig.instance:getOpenActivityId()

	if checknumber(periodId) > 0 and periodId ~= curId then
		FamilyWarModel.instance:onReset()
	end

	if checknumber(curId) <= 0 then
		FamilyWarModel.instance:setFamilyWarPeriodId()
		GlobalDispatcher:dispatch(GlobalNotify.UpdataFamilyWarEnd)

		return
	end

	FamilyWarModel.instance:setFamilyWarPeriodId(curId)
end

function FamilyWarController:openFamilyWarMianView()
	local isUnlock = FamilyWarModel.instance:isFamilyWarFuncUnlock()

	if not isUnlock then
		FloatWordMgr.instance:show(string.format("家族等级%s级开启！", FamilyWarConfig.instance:getFamilyWarLimitLevel()))

		return
	end

	local isOpen, strDes = FamilyWarModel.instance:getFamilyWarFuncOpenDes()

	if not isOpen then
		FloatWordMgr.instance:show(strDes)

		return
	end

	local stageType, cfg = FamilyWarModel.instance:getFamilyWarFuncStage()

	if stageType == FamilyWarController.FuncStageType.None or cfg == nil then
		FloatWordMgr.instance:show("活动还未开始")

		return
	end

	local value = GameUtil.getUserDayData("FamilyWarRedpoint")

	if checknumber(value) ~= 1 then
		GameUtil.saveUserDayData("FamilyWarRedpoint", 1)
		RedPointModel.instance:updateAllRedPoint()
	end

	local nowTime = ServerTime.now()
	local isApply = FamilyWarModel.instance:isApplyFamilyWar()

	if stageType == FamilyWarController.FuncStageType.Apply then
		if not isApply then
			if FamilyModel.instance:isFamilyChief() then
				local timer = GameUtil.string2time(cfg.registrationStageEndTime)
				local date = GameUtil.time2date(timer)
				local des = string.format("当前家族未报名，是否报名参加神柱之战？\n报名结束时间：%s-%02d-%02d %02d:00", date.year, date.month, date.day, date.hour)

				TipsFacade.instance:openPopupWindow("提示", des, function()
					local need = FamilyWarConfig.instance:getFamilyWarCommonParam("MEMBER_NUM_LIMIT")
					local info = FamilyModel.instance:getMyFamilyInfo()

					if checknumber(info.memberCount) < checknumber(need) then
						FloatWordMgr.instance:show(string.format("当前参战的人数不足，神柱之战需要%s人才能参加！", need))

						return
					end

					self:csRequestFamilyBattleRegisteringReq()
				end, function()
					return
				end, "报名", "取消", UnityEngine.TextAnchor.MiddleCenter)
			else
				TipsFacade.instance:openTipWindow("提示", "当前家族未报名，请告知族长或副族长报名参加神柱之战。", nil, "关闭", UnityEngine.TextAnchor.MiddleCenter)
			end
		else
			local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(GameUtil.string2time(cfg.formationStageStartTime) - nowTime)
			local des

			TipsFacade.instance:openTipWindow("提示", day > 0 and string.format("已报名，距离布阵阶段剩余时间：%s天%s时！", day, hour) or string.format("已报名，距离布阵阶段剩余时间：%s时%s分！", hour, min), nil, "关闭", UnityEngine.TextAnchor.MiddleCenter)
		end

		return
	end

	if not isApply then
		FloatWordMgr.instance:show("当前家族未报名，请下次提前参加！")

		return
	end

	if stageType == FamilyWarController.FuncStageType.Formation then
		UIStateManager.instance:push(ViewName.FamilyWarMain)

		local des
		local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(GameUtil.string2time(cfg.battleStageStartTime) - nowTime)

		TipsFacade.instance:openPopupWindow("提示", day > 0 and string.format("距离开战剩余时间：%s天%s时！\n当前可以进行布置您的神柱守阵！", day, hour) or string.format("距离开战剩余时间：%s时%s分！\n当前可以进行布置您的神柱守阵！", hour, min), function()
			self:csRequestFamilyBattleGetFormationReq()
		end, function()
			return
		end, "布阵", "关闭", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	if stageType == FamilyWarController.FuncStageType.Adjustment then
		if FamilyModel.instance:isFamilyChief() then
			UIStateManager.instance:push(ViewName.FamilyWarPillar, cfg.divinePillarPlanId)
		else
			UIStateManager.instance:push(ViewName.FamilyWarMain)

			local des
			local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(GameUtil.string2time(cfg.battleStageStartTime) - nowTime)

			TipsFacade.instance:openTipWindow("提示", day > 0 and string.format("距离开战剩余时间：%s天%s时！\n当前家族族长可调配神柱防守位置！", day, hour) or string.format("距离开战剩余时间：%s时%s分！\n当前家族族长可调配神柱防守位置！", hour, min), nil, "关闭", UnityEngine.TextAnchor.MiddleCenter)
		end

		return
	end

	if stageType == FamilyWarController.FuncStageType.Battle then
		UIStateManager.instance:push(ViewName.FamilyWarMain)

		return
	end

	if stageType == FamilyWarController.FuncStageType.ApplyEnd then
		local timer = GameUtil.string2time(cfg.formationStageStartTime)
		local date = GameUtil.time2date(timer)

		FloatWordMgr.instance:show(string.format("布阵开始时间：%s月%s日 %02d点", date.month, date.day, date.hour))
	elseif stageType == FamilyWarController.FuncStageType.FormationEnd then
		local timer = GameUtil.string2time(cfg.adjustmentStageStartTime)
		local date = GameUtil.time2date(timer)

		FloatWordMgr.instance:show(string.format("调整开始时间：%s月%s日 %02d点", date.month, date.day, date.hour))
	elseif stageType == FamilyWarController.FuncStageType.AdjustmentEnd then
		local timer = GameUtil.string2time(cfg.battleStageStartTime)
		local date = GameUtil.time2date(timer)

		FloatWordMgr.instance:show(string.format("战斗开始时间：%s月%s日 %02d点", date.month, date.day, date.hour))
	end
end

function FamilyWarController:csRequestFamilyBattleGetInfoReq()
	local periodId = FamilyWarModel.instance:getFamilyWarPeriodId()

	if checknumber(periodId) <= 0 then
		return false
	end

	local fsType = FamilyWarModel.instance:getFamilyWarFuncStage()

	if fsType == FamilyWarController.FuncStageType.None or fsType == FamilyWarController.FuncStageType.Apply or fsType == FamilyWarController.FuncStageType.ApplyEnd then
		return false
	end

	FamilyBattleAgent.instance:sendPM_FamilyBattleGetInfoReq(periodId)

	return true
end

function FamilyWarController:scPushFamilyBattleGetInfo(msg)
	FamilyWarModel.instance:scPushFamilyBattleGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataFamilyWarBaseInfo)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataFamilyActivityItem, GameEnum.FamilyActivityType.FamilyWar)
end

function FamilyWarController:csRequestFamilyBattleGetRegistrationInfoReq()
	self:_tickDailyRefreshData()

	if not FamilyWarModel.instance:isFamilyWarFuncUnlock() then
		return
	end

	if not FamilyWarModel.instance:isFamilyWarFuncOpen() then
		return
	end

	local periodId = FamilyWarModel.instance:getFamilyWarPeriodId()

	if checknumber(periodId) <= 0 then
		return
	end

	if FamilyWarModel.instance:isApplyFamilyWar() then
		self:csRequestFamilyBattleGetInfoReq()

		return
	end

	FamilyBattleAgent.instance:sendPM_FamilyBattleGetRegistrationInfoReq(periodId)
end

function FamilyWarController:scPushFamilyBattleGetRegistrationInfo(msg)
	FamilyWarModel.instance:scPushFamilyBattleGetRegistrationInfo(msg.registered)

	if msg and msg.registered and not self:csRequestFamilyBattleGetInfoReq() then
		GlobalDispatcher:dispatch(GlobalNotify.UpdataFamilyActivityItem, GameEnum.FamilyActivityType.FamilyWar)
	end
end

function FamilyWarController:csRequestFamilyBattleRegisteringReq()
	local periodId = FamilyWarModel.instance:getFamilyWarPeriodId()

	if checknumber(periodId) <= 0 then
		return
	end

	FamilyBattleAgent.instance:sendPM_FamilyBattleRegisteringReq(periodId)
end

function FamilyWarController:scPushFamilyBattleRegistering()
	FamilyWarModel.instance:scPushFamilyBattleGetRegistrationInfo(true)
	FloatWordMgr.instance:show("报名成功！")
	GlobalDispatcher:dispatch(GlobalNotify.UpdataFamilyActivityItem, GameEnum.FamilyActivityType.FamilyWar)
end

function FamilyWarController:csRequestFamilyBattleGetFormationReq()
	local periodId = FamilyWarModel.instance:getFamilyWarPeriodId()

	if checknumber(periodId) <= 0 then
		return
	end

	FamilyBattleAgent.instance:sendPM_FamilyBattleGetFormationReq(periodId)
end

function FamilyWarController:scPushFamilyBattleGetFormation(msg)
	FormationNewModel.instance:setFamilyWarTeam(msg.form)
	UIStateManager.instance:push(ViewName.FamilyWarFmt)
end

function FamilyWarController:csRequestFamilyBattleSetFormationReq()
	local periodId = FamilyWarModel.instance:getFamilyWarPeriodId()

	if checknumber(periodId) <= 0 then
		return
	end

	local formInfo = FormationNewModel.instance:GetCurTeam():GetCurFormation()
	local req = FamilyBattleExtension_pb.PM_FamilyBattleSetFormationReq()

	req.periodId = periodId

	formInfo:createFormPb(req.form)
	FamilyBattleAgent.instance:sendPM_FamilyBattleSetFormationReq(req)
end

function FamilyWarController:scPushFamilyBattleSetFormation(msg)
	FloatWordMgr.instance:show("布阵成功！")
	FamilyWarModel.instance:scPushSaveFamilyBattleFormation(msg)
end

function FamilyWarController:csRequestFamilyBattleGetDivinePillarInfoReq()
	local periodId = FamilyWarModel.instance:getFamilyWarPeriodId()

	if checknumber(periodId) <= 0 then
		return
	end

	FamilyBattleAgent.instance:sendPM_FamilyBattleGetDivinePillarInfoReq(periodId)
end

function FamilyWarController:scPushFamilyBattleGetDivinePillarInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataFamilyWarMyPillarInfo, msg.tierInfos)
end

function FamilyWarController:csRequestFamilyBattleViewDivinePillarTierFormationInfoReq(userId)
	local periodId = FamilyWarModel.instance:getFamilyWarPeriodId()

	if checknumber(periodId) <= 0 then
		return
	end

	local isRequest, info = FamilyWarModel.instance:getMyFamilyPillarFormationInfo(userId)

	if not isRequest or info == nil then
		FamilyBattleAgent.instance:sendPM_FamilyBattleViewDivinePillarTierFormationInfoReq(periodId, userId)
	else
		GlobalDispatcher:dispatch(GlobalNotify.UpdataFamilyPillarFormationInfo, info)
	end
end

function FamilyWarController:scPushFamilyBattleViewDivinePillarTierFormationInfo(msg)
	FamilyWarModel.instance:scPushFamilyBattleViewDivinePillarTierFormationInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataFamilyPillarFormationInfo, msg)
end

function FamilyWarController:csRequestFamilyBattleAdjustReq(pos, userId)
	local periodId = FamilyWarModel.instance:getFamilyWarPeriodId()

	if checknumber(periodId) <= 0 then
		return
	end

	FamilyBattleAgent.instance:sendPM_FamilyBattleAdjustReq(periodId, pos, userId)
end

function FamilyWarController:scPushFamilyBattleAdjust(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataFamilyPillarReplaceInfo)
	self:csRequestFamilyBattleGetDivinePillarInfoReq()
end

function FamilyWarController:csRequestFamilyBattleChallengeNestReq(nestId)
	local periodId = FamilyWarModel.instance:getFamilyWarPeriodId()

	if checknumber(periodId) <= 0 then
		FloatWordMgr.instance:show("当前挑战阶段已结束！")

		if ViewMgr.instance:isOpen(ViewName.FWPNMission) then
			UIStateManager.instance:clear(true)
		end

		return
	end

	FamilyBattleAgent.instance:sendPM_FamilyBattleChallengeNestReq(periodId, nestId)
end

function FamilyWarController:scPushFamilyBattleChallengeNestResult(msg)
	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.FamilyWar)
	FamilyWarModel.instance:scPushFamilyBattleChallengeNestResult(msg)
end

function FamilyWarController:csRequestFamilyBattleChallengeDivinePillarReq(familyId)
	local periodId = FamilyWarModel.instance:getFamilyWarPeriodId()

	if checknumber(periodId) <= 0 then
		FloatWordMgr.instance:show("当前挑战阶段已结束！")

		if ViewMgr.instance:isOpen(ViewName.FWPNMission) then
			UIStateManager.instance:clear(true)
		end

		return
	end

	FamilyBattleAgent.instance:sendPM_FamilyBattleChallengeDivinePillarReq(periodId, familyId)
end

function FamilyWarController:scPushFamilyBattleChallengeDivinePillarResult(msg)
	FamilyWarModel.instance:scPushFamilyBattleChallengeDivinePillarResult(msg)
end

function FamilyWarController:csRequestFamilyBattleGetNestInfoReq(nestId)
	local periodId = FamilyWarModel.instance:getFamilyWarPeriodId()

	if checknumber(periodId) <= 0 then
		return
	end

	FamilyBattleAgent.instance:sendPM_FamilyBattleGetNestInfoReq(periodId, nestId)
end

function FamilyWarController:scPushFamilyBattleGetNestInfo(msg)
	FamilyWarModel.instance:scPushFamilyBattleGetNestInfo(msg.nestId, msg.nestMonsterId)

	local periodId = FamilyWarModel.instance:getFamilyWarPeriodId()

	if checknumber(periodId) <= 0 then
		return
	end

	local periodCfg = FamilyWarConfig.instance:getFamilyWarPeriodCfg(periodId)
	local nestCfg = FamilyWarConfig.instance:getFamilyBattleNestCfgs(periodCfg.nestPlanId, msg.nestId)
	local cfg = FamilyWarConfig.instance:getFamilyNestEnemyCfg(nestCfg.nestMonsterPlanId, msg.nestMonsterId)

	if cfg == nil or cfg.creepsMasterId == 0 then
		return
	end

	UIStateManager.instance:push(ViewName.FWPNMission, {
		isNest = true,
		enemyId = cfg.creepsMasterId,
		tempId = msg.nestId,
		name = nestCfg.name
	})
end

function FamilyWarController:csRequestFamilyBattleGetDivinePillarChanglleInfoReq(familyId)
	local periodId = FamilyWarModel.instance:getFamilyWarPeriodId()

	if checknumber(periodId) <= 0 then
		return
	end

	FamilyBattleAgent.instance:sendPM_FamilyBattleGetDivinePillarChanglleInfoReq(periodId, familyId)
end

function FamilyWarController:scPushFamilyBattleGetDivinePillarChanglleInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataFamilyWarPillarChanglleInfo, msg)
end

function FamilyWarController:csRequestFamilyBattleSetFlagReq(flagFamilyId, noFlagFamilyId)
	local periodId = FamilyWarModel.instance:getFamilyWarPeriodId()

	if checknumber(periodId) <= 0 then
		return
	end

	flagFamilyId = checknumber(flagFamilyId)
	noFlagFamilyId = checknumber(noFlagFamilyId)

	FamilyBattleAgent.instance:sendPM_FamilyBattleSetFlagReq(periodId, flagFamilyId, noFlagFamilyId)
end

function FamilyWarController:scPushFamilyBattleSetFlag(msg)
	FamilyWarModel.instance:scPushFamilyBattleSetFlag(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataFamilyWarPillarSign, msg.attackFlagFamilyId, msg.noAttackFlagFamilyId)
end

function FamilyWarController:csRequestFamilyBattleGetReportInfoReq()
	local periodId = FamilyWarModel.instance:getFamilyWarPeriodId()

	if checknumber(periodId) <= 0 then
		return
	end

	FamilyBattleAgent.instance:sendPM_FamilyBattleGetReportInfoReq(periodId)
end

function FamilyWarController:scPushFamilyBattleGetReportInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataFamilyWarReportInfo, msg.reportInfos)
end

function FamilyWarController:csRequestFamilyBattleViewRankReq(srType, isRequest)
	local periodId = FamilyWarModel.instance:getFamilyWarPeriodId()

	if checknumber(periodId) <= 0 then
		return
	end

	self._curRankType = srType

	local data = FamilyWarModel.instance:getFamilyWarFamilyRankList()

	if isRequest or data == nil then
		FamilyBattleAgent.instance:sendPM_FamilyBattleViewRankReq(periodId)

		return true
	else
		GlobalDispatcher:dispatch(GlobalNotify.UpdataFamilyPillarRankInfo, self._curRankType, data)

		self._curRankType = nil

		return false
	end
end

function FamilyWarController:scPushFamilyBattleViewRank(msg)
	FamilyWarModel.instance:scPushFamilyBattleViewRank(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataFamilyPillarRankInfo, self._curRankType, msg.rankInfos)

	self._curRankType = nil
end

function FamilyWarController:csRequestFamilyBattleViewUserRankReq(srType, isRequest)
	local periodId = FamilyWarModel.instance:getFamilyWarPeriodId()

	if checknumber(periodId) <= 0 then
		return
	end

	self._curRankType = srType

	local data = FamilyWarModel.instance:getFamilyWarPersonalRankList()

	if isRequest or data == nil then
		FamilyBattleAgent.instance:sendPM_FamilyBattleViewUserRankReq(periodId)

		return true
	else
		GlobalDispatcher:dispatch(GlobalNotify.UpdataFamilyPillarRankInfo, self._curRankType, data)

		self._curRankType = nil

		return false
	end
end

function FamilyWarController:scPushFamilyBattleViewUserRank(msg)
	FamilyWarModel.instance:scPushFamilyBattleViewUserRank(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataFamilyPillarRankInfo, self._curRankType, msg.userRankInfos)

	self._curRankType = nil
end

function FamilyWarController:csRequestFamilySeasonRankViewRankReq(srType, seasonId)
	FamilySeasonRankAgent.instance:sendPM_FamilySeasonRankViewRankReq(checknumber(srType), seasonId)
end

function FamilyWarController:scPushFamilySeasonRankViewRank(msg)
	FamilySeasonRankModel.instance:scPushFamilySeasonRankViewRank(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataFamilySeasonRankInfo, msg)
end

function FamilyWarController:sendPM_FamilySeasonRankViewNewRankReq(rankType, seasonId)
	FamilySeasonRankAgent.instance:sendPM_FamilySeasonRankViewNewRankReq(rankType, seasonId)
end

function FamilyWarController:handlePM_FamilySeasonRankViewNewRankRes(msg)
	FamilySeasonRankModel.instance:handlePM_FamilySeasonRankViewNewRankRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_FamilySeasonRankViewNewRankRes)

	local leaf = 1

	if msg.rankType == FamilySeasonRankEnum.RankType_Total then
		leaf = 1
	elseif msg.rankType == FamilySeasonRankEnum.RankType_FamilyHoudingClg then
		leaf = 4
	elseif msg.rankType == FamilySeasonRankEnum.StepType_GodStatuesWarZone then
		leaf = 2
	elseif msg.rankType == FamilySeasonRankEnum.StepType_GodStatuesWarSpace then
		leaf = 3
	end

	RankModel.instance:setRankData(msg, GameEnum.RankType.FamilyTeamPlay, leaf)
	GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
end

function FamilyWarController:getSeasonIdOfNfsRank()
	local result = 0
	local dataList = FamilySeasonRankConfig.instance:getNfsSeasonDataList()

	for i = #dataList, 1, -1 do
		local data = dataList[i]

		if self:isInSeasonTimeOfNfsRank(data.seasonId) then
			result = data.seasonId

			break
		end
	end

	return result
end

function FamilyWarController:isInSeasonTimeOfNfsRank(seasonId)
	return self:getSeasonTimePeriodOfNfsRank(seasonId) == GameUtil.inTimePeriod
end

function FamilyWarController:getSeasonTimePeriodOfNfsRank(seasonId)
	local data = FamilySeasonRankConfig.instance:getNfsSeasonData(seasonId)

	return (data or nil) and GameUtil.getTimePeriod(data.startTime, data.endTime)
end

FamilyWarController.instance = FamilyWarController.New()

return FamilyWarController
