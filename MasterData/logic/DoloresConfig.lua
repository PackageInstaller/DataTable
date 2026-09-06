-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doloresclg/config/DoloresConfig.lua

module("logic.extensions.doloresclg.config.DoloresConfig", package.seeall)

local DoloresConfig = class("DoloresConfig", BaseConfig)

function DoloresConfig:getNames()
	return {
		"dolores_clg_activity",
		"dolores_clg_stage",
		"dolores_clg_creeps",
		"dolores_clg_monster",
		"dolores_clg_phase"
	}
end

function DoloresConfig:handleConfig(name, content)
	if name == "dolores_clg_activity" then
		self._dolores_clg_activity = content
	elseif name == "dolores_clg_stage" then
		self._dolores_clg_stage = content
	elseif name == "dolores_clg_creeps" then
		self._dolores_clg_creeps = content
	elseif name == "dolores_clg_monster" then
		self._dolores_clg_monster = content
	elseif name == "dolores_clg_phase" then
		self._dolores_clg_phase = content
	end
end

function DoloresConfig:getActCfg(activityId)
	return self._dolores_clg_activity[activityId]
end

function DoloresConfig:getStageListById(stagePlanId)
	return self._dolores_clg_stage[stagePlanId]
end

function DoloresConfig:getStageById(stagePlanId, stageId)
	if self._dolores_clg_stage[stagePlanId] then
		return self._dolores_clg_stage[stagePlanId][stageId]
	end
end

function DoloresConfig:getPhaseListById(activityId)
	return self._dolores_clg_phase[activityId]
end

function DoloresConfig:getPhaseById(activityId, phaseId)
	if self._dolores_clg_phase[activityId] then
		return self._dolores_clg_phase[activityId][phaseId]
	end
end

function DoloresConfig:getCreepsCfgs(id)
	return self._dolores_clg_creeps[id]
end

function DoloresConfig:getMonsterCfgById(id)
	return self._dolores_clg_monster[id]
end

DoloresConfig.instance = DoloresConfig.New()

return DoloresConfig
