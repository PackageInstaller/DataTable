-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemiyaclg/config/DivineMiyaClgConfig.lua

module("logic.extensions.divinemiyaclg.config.DivineMiyaClgConfig", package.seeall)

local DivineMiyaClgConfig = class("DivineMiyaClgConfig", BaseConfig)

function DivineMiyaClgConfig:onInit()
	DivineMiyaClgConfig.super.onInit(self)
end

function DivineMiyaClgConfig:getNames()
	return {
		"divine_mi_ya_clg_creeps_master",
		"divine_mi_ya_clg_progress_prize",
		"divine_mi_ya_clg_stage",
		"divine_mi_ya_clg_skill_buff",
		"divine_mi_ya_clg_creeps",
		"divine_mi_ya_clg",
		"divine_mi_ya_clg_rule"
	}
end

function DivineMiyaClgConfig:handleConfig(name, content)
	if name == "divine_mi_ya_clg_creeps_master" then
		self._divine_mi_ya_clg_creeps_master = content
	elseif name == "divine_mi_ya_clg_progress_prize" then
		self._divine_mi_ya_clg_progress_prize = content
	elseif name == "divine_mi_ya_clg_stage" then
		self._divine_mi_ya_clg_stage = content
	elseif name == "divine_mi_ya_clg_skill_buff" then
		self._divine_mi_ya_clg_skill_buff = content
	elseif name == "divine_mi_ya_clg_creeps" then
		self._divine_mi_ya_clg_creeps = content
	elseif name == "divine_mi_ya_clg" then
		self._divine_mi_ya_clg = content
	elseif name == "divine_mi_ya_clg_rule" then
		self._divine_mi_ya_clg_rule = content
	end
end

function DivineMiyaClgConfig:getActivityCfg(activityId)
	return self._divine_mi_ya_clg[activityId]
end

function DivineMiyaClgConfig:getProgressPrizeCfgs(activityId)
	return self._divine_mi_ya_clg_progress_prize[activityId]
end

function DivineMiyaClgConfig:getProgressPrizeCfg(activityId, dataBitId)
	return self._divine_mi_ya_clg_progress_prize[activityId][dataBitId]
end

function DivineMiyaClgConfig:getSkillBuffs(activityId)
	return self._divine_mi_ya_clg_skill_buff[activityId]
end

function DivineMiyaClgConfig:getStageCfgs(activityId)
	return self._divine_mi_ya_clg_stage[activityId]
end

function DivineMiyaClgConfig:getStageCfg(activityId, stageId)
	return self._divine_mi_ya_clg_stage[activityId][stageId]
end

function DivineMiyaClgConfig:getTeamCfg(creepsMasterId)
	return self._divine_mi_ya_clg_creeps_master[creepsMasterId]
end

function DivineMiyaClgConfig:getCreepsCfg(creepsMasterId)
	return self._divine_mi_ya_clg_creeps[creepsMasterId]
end

function DivineMiyaClgConfig:getRuleCfgs(activityId)
	return self._divine_mi_ya_clg_rule[activityId]
end

DivineMiyaClgConfig.instance = DivineMiyaClgConfig.New()

return DivineMiyaClgConfig
