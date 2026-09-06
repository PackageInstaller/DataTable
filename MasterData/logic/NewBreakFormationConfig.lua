-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbreakformation/config/NewBreakFormationConfig.lua

module("logic.extensions.newbreakformation.config.NewBreakFormationConfig", package.seeall)

local NewBreakFormationConfig = class("NewBreakFormationConfig", BaseConfig)

function NewBreakFormationConfig:onInit()
	NewBreakFormationConfig.super.onInit(self)
end

function NewBreakFormationConfig:getNames()
	return {
		"new_breach_formation_season",
		"new_breach_formation_tab",
		"new_breach_formation_period",
		"new_breach_formation_stage",
		"new_breach_formation_monster",
		"new_breach_formation_creeps",
		"new_breach_formation_buff",
		"new_breach_formation_score_prize",
		"new_breach_formation_rank_prize",
		"new_breach_formation_rank_level",
		"new_breach_formation_pet_buff"
	}
end

function NewBreakFormationConfig:handleConfig(name, content)
	if name == "new_breach_formation_season" then
		self._new_breach_formation_season = content
	elseif name == "new_breach_formation_tab" then
		self._new_breach_formation_tab = content
	elseif name == "new_breach_formation_period" then
		self._new_breach_formation_period = content
	elseif name == "new_breach_formation_stage" then
		self._new_breach_formation_stage = content
	elseif name == "new_breach_formation_monster" then
		self._new_breach_formation_monster = content
	elseif name == "new_breach_formation_creeps" then
		self._new_breach_formation_creeps = content
	elseif name == "new_breach_formation_buff" then
		self._new_breach_formation_buff = content
	elseif name == "new_breach_formation_score_prize" then
		self._new_breach_formation_score_prize = content
	elseif name == "new_breach_formation_rank_prize" then
		self._new_breach_formation_rank_prize = content
	elseif name == "new_breach_formation_rank_level" then
		self._new_breach_formation_rank_level = content
	elseif name == "new_breach_formation_pet_buff" then
		self._new_breach_formation_pet_buff = content
	end
end

function NewBreakFormationConfig:getSeasonCfgs()
	return self._new_breach_formation_season.dataList
end

function NewBreakFormationConfig:getSeasonCfg(seasonId)
	return self._new_breach_formation_season[seasonId]
end

function NewBreakFormationConfig:getTabCfgs(seasonId)
	return self._new_breach_formation_tab[seasonId]
end

function NewBreakFormationConfig:getTabCfg(seasonId, tabId)
	if self._new_breach_formation_tab[seasonId] then
		return self._new_breach_formation_tab[seasonId][tabId]
	end

	return nil
end

function NewBreakFormationConfig:getPeriodCfgs(periodPlanId)
	return self._new_breach_formation_period[periodPlanId]
end

function NewBreakFormationConfig:getPeriodCfg(periodPlanId, periodId)
	return self._new_breach_formation_period[periodPlanId][periodId]
end

function NewBreakFormationConfig:getStageCfgs(stagePlanId)
	return self._new_breach_formation_stage[stagePlanId]
end

function NewBreakFormationConfig:getStageCfg(stagePlanId, stageId)
	return self._new_breach_formation_stage[stagePlanId][stageId]
end

function NewBreakFormationConfig:getMasterTeamCfg(creepsMasterId)
	return self._new_breach_formation_monster[creepsMasterId]
end

function NewBreakFormationConfig:getCreepsCfg(creepsMasterId)
	return self._new_breach_formation_creeps[creepsMasterId]
end

function NewBreakFormationConfig:getBuffCfgs(buffPlanId)
	return self._new_breach_formation_buff[buffPlanId]
end

function NewBreakFormationConfig:getBuffCfg(buffPlanId, buffId)
	return self._new_breach_formation_buff[buffPlanId][buffId]
end

function NewBreakFormationConfig:getRankLevelCfg(rankLevelPlanId)
	return self._new_breach_formation_rank_level[rankLevelPlanId]
end

function NewBreakFormationConfig:getRankCfg(seasonId, rank)
	local result

	if self._new_breach_formation_rank_prize[seasonId] then
		for i = #self._new_breach_formation_rank_prize[seasonId], 1, -1 do
			if rank >= self._new_breach_formation_rank_prize[seasonId][i].rank[1] and rank <= self._new_breach_formation_rank_prize[seasonId][i].rank[2] then
				result = self._new_breach_formation_rank_prize[seasonId][i]

				break
			end
		end
	end

	return result
end

function NewBreakFormationConfig:getRankCfgs(seasonId)
	return self._new_breach_formation_rank_prize[seasonId]
end

function NewBreakFormationConfig:getScorePlanCfgs(scorePlanId)
	return self._new_breach_formation_score_prize[scorePlanId]
end

function NewBreakFormationConfig:getPetBuffCfg(buffPlanId, raceId)
	return self._new_breach_formation_pet_buff[buffPlanId][raceId]
end

function NewBreakFormationConfig:getPetBuffCfgs(buffPlanId)
	return table.values(self._new_breach_formation_pet_buff[buffPlanId])
end

NewBreakFormationConfig.instance = NewBreakFormationConfig.New()

return NewBreakFormationConfig
