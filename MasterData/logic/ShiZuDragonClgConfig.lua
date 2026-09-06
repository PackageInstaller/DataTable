-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shizudragonclg/config/ShiZuDragonClgConfig.lua

module("logic.extensions.romanticgifts.config.ShiZuDragonClgConfig", package.seeall)

local ShiZuDragonClgConfig = class("ShiZuDragonClgConfig", BaseConfig)

function ShiZuDragonClgConfig:onInit()
	ShiZuDragonClgConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function ShiZuDragonClgConfig:getNames()
	return {
		"shi_zu_dragon_clg_stage",
		"shi_zu_dragon_clg_creeps_master",
		"shi_zu_dragon_clg_creeps",
		"shi_zu_dragon_clg_activity",
		"shi_zu_dragon_clg_buff",
		"shi_zu_dragon_clg_phase"
	}
end

function ShiZuDragonClgConfig:handleConfig(name, content)
	if name == "shi_zu_dragon_clg_stage" then
		self._shi_zu_dragon_clg_stage = content
	elseif name == "shi_zu_dragon_clg_creeps_master" then
		self._shi_zu_dragon_clg_creeps_master = content
	elseif name == "shi_zu_dragon_clg_creeps" then
		self._shi_zu_dragon_clg_creeps = content
	elseif name == "shi_zu_dragon_clg_activity" then
		self._shi_zu_dragon_clg_activity = content
	elseif name == "shi_zu_dragon_clg_buff" then
		self._shi_zu_dragon_clg_buff = content
	elseif name == "shi_zu_dragon_clg_phase" then
		self._shi_zu_dragon_clg_phase = content
	end
end

function ShiZuDragonClgConfig:getActivityCfg(activityId)
	return self._shi_zu_dragon_clg_activity[activityId]
end

function ShiZuDragonClgConfig:getPhaseCfgs(activityId)
	return self._shi_zu_dragon_clg_phase[activityId]
end

function ShiZuDragonClgConfig:getPhaseCfg(activityId, phaseId)
	return self._shi_zu_dragon_clg_phase[activityId][phaseId]
end

function ShiZuDragonClgConfig:getStageCfgs(activityId, phaseId)
	if self._shi_zu_dragon_clg_stage[activityId] then
		return self._shi_zu_dragon_clg_stage[activityId][phaseId]
	end
end

function ShiZuDragonClgConfig:getStageCfg(activityId, phaseId, stageId)
	if self._shi_zu_dragon_clg_stage[activityId] and self._shi_zu_dragon_clg_stage[activityId][phaseId] then
		return self._shi_zu_dragon_clg_stage[activityId][phaseId][stageId]
	end
end

function ShiZuDragonClgConfig:getTeamCfg(creepsMasterId)
	return self._shi_zu_dragon_clg_creeps_master[creepsMasterId]
end

function ShiZuDragonClgConfig:getCreepsCfg(creepsMasterId)
	return self._shi_zu_dragon_clg_creeps[creepsMasterId]
end

function ShiZuDragonClgConfig:getBuffCfg(activityId, phaseId, finishNum)
	if self._shi_zu_dragon_clg_buff[activityId] and self._shi_zu_dragon_clg_buff[activityId][phaseId] then
		return self._shi_zu_dragon_clg_buff[activityId][phaseId][finishNum]
	end
end

ShiZuDragonClgConfig.instance = ShiZuDragonClgConfig.New()

return ShiZuDragonClgConfig
