-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/config/TeenChampionKingConfig.lua

module("logic.extensions.teenchampionking.config.TeenChampionKingConfig", package.seeall)

local TeenChampionKingConfig = class("TeenChampionKingConfig", BaseConfig)

function TeenChampionKingConfig:getNames()
	return {
		"teen_champion_king_common",
		"teen_champion_king_guess",
		"teen_champion_king_champion_guess",
		"teen_champion_king_qualifier_match",
		"teen_champion_king_round",
		"teen_champion_king_zone",
		"teen_champion_king_step",
		"teen_champion_king_activity",
		"teen_champion_king_qualify",
		"teen_champion_king_qualifier_match_score",
		"teen_champion_king_qualifier_rank_score",
		"teen_champion_king_qualify_rank_prize",
		"teen_champion_king_knockout_rank_prize",
		"teen_champion_king_hud",
		"teen_champion_king_knockout_game",
		"teen_champion_king_system_pet"
	}
end

function TeenChampionKingConfig:handleConfig(name, content)
	if name == "teen_champion_king_common" then
		self._teen_champion_king_common = content
	elseif name == "teen_champion_king_guess" then
		self._teen_champion_king_guess = content
	elseif name == "teen_champion_king_champion_guess" then
		self._teen_champion_king_champion_guess = content
	elseif name == "teen_champion_king_qualifier_match" then
		self._teen_champion_king_qualifier_match = content
	elseif name == "teen_champion_king_round" then
		self._teen_champion_king_round = content
	elseif name == "teen_champion_king_zone" then
		self._teen_champion_king_zone = content
	elseif name == "teen_champion_king_step" then
		self._teen_champion_king_step = content
	elseif name == "teen_champion_king_activity" then
		self._teen_champion_king_activity = content
	elseif name == "teen_champion_king_qualify" then
		self._teen_champion_king_qualify = content
	elseif name == "teen_champion_king_qualifier_match_score" then
		self._teen_champion_king_qualifier_match_score = content
	elseif name == "teen_champion_king_qualifier_rank_score" then
		self._teen_champion_king_qualifier_rank_score = content
	elseif name == "teen_champion_king_qualify_rank_prize" then
		self._teen_champion_king_qualify_rank_prize = content

		self:_handleQualifyRankPrizeCfgs()
	elseif name == "teen_champion_king_knockout_rank_prize" then
		self._teen_champion_king_knockout_rank_prize = content
	elseif name == "teen_champion_king_hud" then
		self._teen_champion_king_hud = content
	elseif name == "teen_champion_king_knockout_game" then
		self._teen_champion_king_knockout_game = content
	elseif name == "teen_champion_king_system_pet" then
		self._teen_champion_king_system_pet = content
	end
end

function TeenChampionKingConfig:getRoundCfgsByActId(activityId)
	return self._teen_champion_king_round[activityId]
end

function TeenChampionKingConfig:getRoundCfgByRoundId(activityId, roundId)
	if self._teen_champion_king_round[activityId] then
		return self._teen_champion_king_round[activityId][roundId]
	end
end

function TeenChampionKingConfig:getStepCfgsByActId(activityId)
	return self._teen_champion_king_step[activityId]
end

function TeenChampionKingConfig:getStepCfgByStepId(activityId, stepId)
	if self._teen_champion_king_step[activityId] then
		return self._teen_champion_king_step[activityId][stepId]
	end
end

function TeenChampionKingConfig:getRoundCfgByStepId(activityId, stepId)
	local stepCfg = self:getStepCfgByStepId(activityId, stepId)

	if stepCfg then
		return self:getRoundCfgByRoundId(activityId, stepCfg.roundId)
	end
end

function TeenChampionKingConfig:getRoundIdByStepId(activityId, stepId)
	local stepCfg = self:getStepCfgByStepId(activityId, stepId)

	if stepCfg then
		return stepCfg.roundId
	end

	return -1
end

function TeenChampionKingConfig:getActCfg(activityId)
	return self._teen_champion_king_activity[activityId]
end

function TeenChampionKingConfig:_handleQualifyRankPrizeCfgs()
	self._qualifyRankPrizeCfgs = {}

	for i, v in ipairs(self._teen_champion_king_qualify_rank_prize.dataList) do
		self._qualifyRankPrizeCfgs[v.activityId] = self._qualifyRankPrizeCfgs[v.activityId] or {}

		table.insert(self._qualifyRankPrizeCfgs[v.activityId], v)
	end
end

function TeenChampionKingConfig:getQualifyRankPrizeCfgs(activityId)
	return self._qualifyRankPrizeCfgs[activityId] or {}
end

function TeenChampionKingConfig:getKnockoutRankPrizeCfgs(activityId)
	return self._teen_champion_king_knockout_rank_prize[activityId] or {}
end

function TeenChampionKingConfig:getZoneCfgs(activityId)
	return self._teen_champion_king_zone[activityId]
end

function TeenChampionKingConfig:getHudCfgs(activityId)
	return self._teen_champion_king_hud[activityId]
end

function TeenChampionKingConfig:getQualifyCfg(activityId, stepId)
	if self._teen_champion_king_qualify[activityId] then
		return self._teen_champion_king_qualify[activityId][stepId]
	end
end

function TeenChampionKingConfig:getGuessCfg(gussPlanId)
	return self._teen_champion_king_guess[gussPlanId]
end

function TeenChampionKingConfig:getCommonValue(key)
	if self._teen_champion_king_common[key] then
		return self._teen_champion_king_common[key].value
	end
end

function TeenChampionKingConfig:getGameRoundCfg(activityId, roundId)
	if self._teen_champion_king_knockout_game[activityId] then
		return self._teen_champion_king_knockout_game[activityId][roundId]
	end

	return nil
end

function TeenChampionKingConfig:getQualiflerRankScoreCfgs(planId)
	return self._teen_champion_king_qualifier_rank_score[planId]
end

function TeenChampionKingConfig:getSystemPetByCreepsId(creepsId)
	return self._teen_champion_king_system_pet[creepsId]
end

function TeenChampionKingConfig:getSystemPets()
	return self._teen_champion_king_system_pet.dataList
end

TeenChampionKingConfig.instance = TeenChampionKingConfig.New()

return TeenChampionKingConfig
