-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindualdragon/config/OriginDualDragonConfig.lua

module("logic.extensions.origindualdragon.config.OriginDualDragonConfig", package.seeall)

local OriginDualDragonConfig = class("OriginDualDragonConfig", BaseConfig)

function OriginDualDragonConfig:getNames()
	return {
		"origin_dual_dragon_activity",
		"origin_dual_dragon_stage",
		"origin_dual_dragon_master",
		"origin_dual_dragon_creeps",
		"origin_dual_dragon_buff"
	}
end

function OriginDualDragonConfig:handleConfig(name, content)
	if name == "origin_dual_dragon_activity" then
		self._origin_dual_dragon_activity = content
	elseif name == "origin_dual_dragon_stage" then
		self._origin_dual_dragon_stage = content
	elseif name == "origin_dual_dragon_master" then
		self._origin_dual_dragon_master = content
	elseif name == "origin_dual_dragon_creeps" then
		self._origin_dual_dragon_creeps = content
	elseif name == "origin_dual_dragon_buff" then
		self._origin_dual_dragon_buff = content
	end
end

function OriginDualDragonConfig:getActivity(activityId)
	return self._origin_dual_dragon_activity[activityId]
end

function OriginDualDragonConfig:getStages(activityId)
	return self._origin_dual_dragon_stage[activityId]
end

function OriginDualDragonConfig:getStage(activityId, stageType, stageId)
	if self._origin_dual_dragon_stage[activityId] and self._origin_dual_dragon_stage[activityId][stageType] then
		return self._origin_dual_dragon_stage[activityId][stageType][stageId]
	end
end

function OriginDualDragonConfig:getMaster(creepsMasterId)
	return self._origin_dual_dragon_master[creepsMasterId]
end

function OriginDualDragonConfig:getCreeps(creepsMasterId)
	return self._origin_dual_dragon_creeps[creepsMasterId]
end

function OriginDualDragonConfig:getBuff(activityId, buffId)
	if self._origin_dual_dragon_buff and self._origin_dual_dragon_buff[activityId] then
		return self._origin_dual_dragon_buff[activityId][buffId]
	end
end

OriginDualDragonConfig.instance = OriginDualDragonConfig.New()

return OriginDualDragonConfig
