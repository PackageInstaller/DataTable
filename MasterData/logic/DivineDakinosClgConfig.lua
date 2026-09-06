-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedakinosclg/config/DivineDakinosClgConfig.lua

module("logic.extensions.divinedakinosclg.config.DivineDakinosClgConfig", package.seeall)

local DivineDakinosClgConfig = class("DivineDakinosClgConfig", BaseConfig)

function DivineDakinosClgConfig:getNames()
	return {
		"divine_dakinos_clg_phase",
		"divine_dakinos_clg_creeps",
		"divine_dakinos_clg_monster",
		"divine_dakinos_clg_stage",
		"divine_dakinos_clg"
	}
end

function DivineDakinosClgConfig:handleConfig(name, content)
	if name == "divine_dakinos_clg_phase" then
		self._divine_dakinos_clg_phase = content
	elseif name == "divine_dakinos_clg_creeps" then
		self._divine_dakinos_clg_creeps = content
	elseif name == "divine_dakinos_clg_monster" then
		self._divine_dakinos_clg_monster = content
	elseif name == "divine_dakinos_clg_stage" then
		self._divine_dakinos_clg_stage = content
	elseif name == "divine_dakinos_clg" then
		self._divine_dakinos_clg = content
	end
end

function DivineDakinosClgConfig:getActCfg(activityId)
	return self._divine_dakinos_clg[activityId] or {}
end

function DivineDakinosClgConfig:getPhaseCfg(activityId, phaseId)
	if not self._divine_dakinos_clg_phase[activityId] then
		return self._divine_dakinos_clg_phase[activityId][phaseId]
	end
end

function DivineDakinosClgConfig:getStageCfgs(stagePlanId)
	return self._divine_dakinos_clg_stage[stagePlanId] or {}
end

function DivineDakinosClgConfig:getStageCfg(activityId, phaseId, stageId)
	local phaseCfg = self:getPhaseCfg(activityId, phaseId) or {}
	local stageCfgs = self:getStageCfgs(phaseCfg.stagePlanId)

	return stageCfgs[stageId]
end

function DivineDakinosClgConfig:getFormationCfg(creepsMasterId)
	return self._divine_dakinos_clg_monster[creepsMasterId] or {}
end

function DivineDakinosClgConfig:getCreepCfgs(creepsMasterId)
	return self._divine_dakinos_clg_creeps[creepsMasterId] or {}
end

DivineDakinosClgConfig.instance = DivineDakinosClgConfig.New()

return DivineDakinosClgConfig
