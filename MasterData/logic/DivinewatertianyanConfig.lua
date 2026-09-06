-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinewatertianyan/config/DivinewatertianyanConfig.lua

module("logic.extensions.divinewatertianyan.config.DivinewatertianyanConfig", package.seeall)

local DivinewatertianyanConfig = class("DivinewatertianyanConfig", BaseConfig)

function DivinewatertianyanConfig:onInit()
	return
end

function DivinewatertianyanConfig:getNames()
	return {
		"divine_water_tian_yan_clg_activity",
		"divine_water_tian_yan_clg_creeps",
		"divine_water_tian_yan_clg_creeps_master",
		"divine_water_tian_yan_clg_stage",
		"divine_water_tian_yan_clg_buff",
		"divine_water_tian_yan_clg_tab"
	}
end

function DivinewatertianyanConfig:handleConfig(name, content)
	if name == "divine_water_tian_yan_clg_activity" then
		self._divine_water_tian_yan_clg_activity = content
	elseif name == "divine_water_tian_yan_clg_creeps" then
		self._divine_water_tian_yan_clg_creeps = content
	elseif name == "divine_water_tian_yan_clg_creeps_master" then
		self._divine_water_tian_yan_clg_creeps_master = content
	elseif name == "divine_water_tian_yan_clg_stage" then
		self._divine_water_tian_yan_clg_stage = content
	elseif name == "divine_water_tian_yan_clg_buff" then
		self._divine_water_tian_yan_clg_buff = content
	elseif name == "divine_water_tian_yan_clg_tab" then
		self._divine_water_tian_yan_clg_tab = content
	end
end

function DivinewatertianyanConfig:getActCfg(activityId)
	return self._divine_water_tian_yan_clg_activity[activityId]
end

function DivinewatertianyanConfig:getBuffCfgs(activityId)
	return self._divine_water_tian_yan_clg_buff[activityId]
end

function DivinewatertianyanConfig:getBuffCfg(activityId, buffId)
	return self._divine_water_tian_yan_clg_buff[activityId][buffId]
end

function DivinewatertianyanConfig:getStageCfgs(activityId)
	return self._divine_water_tian_yan_clg_stage[activityId]
end

function DivinewatertianyanConfig:getStageCfg(activityId, stageId)
	return self._divine_water_tian_yan_clg_stage[activityId][stageId]
end

function DivinewatertianyanConfig:getTabCfgs(activityId)
	return self._divine_water_tian_yan_clg_tab[activityId]
end

function DivinewatertianyanConfig:getTabCfg(activityId, stageType)
	return self._divine_water_tian_yan_clg_tab[activityId][stageType]
end

function DivinewatertianyanConfig:getSkinId(activityId)
	return self._divine_water_tian_yan_clg_activity[activityId].skinId
end

function DivinewatertianyanConfig:getCreepsCfgs(creepsMasterId)
	return self._divine_water_tian_yan_clg_creeps[creepsMasterId]
end

function DivinewatertianyanConfig:getCreepsMasterCfg(creepsMasterId)
	return self._divine_water_tian_yan_clg_creeps_master[creepsMasterId]
end

DivinewatertianyanConfig.instance = DivinewatertianyanConfig.New()

return DivinewatertianyanConfig
