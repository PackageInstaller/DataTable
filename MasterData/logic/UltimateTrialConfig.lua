-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatetrial/config/UltimateTrialConfig.lua

module("logic.extensions.ultimatetrial.config.UltimateTrialConfig", package.seeall)

local UltimateTrialConfig = class("UltimateTrialConfig", BaseConfig)

function UltimateTrialConfig:getNames()
	return {
		"ultimate_trial_activity",
		"ultimate_trial_main",
		"ultimate_trial_challenge",
		"ultimate_trial_score_rank_type",
		"ultimate_trial_rank_prize",
		"ultimate_trial_system_props",
		"ultimate_trial_sign_in_buff",
		"ultimate_trial_support_pet",
		"first_pass_rank_challenge",
		"first_pass_rank_prize"
	}
end

function UltimateTrialConfig:handleConfig(name, content)
	if name == "ultimate_trial_activity" then
		self._ultimate_trial_activity = content
	elseif name == "ultimate_trial_main" then
		self._ultimate_trial_main = content
	elseif name == "ultimate_trial_challenge" then
		self._ultimate_trial_challenge = content

		self:_handleUltimateTrialChallenge(content)
	elseif name == "ultimate_trial_score_rank_type" then
		self._ultimate_trial_score_rank_type = content
	elseif name == "ultimate_trial_rank_prize" then
		self._ultimate_trial_rank_prize = content
	elseif name == "ultimate_trial_system_props" then
		self._ultimate_trial_system_props = content
	elseif name == "ultimate_trial_sign_in_buff" then
		self._ultimate_trial_sign_in_buff = content
	elseif name == "ultimate_trial_support_pet" then
		self._ultimate_trial_support_pet = content
	elseif name == "first_pass_rank_challenge" then
		self._first_pass_rank_challenge = content
	elseif name == "first_pass_rank_prize" then
		self._first_pass_rank_prize = content
	end
end

function UltimateTrialConfig:getActData(activityId)
	return self._ultimate_trial_activity[activityId]
end

function UltimateTrialConfig:getMainCfg(activityId)
	return self._ultimate_trial_main[activityId]
end

function UltimateTrialConfig:getMainData(activityId, clgIndex)
	if self._ultimate_trial_main[activityId] then
		return self._ultimate_trial_main[activityId][clgIndex]
	end
end

function UltimateTrialConfig:getChallengeCfgsByIndex(activityId)
	return self._ultimate_trial_challenge[activityId]
end

function UltimateTrialConfig:getChallengeCfgByIndex(activityId, clgIndex)
	if self._ultimate_trial_challenge[activityId] then
		return self._ultimate_trial_challenge[activityId][clgIndex]
	end
end

function UltimateTrialConfig:getChallengeDataByIndex(activityId, clgIndex, mode)
	if self._ultimate_trial_challenge[activityId] and self._ultimate_trial_challenge[activityId][clgIndex] then
		return self._ultimate_trial_challenge[activityId][clgIndex][mode]
	end
end

function UltimateTrialConfig:getChallengeCfg(activityId)
	return self._challengeCfgInActId[activityId]
end

function UltimateTrialConfig:getChallengeData(activityId, clgActId)
	if self._challengeCfgInActId[activityId] then
		return self._challengeCfgInActId[activityId][clgActId]
	end
end

function UltimateTrialConfig:getChallengeDataListByClgId(clgActId)
	return self._challengeCfgInClgActId[clgActId]
end

function UltimateTrialConfig:_handleUltimateTrialChallenge(content)
	self._challengeCfgInActId = {}

	for _, data in pairs(content.dataList) do
		self._challengeCfgInActId[data.activityId] = self._challengeCfgInActId[data.activityId] or {}
		self._challengeCfgInActId[data.activityId][data.clgActId] = data
	end

	self._challengeCfgInClgActId = {}

	for _, data in pairs(content.dataList) do
		self._challengeCfgInClgActId[data.clgActId] = self._challengeCfgInClgActId[data.clgActId] or {}

		table.insert(self._challengeCfgInClgActId[data.clgActId], data)
	end
