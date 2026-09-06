-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/model/FamilyWarModel.lua

module("logic.extensions.newfamily.model.FamilyWarModel", package.seeall)

local FamilyWarModel = class("FamilyWarModel", BaseModel)

function FamilyWarModel:ctor()
	self._curPeriodId = nil
	self._isApplyWar = nil
	self._warBaseInfo = nil
	self._myFamilyPillarInfo = nil
	self._mplFormationInfos = nil
	self._nestBattleInfo = nil
	self._pillarBattleInfo = nil
	self._familyRankList = nil
	self._personalRankList = nil
	self._seasonRankInfo = nil
end

function FamilyWarModel:onInit()
	FamilyWarModel.super.onInit(self)
	self:onReset()
end

function FamilyWarModel:onReset()
	self._curPeriodId = nil
	self._isApplyWar = nil
	self._warBaseInfo = nil
	self._myFamilyPillarInfo = nil
	self._mplFormationInfos = nil
	self._nestBattleInfo = nil
	self._pillarBattleInfo = nil
	self._familyRankList = nil
	self._personalRankList = nil
	self._seasonRankInfo = nil
end

function FamilyWarModel:setFamilyWarPeriodId(periodId)
	self._curPeriodId = periodId
end

function FamilyWarModel:getFamilyWarPeriodId()
	return self._curPeriodId
end

function FamilyWarModel:isApplyFamilyWar()
	return self._isApplyWar
end

function FamilyWarModel:getFamilyWarBaseInfo(isReset)
	if isReset or self._warBaseInfo == nil then
		self._warBaseInfo = {}
		self._warBaseInfo.periodId = 1
		self._warBaseInfo.nestAttackTimes = 0
		self._warBaseInfo.pillarAttackTimes = 0
		self._warBaseInfo.pillarInfos = {}
		self._warBaseInfo.myFamilyId = 0
		self._warBaseInfo.myEnergy = 0
		self._warBaseInfo.flagFamilyId = 0
		self._warBaseInfo.noFlagFamilyId = 0
		self._warBaseInfo.nestPlanIds = {
			0,
			0,
			0,
			0
		}
	end

	return self._warBaseInfo
end

function FamilyWarModel:isFamilyWarFuncUnlock()
	local limLv = FamilyWarConfig.instance:getFamilyWarLimitLevel()
	local nowLv = FamilyController.instance:getFamilyLv()

	return limLv <= nowLv
end

function FamilyWarModel:isFamilyWarFuncOpen()
	local actId = FamilyWarConfig.instance:getOpenActivityId()

	return checknumber(actId) > 0
end

function FamilyWarModel:getFamilyWarFuncOpenDes()
	local fsType, cfg = self:getFamilyWarFuncStage()

	if fsType == FamilyWarController.FuncStageType.None or cfg == nil then
		cfg = FamilyWarConfig.instance:getNextOpenActivityCfg()

		if cfg == nil then
			return false, "活动已结束"
		else
			return false, self:_getFamilyWarOpenTimeStr("下期时间：", cfg.registrationStageStartTime, cfg.battleStageEndTime)
		end
	end

	if fsType == FamilyWarController.FuncStageType.Apply then
		return true, self:_getFamilyWarOpenTimeStr("报名阶段：", cfg.registrationStageStartTime, cfg.registrationStageEndTime)
	end

	if fsType == FamilyWarController.FuncStageType.Formation or fsType == FamilyWarController.FuncStageType.ApplyEnd then
		return true, self:_getFamilyWarOpenTimeStr("布阵阶段：", cfg.formationStageStartTime, cfg.formationStageEndTime)
	end

	if fsType == FamilyWarController.FuncStageType.Adjustment or fsType == FamilyWarController.FuncStageType.FormationEnd then
		return true, self:_getFamilyWarOpenTimeStr("调整阶段：", cfg.adjustmentStageStartTime, cfg.adjustmentStageEndTime)
	end

	if fsType == FamilyWarController.FuncStageType.Battle or fsType == FamilyWarController.FuncStageType.AdjustmentEnd then
		return true, self:_getFamilyWarOpenTimeStr("对战阶段：", cfg.battleStageStartTime, cfg.battleStageEndTime)
	end

	return false, "活动已结束"
end

function FamilyWarModel:_getFamilyWarOpenTimeStr(name, sTime, eTime)
	local startTime = GameUtil.string2time(sTime)
	local startDate = GameUtil.time2date(startTime)
	local endTime = GameUtil.string2time(eTime)
	local endDate = GameUtil.time2date(endTime)

	return (string.format("%s%s-%02d-%02d %02d点 至 %s-%02d-%02d %02d点", name, startDate.year, startDate.month, startDate.day, startDate.hour, endDate.year, endDate.month, endDate.day, endDate.hour))
end

