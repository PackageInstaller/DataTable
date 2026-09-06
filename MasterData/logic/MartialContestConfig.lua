-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/config/MartialContestConfig.lua

module(..., package.seeall)

local MartialContestConfig = class("MartialContestConfig", BaseConfig)

function MartialContestConfig:onInit()
	return
end

function MartialContestConfig:getNames()
	return {
		"martial_contest_finals_equip",
		"martial_contest_system_pet",
		"martial_contest_round",
		"martial_contest_activity",
		"martial_contest_finals_rank_prize",
		"martial_contest_qualify",
		"martial_contest_qualifier_rank_score",
		"martial_contest_qualify_rank_prize",
		"martial_contest_qualifier_active_rank_score",
		"martial_contest_zone",
		"martial_contest_common",
		"martial_contest_qualifier_level",
		"martial_contest_qualifier_match",
		"martial_contest_qualifier_match_score",
		"martial_contest_finals_buff",
		"martial_contest_step",
		"martial_contest_score_match_rank_prize",
		"martial_contest_finals_rank_view"
	}
end

function MartialContestConfig:handleConfig(name, content)
	if name == "martial_contest_finals_equip" then
		self._martial_contest_finals_equip = content
	elseif name == "martial_contest_system_pet" then
		self._martial_contest_system_pet = content
	elseif name == "martial_contest_round" then
		self._martial_contest_round = content
	elseif name == "martial_contest_activity" then
		self._martial_contest_activity = content
	elseif name == "martial_contest_finals_rank_prize" then
		self._martial_contest_finals_rank_prize = content
	elseif name == "martial_contest_qualify" then
		self._martial_contest_qualify = content
	elseif name == "martial_contest_qualifier_rank_score" then
		self._martial_contest_qualifier_rank_score = content
	elseif name == "martial_contest_qualify_rank_prize" then
		self._martial_contest_qualify_rank_prize = content
	elseif name == "martial_contest_qualifier_active_rank_score" then
		self._martial_contest_qualifier_active_rank_score = content
	elseif name == "martial_contest_zone" then
		self._martial_contest_zone = content
	elseif name == "martial_contest_common" then
		self._martial_contest_common = content
	elseif name == "martial_contest_qualifier_level" then
		self._martial_contest_qualifier_level = content
	elseif name == "martial_contest_qualifier_match" then
		self._martial_contest_qualifier_match = content
	elseif name == "martial_contest_qualifier_match_score" then
		self._martial_contest_qualifier_match_score = content
	elseif name == "martial_contest_finals_buff" then
		self._martial_contest_finals_buff = content
	elseif name == "martial_contest_step" then
		self._martial_contest_step = content
	elseif name == "martial_contest_score_match_rank_prize" then
		self._martial_contest_score_match_rank_prize = content
	elseif name == "martial_contest_finals_rank_view" then
		self._martial_contest_finals_rank_view = content
	end
end

function MartialContestConfig:getRoundCfg(activityId, roundId)
	local cfg = self._martial_contest_round[activityId]

	if not cfg then
		return nil
	end

	return cfg[roundId]
end

function MartialContestConfig:getStepCfg(activityId, stepId)
	local cfg = self._martial_contest_step[activityId]

	return cfg[stepId]
end

function MartialContestConfig:getFinalsBuffCfgs(activityId)
	return self._martial_contest_finals_buff[activityId]
end

function MartialContestConfig:getFinalsBuffCfg(activityId, buffId)
	local cfgs = self:getFinalsBuffCfgs(activityId)

	return cfgs[buffId]
end

function MartialContestConfig:getBuffTipSimpleData(activityId, buffId)
	local buffCfg = self:getFinalsBuffCfg(activityId, buffId)

	return {
		buffName = buffCfg.name,
		buffDesc = buffCfg.desc,
		iconPath = GameUrl.getExpEventUrl(buffCfg.icon)
	}
end

function MartialContestConfig:getStepCfgsByRoundId(activityId, roundId)
	local cfgs = self._martial_contest_step[activityId]
	local stepCfgs = {}

	for i, v in ipairs(cfgs) do
		if v.roundId == roundId then
			table.insert(stepCfgs, v)
		end
	end

	return stepCfgs
