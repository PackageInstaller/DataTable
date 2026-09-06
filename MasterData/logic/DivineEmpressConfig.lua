-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineempress/config/DivineEmpressConfig.lua

module("logic.extensions.divineempress.config.DivineEmpressConfig", package.seeall)

local DivineEmpressConfig = class("DivineEmpressConfig", BaseConfig)

function DivineEmpressConfig:getNames()
	return {
		"divine_empress_clg_creeps_master",
		"divine_empress_extreme_clg_stage",
		"divine_empress_extreme_clg_positive_buff",
		"divine_empress_activity",
		"divine_empress_normal_clg_support_pet",
		"divine_empress_normal_clg_stage",
		"divine_empress_extreme_clg_score",
		"divine_empress_normal_clg_buff",
		"divine_empress_extreme_clg_negative_buff",
		"divine_empress_creeps",
		"divine_empress_normal_clg_progress_prize"
	}
end

function DivineEmpressConfig:handleConfig(name, content)
	if name == "divine_empress_clg_creeps_master" then
		self._divine_empress_clg_creeps_master = content
	elseif name == "divine_empress_extreme_clg_stage" then
		self._divine_empress_extreme_clg_stage = content
	elseif name == "divine_empress_extreme_clg_positive_buff" then
		self._divine_empress_extreme_clg_positive_buff = content
	elseif name == "divine_empress_activity" then
		self._divine_empress_activity = content
	elseif name == "divine_empress_normal_clg_support_pet" then
		self._divine_empress_normal_clg_support_pet = content
	elseif name == "divine_empress_normal_clg_stage" then
		self._divine_empress_normal_clg_stage = content
	elseif name == "divine_empress_extreme_clg_score" then
		self._divine_empress_extreme_clg_score = content
	elseif name == "divine_empress_normal_clg_buff" then
		self._divine_empress_normal_clg_buff = content
	elseif name == "divine_empress_extreme_clg_negative_buff" then
		self._divine_empress_extreme_clg_negative_buff = content
	elseif name == "divine_empress_creeps" then
		self._divine_empress_creeps = content
	elseif name == "divine_empress_normal_clg_progress_prize" then
		self._divine_empress_normal_clg_progress_prize = content
	end
end

function DivineEmpressConfig:getActivityCfg(activityId)
	return self._divine_empress_activity[activityId]
end

function DivineEmpressConfig:getExtraStageCfg(activityId, stageId)
	if self._divine_empress_extreme_clg_stage[activityId] then
		return self._divine_empress_extreme_clg_stage[activityId][stageId]
	end
end

function DivineEmpressConfig:getExtraStageCfgs(activityId)
	return self._divine_empress_extreme_clg_stage[activityId]
end

function DivineEmpressConfig:getNormalStageCfg(activityId, groupId, stageId)
	if self._divine_empress_normal_clg_stage[activityId] and self._divine_empress_normal_clg_stage[activityId][groupId] then
		return self._divine_empress_normal_clg_stage[activityId][groupId][stageId]
	end
end

function DivineEmpressConfig:getTeamCfg(creepsMasterId)
	return self._divine_empress_clg_creeps_master[creepsMasterId]
end

function DivineEmpressConfig:getCreepsCfg(creepsMasterId)
	return self._divine_empress_creeps[creepsMasterId]
end

function DivineEmpressConfig:getBuffCfgs(activityId)
	return self._divine_empress_extreme_clg_positive_buff[activityId]
end

function DivineEmpressConfig:getBuffCfg(activityId, buffId)
	if self._divine_empress_extreme_clg_positive_buff[activityId] then
		return self._divine_empress_extreme_clg_positive_buff[activityId][buffId]
	end
end

function DivineEmpressConfig:getDebuffCfgs(activityId)
	return self._divine_empress_extreme_clg_negative_buff[activityId]
end

function DivineEmpressConfig:getDebuffCfg(activityId, buffId)
	if self._divine_empress_extreme_clg_negative_buff[activityId] then
		return self._divine_empress_extreme_clg_negative_buff[activityId][buffId]
	end
end

function DivineEmpressConfig:getScoreCfgs(activityId)
	return self._divine_empress_extreme_clg_score[activityId]
end

function DivineEmpressConfig:getNormalBuffCfgs(activityId)
	return self._divine_empress_normal_clg_buff[activityId]
end

function DivineEmpressConfig:getNormalBuffCfg(activityId, buffId)
	if self._divine_empress_normal_clg_buff[activityId] then
		return self._divine_empress_normal_clg_buff[activityId][buffId]
	end
end

function DivineEmpressConfig:getNormalPrizeCfgs(activityId)
	return self._divine_empress_normal_clg_progress_prize[activityId]
end

function DivineEmpressConfig:getNormalPrizeCfg(activityId, progressId)
	if self._divine_empress_normal_clg_progress_prize[activityId] then
		return self._divine_empress_normal_clg_progress_prize[activityId][progressId]
	end
end

function DivineEmpressConfig:getSupportPetCfgs(activityId)
	return self._divine_empress_normal_clg_support_pet[activityId]
end

function DivineEmpressConfig:getSupportPetCfg(activityId, creepsId)
	if self._divine_empress_normal_clg_support_pet[activityId] then
		return self._divine_empress_normal_clg_support_pet[activityId][creepsId]
	end
end

function DivineEmpressConfig:getNormalClgGroupCfgs(activityId)
	return self._divine_empress_normal_clg_stage[activityId]
end

function DivineEmpressConfig:getNormalClgsByGroupId(activityId, groupId)
	if self._divine_empress_normal_clg_stage[activityId] then
		return self._divine_empress_normal_clg_stage[activityId][groupId]
	end
end

function DivineEmpressConfig:getNormalClgByStageId(activityId, groupId, stageId)
	if self._divine_empress_normal_clg_stage[activityId] and self._divine_empress_normal_clg_stage[activityId][groupId] then
		return self._divine_empress_normal_clg_stage[activityId][groupId][stageId]
	end
end

DivineEmpressConfig.instance = DivineEmpressConfig.New()

return DivineEmpressConfig
