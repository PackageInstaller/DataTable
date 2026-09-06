-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhotbloodmmclg/config/OriginHotBloodMMClgConfig.lua

module("logic.extensions.originhotbloodmmclg.config.OriginHotBloodMMClgConfig", package.seeall)

local OriginHotBloodMMClgConfig = class("OriginHotBloodMMClgConfig", BaseConfig)

function OriginHotBloodMMClgConfig:getNames()
	return {
		"origin_hot_blooded_mm_activity",
		"origin_hot_blooded_mm_stage",
		"origin_hot_blooded_mm_master",
		"origin_hot_blooded_mm_creeps"
	}
end

function OriginHotBloodMMClgConfig:handleConfig(name, content)
	if name == "origin_hot_blooded_mm_activity" then
		self._origin_hot_blooded_mm_activity = content
	elseif name == "origin_hot_blooded_mm_stage" then
		self._origin_hot_blooded_mm_stage = content
	elseif name == "origin_hot_blooded_mm_master" then
		self._origin_hot_blooded_mm_master = content
	elseif name == "origin_hot_blooded_mm_creeps" then
		self._origin_hot_blooded_mm_creeps = content
	end
end

function OriginHotBloodMMClgConfig:getActivity(activityId)
	return self._origin_hot_blooded_mm_activity[activityId]
end

function OriginHotBloodMMClgConfig:getStages(activityId)
	return self._origin_hot_blooded_mm_stage[activityId]
end

function OriginHotBloodMMClgConfig:getStage(activityId, stageId)
	return self._origin_hot_blooded_mm_stage[activityId][stageId]
end

function OriginHotBloodMMClgConfig:getMaster(creepsMasterId)
	return self._origin_hot_blooded_mm_master[creepsMasterId]
end

function OriginHotBloodMMClgConfig:getCreeps(creepsMasterId)
	return self._origin_hot_blooded_mm_creeps[creepsMasterId]
end

OriginHotBloodMMClgConfig.instance = OriginHotBloodMMClgConfig.New()

return OriginHotBloodMMClgConfig
