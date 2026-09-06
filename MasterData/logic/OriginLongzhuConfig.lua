-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongzhu/config/OriginLongzhuConfig.lua

module("logic.extensions.originlongzhu.config.OriginLongzhuConfig", package.seeall)

local OriginLongzhuConfig = class("OriginLongzhuConfig", BaseConfig)

function OriginLongzhuConfig:getNames()
	return {
		"origin_dragon_arya_clg_monster",
		"origin_dragon_arya_clg_activity",
		"origin_dragon_arya_clg_creeps",
		"origin_dragon_arya_clg_score_type",
		"origin_dragon_arya_clg_stage"
	}
end

function OriginLongzhuConfig:handleConfig(name, content)
	if name == "origin_dragon_arya_clg_monster" then
		self._origin_dragon_arya_clg_monster = content
	elseif name == "origin_dragon_arya_clg_activity" then
		self._origin_dragon_arya_clg_activity = content
	elseif name == "origin_dragon_arya_clg_creeps" then
		self._origin_dragon_arya_clg_creeps = content
	elseif name == "origin_dragon_arya_clg_score_type" then
		self._origin_dragon_arya_clg_score_type = content
	elseif name == "origin_dragon_arya_clg_stage" then
		self._origin_dragon_arya_clg_stage = content
	end
end

function OriginLongzhuConfig:getActCfgById(id)
	return self._origin_dragon_arya_clg_activity[id]
end

function OriginLongzhuConfig:getStageListCfgById(activityId)
	return self._origin_dragon_arya_clg_stage[activityId]
end

function OriginLongzhuConfig:getStageCfgById(activityId, stageId)
	if self._origin_dragon_arya_clg_stage[activityId] then
		return self._origin_dragon_arya_clg_stage[activityId][stageId]
	end
end

function OriginLongzhuConfig:getScoreTypeListCfgById(activityId)
	return self._origin_dragon_arya_clg_score_type[activityId]
end

function OriginLongzhuConfig:getScoreTypeCfgById(activityId, id)
	if self._origin_dragon_arya_clg_score_type[activityId] then
		return self._origin_dragon_arya_clg_score_type[activityId][id]
	end
end

function OriginLongzhuConfig:getCreepsById(id)
	return self._origin_dragon_arya_clg_creeps[id]
end

function OriginLongzhuConfig:getMonsterCfgById(id)
	return self._origin_dragon_arya_clg_monster[id]
end

OriginLongzhuConfig.instance = OriginLongzhuConfig.New()

return OriginLongzhuConfig
