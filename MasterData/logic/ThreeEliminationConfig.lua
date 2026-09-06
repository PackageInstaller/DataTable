-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/config/ThreeEliminationConfig.lua

module("logic.extensions.tabframework.config.ThreeEliminationConfig", package.seeall)

local ThreeEliminationConfig = class("ThreeEliminationConfig", BaseConfig)

function ThreeEliminationConfig:onInit()
	ThreeEliminationConfig.super.onInit(self)
end

function ThreeEliminationConfig:getNames()
	return {
		"three_elimination_game_activity",
		"three_elimination_game_buff",
		"three_elimination_game_player_lvl",
		"three_elimination_game_pet_quality",
		"three_elimination_game_map",
		"three_elimination_game_pet",
		"three_elimination_game_group",
		"three_elimination_game_rival_plan",
		"three_elimination_game_rank",
		"three_elimination_game_rule"
	}
end

function ThreeEliminationConfig:handleConfig(name, content)
	if name == "three_elimination_game_activity" then
		self._three_elimination_game_activity = content
	elseif name == "three_elimination_game_buff" then
		self._three_elimination_game_buff = content
	elseif name == "three_elimination_game_player_lvl" then
		self._three_elimination_game_player_lvl = content
	elseif name == "three_elimination_game_pet_quality" then
		self._three_elimination_game_pet_quality = content
	elseif name == "three_elimination_game_map" then
		self._three_elimination_game_map = content
	elseif name == "three_elimination_game_pet" then
		self._three_elimination_game_pet = content
	elseif name == "three_elimination_game_group" then
		self._three_elimination_game_group = content
	elseif name == "three_elimination_game_rival_plan" then
		self._three_elimination_game_rival_plan = content
	elseif name == "three_elimination_game_rank" then
		self._three_elimination_game_rank = content
	elseif name == "three_elimination_game_rule" then
		self._three_elimination_game_rule = content
	end
end

function ThreeEliminationConfig:getActivityCfg(activityId)
	return self._three_elimination_game_activity[activityId]
end

function ThreeEliminationConfig:getBuffCfgs(activityId)
	return self._three_elimination_game_buff[activityId]
end

function ThreeEliminationConfig:getBuffCfg(activityId, buffId)
	return self._three_elimination_game_buff[activityId][buffId]
end

function ThreeEliminationConfig:getAllGroupCfg(activityId)
	return self._three_elimination_game_group[activityId]
end

function ThreeEliminationConfig:getGroupCfg(activityId, groupId)
	return self._three_elimination_game_group[activityId][groupId]
end

function ThreeEliminationConfig:getStageCfg(activityId, groupId, stageId)
	return self._three_elimination_game_group[activityId][groupId][stageId]
end

function ThreeEliminationConfig:getMapCfg(mapId)
	return self._three_elimination_game_map[mapId]
end

function ThreeEliminationConfig:getPetCfgs(activityId)
	return self._three_elimination_game_pet[activityId]
end

function ThreeEliminationConfig:getPlayerLevelCfg(activityId, level)
	return self._three_elimination_game_player_lvl[activityId][level]
end

function ThreeEliminationConfig:getPetCfg(activityId, uniqueId)
	return self._three_elimination_game_pet[activityId][uniqueId]
end

function ThreeEliminationConfig:getQualityCfg(activityId, quality)
	return self._three_elimination_game_pet_quality[activityId][quality]
end

function ThreeEliminationConfig:getQualityCfgs(activityId)
	return self._three_elimination_game_pet_quality[activityId]
end

function ThreeEliminationConfig:getRivalCfg(planId)
	return self._three_elimination_game_rival_plan[planId]
end

function ThreeEliminationConfig:getImgRule(ruleId)
	return self._three_elimination_game_rule[ruleId]
end

ThreeEliminationConfig.instance = ThreeEliminationConfig.New()

return ThreeEliminationConfig
