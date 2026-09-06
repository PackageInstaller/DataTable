-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wudiclg/config/WuDiClgConfig.lua

module("logic.extensions.wudiclg.config.WuDiClgConfig", package.seeall)

local WuDiClgConfig = class("WuDiClgConfig", BaseConfig)

function WuDiClgConfig:onInit()
	WuDiClgConfig.super.onInit(self)
end

function WuDiClgConfig:getNames()
	return {
		"wu_di_clg_activity",
		"wu_di_clg_activity_common",
		"wu_di_extreme_clg_stage",
		"wu_di_normal_clg_stage_group",
		"wu_di_normal_clg_rule",
		"wu_di_normal_clg_progress",
		"wu_di_clg_support_pet",
		"wu_di_clg_creeps_master",
		"wu_di_clg_creeps"
	}
end

function WuDiClgConfig:handleConfig(name, content)
	if name == "wu_di_clg_activity" then
		self._wdcActCfg = content
	elseif name == "wu_di_clg_activity_common" then
		self._wdcCommonCfg = content
	elseif name == "wu_di_extreme_clg_stage" then
		self._wdcExtStageCfgs = content
	elseif name == "wu_di_normal_clg_stage_group" then
		self._wdcNorStageGroupCfgss = content
	elseif name == "wu_di_normal_clg_rule" then
		self._wdcNorRuleCfgs = content
	elseif name == "wu_di_normal_clg_progress" then
		self._wdcNorProgressCfgs = content
	elseif name == "wu_di_clg_support_pet" then
		self._wdcSupportCfgs = content
	elseif name == "wu_di_clg_creeps_master" then
		self._wdcCreepsMasterCfg = content
	elseif name == "wu_di_clg_creeps" then
		self._wdcCreepsCfgs = content
	end
end

function WuDiClgConfig:getWdcActData(activityId)
	return self._wdcActCfg[activityId]
end

function WuDiClgConfig:getWdcCommonData(activityId)
	local actData = self:getWdcActData(activityId)

	if actData then
		return self._wdcCommonCfg[actData.comPlanId]
	end
end

function WuDiClgConfig:getWdcCommonValue(activityId, key)
	local data = self:getWdcCommonData(activityId)

	if data then
		return data[key]
	end
end

function WuDiClgConfig:getWdcExtStageCfg(activityId)
	return self._wdcExtStageCfgs[activityId]
end

function WuDiClgConfig:getWdcExtStageData(activityId, stageId)
	if self._wdcExtStageCfgs[activityId] then
		return self._wdcExtStageCfgs[activityId][stageId]
	end
end

function WuDiClgConfig:getWdcNorStageGroupCfgs(activityId)
	return self._wdcNorStageGroupCfgss[activityId]
end

function WuDiClgConfig:getWdcNorStageGroupCfg(activityId, groupId)
	if self._wdcNorStageGroupCfgss[activityId] then
		return self._wdcNorStageGroupCfgss[activityId][groupId]
	end
end

function WuDiClgConfig:getWdcNorStageGroupData(activityId, groupId, dataBitId)
	if self._wdcNorStageGroupCfgss[activityId] and self._wdcNorStageGroupCfgss[activityId][groupId] then
		return self._wdcNorStageGroupCfgss[activityId][groupId][dataBitId]
	end
end

function WuDiClgConfig:getWdcNorRuleCfg(activityId)
	return self._wdcNorRuleCfgs[activityId]
end

function WuDiClgConfig:getWdcNorRuleData(activityId, ruleId)
	if self._wdcNorRuleCfgs[activityId] then
		return self._wdcNorRuleCfgs[activityId][ruleId]
	end
end

function WuDiClgConfig:getWdcNorProgressCfg(activityId)
	return self._wdcNorProgressCfgs[activityId]
end

function WuDiClgConfig:getWdcNorProgressData(activityId, dataBitId)
	if self._wdcNorProgressCfgs[activityId] then
		return self._wdcNorProgressCfgs[activityId][dataBitId]
	end
end

function WuDiClgConfig:getWdcSupportCfg(activityId)
	return self._wdcSupportCfgs[activityId]
end

function WuDiClgConfig:getWdcSupportData(activityId, creepsId)
	if self._wdcSupportCfgs[activityId] then
		return self._wdcSupportCfgs[activityId][creepsId]
	end
end

function WuDiClgConfig:getWdcCreepsMasterData(creepsMasterId)
	return self._wdcCreepsMasterCfg[creepsMasterId]
end

function WuDiClgConfig:getWdcCreepsCfg(creepsMasterId)
	return self._wdcCreepsCfgs[creepsMasterId]
end

function WuDiClgConfig:getWdcCreepsData(creepsMasterId, creepsId)
	if self._wdcCreepsCfgs[creepsMasterId] then
		return self._wdcCreepsCfgs[creepsMasterId][creepsId]
	end
end

WuDiClgConfig.instance = WuDiClgConfig.New()

return WuDiClgConfig
