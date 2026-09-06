-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmengmeng/model/KingmmModel.lua

module("logic.extensions.kingmengmeng.model.KingmmModel", package.seeall)

local KingmmModel = class("KingmmModel", BaseModel)

KingmmModel.ElementChallenge = 1
KingmmModel.GuardChallenge = 2
KingmmModel.BossChallenge = 3

function KingmmModel:onInit()
	self:onReset()
end

function KingmmModel:onReset()
	self._formId = 0
	self._randomInfo = {}
	self._randomInfo.buffId = 0
	self._randomInfo.formCheckId = 0
	self._randomInfo.conditionId = 0
	self._todayChallengeTimes = 0
	self._curScore = 0
	self._gainPrizeIds = {}
	self._todayResetTimes = 0
	self._damage = 0
	self._isPass = false
	self._passElementStageIds = {}
	self._passGuardStageIds = {}
	self._lockRaceIds = {}
	self._isPassBossStage = false
	self._isGainPassPrize = false
	self._type = 0
	self._stageId = 0
	self._isWin = false
	self._customFmtMo = nil
	self._extremeFmtMo = nil
end

function KingmmModel:onGetCommonInfoRes(msg)
	self._formId = msg.formId
	self._randomInfo.buffId = msg.randomInfo.buffId
	self._randomInfo.formCheckId = msg.randomInfo.formCheckId
	self._randomInfo.conditionId = msg.randomInfo.conditionId
	self._todayChallengeTimes = msg.todayChallengeTimes
	self._curScore = checknumber(msg.curScore)
	self._gainPrizeIds = GameUtil.pbToTable(msg.gainPrizeIds) or self._gainPrizeIds
	self._todayResetTimes = msg.todayResetTimes
end

function KingmmModel:onCommonChallengeRes(msg)
	return
end

function KingmmModel:onNotifyCommonChallengeRes(msg)
	self._todayChallengeTimes = msg.todayChallengeTimes
	self._curScore = checknumber(msg.curScore)
	self._damage = msg.damage
	self._isPass = msg.isPass

	if msg.isPass then
		self._formId = msg.formId
		self._randomInfo.buffId = msg.randomInfo.buffId
		self._randomInfo.formCheckId = msg.randomInfo.formCheckId
		self._randomInfo.conditionId = msg.randomInfo.conditionId
	end
end

function KingmmModel:onGetSocrePrizeRes(msg)
	if not TableUtil.isHad(self._gainPrizeIds, msg.prizeId) then
		table.insert(self._gainPrizeIds, msg.prizeId)
	end
end

function KingmmModel:onResetRandomInfoRes(msg)
	self._todayResetTimes = msg.todayResetTimes
	self._randomInfo.buffId = msg.randomInfo.buffId
	self._randomInfo.formCheckId = msg.randomInfo.formCheckId
	self._randomInfo.conditionId = msg.randomInfo.conditionId
end

function KingmmModel:onGetExtremeInfoRes(msg)
	self._passElementStageIds = GameUtil.pbToTable(msg.passElementStageIds) or {}
	self._passGuardStageIds = GameUtil.pbToTable(msg.passGuardStageIds) or {}
	self._lockRaceIds = GameUtil.pbToTable(msg.lockRaceIds) or {}
	self._isPassBossStage = msg.isPassBossStage
	self._isGainPassPrize = msg.isGainPassPrize
end

function KingmmModel:onExtremeChallengeRes(msg)
	return
end

function KingmmModel:onNotifyExtremeChallengeRes(msg)
	self._type = msg.type
	self._stageId = msg.stageId
	self._isPassBossStage = msg.isPassBossStage
	self._isWin = msg.isWin
	self._passElementStageIds = GameUtil.pbToTable(msg.passElementStageIds) or {}
	self._passGuardStageIds = GameUtil.pbToTable(msg.passGuardStageIds) or {}
	self._lockRaceIds = GameUtil.pbToTable(msg.lockRaceIds) or {}
