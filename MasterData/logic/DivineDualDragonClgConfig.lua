-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedualdragonclg/config/DivineDualDragonClgConfig.lua

module("logic.extensions.divinedualdragonclg.config.DivineDualDragonClgConfig", package.seeall)

local DivineDualDragonClgConfig = class("DivineDualDragonClgConfig", BaseConfig)

function DivineDualDragonClgConfig:getNames()
	return {
		"divine_dual_dragon_clg_activity",
		"divine_dual_dragon_clg_phase",
		"divine_dual_dragon_clg_stage",
		"divine_dual_dragon_clg_monster",
		"divine_dual_dragon_clg_creeps"
	}
end

function DivineDualDragonClgConfig:handleConfig(name, content)
	if name == "divine_dual_dragon_clg_activity" then
		self._divine_dual_dragon_clg_activity = content
	elseif name == "divine_dual_dragon_clg_phase" then
		self._divine_dual_dragon_clg_phase = content
	elseif name == "divine_dual_dragon_clg_stage" then
		self._divine_dual_dragon_clg_stage = content
	elseif name == "divine_dual_dragon_clg_monster" then
		self._divine_dual_dragon_clg_monster = content
	elseif name == "divine_dual_dragon_clg_creeps" then
		self._divine_dual_dragon_clg_creeps = content
	end
end

function DivineDualDragonClgConfig:getActivityCfg(activityId)
	return self._divine_dual_dragon_clg_activity[activityId]
end

function DivineDualDragonClgConfig:getPhaseCfgs(phasePlanId)
	return self._divine_dual_dragon_clg_phase[phasePlanId]
end

function DivineDualDragonClgConfig:getPhaseCfg(phasePlanId, phaseId)
	if self._divine_dual_dragon_clg_phase[phasePlanId] then
		return self._divine_dual_dragon_clg_phase[phasePlanId][phaseId]
	end
end

function DivineDualDragonClgConfig:getStagesByStagePlanId(stagePlanId)
	return self._divine_dual_dragon_clg_stage[stagePlanId]
end

function DivineDualDragonClgConfig:getStageCfg(stagePlanId, stageId)
	if self._divine_dual_dragon_clg_stage[stagePlanId] then
		return self._divine_dual_dragon_clg_stage[stagePlanId][stageId]
	end
end

function DivineDualDragonClgConfig:getTeamCfg(creepsMasterId)
	return self._divine_dual_dragon_clg_monster[creepsMasterId]
end

function DivineDualDragonClgConfig:getCreepsCfg(creepsMasterId)
	return self._divine_dual_dragon_clg_creeps[creepsMasterId]
end

DivineDualDragonClgConfig.instance = DivineDualDragonClgConfig.New()

return DivineDualDragonClgConfig
