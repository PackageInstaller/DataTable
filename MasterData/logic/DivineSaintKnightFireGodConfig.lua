-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/DivineSaintKnightFireGod/config/DivineSaintKnightFireGodConfig.lua

module("logic.extensions.divinesaintknightfiregod.config.DivineSaintKnightFireGodConfig", package.seeall)

local DivineSaintKnightFireGodConfig = class("DivineSaintKnightFireGodConfig", BaseConfig)

function DivineSaintKnightFireGodConfig:onInit()
	return
end

function DivineSaintKnightFireGodConfig:getNames()
	return {
		"divine_saint_knight_fire_god_activity",
		"divine_saint_knight_fire_god_buff",
		"divine_saint_knight_fire_god_creeps",
		"divine_saint_knight_fire_god_stage",
		"divine_saint_knight_fire_god_master"
	}
end

function DivineSaintKnightFireGodConfig:handleConfig(name, content)
	if name == "divine_saint_knight_fire_god_activity" then
		self._divine_saint_knight_fire_god_activity = content
	elseif name == "divine_saint_knight_fire_god_buff" then
		self._divine_saint_knight_fire_god_buff = content
	elseif name == "divine_saint_knight_fire_god_creeps" then
		self._divine_saint_knight_fire_god_creeps = content
	elseif name == "divine_saint_knight_fire_god_stage" then
		self._divine_saint_knight_fire_god_stage = content
	elseif name == "divine_saint_knight_fire_god_master" then
		self._divine_saint_knight_fire_god_master = content
	end
end

function DivineSaintKnightFireGodConfig:getActCfg(activityId)
	return self._divine_saint_knight_fire_god_activity[activityId]
end

function DivineSaintKnightFireGodConfig:getSkinId(activityId)
	return self._divine_saint_knight_fire_god_activity[activityId].skinId
end

function DivineSaintKnightFireGodConfig:getStageCfgs(activityId)
	return self._divine_saint_knight_fire_god_stage[activityId]
end

function DivineSaintKnightFireGodConfig:getStageCfg(activityId, stageId)
	return self._divine_saint_knight_fire_god_stage[activityId][stageId]
end

function DivineSaintKnightFireGodConfig:getMasterCfg(creepsMasterId)
	return self._divine_saint_knight_fire_god_master[creepsMasterId]
end

function DivineSaintKnightFireGodConfig:getCreepsCfgs(creepsMasterId)
	return self._divine_saint_knight_fire_god_creeps[creepsMasterId]
end

function DivineSaintKnightFireGodConfig:getBuffPlanCfgs(buffPlanId)
	return self._divine_saint_knight_fire_god_buff[buffPlanId]
end

function DivineSaintKnightFireGodConfig:getBuffCfgByTime(activityId, buffId, times)
	for i, v in ipairs(self._divine_saint_knight_fire_god_buff.dataList) do
		if v.activityId == activityId and v.level == times and v.buffId == buffId then
			return v
		end
	end
end

DivineSaintKnightFireGodConfig.instance = DivineSaintKnightFireGodConfig.New()

return DivineSaintKnightFireGodConfig