end

function KingmmModel:onResetGuardStageRes(msg)
	self._passGuardStageIds = GameUtil.pbToTable(msg.passGuardStageIds) or {}
	self._lockRaceIds = GameUtil.pbToTable(msg.lockRaceIds) or {}
end

function KingmmModel:onGainPassPrizeRes(msg)
	self._isGainPassPrize = true
end

function KingmmModel:getCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = KingmmCustomFmtMo.New()
	end

	return self._customFmtMo
end

function KingmmModel:getExtremeCustomFmtMo()
	if self._extremeFmtMo == nil then
		self._extremeFmtMo = KingmmExtremeCustomFmtMo.New()
	end

	return self._extremeFmtMo
end

function KingmmModel:getCurScore()
	return self._curScore
end

function KingmmModel:isRewardGeted(prizeId)
	return TableUtil.isHad(self._gainPrizeIds, prizeId)
end

function KingmmModel:isRewardCanGet(prizeId, score)
	local isScoreEnough = self:getCurScore() >= checknumber(score)

	if isScoreEnough then
		local isGeted = self:isRewardGeted(prizeId)

		return not isGeted
	else
		return false
	end
end

function KingmmModel:getFormId()
	return self._formId
end

function KingmmModel:getBuffId()
	return self._randomInfo.buffId
end

function KingmmModel:getFormCheckId()
	return self._randomInfo.formCheckId
end

function KingmmModel:getConditionId()
	return self._randomInfo.conditionId
end

function KingmmModel:getTodayChallengeTimes()
	return self._todayChallengeTimes
end

function KingmmModel:getTodayResetTimes()
	return self._todayResetTimes
end

function KingmmModel:isPassElement(activityId)
	local maxCount = #KingmmConfig.instance:getElementCfgList(activityId)
	local curCount = #self._passElementStageIds

	return maxCount <= curCount
end

function KingmmModel:isPassGuard(activityId)
	local maxCount = #KingmmConfig.instance:getGuardCfgList(activityId)
	local curCount = #self._passGuardStageIds

	return maxCount <= curCount
end

function KingmmModel:getPassElementNum()
	return #self._passElementStageIds
end

function KingmmModel:getPassGuardNum()
	return #self._passGuardStageIds
end

function KingmmModel:isPassBoss()
	return self._isPassBossStage
end

function KingmmModel:isGainPassPrize()
	return self._isGainPassPrize
end

function KingmmModel:isCanGetPassPrize()
	local isPassBoss = KingmmModel.instance:isPassBoss()
	local isGainPassPrize = KingmmModel.instance:isGainPassPrize()

	return isPassBoss and not isGainPassPrize
end

function KingmmModel:isPassElementStage(stageId)
	return TableUtil.isHad(self._passElementStageIds, stageId)
end

function KingmmModel:isPassGuardStage(stageId)
	return TableUtil.isHad(self._passGuardStageIds, stageId)
end

function KingmmModel:isLockRaceId(raceId)
	return TableUtil.isHad(self._lockRaceIds, raceId)
end

function KingmmModel:isLeftTodayChallengeTimes(activityId)
	local cfgActivity = KingmmConfig.instance:getActivityCfg(activityId)

	if not cfgActivity then
		return false
	end

	local maxDailyChallengeTimes = checknumber(cfgActivity.dailyChallengeTimes)
	local leftNum = Mathf.Max(0, maxDailyChallengeTimes - self:getTodayChallengeTimes())

	return leftNum > 0
end

function KingmmModel:isExistCanGetReward(activityId)
	local prizeCfgs = KingmmConfig.instance:getScorePrizeList(activityId)

	if not prizeCfgs then
		return false
	end

	for i, v in ipairs(prizeCfgs) do
		if self:isRewardCanGet(v.prizeId, v.score) then
			return true
		end
	end

	return false
end

KingmmModel.instance = KingmmModel.New()

return KingmmModel
