-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineisaacclg/config/DivineisaacclgConfig.lua

module("logic.extensions.divineisaacclg.config.DivineisaacclgConfig", package.seeall)

local DivineisaacclgConfig = class("DivineisaacclgConfig", BaseConfig)

function DivineisaacclgConfig:onInit()
	return
end

function DivineisaacclgConfig:getNames()
	return {
		"divine_isaac_clg_activity",
		"divine_isaac_clg_phase",
		"divine_isaac_clg_creeps",
		"divine_isaac_clg_creeps_master",
		"divine_isaac_clg_puppet",
		"divine_isaac_clg_puppet_num",
		"divine_isaac_clg_stage",
		"divine_isaac_clg_metal",
		"divine_isaac_clg_puppet_client",
		"divine_isaac_clg_buff_attr"
	}
end

function DivineisaacclgConfig:handleConfig(name, content)
	if name == "divine_isaac_clg_activity" then
		self._divine_isaac_clg_activity = content
	elseif name == "divine_isaac_clg_phase" then
		self._divine_isaac_clg_phase = content
	elseif name == "divine_isaac_clg_creeps" then
		self._divine_isaac_clg_creeps = content
	elseif name == "divine_isaac_clg_creeps_master" then
		self._divine_isaac_clg_creeps_master = content
	elseif name == "divine_isaac_clg_puppet" then
		self._divine_isaac_clg_puppet = content
	elseif name == "divine_isaac_clg_puppet_num" then
		self._divine_isaac_clg_puppet_num = content
	elseif name == "divine_isaac_clg_stage" then
		self._divine_isaac_clg_stage = content
	elseif name == "divine_isaac_clg_metal" then
		self._divine_isaac_clg_metal = content
	elseif name == "divine_isaac_clg_puppet_client" then
		self._divine_isaac_clg_puppet_client = content
	elseif name == "divine_isaac_clg_buff_attr" then
		self._divine_isaac_clg_buff_attr = content
	end
end

function DivineisaacclgConfig:getActCfg(activityId)
	return self._divine_isaac_clg_activity[activityId]
end

function DivineisaacclgConfig:getSkinId(activityId)
	return self._divine_isaac_clg_activity[activityId].skinId
end

function DivineisaacclgConfig:getStageCfgs(activityId)
	return self._divine_isaac_clg_stage[activityId]
end

function DivineisaacclgConfig:getStageCfg(activityId, phaseId, stageId)
	return self._divine_isaac_clg_stage[activityId][phaseId][stageId]
end

function DivineisaacclgConfig:getPhaseCfgs(activityId)
	return self._divine_isaac_clg_phase[activityId]
end

function DivineisaacclgConfig:getPhaseCfg(activityId, phase)
	return self._divine_isaac_clg_phase[activityId][phase]
end

function DivineisaacclgConfig:getMasterCfg(creepsMasterId)
	return self._divine_isaac_clg_creeps_master[creepsMasterId]
end

function DivineisaacclgConfig:getCreepsCfgs(creepsMasterId)
	return self._divine_isaac_clg_creeps[creepsMasterId]
end

function DivineisaacclgConfig:getPuppetNumCfgs(activityId, phaseId)
	return self._divine_isaac_clg_puppet_num[activityId][phaseId]
end

function DivineisaacclgConfig:getPuppetCfgs(activityId, phaseId)
	return self._divine_isaac_clg_puppet[activityId][phaseId]
end

function DivineisaacclgConfig:getMetalResCfgs()
	return self._divine_isaac_clg_metal
end

function DivineisaacclgConfig:getMetalResCfg(metalId)
	return self._divine_isaac_clg_metal[metalId]
end

function DivineisaacclgConfig:getClientPuppetCfg(puppetId)
	return self._divine_isaac_clg_puppet_client[puppetId]
end

function DivineisaacclgConfig:buff2AttrCfg(buffId)
	return self._divine_isaac_clg_buff_attr[buffId]
end

DivineisaacclgConfig.instance = DivineisaacclgConfig.New()

return DivineisaacclgConfig
