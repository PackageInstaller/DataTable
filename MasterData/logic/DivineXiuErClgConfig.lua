-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/config/DivineXiuErClgConfig.lua

module("logic.extensions.divinexiuerclg.config.DivineXiuErClgConfig", package.seeall)

local DivineXiuErClgConfig = class("DivineXiuErClgConfig", BaseConfig)

function DivineXiuErClgConfig:onInit()
	DivineXiuErClgConfig.super.onInit(self)
end

function DivineXiuErClgConfig:getNames()
	return {
		"divine_xiu_er_clg_activity",
		"divine_xiu_er_clg_common",
		"divine_xiu_er_normal_clg",
		"divine_xiu_er_normal_clg_stage_group",
		"divine_xiu_er_normal_clg_stage_type",
		"divine_xiu_er_extreme_clg_tier",
		"divine_xiu_er_extreme_clg_tier_parallel",
		"divine_xiu_er_extreme_clg_tier_truefalse",
		"divine_xiu_er_extreme_clg_stage",
		"divine_xiu_er_extreme_clg_stage_truefalse",
		"divine_xiu_er_extreme_clg_stage_truefalse_type",
		"divine_xiu_er_clg_creeps_master",
		"divine_xiu_er_clg_creeps"
	}
end

function DivineXiuErClgConfig:handleConfig(name, content)
	if name == "divine_xiu_er_clg_activity" then
		self._dxecActCfg = content
	elseif name == "divine_xiu_er_clg_common" then
		self._dxecCommonCfg = content
	elseif name == "divine_xiu_er_normal_clg" then
		self._dxecNorClgCfg = content
	elseif name == "divine_xiu_er_normal_clg_stage_group" then
		self._dxecNorStageGroupCfgss = content
	elseif name == "divine_xiu_er_normal_clg_stage_type" then
		self._dxecNorStageTypeCfgs = content
	elseif name == "divine_xiu_er_extreme_clg_tier" then
		self._dxecExtTierCfgs = content
	elseif name == "divine_xiu_er_extreme_clg_tier_parallel" then
		self._dxecExtTierParallelCfg = content
	elseif name == "divine_xiu_er_extreme_clg_tier_truefalse" then
		self._dxecExtTierTruefalseCfg = content
	elseif name == "divine_xiu_er_extreme_clg_stage" then
		self._dxecExtStageCfgss = content
	elseif name == "divine_xiu_er_extreme_clg_stage_truefalse" then
		self._dxecExtStageTruefalseCfg = content
	elseif name == "divine_xiu_er_extreme_clg_stage_truefalse_type" then
		self._dxecExtStageTruefalseTypeCfgs = content
	elseif name == "divine_xiu_er_clg_creeps_master" then
		self._dxecCreepsMasterCfg = content
	elseif name == "divine_xiu_er_clg_creeps" then
		self._dxecCreepsCfgs = content
	end
end

function DivineXiuErClgConfig:getDxecActData(activityId)
	return self._dxecActCfg[activityId]
end

function DivineXiuErClgConfig:getDxecCommonData(activityId)
	local actData = self:getDxecActData(activityId)

	if actData then
		return self._dxecCommonCfg[actData.comPlanId]
	end
end

function DivineXiuErClgConfig:getDxecCommonValue(activityId, key)
	local data = self:getDxecCommonData(activityId)

	if data then
		return data[key]
	end
end

function DivineXiuErClgConfig:getDxecNorClgData(activityId)
	return self._dxecNorClgCfg[activityId]
end

function DivineXiuErClgConfig:getDxecNorStageGroupCfgs(activityId)
	return self._dxecNorStageGroupCfgss[activityId]
end

function DivineXiuErClgConfig:getDxecNorStageGroupCfg(activityId, groupId)
	if self._dxecNorStageGroupCfgss[activityId] then
		return self._dxecNorStageGroupCfgss[activityId][groupId]
	end
end

function DivineXiuErClgConfig:getDxecNorStageGroupData(activityId, groupId, dataBitId)
	if self._dxecNorStageGroupCfgss[activityId] and self._dxecNorStageGroupCfgss[activityId][groupId] then
		return self._dxecNorStageGroupCfgss[activityId][groupId][dataBitId]
	end
end

function DivineXiuErClgConfig:getDxecNorStageTypeCfg(activityId)
	return self._dxecNorStageTypeCfgs[activityId]
end

function DivineXiuErClgConfig:getDxecNorStageTypeData(activityId, stageType)
	local result
	local cfg = self:getDxecNorStageTypeCfg(activityId)

	if cfg then
		for _, data in ipairs(cfg) do
			if data.stageType == stageType then
				result = data
			end
		end
	end

	return result
end

function DivineXiuErClgConfig:getDxecExtTierCfg(activityId)
	return self._dxecExtTierCfgs[activityId]
end

function DivineXiuErClgConfig:getDxecExtTierData(activityId, tierId)
	if self._dxecExtTierCfgs[activityId] then
		return self._dxecExtTierCfgs[activityId][tierId]
	end
end

function DivineXiuErClgConfig:getDxecExtTierParalleData(parallelId)
	return self._dxecExtTierParallelCfg[parallelId]
end

function DivineXiuErClgConfig:getDxecExtTierTruefalseData(tureFalseId)
	return self._dxecExtTierTruefalseCfg[tureFalseId]
end

function DivineXiuErClgConfig:getDxecExtStageCfgs(activityId)
	return self._dxecExtStageCfgss[activityId]
end

function DivineXiuErClgConfig:getDxecExtStageCfg(activityId, tierId)
	if self._dxecExtStageCfgss[activityId] then
		return self._dxecExtStageCfgss[activityId][tierId]
	end
end

function DivineXiuErClgConfig:getDxecExtStageData(activityId, tierId, dataBitId)
	if self._dxecExtStageCfgss[activityId] and self._dxecExtStageCfgss[activityId][tierId] then
		return self._dxecExtStageCfgss[activityId][tierId][dataBitId]
	end
end

function DivineXiuErClgConfig:getDxecExtStageTruefalseData(tureFalseStageId)
	return self._dxecExtStageTruefalseCfg[tureFalseStageId]
end

function DivineXiuErClgConfig:getDxecExtStageTruefalseTypeCfg(activityId)
	return self._dxecExtStageTruefalseTypeCfgs[activityId]
end

function DivineXiuErClgConfig:getDxecExtStageTruefalseTypeData(activityId, stageType)
	local result
	local cfg = self:getDxecExtStageTruefalseTypeCfg(activityId)

	if cfg then
		for _, data in ipairs(cfg) do
			if data.stageType == stageType then
				result = data
			end
		end
	end

	return result
end

function DivineXiuErClgConfig:getDxecCreepsMasterData(creepsMasterId)
	return self._dxecCreepsMasterCfg[creepsMasterId]
end

function DivineXiuErClgConfig:getDxecCreepsCfg(creepsMasterId)
	return self._dxecCreepsCfgs[creepsMasterId]
end

function DivineXiuErClgConfig:getDxecCreepsData(creepsMasterId, creepsId)
	if self._dxecCreepsCfgs[creepsMasterId] then
		return self._dxecCreepsCfgs[creepsMasterId][creepsId]
	end
end

DivineXiuErClgConfig.instance = DivineXiuErClgConfig.New()

return DivineXiuErClgConfig
