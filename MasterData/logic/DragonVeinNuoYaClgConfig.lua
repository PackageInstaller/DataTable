-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonveinnuoyaclg/config/DragonVeinNuoYaClgConfig.lua

module("logic.extensions.dragonveinnuoyaclg.config.DragonVeinNuoYaClgConfig", package.seeall)

local DragonVeinNuoYaClgConfig = class("DragonVeinNuoYaClgConfig", BaseConfig)

function DragonVeinNuoYaClgConfig:onInit()
	return
end

function DragonVeinNuoYaClgConfig:getNames()
	return {
		"dragon_vein_nuo_ya_clg_stage",
		"dragon_vein_nuo_ya_clg_creeps_master",
		"dragon_vein_nuo_ya_clg_creeps",
		"dragon_vein_nuo_ya_clg"
	}
end

function DragonVeinNuoYaClgConfig:handleConfig(name, content)
	if name == "dragon_vein_nuo_ya_clg_stage" then
		self._dragon_vein_nuo_ya_clg_stage = content
	elseif name == "dragon_vein_nuo_ya_clg_creeps_master" then
		self._dragon_vein_nuo_ya_clg_creeps_master = content
	elseif name == "dragon_vein_nuo_ya_clg_creeps" then
		self._dragon_vein_nuo_ya_clg_creeps = content
	elseif name == "dragon_vein_nuo_ya_clg" then
		self._dragon_vein_nuo_ya_clg = content
	end
end

function DragonVeinNuoYaClgConfig:getActivityCfg(activityId)
	return self._dragon_vein_nuo_ya_clg[activityId]
end

function DragonVeinNuoYaClgConfig:getStageCfgs(activityId)
	return self._dragon_vein_nuo_ya_clg_stage[activityId]
end

function DragonVeinNuoYaClgConfig:getStageCfg(activityId, stageId)
	return self._dragon_vein_nuo_ya_clg_stage[activityId][stageId]
end

function DragonVeinNuoYaClgConfig:getTeamCfg(creepsMasterId)
	return self._dragon_vein_nuo_ya_clg_creeps_master[creepsMasterId]
end

function DragonVeinNuoYaClgConfig:getCreepsCfg(creepsMasterId)
	return self._dragon_vein_nuo_ya_clg_creeps[creepsMasterId]
end

DragonVeinNuoYaClgConfig.instance = DragonVeinNuoYaClgConfig.New()

return DragonVeinNuoYaClgConfig
