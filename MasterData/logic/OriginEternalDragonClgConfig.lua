-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origineternaldragonclg/config/OriginEternalDragonClgConfig.lua

module("logic.extensions.origineternaldragonclg.config.OriginEternalDragonClgConfig", package.seeall)

local OriginEternalDragonClgConfig = class("OriginEternalDragonClgConfig", BaseConfig)

function OriginEternalDragonClgConfig:onInit()
	OriginEternalDragonClgConfig.super.onInit(self)

	self._sortScorePlanMap = {}
end

function OriginEternalDragonClgConfig:getNames()
	return {
		"origin_eternal_dragon_clg_activity",
		"origin_eternal_dragon_clg_stage",
		"origin_eternal_dragon_clg_buff",
		"origin_eternal_dragon_clg_creeps_master",
		"origin_eternal_dragon_clg_creeps",
		"origin_eternal_dragon_clg_combo"
	}
end

function OriginEternalDragonClgConfig:handleConfig(name, content)
	if name == "origin_eternal_dragon_clg_activity" then
		self._origin_eternal_dragon_clg_activity = content
	elseif name == "origin_eternal_dragon_clg_stage" then
		self._origin_eternal_dragon_clg_stage = content
	elseif name == "origin_eternal_dragon_clg_buff" then
		self._origin_eternal_dragon_clg_buff = content
	elseif name == "origin_eternal_dragon_clg_creeps_master" then
		self._origin_eternal_dragon_clg_creeps_master = content
	elseif name == "origin_eternal_dragon_clg_creeps" then
		self._origin_eternal_dragon_clg_creeps = content
	elseif name == "origin_eternal_dragon_clg_combo" then
		self._origin_eternal_dragon_clg_combo = content
	end
end

function OriginEternalDragonClgConfig:getActCfg(activityId)
	return self._origin_eternal_dragon_clg_activity[activityId]
end

function OriginEternalDragonClgConfig:getStageCfgs(activityId)
	return self._origin_eternal_dragon_clg_stage[activityId]
end

function OriginEternalDragonClgConfig:getStageCfgsByType(activityId, type)
	return self._origin_eternal_dragon_clg_stage[activityId] and self._origin_eternal_dragon_clg_stage[activityId][type]
end

function OriginEternalDragonClgConfig:getStageCfgsById(activityId, type, stageId)
	local stageCfgs = self:getStageCfgsByType(activityId, type)

	return stageCfgs and stageCfgs[stageId]
end

function OriginEternalDragonClgConfig:getBuffCfgs(activityId)
	return self._origin_eternal_dragon_clg_buff[activityId]
end

function OriginEternalDragonClgConfig:getBuffCfgsBytype(activityId, type)
	return self._origin_eternal_dragon_clg_buff[activityId] and self._origin_eternal_dragon_clg_buff[activityId][type]
end

function OriginEternalDragonClgConfig:getBuffCfgsByCount(activityId, type, count)
	local buffCfgs = self:getBuffCfgsBytype(activityId, type)

	if buffCfgs then
		return buffCfgs[count]
	end
end

function OriginEternalDragonClgConfig:getCreepMasterCfg(creepMasterId)
	return self._origin_eternal_dragon_clg_creeps_master[creepMasterId]
end

function OriginEternalDragonClgConfig:getCreepsCfg(creepMasterId)
	return self._origin_eternal_dragon_clg_creeps[creepMasterId]
end

function OriginEternalDragonClgConfig:getCreepMasterId(activityId, type, stageId)
	local stageCfg = self:getStageCfgsById(activityId, type, stageId)

	return stageCfg and stageCfg.creepsMasterId
end

function OriginEternalDragonClgConfig:getComboCfgs(activityId)
	return self._origin_eternal_dragon_clg_combo[activityId]
end

function OriginEternalDragonClgConfig:getComboCfgById(activityId, comboId)
	return self._origin_eternal_dragon_clg_combo[activityId] and self._origin_eternal_dragon_clg_combo[activityId][comboId]
end

OriginEternalDragonClgConfig.instance = OriginEternalDragonClgConfig.New()

return OriginEternalDragonClgConfig
