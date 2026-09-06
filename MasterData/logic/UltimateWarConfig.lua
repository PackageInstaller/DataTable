-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/config/UltimateWarConfig.lua

module("logic.extensions.ultimatewar.config.UltimateWarConfig", package.seeall)

local UltimateWarConfig = class("UltimateWarConfig", BaseConfig)

function UltimateWarConfig:onInit()
	UltimateWarConfig.super.onInit(self)
end

function UltimateWarConfig:getNames()
	return {
		"ultimate_war_activity",
		"ultimate_war_plot",
		"ultimate_war_step",
		"ultimate_war_pet_level",
		"ultimate_war_defence_line",
		"ultimate_war_awaken_ratio",
		"ultimate_war_tower",
		"ultimate_war_stage",
		"ultimate_war_creeps_master",
		"ultimate_war_creeps",
		"ultimate_war_support",
		"ultimate_war_damage_prize",
		"ultimate_war_boss",
		"ultimate_war_boss_prize",
		"ultimate_war_buff",
		"ultimate_war_second_step_tower_rank_prize",
		"ultimate_war_second_step_boss_rank_prize",
		"ultimate_war_third_step_boss_rank_prize",
		"ultimate_war_vote"
	}
end

function UltimateWarConfig:handleConfig(name, content)
	if name == "ultimate_war_activity" then
		self._ultimate_war_activity = content
	elseif name == "ultimate_war_plot" then
		self._ultimate_war_plot = content
	elseif name == "ultimate_war_step" then
		self._ultimate_war_step = content
	elseif name == "ultimate_war_pet_level" then
		self._ultimate_war_pet_level = content
	elseif name == "ultimate_war_defence_line" then
		self._ultimate_war_defence_line = content
	elseif name == "ultimate_war_awaken_ratio" then
		self._ultimate_war_awaken_ratio = content
	elseif name == "ultimate_war_tower" then
		self._ultimate_war_tower = content
	elseif name == "ultimate_war_stage" then
		self._ultimate_war_stage = content
	elseif name == "ultimate_war_creeps_master" then
		self._ultimate_war_creeps_master = content
	elseif name == "ultimate_war_creeps" then
		self._ultimate_war_creeps = content
	elseif name == "ultimate_war_support" then
		self._ultimate_war_support = content
	elseif name == "ultimate_war_damage_prize" then
		self._ultimate_war_damage_prize = content
	elseif name == "ultimate_war_boss" then
		self._ultimate_war_boss = content
	elseif name == "ultimate_war_boss_prize" then
		self._ultimate_war_boss_prize = content
	elseif name == "ultimate_war_buff" then
		self._ultimate_war_buff = content
	elseif name == "ultimate_war_second_step_tower_rank_prize" then
		self._ultimate_war_second_step_tower_rank_prize = content
	elseif name == "ultimate_war_second_step_boss_rank_prize" then
		self._ultimate_war_second_step_boss_rank_prize = content
	elseif name == "ultimate_war_third_step_boss_rank_prize" then
		self._ultimate_war_third_step_boss_rank_prize = content
	elseif name == "ultimate_war_vote" then
		self._ultimate_war_vote = content
	end
end

function UltimateWarConfig:getActData(activityId)
	return self._ultimate_war_activity[activityId]
end

function UltimateWarConfig:getGoldMat(activityId)
	local data = self:getActData(activityId)

	return data and data.itemStr
end

function UltimateWarConfig:getScore2Item(activityId)
	local data = self:getActData(activityId)

	return data and data.score2Item
end

function UltimateWarConfig:getSecondStepSubmitFormRank(activityId)
	local data = self:getActData(activityId)

	return (data or nil) and (data.secondStepSubmitFormRank or 0)
end

function UltimateWarConfig:getPlotCfg(activityId)
	return self._ultimate_war_plot[activityId]
end

function UltimateWarConfig:getPlotData(activityId, plotId)
	if self._ultimate_war_plot[activityId] then
		return self._ultimate_war_plot[activityId][plotId]
	end
end

