-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldcup/config/WorldCupConfig.lua

module("logic.extensions.worldcup.config.WorldCupConfig", package.seeall)

local WorldCupConfig = class("WorldCupConfig", BaseConfig)

function WorldCupConfig:onInit()
	WorldCupConfig.super.onInit(self)
end

function WorldCupConfig:getNames()
	return {
		"world_cup_activity",
		"world_cup_odds",
		"world_cup_team",
		"world_cup_stage",
		"world_cup_sign_in",
		"world_cup_top_guess"
	}
end

function WorldCupConfig:handleConfig(name, content)
	if name == "world_cup_activity" then
		self._world_cup_activity = content
	elseif name == "world_cup_odds" then
		self._world_cup_odds = content
	elseif name == "world_cup_team" then
		self._world_cup_team = content
	elseif name == "world_cup_stage" then
		self._world_cup_stage = content
	elseif name == "world_cup_sign_in" then
		self._world_cup_sign_in = content
	elseif name == "world_cup_top_guess" then
		self._world_cup_top_guess = content
	end
end

function WorldCupConfig:getActivityCfg(activityId)
	return self._world_cup_activity[activityId]
end

function WorldCupConfig:getStageCfg(activityId, stageId)
	if self._world_cup_stage[activityId] then
		return self._world_cup_stage[activityId][stageId]
	end
end

function WorldCupConfig:getStageCfgs(activityId)
	return self._world_cup_stage[activityId]
end

function WorldCupConfig:getTeamCfg(activityId, teamId)
	if self._world_cup_team[activityId] then
		return self._world_cup_team[activityId][teamId]
	end
end

function WorldCupConfig:getOddsCfg(activityId, stageId, defineId)
	if self._world_cup_odds[activityId] and self._world_cup_odds[activityId][stageId] then
		return self._world_cup_odds[activityId][stageId][defineId]
	end
end

function WorldCupConfig:getSignInPrizeCfgs(activityId)
	return self._world_cup_sign_in[activityId]
end

function WorldCupConfig:getTopGuessCfg(activityId)
	return self._world_cup_top_guess[activityId]
end

WorldCupConfig.instance = WorldCupConfig.New()

return WorldCupConfig
