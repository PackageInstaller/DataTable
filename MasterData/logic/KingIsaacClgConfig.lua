-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingisaacclg/config/KingIsaacClgConfig.lua

module("logic.extensions.kingisaacclg.config.KingIsaacClgConfig", package.seeall)

local KingIsaacClgConfig = class("KingIsaacClgConfig", BaseConfig)

function KingIsaacClgConfig:onInit()
	KingIsaacClgConfig.super.onInit(self)
end

function KingIsaacClgConfig:getNames()
	return {
		"king_isaac_clg_activity",
		"king_isaac_clg_common",
		"king_isaac_clg_stage",
		"king_isaac_clg_mirror_template",
		"king_isaac_clg_team",
		"king_isaac_clg_creeps"
	}
end

function KingIsaacClgConfig:handleConfig(name, content)
	if name == "king_isaac_clg_activity" then
		self._king_isaac_clg_activity = content
	elseif name == "king_isaac_clg_common" then
		self._king_isaac_clg_common = content
	elseif name == "king_isaac_clg_stage" then
		self._king_isaac_clg_stage = content
	elseif name == "king_isaac_clg_mirror_template" then
		self._king_isaac_clg_mirror_template = content
	elseif name == "king_isaac_clg_team" then
		self._king_isaac_clg_team = content
	elseif name == "king_isaac_clg_creeps" then
		self._king_isaac_clg_creeps = content
	end
end

function KingIsaacClgConfig:getKicActData(activityId)
	return self._king_isaac_clg_activity[activityId]
end

function KingIsaacClgConfig:getKicCommonValue(activityId, key)
	local actData = self:getKicActData(activityId)

	if actData then
		if not actData.comPlanId then
			local comPlanId = 0
			local comData = self._king_isaac_clg_common[comPlanId]

			if comData then
				return comData[key]
			end
		end
	end
end

function KingIsaacClgConfig:getKicStageCfg(activityId)
	return self._king_isaac_clg_stage[activityId]
end

function KingIsaacClgConfig:getKicStageData(activityId, stageId)
	if self._king_isaac_clg_stage[activityId] then
		return self._king_isaac_clg_stage[activityId][stageId]
	end
end

function KingIsaacClgConfig:getKicMirrorTemplateCfg(templateId)
	return self._king_isaac_clg_mirror_template[templateId]
end

function KingIsaacClgConfig:getKicMirrorTemplateData(templateId, posId)
	if self._king_isaac_clg_mirror_template[templateId] then
		return self._king_isaac_clg_mirror_template[templateId][posId]
	end
end

function KingIsaacClgConfig:getKicCreepsMasterData(creepsMasterId)
	return self._king_isaac_clg_team[creepsMasterId]
end

function KingIsaacClgConfig:getKicCreepsCfg(creepsMasterId)
	return self._king_isaac_clg_creeps[creepsMasterId]
end

function KingIsaacClgConfig:getKicCreepsData(creepsMasterId, creepsId)
	if self._king_isaac_clg_creeps[creepsMasterId] then
		return self._king_isaac_clg_creeps[creepsMasterId][creepsId]
	end
end

function KingIsaacClgConfig:getDxecActData(activityId)
	return self._dxecActCfg[activityId]
end

function KingIsaacClgConfig:getDxecCommonData(activityId)
	local actData = self:getDxecActData(activityId)

	if actData then
		return self._dxecCommonCfg[actData.comPlanId]
	end
end

function KingIsaacClgConfig:getDxecCommonValue(activityId, key)
	local data = self:getDxecCommonData(activityId)

	if data then
		return data[key]
	end
end

function KingIsaacClgConfig:getDxecNorClgData(activityId)
	return self._dxecNorClgCfg[activityId]
end

function KingIsaacClgConfig:getDxecNorStageGroupCfgs(activityId)
	return self._dxecNorStageGroupCfgss[activityId]
end

function KingIsaacClgConfig:getDxecNorStageGroupCfg(activityId, groupId)
	if self._dxecNorStageGroupCfgss[activityId] then
		return self._dxecNorStageGroupCfgss[activityId][groupId]
	end
end

function KingIsaacClgConfig:getDxecNorStageGroupData(activityId, groupId, dataBitId)
	if self._dxecNorStageGroupCfgss[activityId] and self._dxecNorStageGroupCfgss[activityId][groupId] then
		return self._dxecNorStageGroupCfgss[activityId][groupId][dataBitId]
	end
end

function KingIsaacClgConfig:getDxecNorStageTypeCfg(activityId)
	return self._dxecNorStageTypeCfgs[activityId]
end

function KingIsaacClgConfig:getDxecNorStageTypeData(activityId, stageType)
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

function KingIsaacClgConfig:getDxecExtTierCfg(activityId)
	return self._dxecExtTierCfgs[activityId]
end

function KingIsaacClgConfig:getDxecExtTierData(activityId, tierId)
	if self._dxecExtTierCfgs[activityId] then
		return self._dxecExtTierCfgs[activityId][tierId]
	end
end

function KingIsaacClgConfig:getDxecExtTierParalleData(parallelId)
	return self._dxecExtTierParallelCfg[parallelId]
end

function KingIsaacClgConfig:getDxecExtTierTruefalseData(tureFalseId)
	return self._dxecExtTierTruefalseCfg[tureFalseId]
end

function KingIsaacClgConfig:getDxecExtStageCfgs(activityId)
	return self._dxecExtStageCfgss[activityId]
end

function KingIsaacClgConfig:getDxecExtStageCfg(activityId, tierId)
	if self._dxecExtStageCfgss[activityId] then
		return self._dxecExtStageCfgss[activityId][tierId]
	end
end

function KingIsaacClgConfig:getDxecExtStageData(activityId, tierId, dataBitId)
	if self._dxecExtStageCfgss[activityId] and self._dxecExtStageCfgss[activityId][tierId] then
		return self._dxecExtStageCfgss[activityId][tierId][dataBitId]
	end
end

function KingIsaacClgConfig:getDxecExtStageTruefalseData(tureFalseStageId)
	return self._dxecExtStageTruefalseCfg[tureFalseStageId]
end

function KingIsaacClgConfig:getDxecExtStageTruefalseTypeCfg(activityId)
	return self._dxecExtStageTruefalseTypeCfgs[activityId]
end

function KingIsaacClgConfig:getDxecExtStageTruefalseTypeData(activityId, stageType)
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

function KingIsaacClgConfig:getDxecCreepsMasterData(creepsMasterId)
	return self._dxecCreepsMasterCfg[creepsMasterId]
end

function KingIsaacClgConfig:getDxecCreepsCfg(creepsMasterId)
	return self._dxecCreepsCfgs[creepsMasterId]
end

function KingIsaacClgConfig:getDxecCreepsData(creepsMasterId, creepsId)
	if self._dxecCreepsCfgs[creepsMasterId] then
		return self._dxecCreepsCfgs[creepsMasterId][creepsId]
	end
end

KingIsaacClgConfig.instance = KingIsaacClgConfig.New()

return KingIsaacClgConfig
