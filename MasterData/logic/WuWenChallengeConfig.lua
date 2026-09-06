-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wuwenchallenge/config/WuWenChallengeConfig.lua

module("logic.extensions.wuwenchallenge.config.WuWenChallengeConfig", package.seeall)

local WuWenChallengeConfig = class("WuWenChallengeConfig", BaseConfig)

function WuWenChallengeConfig:onInit()
	WuWenChallengeConfig.super.onInit(self)
end

function WuWenChallengeConfig:getNames()
	return {
		"wu_wen_clg",
		"wu_wen_clg_phase",
		"wu_wen_clg_stage",
		"wu_wen_clg_buff_plan",
		"wu_wen_clg_creeps_master",
		"wu_wen_clg_creeps"
	}
end

function WuWenChallengeConfig:handleConfig(name, content)
	if name == "wu_wen_clg" then
		self._wu_wen_clg = content
	elseif name == "wu_wen_clg_phase" then
		self._wu_wen_clg_phase = content
	elseif name == "wu_wen_clg_stage" then
		self._wu_wen_clg_stage = content
	elseif name == "wu_wen_clg_buff_plan" then
		self._wu_wen_clg_buff_plan = content
	elseif name == "wu_wen_clg_creeps_master" then
		self._wu_wen_clg_creeps_master = content
	elseif name == "wu_wen_clg_creeps" then
		self._wu_wen_clg_creeps = content
	end
end

function WuWenChallengeConfig:getActivityCfg(activityId)
	return self._wu_wen_clg[activityId]
end

function WuWenChallengeConfig:getPhaseCfgs(activityId)
	return self._wu_wen_clg_phase[activityId]
end

function WuWenChallengeConfig:getPhaseCfg(activityId, phaseId)
	if self._wu_wen_clg_phase[activityId] then
		return self._wu_wen_clg_phase[activityId][phaseId]
	end
end

function WuWenChallengeConfig:getStageCfgs(activityId, phaseId)
	if self._wu_wen_clg_stage[activityId] then
		return self._wu_wen_clg_stage[activityId][phaseId]
	end
end

function WuWenChallengeConfig:getStageCfg(activityId, phaseId, stageId)
	if self._wu_wen_clg_stage[activityId] and self._wu_wen_clg_stage[activityId][phaseId] then
		return self._wu_wen_clg_stage[activityId][phaseId][stageId]
	end
end

function WuWenChallengeConfig:getBuffCfgs(buffPlanId)
	return self._wu_wen_clg_buff_plan[buffPlanId]
end

function WuWenChallengeConfig:getBuffCfg(activityId, phaseId, buffId)
	local phaseCfg = self:getPhaseCfg(activityId, phaseId)

	return self._wu_wen_clg_buff_plan[phaseCfg.buffPlanId][buffId]
end

function WuWenChallengeConfig:getTeamCfg(creepsMasterId)
	return self._wu_wen_clg_creeps_master[creepsMasterId]
end

function WuWenChallengeConfig:getCreepsCfg(creepsMasterId)
	return self._wu_wen_clg_creeps[creepsMasterId]
end

WuWenChallengeConfig.instance = WuWenChallengeConfig.New()

return WuWenChallengeConfig
