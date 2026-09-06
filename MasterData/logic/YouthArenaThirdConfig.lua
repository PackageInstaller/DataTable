-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/config/YouthArenaThirdConfig.lua

module("logic.extensions.youtharenathird.config.YouthArenaThirdConfig", package.seeall)

local YouthArenaThirdConfig = class("YouthArenaThirdConfig", BaseConfig)

function YouthArenaThirdConfig:getNames()
	return {
		"young_arena_king_s3_match",
		"young_arena_king_s3_buff_plan",
		"young_arena_king_s3_knockout_buff_plan",
		"young_arena_king_s3_step",
		"young_arena_king_s3_activity",
		"young_arena_king_s3_zone",
		"young_arena_king_s3_common",
		"young_arena_king_s3_win_streak_score",
		"young_arena_king_s3_match_level",
		"young_arena_king_s3_support_pet",
		"young_arena_king_s3_score_match_rank_prize",
		"young_arena_king_s3_knockout_rank_prize",
		"young_arena_king_s3_original_match_score",
		"young_arena_king_s3_round"
	}
end

function YouthArenaThirdConfig:handleConfig(name, content)
	if name == "young_arena_king_s3_match" then
		self._young_arena_king_s3_match = content
	elseif name == "young_arena_king_s3_buff_plan" then
		self._young_arena_king_s3_buff_plan = content
	elseif name == "young_arena_king_s3_knockout_buff_plan" then
		self._young_arena_king_s3_knockout_buff_plan = content

		self:_handleKnockoutBuffPlanConfig(content.dataList)
	elseif name == "young_arena_king_s3_step" then
		self._young_arena_king_s3_step = content
	elseif name == "young_arena_king_s3_activity" then
		self._young_arena_king_s3_activity = content
	elseif name == "young_arena_king_s3_zone" then
		self._young_arena_king_s3_zone = content
	elseif name == "young_arena_king_s3_common" then
		self._young_arena_king_s3_common = content
	elseif name == "young_arena_king_s3_win_streak_score" then
		self._young_arena_king_s3_win_streak_score = content
	elseif name == "young_arena_king_s3_match_level" then
		self._young_arena_king_s3_match_level = content
	elseif name == "young_arena_king_s3_support_pet" then
		self._young_arena_king_s3_support_pet = content

		self:_handleSupportPetConfig(content.dataList)
	elseif name == "young_arena_king_s3_score_match_rank_prize" then
		self._young_arena_king_s3_score_match_rank_prize = content

		self:_handleScoreMatchRankPrizeConfig(content.dataList)
	elseif name == "young_arena_king_s3_knockout_rank_prize" then
		self._young_arena_king_s3_knockout_rank_prize = content

		self:_handleKnockoutRankPrizeConfig(content.dataList)
	elseif name == "young_arena_king_s3_original_match_score" then
		self._young_arena_king_s3_original_match_score = content
	elseif name == "young_arena_king_s3_round" then
		self._young_arena_king_s3_round = content
	end
end

function YouthArenaThirdConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

function YouthArenaThirdConfig:getActivityData(activityId)
	return self:_safeGet(self._young_arena_king_s3_activity, activityId)
end

function YouthArenaThirdConfig:getMatchDatas(activityId)
	return self:_safeGet(self._young_arena_king_s3_match, activityId)
end

function YouthArenaThirdConfig:getMatchData(activityId, stepId)
	return self:_safeGet(self._young_arena_king_s3_match, activityId, stepId)
end

function YouthArenaThirdConfig:getBuffPlanDatas(buffPlanId)
	return self:_safeGet(self._young_arena_king_s3_buff_plan, buffPlanId)
end

function YouthArenaThirdConfig:getBuffPlanData(buffPlanId, buffId)
	return self:_safeGet(self._young_arena_king_s3_buff_plan, buffPlanId, buffId)
end

function YouthArenaThirdConfig:getKnockoutBuffPlanDatas(buffPlanId)
	return self:_safeGet(self._knockoutBuffPlanDataList, checknumber(buffPlanId))
end

function YouthArenaThirdConfig:getKnockoutBuffPlanData(buffPlanId, buffId)
	return self:_safeGet(self._young_arena_king_s3_knockout_buff_plan, checknumber(buffPlanId), checknumber(buffId))
end

function YouthArenaThirdConfig:_handleKnockoutBuffPlanConfig(dataList)
	self._knockoutBuffPlanDataList = {}

	for _, data in ipairs(dataList or {}) do
		local buffPlanId = checknumber(data.buffPlanId)

		self._knockoutBuffPlanDataList[buffPlanId] = self._knockoutBuffPlanDataList[buffPlanId] or {}

		table.insert(self._knockoutBuffPlanDataList[buffPlanId], data)
	end
end

function YouthArenaThirdConfig:getStepDatas(activityId)
	return self:_safeGet(self._young_arena_king_s3_step, activityId)
end

