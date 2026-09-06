-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiumumchallenge/config/XiuMumChallengeConfig.lua

module("logic.extensions.xiumumchallenge.config.XiuMumChallengeConfig", package.seeall)

local XiuMumChallengeConfig = class("XiuMumChallengeConfig", BaseConfig)

function XiuMumChallengeConfig:onInit()
	XiuMumChallengeConfig.super.onInit(self)
end

function XiuMumChallengeConfig:getNames()
	return {
		"xiumum_challenge",
		"xiumum_challenge_tier",
		"xiumum_challenge_stage",
		"xiumum_challenge_map",
		"xiumum_challenge_map_param",
		"xiumum_challenge_master",
		"xiumum_challenge_creeps"
	}
end

function XiuMumChallengeConfig:handleConfig(name, content)
	if name == "xiumum_challenge" then
		self._actCfg = content
	elseif name == "xiumum_challenge_tier" then
		self._tierCfgs = content
	elseif name == "xiumum_challenge_stage" then
		self._stageCfgs = content
	elseif name == "xiumum_challenge_map" then
		self._mapCfgs = content
	elseif name == "xiumum_challenge_map_param" then
		self._mapParamCfgs = content
	elseif name == "xiumum_challenge_master" then
		self._formationCfg = content
	elseif name == "xiumum_challenge_creeps" then
		self._mosterCfg = content
	end
end

function XiuMumChallengeConfig:getActCfgByActId(actId)
	return self._actCfg[actId]
end

function XiuMumChallengeConfig:getTierCfg(actId, tier)
	local acgCfg = self._actCfg[actId]

	if acgCfg then
		if not acgCfg.tierPlanId then
			local planId = 0

			if not self._tierCfgs[planId] then
				local tiercfgs = {}

				return tiercfgs[tier]
			end
		end
	end
end

function XiuMumChallengeConfig:getStageCfgs(planId)
	return self._stageCfgs[planId]
end

function XiuMumChallengeConfig:getMapCfg(mapId)
	return self._mapCfgs[mapId]
end

function XiuMumChallengeConfig:getMapParamCfg(id)
	return self._mapParamCfgs[id]
end

function XiuMumChallengeConfig:getFormationCfgById(id)
	return self._formationCfg[id]
end

function XiuMumChallengeConfig:getMostersCfgById(id)
	return self._mosterCfg[id]
end

XiuMumChallengeConfig.instance = XiuMumChallengeConfig.New()

return XiuMumChallengeConfig
