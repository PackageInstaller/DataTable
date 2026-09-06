-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roseclg/config/RoseclgConfig.lua

module("logic.extensions.roseclg.config.RoseclgConfig", package.seeall)

local RoseclgConfig = class("RoseclgConfig", BaseConfig)

function RoseclgConfig:onInit()
	return
end

function RoseclgConfig:getNames()
	return {
		"rose_clg_activity",
		"rose_clg_stage",
		"rose_clg_creeps_master",
		"rose_clg_creeps"
	}
end

function RoseclgConfig:handleConfig(name, content)
	if name == "rose_clg_activity" then
		self._rose_clg_activity = content
	elseif name == "rose_clg_stage" then
		self._rose_clg_stage = content
	elseif name == "rose_clg_creeps_master" then
		self._rose_clg_creeps_master = content
	elseif name == "rose_clg_creeps" then
		self._rose_clg_creeps = content
	end
end

function RoseclgConfig:getActCfg(activityId)
	return self._rose_clg_activity[activityId]
end

function RoseclgConfig:getStageCfgs(activityId)
	return self._rose_clg_stage[activityId]
end

function RoseclgConfig:getStageCfg(activityId, stageId)
	return self._rose_clg_stage[activityId][stageId]
end

function RoseclgConfig:getCreepsCfgs(creepsMasterId)
	return self._rose_clg_creeps[creepsMasterId]
end

function RoseclgConfig:getCreepsMasterCfgs(activityId, stageId)
	local stageCfg = self:getStageCfg(activityId, stageId)
	local creepsCfgs = {}

	for i, creepsMasterId in ipairs(stageCfg.teams) do
		table.insert(creepsCfgs, self:getMasterCfg(creepsMasterId))
	end

	return creepsCfgs
end

function RoseclgConfig:getCreepsMasterCfg(creepsMasterId)
	return self._rose_clg_creeps_master[creepsMasterId]
end

function RoseclgConfig:getMasterCfg(creepsMasterId)
	return self._rose_clg_creeps_master[creepsMasterId]
end

RoseclgConfig.instance = RoseclgConfig.New()

return RoseclgConfig
