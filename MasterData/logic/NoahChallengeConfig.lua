-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/noahchallenge/config/NoahChallengeConfig.lua

module("logic.extensions.noahchallenge.config.NoahChallengeConfig", package.seeall)

local NoahChallengeConfig = class("NoahChallengeConfig", BaseConfig)

function NoahChallengeConfig:onInit()
	NoahChallengeConfig.super.onInit(self)

	self.noah_challenge = nil
	self.noah_challenge_stage = nil
	self.noah_challenge_creeps = nil
	self.noah_challenge_params = nil
	self.noah_challenge_pay = nil
end

function NoahChallengeConfig:getNames()
	return {
		"noah_challenge",
		"noah_challenge_stage",
		"noah_challenge_creeps",
		"noah_challenge_params",
		"noah_challenge_pay"
	}
end

function NoahChallengeConfig:handleConfig(name, content)
	if name == "noah_challenge" then
		self.noah_challenge = content
	elseif name == "noah_challenge_stage" then
		self.noah_challenge_stage = content
	elseif name == "noah_challenge_creeps" then
		self.noah_challenge_creeps = content
	elseif name == "noah_challenge_params" then
		self.noah_challenge_params = content
	elseif name == "noah_challenge_pay" then
		self.noah_challenge_pay = content
	end
end

function NoahChallengeConfig:getChallengeCfg(challengeId)
	return self.noah_challenge[challengeId]
end

function NoahChallengeConfig:getChallengeStageList(challengePlanId)
	return self.noah_challenge_stage[challengePlanId] or {}
end

function NoahChallengeConfig:getChallengeStage(challengePlanId, stageId)
	if self.noah_challenge_stage[challengePlanId] then
		return self.noah_challenge_stage[challengePlanId][stageId]
	end
end

function NoahChallengeConfig:getChallengeCreeps(creepsMasterId)
	return self.noah_challenge_creeps[creepsMasterId]
end

function NoahChallengeConfig:getChallengeParamValue(key)
	if self.noah_challenge_params[key] then
		return self.noah_challenge_params[key].value
	end

	return nil
end

function NoahChallengeConfig:getChallengePay(payPlanId)
	return self.noah_challenge_pay[payPlanId]
end

NoahChallengeConfig.instance = NoahChallengeConfig.New()

return NoahChallengeConfig
