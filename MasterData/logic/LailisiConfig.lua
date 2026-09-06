-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/config/LailisiConfig.lua

module("logic.extensions.lailisi.config.LailisiConfig", package.seeall)

local LailisiConfig = class("LailisiConfig", BaseConfig)

function LailisiConfig:onInit()
	LailisiConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function LailisiConfig:getNames()
	return {
		"actor_gain_activity",
		"actor_gain_team",
		"actor_gain_creeps",
		"actor_gain_helper_pet",
		"actor_gain_buff",
		"actor_gain_prize",
		"actor_gain_refresh",
		"actor_gain_task_daily",
		"actor_future_currency",
		"actor_gain_challenge"
	}
end

function LailisiConfig:handleConfig(name, content)
	if name == "actor_gain_activity" then
		self._actor_gain_activity = content
	elseif name == "actor_gain_team" then
		self._actor_gain_team = content
	elseif name == "actor_gain_creeps" then
		self._actor_gain_creeps = content
	elseif name == "actor_gain_helper_pet" then
		self._actor_gain_helper_pet = content
	elseif name == "actor_gain_buff" then
		self._actor_gain_buff = content
	elseif name == "actor_gain_prize" then
		self._actor_gain_prize = content
	elseif name == "actor_gain_refresh" then
		self._actor_gain_refresh = content
	elseif name == "actor_gain_task_daily" then
		self._actor_gain_task_daily = content
	elseif name == "actor_future_currency" then
		self._actor_future_currency = content
	elseif name == "actor_gain_challenge" then
		self._actor_gain_challenge = content
	end
end

function LailisiConfig:getActivityCfg()
	return self._actor_gain_activity.dataList
end

function LailisiConfig:getActivityCfgById(id)
	return self._actor_gain_activity[id]
end

function LailisiConfig:isHavePublicAttr(id)
	local cfg = self._actor_gain_activity[id]

	if cfg then
		return cfg.excludePublicStrengthens
	end

	return false
end

function LailisiConfig:isExtremeMode(id)
	local cfg = self._actor_gain_activity[id]

	if cfg then
		return cfg.extremeMode
	end

	return false
end

function LailisiConfig:getChallengePlanId(actId)
	local cfg = self:getActivityCfgById(actId)

	return cfg.challengePlanId
end

function LailisiConfig:getTeamInfo(actId, stageId)
	local planId = self:getChallengePlanId(actId)
	local cfg = self._actor_gain_team[planId]

	return cfg[stageId]
end

function LailisiConfig:getRewardPrize(activityId)
	return self._actor_gain_prize[activityId]
end

function LailisiConfig:getBuffCfg(activityId, buffId)
	if self._actor_gain_buff[activityId] then
		return self._actor_gain_buff[activityId][buffId]
	end

	printError(">>>>>>>>>>>>>>>>LailisiConfig>>>>>>>", activityId, buffId)
end

function LailisiConfig:getTaskInfo(taskId)
	return self._actor_gain_task_daily[taskId]
end

function LailisiConfig:getPetCreeps(creepsMasterId)
	return self._actor_gain_creeps[creepsMasterId]
end

function LailisiConfig:getHelperPetCfg(actiId)
	return self._actor_gain_helper_pet[actiId]
end

function LailisiConfig:getPrizeMaxScore(actId)
	local cfg = self._actor_gain_buff[actId]
	local count = #cfg

	return self._actor_gain_buff[actId][count].survival
end

function LailisiConfig:getProgressCfgById(actId)
	return self._actor_gain_buff[actId]
end

function LailisiConfig:getCommonCfg(id)
	if self._actor_future_currency[id] then
		return self._actor_future_currency[id].value
	end

	return 0
end

function LailisiConfig:getChallengeCfg(actId)
	return self._actor_gain_challenge[actId]
end

LailisiConfig.instance = LailisiConfig.New()

return LailisiConfig
