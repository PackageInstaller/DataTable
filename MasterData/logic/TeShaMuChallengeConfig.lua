-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teshamu/config/TeShaMuChallengeConfig.lua

module("logic.extensions.teshamu.config.TeShaMuChallengeConfig", package.seeall)

local TeShaMuChallengeConfig = class("TeShaMuChallengeConfig", BaseConfig)

function TeShaMuChallengeConfig:onInit()
	TeShaMuChallengeConfig.super.onInit(self)
end

function TeShaMuChallengeConfig:getNames()
	return {
		"teshamu_challenge",
		"teshamu_stage",
		"teshamu_map_plan",
		"teshamu_level_plan",
		"teshamu_master",
		"teshamu_creeps",
		"teshamu_sign_in_buff"
	}
end

function TeShaMuChallengeConfig:handleConfig(name, content)
	if name == "teshamu_challenge" then
		self._teshamu_challengeCfg = content
	elseif name == "teshamu_stage" then
		self._teshamu_stageCfg = content
	elseif name == "teshamu_map_plan" then
		self._teshamu_map_planCfg = content
	elseif name == "teshamu_level_plan" then
		self._teshamu_level_planCfg = content
	elseif name == "teshamu_master" then
		self._teshamu_masterCfg = content
	elseif name == "teshamu_creeps" then
		self._teshamu_creepsCfg = content
	elseif name == "teshamu_sign_in_buff" then
		self._teshamu_sign_in_buff = content
	end
end

function TeShaMuChallengeConfig:getChallengeCfg(activityId)
	return self._teshamu_challengeCfg[activityId]
end

function TeShaMuChallengeConfig:getStageCfg(activityId)
	return self._teshamu_stageCfg[activityId]
end

function TeShaMuChallengeConfig:getStageCfgById(activityId, stageId)
	return self._teshamu_stageCfg[activityId][stageId]
end

function TeShaMuChallengeConfig:getMapPlanCfg(mapPlanId)
	return self._teshamu_map_planCfg[mapPlanId]
end

function TeShaMuChallengeConfig:getMapPlanCfgById(mapPlanId, blockId)
	return self._teshamu_map_planCfg[mapPlanId][blockId]
end

function TeShaMuChallengeConfig:getLevelPlanCfg(levelPlanId)
	return self._teshamu_level_planCfg[levelPlanId]
end

function TeShaMuChallengeConfig:getLevelPlanCfgById(levelPlanId, level)
	return self._teshamu_level_planCfg[levelPlanId][level]
end

function TeShaMuChallengeConfig:getMasterCfg(mapMonsterPlanId)
	return self._teshamu_masterCfg[mapMonsterPlanId]
end

function TeShaMuChallengeConfig:getMasterCfgById(mapMonsterPlanId, blockId)
	return self._teshamu_masterCfg[mapMonsterPlanId][blockId]
end

function TeShaMuChallengeConfig:getCreepsCfg(creepsMasterId)
	return self._teshamu_creepsCfg[creepsMasterId]
end

function TeShaMuChallengeConfig:getBuffCfgs(buffPlanId)
	return self._teshamu_sign_in_buff[buffPlanId]
end

TeShaMuChallengeConfig.instance = TeShaMuChallengeConfig.New()

return TeShaMuChallengeConfig
