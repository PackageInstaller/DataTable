-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/endlessdark/config/EndlessDarkClgConfig.lua

module("logic.extensions.endlessdark.config.EndlessDarkClgConfig", package.seeall)

local EndlessDarkClgConfig = class("EndlessDarkClgConfig", BaseConfig)

function EndlessDarkClgConfig:onInit()
	EndlessDarkClgConfig.super.onInit(self)

	self._sortScorePlanMap = {}
end

function EndlessDarkClgConfig:getNames()
	return {
		"endless_dark_clg_activity",
		"endless_dark_clg_wave",
		"endless_dark_clg_creeps_master",
		"endless_dark_clg_creeps",
		"endless_dark_clg_buff",
		"endless_dark_clg_support_pet",
		"endless_dark_clg_rank_prize"
	}
end

function EndlessDarkClgConfig:handleConfig(name, content)
	if name == "endless_dark_clg_activity" then
		self._endless_dark_clg_activity = content
	elseif name == "endless_dark_clg_wave" then
		self._endless_dark_clg_wave = content
	elseif name == "endless_dark_clg_creeps_master" then
		self._endless_dark_clg_creeps_master = content
	elseif name == "endless_dark_clg_creeps" then
		self._endless_dark_clg_creeps = content
	elseif name == "endless_dark_clg_buff" then
		self._endless_dark_clg_buff = content
	elseif name == "endless_dark_clg_support_pet" then
		self._endless_dark_clg_support_pet = content
	elseif name == "endless_dark_clg_rank_prize" then
		self._endless_dark_clg_rank_prize = content
	end
end

function EndlessDarkClgConfig:getActCfg(activityId)
	return self._endless_dark_clg_activity[activityId]
end

function EndlessDarkClgConfig:getWaveCfg(activityId)
	return self._endless_dark_clg_wave[activityId]
end

function EndlessDarkClgConfig:getWaveCfgsByWaveId(activityId, waveId)
	return self._endless_dark_clg_wave[activityId] and self._endless_dark_clg_wave[activityId][waveId]
end

function EndlessDarkClgConfig:getWaveCfgsByStageId(activityId, waveId, stageId)
	local waveCfgs = self:getWaveCfgsByWaveId(activityId, waveId)

	return waveCfgs and waveCfgs[stageId]
end

function EndlessDarkClgConfig:getBuffCfg(activityId)
	return self._endless_dark_clg_buff[activityId]
end

function EndlessDarkClgConfig:getBuffCfgsByType(activityId, typeId)
	return self._endless_dark_clg_buff[activityId] and self._endless_dark_clg_buff[activityId][typeId]
end

function EndlessDarkClgConfig:getBuffCfgsById(activityId, typeId, level)
	local typeCfgs = self:getBuffCfgsByType(activityId, typeId)

	return typeCfgs and typeCfgs[level]
end

function EndlessDarkClgConfig:getSupportPetCfg(activityId)
	return self._endless_dark_clg_support_pet[activityId]
end

function EndlessDarkClgConfig:getRankPrizeCfg(activityId)
	return self._endless_dark_clg_rank_prize[activityId]
end

function EndlessDarkClgConfig:getCreepMasterCfg(creepMasterId)
	return self._endless_dark_clg_creeps_master[creepMasterId]
end

function EndlessDarkClgConfig:getCreepsCfg(creepMasterId)
	return self._endless_dark_clg_creeps[creepMasterId]
end

function EndlessDarkClgConfig:getCreepMasterId(activityId, waveId, stageId)
	local waveCfg = self:getWaveCfgsByStageId(activityId, waveId, stageId)

	return waveCfg and waveCfg.creepsMasterId
end

function EndlessDarkClgConfig:getPrizeCfgs(activityId)
	local waveCfgs = self:getWaveCfg(activityId) or {}
	local prizeDataList = {}
	local prizeStageId = 1

	for waveId, stageCfgs in ipairs(waveCfgs) do
		for stageId, stageCfg in ipairs(stageCfgs) do
			local prizeData = {}

			prizeData.prizeStageId = prizeStageId
			prizeData.prize = stageCfg.prize
			prizeStageId = prizeStageId + 1

			table.insert(prizeDataList, prizeData)
		end
	end

	return prizeDataList
end

function EndlessDarkClgConfig:getTotalStageNum(activityId, curWaveId)
	local waveCfgs = EndlessDarkClgConfig.instance:getWaveCfg(activityId) or {}
	local totalStageNum = 0

	for i = 1, curWaveId do
		if not waveCfgs[curWaveId] then
			totalStageNum = totalStageNum + #waveCfgs[curWaveId]
		end
	end

	return totalStageNum
end

function EndlessDarkClgConfig:getBuffTypeList(activityId)
	local buffCfgs = self:getBuffCfg(activityId) or {}
	local typeList = {}

	for type, cfgs in ipairs(buffCfgs) do
		table.insert(typeList, type)
	end

	return typeList
end

EndlessDarkClgConfig.instance = EndlessDarkClgConfig.New()

return EndlessDarkClgConfig
