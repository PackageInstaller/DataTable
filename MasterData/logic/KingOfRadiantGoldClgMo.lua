-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingofradiantgoldclg/data/KingOfRadiantGoldClgMo.lua

module("logic.extensions.kingofradiantgoldclg.data.KingOfRadiantGoldClgMo", package.seeall)

local KingOfRadiantGoldClgMo = class("KingOfRadiantGoldClgMo")

function KingOfRadiantGoldClgMo:ctor(activityId)
	self._activityId = activityId
	self._historyScore = 0
	self._curScore = 0
	self._gainedPrize = false
	self._dailyScores = {}
	self._passStageIds = {}
	self._buffLevels = {}
	self._finishMsg = nil
end

function KingOfRadiantGoldClgMo:dispose()
	table.clear(self._dailyScores)
	table.clear(self._passStageIds)
	table.clear(self._buffLevels)

	self._finishMsg = nil
end

function KingOfRadiantGoldClgMo:handlePM_KingOfRadiantGoldClgInfoRes(msg)
	self._historyScore = msg.historyScore
	self._curScore = msg.curScore
	self._gainedPrize = msg.gainedPrize

	table.clear(self._dailyScores)

	for _, v in ipairs(msg.challenges) do
		local challengeId = v.challengeId

		self._dailyScores[challengeId] = {}
		self._passStageIds[challengeId] = {}

		for _, vv in ipairs(v.stages) do
			self._dailyScores[challengeId][vv.stageId] = vv.dailyScore
			self._passStageIds[challengeId][vv.stageId] = checkbool(vv.hasFirstPass)
		end
	end

	table.clear(self._buffLevels)

	for _, v in ipairs(msg.buffs) do
		self._buffLevels[v.buffId] = v.level
	end
end

function KingOfRadiantGoldClgMo:handlePM_KingOfRadiantGoldClgChallengeRes(msg)
	return
end

function KingOfRadiantGoldClgMo:handlePM_KingOfRadiantGoldClgUpgradeBuffRes(msg)
	self._buffLevels[msg.buffId] = msg.level

	local data = KingOfRadiantGoldClgConfig.instance:getBuffCfgData(self._activityId, msg.buffId, msg.level)

	if data then
		if not data.cost then
			local cost = 0

			self._curScore = Mathf.Max(self._curScore - cost, 0)
		end
	end
end

function KingOfRadiantGoldClgMo:handlePM_KingOfRadiantGoldClgResetBuffRes(msg)
	self._buffLevels[msg.buffId] = 0
	self._curScore = msg.curScore
end

function KingOfRadiantGoldClgMo:handlePM_KingOfRadiantGoldClgOneKeyPassRes(msg)
	local cfgs = KingOfRadiantGoldClgConfig.instance:getStageCfgs(self._activityId) or {}

	for _, cfg in ipairs(cfgs) do
		for _, data in ipairs(cfg) do
			self._passStageIds = MmUtil.checkTable(self._passStageIds, data.challengeId)
			self._passStageIds[data.challengeId][data.stageId] = true
		end
	end
end

function KingOfRadiantGoldClgMo:handlePM_KingOfRadiantGoldClgGainPetRes(msg)
	self._gainedPrize = true
end

function KingOfRadiantGoldClgMo:handlePM_NotifyKingOfRadiantGoldClgFinishRes(msg)
	self._finishMsg = msg
end

function KingOfRadiantGoldClgMo:isHasGainPrize()
	return self._gainedPrize
end

function KingOfRadiantGoldClgMo:getHistoryScore()
	return self._historyScore
end

function KingOfRadiantGoldClgMo:getCurScore()
	return self._curScore
end

function KingOfRadiantGoldClgMo:getFinishMsg()
	return self._finishMsg
end

function KingOfRadiantGoldClgMo:isCanUpdateBuffInAll()
	local result = false
	local cfgs = KingOfRadiantGoldClgConfig.instance:getBuffCfgs(self._activityId)

	if cfgs then
		for buffId, cfg in pairs(cfgs) do
			if self:isCanUpdateBuff(buffId) then
				result = true

				break
			end
		end
	end

	return result
end

function KingOfRadiantGoldClgMo:isCanUpdateBuff(buffId)
	local result = self:getTryResultAndTipsUpdateBuff(false, buffId)

	return result == GameEnum.ResultCode.Success
end

function KingOfRadiantGoldClgMo:isEnoughCostUpdateBuff(buffId)
	local cur = self:getBuffLevel(buffId)
	local max = self:getBuffMaxLevel(buffId)
	local next = Mathf.Min(cur + 1, max)
	local data = KingOfRadiantGoldClgConfig.instance:getBuffCfgData(self._activityId, buffId, next)

	if data then
		if not data.cost then
			local cost = 0
			local curScore = self:getCurScore()

			return cost <= curScore
		end
	end
end

function KingOfRadiantGoldClgMo:isNotFullMaxLevelBuff(buffId)
	local cur = self:getBuffLevel(buffId)
	local max = self:getBuffMaxLevel(buffId)

	return max >= cur + 1
end

function KingOfRadiantGoldClgMo:isCanResetBuff(buffId)
	local cur = self:getBuffLevel(buffId)

	return cur > 0 and not self:isPassAllChallenge()
end

function KingOfRadiantGoldClgMo:getBuffLevel(buffId)
	return checknumber(self._buffLevels[buffId])
end

function KingOfRadiantGoldClgMo:getBuffMaxLevel(buffId)
	return KingOfRadiantGoldClgConfig.instance:getBuffMaxLevel(self._activityId, buffId)
end

