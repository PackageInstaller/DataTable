-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineaojiu/config/DivineAoJiuConfig.lua

module("logic.extensions.divineaojiu.config.DivineAoJiuConfig", package.seeall)

local DivineAoJiuConfig = class("DivineAoJiuConfig", BaseConfig)

function DivineAoJiuConfig:getNames()
	DivineAoJiuConfig.super.getNames(self)

	return {
		"divine_ao_jiu_clg",
		"divine_ao_jiu_clg_buff",
		"divine_ao_jiu_clg_buff_name",
		"divine_ao_jiu_clg_extreme_stage",
		"divine_ao_jiu_clg_creeps_master",
		"divine_ao_jiu_clg_creeps",
		"divine_ao_jiu_clg_system_pet",
		"divine_ao_jiu_clg_system_pet_pos",
		"divine_ao_jiu_clg_normal_stage",
		"divine_ao_jiu_clg_normal_stage_prize"
	}
end

function DivineAoJiuConfig:handleConfig(name, content)
	if name == "divine_ao_jiu_clg" then
		self._divine_ao_jiu_clg = content
	elseif name == "divine_ao_jiu_clg_buff" then
		self._divine_ao_jiu_clg_buff = content
	elseif name == "divine_ao_jiu_clg_buff_name" then
		self._divine_ao_jiu_clg_buff_name = content
	elseif name == "divine_ao_jiu_clg_extreme_stage" then
		self._divine_ao_jiu_clg_extreme_stage = content
	elseif name == "divine_ao_jiu_clg_creeps_master" then
		self._divine_ao_jiu_clg_creeps_master = content
	elseif name == "divine_ao_jiu_clg_creeps" then
		self._divine_ao_jiu_clg_creeps = content
	elseif name == "divine_ao_jiu_clg_system_pet" then
		self._divine_ao_jiu_clg_system_pet = content
	elseif name == "divine_ao_jiu_clg_system_pet_pos" then
		self._divine_ao_jiu_clg_system_pet_pos = content
	elseif name == "divine_ao_jiu_clg_normal_stage" then
		self._divine_ao_jiu_clg_normal_stage = content
	elseif name == "divine_ao_jiu_clg_normal_stage_prize" then
		self._divine_ao_jiu_clg_normal_stage_prize = content
	end
end

function DivineAoJiuConfig:getActivityCfg(activityId)
	return self._divine_ao_jiu_clg[activityId]
end

function DivineAoJiuConfig:getExtremeStageCfgs(activityId)
	return self._divine_ao_jiu_clg_extreme_stage[activityId]
end

function DivineAoJiuConfig:getExtremeStageCfg(activityId, stageId)
	if self._divine_ao_jiu_clg_extreme_stage[activityId] then
		return self._divine_ao_jiu_clg_extreme_stage[activityId][stageId]
	end
end

function DivineAoJiuConfig:getBuffCfg(activityId, buffId)
	if self._divine_ao_jiu_clg_buff[activityId] then
		return self._divine_ao_jiu_clg_buff[activityId][buffId]
	end
end

function DivineAoJiuConfig:getBuffName(activityId, buffType)
	if self._divine_ao_jiu_clg_buff_name[activityId] and self._divine_ao_jiu_clg_buff_name[activityId][buffType] then
		return self._divine_ao_jiu_clg_buff_name[activityId][buffType].name
	end
end

function DivineAoJiuConfig:getTeamCfg(creepsMasterId)
	return self._divine_ao_jiu_clg_creeps_master[creepsMasterId]
end

function DivineAoJiuConfig:getCreepsCfg(creepsMasterId)
	return self._divine_ao_jiu_clg_creeps[creepsMasterId]
end

function DivineAoJiuConfig:getSupportPetPosCfg(systemPetPosPlan)
	return self._divine_ao_jiu_clg_system_pet_pos[systemPetPosPlan]
end

function DivineAoJiuConfig:getSupportPetCfg(creepsId)
	return self._divine_ao_jiu_clg_system_pet[creepsId]
end

function DivineAoJiuConfig:getNormalStageCfgs(activityId)
	return self._divine_ao_jiu_clg_normal_stage[activityId]
end

function DivineAoJiuConfig:getNormalStageCfg(activityId, stageId)
	if self._divine_ao_jiu_clg_normal_stage[activityId] then
		return self._divine_ao_jiu_clg_normal_stage[activityId][stageId]
	end
end

function DivineAoJiuConfig:getNormalPrizeCfgs(activityId)
	return self._divine_ao_jiu_clg_normal_stage_prize[activityId]
end

DivineAoJiuConfig.instance = DivineAoJiuConfig.New()

return DivineAoJiuConfig
