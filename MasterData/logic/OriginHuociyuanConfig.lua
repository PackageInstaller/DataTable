-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhuociyuan/config/OriginHuociyuanConfig.lua

module("logic.extensions.originhuociyuan.config.OriginHuociyuanConfig", package.seeall)

local OriginHuociyuanConfig = class("OriginHuociyuanConfig", BaseConfig)

function OriginHuociyuanConfig:getNames()
	return {
		"origin_fire_dimension_master",
		"origin_fire_dimension_stage",
		"origin_fire_dimension_activity",
		"origin_fire_dimension_block_buff",
		"origin_fire_dimension_creeps",
		"origin_fire_dimension_enemy_buff"
	}
end

function OriginHuociyuanConfig:handleConfig(name, content)
	if name == "origin_fire_dimension_master" then
		self._origin_fire_dimension_master = content
	elseif name == "origin_fire_dimension_stage" then
		self._origin_fire_dimension_stage = content
	elseif name == "origin_fire_dimension_activity" then
		self._origin_fire_dimension_activity = content
	elseif name == "origin_fire_dimension_block_buff" then
		self._origin_fire_dimension_block_buff = content
	elseif name == "origin_fire_dimension_creeps" then
		self._origin_fire_dimension_creeps = content
	elseif name == "origin_fire_dimension_enemy_buff" then
		self._origin_fire_dimension_enemy_buff = content
	end
end

function OriginHuociyuanConfig:getActCfgById(activityId)
	return self._origin_fire_dimension_activity[activityId]
end

function OriginHuociyuanConfig:getStageListCfgById(activityId)
	return self._origin_fire_dimension_stage[activityId]
end

function OriginHuociyuanConfig:getStageCfgById(activityId, stageId)
	if self._origin_fire_dimension_stage[activityId] then
		return self._origin_fire_dimension_stage[activityId][stageId]
	end
end

function OriginHuociyuanConfig:getMonsterCfgById(creepsMasterId)
	return self._origin_fire_dimension_master[creepsMasterId]
end

function OriginHuociyuanConfig:getCreepsById(creepsMasterId)
	return self._origin_fire_dimension_creeps[creepsMasterId]
end

function OriginHuociyuanConfig:getEnemyBuffCfgById(activityId)
	return self._origin_fire_dimension_enemy_buff[activityId]
end

function OriginHuociyuanConfig:getBuffCfgById(activityId, buffId)
	if self._origin_fire_dimension_block_buff[activityId] then
		return self._origin_fire_dimension_block_buff[activityId][buffId]
	end
end

OriginHuociyuanConfig.instance = OriginHuociyuanConfig.New()

return OriginHuociyuanConfig
