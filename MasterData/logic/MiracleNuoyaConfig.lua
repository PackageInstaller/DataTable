-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclenuoya/config/MiracleNuoyaConfig.lua

module("logic.extensions.miraclenuoya.config.MiracleNuoyaConfig", package.seeall)

local MiracleNuoyaConfig = class("MiracleNuoyaConfig", BaseConfig)

function MiracleNuoyaConfig:getNames()
	return {
		"miracle_nuo_ya_clg",
		"miracle_nuo_ya_normal_clg_stage_group",
		"miracle_nuo_ya_normal_clg_damage",
		"miracle_nuo_ya_normal_clg_progress",
		"miracle_nuo_ya_extreme_clg_map",
		"miracle_nuo_ya_extreme_clg_buff",
		"miracle_nuo_ya_extreme_clg_support_pet",
		"miracle_nuo_ya_clg_creeps_master",
		"miracle_nuo_ya_clg_creeps"
	}
end

function MiracleNuoyaConfig:handleConfig(name, content)
	if name == "miracle_nuo_ya_clg" then
		self._miracle_nuo_ya_clg = content
	elseif name == "miracle_nuo_ya_normal_clg_stage_group" then
		self._miracle_nuo_ya_normal_clg_stage_group = content
	elseif name == "miracle_nuo_ya_normal_clg_damage" then
		self._miracle_nuo_ya_normal_clg_damage = content
	elseif name == "miracle_nuo_ya_normal_clg_progress" then
		self._miracle_nuo_ya_normal_clg_progress = content
	elseif name == "miracle_nuo_ya_extreme_clg_map" then
		self._miracle_nuo_ya_extreme_clg_map = content
	elseif name == "miracle_nuo_ya_extreme_clg_buff" then
		self._miracle_nuo_ya_extreme_clg_buff = content
	elseif name == "miracle_nuo_ya_extreme_clg_support_pet" then
		self._miracle_nuo_ya_extreme_clg_support_pet = content
	elseif name == "miracle_nuo_ya_clg_creeps_master" then
		self._miracle_nuo_ya_clg_creeps_master = content
	elseif name == "miracle_nuo_ya_clg_creeps" then
		self._miracle_nuo_ya_clg_creeps = content
	end
end

function MiracleNuoyaConfig:getActivityCfgById(id)
	return self._miracle_nuo_ya_clg[id]
end

function MiracleNuoyaConfig:getGroupCfgById(activityId, groupId)
	if self._miracle_nuo_ya_normal_clg_stage_group[activityId] then
		return self._miracle_nuo_ya_normal_clg_stage_group[activityId][groupId]
	end
end

function MiracleNuoyaConfig:getDamageListCfgById(activityId)
	return self._miracle_nuo_ya_normal_clg_damage[activityId]
end

function MiracleNuoyaConfig:getDamageCfgById(activityId, subId)
	if self._miracle_nuo_ya_normal_clg_damage[activityId] then
		return self._miracle_nuo_ya_normal_clg_damage[activityId][subId]
	end
end

function MiracleNuoyaConfig:getProgressListCfg(activityId)
	return self._miracle_nuo_ya_normal_clg_progress[activityId]
end

function MiracleNuoyaConfig:getProgressCfgById(activityId, dataBitId)
	if self._miracle_nuo_ya_normal_clg_progress[activityId] then
		return self._miracle_nuo_ya_normal_clg_progress[activityId][dataBitId]
	end
end

function MiracleNuoyaConfig:getMapCfgById(activityId)
	return self._miracle_nuo_ya_extreme_clg_map[activityId]
end

function MiracleNuoyaConfig:getMapBlockCfgById(activityId, blockId)
	if self._miracle_nuo_ya_extreme_clg_map[activityId] then
		return self._miracle_nuo_ya_extreme_clg_map[activityId][blockId]
	end
end

function MiracleNuoyaConfig:getBuffListCfg(activityId)
	return self._miracle_nuo_ya_extreme_clg_buff[activityId]
end

function MiracleNuoyaConfig:getBuffCfgById(activityId, buffId)
	if self._miracle_nuo_ya_extreme_clg_buff[activityId] then
		return self._miracle_nuo_ya_extreme_clg_buff[activityId][buffId]
	end
end

function MiracleNuoyaConfig:getSupportCfgById(creepsId)
	return self._miracle_nuo_ya_extreme_clg_support_pet[creepsId]
end

function MiracleNuoyaConfig:getMonsterCfgById(creepsMasterId)
	return self._miracle_nuo_ya_clg_creeps_master[creepsMasterId]
end

function MiracleNuoyaConfig:getCreepsCfgById(creepsMasterId)
	return self._miracle_nuo_ya_clg_creeps[creepsMasterId]
end

MiracleNuoyaConfig.instance = MiracleNuoyaConfig.New()

return MiracleNuoyaConfig
