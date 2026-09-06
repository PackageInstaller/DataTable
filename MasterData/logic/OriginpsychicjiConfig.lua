-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpsychicji/config/OriginpsychicjiConfig.lua

module("logic.extensions.originpsychicji.config.OriginpsychicjiConfig", package.seeall)

local OriginpsychicjiConfig = class("OriginpsychicjiConfig", BaseConfig)

function OriginpsychicjiConfig:onInit()
	return
end

function OriginpsychicjiConfig:getNames()
	return {
		"origin_psychic_ji_activity",
		"origin_psychic_ji_master",
		"origin_psychic_ji_settle_plan",
		"origin_psychic_ji_creeps",
		"origin_psychic_ji_ext_stage",
		"origin_psychic_ji_normal_stage"
	}
end

function OriginpsychicjiConfig:handleConfig(name, content)
	if name == "origin_psychic_ji_activity" then
		self._origin_psychic_ji_activity = content
	elseif name == "origin_psychic_ji_master" then
		self._origin_psychic_ji_master = content
	elseif name == "origin_psychic_ji_settle_plan" then
		self._origin_psychic_ji_settle_plan = content
	elseif name == "origin_psychic_ji_creeps" then
		self._origin_psychic_ji_creeps = content
	elseif name == "origin_psychic_ji_ext_stage" then
		self._origin_psychic_ji_ext_stage = content
	elseif name == "origin_psychic_ji_normal_stage" then
		self._origin_psychic_ji_normal_stage = content
	end
end

function OriginpsychicjiConfig:getActCfg(activityId)
	return self._origin_psychic_ji_activity[activityId]
end

function OriginpsychicjiConfig:getSkinId(activityId)
	return self._origin_psychic_ji_activity[activityId].skinId
end

function OriginpsychicjiConfig:getNormalStageCfgs(activityId)
	return self._origin_psychic_ji_normal_stage[activityId]
end

function OriginpsychicjiConfig:getNormalStageCfg(activityId, stageId)
	return self._origin_psychic_ji_normal_stage[activityId][stageId]
end

function OriginpsychicjiConfig:getExtStageCfgs(activityId)
	return self._origin_psychic_ji_ext_stage[activityId]
end

function OriginpsychicjiConfig:getExtStageCfg(activityId, stageId)
	return self._origin_psychic_ji_ext_stage[activityId][stageId]
end

function OriginpsychicjiConfig:getCreepsCfgs(creepsMasterId)
	return self._origin_psychic_ji_creeps[creepsMasterId]
end

function OriginpsychicjiConfig:getCreepsMasterCfg(creepsMasterId)
	return self._origin_psychic_ji_master[creepsMasterId]
end

function OriginpsychicjiConfig:getSettlePlanCfgs(activityId, planId)
	return self._origin_psychic_ji_settle_plan[activityId][planId]
end

function OriginpsychicjiConfig:getSettleEnergyByNum(activityId, planId, num)
	for numKey, cfg in pairs(self:getSettlePlanCfgs(activityId, planId)) do
		if num >= numKey[1] and num <= numKey[2] then
			return cfg.energy
		end
	end

	return 0
end

OriginpsychicjiConfig.instance = OriginpsychicjiConfig.New()

return OriginpsychicjiConfig
