-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/config/ShowDownConfig.lua

module("logic.extensions.showdown.config.ShowDownConfig", package.seeall)

local ShowDownConfig = class("ShowDownConfig", BaseConfig)

function ShowDownConfig:onInit()
	ShowDownConfig.super.onInit(self)
end

function ShowDownConfig:getNames()
	return {
		"show_down_activity",
		"show_down_client_common",
		"show_down_step",
		"show_down_round",
		"show_down_qualify",
		"show_down_match_rule",
		"show_down_qualify_prize",
		"show_down_select_pet_plan",
		"show_down_buy_refresh_times",
		"show_down_team",
		"show_down_guess",
		"show_down_team_icon",
		"show_down_system_pet_pool",
		"show_down_system_pet",
		"show_down_buff",
		"show_down_random_form",
		"show_down_creeps",
		"show_down_creeps_master",
		"show_down_final_match_prize"
	}
end

function ShowDownConfig:handleConfig(name, content)
	if name == "show_down_activity" then
		self.show_down_activity = content
	elseif name == "show_down_client_common" then
		self.show_down_client_common = content
	elseif name == "show_down_step" then
		self.show_down_step = content
	elseif name == "show_down_round" then
		self.show_down_round = content
	elseif name == "show_down_qualify" then
		self.show_down_qualify = content
	elseif name == "show_down_match_rule" then
		self.show_down_match_rule = content
	elseif name == "show_down_qualify_prize" then
		self.show_down_qualify_prize = content
	elseif name == "show_down_select_pet_plan" then
		self.show_down_select_pet_plan = content
	elseif name == "show_down_buy_refresh_times" then
		self.show_down_buy_refresh_times = content
	elseif name == "show_down_team" then
		self.show_down_team = content
	elseif name == "show_down_guess" then
		self.show_down_guess = content
	elseif name == "show_down_team_icon" then
		self.show_down_team_icon = content
	elseif name == "show_down_system_pet_pool" then
		self.show_down_system_pet_pool = content
	elseif name == "show_down_system_pet" then
		self.show_down_system_pet = content
	elseif name == "show_down_buff" then
		self.show_down_buff = content
	elseif name == "show_down_random_form" then
		self.show_down_random_form = content
	elseif name == "show_down_creeps" then
		self.show_down_creeps = content
	elseif name == "show_down_creeps_master" then
		self.show_down_creeps_master = content
	elseif name == "show_down_final_match_prize" then
		self.show_down_final_match_prize = content
	end
end

function ShowDownConfig:getActData(activityId)
	return self.show_down_activity[activityId]
end

function ShowDownConfig:getCommonValue(activityId, key, isToNumber)
	local data = self:getActData(activityId)

	if data then
		if not data.comPlanId then
			local comPlanId = 0
			local comData = self.show_down_client_common[comPlanId]

			if comData then
				if isToNumber then
					return checknumber(comData[key])
				else
					return comData[key]
				end
			end
		end
	end
end

function ShowDownConfig:getStepCfg(activityId)
	return self.show_down_step[activityId]
end

function ShowDownConfig:getStepData(activityId, stepId)
	if self.show_down_step[activityId] then
		return self.show_down_step[activityId][stepId]
	end
end

function ShowDownConfig:getRoundCfg(activityId)
	return self.show_down_round[activityId]
end

function ShowDownConfig:getRoundData(activityId, roundId)
	if roundId == ShowDownEnum.Round_Func then
		roundId = ShowDownEnum.Round_Qualify
	end

	if self.show_down_round[activityId] then
		return self.show_down_round[activityId][roundId]
	end
end

function ShowDownConfig:getQualifyCfg(activityId)
	return self.show_down_qualify[activityId]
end

function ShowDownConfig:getQualifyData(activityId, qualType)
	return self.show_down_qualify[activityId][qualType]
end

function ShowDownConfig:getMatchRuleCfg(activityId, qualType)
	local data = self:getQualifyData(activityId, qualType)
	local matchPlanId = data and data.matchPlanId

	if matchPlanId then
		return self._show_down_match_rule[matchPlanId]
	end
end

function ShowDownConfig:getMatchRuleData(activityId, qualType, matchId)
	local cfg = self:getMatchRuleCfg(activityId, qualType)

	if cfg then
		return cfg[matchId]
	end
end

function ShowDownConfig:getQualifyPrizeCfg(activityId, qualType)
	local data = self:getQualifyData(activityId, qualType)
	local prizePlanId = data and data.prizePlanId

	if prizePlanId then
		return self.show_down_qualify_prize[prizePlanId]
	end
end

function ShowDownConfig:getQualifyPrizeData(activityId, qualType, times)
	local cfg = self:getQualifyPrizeCfg(activityId, qualType)

	if cfg then
		return cfg[times]
	end
end

function ShowDownConfig:getSelectPetPlanData(activityId, roundId)
	local data = self:getRoundData(activityId, roundId)
	local selectPetPlanId = data and data.selectPetPlanId

	if selectPetPlanId then
		return self.show_down_select_pet_plan[selectPetPlanId]
	end
