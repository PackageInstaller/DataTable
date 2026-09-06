-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origintsdragonclg/config/OriginTSDragonClgConfig.lua

module("logic.extensions.origintsdragonclg.config.OriginTSDragonClgConfig", package.seeall)

local OriginTSDragonClgConfig = class("OriginTSDragonClgConfig", BaseConfig)

function OriginTSDragonClgConfig:onInit()
	OriginTSDragonClgConfig.super.onInit(self)
end

function OriginTSDragonClgConfig:getNames()
	return {
		"origin_ts_dragon_clg_activity",
		"origin_ts_dragon_clg_phase",
		"origin_ts_dragon_clg_stage",
		"origin_ts_dragon_clg_puzzle",
		"origin_ts_dragon_clg_monster",
		"origin_ts_dragon_clg_creeps"
	}
end

function OriginTSDragonClgConfig:handleConfig(name, content)
	if name == "origin_ts_dragon_clg_activity" then
		self._origin_ts_dragon_clg_activity = content
	elseif name == "origin_ts_dragon_clg_phase" then
		self._origin_ts_dragon_clg_phase = content
	elseif name == "origin_ts_dragon_clg_stage" then
		self._origin_ts_dragon_clg_stage = content
	elseif name == "origin_ts_dragon_clg_puzzle" then
		self._origin_ts_dragon_clg_puzzle = content
	elseif name == "origin_ts_dragon_clg_monster" then
		self._origin_ts_dragon_clg_monster = content
	elseif name == "origin_ts_dragon_clg_creeps" then
		self._origin_ts_dragon_clg_creeps = content
	end
end

function OriginTSDragonClgConfig:getActCfg(activityId)
	return self._origin_ts_dragon_clg_activity[activityId]
end

function OriginTSDragonClgConfig:getPhaseCfgs(activityId)
	return self._origin_ts_dragon_clg_phase[activityId]
end

function OriginTSDragonClgConfig:getPhaseCfgById(activityId, phaseId)
	return self._origin_ts_dragon_clg_phase[activityId] and self._origin_ts_dragon_clg_phase[activityId][phaseId]
end

function OriginTSDragonClgConfig:getPuzzleLimit(activityId, phaseId)
	local phaseCfg = self:getPhaseCfgById(activityId, phaseId)

	return phaseCfg and phaseCfg.puzzleLimit
end

function OriginTSDragonClgConfig:getStageCfgs(activityId, phaseId)
	local stageCfgs = self._origin_ts_dragon_clg_stage[activityId]

	if phaseId ~= nil then
		return stageCfgs and stageCfgs[phaseId]
	end

	return stageCfgs
end

function OriginTSDragonClgConfig:getStageCfgsByPhaseId(activityId, phaseId)
	return self:getStageCfgs(activityId, phaseId)
end

function OriginTSDragonClgConfig:getStageCfg(activityId, phaseId, stageId)
	local stageCfgs = self:getStageCfgs(activityId, phaseId)

	return stageCfgs and stageCfgs[stageId]
end

function OriginTSDragonClgConfig:getPuzzleCfgs(activityId, phaseId)
	local puzzleCfgs = self._origin_ts_dragon_clg_puzzle[activityId]

	if phaseId ~= nil then
		return puzzleCfgs and puzzleCfgs[phaseId]
	end

	return puzzleCfgs
end

function OriginTSDragonClgConfig:getPuzzleCfgsByPhaseId(activityId, phaseId)
	return self:getPuzzleCfgs(activityId, phaseId)
end

function OriginTSDragonClgConfig:getPuzzleCfg(activityId, phaseId, puzzleId)
	local puzzleCfgs = self:getPuzzleCfgs(activityId, phaseId)

	return puzzleCfgs and puzzleCfgs[puzzleId]
end

function OriginTSDragonClgConfig:getMasterCfg(creepsMasterId)
	return self._origin_ts_dragon_clg_monster[creepsMasterId]
end

function OriginTSDragonClgConfig:getCreepCfg(creepsMasterId)
	return self._origin_ts_dragon_clg_creeps[creepsMasterId]
end

function OriginTSDragonClgConfig:getCreepMasterId(activityId, phaseId, stageId)
	local stageCfg = self:getStageCfg(activityId, phaseId, stageId)

	if stageCfg then
		return stageCfg.creepsMasterId
	end
end

OriginTSDragonClgConfig.instance = OriginTSDragonClgConfig.New()

return OriginTSDragonClgConfig
