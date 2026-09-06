-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originxiuer/config/OriginXiuErConfig.lua

module("logic.extensions.originxiuer.config.OriginXiuErConfig", package.seeall)

local OriginXiuErConfig = class("OriginXiuErConfig", BaseConfig)

function OriginXiuErConfig:getNames()
	return {
		"origin_xiu_er_activity",
		"origin_xiu_er_stage",
		"origin_xiu_er_master",
		"origin_xiu_er_creeps"
	}
end

function OriginXiuErConfig:handleConfig(name, content)
	if name == "origin_xiu_er_activity" then
		self._origin_xiu_er_activity = content
	elseif name == "origin_xiu_er_stage" then
		self._origin_xiu_er_stage = content
	elseif name == "origin_xiu_er_master" then
		self._origin_xiu_er_master = content
	elseif name == "origin_xiu_er_creeps" then
		self._origin_xiu_er_creeps = content
	end
end

function OriginXiuErConfig:getActCfg(activityId)
	return self._origin_xiu_er_activity[activityId]
end

function OriginXiuErConfig:getStageCfgs(activityId)
	return self._origin_xiu_er_stage[activityId]
end

function OriginXiuErConfig:getStageCfgById(activityId, stageId)
	return self._origin_xiu_er_stage[activityId] and self._origin_xiu_er_stage[activityId][stageId]
end

function OriginXiuErConfig:getCreepMasterCfg(creepMasterId)
	return self._origin_xiu_er_master[creepMasterId]
end

function OriginXiuErConfig:getCreepsCfg(creepMasterId)
	return self._origin_xiu_er_creeps[creepMasterId]
end

function OriginXiuErConfig:getCreepMasterId(activityId, stageId)
	local stageCfg = self:getStageCfgById(activityId, stageId)

	return stageCfg and stageCfg.creepsMasterId
end

function OriginXiuErConfig:getBuffEnemyList(activityId, stageId)
	local creepMasterId = self:getCreepMasterId(activityId, stageId)
	local creepsCfg = self:getCreepsCfg(creepMasterId)
	local stageCfg = self:getStageCfgById(activityId, stageId)
	local buffPosition = stageCfg.buffPosition
	local buffEnemyList = {}

	for i, cfg in ipairs(creepsCfg) do
		local buff = buffPosition[cfg.posId]

		if buff == 1 then
			table.insert(buffEnemyList, cfg)
		end
	end

	return buffEnemyList
end

OriginXiuErConfig.instance = OriginXiuErConfig.New()

return OriginXiuErConfig
