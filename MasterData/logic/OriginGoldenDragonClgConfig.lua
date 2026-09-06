-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoldendragonclg/config/OriginGoldenDragonClgConfig.lua

module("logic.extensions.origingoldendragonclg.config.OriginGoldenDragonClgConfig", package.seeall)

local OriginGoldenDragonClgConfig = class("OriginGoldenDragonClgConfig", BaseConfig)

function OriginGoldenDragonClgConfig:onInit()
	OriginGoldenDragonClgConfig.super.onInit(self)
end

function OriginGoldenDragonClgConfig:getNames()
	return {
		"origin_golden_dragon_clg_activity",
		"origin_golden_dragon_clg_creeps_master",
		"origin_golden_dragon_clg_prize",
		"origin_golden_dragon_clg_prophecy",
		"origin_golden_dragon_clg_stage",
		"origin_golden_dragon_clg_score_rate",
		"origin_golden_dragon_clg_creeps"
	}
end

function OriginGoldenDragonClgConfig:handleConfig(name, content)
	if name == "origin_golden_dragon_clg_activity" then
		self._origin_golden_dragon_clg_activity = content
	elseif name == "origin_golden_dragon_clg_creeps_master" then
		self._origin_golden_dragon_clg_creeps_master = content
	elseif name == "origin_golden_dragon_clg_prize" then
		self._origin_golden_dragon_clg_prize = content
	elseif name == "origin_golden_dragon_clg_prophecy" then
		self._origin_golden_dragon_clg_prophecy = content
	elseif name == "origin_golden_dragon_clg_stage" then
		self._origin_golden_dragon_clg_stage = content
	elseif name == "origin_golden_dragon_clg_score_rate" then
		self._origin_golden_dragon_clg_score_rate = content
	elseif name == "origin_golden_dragon_clg_creeps" then
		self._origin_golden_dragon_clg_creeps = content
	end
end

function OriginGoldenDragonClgConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

function OriginGoldenDragonClgConfig:getActCfgByActId(activityId)
	return self:_safeGet(self._origin_golden_dragon_clg_activity, activityId)
end

function OriginGoldenDragonClgConfig:getCreepCfgs(creepsMasterId)
	return self:_safeGet(self._origin_golden_dragon_clg_creeps, creepsMasterId)
end

function OriginGoldenDragonClgConfig:getTeamCfg(creepsMasterId)
	return self:_safeGet(self._origin_golden_dragon_clg_creeps_master, creepsMasterId)
end

function OriginGoldenDragonClgConfig:getPrizeCfgById(activityId, prizeId)
	return self:_safeGet(self._origin_golden_dragon_clg_prize, activityId, prizeId)
end

function OriginGoldenDragonClgConfig:getAllPrizeCfgsByActId(activityId)
	return self:_safeGet(self._origin_golden_dragon_clg_prize, activityId)
end

function OriginGoldenDragonClgConfig:getProphecyCfgById(activityId, prophecyId)
	return self:_safeGet(self._origin_golden_dragon_clg_prophecy, activityId, prophecyId)
end

function OriginGoldenDragonClgConfig:getAllProphecyCfgsByActId(activityId)
	return self:_safeGet(self._origin_golden_dragon_clg_prophecy, activityId)
end

function OriginGoldenDragonClgConfig:getStageCfgById(activityId, stageId)
	return self:_safeGet(self._origin_golden_dragon_clg_stage, activityId, stageId)
end

function OriginGoldenDragonClgConfig:getAllStageCfgsByActId(activityId)
	return self:_safeGet(self._origin_golden_dragon_clg_stage, activityId)
end

function OriginGoldenDragonClgConfig:getScoreRateCfgById(activityId, hitCount)
	return self:_safeGet(self._origin_golden_dragon_clg_score_rate, activityId, hitCount)
end

function OriginGoldenDragonClgConfig:getScoreRateByHitCount(activityId, hitCount)
	local cfg = self:getScoreRateCfgById(activityId, hitCount)

	return (cfg and cfg.scoreRate or nil) and cfg.scoreRate / 10000
end

OriginGoldenDragonClgConfig.instance = OriginGoldenDragonClgConfig.New()

return OriginGoldenDragonClgConfig
