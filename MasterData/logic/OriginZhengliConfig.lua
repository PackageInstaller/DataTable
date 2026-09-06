-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originzhengli/config/OriginZhengliConfig.lua

module("logic.extensions.originzhengli.config.OriginZhengliConfig", package.seeall)

local OriginZhengliConfig = class("OriginZhengliConfig", BaseConfig)

function OriginZhengliConfig:getNames()
	return {
		"origin_zhengli_buff",
		"origin_zhengli_creeps",
		"origin_zhengli_settle_plan",
		"origin_zhengli_master",
		"origin_zhengli_route",
		"origin_zhengli_stage",
		"origin_zhengli_activity"
	}
end

function OriginZhengliConfig:handleConfig(name, content)
	if name == "origin_zhengli_buff" then
		self._origin_zhengli_buff = content
	elseif name == "origin_zhengli_creeps" then
		self._origin_zhengli_creeps = content
	elseif name == "origin_zhengli_settle_plan" then
		self._origin_zhengli_settle_plan = content
	elseif name == "origin_zhengli_master" then
		self._origin_zhengli_master = content
	elseif name == "origin_zhengli_route" then
		self._origin_zhengli_route = content
	elseif name == "origin_zhengli_stage" then
		self._origin_zhengli_stage = content
	elseif name == "origin_zhengli_activity" then
		self._origin_zhengli_activity = content
	end
end

function OriginZhengliConfig:getActivityCfg(activityId)
	return self._origin_zhengli_activity[activityId]
end

function OriginZhengliConfig:getCreepCfgs(creepsMasterId)
	return self._origin_zhengli_creeps[creepsMasterId]
end

function OriginZhengliConfig:getTeamCfg(creepsMasterId)
	return self._origin_zhengli_master[creepsMasterId]
end

function OriginZhengliConfig:getBuffCfgById(activityId, buffId)
	if self._origin_zhengli_buff[activityId] then
		return self._origin_zhengli_buff[activityId][buffId]
	end
end

function OriginZhengliConfig:getRouteCfgs(activityId)
	return self._origin_zhengli_route[activityId]
end

function OriginZhengliConfig:getRouteCfgById(activityId, routeId)
	if self._origin_zhengli_route[activityId] then
		return self._origin_zhengli_route[activityId][routeId]
	end
end

function OriginZhengliConfig:getStageCfgs(activityId)
	return self._origin_zhengli_stage[activityId]
end

function OriginZhengliConfig:getStageCfgById(activityId, stageId)
	if self._origin_zhengli_stage[activityId] then
		return self._origin_zhengli_stage[activityId][stageId]
	end
end

function OriginZhengliConfig:getSettlePlanCfg(activityId, settlePlanId, param)
	if self._origin_zhengli_settle_plan[activityId] then
		local settlePlanCfgs = self._origin_zhengli_settle_plan[activityId][settlePlanId]

		if settlePlanCfgs then
			for _, cfg in pairs(settlePlanCfgs) do
				if not cfg.num then
					if param >= checknumber(cfg.num[1]) and param <= checknumber(cfg.num[2]) then
						return cfg
					end
				end
			end
		end
	end
end

OriginZhengliConfig.instance = OriginZhengliConfig.New()

return OriginZhengliConfig
