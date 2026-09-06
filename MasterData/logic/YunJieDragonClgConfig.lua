-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yunjiedragonclg/config/YunJieDragonClgConfig.lua

module("logic.extensions.yunjiedragonclg.config.YunJieDragonClgConfig", package.seeall)

local YunJieDragonClgConfig = class("YunJieDragonClgConfig", BaseConfig)

function YunJieDragonClgConfig:onInit()
	YunJieDragonClgConfig.super.onInit(self)
end

function YunJieDragonClgConfig:getNames()
	return {
		"yun_jie_dragon_clg_activity",
		"yun_jie_dragon_clg_phase",
		"yun_jie_dragon_clg_stage",
		"yun_jie_dragon_clg_one_key_pass_cost",
		"yun_jie_dragon_clg_monster",
		"yun_jie_dragon_clg_creeps"
	}
end

function YunJieDragonClgConfig:handleConfig(name, content)
	if name == "yun_jie_dragon_clg_activity" then
		self._yun_jie_dragon_clg_activity = content
	elseif name == "yun_jie_dragon_clg_phase" then
		self._yun_jie_dragon_clg_phase = content
	elseif name == "yun_jie_dragon_clg_stage" then
		self._yun_jie_dragon_clg_stage = content

		self:_sortStageCfgByPhaseId(content.dataList)
	elseif name == "yun_jie_dragon_clg_one_key_pass_cost" then
		self._yun_jie_dragon_clg_one_key_pass_cost = content
	elseif name == "yun_jie_dragon_clg_monster" then
		self._yun_jie_dragon_clg_monster = content
	elseif name == "yun_jie_dragon_clg_creeps" then
		self._yun_jie_dragon_clg_creeps = content
	end
end

function YunJieDragonClgConfig:getActCfg(activityId)
	return self._yun_jie_dragon_clg_activity[activityId]
end

function YunJieDragonClgConfig:getPhaseCfgs(activityId)
	return self._yun_jie_dragon_clg_phase[activityId]
end

function YunJieDragonClgConfig:getPhaseCfgById(activityId, phaseId)
	return self._yun_jie_dragon_clg_phase[activityId] and self._yun_jie_dragon_clg_phase[activityId][phaseId]
end

function YunJieDragonClgConfig:_sortStageCfgByPhaseId(dataList)
	self._stageMaps = {}

	for i, cfg in ipairs(dataList) do
		self._stageMaps[cfg.activityId] = self._stageMaps[cfg.activityId] or {}

		local stagePhaseMap = self._stageMaps[cfg.activityId]

		stagePhaseMap[cfg.phaseId] = stagePhaseMap[cfg.phaseId] or {}

		local stageList = stagePhaseMap[cfg.phaseId]

		table.insert(stageList, cfg)
	end
end

function YunJieDragonClgConfig:getStageCfgs(activityId)
	return self._yun_jie_dragon_clg_stage[activityId]
end

function YunJieDragonClgConfig:getStageCfgsByPhaseId(activityId, phaseId)
	return self._stageMaps[activityId] and self._stageMaps[activityId][phaseId]
end

function YunJieDragonClgConfig:getStageCfgByStageId(activityId, stageId)
	return self._yun_jie_dragon_clg_stage[activityId] and self._yun_jie_dragon_clg_stage[activityId][stageId]
end

function YunJieDragonClgConfig:getOneKeyPassCostCfg(activityId, leftStageCount)
	return self._yun_jie_dragon_clg_one_key_pass_cost[activityId] and self._yun_jie_dragon_clg_one_key_pass_cost[activityId][leftStageCount]
end

function YunJieDragonClgConfig:getMasterCfg(creepsMasterId)
	return self._yun_jie_dragon_clg_monster[creepsMasterId]
end

function YunJieDragonClgConfig:getCreepCfg(creepsMasterId)
	return self._yun_jie_dragon_clg_creeps[creepsMasterId]
end

function YunJieDragonClgConfig:getCreepMasterId(activityId, stageId)
	local stageCfg = self:getStageCfgByStageId(activityId, stageId)

	return stageCfg and stageCfg.creepsMasterId
end

YunJieDragonClgConfig.instance = YunJieDragonClgConfig.New()

return YunJieDragonClgConfig