function KingOfRadiantGoldClgMo:isBuffOpenTime()
	local data = KingOfRadiantGoldClgConfig.instance:getActData(self._activityId)
	local buffOpenTime = data and data.buffOpenTime

	return GameUtil.getTimePeriod(buffOpenTime, nil) == GameUtil.inTimePeriod
end

function KingOfRadiantGoldClgMo:isUnlockChallenge(challengeId)
	return self:isUnlockChallengeByTime(challengeId) and self:isUnlockChallengeByCond(challengeId)
end

function KingOfRadiantGoldClgMo:isUnlockChallengeByTime(challengeId)
	local data = KingOfRadiantGoldClgConfig.instance:getChallengeData(self._activityId, challengeId)
	local startTime = data and data.openTime

	return GameUtil.getTimePeriod(startTime, nil) == GameUtil.inTimePeriod
end

function KingOfRadiantGoldClgMo:isUnlockChallengeByCond(challengeId)
	local lastChallengeId = challengeId - 1

	if lastChallengeId <= 0 then
		return true
	else
		return self:isPassChallenge(lastChallengeId)
	end
end

function KingOfRadiantGoldClgMo:isPassAllChallenge()
	local result = false
	local cfgs = KingOfRadiantGoldClgConfig.instance:getStageCfgs(self._activityId)

	if cfgs then
		result = true

		for challengeId, cfg in ipairs(cfgs) do
			if not self:isPassChallenge(challengeId) then
				result = false

				break
			end
		end
	end

	return result
end

function KingOfRadiantGoldClgMo:isPassChallenge(challengeId)
	local result = false
	local cfg = KingOfRadiantGoldClgConfig.instance:getStageCfg(self._activityId, challengeId)

	if cfg then
		result = true

		for _, data in ipairs(cfg) do
			if not self:isPassStage(challengeId, data.stageId) then
				result = false

				break
			end
		end
	end

	return result
end

function KingOfRadiantGoldClgMo:isPassStage(challengeId, stageId)
	return (self._passStageIds[challengeId] or nil) and (self._passStageIds[challengeId][stageId] or false)
end

function KingOfRadiantGoldClgMo:getDailyScore(challengeId, stageId)
	return (self._dailyScores[challengeId] or nil) and (self._dailyScores[challengeId][stageId] or 0)
end

function KingOfRadiantGoldClgMo:getTryResultAndTipsEnterChallenge(isShowTips, challengeId)
	local result = GameEnum.ResultCode.Success
	local tips

	if not KingOfRadiantGoldClgController.instance:isInActivityTime(self._activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = isShowTips and "不在活动时间范围内"
	elseif not self:isUnlockChallengeByTime(challengeId) then
		result = GameEnum.ResultCode.NotInTime

		if isShowTips then
			local data = KingOfRadiantGoldClgConfig.instance:getChallengeData(self._activityId, challengeId)
			local timeStr = GameUtil.formatTimeString("%m.%d %H:%M", data.openTime)

			tips = string.format("%s\n后开启", timeStr)
		end
	elseif not self:isUnlockChallengeByCond(challengeId) then
		result = GameEnum.ResultCode.NotInTime
		tips = isShowTips and "请通关上一层后开启"
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function KingOfRadiantGoldClgMo:getTryResultAndTipsStartStageClg(isShowTips, challengeId, stageId)
	local result = GameEnum.ResultCode.Success
	local tips

	result = self:getTryResultAndTipsEnterChallenge(isShowTips, challengeId)

	if result == GameEnum.ResultCode.Success and self:isPassAllChallenge() then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "您已通关不可挑战"
	end

	if result == GameEnum.ResultCode.Success then
		local scoreCfg = KingOfRadiantGoldClgConfig.instance:getScoreCfgByStage(self._activityId, challengeId, stageId)

		if scoreCfg == nil and self:isPassStage(challengeId, stageId) then
			result = GameEnum.ResultCode.Error
			tips = isShowTips and "您已通关不可挑战"
		end
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function KingOfRadiantGoldClgMo:getTryResultAndTipsUpdateBuff(isShowTips, buffId)
	local result = GameEnum.ResultCode.Success
	local tips

	if not KingOfRadiantGoldClgController.instance:isInActivityTime(self._activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = isShowTips and "不在活动时间范围内"
	elseif self:isPassAllChallenge() then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "您已通关无需强化符文"
	elseif not self:isNotFullMaxLevelBuff(buffId) then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "已满级"
	elseif not self:isBuffOpenTime() then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "符文升级未开放"
	elseif not self:isEnoughCostUpdateBuff(buffId) then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "符文数量不足"
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function KingOfRadiantGoldClgMo:getTryResultAndTipsResetBuff(isShowTips, buffId)
	local result = GameEnum.ResultCode.Success
	local tips

	if not KingOfRadiantGoldClgController.instance:isInActivityTime(self._activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = isShowTips and "不在活动时间范围内"
	elseif self:isPassAllChallenge() then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "您已通关无需重置符文"
	elseif not self:isBuffOpenTime() then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "符文升级未开放"
	elseif not self:isCanResetBuff(buffId) then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "无需重置"
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function KingOfRadiantGoldClgMo:getTryResultAndTipsGetFinalPrize(isShowTips)
	local result = GameEnum.ResultCode.Success
	local tips

	if not KingOfRadiantGoldClgController.instance:isInActivityTime(self._activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = isShowTips and "不在活动时间范围内"
	elseif self:isHasGainPrize() then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "您已获得最终奖励"
	elseif not self:isPassAllChallenge() then
		result = GameEnum.ResultCode.Error
		tips = isShowTips and "未通关"
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

return KingOfRadiantGoldClgMo