function UltimateWarConfig:getPlotStoryId(activityId, plotId)
	local data = self:getPlotData(activityId, plotId)

	return (data or nil) and (data.storyId or 0)
end

function UltimateWarConfig:getStepCfg(activityId)
	return self._ultimate_war_step[activityId]
end

function UltimateWarConfig:getStepData(activityId, stepId)
	if self._ultimate_war_step[activityId] then
		return self._ultimate_war_step[activityId][stepId]
	end
end

function UltimateWarConfig:getTowerBossCreepsMasterId(activityId)
	local data = self:getStepData(activityId, UltimateWarEnum.StepId_Two)

	return (data or nil) and (data.bossCreepsMasterId or 0)
end

function UltimateWarConfig:getTowerBossBuffDesc(activityId)
	local data = self:getStepData(activityId, UltimateWarEnum.StepId_Two)

	return data and data.buffDesc
end

function UltimateWarConfig:getTowerBossSupportPetPlanId(activityId)
	local data = self:getStepData(activityId, UltimateWarEnum.StepId_Two)

	return (data or nil) and (data.supportPetPlanId or 0)
end

function UltimateWarConfig:getPetLevelCfg(activityId)
	return self._ultimate_war_pet_level[activityId]
end

function UltimateWarConfig:getPetLevelData(activityId, petLevel)
	if self._ultimate_war_pet_level[activityId] then
		return self._ultimate_war_pet_level[activityId][petLevel]
	end
end