end

function MartialContestConfig:getActivityCfg(activityId)
	return self._martial_contest_activity[activityId]
end

function MartialContestConfig:getWarZoneCfgs(activityId)
	return self._martial_contest_zone[activityId] or {}
end

function MartialContestConfig:getWarZoneCfg(activityId, areaId)
	local cfgs = self:getWarZoneCfgs(activityId)

	for _, cfg in pairs(cfgs) do
		if areaId >= cfg.areaIds[1] and areaId <= cfg.areaIds[2] then
			return cfg
		end
	end
end

function MartialContestConfig:getStepCfg(activityId, stepId)
	if self._martial_contest_step[activityId] then
		return self._martial_contest_step[activityId][stepId]
	end
end

function MartialContestConfig:getEquipTypeCfgs(activityId)
	return self._martial_contest_finals_equip[activityId]
end

function MartialContestConfig:getEquipCfg(activityId, equipId, level)
	if self._martial_contest_finals_equip[activityId] and self._martial_contest_finals_equip[activityId][equipId] then
		return self._martial_contest_finals_equip[activityId][equipId][level]
	end
end

function MartialContestConfig:getQualifierMatchCfgs(quaMatchingPlanId)
	return self._martial_contest_qualifier_match[quaMatchingPlanId]
end

function MartialContestConfig:getQualifierMatchCfg(quaMatchingPlanId, quaMatchingId)
	if self._martial_contest_qualifier_match[quaMatchingPlanId] then
		return self._martial_contest_qualifier_match[quaMatchingPlanId][quaMatchingId]
	end
end

function MartialContestConfig:getQualifierCfg(activityId, stepId)
	if self._martial_contest_qualify[activityId] then
		return self._martial_contest_qualify[activityId][stepId]
	end
end

function MartialContestConfig:getQualifierRankScoreCfg(rankScorePlanId)
	return self._martial_contest_qualifier_rank_score[rankScorePlanId]
end

function MartialContestConfig:getQualifierPrizeCfgs(activityId)
	return self._martial_contest_qualify_rank_prize[activityId]
end

function MartialContestConfig:getFinalsPrizeCfgs(activityId)
	return self._martial_contest_finals_rank_prize[activityId]
end

function MartialContestConfig:getScoreRankPrizeCfgs(activityId)
	return self._martial_contest_score_match_rank_prize[activityId]
end

function MartialContestConfig:getSupportPetList()
	return self._martial_contest_system_pet.dataList
end

function MartialContestConfig:getFinalsRankViewCfgs()
	return self._martial_contest_finals_rank_view.dataList
end

function MartialContestConfig:getFinalsRankViewCfg(tabId)
	return self._martial_contest_finals_rank_view[tabId]
end

function MartialContestConfig:getQualifierRankPrizeCfgByRank(activityId, rank)
	local cfgs = self:getQualifierPrizeCfgs(activityId)

	for _, cfg in pairs(cfgs) do
		if rank >= cfg.rankRange[1] and rank <= cfg.rankRange[2] then
			return cfg
		end
	end
end

function MartialContestConfig:getFinalsRankPrizeCfgByRank(activityId, rank)
	local cfgs = self:getFinalsPrizeCfgs(activityId)

	for _, cfg in pairs(cfgs) do
		if rank >= cfg.rankRange[1] and rank <= cfg.rankRange[2] then
			return cfg
		end
	end
end

function MartialContestConfig:getScoreRankPrizeCfgByRank(activityId, rank)
	local cfgs = self:getScoreRankPrizeCfgs(activityId)

	for _, cfg in pairs(cfgs) do
		if rank >= cfg.rankRange[1] and rank <= cfg.rankRange[2] then
			return cfg
		end
	end
end

function MartialContestConfig:getStepCfgs(activityId)
	return self._martial_contest_step[activityId]
end

function MartialContestConfig:getActiveScorePlanCfg(planId)
	return self._martial_contest_qualifier_active_rank_score[planId]
end

MartialContestConfig.instance = MartialContestConfig.New()

return MartialContestConfig
