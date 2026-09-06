-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpsychicclg/config/DragonPsychicClgConfig.lua

module("logic.extensions.dragonpsychicclg.config.DragonPsychicClgConfig", package.seeall)

local DragonPsychicClgConfig = class("DragonPsychicClgConfig", BaseConfig)

function DragonPsychicClgConfig:onInit()
	DragonPsychicClgConfig.super.onInit(self)
end

function DragonPsychicClgConfig:getNames()
	return {
		"dragon_psychic_clg",
		"dragon_psychic_clg_common",
		"dragon_psychic_clg_system_pet",
		"dragon_psychic_clg_universal_stage",
		"dragon_psychic_clg_master",
		"dragon_psychic_clg_creeps",
		"dragon_psychic_clg_extreme_stage_total",
		"dragon_psychic_clg_extreme_stage"
	}
end

function DragonPsychicClgConfig:handleConfig(name, content)
	if name == "dragon_psychic_clg" then
		self._dragon_psychic_clg = content
	elseif name == "dragon_psychic_clg_common" then
		self._dragon_psychic_clg_common = content
	elseif name == "dragon_psychic_clg_system_pet" then
		self._dragon_psychic_clg_system_pet = content
	elseif name == "dragon_psychic_clg_universal_stage" then
		self._dragon_psychic_clg_universal_stage = content
	elseif name == "dragon_psychic_clg_master" then
		self._dragon_psychic_clg_master = content
	elseif name == "dragon_psychic_clg_creeps" then
		self._dragon_psychic_clg_creeps = content
	elseif name == "dragon_psychic_clg_extreme_stage_total" then
		self._dragon_psychic_clg_extreme_stage_total = content
	elseif name == "dragon_psychic_clg_extreme_stage" then
		self._dragon_psychic_clg_extreme_stage = content
	end
end

function DragonPsychicClgConfig:getDpcData(activityId)
	return self._dragon_psychic_clg[activityId]
end

function DragonPsychicClgConfig:getCommonValue(activityId, key)
	local data = self:getDpcData(activityId)

	if data then
		if not data.comPlanId then
			local comPlanId = 0
			local comData = self._dragon_psychic_clg_common[comPlanId]

			if comData then
				return comData[key]
			end
		end
	end
end

function DragonPsychicClgConfig:getDpcSystemPetCfg(activityId)
	return self._dragon_psychic_clg_system_pet[activityId]
end

function DragonPsychicClgConfig:getDpcSystemPetData(activityId, creepsId)
	if self._dragon_psychic_clg_system_pet[activityId] then
		return self._dragon_psychic_clg_system_pet[activityId][creepsId]
	end
end

function DragonPsychicClgConfig:getDpcUniversalStageCfg(activityId)
	return self._dragon_psychic_clg_universal_stage[activityId]
end

function DragonPsychicClgConfig:getDpcUniversalStageData(activityId, stageId)
	if self._dragon_psychic_clg_universal_stage[activityId] then
		return self._dragon_psychic_clg_universal_stage[activityId][stageId]
	end
end

function DragonPsychicClgConfig:getDpcMasterData(creepsMasterId)
	return self._dragon_psychic_clg_master[creepsMasterId]
end

function DragonPsychicClgConfig:getDpcCreepsCfg(creepsMasterId)
	return self._dragon_psychic_clg_creeps[creepsMasterId]
end

function DragonPsychicClgConfig:getDpcCreepsData(creepsMasterId, creepsId)
	if self._dragon_psychic_clg_creeps[creepsMasterId] then
		return self._dragon_psychic_clg_creeps[creepsMasterId][creepsId]
	end
end

function DragonPsychicClgConfig:getDpcExtremeStageTotalCfg(activityId)
	return self._dragon_psychic_clg_extreme_stage_total[activityId]
end

function DragonPsychicClgConfig:getDpcExtremeStageTotalData(activityId, stageId)
	if self._dragon_psychic_clg_extreme_stage_total[activityId] then
		return self._dragon_psychic_clg_extreme_stage_total[activityId][stageId]
	end
end

function DragonPsychicClgConfig:getDpcExtremeStageCfgs(activityId)
	return self._dragon_psychic_clg_extreme_stage[activityId]
end

function DragonPsychicClgConfig:getDpcExtremeStageCfg(activityId, stageId)
	if self._dragon_psychic_clg_extreme_stage[activityId] then
		return self._dragon_psychic_clg_extreme_stage[activityId][stageId]
	end
end

function DragonPsychicClgConfig:getDpcExtremeStageData(activityId, stageId, teamId)
	local cfg = self:getDpcExtremeStageCfg(activityId, stageId)

	if cfg then
		return cfg[teamId]
	end
end

DragonPsychicClgConfig.instance = DragonPsychicClgConfig.New()

return DragonPsychicClgConfig
