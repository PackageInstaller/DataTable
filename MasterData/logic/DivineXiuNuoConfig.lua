-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiunuo/config/DivineXiuNuoConfig.lua

module("logic.extensions.divinexiunuo.config.DivineXiuNuoConfig", package.seeall)

local DivineXiuNuoConfig = class("DivineXiuNuoConfig", BaseConfig)

function DivineXiuNuoConfig:getNames()
	return {
		"divine_xiu_nuo_clg",
		"divine_xiu_nuo_clg_phase",
		"divine_xiu_nuo_clg_stage",
		"divine_xiu_nuo_clg_support_pet",
		"divine_xiu_nuo_clg_creeps_master",
		"divine_xiu_nuo_clg_creeps"
	}
end

function DivineXiuNuoConfig:handleConfig(name, content)
	if name == "divine_xiu_nuo_clg" then
		self._divine_xiu_nuo_clg = content
	elseif name == "divine_xiu_nuo_clg_phase" then
		self._divine_xiu_nuo_clg_phase = content
	elseif name == "divine_xiu_nuo_clg_stage" then
		self._divine_xiu_nuo_clg_stage = content
	elseif name == "divine_xiu_nuo_clg_support_pet" then
		self._divine_xiu_nuo_clg_support_pet = content
	elseif name == "divine_xiu_nuo_clg_creeps_master" then
		self._divine_xiu_nuo_clg_creeps_master = content
	elseif name == "divine_xiu_nuo_clg_creeps" then
		self._divine_xiu_nuo_clg_creeps = content
	end
end

function DivineXiuNuoConfig:getActivityCfgById(id)
	return self._divine_xiu_nuo_clg[id]
end

function DivineXiuNuoConfig:getPhaseListById(activityId)
	return self._divine_xiu_nuo_clg_phase[activityId]
end

function DivineXiuNuoConfig:getPhaseCfgById(activityId, phaseId)
	if self._divine_xiu_nuo_clg_phase[activityId] then
		return self._divine_xiu_nuo_clg_phase[activityId][phaseId]
	end
end

function DivineXiuNuoConfig:getStageListById(activityId, phaseId)
	if self._divine_xiu_nuo_clg_stage[activityId] then
		return self._divine_xiu_nuo_clg_stage[activityId][phaseId]
	end
end

function DivineXiuNuoConfig:getStageCfgById(activityId, phaseId, stageId)
	if self._divine_xiu_nuo_clg_stage[activityId] and self._divine_xiu_nuo_clg_stage[activityId][phaseId] then
		return self._divine_xiu_nuo_clg_stage[activityId][phaseId][stageId]
	end
end

function DivineXiuNuoConfig:getCreepsById(creepsMasterId)
	return self._divine_xiu_nuo_clg_creeps[creepsMasterId]
end

function DivineXiuNuoConfig:getMonsterCfgById(creepsMasterId)
	return self._divine_xiu_nuo_clg_creeps_master[creepsMasterId]
end

function DivineXiuNuoConfig:getSupportCfgById(activityId, petId)
	if self._divine_xiu_nuo_clg_support_pet[activityId] then
		return self._divine_xiu_nuo_clg_support_pet[activityId][petId]
	end
end

DivineXiuNuoConfig.instance = DivineXiuNuoConfig.New()

return DivineXiuNuoConfig