end

function ShowDownConfig:getBuyRefreshTimesCfg(activityId, roundId)
	local data = self:getSelectPetPlanData(activityId, roundId)
	local refreshTimesPlanId = data and data.refreshTimesPlanId

	if refreshTimesPlanId then
		return self.show_down_buy_refresh_times[refreshTimesPlanId]
	end
end

function ShowDownConfig:getBuyRefreshTimesData(activityId, roundId, buyId)
	local cfg = self:getBuyRefreshTimesCfg(activityId, roundId)

	if cfg then
		return cfg[buyId]
	end
end

function ShowDownConfig:getBuyRefreshTimesDataByTimes(activityId, roundId, times)
	local result
	local cfg = self:getBuyRefreshTimesCfg(activityId, roundId)

	for _, data in ipairs(cfg or {}) do
		if times >= data.count then
			result = data
		else
			break
		end
	end

	return result
end

function ShowDownConfig:getTeamData(activityId)
	return self.show_down_team[activityId]
end

function ShowDownConfig:getGuessData(activityId, roundId)
	local data = self:getRoundData(activityId, roundId)
	local gussPlanId = data and data.gussPlanId

	if gussPlanId then
		return self.show_down_guess[gussPlanId]
	end
end

function ShowDownConfig:getMinGuessScoreInGuess(activityId, roundId)
	local data = self:getGuessData(activityId, roundId)

	if data then
		return data.minGuessScore
	end

	return 0
end

function ShowDownConfig:getMaxGuessScoreInGuess(activityId, roundId)
	local data = self:getGuessData(activityId, roundId)

	if data then
		return data.maxGuessScore
	end

	return 0
end

function ShowDownConfig:getGuessRoundLimitInGuess(activityId, roundId)
	local data = self:getGuessData(activityId, roundId)

	if data then
		return data.guessRoundLimit
	end

	return 0
end

function ShowDownConfig:getWinRatioInGuess(activityId, roundId)
	local data = self:getGuessData(activityId, roundId)

	if data then
		return data.winRatio
	end

	return 0
end

function ShowDownConfig:getSameGroupLimitInGuess(activityId, roundId)
	local data = self:getGuessData(activityId, roundId)

	if data then
		return data.sameGroupLimit
	end

	return 0
end

function ShowDownConfig:getTeamIconCfg(activityId)
	local activityCfg = self.show_down_activity[activityId]

	if activityCfg then
		return self.show_down_team_icon[activityCfg.teamIconPlanId]
	end
end

function ShowDownConfig:getTeamIconData(activityId, iconId)
	local iconCfgs = self:getTeamIconCfg(activityId)

	if iconCfgs then
		return iconCfgs[iconId]
	end
end

function ShowDownConfig:getSystemPetPoolCfg(systemPetPoolId)
	return self.show_down_system_pet_pool[systemPetPoolId]
end

function ShowDownConfig:getSystemPetPoolData(systemPetPoolId, creepsId)
	if self.show_down_system_pet_pool[systemPetPoolId] then
		return self.show_down_system_pet_pool[systemPetPoolId][creepsId]
	end
end

function ShowDownConfig:getSystemPetData(creepsId)
	return self.show_down_system_pet[creepsId]
end

function ShowDownConfig:getBuffCfg(activityId, roundId)
	local data = self:getRoundData(activityId, roundId)
	local selectBuffPlanId = data and data.selectBuffPlanId

	if selectBuffPlanId then
		return self.show_down_buff[selectBuffPlanId]
	end
end

function ShowDownConfig:getBuffData(activityId, roundId, buffId)
	local cfg = self:getBuffCfg(activityId, roundId)

	if cfg then
		return cfg[buffId]
	end
end

function ShowDownConfig:getRandomFormCfg(activityId, roundId)
	local data = self:getRoundData(activityId, roundId)
	local randomFormPlanId = data and data.randomFormPlanId

	if randomFormPlanId then
		return self.show_down_random_form[randomFormPlanId]
	end
end

function ShowDownConfig:getRandomFormData(activityId, roundId, formId)
	local cfg = self:getRandomFormCfg(activityId, roundId)

	if cfg then
		return cfg[formId]
	end
end

function ShowDownConfig:getCreepsCfg(creepsMasterId)
	return self.show_down_creeps[creepsMasterId]
end

function ShowDownConfig:getCreepsData(creepsMasterId, creepsId)
	if self.show_down_creeps[creepsMasterId] then
		return self.show_down_creeps[creepsMasterId][creepsId]
	end
end

function ShowDownConfig:getCreepsMasterData(creepsMasterId)
	return self.show_down_creeps_master[creepsMasterId]
end

function ShowDownConfig:getFinalMatchPrizeCfg(activityId)
	return self.show_down_final_match_prize[activityId]
end

ShowDownConfig.instance = ShowDownConfig.New()

return ShowDownConfig
