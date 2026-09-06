-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originweileita/config/OriginWeiLeiTaConfig.lua

module("logic.extensions.originweileita.config.OriginWeiLeiTaConfig", package.seeall)

local OriginWeiLeiTaConfig = class("OriginWeiLeiTaConfig", BaseConfig)

function OriginWeiLeiTaConfig:onInit()
	return
end

function OriginWeiLeiTaConfig:getNames()
	return {
		"origin_weileita_extreme_stage",
		"origin_weileita_monster",
		"origin_weileita_activity",
		"origin_weileita_creeps",
		"origin_weileita_normal_stage",
		"origin_weileita_normal_buff",
		"origin_weileita_sign",
		"origin_weileita_normal_progress_prize"
	}
end

function OriginWeiLeiTaConfig:handleConfig(name, content)
	if name == "origin_weileita_extreme_stage" then
		self._origin_weileita_extreme_stage = content
	elseif name == "origin_weileita_monster" then
		self._origin_weileita_monster = content
	elseif name == "origin_weileita_activity" then
		self._origin_weileita_activity = content
	elseif name == "origin_weileita_creeps" then
		self._origin_weileita_creeps = content
	elseif name == "origin_weileita_normal_stage" then
		self._origin_weileita_normal_stage = content
	elseif name == "origin_weileita_normal_buff" then
		self._origin_weileita_normal_buff = content
	elseif name == "origin_weileita_sign" then
		self._origin_weileita_sign = content
	elseif name == "origin_weileita_normal_progress_prize" then
		self._origin_weileita_normal_progress_prize = content
	end
end

function OriginWeiLeiTaConfig:getActCfg(activityId)
	return self._origin_weileita_activity[activityId]
end

function OriginWeiLeiTaConfig:getExtStageCfgs(activityId)
	return self._origin_weileita_extreme_stage[activityId]
end

function OriginWeiLeiTaConfig:getExtStageCfg(activityId, stageId)
	return self._origin_weileita_extreme_stage[activityId][stageId]
end

function OriginWeiLeiTaConfig:getNorStageCfgs(activityId)
	return self._origin_weileita_normal_stage[activityId]
end

function OriginWeiLeiTaConfig:getNorStageCfg(activityId, stageId)
	return self._origin_weileita_normal_stage[activityId][stageId]
end

function OriginWeiLeiTaConfig:getNorPrizeCfgs(activityId)
	return self._origin_weileita_normal_progress_prize[activityId]
end

function OriginWeiLeiTaConfig:getCreepsCfgs(creepsMasterId)
	return self._origin_weileita_creeps[creepsMasterId]
end

function OriginWeiLeiTaConfig:getCreepsMasterCfg(creepsMasterId)
	return self._origin_weileita_monster[creepsMasterId]
end

function OriginWeiLeiTaConfig:getBuffCfgs(activityId)
	return self._origin_weileita_normal_buff[activityId]
end

function OriginWeiLeiTaConfig:getBuffCfgByScore(activityId, score)
	for i = #self._origin_weileita_normal_buff.dataList, 1, -1 do
		local v = self._origin_weileita_normal_buff.dataList[i]

		if v.activityId == activityId and score >= v.progress then
			return v
		end
	end
end

function OriginWeiLeiTaConfig:getSignCfg(activityId, signId)
	return self._origin_weileita_sign[activityId][signId]
end

OriginWeiLeiTaConfig.instance = OriginWeiLeiTaConfig.New()

return OriginWeiLeiTaConfig
