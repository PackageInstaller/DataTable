-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/twindragonchallenge/config/IntegrationChallengeConfig.lua

module("logic.extensions.twindragonchallenge.config.IntegrationChallengeConfig", package.seeall)

local IntegrationChallengeConfig = class("IntegrationChallengeConfig", BaseConfig)

function IntegrationChallengeConfig:onInit()
	IntegrationChallengeConfig.super.onInit(self)
end

function IntegrationChallengeConfig:getNames()
	return {
		"integration_challenge",
		"integration_challenge_type",
		"integration_challenge_stage",
		"integration_challenge_creeps",
		"integration_challenge_pay",
		"integration_challenge_buff_define"
	}
end

function IntegrationChallengeConfig:handleConfig(name, content)
	if name == "integration_challenge" then
		self._challenge = content
	elseif name == "integration_challenge_type" then
		self._type = content
	elseif name == "integration_challenge_stage" then
		self._stage = content
	elseif name == "integration_challenge_creeps" then
		self._creeps = content
	elseif name == "integration_challenge_pay" then
		self._pay = content
	elseif name == "integration_challenge_buff_define" then
		self._buff = content
	end
end

function IntegrationChallengeConfig:getChallengeById(id)
	return self._challenge[id]
end

function IntegrationChallengeConfig:getType()
	return self._type
end

function IntegrationChallengeConfig:getStageByParam(planId, type, id)
	if self._stage[planId][type] then
		return self._stage[planId][type][id]
	end
end

function IntegrationChallengeConfig:getCreepsById(creepsMasterId)
	return self._creeps[creepsMasterId]
end

function IntegrationChallengeConfig:getPayById(planId)
	return self._pay[planId]
end

function IntegrationChallengeConfig:getBuffByPlan(planId)
	return self._buff[planId]
end

IntegrationChallengeConfig.instance = IntegrationChallengeConfig.New()

return IntegrationChallengeConfig
