-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkaya/config/OriginKayaConfig.lua

module("logic.extensions.originkaya.config.OriginKayaConfig", package.seeall)

local OriginKayaConfig = class("OriginKayaConfig", BaseConfig)

function OriginKayaConfig:onInit()
	OriginKayaConfig.super.onInit(self)
end

function OriginKayaConfig:getNames()
	return {
		"origin_kaya_floor",
		"origin_kaya_attribute",
		"origin_kaya_creeps",
		"origin_kaya_master",
		"origin_kaya_seed",
		"origin_kaya_stage",
		"origin_kaya_activity"
	}
end

function OriginKayaConfig:handleConfig(name, content)
	if name == "origin_kaya_floor" then
		self._origin_kaya_floor = content
	elseif name == "origin_kaya_attribute" then
		self._origin_kaya_attribute = content
	elseif name == "origin_kaya_creeps" then
		self._origin_kaya_creeps = content
	elseif name == "origin_kaya_master" then
		self._origin_kaya_master = content
	elseif name == "origin_kaya_seed" then
		self._origin_kaya_seed = content
	elseif name == "origin_kaya_stage" then
		self._origin_kaya_stage = content
	elseif name == "origin_kaya_activity" then
		self._origin_kaya_activity = content
	end
end

function OriginKayaConfig:getActivityCfg(activityId)
	return self._origin_kaya_activity[activityId]
end

function OriginKayaConfig:getFloorCfgs(activityId)
	return self._origin_kaya_floor[activityId]
end

function OriginKayaConfig:getFloorCfg(activityId, floorId)
	if self._origin_kaya_floor[activityId] then
		return self._origin_kaya_floor[activityId][floorId]
	end
end

function OriginKayaConfig:getStageCfgs(activityId, floorId)
	if self._origin_kaya_stage[activityId] then
		return self._origin_kaya_stage[activityId][floorId]
	end
end

function OriginKayaConfig:getStageCfg(activityId, floorId, stageId)
	if self._origin_kaya_stage[activityId] and self._origin_kaya_stage[activityId][floorId] then
		return self._origin_kaya_stage[activityId][floorId][stageId]
	end
end

function OriginKayaConfig:getTeamCfg(creepsMasterId)
	return self._origin_kaya_master[creepsMasterId]
end

function OriginKayaConfig:getCreepsCfg(creepsMasterId)
	return self._origin_kaya_creeps[creepsMasterId]
end

function OriginKayaConfig:getSeedCfg(activityId, seedId)
	if self._origin_kaya_seed[activityId] then
		return self._origin_kaya_seed[activityId][seedId]
	end
end

OriginKayaConfig.instance = OriginKayaConfig.New()

return OriginKayaConfig