function UltimateWarConfig:getMaxLevel(activityId)
	local cfg = self:getPetLevelCfg(activityId)
	local data = cfg and cfg[#cfg]

	return (data or nil) and (data.petLevel or 0)
end

function UltimateWarConfig:getDefenceLineCfg(activityId)
	return self._ultimate_war_defence_line[activityId]
end

function UltimateWarConfig:getDefenceLineData(activityId, pointId)
	if self._ultimate_war_defence_line[activityId] then
		return self._ultimate_war_defence_line[activityId][pointId]
	end
end

function UltimateWarConfig:getAwakenRatioCfg(activityId)
	return self._ultimate_war_awaken_ratio[activityId]
end

function UltimateWarConfig:getAwakenRatioData(activityId, awakenLv)
	if self._ultimate_war_awaken_ratio[activityId] then
		return self._ultimate_war_awaken_ratio[activityId][awakenLv]
	end
end

function UltimateWarConfig:getAddScoreRatioByAwaken(activityId, awakenLv)
	local result = 0
	local cfg = self._ultimate_war_awaken_ratio[activityId]

	if cfg then
		local data = cfg[Mathf.Clamp(awakenLv, 0, #cfg)]

		result = data and data.addScoreRatio or 0
	end

	return result
end

function UltimateWarConfig:getTowerCfg(activityId)
	return self._ultimate_war_tower[activityId]
end

function UltimateWarConfig:getTowerData(activityId, towerId)
	if self._ultimate_war_tower[activityId] then
		return self._ultimate_war_tower[activityId][towerId]
	end
end

function UltimateWarConfig:getStageCfg(activityId, towerId)
	local data = self:getTowerData(activityId, towerId)

	if data then
		if not data.stagePlanId then
			local stagePlanId = 0

			return self._ultimate_war_stage[stagePlanId]
		end
	end
end

function UltimateWarConfig:getStageData(activityId, towerId, stageId)
	local cfg = self:getStageCfg(activityId, towerId)

	if cfg then
		return cfg[stageId]
	end
end

function UltimateWarConfig:getMaxStageCount(activityId, towerId)
	local cfg = self:getStageCfg(activityId, towerId)

	return (cfg or nil) and (#cfg or 0)
end

function UltimateWarConfig:getMasterData(creepsMasterId)
	return self._ultimate_war_creeps_master[creepsMasterId]
end

function UltimateWarConfig:getCreepsData(creepsMasterId)
	return self._ultimate_war_creeps[creepsMasterId]
end

function UltimateWarConfig:getSupportCfg(supportPetPlanId)
	return self._ultimate_war_support[supportPetPlanId]
end

function UltimateWarConfig:getDamagePrizeCfg(activityId)
	return self._ultimate_war_damage_prize[activityId]
end

function UltimateWarConfig:getDamagePrizeData(activityId, prizeId)
	if self._ultimate_war_damage_prize[activityId] then
		return self._ultimate_war_damage_prize[activityId][prizeId]
	end
end

function UltimateWarConfig:getBossCfg(activityId)
	return self._ultimate_war_boss[activityId]
end

function UltimateWarConfig:getBossData(activityId, bossId)
	if self._ultimate_war_boss[activityId] then
		return self._ultimate_war_boss[activityId][bossId]
	end
end

function UltimateWarConfig:getFinalBossCount(activityId)
	local cfg = self:getBossCfg(activityId)

	return (cfg or nil) and #cfg
end

function UltimateWarConfig:getBossPrizeCfg(activityId)
	return self._ultimate_war_boss_prize[activityId]
end

function UltimateWarConfig:getBossPrizeData(activityId, prizeId)
	if self._ultimate_war_boss_prize[activityId] then
		return self._ultimate_war_boss_prize[activityId][prizeId]
	end
end

function UltimateWarConfig:getBossBuffCfg(activityId)
	return self._ultimate_war_buff[activityId]
end

function UltimateWarConfig:getBossBuffData(activityId, buffId)
	if self._ultimate_war_buff[activityId] then
		return self._ultimate_war_buff[activityId][buffId]
	end
end

function UltimateWarConfig:getBossBuffDataByDay(activityId, checkInDays)
	local result
	local cfg = self:getBossBuffCfg(activityId)

	if cfg then
		for _, data in ipairs(cfg) do
			if checkInDays >= data.checkInDays then
				result = data
			else
				break
			end
		end
	end

	return result
end

function UltimateWarConfig:getMaxBuffDataByDay(activityId)
	local result
	local cfg = self:getBossBuffCfg(activityId)

	if cfg then
		for _, data in ipairs(cfg) do
			if result == nil then
				result = data
			elseif result.checkInDays <= data.checkInDays then
				result = data
			end
		end
	end

	return result
end

function UltimateWarConfig:getSecondStepTowerRankPrizeCfg(activityId)
	return self._ultimate_war_second_step_tower_rank_prize[activityId]
end

function UltimateWarConfig:getSecondStepTowerRankPrizeData(activityId, rank)
	local data
	local cfg = self._ultimate_war_second_step_tower_rank_prize[activityId]

	if cfg then
		for i, v in ipairs(cfg) do
			if rank >= v.rankRange[1] and rank <= v.rankRange[2] then
				data = v

				break
			end
		end
	end

	return data
end

function UltimateWarConfig:getSecondStepBossRankPrizeCfg(activityId)
	return self._ultimate_war_second_step_boss_rank_prize[activityId]
end

function UltimateWarConfig:getSecondStepBossRankPrizeData(activityId, rank)
	local data
	local cfg = self._ultimate_war_second_step_boss_rank_prize[activityId]

	if cfg then
		for i, v in ipairs(cfg) do
			if rank >= v.rankRange[1] and rank <= v.rankRange[2] then
				data = v

				break
			end
		end
	end

	return data
end

function UltimateWarConfig:getThirdStepBossRankPrizeCfg(activityId)
	return self._ultimate_war_third_step_boss_rank_prize[activityId]
end

function UltimateWarConfig:getThirdStepBossRankPrizeData(activityId, rank)
	local data
	local cfg = self._ultimate_war_third_step_boss_rank_prize[activityId]

	if cfg then
		for i, v in ipairs(cfg) do
			if rank >= v.rankRange[1] and rank <= v.rankRange[2] then
				data = v

				break
			end
		end
	end

	return data
end

function UltimateWarConfig:getWarVoteCfg(activityId)
	return self._ultimate_war_vote[activityId]
end

function UltimateWarConfig:getWarVoteData(activityId, voteId)
	return self._ultimate_war_vote[activityId][voteId]
end

UltimateWarConfig.instance = UltimateWarConfig.New()

return UltimateWarConfig