function YouthArenaThirdConfig:getStepData(activityId, stepId)
	return self:_safeGet(self._young_arena_king_s3_step, activityId, stepId)
end

function YouthArenaThirdConfig:getKnockoutBuffStepDataByRoundMode(activityId, roundId, mode)
	local targetRoundId = checknumber(roundId)
	local targetMode = checknumber(mode) == 2 and "MODE_3V3" or "MODE_1V1"
	local targetStepData
	local var_14_0

	if targetRoundId <= 0 then
		do return nil end

		var_14_0 = self:getStepDatas(activityId) or {}
	end

	for _, stepData in pairs(var_14_0) do
		if checknumber(stepData.roundId) == targetRoundId and stepData.mode == targetMode and checknumber(stepData.buffPlanId) > 0 then
			local isTargetPrepare = targetStepData and checkbool(targetStepData.canSetForm) or false
			local isCurrentPrepare = checkbool(stepData.canSetForm)

			if targetStepData == nil or isCurrentPrepare and not isTargetPrepare or isCurrentPrepare == isTargetPrepare and checknumber(stepData.stepId) < checknumber(targetStepData.stepId) then
				targetStepData = stepData
			end
		end
	end

	return targetStepData
end

function YouthArenaThirdConfig:getKnockoutBuffPlanDatasByRoundMode(activityId, roundId, mode)
	local stepData = self:getKnockoutBuffStepDataByRoundMode(activityId, roundId, mode)

	return stepData and self:getKnockoutBuffPlanDatas(stepData.buffPlanId) or nil
end

function YouthArenaThirdConfig:hasKnockoutBuffPlanDataByRound(activityId, roundId)
	local oneList = self:getKnockoutBuffPlanDatasByRoundMode(activityId, roundId, 1) or {}
	local threeList = self:getKnockoutBuffPlanDatasByRoundMode(activityId, roundId, 2) or {}

	return #oneList > 0 or #threeList > 0
end

function YouthArenaThirdConfig:getDefenseBuffStepData(activityId, stepId)
	local currentStepData = self:getStepData(activityId, checknumber(stepId))

	if currentStepData == nil or not checkbool(currentStepData.canSetForm) then
		return nil
	end

	return currentStepData
end

function YouthArenaThirdConfig:getBuffStepDataByStepData(activityId, stepData)
	if not stepData then
		return nil
	end

	if not string.nilorempty(stepData.buffDesc) then
		return stepData
	end

	if not checkbool(stepData.canSetForm) then
		return stepData
	end

	local nextStepData = self:getStepData(activityId, checknumber(stepData.stepId) + 1)

	if nextStepData and checknumber(nextStepData.roundId) == checknumber(stepData.roundId) then
		return nextStepData
	end

	return stepData
end

function YouthArenaThirdConfig:getBuffStepDataByRoundId(activityId, roundId)
	local targetStepData
	local targetRoundId = checknumber(roundId)
	local var_19_0

	if targetRoundId <= 0 then
		do return nil end

		var_19_0 = self:getStepDatas(activityId) or {}
	end

	for _, stepData in pairs(var_19_0) do
		if checknumber(stepData.roundId) == targetRoundId and not string.nilorempty(stepData.buffDesc) and (targetStepData == nil or checknumber(stepData.stepId) < checknumber(targetStepData.stepId)) then
			targetStepData = stepData
		end
	end

	return targetStepData
end

function YouthArenaThirdConfig:getZoneDatas(activityId)
	return self:_safeGet(self._young_arena_king_s3_zone, activityId)
end

function YouthArenaThirdConfig:getZoneData(activityId, zoneId)
	return self:_safeGet(self._young_arena_king_s3_zone, activityId, zoneId)
end

function YouthArenaThirdConfig:getCommonData(key)
	return self:_safeGet(self._young_arena_king_s3_common, key)
end

function YouthArenaThirdConfig:getCommonValue(key, isToNumber)
	local data = self:getCommonData(key)
	local value = data and data.value

	if isToNumber then
		return checknumber(value)
	end

	return value
end

function YouthArenaThirdConfig:getWinStreakScoreDatas(rankScorePlanId)
	return self:_safeGet(self._young_arena_king_s3_win_streak_score, rankScorePlanId)
end

function YouthArenaThirdConfig:getWinStreakScoreData(rankScorePlanId, rankScoreId)
	return self:_safeGet(self._young_arena_king_s3_win_streak_score, rankScorePlanId, rankScoreId)
end

function YouthArenaThirdConfig:getWinStreakScoreDataByWinStreak(rankScorePlanId, winStreak)
	return MmUtil.unorderedSearchInSingleKey(self:getWinStreakScoreDatas(rankScorePlanId), "winStreak", checknumber(winStreak))
end

function YouthArenaThirdConfig:getMatchLevelDatas(quaLevelPlanId)
	return self:_safeGet(self._young_arena_king_s3_match_level, quaLevelPlanId)
end

