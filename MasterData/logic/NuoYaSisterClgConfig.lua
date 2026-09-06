-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/config/NuoYaSisterClgConfig.lua

module("logic.extensions.nuoyasisterclg.config.NuoYaSisterClgConfig", package.seeall)

local NuoYaSisterClgConfig = class("NuoYaSisterClgConfig", BaseConfig)

function NuoYaSisterClgConfig:onInit()
	NuoYaSisterClgConfig.super.onInit(self)
end

function NuoYaSisterClgConfig:getNames()
	return {
		"divine_nuo_ya_sister_clg_team",
		"divine_nuo_ya_sister_extreme_clg_stage",
		"divine_nuo_ya_sister_extreme_clg_buff",
		"divine_nuo_ya_sister_common_clg_prize",
		"divine_nuo_ya_sister_extreme_clg_prize",
		"divine_nuo_ya_sister_common_clg_damage",
		"divine_nuo_ya_sister_common_clg_boss",
		"divine_nuo_ya_sister_extreme_clg_type",
		"divine_nuo_ya_sister_clg_creeps",
		"divine_nuo_ya_sister_clg_activity"
	}
end

function NuoYaSisterClgConfig:handleConfig(name, content)
	if name == "divine_nuo_ya_sister_clg_team" then
		self._divine_nuo_ya_sister_clg_team = content
	elseif name == "divine_nuo_ya_sister_extreme_clg_stage" then
		self._divine_nuo_ya_sister_extreme_clg_stage = content
	elseif name == "divine_nuo_ya_sister_extreme_clg_buff" then
		self._divine_nuo_ya_sister_extreme_clg_buff = content
	elseif name == "divine_nuo_ya_sister_common_clg_prize" then
		self._divine_nuo_ya_sister_common_clg_prize = content
	elseif name == "divine_nuo_ya_sister_extreme_clg_prize" then
		self._divine_nuo_ya_sister_extreme_clg_prize = content
	elseif name == "divine_nuo_ya_sister_common_clg_damage" then
		self._divine_nuo_ya_sister_common_clg_damage = content
	elseif name == "divine_nuo_ya_sister_common_clg_boss" then
		self._divine_nuo_ya_sister_common_clg_boss = content
	elseif name == "divine_nuo_ya_sister_extreme_clg_type" then
		self._divine_nuo_ya_sister_extreme_clg_type = content
	elseif name == "divine_nuo_ya_sister_clg_creeps" then
		self._divine_nuo_ya_sister_clg_creeps = content
	elseif name == "divine_nuo_ya_sister_clg_activity" then
		self._divine_nuo_ya_sister_clg_activity = content
	end
end

function NuoYaSisterClgConfig:getActivityCfg(activityId)
	return self._divine_nuo_ya_sister_clg_activity[activityId]
end

function NuoYaSisterClgConfig:getExtremeClgTypes(activityId)
	return self._divine_nuo_ya_sister_extreme_clg_type[activityId]
end

function NuoYaSisterClgConfig:getExtremeClgType(activityId, typeId)
	return self._divine_nuo_ya_sister_extreme_clg_type[activityId][typeId]
end

function NuoYaSisterClgConfig:getBuffCfg(activityId, typeId)
	return self._divine_nuo_ya_sister_extreme_clg_buff[activityId][typeId]
end

function NuoYaSisterClgConfig:getPrizeCfg(activityId)
	return self._divine_nuo_ya_sister_extreme_clg_prize[activityId]
end

function NuoYaSisterClgConfig:getStageCfgs(activityId, type)
	return self._divine_nuo_ya_sister_extreme_clg_stage[activityId][type]
end

function NuoYaSisterClgConfig:getStageCfg(activityId, type, stageId)
	return self._divine_nuo_ya_sister_extreme_clg_stage[activityId][type][stageId]
end

function NuoYaSisterClgConfig:getTeamCfg(creepsMasterId)
	return self._divine_nuo_ya_sister_clg_team[creepsMasterId]
end

function NuoYaSisterClgConfig:getCreepsCfg(creepsMasterId)
	return self._divine_nuo_ya_sister_clg_creeps[creepsMasterId]
end

function NuoYaSisterClgConfig:getRewardProgressListCfgs(activityId)
	return self._divine_nuo_ya_sister_common_clg_prize[activityId]
end

function NuoYaSisterClgConfig:getProgressRewardCfg(activityId, prizeId)
	return self._divine_nuo_ya_sister_common_clg_prize[activityId][prizeId]
end

function NuoYaSisterClgConfig:getCommonBossCfgs(activityId)
	return self._divine_nuo_ya_sister_common_clg_boss[activityId]
end

function NuoYaSisterClgConfig:getCommonBossCfg(activityId, day)
	return self._divine_nuo_ya_sister_common_clg_boss[activityId][day]
end

function NuoYaSisterClgConfig:getCommonDamageCfg(activityId, day)
	return self._divine_nuo_ya_sister_common_clg_damage[activityId][day]
end

function NuoYaSisterClgConfig:getCommonDamageCfgByIndex(activityId, day, id)
	return self._divine_nuo_ya_sister_common_clg_damage[activityId][day][id]
end

NuoYaSisterClgConfig.instance = NuoYaSisterClgConfig.New()

return NuoYaSisterClgConfig
