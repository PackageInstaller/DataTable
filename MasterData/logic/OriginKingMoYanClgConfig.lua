-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmoyanclg/config/OriginKingMoYanClgConfig.lua

module("logic.extensions.originkingmoyanclg.config.OriginKingMoYanClgConfig", package.seeall)

local OriginKingMoYanClgConfig = class("OriginKingMoYanClgConfig", BaseConfig)

function OriginKingMoYanClgConfig:onInit()
	OriginKingMoYanClgConfig.super.onInit(self)
end

function OriginKingMoYanClgConfig:getNames()
	return {
		"origin_king_mo_yan_clg_creeps_master",
		"origin_king_mo_yan_clg_stage",
		"origin_king_mo_yan_clg_creeps",
		"origin_king_mo_yan_clg_phase",
		"origin_king_mo_yan_clg_buff",
		"origin_king_mo_yan_clg_activity"
	}
end

function OriginKingMoYanClgConfig:handleConfig(name, content)
	if name == "origin_king_mo_yan_clg_creeps_master" then
		self._origin_king_mo_yan_clg_creeps_master = content
	elseif name == "origin_king_mo_yan_clg_stage" then
		self._origin_king_mo_yan_clg_stage = content
	elseif name == "origin_king_mo_yan_clg_creeps" then
		self._origin_king_mo_yan_clg_creeps = content
	elseif name == "origin_king_mo_yan_clg_phase" then
		self._origin_king_mo_yan_clg_phase = content
	elseif name == "origin_king_mo_yan_clg_buff" then
		self._origin_king_mo_yan_clg_buff = content
	elseif name == "origin_king_mo_yan_clg_activity" then
		self._origin_king_mo_yan_clg_activity = content
	end
end

function OriginKingMoYanClgConfig:getActivityCfg(activityId)
	return self._origin_king_mo_yan_clg_activity[activityId]
end

function OriginKingMoYanClgConfig:getFloorCfgs(activityId)
	return self._origin_king_mo_yan_clg_phase[activityId]
end

function OriginKingMoYanClgConfig:getFloorCfg(activityId, floorId)
	if self._origin_king_mo_yan_clg_phase[activityId] then
		return self._origin_king_mo_yan_clg_phase[activityId][floorId]
	end
end

function OriginKingMoYanClgConfig:getStageCfgs(activityId, floorId)
	if self._origin_king_mo_yan_clg_stage[activityId] then
		return self._origin_king_mo_yan_clg_stage[activityId][floorId]
	end
end

function OriginKingMoYanClgConfig:getStageCfg(activityId, floorId, stageId)
	if self._origin_king_mo_yan_clg_stage[activityId] and self._origin_king_mo_yan_clg_stage[activityId][floorId] then
		return self._origin_king_mo_yan_clg_stage[activityId][floorId][stageId]
	end
end

function OriginKingMoYanClgConfig:getTeamCfg(creepsMasterId)
	return self._origin_king_mo_yan_clg_creeps_master[creepsMasterId]
end

function OriginKingMoYanClgConfig:getCreepsCfg(creepsMasterId)
	return self._origin_king_mo_yan_clg_creeps[creepsMasterId]
end

function OriginKingMoYanClgConfig:getBuffCfgWithType(activityId, buffType)
	if self._origin_king_mo_yan_clg_buff[activityId] then
		return self._origin_king_mo_yan_clg_buff[activityId][buffType]
	end
end

OriginKingMoYanClgConfig.instance = OriginKingMoYanClgConfig.New()

return OriginKingMoYanClgConfig
