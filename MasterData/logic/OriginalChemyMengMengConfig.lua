-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originalchemymengmeng/config/OriginalChemyMengMengConfig.lua

module("logic.extensions.originalchemymengmeng.config.OriginalChemyMengMengConfig", package.seeall)

local OriginalChemyMengMengConfig = class("OriginalChemyMengMengConfig", BaseConfig)

function OriginalChemyMengMengConfig:getNames()
	return {
		"origin_alchemy_meng_meng_activity",
		"origin_alchemy_meng_meng_stage",
		"origin_alchemy_meng_meng_reagent",
		"origin_alchemy_meng_meng_compound",
		"origin_alchemy_meng_meng_mark",
		"origin_alchemy_meng_meng_master",
		"origin_alchemy_meng_meng_creeps"
	}
end

function OriginalChemyMengMengConfig:handleConfig(name, content)
	if name == "origin_alchemy_meng_meng_activity" then
		self._origin_alchemy_meng_meng_activity = content
	elseif name == "origin_alchemy_meng_meng_stage" then
		self._origin_alchemy_meng_meng_stage = content
	elseif name == "origin_alchemy_meng_meng_reagent" then
		self._origin_alchemy_meng_meng_reagent = content
	elseif name == "origin_alchemy_meng_meng_compound" then
		self._origin_alchemy_meng_meng_compound = content
	elseif name == "origin_alchemy_meng_meng_mark" then
		self._origin_alchemy_meng_meng_mark = content
	elseif name == "origin_alchemy_meng_meng_master" then
		self._origin_alchemy_meng_meng_master = content
	elseif name == "origin_alchemy_meng_meng_creeps" then
		self._origin_alchemy_meng_meng_creeps = content
	end
end

function OriginalChemyMengMengConfig:getActivityCfg(activityId)
	return self._origin_alchemy_meng_meng_activity[activityId]
end

function OriginalChemyMengMengConfig:getStageCfgs(activityId)
	return self._origin_alchemy_meng_meng_stage[activityId]
end

function OriginalChemyMengMengConfig:getStageCfg(activityId, stageId)
	return self._origin_alchemy_meng_meng_stage[activityId] and self._origin_alchemy_meng_meng_stage[activityId][stageId]
end

function OriginalChemyMengMengConfig:getReagentCfgs(activityId)
	return self._origin_alchemy_meng_meng_reagent[activityId]
end

function OriginalChemyMengMengConfig:getReagentCfg(activityId, reagentId)
	local cfgs = self:getReagentCfgs(activityId)

	return cfgs and cfgs[reagentId]
end

function OriginalChemyMengMengConfig:getCompoundCfgs(activityId)
	return self._origin_alchemy_meng_meng_compound[activityId]
end

function OriginalChemyMengMengConfig:getCompoundCfg(activityId, compoundId)
	local cfgs = self:getCompoundCfgs(activityId)

	return cfgs and cfgs[compoundId]
end

function OriginalChemyMengMengConfig:getMarkCfgs(activityId)
	return self._origin_alchemy_meng_meng_mark[activityId]
end

function OriginalChemyMengMengConfig:getMarkCfg(activityId, markId)
	local cfgs = self:getMarkCfgs(activityId)

	return cfgs and cfgs[markId]
end

function OriginalChemyMengMengConfig:getMasterCfg(creepsMasterId)
	return self._origin_alchemy_meng_meng_master[creepsMasterId]
end

function OriginalChemyMengMengConfig:getCreepsCfgs(creepsMasterId)
	return self._origin_alchemy_meng_meng_creeps[creepsMasterId]
end

function OriginalChemyMengMengConfig:getCreepsCfg(creepsMasterId, creepsId)
	local cfgs = self:getCreepsCfgs(creepsMasterId)

	return cfgs and cfgs[creepsId]
end

function OriginalChemyMengMengConfig:getCreepMasterId(activityId, stageId)
	local cfg = self:getStageCfg(activityId, stageId)

	return cfg and cfg.creepsMasterId
end

OriginalChemyMengMengConfig.instance = OriginalChemyMengMengConfig.New()

return OriginalChemyMengMengConfig