end

function UltimateTrialConfig:getScoreRankTypeData(clgActType)
	return self._ultimate_trial_score_rank_type[clgActType]
end

function UltimateTrialConfig:getScoreRankType(clgActType)
	local data = self:getScoreRankTypeData(clgActType)

	return data and data.scoreRankType
end

function UltimateTrialConfig:getScoreRankPrizeCfg(activityId, clgActId)
	local data = self:getChallengeData(activityId, clgActId)

	if data then
		if not data.scoreRankPrizePlanId then
			local scoreRankPrizePlanId = 0

			return self._ultimate_trial_rank_prize[scoreRankPrizePlanId]
		end
	end
end

function UltimateTrialConfig:getScoreRankPrizeData(activityId, clgActId, rank)
	local cfg = self:getScoreRankPrizeCfg(activityId, clgActId)

	return MmUtil.binarySearchInArrayKey(cfg, "rankRange", rank)
end

function UltimateTrialConfig:getTimeRankPrizeCfg(activityId, clgActId)
	local data = self:getChallengeData(activityId, clgActId)

	if data then
		if not data.timeRankPrizePlanId then
			local timeRankPrizePlanId = 0

			return self._ultimate_trial_rank_prize[timeRankPrizePlanId]
		end
	end
end

function UltimateTrialConfig:getTimeRankPrizeData(activityId, clgActId, rank)
	local cfg = self:getTimeRankPrizeCfg(activityId, clgActId)

	return MmUtil.binarySearchInArrayKey(cfg, "rankRange", rank)
end

function UltimateTrialConfig:getSystemPropsCfg(activityId)
	local data = self:getActData(activityId)

	if data then
		if not data.systemPropPlanId then
			local systemPropPlanId = 0

			return self._ultimate_trial_system_props[systemPropPlanId]
		end
	end
end

function UltimateTrialConfig:getSystemPropsData(activityId, days)
	local cfg = self:getSystemPropsCfg(activityId)

	days = cfg and math.min(days, #cfg) or 0

	return cfg and cfg[days]
end

function UltimateTrialConfig:getSignInBuffCfg(activityId)
	local data = self:getActData(activityId)

	if data then
		if not data.signInBuffPlanId then
			local signInBuffPlanId = 0

			return self._ultimate_trial_sign_in_buff[signInBuffPlanId]
		end
	end
end

function UltimateTrialConfig:getSignInBuffData(activityId, level)
	local cfg = self:getSignInBuffCfg(activityId)

	level = cfg and math.min(level, #cfg) or 0

	return cfg and cfg[level]
end

function UltimateTrialConfig:getMaxSignDay(activityId)
	local cfg = self:getSignInBuffCfg(activityId)
	local data = cfg and cfg[#cfg]

	return (data or nil) and (data.level or 0)
end

function UltimateTrialConfig:getSupportPetCfg(supportPetPlanId)
	return self._ultimate_trial_support_pet[supportPetPlanId]
end

function UltimateTrialConfig:getFirstPassRankChallengeCfg(activityId)
	return self._first_pass_rank_challenge[activityId]
end

function UltimateTrialConfig:getAllFirstPassRankChallengeCfs()
	return self._first_pass_rank_challenge.dataList
end

function UltimateTrialConfig:getFirstPassRankPrizeCfgs(planId)
	return self._first_pass_rank_prize[planId]
end

function UltimateTrialConfig:getFirstPassRankPrizeData(activityId, rank)
	local actCfg = self:getFirstPassRankChallengeCfg(activityId)
	local prizeCfgs = self:getFirstPassRankPrizeCfgs(actCfg and actCfg.rankPrizePlanId) or {}

	return MmUtil.binarySearchInArrayKey(prizeCfgs, "rankRange", rank)
end

UltimateTrialConfig.instance = UltimateTrialConfig.New()

return UltimateTrialConfig
