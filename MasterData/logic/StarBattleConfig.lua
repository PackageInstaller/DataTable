-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/config/StarBattleConfig.lua

module("logic.extensions.starbattle.config.StarBattleConfig", package.seeall)

local StarBattleConfig = class("StarBattleConfig", BaseConfig)

function StarBattleConfig:getNames()
	return {
		"star_battle_support_pet_plan",
		"star_battle_buff_plan",
		"star_battle_crack_formation_race_plan",
		"star_battle_creeps",
		"star_battle_defense_plan",
		"star_battle_double_boss_score_plan",
		"star_battle_master",
		"star_battle_period",
		"star_battle_progress_prize_plan",
		"star_battle_score_rank_prize_plan",
		"star_battle_stage_plan",
		"star_battle_activity",
		"star_battle_boss_plan",
		"star_battle_defense_race_plan"
	}
end

function StarBattleConfig:handleConfig(name, content)
	if name == "star_battle_support_pet_plan" then
		self._star_battle_support_pet_plan = content
	elseif name == "star_battle_buff_plan" then
		self._star_battle_buff_plan = content
	elseif name == "star_battle_crack_formation_race_plan" then
		self._star_battle_crack_formation_race_plan = content
	elseif name == "star_battle_creeps" then
		self._star_battle_creeps = content
	elseif name == "star_battle_defense_plan" then
		self._star_battle_defense_plan = content
	elseif name == "star_battle_double_boss_score_plan" then
		self._star_battle_double_boss_score_plan = content
	elseif name == "star_battle_master" then
		self._star_battle_master = content
	elseif name == "star_battle_period" then
		self._star_battle_period = content
	elseif name == "star_battle_progress_prize_plan" then
		self._star_battle_progress_prize_plan = content
	elseif name == "star_battle_score_rank_prize_plan" then
		self._star_battle_score_rank_prize_plan = content
	elseif name == "star_battle_stage_plan" then
		self._star_battle_stage_plan = content
	elseif name == "star_battle_activity" then
		self._star_battle_activity = content
	elseif name == "star_battle_boss_plan" then
		self._star_battle_boss_plan = content
	elseif name == "star_battle_defense_race_plan" then
		self._star_battle_defense_race_plan = content
	end
end

function StarBattleConfig:getActCfg(activityId)
	return self._star_battle_activity[activityId]
end

function StarBattleConfig:getPeriodCfgs(activityId)
	return self._star_battle_period[activityId]
end

function StarBattleConfig:getPeriodCfg(activityId, periodId)
	if self._star_battle_period[activityId] then
		return self._star_battle_period[activityId][periodId]
	end
end

function StarBattleConfig:getCreepCfgs(creepsMasterId)
	return self._star_battle_creeps[creepsMasterId]
end

function StarBattleConfig:getTeamCfg(creepsMasterId)
	return self._star_battle_master[creepsMasterId]
end

function StarBattleConfig:getStageCfgs(planId)
	return self._star_battle_stage_plan[planId]
end

function StarBattleConfig:getStageCfgByStageId(planId, stageId)
	if self._star_battle_stage_plan[planId] then
		return self._star_battle_stage_plan[planId][stageId]
	end
end

function StarBattleConfig:getBossCfgs(planId)
	return self._star_battle_boss_plan[planId]
end

function StarBattleConfig:getBossCfgById(planId, bossId)
	if self._star_battle_boss_plan[planId] then
		return self._star_battle_boss_plan[planId][bossId]
	end
end

function StarBattleConfig:getSupportPetCfgs(planId)
	return self._star_battle_support_pet_plan[planId]
end

function StarBattleConfig:getBuffCfgs(planId)
	return self._star_battle_buff_plan[planId]
end

function StarBattleConfig:getBuffCfgByDays(planId, day)
	local cfgs = self:getBuffCfgs(planId)

	if cfgs then
		local matchCfg

		for _, cfg in ipairs(cfgs) do
			if day >= cfg.signInDays then
				matchCfg = cfg
			else
				break
			end
		end

		return matchCfg
	end
end

function StarBattleConfig:getFormationRaceCfgs(planId)
	if not self._star_battle_crack_formation_race_plan[planId] then
		local cfgs = {}

		for _, cfg in pairs(self._star_battle_crack_formation_race_plan[planId]) do
			table.insert(cfgs, cfg)
		end

		return cfgs
	end
end

function StarBattleConfig:getFormationRaceCfgByRaceId(planId, raceId)
	if self._star_battle_crack_formation_race_plan[planId] then
		return self._star_battle_crack_formation_race_plan[planId][raceId]
	end
end

function StarBattleConfig:getDefensePrizeCfgs(planId)
	return self._star_battle_defense_plan[planId]
end

function StarBattleConfig:getDefenseRaces(planId)
	local races = {}
	local cfgs = self._star_battle_defense_race_plan[planId]

	if cfgs then
		for _, cfg in pairs(cfgs) do
			table.insert(races, cfg.raceId)
		end
	end

	return races
end

function StarBattleConfig:getDefenseRacePrizeCfgs(planId)
	return self._star_battle_defense_race_plan[planId]
end

function StarBattleConfig:getDefenseRacePrizeCfg(planId, raceId)
	if self._star_battle_defense_race_plan[planId] then
		return self._star_battle_defense_race_plan[planId][raceId]
	end
end

function StarBattleConfig:getBossProgressPrizeCfgs(planId)
	return self._star_battle_progress_prize_plan[planId]
end

function StarBattleConfig:getRankPrizeCfgs(planId)
	if not self._star_battle_score_rank_prize_plan.dataList then
		local rankCfgs = {}

		for _, v in ipairs(self._star_battle_score_rank_prize_plan.dataList) do
			if v.rankPlanId == planId then
				table.insert(rankCfgs, v)
			end
		end

		return rankCfgs
	end
end

function StarBattleConfig:getRankPrizeCfgByRank(planId, rank)
	local prizeCfgs = self:getRankPrizeCfgs(planId)

	if prizeCfgs then
		for _, cfg in ipairs(prizeCfgs) do
			if cfg.rankRange then
				local minRank, maxRank = checknumber(cfg.rankRange[1]), checknumber(cfg.rankRange[2])

				if minRank <= rank and rank <= maxRank then
					return cfg
				end
			end
		end
	end
end

StarBattleConfig.instance = StarBattleConfig.New()

return StarBattleConfig
