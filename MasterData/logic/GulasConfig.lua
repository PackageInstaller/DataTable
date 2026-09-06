-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gulas/config/GulasConfig.lua

module("logic.extensions.gulas.config.GulasConfig", package.seeall)

local GulasConfig = class("GulasConfig", BaseConfig)

function GulasConfig:getNames()
	return {
		"gulas_clg_activity",
		"gulas_clg_buff",
		"gulas_clg_creeps",
		"gulas_clg_monster",
		"gulas_clg_phase",
		"gulas_clg_stage"
	}
end

function GulasConfig:handleConfig(name, content)
	if name == "gulas_clg_activity" then
		self._gulas_clg_activity = content
	elseif name == "gulas_clg_buff" then
		self._gulas_clg_buff = content
	elseif name == "gulas_clg_creeps" then
		self._gulas_clg_creeps = content
	elseif name == "gulas_clg_monster" then
		self._gulas_clg_monster = content
	elseif name == "gulas_clg_phase" then
		self._gulas_clg_phase = content
	elseif name == "gulas_clg_stage" then
		self._gulas_clg_stage = content
	end
end

function GulasConfig:getActivityCfgById(id)
	return self._gulas_clg_activity[id]
end

function GulasConfig:getPhaseCfgListById(activityId)
	return self._gulas_clg_phase[activityId]
end

function GulasConfig:getPhaseCfgById(activityId, phaseId)
	if self._gulas_clg_phase[activityId] then
		return self._gulas_clg_phase[activityId][phaseId]
	end
end

function GulasConfig:getStageCfgListById(stagePlanId)
	return self._gulas_clg_stage[stagePlanId]
end

function GulasConfig:getStageCfgById(stagePlanId, stageId)
	if self._gulas_clg_stage[stagePlanId] then
		return self._gulas_clg_stage[stagePlanId][stageId]
	end
end

function GulasConfig:getMonsterCfgById(id)
	return self._gulas_clg_monster[id]
end

function GulasConfig:getCreepsById(id)
	return self._gulas_clg_creeps[id]
end

GulasConfig.instance = GulasConfig.New()

return GulasConfig