function YouthArenaThirdConfig:getMatchLevelData(quaLevelPlanId, quaLevelId)
	return self:_safeGet(self._young_arena_king_s3_match_level, quaLevelPlanId, quaLevelId)
end

function YouthArenaThirdConfig:getMatchLevelDataByRankScore(quaLevelPlanId, rankScore)
	return MmUtil.unorderedSearchInSingleKey(self:getMatchLevelDatas(quaLevelPlanId), "rankScoreLimit", checknumber(rankScore))
end

function YouthArenaThirdConfig:getSupportPetDatas(activityId)
	return self:_safeGet(self._young_arena_king_s3_support_pet, activityId)
end

function YouthArenaThirdConfig:getSupportPetData(activityId, creepsId)
	return self:_safeGet(self._young_arena_king_s3_support_pet, activityId, creepsId)
end

function YouthArenaThirdConfig:getSupportPetDatasByPlan(activityId, supportPetPlanId)
	return self:_safeGet(self._supportPetDataListInPlan, activityId, supportPetPlanId)
end

function YouthArenaThirdConfig:_handleSupportPetConfig(dataList)
	self._supportPetDataListInPlan = {}

	for _, data in ipairs(dataList or {}) do
		local activityId = data.activityId
		local supportPetPlanId = data.supportPetPlanId

		self._supportPetDataListInPlan = MmUtil.checkTable(self._supportPetDataListInPlan, activityId, supportPetPlanId)

		table.insert(self._supportPetDataListInPlan[activityId][supportPetPlanId], data)
	end
end

function YouthArenaThirdConfig:getScoreMatchRankPrizeDatas(activityId)
	return self:_safeGet(self._scoreMatchRankPrizeDataList, activityId)
end

function YouthArenaThirdConfig:getScoreMatchRankPrizeDataByRank(activityId, rank)
	return MmUtil.unorderedSearchInArrayKey(self:getScoreMatchRankPrizeDatas(activityId), "rankRange", checknumber(rank))
end

function YouthArenaThirdConfig:_handleScoreMatchRankPrizeConfig(dataList)
	self._scoreMatchRankPrizeDataList = {}

	for _, data in ipairs(dataList or {}) do
		local activityId = data.activityId

		self._scoreMatchRankPrizeDataList = MmUtil.checkTable(self._scoreMatchRankPrizeDataList, activityId)

		table.insert(self._scoreMatchRankPrizeDataList[activityId], data)
	end
end

function YouthArenaThirdConfig:getKnockoutRankPrizeDatas(activityId)
	return self:_safeGet(self._young_arena_king_s3_knockout_rank_prize, activityId)
end

function YouthArenaThirdConfig:getKnockoutRankPrizeData(activityId, rankPrizeId)
	return self:_safeGet(self._young_arena_king_s3_knockout_rank_prize, activityId, rankPrizeId)
end

function YouthArenaThirdConfig:getKnockoutRankPrizeDatasByRound(activityId, roundId)
	return self:_safeGet(self._knockoutRankPrizeDataListInRound, activityId, roundId)
end

function YouthArenaThirdConfig:getKnockoutRankPrizeDataByRank(activityId, rank)
	local datas = self:getKnockoutRankPrizeDatas(activityId)
	local result

	for _, data in pairs(datas or {}) do
		if rank <= data.rank and (result == nil or data.rank < result.rank) then
			result = data
		end
	end

	return result
end

function YouthArenaThirdConfig:_handleKnockoutRankPrizeConfig(dataList)
	self._knockoutRankPrizeDataListInRound = {}

	for _, data in ipairs(dataList or {}) do
		local activityId = data.activityId
		local roundId = data.roundId

		self._knockoutRankPrizeDataListInRound = MmUtil.checkTable(self._knockoutRankPrizeDataListInRound, activityId, roundId)

		table.insert(self._knockoutRankPrizeDataListInRound[activityId][roundId], data)
	end
end

function YouthArenaThirdConfig:getOriginalMatchScoreDatas(matchScorePlanId)
	return self:_safeGet(self._young_arena_king_s3_original_match_score, matchScorePlanId)
end

function YouthArenaThirdConfig:getOriginalMatchScoreData(matchScorePlanId, matchScoreId)
	return self:_safeGet(self._young_arena_king_s3_original_match_score, matchScorePlanId, matchScoreId)
end

function YouthArenaThirdConfig:getOriginalMatchScoreDataByZdl(matchScorePlanId, zdl)
	return MmUtil.unorderedSearchInSingleKey(self:getOriginalMatchScoreDatas(matchScorePlanId), "zdl", checknumber(zdl))
end

function YouthArenaThirdConfig:getRoundDatas(activityId)
	return self:_safeGet(self._young_arena_king_s3_round, activityId)
end

function YouthArenaThirdConfig:getRoundData(activityId, roundId)
	return self:_safeGet(self._young_arena_king_s3_round, activityId, roundId)
end

YouthArenaThirdConfig.instance = YouthArenaThirdConfig.New()

return YouthArenaThirdConfig
