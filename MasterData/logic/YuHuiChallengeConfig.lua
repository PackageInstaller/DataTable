-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yuhuichallenge/config/YuHuiChallengeConfig.lua

module("logic.extensions.yuhuichallenge.config.YuHuiChallengeConfig", package.seeall)

local YuHuiChallengeConfig = class("YuHuiChallengeConfig", BaseConfig)

function YuHuiChallengeConfig:onInit()
	YuHuiChallengeConfig.super.onInit(self)
end

function YuHuiChallengeConfig:getNames()
	return {
		"yu_hui_challenge",
		"yu_hui_challenge_stage",
		"yu_hui_challenge_stage_mode",
		"yu_hui_challenge_creeps",
		"yu_hui_challenge_buff",
		"yu_hui_challenge_sign_in_buff"
	}
end

function YuHuiChallengeConfig:handleConfig(name, content)
	if name == "yu_hui_challenge" then
		self._challengeCfg = content
	elseif name == "yu_hui_challenge_stage" then
		self._stageCfgs = content
	elseif name == "yu_hui_challenge_stage_mode" then
		self._stageModeCfgs = content
	elseif name == "yu_hui_challenge_creeps" then
		self._creepsMasterCfgs = content
	elseif name == "yu_hui_challenge_buff" then
		self._buffCfgs = content
	elseif name == "yu_hui_challenge_sign_in_buff" then
		self._yu_hui_challenge_sign_in_buff = content
	end
end

function YuHuiChallengeConfig:getChallengeCfgById(id)
	return self._challengeCfg[id]
end

function YuHuiChallengeConfig:getStageCfgs(planId)
	return self._stageCfgs[planId]
end

function YuHuiChallengeConfig:getStageModeCfgs(stageModePlanId)
	return self._stageModeCfgs[stageModePlanId]
end

function YuHuiChallengeConfig:getCreepsMasterCfgs(creepId)
	return self._creepsMasterCfgs[creepId]
end

function YuHuiChallengeConfig:getBuffCfgs(planId)
	return self._buffCfgs[planId]
end

function YuHuiChallengeConfig:getSingBuffCfgs(planId, lvl)
	if self._yu_hui_challenge_sign_in_buff[planId] then
		return self._yu_hui_challenge_sign_in_buff[planId][lvl]
	end
end

YuHuiChallengeConfig.instance = YuHuiChallengeConfig.New()

return YuHuiChallengeConfig