function FamilyWarModel:getFamilyWarFuncStage()
	local actId = FamilyWarConfig.instance:getOpenActivityId()

	if checknumber(actId) <= 0 then
		return FamilyWarController.FuncStageType.None, nil
	end

	local cfg = FamilyWarConfig.instance:getFamilyWarPeriodCfg(actId)

	if cfg == nil then
		return FamilyWarController.FuncStageType.None, nil
	end

	if GameUtil.checkIsInTimePeriod(cfg.registrationStageStartTime, cfg.registrationStageEndTime) then
		return FamilyWarController.FuncStageType.Apply, cfg
	end

	if cfg.registrationStageEndTime ~= cfg.formationStageStartTime and GameUtil.checkIsInTimePeriod(cfg.registrationStageEndTime, cfg.formationStageStartTime) then
		return FamilyWarController.FuncStageType.ApplyEnd, cfg
	end

	if GameUtil.checkIsInTimePeriod(cfg.formationStageStartTime, cfg.formationStageEndTime) then
		return FamilyWarController.FuncStageType.Formation, cfg
	end

	if cfg.formationStageEndTime ~= cfg.adjustmentStageStartTime and GameUtil.checkIsInTimePeriod(cfg.formationStageEndTime, cfg.adjustmentStageStartTime) then
		return FamilyWarController.FuncStageType.FormationEnd, cfg
	end

	if GameUtil.checkIsInTimePeriod(cfg.adjustmentStageStartTime, cfg.adjustmentStageEndTime) then
		return FamilyWarController.FuncStageType.Adjustment, cfg
	end

	if cfg.adjustmentStageEndTime ~= cfg.battleStageStartTime and GameUtil.checkIsInTimePeriod(cfg.adjustmentStageEndTime, cfg.battleStageStartTime) then
		return FamilyWarController.FuncStageType.AdjustmentEnd, cfg
	end

	if GameUtil.checkIsInTimePeriod(cfg.battleStageStartTime, cfg.battleStageEndTime) then
		return FamilyWarController.FuncStageType.Battle, cfg
	end

	return FamilyWarController.FuncStageType.None, nil
end

function FamilyWarModel:getFamilyWarPillarSign()
	if self._warBaseInfo == nil then
		return 0, 0
	end

	return checknumber(self._warBaseInfo.flagFamilyId), checknumber(self._warBaseInfo.noFlagFamilyId)
end

function FamilyWarModel:getMyFamilyPillarFormationInfo(userId)
	if self._mplFormationInfos == nil or self._mplFormationInfos[prizeId] == nil then
		return false, nil
	end

	local info = self._mplFormationInfos[prizeId]

	if info[userId] == nil or not info[userId].isRequest then
		return false, nil
	end

	return true, info[userId]
end

function FamilyWarModel:getNestBattleInfo()
	if self._nestBattleInfo == nil or self._nestBattleInfo.periodId == nil then
		return nil
	end

	local cfg = FamilyWarConfig.instance:getFamilyWarPeriodCfg(self._nestBattleInfo.periodId)

	if cfg == nil or cfg.nestPlanId == nil then
		return nil
	end

	cfg = FamilyWarConfig.instance:getFamilyBattleNestCfgs(cfg.nestPlanId, self._nestBattleInfo.nestId)

	if cfg == nil or cfg.nestConditionPlanId == nil then
		return nil
	end

	local allCfgs = FamilyWarConfig.instance:getFamilyNestConditionCfgs(cfg.nestConditionPlanId)

	if allCfgs == nil or #allCfgs == 0 then
		return nil
	end

	local nestInfo = self._nestBattleInfo.challengeNestInfo
	local targetList = {}

	for i = 1, #allCfgs do
		if allCfgs[i] and not string.nilorempty(allCfgs[i].desc) then
			local data = {
				isFinish = false,
				desc = allCfgs[i].desc
			}

			if nestInfo and nestInfo.achieveNestConditionIds and table.indexof(nestInfo.achieveNestConditionIds, allCfgs[i].nestConditionId) then
				data.isFinish = true
			end

			table.insert(targetList, data)
		end
	end

	return targetList
end

function FamilyWarModel:getFamilyWarFamilyRankList()
	return self._familyRankList
end

function FamilyWarModel:getFamilyWarPersonalRankList()
	return self._personalRankList
end

function FamilyWarModel:getFamilyNestMonsterPlanId(nestId)
	if self._warBaseInfo == nil or self._warBaseInfo.nestPlanIds == nil then
		return 0
	end

	return checknumber(self._warBaseInfo.nestPlanIds[nestId])
end

function FamilyWarModel:getFamilySeasonByType(srType)
	local allCfgs = FamilyWarConfig.instance:getFamilySeasonRankCfg(srType)

	if allCfgs == nil or #allCfgs == 0 then
		return nil
	end

	for i = 1, #allCfgs do
		if allCfgs[i] and GameUtil.checkIsInTimePeriod(allCfgs[i].startTime, allCfgs[i].endTime) then
			return allCfgs[i]
		end
	end

	return nil
