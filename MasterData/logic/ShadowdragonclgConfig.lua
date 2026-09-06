-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shadowdragonclg/config/ShadowdragonclgConfig.lua

module("logic.extensions.shadowdragonclg.config.ShadowdragonclgConfig", package.seeall)

local ShadowdragonclgConfig = class("ShadowdragonclgConfig", BaseConfig)

function ShadowdragonclgConfig:onInit()
	return
end

function ShadowdragonclgConfig:getNames()
	return {
		"shadow_dragon_clg_creeps_master",
		"shadow_dragon_clg_now_stage",
		"shadow_dragon_clg_future_pass_stage",
		"shadow_dragon_clg_activity",
		"shadow_dragon_clg_creeps",
		"shadow_dragon_clg_buff",
		"shadow_dragon_floor"
	}
end

function ShadowdragonclgConfig:handleConfig(name, content)
	if name == "shadow_dragon_clg_creeps_master" then
		self._shadow_dragon_clg_creeps_master = content
	elseif name == "shadow_dragon_clg_now_stage" then
		self._shadow_dragon_clg_now_stage = content
	elseif name == "shadow_dragon_clg_future_pass_stage" then
		self._shadow_dragon_clg_future_pass_stage = content
	elseif name == "shadow_dragon_clg_activity" then
		self._shadow_dragon_clg_activity = content
	elseif name == "shadow_dragon_clg_creeps" then
		self._shadow_dragon_clg_creeps = content
	elseif name == "shadow_dragon_clg_buff" then
		self._shadow_dragon_clg_buff = content
	elseif name == "shadow_dragon_floor" then
		self._shadow_dragon_floor = content
	end
end

function ShadowdragonclgConfig:getActCfg(activityId)
	return self._shadow_dragon_clg_activity[activityId]
end

function ShadowdragonclgConfig:getBuffCfgs(activityId, stageId)
	local stageCfg = self:getNowStageCfg(activityId, stageId)

	return self._shadow_dragon_clg_buff[stageCfg.selectBuffPlan]
end

function ShadowdragonclgConfig:getFuturePassBuffCfgs(activityId, stageId)
	local stageCfg = self:getFuturePassStageCfg(activityId, stageId)

	return self._shadow_dragon_clg_buff[stageCfg.selectBuffPlan]
end

function ShadowdragonclgConfig:getBuffCfg(selectBuffPlan, buffId)
	return self._shadow_dragon_clg_buff[selectBuffPlan][buffId]
end

function ShadowdragonclgConfig:getNowStageCfgs(activityId)
	return self._shadow_dragon_clg_now_stage[activityId]
end

function ShadowdragonclgConfig:getNowStageCfg(activityId, stageId)
	return self._shadow_dragon_clg_now_stage[activityId][stageId]
end

function ShadowdragonclgConfig:getFuturePassStageCfgs(activityId)
	return self._shadow_dragon_clg_future_pass_stage[activityId]
end

function ShadowdragonclgConfig:getFuturePassStageCfg(activityId, stageId)
	return self._shadow_dragon_clg_future_pass_stage[activityId][stageId]
end

function ShadowdragonclgConfig:getSkinId(activityId)
	return self._shadow_dragon_clg_activity[activityId].skinId
end

function ShadowdragonclgConfig:getCreepsCfgs(creepsMasterId)
	return self._shadow_dragon_clg_creeps[creepsMasterId]
end

function ShadowdragonclgConfig:getCreepsMasterCfg(creepsMasterId)
	return self._shadow_dragon_clg_creeps_master[creepsMasterId]
end

function ShadowdragonclgConfig:getFloorCfgs(activityId)
	return self._shadow_dragon_floor[activityId]
end

function ShadowdragonclgConfig:getFloorCfg(activityId, floorId)
	return self._shadow_dragon_floor[activityId][floorId]
end

ShadowdragonclgConfig.instance = ShadowdragonclgConfig.New()

return ShadowdragonclgConfig