end

function FamilyWarModel:getFamilySeasonIdByType(srType)
	local cfg = self:getFamilySeasonByType(srType)

	return (cfg or nil) and cfg.seasonId
end

function FamilyWarModel:getFamilyWarRedpoint()
	if not self:isFamilyWarFuncUnlock() then
		return false
	end

	if not self:getFamilyWarFuncOpenDes() then
		return false
	end

	local stageType, cfg = self:getFamilyWarFuncStage()

	if stageType == FamilyWarController.FuncStageType.None or stageType == FamilyWarController.FuncStageType.ApplyEnd or cfg == nil or stageType == FamilyWarController.FuncStageType.FormationEnd or stageType == FamilyWarController.FuncStageType.AdjustmentEnd then
		return false
	end

	local value = GameUtil.getUserDayData("FamilyWarRedpoint")

	return checknumber(value) ~= 1
end

function FamilyWarModel:scPushFamilyBattleGetInfo(msg)
	self:getFamilyWarBaseInfo(true)

	self._warBaseInfo.nestPlanIds = {
		0,
		0,
		0,
		0
	}

	if msg == nil or msg.periodId == nil then
		return
	end

	self._warBaseInfo.periodId = checknumber(msg.periodId)
	self._warBaseInfo.nestAttackTimes = checknumber(msg.nestAttackTimes)
	self._warBaseInfo.pillarAttackTimes = checknumber(msg.divinePillarAttackTimes)
	self._warBaseInfo.myFamilyId = checknumber(msg.myFamilyId)
	self._warBaseInfo.myEnergy = checknumber(msg.myEnergy)
	self._warBaseInfo.flagFamilyId = checknumber(msg.attackFlagFamilyId)
	self._warBaseInfo.noFlagFamilyId = checknumber(msg.noAttackFlagFamilyId)

	if msg.outsideInfos == nil or #msg.outsideInfos == 0 then
		return
	end

	for i = 1, #msg.outsideInfos do
		if msg.outsideInfos[i] and checknumber(msg.outsideInfos[i].familyId) > 0 then
			table.insert(self._warBaseInfo.pillarInfos, {
				familyId = msg.outsideInfos[i].familyId,
				familyName = msg.outsideInfos[i].familyName,
				totalEnergy = msg.outsideInfos[i].totalEnergy
			})
		end
	end
end

function FamilyWarModel:scPushFamilyBattleViewDivinePillarTierFormationInfo(msg)
	self._mplFormationInfos = self._mplFormationInfos or {}

	if msg == nil or msg.periodId == nil then
		return
	end

	self._mplFormationInfos[msg.periodId] = self._mplFormationInfos[msg.periodId] or {}
	self._mplFormationInfos[msg.periodId][msg.targetUserId] = {}
	self._mplFormationInfos[msg.periodId][msg.targetUserId].targetUserId = msg.targetUserId
	self._mplFormationInfos[msg.periodId][msg.targetUserId].playerView = msg.playerView
	self._mplFormationInfos[msg.periodId][msg.targetUserId].zdl = msg.zdl
	self._mplFormationInfos[msg.periodId][msg.targetUserId].speed = msg.speed
	self._mplFormationInfos[msg.periodId][msg.targetUserId].isRequest = true
end

function FamilyWarModel:scPushFamilyBattleSetFlag(msg)
	self._warBaseInfo.flagFamilyId = checknumber(msg.attackFlagFamilyId)
	self._warBaseInfo.noFlagFamilyId = checknumber(msg.noAttackFlagFamilyId)
end

function FamilyWarModel:scPushFamilyBattleGetRegistrationInfo(isBool)
	self._isApplyWar = isBool
end

function FamilyWarModel:scPushSaveFamilyBattleFormation(msg)
	return
end

function FamilyWarModel:scPushFamilyBattleViewRank(msg)
	self._familyRankList = msg.rankInfos
end

function FamilyWarModel:scPushFamilyBattleViewUserRank(msg)
	self._personalRankList = msg.userRankInfos
end

function FamilyWarModel:scPushFamilyBattleChallengeNestResult(msg)
	self._pillarBattleInfo = nil
	self._nestBattleInfo = msg
end

function FamilyWarModel:scPushFamilyBattleChallengeDivinePillarResult(msg)
	self._nestBattleInfo = nil
	self._pillarBattleInfo = msg
end

function FamilyWarModel:scPushFamilyBattleGetNestInfo(nestId, planId)
	if self._warBaseInfo == nil then
		self:getFamilyWarBaseInfo()
	end

	self._warBaseInfo.nestPlanIds = self._warBaseInfo.nestPlanIds or {}
	self._warBaseInfo.nestPlanIds[nestId] = planId
end

FamilyWarModel.instance = FamilyWarModel.New()

return FamilyWarModel
